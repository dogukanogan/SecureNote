//
//  ContentView.swift
//  SecureNote
//
//  Created by Doğukan Ogan on 16.11.2025.
//

import SwiftUI

struct ContentView: View {
    
    // for now, fake notes
    
    @State private var notes: [Note] = [
        Note(title: "İlk Not", content: "Bu benim ilk notum."),
        Note(title: "Market Alışverişi", content: "Süt, yumurta, ekmek")
    ]
    
    var body: some View {
        NavigationView {
            List(notes) { note in
                VStack(alignment: .leading) {
                    Text(note.title)
                        .font(.headline)
                    Text(note.content)
                        .font(.subheadline)
                        .lineLimit(1) // içeriğin sadece 1 satırı gözükecek
                }
            }
            .navigationTitle("Güvenli Notlar")
            .toolbar {
                // new note butonu
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // TODO: yeni not ekleme ekranını aç
                        print("Yeni not ekle tıklandı.")
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}
