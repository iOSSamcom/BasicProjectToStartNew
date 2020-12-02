//
//  LocalizationButton.swift
//  Cantina
//
//  Created by Samir Khatri on 02/03/19.
//  Copyright © 2019 AppToDate. All rights reserved.
//

import UIKit
import Localize_Swift

class LocalizationButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    localisation()
    NotificationCenter.default.addObserver(self, selector: #selector(localisation), name: Notification.Name(rawValue: kUpdateLanguage), object: nil)
    }
    
   @objc func localisation() {
        self.setTitle(self.titleLabel?.text?.localized(), for: .normal)
    }

}
