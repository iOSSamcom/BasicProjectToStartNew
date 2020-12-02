//
//  LocalizationLabel.swift
//  Cantina
//
//  Created by Samir Khatri on 02/03/19.
//  Copyright © 2019 AppToDate. All rights reserved.
//

import UIKit
import Localize_Swift

class LocalizationLabel: UILabel {

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(localisation), name: Notification.Name(rawValue: kUpdateLanguage), object: nil)
        localisation()
    }
    
   @objc func localisation() {
    self.text = self.text?.localized()
    }

}
