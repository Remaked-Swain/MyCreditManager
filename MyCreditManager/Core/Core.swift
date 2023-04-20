//
//  ScoreModel.swift
//  MyCreditManager
//
//  Created by Swain Yun on 2023/04/20.
//

import Foundation

class Core {
    // 학생과 성적을 관리할 데이터베이스 역할의 변수
    private var studentDict: [Student:Score]
    
    init() {
        self.studentDict = [Student:Score]()
        run()
    }
    
    private func getUserOrder() -> String {
        print("원하는 기능을 입력해주세요\n1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
        guard let order = readLine() else { return "" }
        return order
    }
    
    func run() {
        while true {
            let order = getUserOrder()
        }
    }
}
