//
//  VideoPresenter.swift
//  MovikaTask
//
//  Created by Рустем on 09.06.2022.
//

import Foundation
import AVFoundation

protocol VideoPresenterProtocol: AnyObject {
    func getFirstVideo(playerLayer: AVPlayerLayer)
    func getSecondVideo(playerLayer: AVPlayerLayer)
    func videoTimer()
}

class VideoPresenter: VideoPresenterProtocol {
    
    var timer = Timer()
    weak var view: VideoViewControllerProtocol?
    let model: VideoModelServiceProtocol
    
    init(model: VideoModelServiceProtocol) {
            self.model = model
        }
    
    func videoTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerValueDecrease), userInfo: nil, repeats: true)
    }
    
    func getFirstVideo(playerLayer: AVPlayerLayer) {
        model.getFirstVideo { result in
            switch result{
            case .success(let video):
                playerLayer.player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: video.title, ofType: video.type) ?? ""))
                
            case .failure(let error):
                print(error)
            }
            
        }
        guard let duration = playerLayer.player?.currentItem?.asset.duration else { return  }
        
        view?.setVideoDuration(duration: CMTimeGetSeconds(duration))
    }
    
    func getSecondVideo(playerLayer: AVPlayerLayer) {
        model.getSecondVideo { result in
            switch result{
            case .success(let video):
                playerLayer.player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: video.title, ofType: video.type) ?? ""))
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    @objc func timerValueDecrease() {
        view?.timerValueDecrease()
    }
   
}
