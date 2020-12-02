
import UIKit

typealias AccountBlock = (_ success : Bool, _ request: Account, _ errorMessage: String) -> (Void)

class Account: NSObject ,NSCoding {
    var accountBlock: AccountBlock  = {_,_,_ in }
    var name : String = ""
    var last_name : String = ""
    var first_name : String = ""
    var email : String = ""
    var mobile_no : String = ""
    var avtar : String = ""
    var facebookId : String = ""
    var userId : String = ""
    var facebook_accessToken : String = ""
    var apple_accessToken : String = ""
    var accessToken : String = ""
    var radius : Int = 0
    var device_type : String = ""
    var device_token : String = ""
    let ENCODING_VERSION:Int = 1;
    
    override init() {}
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name");
        aCoder.encode(last_name, forKey: "last_name");
        aCoder.encode(first_name, forKey: "first_name");
        aCoder.encode(mobile_no, forKey: "mobile_no");
        aCoder.encode(email, forKey: "email");
        aCoder.encode(avtar, forKey: "avtar");
        aCoder.encode(facebookId, forKey: "facebook");
        aCoder.encode(userId, forKey: "userId");
        aCoder.encode(facebook_accessToken, forKey: "facebook_accessToken");
        aCoder.encode(apple_accessToken, forKey: "apple_accessToken");
        aCoder.encode(accessToken, forKey: "token");
        aCoder.encode(ENCODING_VERSION, forKey: "version");
        aCoder.encode(radius, forKey: "radius");
        aCoder.encode(device_type, forKey: "device_type");
        aCoder.encode(device_token, forKey: "device_token");
    }
    
    required init?(coder aDecoder: NSCoder) {
        if(aDecoder.decodeInteger(forKey: "version") == ENCODING_VERSION) {
            name = aDecoder.decodeObject(forKey: "name") as? String  ?? ""
            last_name = aDecoder.decodeObject(forKey: "last_name") as? String  ?? ""
            first_name = aDecoder.decodeObject(forKey: "first_name") as? String  ?? ""
            mobile_no = aDecoder.decodeObject(forKey: "mobile_no") as? String  ?? ""
            email = aDecoder.decodeObject(forKey: "email") as? String  ?? ""
            avtar = aDecoder.decodeObject(forKey: "avtar") as? String  ?? ""
            facebookId = aDecoder.decodeObject(forKey: "facebookId") as? String  ?? ""
            userId = aDecoder.decodeObject(forKey: "userId") as? String  ?? ""
            facebook_accessToken = aDecoder.decodeObject(forKey: "facebook_accessToken") as? String  ?? ""
            apple_accessToken = aDecoder.decodeObject(forKey: "apple_accessToken") as? String  ?? ""
            accessToken = aDecoder.decodeObject(forKey: "accessToken") as? String  ?? ""
            radius = aDecoder.decodeObject(forKey: "radius") as? Int ?? 0
            device_type = aDecoder.decodeObject(forKey: "device_type") as? String  ?? ""
            device_token = aDecoder.decodeObject(forKey: "device_token") as? String  ?? ""
        }
    }
    
    func parseDict(inDict:[String : Any]) {
        if let aStr = inDict["id"] as? String{
            self.facebookId = aStr
            self.avtar = "https://graph.facebook.com/v2.6/\(self.facebookId)/picture?type=large"
        }
        
        if let aStr = inDict["name"] as? String{
            self.name = aStr
        }
        
        if let aStr = inDict["last_name"] as? String{
            self.last_name = aStr
        }
        
        if let aStr = inDict["first_name"] as? String{
            self.first_name = aStr
        }
        
        if let aStr = inDict["email"] as? String{
            self.email = aStr
        }
        
        if let aStr = inDict["mobile_no"] as? String{
            self.mobile_no = aStr
        }
        
        if let aStr = inDict["radius"] as? Int{
            self.radius = aStr
        }
        if let aStr = inDict["device_type"] as? Int{
            self.radius = aStr
        }
        if let aStr = inDict["device_token"] as? Int{
            self.radius = aStr
        }
    }
    
    func updateDeviceToken(block : @escaping AccountBlock){
        let request = Request.init(url: "\(kBaseUrl)\(kDeviceToken)\(self.userId)", method: .post) {
            (success:Bool, request:Request, message:NSString) -> (Void) in
            
            print(request)
            guard request.isSuccess else{
                block(false,self,message as String)
                return
            }
            block(true,self,message as String)
        }
       
        let device = ["device_type":"iOS","device_token": ""] as [String : Any]
        request.setParameter(device, forKey: "device")
        request.startRequest()
    }
}


