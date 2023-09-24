//
//  BPItem+CoreDataProperties.swift
//  pratice
//
//  Created by 林秀謙 on 2023/9/24.
//
//

import Foundation
import CoreData


extension BPItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BPItem> {
        return NSFetchRequest<BPItem>(entityName: "BPItem")
    }

    @NSManaged public var mdate: Date?
    @NSManaged public var sbp: Int
    @NSManaged public var dbp: Int

}

extension BPItem : Identifiable {

}
