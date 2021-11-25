//
//  UIVViewController.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 17/11/2021.
//

import UIKit
import Alamofire

extension UIViewController {
    
    func presentAlert(title: String, message: String) {
      let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      present(alertVC, animated: true, completion: nil)
    }
}

extension UIView{
    func createGradientBlur() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
        UIColor.white.withAlphaComponent(0).cgColor,
        UIColor.white.withAlphaComponent(1).cgColor]
        let viewEffect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: viewEffect)
        effectView.frame = CGRect(x: self.bounds.origin.x, y: self.bounds.size.height, width: self.bounds.width, height: self.bounds.size.height)
        gradientLayer.frame = effectView.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0 , y: 0.0)
        effectView.autoresizingMask = [.flexibleHeight]
        effectView.layer.mask = gradientLayer
        effectView.isUserInteractionEnabled = false
        addSubview(effectView)
    }
}

extension UIImageView {
    
    func loadFromURL(_ url: URL) {
        AF.request(url).responseData { (response) in
            if response.error == nil {
                if let data = response.data {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
}
