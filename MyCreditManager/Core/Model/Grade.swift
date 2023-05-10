//
//  Grade.swift
//  MyCreditManager
//
//  Created by Swain Yun on 2023/05/10.
//

import Foundation

@frozen enum Grade {
    case aPlus, a, bPlus, b, cPlus, c, dPlus, d, f
    
    var score: Double {
        switch self {
        case .aPlus: return 4.5
        case .a: return 4
        case .bPlus: return 3.5
        case .b: return 3
        case .cPlus: return 2.5
        case .c: return 2
        case .dPlus: return 1.5
        case .d: return 1
        case .f: return 0
        }
    }
}
