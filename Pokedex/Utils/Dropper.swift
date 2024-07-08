//
//  Dropper.swift
//  Pokedex
//
//  Created by Sahil Ak on 06/07/2024.
//

import SwiftUI
import Drops

/// Helper methods for accessible toasts to the user
enum Dropper {
    /// Send a UI Toast message to the user
    /// - Parameters:
    ///   - type: the type of toast to send, i.e a warning, success or error.
    ///   - message: the textual message to conveyed to the user.
    static func send(_ type: MessageType, title: String, subtitle: String? = nil) {
        Drops.show(
            Drop(title: title, subtitle: subtitle, icon: type.icon, duration: .seconds(0.9), accessibility: .init(message: "\(title), \(subtitle ?? "")"))
        )
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

