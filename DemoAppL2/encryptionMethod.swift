//
//  encryptionMethod.swift
//  DemoAppL2
//
//  Created by Vikas Hareram Shah on 16/02/25.
//

import Foundation
import CommonCrypto

// Convert key into 32-byte (AES-256 requires exactly 32 bytes), ensuring minimum 10 characters
func formatKey(_ key: String) -> Data? {
    guard key.count >= 10 else {
        print("Key must be at least 10 characters.")
        return nil
    }

    let keyData = key.data(using: .utf8) ?? Data()
    
    if keyData.count < 32 {
        return keyData + Data(repeating: 0, count: 32 - keyData.count)  // Pad with zeros
    } else {
        return keyData.prefix(32)  // Trim excess bytes
    }
}

// AES Encryption
func encryptAES(text: String, key: String) -> String? {
    guard let keyData = formatKey(key) else { return nil }  // Ensure valid key
    guard let data = text.data(using: .utf8) else { return nil }
    
    let bufferSize = data.count + kCCBlockSizeAES128
    var buffer = Data(count: bufferSize)
    
    var numBytesEncrypted: size_t = 0
    let status = buffer.withUnsafeMutableBytes { bufferBytes in
        data.withUnsafeBytes { dataBytes in
            keyData.withUnsafeBytes { keyBytes in
                CCCrypt(
                    CCOperation(kCCEncrypt),
                    CCAlgorithm(kCCAlgorithmAES),
                    CCOptions(kCCOptionPKCS7Padding),
                    keyBytes.baseAddress, kCCKeySizeAES256,
                    nil,
                    dataBytes.baseAddress, data.count,
                    bufferBytes.baseAddress, bufferSize,
                    &numBytesEncrypted
                )
            }
        }
    }
    
    if status == kCCSuccess {
        return buffer.prefix(numBytesEncrypted).base64EncodedString()  // Convert to Base64
    }
    
    return nil
}

// AES Decryption
func decryptAES(text: String, key: String) -> String? {
    guard let keyData = formatKey(key) else { return nil }  // Ensure valid key
    guard let data = Data(base64Encoded: text) else { return nil }

    let bufferSize = data.count + kCCBlockSizeAES128
    var buffer = Data(count: bufferSize)

    var numBytesDecrypted: size_t = 0
    let status = buffer.withUnsafeMutableBytes { bufferBytes in
        data.withUnsafeBytes { dataBytes in
            keyData.withUnsafeBytes { keyBytes in
                CCCrypt(
                    CCOperation(kCCDecrypt),
                    CCAlgorithm(kCCAlgorithmAES),
                    CCOptions(kCCOptionPKCS7Padding),
                    keyBytes.baseAddress, kCCKeySizeAES256,
                    nil,
                    dataBytes.baseAddress, data.count,
                    bufferBytes.baseAddress, bufferSize,
                    &numBytesDecrypted
                )
            }
        }
    }

    if status == kCCSuccess {
        return String(data: buffer.prefix(numBytesDecrypted), encoding: .utf8)
    }

    return nil
}
