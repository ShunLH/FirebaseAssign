//
//  Extensions.swift
//  FirestoreAssignment
//
//  Created by AcePlus Admin on 10/26/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
	func showAlertDialog(title:String,msg:String) {
		let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
		let action = UIAlertAction(title: "OK", style: .default, handler: nil)
		alert.addAction(action)
		present(alert,animated: true)
	}
}

