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

// MARK: - Cammera Methods

class CameraViewController: UIViewController {
    
    let supportedLanguages = ["en", "de", "fr", "it", "es", "pt"]
    var request = [VNRequest]()
    let imagePicker = UIImagePickerController()
    var resultingText = String()

    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerController.CameraDevice.rear) {
            DispatchQueue.main.async{
                self.present(self.imagePicker, animated: false, completion: nil)
            }}
        
        resultingText = String()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVision()
        checkSupportedLang()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        
        navigationItem.backBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: nil, action: nil)
    }
    
    func checkSupportedLang() {
        
        // `supportedLanguages` Languages supported by Vision, if iPhone in e.g: Croatian, it defaults to English
        if let preferredLang = Locale.preferredLanguages.first {
            let preferredLangIso2Characters = preferredLang.dropLast(3)
            let safeLang = String(preferredLangIso2Characters)
    
        if !supportedLanguages.contains(safeLang) {
            alertController(alertTitle: "🧐",
                            message: "Sorry, your iPhone language (\(safeLang.uppercased())) is currently not available. You can still search for texts in English.",
                            actionTitle: "OK")
        }}
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
                // Build a BOUNDINGBOX somewhere around here... Somewhat later.
                self.resultingText += candidate.string
            }
            
            self.googleFoundText()
        }
        
        // Specify the recognition level
        textRecognitionRequest.recognitionLevel = .accurate
        textRecognitionRequest.minimumTextHeight = 0.05
        textRecognitionRequest.recognitionLanguages = supportedLanguages
        self.request = [textRecognitionRequest]
    }
    
    func googleFoundText() {
        
        if resultingText == "" {
            
            DispatchQueue.main.async {
                self.alertController(alertTitle: "😅",
                                message: "Sorry, apparently we found no text in the pictrue, please try again!",
                                actionTitle: "Sure")
            }
            
        } else {
            let urlForSearch = "https://www.google.com/search?q=\(resultingText)"
            if let urlString = urlForSearch.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let vc = self.storyboard?.instantiateViewController(identifier: "WebView") as? WebViewController {
                vc.urlFromPicture = URL(string: urlString)
                self.navigationController?.pushViewController(vc, animated: true)
            }}}
    }
    
    func alertController(alertTitle: String, message: String, actionTitle: String) {
        
        let ac = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let submitAction = (UIAlertAction(title: actionTitle, style: .default, handler: { [weak self] _ in
            self?.navigationController?.loadView()
        }))
        
        ac.addAction(submitAction)
        self.present(ac, animated: true)
    }
}


//MARK: - ImagePicker Methods

extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let takenPicture = info[.editedImage] as? UIImage {
            if let cgImage = takenPicture.cgImage {
                let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
                do {
                    try requestHandler.perform(self.request)
                } catch {
                    print (error)
                } } }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
}


/*
 POSSIBLE IMPROVEMENTS:
 - Buid a custom wrapper over the UIImagePickerController
    - And get rid of the cancel button
 - Clean up `resultingText` beffore triggering the search
 */
