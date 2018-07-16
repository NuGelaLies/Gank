//
//  UIView+Animation.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/7/16.
//

import Foundation

import UIKit

extension UIView {
    
    func shimmer() {
        //add layer mask
        let gradinetLayer = CAGradientLayer()
        
        gradinetLayer.colors = [UIColor.clear.cgColor,UIColor.white.cgColor,UIColor.clear.cgColor]
        gradinetLayer.locations = [0, 0.5, 1]
        gradinetLayer.frame = frame
        
        let angle = 45 * CGFloat.pi / 180
        gradinetLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        
        // layer animation
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 2
        animation.fromValue = -self.width
        animation.toValue = self.width
        animation.repeatCount = Float.infinity
        gradinetLayer.add(animation, forKey: "rotate-layer")
        layer.mask = gradinetLayer
    }
    
    func cancelAnimate() {
        
    }
}
