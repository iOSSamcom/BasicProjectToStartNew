
import UIKit
import MagicalRecord
import FastEasyMapping
import CoreLocation

class Manager: NSObject {
    var itemLoadedBlock : ItemLoadedBlock = {_,_,_  in }
}

extension Manager {
    
    class func sharedManager() -> Manager {
        var singleton: Manager? = nil
        if singleton == nil {
            singleton = Manager()
        }
        return singleton!
    }
    
    // Below function is for example, you can change base url and contact url by your own
    class func searchRegisteredUsersSearchBy(username: String, limit: String, skip: String, isRemoveAllData: Bool, block : @escaping ItemLoadedBlock){
        
        let request = Request.init(url: "\(kBaseUrl)\(kLogin)", method: .post) {
            (success:Bool, request:Request, message:NSString) -> (Void) in
            
            print(request)
            guard request.isSuccess, let arrUsers = request.serverData["data"] as? [Any] else {
                block("",request.isSuccess,message as String)
                return
            }
            
            /*
            MagicalRecord.save(blockAndWait: { (localContext:NSManagedObjectContext) in
                if isRemoveAllData {
                    InviteUsers.mr_truncateAll(in: localContext)
                }
                let arrUsers = FEMDeserializer.collection(fromRepresentation: arrUsers, mapping: InviteUsers.defaultMapping(), context: localContext)
                DispatchQueue.main.async {
                    block(arrUsers,request.isSuccess,message as String)
                }
            }) */
        }
        
        let whereDict:[String:Any] = ["limit":Int(limit) as Any,"skip":Int(skip) as Any]
        request.setParameter(whereDict, forKey: "limit")
        request.setParameter(username, forKey: "username")
        let acc = AccountManager.instance().activeAccount!
        request.setParameter(acc.userId, forKey: "userId")
        request.startRequest()
    }
}

