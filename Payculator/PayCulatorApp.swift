//
//  PayCulatorApp.swift
//  PayCulator
//
//  Created by Kelvin Reid on 2/28/24.
//

import SwiftUI

@main
struct PayCulatorApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SalaryCalculatorView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
