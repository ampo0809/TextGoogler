//
//  ViewController.swift
//  TextGoogler
//
//  Created by Nacho Ampuero on 05.06.20.
//  Copyright © 2020 Nacho Ampuero. All rights reserved.
//

import UIKit
import Vision
import VisionKit

//extension ViewController: VNDocumentCameraViewControllerDelegate {
//
//    func loadDocumentCameraViewController() {
//        // Find later how to lauch the camera when the app opens
//        let documentCameraViewController = VNDocumentCameraViewController()
//        documentCameraViewController.delegate = self
//        present(documentCameraViewController, animated: true)
//    }
//
//    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
//
//        controller.dismiss(animated: true, completion: nil)
//
//        let image = scan.imageOfPage(at: 0)
//        if let cgImage = image.cgImage {
//            let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
//            do {
//                try requestHandler.perform(self.request)
//            } catch {
//                print (error)
//            }
//
//        }
//    }
//}

//extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        
//        if let takenPicture = info[.editedImage] as? UIImage {
//            if let cgImage = takenPicture.cgImage {
//                let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
//                do {
//                    try requestHandler.perform(self.request)
//                } catch {
//                    print (error)
//                }
//            }
//        }
//        imagePicker.dismiss(animated: true, completion: nil)
//    }
//}




/* FUTURE IMPLEMENTATIONS RESOURCES:
 
 guard let url = URL(string: "googlechrome://\(urlString!)") else { return }
 print(url)
 UIApplication.shared.open(url)
 
 https://developer.chrome.com/multidevice/ios/links
 */
