//
//  CellInfo.swift
//  NOADance
//
//  Created by Jack on 2022/05/09.
//

import Foundation

enum CellInfoType {
    case title
    case content
    case image
    case combine
}

struct CellInfo: Identifiable, Comparable {
    static func < (lhs: CellInfo, rhs: CellInfo) -> Bool {
        lhs.id.hashValue < rhs.id.hashValue
    }
    
    static func == (lhs: CellInfo, rhs: CellInfo) -> Bool {
        lhs.id == rhs.id
    }
    
    let type: CellInfoType
    var value: Any
    var subValue: Any? = nil
    var tag: String? = nil
    let id = UUID()
}
