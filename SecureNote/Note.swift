import Foundation

struct Note: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var content: String
    var createdAt: Date = Date()
}


//
//  Note.swift
//  SecureNote
//
//  Created by Doğukan Ogan on 16.11.2025.
//

