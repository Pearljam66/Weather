//
//  LocationManager.swift
//  Weather
//
//  Created by Sarah Clark on 9/21/23.
//

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    typealias LocationUpdateHandler = ((CLLocation?, Error?) -> Void)
    private var didUpdateLocation: LocationUpdateHandler?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        manager.requestWhenInUseAuthorization()
    }

    public func updateLocation(handler: @escaping LocationUpdateHandler) {
        self.didUpdateLocation = handler
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let handler = didUpdateLocation {
            handler(locations.last, nil)
        }
        manager.stopUpdatingLocation()
    }

    func  locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let handler = didUpdateLocation {
            handler(nil, error)
        }
    }
}

