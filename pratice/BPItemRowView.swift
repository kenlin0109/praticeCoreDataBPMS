//
//  BPItemRowView.swift
//  pratice
//
//  Created by 林秀謙 on 2023/9/24.
//

import Foundation
import SwiftUI

struct BPItemRowView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var item: BPItem
    
    var body: some View {
        HStack {
          
                Text("\(item.mdate ?? Date(),formatter: itemFormatter)")
                    .font(.headline)
                
                Spacer()
                Text("\(item.sbp)")
                    .font(.title3)
                    .foregroundColor(Const.GetSBPFontColor(item.sbp))
                    .padding(.trailing, 5)
                
                Text("\(item.dbp)")
                    .font(.title3)
                    .foregroundColor(Const.GetDBPFontColor(item.dbp))
                    .frame(width: 50, alignment: .trailing)
                
           
            
        }
    }
}
