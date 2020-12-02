import UIKit
import Foundation
import EventKit
import Localize_Swift
import Photos

public enum FontType: Int {
    case fontBold = 0
    case fontRegular = 1
    case fontThin = 2
    case fontSemiBold = 3
}

public enum FontSize: Int {
    case regular = 0 // 17
    case lowest = 1 // 10
    case medium = 2 // 14
    case large = 3 // 21
    case largest = 4 // 30
}

var ALERT_TITLE: String = "Selfume".localized()

class Utils: NSObject {
    
    class func getTopViewController() -> UIViewController {
        var topController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        while ((topController?.presentedViewController) != nil) {
            topController = topController?.presentedViewController
        }
        return topController!
    }
    
    class func getTopVisibleVC() -> UIViewController {
        if let wd = UIApplication.shared.delegate?.window {
            var vc = wd!.rootViewController
            if(vc is UINavigationController){
                vc = (vc as! UINavigationController).visibleViewController
            }
            return vc!
        }
        return Utils.getTopViewController()
    }
    
    
    class func dismissAnyAlertControllerIfPresent(completion:@escaping () -> Void) {
        guard let window :UIWindow = UIApplication.shared.keyWindow , var topVC = window.rootViewController?.presentedViewController else {
            completion()
            return
        }
        while topVC.presentedViewController != nil  {
            topVC = topVC.presentedViewController!
        }
        topVC.dismiss(animated: false, completion: {
            completion()
        })
    }
    
    
    class func checkIfAnyAlertControllerIsPresent(completion:@escaping (_ isPresent: Bool) -> Void) {
        guard let window :UIWindow = UIApplication.shared.keyWindow , var topVC = window.rootViewController?.presentedViewController else {
            completion(false)
            return
        }
        while topVC.presentedViewController != nil  {
            topVC = topVC.presentedViewController!
        }
        
        completion(true)
    }
    
    class func showAlert(withMessage message: String) {
        let alertController = UIAlertController(title: ALERT_TITLE.localized(), message: message , preferredStyle: .alert)
        alertController.dismiss(animated: true, completion: nil)
        let actionOk = UIAlertAction(title: "Ok".localized(), style: .default, handler: nil)
        alertController.addAction(actionOk)
        Utils.getTopViewController().present(alertController, animated: true)
    }
    
    class func isLeapYear(_ year: Int) -> Bool {
        let isLeapYear = ((year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0))
        return isLeapYear
    }
    // withTitle.localized()
    class func showAlert(withTitle:String, withMessage: String, withButtonTitle:String) {
        let alertController = UIAlertController(title: "" , message: withMessage , preferredStyle: .alert)
        
        let actionOk = UIAlertAction(title: withButtonTitle, style: .default, handler: nil)
        alertController.addAction(actionOk)
        Utils.getTopViewController().present(alertController, animated: true)
    }
    
    
    class func isEmailValid(txt: String) -> Bool {
        let Email_REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", Email_REGEX)
        let result =  emailTest.evaluate(with: txt)
        return result
    }
    
    class func isEmail(txt: String) -> Bool {
        let regex = try? NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}", options: .caseInsensitive)
        return regex?.firstMatch(in: txt, options: [], range: NSMakeRange(0, txt.count)) != nil
    }
    
    class func isNumber(number:String) -> Bool{
        let numberRegEx = "[0-9]{10,13}"
        let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        if numberTest.evaluate(with: number) == true {
            return true
        }
        else {
            return false
        }
    }
    
    class func isPhoneNumber(value: String) -> Bool {
        let PHONE_REGEX =  "^((\\+))[0-9]{6,15}"
        //        let PHONE_REGEX = "[+0-9]{6,15}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    class func isPhoneNumber2(value: String) -> Bool {
        var PHONE_REGEX = String()
        let firstChar = value.first
        if value.contains("+"){
            if firstChar == "+"{
                PHONE_REGEX =  "^((\\+))[0-9]{6,15}"
            }
        }else{
            PHONE_REGEX = "[0-9]{6,15}"
        }
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    class func isPassword(value: String) -> Bool {
        if value.count > 5 && value.count < 16 {
            return true
        }
        return false
    }
    class func isPassword(txt: String) -> Bool {
        let regex = try? NSRegularExpression(pattern: "^[A-Z0-9a-z._@]{6,15}", options: .caseInsensitive)
        return regex?.firstMatch(in: txt, options: [], range: NSMakeRange(0, txt.count)) != nil
    }
    
    class func isZipcode(number:String) -> Bool{
        let numberRegEx = "[0-9]{1,10}"
        let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        if numberTest.evaluate(with: number) == true {
            return true
        }
        else {
            return false
        }
    }
    
    class func randomString(length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        var randomString = "Vdate"
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
    
    class func isSimulator() -> Bool {
        return Platform.isSimulator
    }
    
    class func setBottomBorderForTextField(txtField: UITextField) {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: txtField.frame.size.height - width, width:  txtField.frame.size.width, height: txtField.frame.size.height)
        border.borderWidth = width
        txtField.layer.addSublayer(border)
        txtField.layer.masksToBounds = true
    }
    
    class func setShadowForTextField(textField: UITextField) {
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = textField.bounds
        shadowLayer.shadowColor = UIColor(white: 0, alpha: 1).cgColor
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadowLayer.shadowOpacity = 0.3
        shadowLayer.shadowRadius = 4
        shadowLayer.fillRule = CAShapeLayerFillRule.evenOdd
        let path: CGMutablePath = CGMutablePath()
        path.addRect(textField.bounds.insetBy(dx: -42, dy: -42), transform: .identity)
        let someInnerPath = (UIBezierPath(roundedRect: textField.bounds, cornerRadius: textField.layer.cornerRadius).cgPath)
        path.addPath(someInnerPath, transform: .identity)
        path.closeSubpath()
        shadowLayer.path = path
        textField.layer.addSublayer(shadowLayer)
        let maskLayer = CAShapeLayer()
        maskLayer.path = someInnerPath
        shadowLayer.mask = maskLayer
    }
    
    class func setShadowForTextView(textView: UITextView) {
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = textView.bounds
        shadowLayer.shadowColor = UIColor(white: 0, alpha: 1).cgColor
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadowLayer.shadowOpacity = 0.1
        shadowLayer.shadowRadius = 4
        shadowLayer.fillRule = CAShapeLayerFillRule.evenOdd
        let path: CGMutablePath = CGMutablePath()
        path.addRect(textView.bounds.insetBy(dx: -15, dy: -15), transform: .identity)
        let someInnerPath = (UIBezierPath(roundedRect: textView.bounds, cornerRadius: textView.layer.cornerRadius).cgPath)
        path.addPath(someInnerPath, transform: .identity)
        path.closeSubpath()
        shadowLayer.path = path
        textView.layer.addSublayer(shadowLayer)
    }
    
    class func setShadowForView(inView: UIView) {
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = inView.bounds
        shadowLayer.shadowColor = UIColor(white: 0, alpha: 1).cgColor
        shadowLayer.shadowOffset = CGSize(width: 1, height:1)
        shadowLayer.shadowOpacity = 0.7
        shadowLayer.shadowRadius = 4
        shadowLayer.fillRule = CAShapeLayerFillRule.evenOdd
        let path: CGMutablePath = CGMutablePath()
        path.addRect(inView.bounds.insetBy(dx: -42, dy: -42), transform: .identity)
        let someInnerPath = (UIBezierPath(roundedRect: inView.bounds, cornerRadius: inView.layer.cornerRadius).cgPath)
        path.addPath(someInnerPath, transform: .identity)
        path.closeSubpath()
        shadowLayer.path = path
        inView.layer.addSublayer(shadowLayer)
        let maskLayer = CAShapeLayer()
        maskLayer.path = someInnerPath
        shadowLayer.mask = maskLayer
    }
    
    class func bottomInnerShadow(imageViewShadow: UIImageView) {
        let gradient = CAGradientLayer()
        gradient.frame = imageViewShadow.bounds
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.startPoint = CGPoint.init(x: 1, y: 1)
        gradient.endPoint = CGPoint.init(x: 1, y: 0.7)
        if gradient.superlayer == nil {
            imageViewShadow.layer.insertSublayer(gradient, at: 0)
        }
    }
    
    class func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        //let scale = newWidth / image.size.width
        //let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newWidth))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newWidth))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    class func resizedImageForTabbar(image: UIImageView, newWidth: CGFloat) -> UIImage {
        let scale = newWidth / image.frame.size.width
        let newHeight = image.frame.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    class func load_image(image_url_string:String, view:UIImageView) {
        let URL_IMAGE = URL(string: image_url_string )//"http://www.simplifiedtechy.net/wp-content/uploads/2017/07/simplified-techy-default.png"
        let session = URLSession(configuration: .default)
        //creating a dataTask
        let getImageFromUrl = session.dataTask(with: URL_IMAGE!) { (data, response, error) in
            //if there is any error
            if let e = error {
                //displaying the message
                print("Error Occurred: \(e)")
            } else {
                //in case of now error, checking wheather the response is nil or not
                if (response as? HTTPURLResponse) != nil {
                    
                    //checking if the response contains an image
                    if let imageData = data {
                        //getting the image
                        let image = UIImage(data: imageData)
                        
                        //displaying the image
                        view.image = image
                    } else {
                        print("Image file is currupted")
                    }
                } else {
                    print("No response from server")
                }
            }
        }
        getImageFromUrl.resume()
    }
    class func openAppleMap(location : CLLocationCoordinate2D) {
        if let currentLocation = LocationManagerHelper.sharedManager.locationGlobal {
            let directionsURL = "http://maps.apple.com/?saddr=\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)&daddr=\(location.longitude),\(location.latitude)"
            guard let url = URL(string: directionsURL) else {
                return
            }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    class func openWaze(location : CLLocationCoordinate2D) {
        if UIApplication.shared.canOpenURL(URL(string: "waze://")!) {
            // Waze is installed. Launch Waze and start navigation
            guard let url = URL(string: "waze://?ll=\(location.longitude),\(location.latitude)&navigate=yes") else { return }
            UIApplication.shared.open(url)
        }
        else
        {
            // Waze is not installed. Launch AppStore to install Waze app
            guard let url = URL(string: "https://apps.apple.com/us/app/waze-navigation-live-traffic/id323229106") else { return }
            UIApplication.shared.open(url)
        }
    }
    class func openGoogleMaps(location : CLLocationCoordinate2D){
        if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!) {
            if let currentLocation = LocationManagerHelper.sharedManager.locationGlobal {
                guard let url = URL(string: "comgooglemaps://?saddr=\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)&daddr=\(location.longitude),\(location.latitude)&directionsmode=driving") else { return }
                UIApplication.shared.open(url)
            } else {
                guard let url = URL(string: "comgooglemaps://?saddr=23.0225,72.5714&daddr=\(location.longitude),\(location.latitude)&directionsmode=driving") else { return }
                UIApplication.shared.open(url)
            }
        } else {
            guard let url = URL(string: "https://apps.apple.com/us/app/google-maps-transit-food/id585027354") else { return }
            UIApplication.shared.open(url)
        }
    }
    class func setBottomBorderForView(inView: UIView) {
        inView.layer.borderColor = UIColor.black.cgColor
        inView.layer.borderWidth = 1.0;
    }
    
    class func setBoolForKey(_ value: Bool, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func fetchBool(forKey key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    class func fetchInt(forKey key: String) -> Int {
        return UserDefaults.standard.integer(forKey: key)
    }
    
    class func setStringForKey(_ value: String, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    class func setIntForKey(_ value: Int, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    
    class func fetchString(forKey key: String) -> String {
        if UserDefaults.standard.string(forKey: key) == nil {
            return ""
        }
        return UserDefaults.standard.string(forKey: key)!
    }
    class func removekey(forKey key: String) -> Void {
        return UserDefaults.standard.removeObject(forKey: key)
    }
    
    class func applyGradientForUIView(inView:UIView) {
        let layer = UIView(frame: CGRect(x: 0, y: 0, width: 376, height: 618))
        layer.alpha = 0.7
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: inView.frame.width, height: inView.frame.height)
        gradient.colors = [ UIColor(red:65/255, green:67/255, blue:63/255, alpha:1).cgColor, UIColor(red:126/255, green:134/255, blue:100/255, alpha:0.65).cgColor]
        //        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        layer.layer.addSublayer(gradient)
        inView.layer.addSublayer(gradient)
    }
    
    class func showAlertWithPopController(withMessage message: String, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: "", message: message , preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Ok".localized(), style: UIAlertAction.Style.default) {
            UIAlertAction in
            
            completionHandler() //Utils.getTopViewController().navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: UIAlertAction.Style.default) {
            UIAlertAction in
            
            completionHandler() //Utils.getTopViewController().navigationController?.popViewController(animated: true)
        }
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        
        // Present the controller
        
        Utils.getTopViewController().present(alertController, animated: true)
    }
    
    //MARK:- Helper
    //    class func applygradient(view: TagView) {
    //
    //        if view.isSelected {
    //
    //            let layer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
    //
    ////            layer.backgroundColor = UIColor.green
    //            layer.tag = 100
    //            layer.isUserInteractionEnabled = false
    //
    //            view.layer.shadowOpacity = 1
    //            view.layer.masksToBounds = false
    //            view.layer.shadowOffset = CGSize(width: -1, height: 10)
    //            view.layer.shadowColor = UIColor(red:0.31, green:0.52, blue:1, alpha:0.28).cgColor
    //            view.layer.shadowRadius = 5
    //
    //            view.textFont = UIFont.init(name: "LucidaGrande-Bold", size: 15)!
    //
    //            let gradient = CAGradientLayer()
    //            gradient.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height )
    //            gradient.colors = [
    //                UIColor(red:0.31, green:0.41, blue:1, alpha:1).cgColor,
    //                UIColor(red:0.05, green:0.34, blue:0.85, alpha:1).cgColor
    //            ]
    //
    //            gradient.locations = [0, 1]
    //            gradient.startPoint = CGPoint(x: 0.03, y: 0.39)
    //            gradient.endPoint = CGPoint(x: 0.97, y: 0.5)
    //            gradient.cornerRadius = 10
    //
    //            layer.layer.addSublayer(gradient)
    //
    //            view.addSubview(layer)
    //            view.sendSubviewToBack(layer)
    //
    //        } else {
    //
    //            view.layer.masksToBounds = true
    //            view.textFont = UIFont.init(name: "Lato-Bold", size: 16)!
    //
    //            // Remoe layer View
    //            for subview in view.subviews{
    //                if subview.tag == 100 {
    //                    subview.removeFromSuperview()
    //                }
    //            }
    //        }
    //    }
    
    class func setImageFromURL(imgId:String,imgView:UIImageView){
        var url: URL?
        if imgId.contains("http"){
            url = URL(string:imgId)
        } else {
            url = URL(string: "\(kImageUrl)\(imgId)")
        }
        
        imgView.sd_setImage(with: url, placeholderImage: UIImage(named: "Placeholder"), options: .refreshCached, completed: { (image, error, cacheType, url) in
            if image != nil{
                DispatchQueue.main.async {
                    imgView.image = image
                }
            } else {
                imgView.image = UIImage(named: "Placeholder")
            }
        })
    }
     //Mark : Remove event
    
    class func addEventToCalendar(title: String, description: String?, startDate: Date, endDate: Date, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
        let alertController = UIAlertController(title: ALERT_TITLE, message: "Do you want to add this session in your calendar?".localized() , preferredStyle: .alert)
        // Create the actions
        let okAction = UIAlertAction(title: "Yes".localized(), style: UIAlertAction.Style.default) {
            UIAlertAction in
            
            let eventStore = EKEventStore()
            eventStore.requestAccess(to: .event, completion: { (granted, error) in
                if (granted) && (error == nil) {
                    let event = EKEvent(eventStore: eventStore)
                    event.title = title
                    event.startDate = startDate
                    event.endDate = endDate
                    event.notes = description
                    event.calendar = eventStore.defaultCalendarForNewEvents
                    do {
                        try eventStore.save(event, span: .thisEvent)
                    } catch let e as NSError {
                        DispatchQueue.main.async {
                            completion?(false, e)
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        completion?(true, nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion?(false, error as NSError?)
                    }
                }
            })
        }
        
        let cancelAction = UIAlertAction(title: "No".localized(), style: UIAlertAction.Style.default) {
            UIAlertAction in
            DispatchQueue.main.async {
                completion?(false, nil)
            }
        }
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        Utils.getTopViewController().present(alertController, animated: true)
    }
    
    //Mark : Remove event
    class func removeEventFromCalendar(title: String, description: String?, startDate: Date, endDate: Date, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
        let alertController = UIAlertController(title: ALERT_TITLE, message: "Do you want to remove this session from your calendar?".localized() , preferredStyle: .alert)
        // Create the actions
        let okAction = UIAlertAction(title: "Yes".localized(), style: UIAlertAction.Style.default) {
            UIAlertAction in
            
            let eventStore = EKEventStore()
            eventStore.requestAccess(to: .event, completion: { (granted, error) in
                if (granted) && (error == nil) {
                    
                    let event = eventStore.event(withIdentifier: "EE3FDCF4-2B91-4409-BF5D-6644D780ECA5")
                    if event != nil {
                        do {
                            try eventStore.remove(event!, span: .thisEvent)
                        } catch let e as NSError {
                            completion?(false, e)
                            return
                        }
                    }
                    
                    
                    
//                    let event = EKEvent(eventStore: eventStore)
//                    event.title = title
//                    event.startDate = startDate
//                    event.endDate = endDate
//                    event.notes = description
//                    do {
//                        try eventStore.remove(event, span: .thisEvent)
//                    } catch let e as NSError {
//                        completion?(false, e)
//                        return
//                    }
                    completion?(true, nil)
                } else {
                    completion?(false, error as NSError?)
                }
            })
        }
        
        let cancelAction = UIAlertAction(title: "No".localized(), style: UIAlertAction.Style.default) {
            UIAlertAction in
            
        }
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        Utils.getTopViewController().present(alertController, animated: true)
    }
    
    //MARK:- Pass any button and badge will set
    
    class func setButtonWithBadge(imageName: String, btn: UIButton, buttonWidth: Int, buttonHeight: Int) {
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight)
        // tag = 1111 = menu
        // tag = 2222 = bell icon
        // tag = 3333 = upcoming session
        // tag = 4444 = recent paintings
        // tag = 5555 = new locations
        self.getBadgeLabelOnButton(btn: btn)
    }
    
    class func getBadgeLabelOnButton(btn: UIButton) {
        let widthButton = btn.frame.size.width
        let heightButton = btn.frame.size.height
        let current_localization =  Utils.fetchString(forKey: kLanguage)
        var lblBadge = UILabel()
        if current_localization == kHebrew {
            lblBadge = UILabel.init(frame: CGRect.init(x: -8, y: 0, width: widthButton/2, height: heightButton/2))
        } else {
            lblBadge = UILabel.init(frame: CGRect.init(x: widthButton-(widthButton/2), y: 0, width: widthButton/2, height: heightButton/2))
        }
        
        lblBadge.backgroundColor = NewGreenButtonColor
        lblBadge.clipsToBounds = true
        lblBadge.layer.cornerRadius = 7
        lblBadge.textColor = UIColor.white
        lblBadge.font = UIFont(name: "Raleway", size: 10)
        lblBadge.textAlignment = .center
        lblBadge.tag = btn.tag
        for view in btn.subviews {
            view.removeFromSuperview()
        }
        btn.addSubview(lblBadge)
    }
    
    class func updateBadgeOnButton(btn: UIButton, strBadge: String, VC: UIViewController?) {
        
        for lbl in btn.subviews {
            
            if lbl.tag == btn.tag {
                
                let lblBadge = lbl as! UILabel
                
                guard let intValue = Int(strBadge) else { return }
                
                if intValue > 99
                {
                    lblBadge.text = "99+"
                } else {
                    DispatchQueue.main.async {
                        lblBadge.text = strBadge
                        if let objVC = VC {
                            objVC.view.setNeedsDisplay()
                        }
                        lblBadge.setNeedsDisplay()
                    }
                }
                
                var width = lblBadge.intrinsicContentSize.width
                
                if width > 30 {
                    width = 30
                }
                
                if width < 15 {
                    width = 15
                }
                if strBadge == "0" {
                    lblBadge.frame = CGRect(x: btn.frame.size.width-8, y: 0, width: 0, height: 0)
                } else {
                    let current_localization =  Utils.fetchString(forKey: kLanguage)
                    if current_localization == kHebrew {
                        lblBadge.frame = CGRect(x: -8, y: 0, width: width, height: 15)
                    }
                    else {
                        lblBadge.frame = CGRect(x: btn.frame.size.width-8, y: 0, width: width, height: 15)
                    }
                }
            }
        }
    }
    
    //Image zoom funcionality with Lightbox
    class func zoomImageWithLightbox(viewController: UIViewController, collection: [LightboxImage], selectedIndex: Int) {
        LightboxConfig.CloseButton.text = "Close".localized()
        let controller = LightboxController(images: collection, startIndex: selectedIndex)
        controller.dynamicBackground = true
        controller.modalPresentationStyle = .fullScreen
        viewController.present(controller, animated: true, completion: nil)
    }
    
    func resolutionForLocalVideo(url: URL) -> CGSize? {
        guard let track = AVURLAsset(url: url).tracks(withMediaType: AVMediaType.video).first else { return nil }
        let size = track.naturalSize.applying(track.preferredTransform)
        return CGSize(width: abs(size.width), height: abs(size.height))
    }
    
    //MARK:- Language Change functions
    class func updateLanguage(str : String, view: UIView?) {
        
        Utils.setStringForKey(str, key: kLanguage)
        
        if Utils.fetchString(forKey: kLanguage) == kHebrew {
            Localize.setCurrentLanguage("he")
        }
        else if Utils.fetchString(forKey: kLanguage) == kSpanish {
            Localize.setCurrentLanguage("es")
        }
        else if Utils.fetchString(forKey: kLanguage) == kFrench {
            Localize.setCurrentLanguage("fr")
        }
        else if Utils.fetchString(forKey: kLanguage) == kItalian {
            Localize.setCurrentLanguage("it")
        } else {
            Localize.setCurrentLanguage("en")
        }
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: kUpdateLanguage), object: nil)
        self.changeLHSRHS()
        self.reloadViewFromNib(view: view)
    }
    class func changeLHSRHS() {
        let current_localization = Utils.fetchString(forKey: kLanguage)
        
        if current_localization == kHebrew{
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
    class func reloadViewFromNib(view: UIView?) {
        // This lines causes the view to be reloaded
        if (view != nil) {
            let parent = view!.superview
            view!.removeFromSuperview()
            parent?.addSubview(view!)
        }
    }
}

extension String {
    func contains(_ find: String) -> Bool{
        return self.range(of: find) != nil
    }
    func containsIgnoringCase(_ find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

struct Platform {
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}

extension UIDevice {
    static var isIphoneX: Bool {
        var modelIdentifier = ""
        if isSimulator {
            modelIdentifier = ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"] ?? ""
        } else {
            var size = 0
            sysctlbyname("hw.machine", nil, &size, nil, 0)
            var machine = [CChar](repeating: 0, count: size)
            sysctlbyname("hw.machine", &machine, &size, nil, 0)
            modelIdentifier = String(cString: machine)
        }
        return modelIdentifier == "iPhone10,3" || modelIdentifier == "iPhone10,6"
    }
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}

extension UIView {
    func showToastAlert(message : String) {
    
        let toastLabel = UILabel()
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont(name: "Raleway-Regular", size: 16)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.addSubview(toastLabel)
        
        toastLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -80).isActive = true
        toastLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        toastLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        toastLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func setTopBottomViewShadow(){
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 1, height: 0)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.4
        self.layer.shadowColor = UIColor.lightGray.cgColor
    }
    func addTopBorder(_ color: UIColor, height: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        border.addConstraint(NSLayoutConstraint(item: border,
                                                attribute: NSLayoutConstraint.Attribute.height,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: nil,
                                                attribute: NSLayoutConstraint.Attribute.height,
                                                multiplier: 1, constant: height))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.top,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.top,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.leading,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.leading,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.trailing,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.trailing,
                                              multiplier: 1, constant: 0))
    }
    
    func addBottomBorder(_ color: UIColor, height: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        border.addConstraint(NSLayoutConstraint(item: border,
                                                attribute: NSLayoutConstraint.Attribute.height,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: nil,
                                                attribute: NSLayoutConstraint.Attribute.height,
                                                multiplier: 1, constant: height))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.bottom,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.bottom,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.leading,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.leading,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.trailing,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.trailing,
                                              multiplier: 1, constant: 0))
    }
    func addLeftBorder(_ color: UIColor, width: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        border.addConstraint(NSLayoutConstraint(item: border,
                                                attribute: NSLayoutConstraint.Attribute.width,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: nil,
                                                attribute: NSLayoutConstraint.Attribute.width,
                                                multiplier: 1, constant: width))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.leading,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.leading,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.bottom,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.bottom,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.top,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.top,
                                              multiplier: 1, constant: 0))
    }
    func addRightBorder(_ color: UIColor, width: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        border.addConstraint(NSLayoutConstraint(item: border,
                                                attribute: NSLayoutConstraint.Attribute.width,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: nil,
                                                attribute: NSLayoutConstraint.Attribute.width,
                                                multiplier: 1, constant: width))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.trailing,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.trailing,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.bottom,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.bottom,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.top,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.top,
                                              multiplier: 1, constant: 0))
    }
}
extension UIImage{
    var roundedImage: UIImage {
        let rect = CGRect(origin:CGPoint(x: 0, y: 0), size: self.size)
        UIGraphicsBeginImageContextWithOptions(self.size, false, 1)
        UIBezierPath(
            roundedRect: rect,
            cornerRadius: self.size.height
            ).addClip()
        self.draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
    func resize(targetSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size:targetSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}


extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}

//MARK: New Design Changes

//MARK: Label
public extension UILabel {
    func setLabelStyle(fontSize : FontSize, fontType: FontType, fontColor: UIColor?){
        
        if (fontColor != nil) {
            self.textColor = fontColor
        }
        
        switch fontSize {
        case .regular:
            switch fontType {
            case .fontBold:
                self.font = BoldFontRegularSize
                break
            case .fontRegular:
                self.font = RegularFontRegularSize
                break
            case .fontThin:
                self.font = ThinFontRegularSize
                break
            case .fontSemiBold:
                self.font = SemiBoldFontRegularSize
                break
            }
            break
        case .lowest:
            switch fontType {
            case .fontBold:
                self.font = BoldFontLowestSize
                break
            case .fontRegular:
                self.font = RegularFontLowestSize
                break
            case .fontThin:
                self.font = ThinFontLowestSize
                break
            case .fontSemiBold:
                self.font = SemiBoldFontLowestSize
                break
            }
            break
        case .medium:
            switch fontType {
            case .fontBold:
                self.font = BoldFontMediumSize
                break
            case .fontRegular:
                self.font = RegularFontMediumSize
                break
            case .fontThin:
                self.font = ThinFontMediumSize
                break
            case .fontSemiBold:
                self.font = SemiBoldFontMediumSize
                break
            }
            break
            
        case .large:
            switch fontType {
            case .fontBold:
                self.font = BoldFontLargerSize
                break
            case .fontRegular:
                self.font = RegularFontLargerSize
                break
            case .fontThin:
                self.font = ThinFontLargerSize
                break
            case .fontSemiBold:
                self.font = SemiBoldFontLargerSize
                break
            }
            break
        case .largest:
            switch fontType {
            case .fontBold:
                self.font = BoldFontLargestSize
                break
            case .fontRegular:
                self.font = RegularFontLargestSize
                break
            case .fontThin:
                self.font = ThinFontLargestSize
                break
            case .fontSemiBold:
                self.font = SemiBoldFontLargestSize
                break
            }
            break
        }
    }
}

//MARK: button
public extension UIButton {
    func setButtonStyle(fontColour : UIColor, backGroundColour: UIColor, fontType: FontType, fontSize: FontSize, customTintColor: UIColor?){
        self.setTitleColor(fontColour, for: .normal)
        self.backgroundColor = backGroundColour
        
        if (customTintColor != nil) {
            self.tintColor = customTintColor
        }
        
        switch fontSize {
        case .regular:
            switch fontType {
            case .fontBold:
                self.titleLabel?.font = BoldFontRegularSize
                break
            case .fontRegular:
                self.titleLabel?.font = RegularFontRegularSize
                break
            case .fontThin:
                self.titleLabel?.font = ThinFontRegularSize
                break
            case .fontSemiBold:
                self.titleLabel?.font = SemiBoldFontRegularSize
                break
            }
            break
        case .lowest:
            switch fontType {
            case .fontBold:
                self.titleLabel?.font = BoldFontLowestSize
                break
            case .fontRegular:
                self.titleLabel?.font = RegularFontLowestSize
                break
            case .fontThin:
                self.titleLabel?.font = ThinFontLowestSize
                break
            case .fontSemiBold:
                self.titleLabel?.font = SemiBoldFontLowestSize
                break
            }
            break
        case .medium:
            switch fontType {
            case .fontBold:
                self.titleLabel?.font = BoldFontMediumSize
                break
            case .fontRegular:
                self.titleLabel?.font = RegularFontMediumSize
                break
            case .fontThin:
                self.titleLabel?.font = ThinFontMediumSize
                break
            case .fontSemiBold:
                self.titleLabel?.font = SemiBoldFontMediumSize
                break
            }
            break
            
        case .large:
            switch fontType {
            case .fontBold:
                self.titleLabel?.font = BoldFontLargerSize
                break
            case .fontRegular:
                self.titleLabel?.font = RegularFontLargerSize
                break
            case .fontThin:
                self.titleLabel?.font = ThinFontLargerSize
                break
            case .fontSemiBold:
                self.titleLabel?.font = SemiBoldFontLargerSize
                break
            }
            break
        case .largest:
            switch fontType {
            case .fontBold:
                self.titleLabel?.font = BoldFontLargestSize
                break
            case .fontRegular:
                self.titleLabel?.font = RegularFontLargestSize
                break
            case .fontThin:
                self.titleLabel?.font = ThinFontLargestSize
                break
            case .fontSemiBold:
                self.titleLabel?.font = SemiBoldFontLargestSize
                break
            }
            break
        }
    }
}

extension Double {
    var removeDecimalIfZeroValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.1f", self)
    }
    
    var removeDecimalOrAdd: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        return formatter.string(from: self as NSNumber) ?? "0/5"
    }
}

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}

