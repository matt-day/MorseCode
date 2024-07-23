//
//  MorseCodeApp.swift
//  MorseCode
//
//  Created by Matt Day on 3/16/22.
//

import SwiftUI

@main
struct MorseCodeApp: App {
    @StateObject var manager = MorseManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(manager)
        }
    }
}
