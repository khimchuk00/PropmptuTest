//
//  UIView+LoadFromNib.swift
//  PromptuCodingKhimchuk
//
//  Created by Valentyn Khimchuk on 13.12.2022.
//

import UIKit

extension UIView {
    class func loadViewFromNib<T>(owner: Any? = nil) -> T? where T: UIView {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: "\(self)", bundle: bundle)
        let view = nib.instantiate(withOwner: owner, options: nil).first as? T

        return view
    }
}
