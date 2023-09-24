//
//  DetailView.swift
//  pratice
//
//  Created by 林秀謙 on 2023/9/24.
//

import Foundation
import SwiftUI
import CoreData

struct DetailView : View{
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var item: BPItem
    @State var isReadMode: Bool = true
    @State var editMdate = Date()
    @State var editSBP = Const.SBPNormal
    @State var editDBP = Const.DBPNormal
    
    var body: some View {
        VStack{
            if isReadMode {
                ReadView(item: item)
                
            } else {
                List {
                    DatePicker(selection: $editMdate, label: { Text("量測時間") })
                        .onAppear { editMdate = item.mdate! } //進入頁面時將預設數值填入
                    
                    Picker("收縮壓", selection: $editSBP,content:  {
                        ForEach(Const.SBPMin ..< Const.SBPMax) { n in
                            Text("\(n)").tag(n)
                        }
                    })
                    .onAppear { editSBP = item.sbp } //進入頁面時將預設數值填入
                    
                    Picker("舒張壓", selection: $editDBP,content:  {
                        ForEach(Const.DBPMin ..< Const.DBPMax) { n in
                            Text("\(n)").tag(n)
                        } })
                    .onAppear { editDBP = item.dbp } //進入頁面時將預設數值填入
                    
                }
                
            }
            
            
        }.toolbar {
            Button{
                if !isReadMode {
                    
                    item.mdate = editMdate
                    item.sbp = editSBP
                    item.dbp = editDBP
                    
                    do {
                        try viewContext.save()
                    } catch {
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                }
                
                isReadMode = !isReadMode
            } label: {
                Text(isReadMode ? "Edit" : "Save")
            }
        }
    }
}


