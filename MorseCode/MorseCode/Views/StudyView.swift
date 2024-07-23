//
//  StudyView.swift
//  MorseCode
//
//  Created by Matt Day on 3/16/22.
//

import SwiftUI

struct StudyView: View {
    @EnvironmentObject var manager : MorseManager
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(manager.model.morseArr, id:\.self) { key in
                    FlipMorseCardView(front: key, back: manager.model.morseDict[key]!)
                }
            }
        }
        .navigationTitle("Study Morse")
    }
}

//struct FlipMorseCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        FlipMorseCardView()
//    }
//}
