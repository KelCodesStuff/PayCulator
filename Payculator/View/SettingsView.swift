//
//  SettingsView.swift
//  PayCulator
//
//  Created by Kelvin Reid on 2/28/24.
//

import SwiftUI

struct SettingsView: View {
    var appVersion: String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return version
        }
        return "Unknown"
    }
    
    var buildNumber: String {
        if let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            return build
        }
        return "Unknown"
    }
    
    var body: some View {
        Form {
            Section(header: Text("App Info")) {
                HStack {
                    Text("App Name")
                    Spacer()
                    Text("Payculator")
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Version")
                    Spacer()
                    Text(appVersion)
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Build")
                    Spacer()
                    Text(buildNumber)
                        .foregroundColor(.gray)
                }
            }
            
            Section(header: Text("Developer")) {
                HStack {
                    Text("Name")
                    Spacer()
                    Text("Kel Reid")
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Website")
                    Spacer()
                    Text("https://github.com/KelCodesStuff/Payculator")
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView()
}
