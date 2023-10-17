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
    @State var bpdarr = [String]()
    @State var mindbp: Int32 = 120
    @State var maxsbp: Int32 = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Chart {
                    ForEach(Array(bpdarr.enumerated()), id: \.offset) { index, key in
//                  ForEach(Array(bpdict.keys.sorted(by: >).enumerated()), id: \.offset) { index, key in
                        //ForEach (bpdict.keys.sorted(by: >), id:\.self) { key in
                        LineMark(
                            x: .value("date", index),
                            y: .value("sbp", bpdict[key]?.sbp ?? 0)
                        )
                        //                        .foregroundStyle(.blue)
                        .foregroundStyle(by: .value("Type", "\(language.isZhorEn ? "SBP" : "收縮壓")"))
                        
                        PointMark(
                            x: .value("date", index),
                            y: .value("sbp", bpdict[key]?.sbp ?? 0)
                        )
                        //                       .foregroundStyle(.blue)
                        .annotation {
                            Text("\(bpdict[key]?.sbp ?? 0)")  //  \(bpdict[key]?.mdate ?? Date(), formatter: MMddFormatter)
                        }
                        
                        
                        LineMark(
                            x: .value("date", index),
                            y: .value("dbp", bpdict[key]?.dbp ?? 0)
                        )
                        //                      .foregroundStyle(.green)
                        .foregroundStyle(by: .value("Type", "\(language.isZhorEn ? "DBP" : "舒張壓")"))
                        
                        PointMark(
                            x: .value("date", index),
                            y: .value("sbp", bpdict[key]?.dbp ?? 0)
                        )
                        .foregroundStyle(Color.green)
                        .annotation {
                            Text("\(bpdict[key]?.dbp ?? 0)")
                        }
                        
                        LineMark(
                            x: .value("date", index),
                            y: .value("sbp", 120)
                        )
                        //                        .foregroundStyle(.blue)
                        .foregroundStyle(by: .value("Type", "\(language.isZhorEn ? "standand SBP" : "標準收縮壓")"))
                        
                        LineMark(
                            x: .value("date", index),
                            y: .value("dbp", 80)
                        )
                        //                        .foregroundStyle(.blue)
                        .foregroundStyle(by: .value("Type", "\(language.isZhorEn ? "standand DBP" : "標準舒張壓")"))
                    }
                }
                .chartXAxis{
                    //                    AxisMarks(values: .stride(by: .day)) { value in
                    AxisMarks(values: .stride(by: 1)) { value in
                        
                        AxisGridLine()
                        AxisValueLabel{
                            if let localIndex = value.as(Int.self) {
                                if localIndex>=0 && localIndex<bpdict.count {
                                    //                            if let localDate = bpdict[value]?.mdate! {
                                    //                                let formattedDate = MMddFormatter.string(from: localDate)
                                    //                                Text(formattedDate)
                                    let key = bpdarr[localIndex]
                                    if let localDate = bpdict[key]?.mdate {
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
                }
            }
            .chartYScale(domain: [mindbp-8, maxsbp+8])
            .navigationTitle(language.isZhorEn ? "Statistics" : "統計")
            .foregroundColor(Color.blue)
            .padding(20)
            
            //Spacer()
        }
        .onAppear {
            filterdata()
            bpdarr = bpdict.keys.sorted(by: <)
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
        
        let mindate = Calendar.current.date(byAdding: .day, value: -140, to: Date())
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
        if mindbp==120 { mindbp = 50 }
        if maxsbp==0 { maxsbp = 120 }
    }
}

let MMddFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd"
    return formatter
}()

