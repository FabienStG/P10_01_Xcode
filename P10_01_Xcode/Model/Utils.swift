//
//  Utils.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 30/11/2021.
//

import Foundation
//
// MARK: - Extention Int
//
extension Int {

    func noteReturn () -> String {
        if (self == 0) {
            return "N/A"
        }
        return String(self)
    }
    
    func inHours() -> String {
        if (self == 0) {
            return "N/A"
        }
        let (h, m) = (self / 60, self % 60)
        if h == 0 {
            return "\(m)m"
        }
        return "\(h)h\(m)"
    }
}

//
// MARK: - Mode
//
enum Mode {
    
    case online, offline
}

//
// MARK: - RequestStatus
//
enum RequestStatus {
    
    case initial, following
}
