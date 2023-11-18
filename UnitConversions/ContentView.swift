import SwiftUI

struct ContentView: View {
    @FocusState private var inputIsFocused: Bool
    
    @State private var inputNumber = 0.0
    @State private var inputUnit = ""
    @State private var outputUnit = ""
    
    let unitMassive = ["seconds", "minutes", "hours"]
    
    func outputNumber() -> Double {
        var result = 0.0
        if inputUnit == "seconds", outputUnit == "seconds" {
            result = inputNumber
        } else if inputUnit == "seconds", outputUnit == "minutes" {
            result = inputNumber / 60
        } else if inputUnit == "seconds", outputUnit == "hours" {
            result = inputNumber / 360
        }
        
        if inputUnit == "minutes", outputUnit == "seconds" {
            result = inputNumber * 60
        } else if inputUnit == "minutes", outputUnit == "minutes" {
            result = inputNumber
        } else if inputUnit == "minutes", outputUnit == "hours" {
            result = inputNumber / 60
        }
        
        if inputUnit == "hours", outputUnit == "seconds" {
            result = inputNumber * 360
        } else if inputUnit == "hours", outputUnit == "minutes" {
            result = inputNumber * 60
        } else if inputUnit == "hours", outputUnit == "hours" {
            result = inputNumber
        }
        return result
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section ("Input number") {
                    TextField ("Input number", value: $inputNumber, format: .number)
                }
                .keyboardType(.decimalPad)
                .focused($inputIsFocused)
                
                Section ("Choose input unit") {
                    Picker ("Input Unit", selection: $inputUnit) {
                        ForEach(unitMassive, id: \.self) {
                            Text("You choose: \($0)")
                        }
                    }
                }
                
                Section ("Choose output unit") {
                    Picker ("Output Unit", selection: $outputUnit) {
                        ForEach(unitMassive, id: \.self) {
                            Text("You choose: \($0)")
                        }
                    }
                }
                
                Section ("Output number")  {
                    Text ("\(outputNumber().formatted())")
                }
            }
            .navigationTitle("UnitConversions")
            .toolbar {
                if inputIsFocused {
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
