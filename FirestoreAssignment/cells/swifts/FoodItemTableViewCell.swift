//
//  FoodItemTableViewCell.swift
//  FirestoreAssignment
//
//  Created by AcePlus Admin on 10/25/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import UIKit
import SDWebImage

class FoodItemTableViewCell: UITableViewCell {

   static let identifier = "FoodItemTableViewCell"
	@IBOutlet weak var ivFoodItem: UIImageView!
	
	@IBOutlet weak var lblName: UILabel!
	
	@IBOutlet weak var lblAmount: UILabel!
	
	@IBOutlet weak var lblWaitingTime: UILabel!
	
	@IBOutlet weak var ratingStackView: UIStackView!
	var mData : FoodVO? {
		didSet{
			
			ivFoodItem.sd_setImage(with: URL(string: mData?.imageUrl ?? ""),placeholderImage: UIImage(named: "cheeseburger"),completed: nil)
			lblName.text = mData?.name
			lblAmount.text = "$\(mData?.amount ?? 0.0)"
			lblWaitingTime.text = "Prep in \(mData?.waitingTime)"
			setRating(mData?.rating ?? 0)
		}
	}
	
	func setRating(_ count : Int){
		for view in ratingStackView.arrangedSubviews {
			if let ivRating = view as? UIImageView {
				if view.tag < count {
				ivRating.image = UIImage(systemName: "star.fill")
				}
				
			}
		}
	}
	override func awakeFromNib() {
		   super.awakeFromNib()
		   // Initialization code
	   }
	
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
