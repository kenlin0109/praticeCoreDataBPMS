//
//  ReadView.swift
//  pratice
//
//  Created by 林秀謙 on 2023/9/24.
//

import Foundation
import SwiftUI
import CoreData

struct ReadView : View{
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State var item: BPItem
    
    
    var body: some View {
        
            List {
                Text("量測時間 \t \(item.mdate!, formatter: itemFormatter)")
                Text("收縮壓 \t \(item.sbp)")
                Text("舒張壓 \t \(item.dbp)")
            }
            
        
        
    }
}

