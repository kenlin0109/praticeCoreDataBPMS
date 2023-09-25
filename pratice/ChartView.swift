import SwiftUI
import CoreData
import Charts

struct ChartView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BPItem.mdate, ascending: false)],
        animation: .default)
    private var items: FetchedResults<BPItem>
    
    var body: some View {
        VStack{
            Text("LineChart")
                .font(.title)
                .foregroundColor(Color.blue)
            Chart {
                ForEach(items) { item in
                    let index = items.firstIndex(of: item)
                    
                    LineMark(x: .value("date", index!),
                             y: .value("sbp", item.sbp)
                    )
                    .foregroundStyle(.red)
                    .foregroundStyle(by: .value("Type", "SBP"))
                    
                    PointMark(
                        x: .value("date", index!),
                        y: .value("sbp", item.sbp)
                    )
                    .foregroundStyle(.red)
                    .annotation {
                        Text("\(item.sbp)")
                    }
                    
                    LineMark(x: .value("date", index!),
                             y: .value("dbp", item.dbp)
                    )
                    .foregroundStyle(.blue)
                    .foregroundStyle(by: .value("Type", "DBP"))
                    
                    PointMark(
                        x: .value("date", index!),
                        y: .value("sbp", item.dbp)
                    )
                    .foregroundStyle(Color.blue)
                    .annotation {
                        Text("\(item.dbp)")
                    }
                    
                    
                    LineMark(x: .value("date", index!),
                             y: .value("sbp", 120)
                    )
                    .foregroundStyle(by: .value("Type", "120"))
//                    .annotation {
//                        Text("120")
//                    }
                    LineMark(x: .value("date", index!),
                             y: .value("dbp", 80)
                    )
                    .foregroundStyle(by: .value("Type", "80"))
//                    .annotation {
//                        Text("80")
//                    }
                }
            }
            .chartXScale(domain: [0, items.count-1])
            .padding(15)
            //.frame(width: 350, height: 300)
            Spacer()
        }
    }
}


