//
//  InterfaceScript.swift
//  MyCreditManager
//
//  Created by Swain Yun on 2023/05/10.
//

import Foundation

@frozen enum InterfaceScript {
    @frozen enum Menu {
        case selectMenu
        case exitProgram
        
        var description: String {
            switch self {
            case .selectMenu:
                return "원하는 기능을 입력해주세요\n1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료"
            case .exitProgram:
                return "프로그램을 종료합니다..."
            }
        }
    }
    
    @frozen enum WrongInput: Error, CustomDebugStringConvertible {
        case wrongMenuSelected
        case wrongInput
        case studentNotExist(name: String)
        case subjectNotExist(name: String, subject: String)
        case statusNotFound
        
        var debugDescription: String {
            switch self {
            case .wrongMenuSelected:
                return "뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요."
            case .wrongInput:
                return "입력이 잘못되었습니다. 다시 확인해주세요."
            case .studentNotExist(let name):
                return "\(name) 학생을 찾지 못했습니다."
            case .subjectNotExist(let name, let subject):
                return "\(name) 학생의 \(subject) 과목의 성적은 존재하지 않습니다."
            case .statusNotFound:
                return "평점을 구할 과목과 성적이 없습니다."
            }
        }
    }
    
    @frozen enum AddStudent {
        case readLineStudentName
        case duplicatedStudentName(name: String)
        case addStudentSuccess(name: String)
        
        var description: String {
            switch self {
            case .readLineStudentName:
                return "추가할 학생의 이름을 입력해주세요"
            case .duplicatedStudentName(let name):
                return "\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다."
            case .addStudentSuccess(let name):
                return "\(name) 학생을 추가했습니다."
            }
        }
    }
    
    @frozen enum RemoveStudent {
        case readLineStudentName
        case removeStudentSuccess(name: String)
        
        var description: String {
            switch self {
            case .readLineStudentName:
                return "삭제할 학생의 이름을 입력해주세요"
            case .removeStudentSuccess(let name):
                return "\(name) 학생을 삭제하였습니다."
            }
        }
    }
    
    @frozen enum AdjustScore {
        case readLineScore
        case adjustScoreSuccess(name: String, subject: String, grade: String)
        
        var description: String {
            switch self {
            case .readLineScore:
                return "성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.\n입력예) Mickey Swift A+\n만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다."
            case .adjustScoreSuccess(let name, let subject, let grade):
                return "\(name) 학생의 \(subject) 과목이 \(grade)로 추가(변경)되었습니다."
            }
        }
    }
    
    @frozen enum RemoveScore {
        case readLineScore
        case removeScoreSuccess(name: String, subject: [String:String])
        
        var description: String {
            switch self {
            case .readLineScore:
                return "성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요."
            case .removeScoreSuccess(let name, let subject):
                return "\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다."
            }
        }
    }
    
    @frozen enum StatusScore {
        case readLineStudentName
        case statusScoreSuccess(totalScore: String)
        
        var description: String {
            switch self {
            case .readLineStudentName:
                return "평점을 알고싶은 학생의 이름을 입력해주세요"
            case .statusScoreSuccess(let totalScore):
                return "평점 : \(totalScore)"
            }
        }
    }
}
