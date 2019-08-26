//
//  HSLocationWarningViewController.swift
//  HeadStart
//
//  Created by Ashfauck on 3/26/19.
//  Copyright © 2019 Ashfauck. All rights reserved.
//

import UIKit
import CoreLocation

class HSLocationWarningViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Listens for the apps lifecycle if it did become active
        // Check the location service is Enabled or not
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }

    @objc func didBecomeActive()
    {
        
        if CLLocationManager.locationServicesEnabled(),[CLAuthorizationStatus.authorizedAlways,.authorizedWhenInUse].contains(CLLocationManager.authorizationStatus())
        {
               self.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func settingsBtnAction(_ sender: UIButton)
    {
        guard let bundleId = Bundle.main.bundleIdentifier, let settingsUrl = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION\(bundleId)")
            else
        {
            print("Unable to open the app settings")
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl)
        {
            UIApplication.shared.open(settingsUrl, options: [:]) { (completed) in
                if completed
                {
                    print("Setting opened")
                }
            }
        }
    }
    
    
    
}
