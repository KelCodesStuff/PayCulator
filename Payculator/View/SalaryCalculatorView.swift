//
//  ContentView.swift
//  PayCulator
//
//  Created by Kelvin Reid on 2/28/24.
//

import SwiftUI
import CoreData

struct SalaryCalculatorView: View {
    @State private var hourlyRate: String = ""
    @State private var hoursWorked: String = ""
    @State private var taxPercent: String = ""
    @State private var weeklySalary: Double = 0
    @State private var biweeklySalary: Double = 0
    @State private var monthlySalary: Double = 0
    @State private var annualSalary: Double = 0
    
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input")) {
                    HStack {
                        Text("Hourly Rate")
                        Spacer()
                        TextField("0", text: $hourlyRate)
                            .keyboardType(.decimalPad)
                            .frame(width: 100) // Adjust this width as needed
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Hours Worked")
                        Spacer()
                        TextField("0", text: $hoursWorked)
                            .keyboardType(.decimalPad)
                            .frame(width: 100) // Adjust this width as needed
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Tax Percent")
                        Spacer()
                        TextField("0", text: $taxPercent)
                            .keyboardType(.decimalPad)
                            .frame(width: 100) // Adjust this width as needed
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Button("Calculate") {
                    calculateSalaries()
                }
                .foregroundColor(.green)
                .frame(maxWidth: .infinity)
                
                Section(header: Text("Results")) {
                    HStack {
                        Text("Weekly:")
                        Spacer()
                        Text("$\(weeklySalary, specifier: "%.2f")")
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Biweekly:")
                        Spacer()
                        Text("$\(biweeklySalary, specifier: "%.2f")")
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Monthly:")
                        Spacer()
                        Text("$\(monthlySalary, specifier: "%.2f")")
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Annual:")
                        Spacer()
                        Text("$\(annualSalary, specifier: "%.2f")")
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            .navigationTitle("Payculator")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                            .foregroundColor(.green)
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Input Required"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    // Function overloading
    private func calculateSalaries() {
        guard !hourlyRate.isEmpty, !hoursWorked.isEmpty, !taxPercent.isEmpty,
              let hourlyRateValue = Double(hourlyRate),
              let hoursWorkedValue = Double(hoursWorked),
              let taxPercentValue = Double(taxPercent),
              hourlyRateValue >= 0, hoursWorkedValue >= 0, taxPercentValue >= 0, taxPercentValue <= 100 else {
            alertMessage = "Fields cannot be negative and tax percent is between 0 and 100."
            showAlert = true
            return
        }
        
        let salaries = calculateSalaries(hourlyRate: hourlyRateValue, hoursWorked: hoursWorkedValue, taxPercent: taxPercentValue)
        weeklySalary = salaries.weekly
        biweeklySalary = salaries.biweekly
        monthlySalary = salaries.monthly
        annualSalary = salaries.annual
    }

    // Function overloading
    private func calculateSalaries(hourlyRate: Double, hoursWorked: Double, taxPercent: Double) -> (weekly: Double, biweekly: Double, monthly: Double, annual: Double) {
        let grossWeeklySalary = hourlyRate * hoursWorked
        let taxedWeeklySalary = grossWeeklySalary - (grossWeeklySalary * taxPercent / 100)
        let biweeklySalary = taxedWeeklySalary * 2
        let monthlySalary = taxedWeeklySalary * 4.33
        let annualSalary = taxedWeeklySalary * 52
        return (taxedWeeklySalary, biweeklySalary, monthlySalary, annualSalary)
    }
}



#Preview {
    SalaryCalculatorView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
