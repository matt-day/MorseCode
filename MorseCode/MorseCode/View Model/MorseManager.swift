//
//  MorseManager.swift
//  MorseCode
//
//  Created by Matt Day on 3/16/22.
//

import Foundation
import SwiftUI

class MorseManager : ObservableObject {
    @Published var model = MorseModel()
    
    @Published var decodeColor: Color = .green
    
    @Published var hideTap = 1.0
    @Published var transText = ""
    @Published var morseText = ""
    
    func checkMorse(seq: String) -> String{
        for i in model.morseDict {
            if seq == i.value {
                decodeColor = .green
                return i.key
            }
        }
        decodeColor = .red
        return ""
    }
    
    weak var timer: Timer?
    
    func timeStart() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(fireTimer(_:)), userInfo: nil, repeats: false)
    }
    
    func timeStop() {
        timer?.invalidate()
    }

    
    @objc func fireTimer(_ timer: Timer) {
        hideTap = 1
        transText += checkMorse(seq: morseText)
        morseText = ""
    }
    
}
