//
//  HeaderCollectionViewCell.swift
//  HouseRentingApp
//
//  Created by AcePlus Admin on 9/11/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import UIKit

class FoodTypeCollectionViewCell: UICollectionViewCell {
	static let identifier = "FoodTypeCollectionViewCell"
	@IBOutlet weak var lblText : UILabel!
	
	@IBOutlet weak var pointerView: UIView!
	override func awakeFromNib() {
        super.awakeFromNib()
		pointerView.layer.cornerRadius = 24

    }
	
	override var isSelected: Bool{
		didSet{
			if self.isSelected {
				pointerView.backgroundColor = UIColor.black
				lblText.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
			}else{
				pointerView.backgroundColor	= UIColor.white
				lblText.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
			}
		}
	}

}
