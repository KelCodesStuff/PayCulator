//
//  InfoController.swift
//  Payculator
//
//  Created by Kelvin Reid on 5/19/19.
//  Copyright © 2019 Kelvin Reid. All rights reserved.
//

import UIKit

class InfoController: UIViewController {
    
    // This is in the plist file
    let appVersionNumber = "CFBundleShortVersionString"
    let appBuildNumber = "CFBundleVersion"

    @IBOutlet var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        versionLabel.text = getVersion()

    }
    
    func getVersion() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary[appVersionNumber] as! String
        let build = dictionary[appBuildNumber] as! String
        
        return "Version: \(version) (\(build))"
    }
}
