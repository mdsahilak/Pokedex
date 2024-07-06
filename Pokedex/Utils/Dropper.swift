//
//  Dropper.swift
//  Pokedex
//
//  Created by Sahil Ak on 06/07/2024.
//

import SwiftUI
import Drops

struct Dropper {
    static func send(_ type: MessageType, message: MessageItem) {
        Drops.show(
            Drop(title: message.title, subtitle: message.subtitle, icon: type.icon, duration: .seconds(0.9), accessibility: .init(message: "\(message.title), \(message.subtitle ?? "")"))
        )
    }
    
    struct MessageItem {
        var title: String
        var subtitle: String? = nil
    }
    
    enum MessageType {
        case error, warning, success
        
        var icon: UIImage? {
            switch self {
            case .error:
                return UIImage(systemName: "xmark.circle")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
            case .warning:
                return UIImage(systemName: "exclamationmark.circle")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
            case .success:
                return UIImage(systemName: "checkmark.circle")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
            }
        }
    }
}

