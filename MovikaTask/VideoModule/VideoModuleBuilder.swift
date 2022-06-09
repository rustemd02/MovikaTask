//
//  VideoModuleBuilder.swift
//  MovikaTask
//
//  Created by Рустем on 09.06.2022.
//

import UIKit

protocol VideoModuleBuilderProtocol: AnyObject {
    func build() -> UIViewController
}

final class VideoModuleBuilder: VideoModuleBuilderProtocol {
    
    func build() -> UIViewController {
        let model = VideoModelService()
        let presenter = VideoPresenter(model: model)
        let viewController = VideoViewController(presenter: presenter)
        
        presenter.view = viewController
        
        return viewController
    }
}
