//
//  Dropper.swift
//  Pokedex
//
//  Created by Sahil Ak on 06/07/2024.
//

import SwiftUI
import Drops

/// Helper struct to send Toasts
struct Dropper {
    /// Send a UI Toast message to the user
    /// - Parameters:
    ///   - type: the type of toast to send, i.e a warning, success or error.
    ///   - message: the textual message to conveyed to the user.
    static func send(_ type: MessageType, message: MessageItem) {
        Drops.show(
            Drop(title: message.title, subtitle: message.subtitle, icon: type.icon, duration: .seconds(0.9), accessibility: .init(message: "\(message.title), \(message.subtitle ?? "")"))
        )
    }
    
    /// Represents the message contents
    struct MessageItem {
        var title: String
        var subtitle: String? = nil
    }
    
    /// Represents the type of message
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

