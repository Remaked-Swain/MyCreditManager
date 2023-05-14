//
//  ScoreModel.swift
//  MyCreditManager
//
//  Created by Swain Yun on 2023/04/20.
//

import Foundation

class Core {
    // MARK: Properties
    private let converter = GradeConverter()
    private let script = InterfaceScript.self
    
    // 학생과 성적을 관리할 데이터베이스 역할의 변수
    private var studentDict: [String:[String:String]]
    
    init() {
        self.studentDict = [String:[String:String]]()
    }
    
    // MARK: Methods
    func run() {
        while true {
            switch getUserOrder() {
            case "1":
                do {
                    try addStudent()
                } catch {
                    print(error)
                }
            case "2":
                do {
                    try removeStudent()
                } catch {
                    print(error)
                }
            case "3":
                do {
                    try adjustScore()
                } catch {
                    print(error)
                }
            case "4":
                do {
                    try removeScore()
                } catch {
                    print(error)
                }
            case "5":
                do {
                    try getStatusScore()
                } catch {
                    print(error)
                }
            case "X":
                exit();
            default:
                print(script.Failure.wrongMenuSelected.debugDescription)
            }
        }
    }
}

extension Core {
    // MARK: Interface Methods
    private func getUserOrder() -> String {
        print(script.Menu.selectMenu.description)
        guard let order = readLine() else { return "" }
        return order
    }
    
    private func addStudent() throws {
        print(script.AddStudent.readLineStudentName.description)
        
        guard
            let name = readLine(),
            name.isEmpty == false
        else { throw script.Failure.wrongInput }
        
        if self.studentDict.keys.contains(name) {
            print(script.AddStudent.duplicatedStudentName(name: name).description)
        } else {
            self.studentDict[name] = [:]
            print(script.AddStudent.addStudentSuccess(name: name).description)
        }
    }
    
    private func removeStudent() throws {
        print(script.RemoveStudent.readLineStudentName.description)
        
        guard
            let name = readLine(),
            name.isEmpty == false
        else { throw script.Failure.wrongInput }
        
        if self.studentDict.keys.contains(name) {
            self.studentDict[name] = nil
            print(script.RemoveStudent.removeStudentSuccess(name: name).description)
        } else {
            print(script.Failure.studentNotExist(name: name))
        }
    }
    
    private func adjustScore() throws {
        print(script.AdjustScore.readLineScore.description)
        
        // 입력데이터 무결성 검사
        guard
            let input = readLine()?.components(separatedBy: " "),
            input.count == 3,
            ["A+", "A", "B+", "B", "C+", "C", "D+", "D", "F"].contains(input[2])
        else { throw script.Failure.wrongInput }
        
        let name = input[0]; let subject = input[1]; let grade = input[2]
            
        if self.studentDict.keys.contains(name) {
            self.studentDict[name]?[subject] = grade
            print(script.AdjustScore.adjustScoreSuccess(name: name, subject: subject, grade: grade).description)
        } else {
            print(script.Failure.studentNotExist(name: name))
        }
    }
    
    private func removeScore() throws {
        print(script.RemoveScore.readLineScore.description)
        
        // 입력데이터 무결성 검사
        guard
            let input = readLine()?.components(separatedBy: " "),
            input.count == 2
        else { throw script.Failure.wrongInput }
        
        let name = input[0]; let subject = input[1]
        
        guard self.studentDict.keys.contains(name) else { throw script.Failure.studentNotExist(name: name) }
        guard self.studentDict[name]?.keys.contains(subject) == true else { throw script.Failure.subjectNotExist(name: name, subject: subject) }
        
        self.studentDict[name]?[subject] = nil
        print(script.RemoveScore.removeScoreSuccess(name: name, subject: subject).description)
    }
    
    private func getStatusScore() throws {
        print(script.StatusScore.readLineStudentName.description)
        
        // 입력데이터 무결성 검사
        guard
            let name = readLine(),
            name.isEmpty == false
        else { throw script.Failure.wrongInput }
        
        guard self.studentDict.keys.contains(name) else { throw script.Failure.studentNotExist(name: name) }
        guard let list = self.studentDict[name], list.isEmpty == false else { throw script.Failure.statusNotFound }
        
        // Score Dictionary: sorted by ascending
        for item in list.sorted(by: {converter.stringToScore($0.value) > converter.stringToScore($1.value)}) {
            print("\(item.key): \(item.value)")
        }
        
        let totalScore: String = (list.values.map {converter.stringToScore($0)}.reduce(0, +) / Double(list.count)).asStringWith2Decimals()
        
        print(script.StatusScore.statusScoreSuccess(totalScore: totalScore).description)
    }
    
    private func exit() {
        print(script.Menu.exitProgram.description)
        Darwin.exit(EXIT_SUCCESS)
    }
}
