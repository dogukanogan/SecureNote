import Foundation
import CryptoKit

class CryptoHelper {
    // şimdilik user defaults'ta saklanıyor.
    
    private static var key: SymmetricKey {
        let keyString = "secureNotesKeyData"
        
        if let storedKeyData = UserDefaults.standard.data(forKey: keyString) {
            return SymmetricKey(data: storedKeyData)
        } else {
            let newKey = SymmetricKey(size: .bits256)
            let keyData = newKey.withUnsafeBytes { Data($0) }
            UserDefaults.standard.set(keyData, forKey: keyString)
            return newKey
        }
    }
    
    static func encrypt(data: Data) -> Data? {
        do {
            // ChaChaPoly
            let sealedBox = try ChaChaPoly.seal(data, using: key)
            return sealedBox.combined
        } catch {
            print("Şifreleme hatası: \(error)")
            return nil
        }
    }
    
    static func decrypt(data: Data) -> Data? {
        do {
            let sealedBox = try ChaChaPoly.SealedBox(combined: data)
            let decryptedData = try ChaChaPoly.open(sealedBox, using: key)
            return decryptedData
        } catch {
            print("Şifre çözme hatası: \(error)")
            return nil
        }
    }
}
//
//  CryptoHelper.swift
//  SecureNote
//
//  Created by Doğukan Ogan on 18.11.2025.
//


