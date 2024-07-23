//
//  DecodeView.swift
//  MorseCode
//
//  Created by Matt Day on 3/16/22.
//

import SwiftUI

struct DecodeView: View {
    @EnvironmentObject var manager : MorseManager
    
    let defaultText = "TAP / HOLD"
    
    @GestureState var isDetectingTap = false
    @GestureState var isDetectingLongPress = false

    func fireTimer(_ timer: Timer) {
        manager.hideTap = 1
        manager.transText += manager.checkMorse(seq: manager.morseText)
        manager.morseText = ""
    }
        
    var body: some View {
        
        let tapGes = TapGesture()
            .onEnded{
                manager.timeStop()
                manager.hideTap = 0
                manager.decodeColor = .orange
                manager.morseText += "."
            }
        
        let longPress = LongPressGesture()
            .onEnded { value in
                manager.timeStop()
                manager.hideTap = 0
                manager.decodeColor = .orange
                manager.morseText += "-"
            }
        
        let morseInteract = tapGes.exclusively(before: longPress)
            .onEnded { value in
                manager.timeStart()
            }
        
        return VStack {
            Button(action: {
                manager.timeStop()
                manager.transText = ""
                manager.morseText = ""
                manager.decodeColor = .green
                manager.hideTap = 1.0
            }, label: {
                Label("Clear Message", systemImage: "trash")
            })
                .padding(10)
            
            Text(manager.transText)
                .background {
                    Rectangle()
                        .fill(.blue)
                        .frame(width: 300, height: 150, alignment: .center)
                }
                .padding(5)
                .font(.system(size: 25, weight: .bold, design: .rounded))
                .frame(width: 300, height: 150, alignment: .center)

            ZStack{
                Text(manager.morseText)
                    .background {
                        Rectangle()
                            .fill(.blue)
                            .frame(width: 300, height: 150, alignment: .center)
                    }
                    .padding(5)
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .frame(width: 300, height: 150, alignment: .center)
                    .gesture(morseInteract)
                    
                Text(defaultText)
                    .padding(5)
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .frame(width: 300, height: 150, alignment: .center)
                    .opacity(manager.hideTap)
                    .gesture(morseInteract)
            }
            
            Button(action: {
                manager.timeStop()
                manager.hideTap = 1
                manager.transText += manager.checkMorse(seq: manager.morseText)
                manager.morseText = ""
            }, label: {
                Text("Decode")
                    .background {
                        Capsule()
                            .fill(manager.decodeColor)
                            .frame(width: 100, height: 50, alignment: .center)
                    }
                    .padding(5)
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            })
                .padding(10)
        }
        .navigationTitle("Decode Morse")
    }
}

struct DecodeView_Previews: PreviewProvider {
    static var previews: some View {
        DecodeView()
    }
}
