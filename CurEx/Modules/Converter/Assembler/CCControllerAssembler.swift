//
//  CCControllerAssembler.swift
//  CurEx
//
//  Created by Roman Bigun on 06.06.2024.
//

import UIKit

final class CCViewControllerAssembler {
    static func build() -> CCViewController {
        let controller = CCViewController()
        let converter = ConverterService()
        let interactor = ConverterInteractor(converter: converter)
        controller.presenter = ConverterPresenter(interactor: interactor)
        return controller
    }
}

