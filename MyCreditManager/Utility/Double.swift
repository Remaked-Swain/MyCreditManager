//
//  String.swift
//  MyCreditManager
//
//  Created by Swain Yun on 2023/04/21.
//

import Foundation

extension Double {
    private var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
    func asStringWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return formatter.string(from: number) ?? ""
    }
}
