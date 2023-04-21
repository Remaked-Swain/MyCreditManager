//
//  Score.swift
//  MyCreditManager
//
//  Created by Swain Yun on 2023/04/21.
//

import Foundation

struct ScoreConverter {
    @frozen private enum Grade {
        case aPlus, a, bPlus, b, cPlus, c, dPlus, d, f
        
        var value: Double {
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
    
    func convertGradeToScore(_ grade: String) -> Double {
        switch grade {
        case "A+": return Grade.aPlus.value
        case "A": return Grade.a.value
        case "B+": return Grade.bPlus.value
        case "B": return Grade.b.value
        case "C+": return Grade.cPlus.value
        case "C": return Grade.c.value
        case "D+": return Grade.dPlus.value
        case "D": return Grade.d.value
        default: return Grade.f.value
        }
    }
}
