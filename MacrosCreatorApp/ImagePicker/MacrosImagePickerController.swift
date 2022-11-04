//
//  MacrosImagePickerController.swift
//  MacrosCreatorApp
//
//  Created by Abhishek Kashyap on 04/11/22.
//

import Foundation
import UIKit

final class MacrosImagePickerController:NSObject,ImageSetProtocol, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  
  //MARK: - Properties
  private var pickerController:UIImagePickerController!
  weak var imagePickerDelegate:MacrosImagePickerControllerDelegate!
  
  init(delegate:MacrosImagePickerControllerDelegate){
    super.init()
    self.imagePickerDelegate = delegate
    self.pickerController = UIImagePickerController()
    self.pickerController.delegate = self
  }
  
  private func pickImageFromSource(source:UIImagePickerController.SourceType){
    self.pickerController.sourceType = source
    imagePickerDelegate?.present(pickerController, animated: true, completion: nil)
  }
  
  func setImageFromCamera(){
    pickImageFromSource(source: .camera)
  }
  
  func setImageFromGalary(){
    pickImageFromSource(source: .photoLibrary)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image  = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage{
      imagePickerDelegate?.didSelected(image: image)
      imagePickerDelegate?.dismiss(animated: true, completion: nil)
    }
    
  }
  
}



protocol ImageSetProtocol:AnyObject{
  func setImageFromCamera()
  func setImageFromGalary()
}
protocol MacrosImagePickerControllerDelegate where Self:UIViewController{
  func didSelected(image:UIImage)
  func didGetErrorwhileSelection(error:Error)
}
