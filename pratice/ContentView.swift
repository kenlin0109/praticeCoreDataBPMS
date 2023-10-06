//
//  ContentView.swift
//  pratice
//
//  Created by 林秀謙 on 2023/9/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BPItem.mdate, ascending: false)],
        animation: .default)
    private var items: FetchedResults<BPItem>
    
    @EnvironmentObject var language: LanguageTheme
    
    var body: some View {
        NavigationView {
            VStack{
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            DetailView(item: item)
                        } label: {
                            BPItemRowView(item: item)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItem {
                        NavigationLink {
                            NewDetailView()
                        } label: {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
            }
            .navigationTitle(language.isZhorEn ? "History" : "紀錄")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


