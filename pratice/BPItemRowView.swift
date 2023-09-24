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
    @State var item: BPItem
    
    var body: some View {
        HStack {
            Text("\(item.mdate!,formatter: itemFormatter)")
                .font(.headline)
            Spacer()
            Text("\(item.sbp)")
                .font(.title2)
                .foregroundColor(Const.GetSBPFontColor(item.sbp))
            Spacer()
            Text("\(item.dbp)")
                .font(.title2)
                .foregroundColor(Const.GetDBPFontColor(item.dbp))
           
        }
    }
}
