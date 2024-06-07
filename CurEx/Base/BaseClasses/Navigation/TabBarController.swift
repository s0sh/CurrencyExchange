//
//  TabBarController.swift
//  CurEx
//
//  Created by Roman Bigun on 06.06.2024.
//

import UIKit

enum Tabs: Int {
    case converter
}

final class TabBarController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        sonfigure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func sonfigure() {
        
        // MARK: - Appearance
        tabBar.tintColor = Resources.Colors.active
        tabBar.barTintColor = Resources.Colors.inactive
        tabBar.layer.borderColor = Resources.Colors.separator.cgColor
        tabBar.backgroundColor = .white
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
        
        // MARK: - Controllers
        let converterController = CCViewControllerAssembler.build()
        
        let converterNavigationaController = NavBarController(rootViewController: converterController)
        
        // MARK: - Bar items
        converterNavigationaController.tabBarItem = UITabBarItem(title: Resources.Strings.Tbbar.converter,
                                                     image: Resources.Images.converter,
                                                     tag: Tabs.converter.rawValue)
       
        setViewControllers([converterNavigationaController], animated: false)
        
    }
    
}
