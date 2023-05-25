//
//  ViewModel.swift
//  Nano2
//
//  Created by Elvis Susanto on 25/05/23.
//

import Foundation
import UIKit

class ViewModel: ObservableObject {
    
    
    
}

func selectImageFromGallery() {
    let imagePicker = UIImagePickerController()
    imagePicker.sourceType = .photoLibrary
    imagePicker.delegate = self
    present(imagePicker, animated: true, completion: nil)
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                // Use the 'imageData' here as the binary data for the selected image
                // You can save it to a variable or perform further operations
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
