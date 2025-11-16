//
//  AddNoteView.swift
//  SecureNote
//
//  Created by Doğukan Ogan on 16.11.2025.
//

import SwiftUI

struct AddNoteView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var noteManager: NoteManager
    
    @State private var title: String = ""
    @State private var content: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Not Detayları")) {
                    TextField("Başlık", text: $title)
                    TextEditor(text: $content) // çok satırlı text girişi
                        .frame(height: 200)
                }
            }
            .navigationTitle("Yeni Not")
            .navigationBarItems(
                leading: Button("İptal") {
                    dismiss()
                },
                trailing: Button("Kaydet") {
                    if !title.isEmpty && !content.isEmpty {
                        noteManager.addNote(title: title, content: content)
                        dismiss()
                    }
                }
            )
        }
    }
}


