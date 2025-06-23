//
//  ContentView.swift
//  BetterRest
//
//  Created by warren su on 6/21/25.
//

import SwiftUI
import CoreML
struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeUpTime
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    private var increment:String {
        coffeeAmount == 1 ? " cup" : " cups"
    }
    static var defaultWakeUpTime: Date {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    var body: some View {
        NavigationStack {
            Form {
                VStack (alignment: .leading, spacing: 0){
                    Text("When do you want to wake up?").font(.headline)
                    
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute).labelsHidden()
                }
                VStack(alignment: .leading, spacing: 0){
                    Text("Desired amount of sleep").font(.headline)
                    
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                VStack(alignment: .leading, spacing: 0){
                    Text("Daily coffee intake").font(.headline)
                    
                    Picker(selection: $coffeeAmount, label: Text("\(coffeeAmount) \(increment)"), content:{ForEach(1...20, id: \.self)
                        {Text("\($0)")}})
                    
                    //Stepper("\(coffeeAmount) \(increment)", value: $coffeeAmount, in: 1...20)
                }.onAppear() {
                    calculateBedtime()
                }
                VStack(alignment: .leading, spacing: 25){
                    Text(alertTitle)
                    Text(alertMessage).font(.system(size: 35))
                }.padding()
                
                
            }
            .navigationTitle("BetterRest")
            //.toolbar{
            //    Button("Calculate", action: calculateBedtime)
            
        
        }
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch{
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime"
            
        }
        showingAlert = true
    }
    

}

#Preview {
    ContentView()
}
