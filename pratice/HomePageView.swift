//
//  ContentView.swift
//  pratice
//
//  Created by 林秀謙 on 2023/9/24.
//

import SwiftUI
import CoreData

struct HomePageView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BPItem.mdate, ascending: false)],
        animation: .default)
    private var items: FetchedResults<BPItem>
    
    var body: some View {
        NavigationView {
            VStack{
                TabView {
                    ContentView().tabItem{
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    
                    ChartView().tabItem{
                        Image(systemName: "chart.bar.doc.horizontal")
                        Text("Chart")
                    }
                    
                    Text("").tabItem{
                        Image(systemName: "gearshape.fill")
                        Text("Setting")
                    }
                }
               
            }
        }
    }
}
