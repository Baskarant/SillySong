//
//  ViewController.swift
//  Silly Song
//
//  Created by Baskaran T on 09/12/16.
//  Copyright © 2016 Baskaran T. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // search box text field and Lyrics View declaration
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    // Lyrics Template
    var lTemplate = ["<FULL_NAME>,<FULL_NAME> MO M<SHORT_NAME>","SA RE GA MA S<SHORT_NAME>","MA GA SA R<SHORT_NAME>","<FULL_NAME>"].joined(separator: "\n")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameField.delegate = self
        nameField.text?.removeAll()
        lyricsView.text.removeAll()
    }
    
    // remove text in search box
    @IBAction func reset(_ sender: UITextField) {
        nameField.text?.removeAll()
        lyricsView.text.removeAll()
    }

    // display result (lyrics)
    @IBAction func displayLyrics(_ sender: UITextField) {
        guard let name = nameField.text, !name.isEmpty else {
            lyricsView.text = "Enter Your name"
            return
        }
        lyricsView.text = lyricsForName(lTemplate, fullName: name)
    }
    
    
    func shortFromName(_ name:String) -> String {
        let lowercaseName = name.lowercased()
        let vowelSet = CharacterSet(charactersIn: "aeiou")
        if let firstVowelRange = lowercaseName.folding(options: .diacriticInsensitive, locale: nil).rangeOfCharacter(from: vowelSet, options: .caseInsensitive)
        {
            return lowercaseName.substring(from: firstVowelRange.lowerBound)
        }
        else {
            return lowercaseName
        }
    }
    
    func lyricsForName (_ lyricsTemplate: String, fullName: String) -> String{
      
        let shortName = shortFromName(fullName)
        
        let lyrics = lyricsTemplate
                        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
                        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
        return lyrics
    }
}

// MARK: - UITEXTFIELD DELAGATE 

extension  ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

