//
//  UITableView+Register.swift
//  PromptuCodingKhimchuk
//
//  Created by Valentyn Khimchuk on 13.12.2022.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type) {
        let identifier = "\(cellType)"
        let nib = UINib(nibName: identifier, bundle: nil)
        register(nib, forCellReuseIdentifier: identifier)
    }

    func cell<T: UITableViewCell>(cellType: T.Type) -> T {
        let identifier = "\(cellType)"
        guard let cell = dequeueReusableCell(withIdentifier: identifier) as? T else {
            print("cell own type")
            return T.loadViewFromNib() ?? T()
        }

        return cell
    }
}
