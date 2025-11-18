//
//  ContentView.swift
//  SecureNote
//
//  Created by Doğukan Ogan on 16.11.2025.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    
    @StateObject private var noteManager = NoteManager()
    @State private var showingAddNoteView = false
    
    // locked or unlocked variable
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                // if unlocked, show notes
                NavigationView {
                    List {
                        ForEach(noteManager.notes) { note in
                            VStack(alignment: .leading) {
                                Text(note.title)
                                    .font(.headline)
                                Text(note.content)
                                    .font(.subheadline)
                                    .lineLimit(1)
                            }
                        }
                        .onDelete(perform: noteManager.deleteNote)
                    }
                    .navigationTitle("Güvenli Notlar")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button { showingAddNoteView = true } label: {
                                Image(systemName: "plus")
                            }
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            EditButton()
                        }
                    }
                    .sheet(isPresented: $showingAddNoteView) {
                        AddNoteView(noteManager: noteManager)
                    }
                }
            } else {
                VStack(spacing: 20) {
                    Image(systemName: "lock.shield.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                    
                    Text("Güvenli Notlar Kilitli")
                        .font(.title2)
                        .fontWeight(.bold)
                    Button("Kilidi Aç") {
                        authenticate()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
        }
        .onAppear() {
            authenticate()
        }
    }
    
    // Face ID function
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Notlarınıza erişmek için lütfen kimliğinizi doğrulayın."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.isUnlocked = false
                    }
                }
            }
        } else {
            print("Cihazda biyometrik doğrulama yok.")
            self.isUnlocked = true
        }
    }
}




