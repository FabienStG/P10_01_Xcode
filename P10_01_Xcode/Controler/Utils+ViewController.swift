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
  
    func gradientBlur() {
        let maskedView = self
        backgroundColor = .darkGray
        let gradientMaskLayer = CAGradientLayer()
        gradientMaskLayer.frame = maskedView.bounds
        gradientMaskLayer.colors = [UIColor.darkGray.cgColor, UIColor.darkGray.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor]
        layer.mask = gradientMaskLayer
    }
    
    func setSquareView() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = 5
    }
}

//
// MARK: - Image View
//

/// Extension UIImageView
/// Add function to request a picture from an URL
extension UIImageView {

    func loadFromURL(_ url: URL) {
        AF.request(url).responseData { (response) in
            if response.error == nil {
                if let data = response.data {
                   return self.image = UIImage(data: data)
                }
            }
        }
        return self.image = UIImage(named: "DefaultFood")
    }
}

//
// MARK: - TextField
//

/// Extension to provide the underline visual effect on the textField
extension UITextField {
    
    func setUnderline() {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width - 10, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
