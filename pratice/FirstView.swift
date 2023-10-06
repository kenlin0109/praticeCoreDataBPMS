//
//  firstView.swift
//  pratice
//
//  Created by 林秀謙 on 2023/10/6.
//

import Foundation
import SwiftUI

struct FirstView: View {
    @State var show = false
    
    var body: some View{
        ZStack {
            if !show {
                VStack {
                    Text("SwiftUI")
                        .font(.largeTitle).fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(20)
                .foregroundColor(.white)
                .background(
                    Color.red
                )
            } else {
                VStack {
                    Spacer()
                    Text("SwiftUI")
                        .font(.largeTitle).fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(20)
                .foregroundColor(.white)
                .background(
                    Color.blue
                )
            }
        }
        .onTapGesture {
            withAnimation {
                show.toggle()
            }
        }
    }
}
