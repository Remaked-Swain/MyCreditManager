//
//  Database.swift
//  MyCreditManager
//
//  Created by Swain Yun on 2023/05/10.
//

import Foundation

struct Database {
    let student: [Student]
}

struct Student {
    let name: String
    let subjects: [Subject]
}

struct Subject {
    let title: String
    let grade: Grade
}
