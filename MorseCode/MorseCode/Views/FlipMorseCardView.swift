//
//  FlipMorseCardView.swift
//  MorseCode
//
//  Created by Matt Day on 3/16/22.
//

import SwiftUI

struct FlipMorseCardView: View {
    @EnvironmentObject var manager : MorseManager
    
    enum DraggingState {
        case right, left
    }
    
    @State private var degrees  : Double = 0.0  // rotation angle
    @State private var swiping  = DraggingState.left //swipe direction
    
    var front : String
    var back : String
    
    let bgColorFront = Color.blue
    let bgColorBack = Color.orange
    
    let frontDegrees : Double = 0.0
    let backDegrees : Double = -180.0
    let midDegrees : Double = -90.0
    
    var isShowingBack : Bool {degrees < midDegrees}
    var bgImageColor : Color {isShowingBack ? bgColorBack : bgColorFront}
    var flipDegree : Double {isShowingBack ? backDegrees : frontDegrees}

    var body: some View {
        
        let swipe = DragGesture()
            .onChanged { v in
                let translation = Double(v.translation.width)
                switch swiping {
                case .right:
                    degrees = rotationDegreesFor(translation + backDegrees)
                case .left:
                    degrees = rotationDegreesFor(translation)
                }
            }
            .onEnded { v in
                if isShowingBack {
                    swiping = .right
                    withAnimation {
                        degrees = backDegrees
                    }
                } else {
                    swiping = .left
                    withAnimation {
                        degrees = frontDegrees
                    }
                }
            }
                    
        return Text(isShowingBack ? front : back)
                .background {
                    Rectangle()
                        .fill(bgImageColor)
                        .frame(width: 300, height: 150, alignment: .center)
                        .padding(100)
                }
                .font(.system(size: 25, weight: .bold, design: .rounded))
                .frame(width: 300, height: 150, alignment: .center)
            
                .rotation3DEffect(Angle(degrees: flipDegree), axis: (0,1,0))
                .rotation3DEffect(Angle(degrees: degrees), axis: (0,1,0))

                .gesture(swipe)
    }
    


  // Rotation should be between 0 and -180
    func rotationDegreesFor(_ translation: Double) -> Double {
        if translation > frontDegrees {
            return  frontDegrees
        } else if translation < backDegrees {
            return  backDegrees
        } else {
            return translation
        }
    }
}

//struct StudyView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudyView()
//    }
//}
