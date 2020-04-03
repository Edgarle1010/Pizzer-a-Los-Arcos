//
//  TermsAndConditionsViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 30/03/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit

class TermsAndConditionsViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var termsAndConditionsTextView: UITextView!
    
    let kURLString = "https://www.mywebsite.com"
    let kURLString2 = "https://www.mywebsite.com2"
    
    var document: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        termsAndConditionsTextView.delegate = self
        
        let originalText = termsAndConditionsTextView.text!
        let attributedOriginalText = NSMutableAttributedString(string: originalText)

        let linkRange = attributedOriginalText.mutableString.range(of: "Términos y condiciones")
        attributedOriginalText.addAttribute(.link, value: kURLString, range: linkRange)
        
        let linkRange2 = attributedOriginalText.mutableString.range(of: "Declaración de privacidad")
        attributedOriginalText.addAttribute(.link, value: kURLString2, range: linkRange2)
        
        termsAndConditionsTextView.attributedText = attributedOriginalText

    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if (URL.absoluteString == kURLString) {
            document = "TerminosCondiciones"
            performSegue(withIdentifier: "test", sender: self)
        }
        
        if (URL.absoluteString == kURLString2) {
            document = "AvisoPrivacidad"
            performSegue(withIdentifier: "test", sender: self)
        }
        
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "test" {
            let destinationVC = segue.destination as! TermsDetailsViewController
            if let doc = document {
                destinationVC.document = doc
            }
            
        }
    }

}
