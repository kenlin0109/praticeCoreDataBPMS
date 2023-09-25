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
    func hyperten() -> String {
        var hyperText = ""
        if (item.sbp >= 140  && item.dbp >= 90) {
            hyperText = "高血壓"
        }else if (item.sbp > 139 && item.sbp < 160 && item.dbp < 89 && item.dbp < 100) {
            hyperText = "高血壓第一期"
        }else if(item.sbp > 159 && item.sbp < 180 || item.dbp > 99 && item.dbp < 110){
            hyperText = "高血壓第二期"
        }else if(item.sbp >= 180){
            hyperText = "高血壓第三期"
        }else{
            hyperText = "正常"
        }
        return(hyperText)
    }
    
    func hypertenColor() -> Color {
        var hyperText = Color("")
        if (item.sbp >= 140  && item.dbp >= 90) {
            hyperText = Color(.yellow)
        }else if (item.sbp > 139 && item.sbp < 160 && item.dbp < 89 && item.dbp < 100) {
            hyperText = Color(.orange)
        }else if(item.sbp > 159 && item.sbp < 180 || item.dbp > 99 && item.dbp < 110){
            hyperText = Color(.brown)
        }else if(item.sbp >= 180){
            hyperText = Color(.red)
        }else{
            hyperText = Color(.blue)
        }
        return(hyperText)
    }
    
    var body: some View {
        
            List {
                Text("量測時間 \t \(item.mdate!, formatter: itemFormatter)")
                Text("收縮壓 \t \(item.sbp)")
                    .foregroundColor(Const.GetSBPFontColor(item.sbp))
                Text("舒張壓 \t \(item.dbp)")
                    .foregroundColor(Const.GetDBPFontColor(item.dbp))
                Text("狀態 \t \t \(hyperten())")
                    .foregroundColor(hypertenColor())
            }
            
        
        
    }
}

