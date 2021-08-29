//
//  String+Extensions.swift
//  MarvelAPI
//
//  Created by German Huerta on 27/08/21.
//

import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG
extension String {
    private func MD5(string: String) -> Data {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData
    }
    func md5Hex() -> String {
        let md5Data = MD5(string: self)
        let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
        return md5Hex

    }

    func md5Base64() -> String {
        let md5Data = MD5(string: self)
        let md5Base64 = md5Data.base64EncodedString()
        return md5Base64
    }
    
}
