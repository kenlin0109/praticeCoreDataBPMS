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
    @EnvironmentObject var language: LanguageTheme
    
    @State var editMdate = Date()
    @State var editSBP = Const.SBPNormal
    @State var editDBP = Const.DBPNormal
    
    var body: some View {
        List {
            DatePicker(selection: $editMdate, label: { Text(language.isZhorEn ? "Measurement time" : "量測時間") })
            
            Picker(language.isZhorEn ? "SBP" : "收縮壓", selection: $editSBP) {
                ForEach(Const.SBPMin..<Const.SBPMax) { n in
                    Text("\(n)").tag(n)
                }
            }
            Picker(language.isZhorEn ? "DBP" : "舒張壓", selection: $editDBP)  {
                ForEach(Const.DBPMin..<Const.DBPMax) { n in
                    Text("\(n)").tag(n)
                }
            }
            .toolbar {
                Button(language.isZhorEn ? "Save" : "儲存") {
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

