//
//  FormatterCollection.swift
//  pratice
//
//  Created by 林秀謙 on 2023/9/24.
//

import Foundation

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
    return formatter
}()


