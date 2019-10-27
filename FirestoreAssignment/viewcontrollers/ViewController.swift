//
//  ViewController.swift
//  FirestoreAssignment
//
//  Created by AcePlus Admin on 10/25/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {

	@IBOutlet weak var collectionViewFoodType: UICollectionView!
	@IBOutlet weak var tableViewFoodList: UITableView!
	
	@IBOutlet weak var createFoodView: CardView!
	
	var FoodTypes : [String] = ["Entrees","Mains","Drinks","Desserts"]
	var foods : [FoodVO] = []
	var listener : ListenerRegistration!
	static var DB_COLLECTION_PATH = "Entrees"

	func baseQuery() -> Query {
		return Firestore.firestore().collection(ViewController.DB_COLLECTION_PATH)
	}
	var query : Query? {
		didSet {
			if let listener = listener {
				listener.remove()
			}
		}
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		tableViewFoodList.register(UINib(nibName: FoodItemTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: FoodItemTableViewCell.identifier)
		tableViewFoodList.delegate = self
		tableViewFoodList.dataSource = self
		collectionViewFoodType.register(UINib(nibName: FoodTypeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: FoodTypeCollectionViewCell.identifier)
		collectionViewFoodType.delegate = self
		collectionViewFoodType.dataSource = self
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapCreateFoodView))
		createFoodView.addGestureRecognizer(tapGesture)
		collectionViewFoodType.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
		self.query = baseQuery()

	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		queryFoodList()
	}
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		self.listener.remove()
	}
	
	func queryFoodList(){
		self.listener = query?.addSnapshotListener({ (querySnapshot, err) in
			if let err = err {
				print(err.localizedDescription)
			}
			let results = querySnapshot?.documents.map({ (document) -> FoodVO in
				print("document \(document.data())")
				if let food = FoodVO(dictionary: document.data(), id: document.documentID) {
					return food
				}else {
					print("No Food Data ")
					fatalError()
				}
			})
			self.foods = results ?? []
			self.tableViewFoodList.reloadData()
		})
	}
	@objc func handleTapCreateFoodView(){
//		let sb = UIStoryboard(name: "Main", bundle: nil)
//		guard let vc = sb.instantiateViewController(identifier: CreateFoodItemViewController.identifier) as? CreateFoodItemViewController else {return}
//		vc.modalPresentationStyle = .fullScreen
//		vc.DB_COLLECTION_PATH = ViewController.DB_COLLECTION_PATH
//		self.present(vc, animated: true, completion: nil)
		self.performSegue(withIdentifier: "createFoodItem", sender: self)
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let destVC = segue.destination as? CreateFoodItemViewController {
			destVC.DB_COLLECTION_PATH = ViewController.DB_COLLECTION_PATH
		}
	}

}

extension ViewController : UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return foods.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodItemTableViewCell.identifier, for: indexPath) as? FoodItemTableViewCell else {
			return UITableViewCell()
		}
		cell.mData = foods[indexPath.row]
		return cell
	}
	
}
extension ViewController : UITableViewDelegate {
	
}
extension ViewController : UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		ViewController.DB_COLLECTION_PATH = FoodTypes[indexPath.row]
		query = baseQuery()
		queryFoodList()
	}
	
	
}
extension ViewController : UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return FoodTypes.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodTypeCollectionViewCell.identifier, for: indexPath) as? FoodTypeCollectionViewCell else {
			return UICollectionViewCell()
		}
		cell.lblText.text = FoodTypes[indexPath.row]
		return cell
	}
	
	
}
