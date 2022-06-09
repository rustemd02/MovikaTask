//
//  VideoService.swift
//  MovikaTask
//
//  Created by Рустем on 09.06.2022.
//

import Foundation
import AVKit
import AVFoundation

protocol VideoModelServiceProtocol {
    func getFirstVideo(completion: @escaping(Result<Video, Error>) -> Void)
    func getSecondVideo(completion: @escaping(Result<Video, Error>) -> Void)
}

class VideoModelService: VideoModelServiceProtocol {

    
    func getFirstVideo(completion: @escaping(Result<Video, Error>) -> Void) {
        let video = Video(title: "video1", type: "mp4")
        completion(.success(video))
    }
    
    func getSecondVideo(completion: @escaping(Result<Video, Error>) -> Void) {
        let video = Video(title: "video2", type: "mp4")
        completion(.success(video))
    }
}
