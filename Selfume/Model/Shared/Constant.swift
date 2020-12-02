
import UIKit
import Foundation

typealias ItemLoadedBlock = (_ result: Any, _ isSuccess : Bool , _ error : String) -> (Void)

let loaderSize = CGSize(width: 30, height: 30)
let appDelegateShared = UIApplication.shared.delegate as? AppDelegate

let kLanguage                                 = "Language"
let kEnglish                                  = "English"
let kHebrew                                   = "עברית"
let kSpanish                                  = "Español"
let kFrench                                   = "Français"
let kItalian                                  = "Italiano"
let kDeviceToken                              = "device_token"
let kLoginAutheticationHeader                 = "LoginAutheticationHeader"
let kUpdateLanguage                           = "kUpdateLanguage"
