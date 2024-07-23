//
//  ContentView.swift
//  MorseCode
//
//  Created by Matt Day on 3/16/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack{
                Text("Morse Code")
                    .padding(5)
                    .font(.system(size: 35, weight: .bold, design: .serif))
                List {
                    NavigationLink(destination: StudyView(), label: {
                        Label("Study Morse", systemImage: "books.vertical")
                    })
                    
                    NavigationLink(destination: DecodeView(), label: {
                        Label("Decode Morse", systemImage: "person.wave.2.fill")
                    })
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
