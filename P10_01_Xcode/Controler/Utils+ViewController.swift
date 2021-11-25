//
//  UIVViewController.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 17/11/2021.
//

import UIKit
import Alamofire
//
// MARK: - View Controller
//

/// Extension UIVIewController
/// Fonction called by all the View Controllers
extension UIViewController {
    //
    // MARK: - Internal Method
    //
    func presentAlert(title: String, message: String) {
      let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      present(alertVC, animated: true, completion: nil)
    }
}

//
// MARK: - View
//

/// Extension UIView
/// Create a blur for the displayed pictures
extension UIView{
    //
    // MARK: - Internal Method
    //
    func createGradientBlur() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
        UIColor.white.withAlphaComponent(0).cgColor,
        UIColor.white.withAlphaComponent(1).cgColor]
        let viewEffect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: viewEffect)
        effectView.frame = CGRect(x: self.bounds.origin.x, y: self.bounds.size.height,
                                  width: self.bounds.width, height: self.bounds.size.height)
        gradientLayer.frame = effectView.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0 , y: 0.0)
        effectView.autoresizingMask = [.flexibleHeight]
        effectView.layer.mask = gradientLayer
        effectView.isUserInteractionEnabled = false
        addSubview(effectView)
    }
}

//
// MARK: - Image View
//

/// Extension UIImageView
/// Add function to request a picture from an URL
extension UIImageView {
    //
    // MARK: - Internal Method
    //
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
