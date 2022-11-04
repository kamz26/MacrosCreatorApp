//
//  UIViewController+Extensions.swift
//  MacrosCreatorApp
//
//  Created by Abhishek Kashyap on 04/11/22.
//

import Foundation
import UIKit


extension UIViewController{
  
  static func initFromNib() -> Self{
    func instanceFromNib<T: UIViewController>() -> T {
        
        //This assumes we are passing viewcontroller name as the nibname
        return T(nibName: String(describing: self), bundle: nil)
    }
    
    return instanceFromNib()
  }
}
