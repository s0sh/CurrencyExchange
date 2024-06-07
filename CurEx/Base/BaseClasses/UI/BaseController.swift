//
//  ViewController.swift
//  CurEx
//
//  Created by Roman Bigun on 06.06.2024.
//

import UIKit


class BaseController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        layoutViews()
        configure()
    }
    
}

@objc extension BaseController {
    
    func addViews() {}
    
    func layoutViews() {}
    
    func configure() {
        view.backgroundColor = Resources.Colors.backgroundMain
    }
}
