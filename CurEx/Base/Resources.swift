//
//  Resources.swift
//  CurEx
//
//  Created by Roman Bigun on 06.06.2024.
//
import UIKit

typealias R = Resources

enum Resources {
    enum Colors {
        static let active = UIColor(hexString: "#F2A93B")
        static let inactive = UIColor(hexString: "#929DA5")
        static let separator = UIColor(hexString: "#E8ECEF")
        static let titleDarkGrey = UIColor(hexString: "#545C77")
        static let backgroundMain = UIColor(hexString: "#F8f9F9")
        static let secondaryBackground = UIColor(hexString: "#F0F3FF")
    }
    
    enum Strings {
        enum Tbbar {
            static let converter = "Converter"
        }
        
        enum NavBar {
            enum Title {
                static let converter = "Currency Converter"
            }
        }
    }
    
    enum Images {
        static let converter = UIImage(systemName: "arrow.right.arrow.left")
        
    }
    
    enum Fonts {
        static func helveticaRegular(with size: CGFloat) -> UIFont {
            return UIFont(name: "Helvetica", size: size) ?? UIFont()
        }
        static func helveticaBold(with size: CGFloat) -> UIFont {
            return UIFont(name: "Helvetica-Bold", size: size) ?? UIFont()
        }
    }
}
