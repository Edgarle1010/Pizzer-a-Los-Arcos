//
//  TermsDetailsViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 01/04/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit
import WebKit

class TermsDetailsViewController: UIViewController {
    @IBOutlet weak var termsWebView: WKWebView!
    
    var document: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let htmlpath = Bundle.main.path(forResource: document, ofType: "html")
        let url = URL(fileURLWithPath: htmlpath!)
        let request = URLRequest(url: url)
        termsWebView.load(request)
    }

}
