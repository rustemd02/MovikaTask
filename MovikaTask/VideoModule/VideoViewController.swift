//
//  VideoViewController.swift
//  MovikaTask
//
//  Created by Рустем on 09.06.2022.
//

import SnapKit
import UIKit
import AVKit
import AVFoundation

protocol VideoViewControllerProtocol: AnyObject {
    func timerValueDecrease()
    func setVideoDuration(duration: Double)
}

class VideoViewController: UIViewController, VideoViewControllerProtocol {
    private var presenter: VideoPresenterProtocol?
    var playerLayer = AVPlayerLayer()
    var timerLabel = UILabel()
    var button = UIButton()
    
    var firstClipView = UIView()
    var timeLeftBackgroundView = UIView()
    var timeLeftView = UIView()
    
    var duration: Double?
    
    init(presenter: VideoPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiInit()
        configure()
        presenter?.videoTimer()
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    func configure() {
        presenter?.getFirstVideo(playerLayer: playerLayer)
        playerLayer.player?.play()
        guard let duration = duration else {
            return
        }
        
        
        UIView.animate(withDuration: duration, delay: 1, options: .allowUserInteraction) {
            self.timeLeftView.transform = CGAffineTransform(scaleX: 1, y: 0.000001)
        } completion: { _ in
            if (self.firstClipView.isHidden) { return }
            
            let alert = UIAlertController(title: "Проигрыш", message: "Не успели", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: {_ in
                self.button.isHidden = true
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        UIViewPropertyAnimator(duration: duration, curve: .easeOut) {
            self.button.center = CGPoint(
                x: self.button.center.x + 210,
                y: self.button.center.y + 70
            )
            self.button.transform = CGAffineTransform (scaleX: 2, y: 2)
            
        }.startAnimation()
        
        
        
    }
    
    func uiInit() {
        view.layer.addSublayer(playerLayer)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        view.addSubview(firstClipView)
        firstClipView.addSubview(timerLabel)
        firstClipView.addSubview(button)
        firstClipView.addSubview(timeLeftBackgroundView)
        firstClipView.addSubview(timeLeftView)
        
        firstClipView.isUserInteractionEnabled = true
        firstClipView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview()
        }
        
        button.setTitle("жмак", for: .normal)
        button.setTitleShadowColor(.black, for: .normal)
        button.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        timeLeftBackgroundView.backgroundColor = .darkGray
        timeLeftBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.width.equalTo(16)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(8)
            
        }
        
        timeLeftView.backgroundColor = .white
        timeLeftView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.width.equalTo(16)
            make.left.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
    }
    
    @objc func buttonPressed() {
        firstClipView.isHidden = true
        
        presenter?.getSecondVideo(playerLayer: playerLayer)
        playerLayer.player?.play()
    }
    
    func timerValueDecrease() {
        duration!-=1
    }
    
    func setVideoDuration(duration: Double) {
        self.duration = duration
    }
    
    
}


