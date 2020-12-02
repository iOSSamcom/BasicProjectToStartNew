//
//  ViewController.swift
//  Selfume
//
//  Created by Samir imac4 on 01/12/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        Utils.updateLanguage(str : kEnglish, view: view)
        self.lblText.text = "Hello World".localized()
        // Do any additional setup after loading the view.
    }

    @IBAction func changeLanguageClick(_ sender: Any) {
        if Utils.fetchString(forKey: kLanguage) == kEnglish {
            Utils.updateLanguage(str : kItalian, view: view)
            Localize.setCurrentLanguage("it")
        }
        else if Utils.fetchString(forKey: kLanguage) == kItalian {
            Utils.updateLanguage(str : kEnglish, view: view)
            Localize.setCurrentLanguage("en")
        }
        self.lblText.text = "Hello World".localized()
    }
    
}

