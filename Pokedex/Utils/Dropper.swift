//
//  Dropper.swift
//  Pokedex
//
//  Created by Sahil Ak on 06/07/2024.
//

import UIKit
import Drops

/// Helper methods for accessible toasts to the user
enum Dropper {
    /// Send a UI Toast message to the user
    /// - Parameters:
    ///   - message: the message type and textual content to conveyed to the user.
    static func show(_ message: Message) {
        Drops.show(
            Drop(title: message.title, subtitle: message.subtitle, icon: message.type.icon, duration: .seconds(0.9), accessibility: .init(message: "\(message.title), \(message.subtitle ?? "")"))
        )
    }
    
    /// Represents a message to be displayed to the user
    struct Message {
        let type: MessageType
        let title: String
        var subtitle: String? = nil
        
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
    
}

