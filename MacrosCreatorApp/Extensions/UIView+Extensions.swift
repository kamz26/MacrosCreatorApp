//
//  UIView+Extensions.swift
//  MacrosCreatorApp
//
//  Created by Abhishek Kashyap on 04/11/22.
//

import Foundation
import UIKit

extension UIView{
  func takeScreeShot() -> UIImage{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
    self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    if image != nil {
        return image!
    }
    return UIImage()
  }
}
