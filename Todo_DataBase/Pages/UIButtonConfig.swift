//
//  UIButtonConfig.swift
//  Todo_DataBase
//
//  Created by Jaka on 2024-07-03.
//

import UIKit

extension UIButton.Configuration {
    
    static func configButton(_ title: String) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        configuration.title = title
        configuration.titleAlignment = .leading
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        configuration.baseForegroundColor = .white
        configuration.image = UIImage(systemName: "chevron.right")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 240
        
        return configuration
    }
}
