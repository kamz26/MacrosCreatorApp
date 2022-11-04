//
//  MacrosCreatorViewController.swift
//  MacrosCreatorApp
//
//  Created by Abhishek Kashyap on 04/11/22.
//

import UIKit

class MacrosCreatorViewController: UIViewController {
  
  //MARK: - IBOutlets
  @IBOutlet weak var cameraBtn: UIButton!
  @IBOutlet weak var galaryBtn: UIButton!
  @IBOutlet weak var topTextField: UITextField!
  @IBOutlet weak var bottomTextField: UITextField!
  @IBOutlet weak var imageContainerView: UIView!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var topLabel: UILabel!
  @IBOutlet weak var bottomLabel: UILabel!
  @IBOutlet weak var grayModeSwitch: UISwitch!
  
  //MARK: - Properties
  var imagePicker:ImageSetProtocol!
  var imageProcessor:ImageProcessor!
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  //MARK: - Setup
  private func setup(){
    macrosImagePickerSetup()
    macrosImageProcesstorSetup()
    
    //Textfield setup
    topTextField.delegate = self
    bottomTextField.delegate = self
    
    
  }
  
  private func macrosImagePickerSetup(){
    imagePicker = MacrosImagePickerController(delegate: self)
  }
  
  private func macrosImageProcesstorSetup(){
    self.imageProcessor = MacrosImageProcessor()
  }
  
  private func backgroundColorSelector(){
    let picker = UIColorPickerViewController()
    picker.delegate = self
    present(picker, animated: true, completion: nil)
  }
  
  
  //MARK: - Action
  @IBAction func cameraAction(_ sender: Any) {
    imagePicker.setImageFromCamera()
  }
  
  @IBAction func galaryAction(_ sender: Any) {
    imagePicker.setImageFromGalary()
  }
  @IBAction func shareImageAction(_ sender: Any) {
    //Take screenshot
    let image = imageContainerView.takeScreeShot()
    let imageToShare = [image]
    self.presentActivityIndicator(with: imageToShare)
  }
  @IBAction func grayModeAction(_ sender: UISwitch) {
    self.imageView.image = sender.isOn ? imageProcessor.getGrayScaledImage() : imageProcessor.getOriginalImage()
  }
  
  @IBAction func backgroundColorSelector(_ sender: UIButton) {
    backgroundColorSelector()
  }
  
  private func presentActivityIndicator(with images:[UIImage]){
    let activityViewController = UIActivityViewController(activityItems: images, applicationActivities: nil)
    activityViewController.popoverPresentationController?.sourceView = self.view
    
    activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
        if !completed {
            print("Cancelled!")
            return
        }
        print("Success!")
    }
    
    self.present(activityViewController, animated: true, completion: nil)
  }
  
  //MARK: - Touch Delegate
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    topLabel.setAttributedText(text: topTextField.text?.uppercased() ?? "")
    bottomLabel.setAttributedText(text: bottomTextField.text?.uppercased() ?? "")
    view.endEditing(true)
  }
  
}

extension MacrosCreatorViewController:UITextFieldDelegate{
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    topLabel.setAttributedText(text: topTextField.text?.uppercased() ?? "")
    bottomLabel.setAttributedText(text: bottomTextField.text?.uppercased() ?? "")
    textField.resignFirstResponder()
    return true
  }
}

//MARK: - MacrosImagePickerControllerDelegate
extension MacrosCreatorViewController:MacrosImagePickerControllerDelegate{
  func didSelected(image: UIImage) {
    self.imageProcessor.setOriginalImage(originalImage: image)
    self.imageView.image = grayModeSwitch.isOn ? self.imageProcessor.getGrayScaledImage() : self.imageProcessor.getOriginalImage()
  }
  
  func didGetErrorwhileSelection(error: Error) {
    print(error.localizedDescription)
  }
}

//MARK: - UIColorPickerViewControllerDelegate
extension MacrosCreatorViewController:UIColorPickerViewControllerDelegate{
  func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
    dismiss(animated: true, completion: nil)
  }
  func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
    let color = viewController.selectedColor
    
    DispatchQueue.main.async {
      self.imageContainerView.backgroundColor = color
    }
  }
}
