//
//  FoodVO.swift
//  FirestoreAssignment
//
//  Created by AcePlus Admin on 10/26/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import Foundation
struct FoodVO {
	var name : String
	var amount : Double
	var imageUrl : String
	var rating : Int
	var waitingTime : String
	var id : String
	var dictionary : [String:Any] {
		return
			[
				"name":name,
				"amount" : amount,
				"imageUrl":imageUrl,
				"rating":rating,
				"waitingTime":waitingTime
	
		]
	}
}

extension FoodVO {
	init?(dictionary:[String:Any],id:String){
		guard let name = dictionary["name"] as? String ,
			let amount = dictionary["amount"] as? Double ,
			let rating = dictionary["rating"] as? Int ,
			let imgUrl = dictionary["imageUrl"] as? String ,
			let waitingTime = dictionary["waitingTime"] as? String
		else {
			return nil
		}
		self.init(name:name,amount:amount,imageUrl:imgUrl,rating:rating,waitingTime:waitingTime,id:id)
	}
}


