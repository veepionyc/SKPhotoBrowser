//
//  SKDetectingImageView.swift
//  SKPhotoBrowser
//
//  Created by suzuki_keishi on 2015/10/01.
//  Copyright © 2015 suzuki_keishi. All rights reserved.
//

import UIKit
import VPKit

@objc protocol SKDetectingImageViewDelegate {
    func handleImageViewSingleTap(_ touchPoint: CGPoint)
    func handleImageViewDoubleTap(_ touchPoint: CGPoint)
}

class SKDetectingImageView: VPKPreview {
    weak var skdelegate: SKDetectingImageViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //setup()
    }
    
    @objc func handleDoubleTap(_ recognizer: UITapGestureRecognizer) {
        skdelegate?.handleImageViewDoubleTap(recognizer.location(in: self))
    }
    
    @objc func handleSingleTap(_ recognizer: UITapGestureRecognizer) {
        skdelegate?.handleImageViewSingleTap(recognizer.location(in: self))
    }
}

private extension SKDetectingImageView {
    func setup() {
        isUserInteractionEnabled = true
        useCache = false
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTap)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(_:)))
        singleTap.require(toFail: doubleTap)
        addGestureRecognizer(singleTap)
    }
}
