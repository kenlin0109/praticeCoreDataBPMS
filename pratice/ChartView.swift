import SwiftUI
import CoreData
import Charts

struct bpinfo {
    public var mdate: Date
    public var sbp: Int
    public var dbp: Int
}

struct ChartView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject var language: LanguageTheme
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BPItem.mdate, ascending: false)],
        animation: .default)
    private var items: FetchedResults<BPItem>
    
    @State var bpdict = [String: bpinfo]()
    @State var mindbp: Int32 = 120
    @State var maxsbp: Int32 = 0
    
    var body: some View {
        
            VStack {
                Text(language.isZhorEn ? "Statistics" : "統計")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                Chart {
                    ForEach(Array(bpdict.keys.sorted(by: >).enumerated()), id: \.offset) { index, key in
                        //ForEach (bpdict.keys.sorted(by: >), id:\.self) { key in
                        LineMark(
                            x: .value("date", bpdict[key]?.mdate ?? Date()),
                            y: .value("sbp", bpdict[key]?.sbp ?? 0)
                        )
                        .foregroundStyle(.red)
                        .foregroundStyle(by: .value("Type", "SBP"))
                        
                        PointMark(
                            x: .value("date", bpdict[key]?.mdate ?? Date()),
                            y: .value("sbp", bpdict[key]?.sbp ?? 0)
                        )
                        .foregroundStyle(.red)
                        .annotation {
                            Text("\(bpdict[key]?.sbp ?? 0)")
                        }
                        
                        LineMark(
                            x: .value("date", bpdict[key]?.mdate ?? Date()),
                            y: .value("dbp", bpdict[key]?.dbp ?? 0)
                        )
                        .foregroundStyle(.blue)
                        .foregroundStyle(by: .value("Type", "DBP"))
                        
                        PointMark(
                            x: .value("date", bpdict[key]?.mdate ?? Date()),
                            y: .value("sbp", bpdict[key]?.dbp ?? 0)
                        )
                        .foregroundStyle(Color.blue)
                        .annotation {
                            Text("\(bpdict[key]?.dbp ?? 0)")
                        }
                    }
                }
                .chartXAxis{
                    AxisMarks(values: .stride(by: .day)) { value in
                        AxisGridLine()
                        AxisValueLabel{
                            if let localDate = value.as(Date.self) {
                                let formattedDate = MMddFormatter.string(from: localDate)
                                Text(formattedDate)
                                    .font(.system(size: 12))
                                    .foregroundColor(Color.black)
                                    .rotationEffect(Angle(degrees: 40))
                            }
                        }
                    }
                }
            }
            .chartYScale(domain: [mindbp-8, maxsbp+8])
            .navigationTitle(language.isZhorEn ? "Statistics" : "統計")
            .foregroundColor(Color.blue)
            .padding(20)
            
            //Spacer()
        
        .onAppear {
            filterdata()
            //            let formatter = DateFormatter()
            //            formatter.dateFormat = "yyyy/MM/dd"
            //
            //            for item in items {
            //                let mdate = formatter.string(from: item.mdate!)
            //                let sbp = item.sbp
            //                let dbp = item.dbp
            //                if let oldData = bpdict[mdate] {
            //                    let oldSBP = oldData.sbp
            //                    let oldDBP = oldData.dbp
            //                    bpdict[mdate] = bpinfo(mdate: item.mdate!, sbp: (oldSBP+sbp)/2, dbp: (oldDBP+dbp)/2)
            //                } else {
            //                    bpdict[mdate] = bpinfo(mdate: item.mdate!, sbp: sbp, dbp: dbp)
            //                }
            //            }
        }
    }
    
    func filterdata() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        let mindate = Calendar.current.date(byAdding: .day, value: -14, to: Date())
        let today = Date()
        for item in items {
            if item.mdate!>mindate! && item.mdate!<today {
                
                let mdate = formatter.string(from: item.mdate!)
                let sbp = item.sbp
                let dbp = item.dbp
                
                if dbp < mindbp { mindbp = Int32(dbp) }
                if sbp > maxsbp { maxsbp = Int32(sbp) }
                
                if let oldData = bpdict[mdate] {
                    let oldSBP = oldData.sbp
                    let oldDBP = oldData.dbp
                    bpdict[mdate] = bpinfo(mdate: item.mdate!, sbp: (oldSBP+sbp)/2, dbp: (oldDBP+dbp)/2)
                } else {
                    bpdict[mdate] = bpinfo(mdate: item.mdate!, sbp: sbp, dbp: dbp)
                }
            }
        }
    }
}

let MMddFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd"
    return formatter
}()

