//
//  ScoreModel.swift
//  MyCreditManager
//
//  Created by Swain Yun on 2023/04/20.
//

import Foundation

class Core {
    // MARK: Properties
    private let scoreConverter = ScoreConverter()
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
            case "1": addStudent()
            case "2": removeStudent()
            case "3": adjustScore()
            case "4": removeScore()
            case "5": getStatusScore()
            case "X": exit();
            default: print(script.WrongInput.wrongMenuSelected.debugDescription)
            }
        }
    }
}

extension Core {
    // MARK: Interface Methods
    private func getUserOrder() -> String {
        print(script.Menu.selectMenu)
        guard let order = readLine() else { return "" }
        return order
    }
    
    private func addStudent() {
        print(script.AddStudent.readLineStudentName)
        
        guard let name = readLine() else { return }
        
        if name.isEmpty {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        } else {
            if self.studentDict.keys.contains(name) {
                print("\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
            } else {
                self.studentDict[name] = [String:String]()
                print("\(name) 학생을 추가했습니다.")
            }
        }
    }
    
    private func removeStudent() {
        print("삭제할 학생의 이름을 입력해주세요")
        
        guard let name = readLine() else { return }
        
        if name.isEmpty {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        } else {
            if self.studentDict.keys.contains(name) {
                self.studentDict[name] = nil
                print("\(name) 학생을 삭제하였습니다.")
            } else {
                print("\(name) 학생을 찾지 못했습니다.")
            }
        }
    }
    
    private func adjustScore() {
        print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.\n입력예) Mickey Swift A+\n만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
        
        guard let input = readLine()?.components(separatedBy: " ") else { return }
        
        if input.count != 3 {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        } else {
            let name = input[0]; let subject = input[1]; let grade = input[2]
            if self.studentDict.keys.contains(name) {
                self.studentDict[name] = [subject:grade]
                print("\(name) 학생의 \(subject) 과목이 \(grade)로 추가(변경)되었습니다.")
            } else {
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
            }
        }
    }
    
    private func removeScore() {
        print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
        
        guard let input = readLine()?.components(separatedBy: " ") else { return }
        
        if input.count != 2 {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        } else {
            let name = input[0]; let subject = input[1]
            
            if self.studentDict.keys.contains(name), let item = self.studentDict[name] {
                if item.keys.contains(subject) {
                    self.studentDict[name]?[subject] = nil
                    print("\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
                } else {
                    print("\(name) 학생의 \(subject) 과목의 성적은 존재하지 않습니다.")
                }
            } else {
                print("\(name) 학생을 찾지 못했습니다.")
            }
        }
    }
    
    private func getStatusScore() {
        print("평점을 알고싶은 학생의 이름을 입력해주세요")
        
        guard let name = readLine() else { return }
        
        if name.isEmpty {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        } else {
            if self.studentDict.keys.contains(name) {
                if let list = self.studentDict[name] {
                    for item in list {
                        print("\(item.key): \(item.value)")
                    }
                    
                    if list.isEmpty {
                        print("평점을 구할 과목과 성적이 없습니다.")
                    } else {
                        print("평점 : \((list.values.map {scoreConverter.convertGradeToScore($0)}.reduce(0, +) / Double(list.count)).asStringWith2Decimals())")
                    }
                }
            } else {
                print("\(name) 학생을 찾지 못했습니다.")
            }
        }
    }
    
    private func exit() {
        print("프로그램을 종료합니다...")
        Darwin.exit(EXIT_SUCCESS)
    }
}
