//
//  CameraViewController.swift
//  TextGoogler
//
//  Created by Nacho Ampuero on 05.06.20.
//  Copyright © 2020 Nacho Ampuero. All rights reserved.
//

import UIKit
import Vision
import VisionKit


class CameraViewController: UIViewController {
    
    var request = [VNRequest]()
    var resultingText = K.empty
    let imagePicker = UIImagePickerController()
    private var url: URL?
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerController.CameraDevice.rear) {
            DispatchQueue.main.async{
                self.present(self.imagePicker, animated: false, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVision()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
    }
    
    private func setupVision() {
        let textRecognitionRequest = VNRecognizeTextRequest { (request, error) in
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                print("The observations are of an unexpected type.")
                return
            }
            // Concatenate the recognised text from all the observations.
            let maximumCandidates = 1
            for observation in observations {
                
                guard let candidate = observation.topCandidates(maximumCandidates).first else { continue }
                //                Build a BOUNDINGBOX somewhere around here... Somewhat later.
                self.resultingText += candidate.string
            }
            self.googleFoundText()
        }
        // specify the recognition level
        textRecognitionRequest.recognitionLevel = .accurate
        textRecognitionRequest.minimumTextHeight = 0.05
        textRecognitionRequest.recognitionLanguages = K.langArray
        self.request = [textRecognitionRequest]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SFSafariViewController
        destinationVC.destinationUrl = url
    }
    
    func googleFoundText() {
        let urlToGoogle = "https://www.google.com/search?q=\(resultingText)"
        let urlString = urlToGoogle.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        url = URL(string: urlString!)
        DispatchQueue.main.async{
            self.performSegue(withIdentifier: K.goToBrowser, sender: nil)
        }
    }
}


//MARK: - ImagePickerController

extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let takenPicture = info[.editedImage] as? UIImage {
            if let cgImage = takenPicture.cgImage {
                let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
                do {
                    try requestHandler.perform(self.request)
                } catch {
                    print (error)
                }
            }
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Temporal IBActions
    
//    @IBAction func cameraViewButtonPressed(_ sender: UIButton) {   // TEMP
//        present(imagePicker, animated: false, completion: nil)
//    }
//    
//    @IBAction func webViewButtonPressed(_ sender: UIButton) {   // TEMP
//        performSegue(withIdentifier: K.goToBrowser, sender: self)
//    }
}


