//
//  CreateFoodItemViewController.swift
//  FirestoreAssignment
//
//  Created by AcePlus Admin on 10/25/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

class CreateFoodItemViewController: UIViewController {
	
	
	@IBOutlet weak var ivFoodImage: UIImageView!
	
	@IBOutlet weak var tfAmount: UITextField!
	
	@IBOutlet weak var tfWaitingTime: UITextField!
	@IBOutlet weak var tfRating: UITextField!
	@IBOutlet weak var tfFoodName: UITextField!
	
	var DB_COLLECTION_PATH : String = ""
	var imageReference : StorageReference!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print("FoodType = \(DB_COLLECTION_PATH)")
		let imageName = UUID().uuidString
		imageReference = Storage.storage().reference().child("images").child(imageName)
	}
	
	
	@IBAction func btnChooseFoodImage(_ sender: Any) {
		ImagePickerManager().pickImage(self) { (image) in
			self.ivFoodImage.image = image
			guard let image = self.ivFoodImage.image, let data = image.jpegData(compressionQuality: 0.8) else {
				return
			}
			self.imageReference.putData(data, metadata: nil) { (metadata, err) in
				if let err = err {
					print(err.localizedDescription)
					return
				}
				self.showAlertDialog(title: "Success", msg: "Your image is successfully upload to cloud storage")

			}
		}
		
	}
	
	func downloadImageURL(Completion : @escaping(String)->Void){
		var urlString = ""
		imageReference.downloadURL { (url, err) in
			if let err = err {
				print(err.localizedDescription)
				return
			}
			print("URL = \(url)")
			urlString = url?.absoluteString ?? ""
			print(urlString)
			Completion(urlString)

		}
	}
	@IBAction func btnCreateFoodItem(_ sender: Any) {
		
		
		let name = tfFoodName.text ?? ""
		let amount = Double(tfAmount.text ?? "0.0") ?? 0.0
		let rating = Double(tfRating.text ?? "0") ?? 0
		let waitingTime = tfWaitingTime.text ?? ""
		let db = Firestore.firestore()
		downloadImageURL { (url) in
			print("download URL = \(url)")

			db.collection(self.DB_COLLECTION_PATH).addDocument(data: ["name":name,"amount":amount,"imageUrl":url,"rating":rating,"waitingTime":waitingTime])
			self.dismiss(animated: true, completion: nil)
		}

		

		
	}
	
}
