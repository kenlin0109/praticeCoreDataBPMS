//
//  AnimationView.swift
//  pratice
//
//  Created by 林秀謙 on 2023/10/6.
//

import Foundation
import SwiftUI

struct AnimationView : View {
    
    @State private var expand = false
    @State private var moveDistance: Double = 0
    @State private var opacity: Double = 1
    
    var body: some View {
        VStack {
            Button("奔跑吧") {
                moveDistance += 20
                opacity -= 0.05
            }
            .font(.title)
            HStack {
                Circle()
                    .fill(Color.green)
                    .frame(width: 150, height: 150)
                    .offset(x: moveDistance)
                    .opacity(opacity)
                    .animation(.default, value: opacity)
                    .animation(.default, value: moveDistance)
                Spacer()
            }
        }
        
        
        
        
        
        
        
        
        
        //        Circle()
        //            .fill(Color.green)
        //            .frame(width: expand ? 300 : 150, height: expand ? 300 : 150)
        //            .offset(y: expand ? -200 : 0)
        //            .animation(.easeOut, value: opacity)
        //            .onTapGesture {
        //                self.expand.toggle()
        //            }
        
    }
}
