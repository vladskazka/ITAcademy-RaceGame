//
//  String + extension.swift
//  ITAcademy_RaceGame
//
//  Created by Влад Муравьев on 10.05.2024.
//

import UIKit

extension String {
    
    func makeAttributed() -> NSAttributedString {
        
        let attributes = [
            NSAttributedString.Key.foregroundColor : Constants.attributedTextColor,
            NSAttributedString.Key.font : Constants.attributedTextFont
        ] as? [NSAttributedString.Key : Any]
        let attributedString = NSAttributedString(string: self, attributes: attributes)
        
        return attributedString
    }
}
