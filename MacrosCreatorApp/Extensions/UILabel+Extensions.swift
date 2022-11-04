//
//  UILabel+Extensions.swift
//  MacrosCreatorApp
//
//  Created by Abhishek Kashyap on 04/11/22.
//

import Foundation
import UIKit

extension UILabel{
  
  fileprivate func getAttributes() -> [NSAttributedString.Key:Any]{
    let defaultAttrubutes:[NSAttributedString.Key:Any] = [
      NSAttributedString.Key.strokeColor : UIColor.black,
      NSAttributedString.Key.foregroundColor : UIColor.white,
      NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
      NSAttributedString.Key.strokeWidth : -4.0
    ]
    return defaultAttrubutes
  }
  func addShadowLabel(color:CGColor,
                      shadowRadius:Double,
                      shadowOpacity:Float,
                      offSetWidth:CGFloat,
                      offSetHeight:CGFloat,
                      maskToBound:Bool){
    self.layer.shadowColor = color
    self.layer.shadowRadius = shadowRadius
    self.layer.shadowOpacity = shadowOpacity
    self.layer.shadowOffset = CGSize(width: offSetWidth, height: offSetHeight)
    self.layer.masksToBounds = maskToBound
    
  }
  
  func setAttributedText(text:String){
    self.attributedText = NSAttributedString(string: text, attributes: getAttributes())
  }
  
  
}
