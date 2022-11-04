//
//  MacrosImagProcessor.swift
//  MacrosCreatorApp
//
//  Created by Abhishek Kashyap on 04/11/22.
//

import Foundation
import UIKit


class MacrosImageProcessor:ImageProcessor{
  var context = CIContext(options: nil)
  var originalImage:UIImage!
  
  func setOriginalImage(originalImage:UIImage){
    self.originalImage = originalImage
  }
  
  func getOriginalImage() -> UIImage?{
    return self.originalImage
  }
  
  func getGrayScaledImage() -> UIImage?{
    return grayscale()
  }
  
  private func grayscale() -> UIImage?{
    guard let currentCGImage = originalImage.cgImage else { return nil }
    let currentCIImage = CIImage(cgImage: currentCGImage)

    let filter = CIFilter(name: "CIColorMonochrome")
    filter?.setValue(currentCIImage, forKey: "inputImage")

    // set a gray value for the tint color
    filter?.setValue(CIColor(red: 0.7, green: 0.7, blue: 0.7), forKey: "inputColor")

    filter?.setValue(1.0, forKey: "inputIntensity")
    guard let outputImage = filter?.outputImage else { return nil }

    let context = CIContext()

    if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
        let processedImage = UIImage(cgImage: cgimg)
        return processedImage
    }
    return nil
  }
}


protocol ImageProcessor{
  func setOriginalImage(originalImage:UIImage)
  func getOriginalImage() -> UIImage?
  func getGrayScaledImage() -> UIImage?
}
