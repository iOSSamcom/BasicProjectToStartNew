import UIKit
import CoreLocation

class LocationManagerHelper: NSObject, CLLocationManagerDelegate {
    
    var locationManagerGlobal: CLLocationManager?
    var locationGlobal : CLLocation?
    
    static let sharedManager = LocationManagerHelper()
    
    func locationIntialization() {
        //Check location is on or off
        self.checkLocationServiceEnable()
        if CLLocationManager.locationServicesEnabled() {
            //Location Manager
            locationManagerGlobal = CLLocationManager()
            locationManagerGlobal?.delegate = self
            locationManagerGlobal?.requestWhenInUseAuthorization()
            locationManagerGlobal?.requestAlwaysAuthorization()
            locationManagerGlobal?.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManagerGlobal?.startUpdatingLocation() // start location manager
        }
    }
    
    func checkLocationServiceEnable() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .restricted, .denied:
                print("No access")
                UIApplication.openAppSettings()
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
            case .notDetermined:
                locationManagerGlobal?.requestAlwaysAuthorization()
                locationManagerGlobal?.requestWhenInUseAuthorization()
                break
            }
        } else {
            print("Location services are not enabled")
            locationManagerGlobal?.requestAlwaysAuthorization()
            locationManagerGlobal?.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        locationManagerGlobal?.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locations.first != nil else {
            return
        }
        let userLocation:CLLocation = locations[0] as CLLocation
        locationGlobal = userLocation
        locationManagerGlobal?.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
