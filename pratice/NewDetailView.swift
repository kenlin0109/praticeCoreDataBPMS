//
//  EditDetailView.swift
//  pratice
//
//  Created by 林秀謙 on 2023/9/24.
//

import Foundation
import CoreData
import SwiftUI

struct NewDetailView : View{
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    
    @State var editMdate = Date()
    @State var editSBP = Const.SBPNormal
    @State var editDBP = Const.DBPNormal
    
    var body: some View {
        List {
            DatePicker(selection: $editMdate, label: { Text("量測時間") })
            
            
            Picker("收縮壓", selection: $editSBP) {
                ForEach(Const.SBPMin..<Const.SBPMax) { n in
                    Text("\(n)").tag(n)
                }
            }
            
            
            Picker("舒張壓", selection: $editDBP)  {
                ForEach(Const.DBPMin..<Const.DBPMax) { n in
                    Text("\(n)").tag(n)
                }
            }
            .toolbar {
                Button("Save") {
                    @State var newItem = BPItem(context: viewContext)
                    newItem.mdate = editMdate
                    newItem.sbp = editSBP
                    newItem.dbp = editDBP
                    
                    do {
                        try viewContext.save()
                    } catch {
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                    self.presentationMode.wrappedValue.dismiss()
                }
                
            }
        }
    }
}

