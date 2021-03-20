//
//  LangArray.swift
//  TextGoogler
//
//  Created by Nacho Ampuero on 08.06.20.
//  Copyright © 2020 Nacho Ampuero. All rights reserved.
//

import Foundation

struct K {
    static let langArray = [
//        safeLang,
        "en",
//        "zh",
//        "jp",
//        "ko",
//        "ru",
        "de",
        "fr",
        "it",
        "es",
        "pt"
    ]
    
    static let unsupportedLangAlert = "Sorry, your iPhone langugage (\(safeLang.uppercased())) is currently not supported. You can still search texts in English."
    static let ok = "OK"
    static let empty = ""
    static let goToBrowser = "goToBrowser"
    
}

let preferredLang = Locale.preferredLanguages.first?.dropLast(3)   // If the lang = nil, .dropLast() will have no effect and nil will be caught in the next line.
let preferredLangIso2Characters = preferredLang ?? "No language found"
let safeLang = String(preferredLangIso2Characters)

// Lang support left for further steps.







//        // Check if the phone language is supported
       //        if !K.langArray.contains(safeLang) {
       //            let alert = UIAlertController(title: nil, message: K.unsupportedLangAlert, preferredStyle: .alert)
       //            alert.addAction(UIAlertAction(title: K.ok, style: .default, handler: nil))
       //            self.present(alert, animated: true)
       //        }
