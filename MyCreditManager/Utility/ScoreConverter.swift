//
//  ScoreConverter.swift
//  MyCreditManager
//
//  Created by Swain Yun on 2023/04/21.
//

import Foundation

struct ScoreConverter {
    private let grade = Grade.unknown
    
    @frozen private enum Grade {
        case aPlus, a, bPlus, b, cPlus, c, dPlus, d, f, unknown
        
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
            case .unknown: return -1
            }
        }
        
        func getGrade(_ grade: String) -> Grade {
            switch grade {
            case "A+": return .aPlus
            case "A": return .a
            case "B+": return .bPlus
            case "B": return .b
            case "C+": return .cPlus
            case "C": return .c
            case "D+": return .dPlus
            case "D": return .d
            case "F": return .f
            default: return .unknown
            }
        }
    }
    
    func getScore(_ grade: String) -> Double {
        return self.grade.getGrade(grade).score
    }
}
