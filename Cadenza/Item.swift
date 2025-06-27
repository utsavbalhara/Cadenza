//
//  Item.swift
//  Cadenza
//
//  Created by Utsav Balhara on 6/27/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
