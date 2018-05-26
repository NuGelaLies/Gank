import Foundation
import UIKit

extension String {
    // 拼音
    var pinYingString: String {
        let str = NSMutableString(string: self) as CFMutableString
        CFStringTransform(str, nil, kCFStringTransformToLatin, false)
        CFStringTransform(str, nil, kCFStringTransformStripDiacritics, false)

        let string = str as String
        return string.capitalized.trimmed
    }
    
    // 首字母
    var pinyingInitial: String {
        let array = self.capitalized.components(separatedBy: " ")
        var pinYing = ""
        for temp in array {
            if temp.count == 0 {continue}
            let index = temp.index(temp.startIndex, offsetBy: 1)
            pinYing += temp[..<index]
        }
        return pinYing
        
    }
    
    var firstLetter: String {
        if count == 0 { return self }
        let index = self.index(self.startIndex, offsetBy: 1)
        return String(self[startIndex..<index])
    }
    
    var bang: [String] {
        let locale = CFLocaleCopyCurrent()
        let text = self as CFString
        let range = CFRangeMake(0, CFStringGetLength(text))
        let tokenizer = CFStringTokenizerCreate(kCFAllocatorDefault, text, range, UInt(kCFStringTokenizerUnitWordBoundary), locale)
        
        var tokens = [String]()
        CFStringTokenizerAdvanceToNextToken(tokenizer)
        
        while (true) {
            let range = CFStringTokenizerGetCurrentTokenRange(tokenizer)
            if range.location == kCFNotFound && range.length == 0 { break }
            let token = CFStringCreateWithSubstring(kCFAllocatorDefault, text, range)
            if let item = token as String?, item.trimmed.isNotEmpty {
                tokens.append(item)
            }
            CFStringTokenizerAdvanceToNextToken(tokenizer)
        }
        
        return tokens
    }
}
