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
    
    @EnvironmentObject var language: LanguageTheme
    
    
    
    func hyperten() -> String {
        var hyperText = ""
        if (item.sbp >= 140 && item.dbp >= 90) {
            hyperText = language.isZhorEn ? "Hypertension" : "高血壓"
        }else if (item.sbp > 139 && item.sbp < 160 && item.dbp < 89 && item.dbp < 100) {
            hyperText = language.isZhorEn ? "Hypertension I" : "高血壓第一期"
        }else if(item.sbp > 159 && item.sbp < 180 || item.dbp > 99 && item.dbp < 110) {
            hyperText = language.isZhorEn ? "Hypertension II" : "高血壓第二期"
        }else if(item.sbp >= 180){
            hyperText = language.isZhorEn ? "Hypertension III" : "高血壓第三期"
        }else{
            hyperText = language.isZhorEn ? "Normal" : "正常"
        }
        return(hyperText)
    }
    
    func hypertenColor() -> Color {
        var hyperText = Color("")
        if (item.sbp >= 140 && item.dbp >= 90) {
            hyperText = Color.yellow
        }else if (item.sbp > 139 && item.sbp < 160 && item.dbp < 89 && item.dbp < 100) {
            hyperText = Color.orange
        }else if(item.sbp > 159 && item.sbp < 180 || item.dbp > 99 && item.dbp < 110){
            hyperText = Color.brown
        }else if(item.sbp >= 180){
            hyperText = Color.red
        }else{
            hyperText = Color.blue
        }
        return(hyperText)
    }
    
    var body: some View {
        VStack{
            List {
                HStack{
                    Text(language.isZhorEn ? "Measurement time" : "量測時間")
                        .frame(width: 75, alignment: .leading)
                    Text("\(item.mdate!, formatter: itemFormatter)")
                }
                HStack{
                    Text(language.isZhorEn ? "SBP" : "收縮壓")
                        .frame(width: 75, alignment: .leading)
                    Text("\(item.sbp)")
                        .foregroundColor(Const.GetSBPFontColor(item.sbp))
                }
                HStack{
                    Text(language.isZhorEn ? "DBP" : "舒張壓")
                        .frame(width: 75, alignment: .leading)
                    Text("\(item.dbp)")
                        .foregroundColor(Const.GetSBPFontColor(item.dbp))
                }
                HStack{
                    Text(language.isZhorEn ? "Body condition" : "狀態")
                        .frame(width: 75, alignment: .leading)
                    Text("\(hyperten())")
                        .foregroundColor(hypertenColor())
                }
            }
            //            Text("1.先菜後肉 \r 衛生福利部指出，一天應攝取3份蔬菜（約300公克），但由於外食比例高，平均攝取量嚴重不足。高澤謙二表示，吃飯時不妨先菜後肉，不僅可增加蔬菜的食用量，豐富的植物纖維還可避免血糖急速上升，以防血管受損。")
            //                .frame(width: 325)
            //
            //            Text("")
            //
            //            Text("2.一天一和食 \r現代人飲食西化，肉類攝取量提高的同時，也帶來了過胖、膽固醇過高與心血管疾病等問題。而以魚肉為中心的日式飲食熱量較低，且富含優良蛋白質與油脂，守護血管健康。")
            //                .frame(width: 325)
        }
    }
}
