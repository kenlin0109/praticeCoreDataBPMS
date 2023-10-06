//
//  ContentView.swift
//  pratice
//
//  Created by 林秀謙 on 2023/9/24.
//

import SwiftUI
import CoreData
//1. 改用文檔
//2. 統計Ｘ軸
struct HomePageView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BPItem.mdate, ascending: false)],
        animation: .default)
    private var items: FetchedResults<BPItem>
    
    @EnvironmentObject var theme: Theme
    @EnvironmentObject var language: LanguageTheme
    @State var show = false
    
    var body: some View {
        NavigationView {
            VStack{
                TabView {
                    ContentView().tabItem{
                        //.environment(isDarkMode ? (\.colorScheme,.dark):(\.colorScheme,.default) )
                        //preferredColorScheme(isDarkMode ? .dark : .light)
                        //.preferredColorScheme(.dark)
                        Image(systemName: "house.fill")
                        Text(language.isZhorEn ? "Home" : "首頁")
                    }
                    ChartView().tabItem{
                        Image(systemName: "chart.bar.doc.horizontal")
                        Text(language.isZhorEn ? "Chart" : "圖表")
                    }
                    SettingsView().tabItem{
                        Image(systemName: "gearshape.fill")
                        Text(language.isZhorEn ? "Setting" : "設定")
                    }
                    FirstView().tabItem{
                        Image(systemName: "hexagon.fill")
                        Text("測試")
                    }
                    AnimationView().tabItem{
                        Image(systemName: "octagon.fill")
                        Text("測試2")
                    }
                }
                .preferredColorScheme(theme.isDarkMode ? .dark : .light)
            }
        }
    }
}
