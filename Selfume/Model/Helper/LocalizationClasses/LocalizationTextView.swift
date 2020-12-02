//
//  LocalizationTextfield.swift
//  Cantina
//
//  Created by Samir Khatri on 05/03/19.
//  Copyright © 2019 AppToDate. All rights reserved.
//

import UIKit
import Localize_Swift
class LocalizationTextView: UITextView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.font = UIFont(name: "Raleway-Regular", size: 11.0)
        NotificationCenter.default.addObserver(self, selector: #selector(localisation), name: Notification.Name(rawValue: kUpdateLanguage), object: nil)
        localisation()
    }
    
    @objc func localisation() {
        self.text = self.text?.localized()
    }
    
}
