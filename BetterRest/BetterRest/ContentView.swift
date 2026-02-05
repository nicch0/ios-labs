//
//  ContentView.swift
//  BetterRest
//
//  Created by niccho on 2/11/2025.
//



//One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try extending this app to make sure you fully understand what’s going on:
//
//    Replace each VStack in our form with a Section, where the text view is the title of the section. Do you prefer this layout or the VStack layout? It’s your app – you choose!
//    Replace the “Number of cups” stepper with a Picker showing the same range of values.
//    Change the user interface so that it always shows their recommended bedtime using a nice and large font. You should be able to remove the “Calculate” button entirely.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var predictedWakeUpTime: String? {
        // “wake”: when the user wants to wake up. This is expressed as the number of seconds from midnight, so 8am would be 8 hours multiplied by 60 multiplied by 60, giving 28800.
        //  “estimatedSleep”: roughly how much sleep the user wants to have, stored as values from 4 through 12 in quarter increments.
        //  “coffee”: roughly how many cups of coffee the user drinks per day.

        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hourInSeconds = (components.hour ?? 0) * 60 * 60
            let minuteInSeconds = (components.minute ?? 0) * 60
            let wakeUpTimeInSeconds = Double(hourInSeconds + minuteInSeconds)
            
            let prediction = try model.prediction(wake: wakeUpTimeInSeconds, estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
        
            return sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return nil
        }
    }
    
    
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    DatePicker(
                        "Please enter a time",
                        selection: $wakeUp,
                        displayedComponents: .hourAndMinute
                    )
                        .labelsHidden()
                    
                } header: {
                    Text("When do you want to wake up?")
                        .font(.headline)
                }
                
                Section {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    
                } header: {
                    Text("How much sleep do you want?")
                        .font(.headline)
                }
                
                Section {
//                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 0...5, step: 1)
                    Picker(
                        "^[\(coffeeAmount) cup](inflect: true)",
                        selection: $coffeeAmount
                    ) {
                        ForEach(0..<6) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much coffee do you drink daily?")
                        .font(.headline)
                }
                
                Text("Your ideal bedtime is: \(predictedWakeUpTime ?? "Error")")
                    .font(.title3)
                
            }
            .navigationTitle("BetterRest")
        }
        

    }
    
    
}

#Preview {
    ContentView()
}

