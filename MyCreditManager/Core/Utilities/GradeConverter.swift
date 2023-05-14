//
//  Score.swift
//  MyCreditManager
//
//  Created by Swain Yun on 2023/04/21.
//

import Foundation

struct GradeConverter {
    func stringToScore(_ grade: String) -> Double {
        switch grade {
        case "A+": return Grade.aPlus.score
        case "A": return Grade.a.score
        case "B+": return Grade.bPlus.score
        case "B": return Grade.b.score
        case "C+": return Grade.cPlus.score
        case "C": return Grade.c.score
        case "D+": return Grade.dPlus.score
        case "D": return Grade.d.score
        default: return Grade.f.score
        }
    }
}
