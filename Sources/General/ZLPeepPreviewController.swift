//
//  ZLPeepPreviewController.swift
//  ZLPhotoBrowser
//
//  Created by Kagen Zhao on 2021/3/5.
//

import UIKit

class ZLPeepPreviewController: UIViewController {
    
    let model: ZLPhotoModel
    let popAction: (() -> ())
    
    private var preview: ZLPreviewView!
    
    init(model: ZLPhotoModel, popAction: @escaping (() -> ())) {
        self.model = model
        self.popAction = popAction
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        preview = ZLPreviewView()
        view.addSubview(preview)
        preview.model = model
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        switch model.type {
        case .gif:
            preview.loadGifData()
        case .image, .livePhoto, .unknown:
            preview.loadPhoto()
        case .video:
            preview.loadGifFirstFrame()
            return
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        preview.frame = view.bounds
    }
    
}
