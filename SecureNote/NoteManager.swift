//
//  NoteManager.swift
//  SecureNote
//
//  Created by Doğukan Ogan on 16.11.2025.
//

import Foundation
import Combine
import SwiftUI


class NoteManager: ObservableObject {
    @Published var notes: [Note] = []
    
    private let saveKey = "mySecureNotes"
    
    init() {
        loadNotes()
    }
    
    func loadNotes() {
        
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedNotes = try? JSONDecoder().decode([Note].self, from: data) {
                self.notes = decodedNotes
                return
            }
        }
        
        self.notes = []
    }
    
    func saveNotes() {
        if let encodedData = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encodedData, forKey: saveKey)
        }
    }
    
    func addNote(title: String, content: String) {
        let newNote = Note(title: title, content: content)
        notes.insert(newNote, at: 0)
        
        saveNotes()
    }
    
    func deleteNote(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
        
        saveNotes()
    }
}





