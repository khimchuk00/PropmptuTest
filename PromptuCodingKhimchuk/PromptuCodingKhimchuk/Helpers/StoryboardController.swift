//
//  StoryboardController.swift
//  PromptuCodingKhimchuk
//
//  Created by Valentyn Khimchuk on 13.12.2022.
//

import UIKit

protocol StoryboardController where Self: UIViewController {
    static var fromStoryboard: Self { get }
    static var identifier: String { get }
    static var storyboard: Storyboard { get }
}

extension StoryboardController {
    static var fromStoryboard: Self {

        guard let viewController = UIStoryboard(name: storyboard.rawValue, bundle: nil).instantiateViewController(withIdentifier: identifier) as? Self else {
            fatalError("Failed to instantiate \(identifier)")
        }
        return viewController
    }

    static var identifier: String {
        String(describing: self)
    }
}

enum Storyboard: String {
    case Main
    case AirportDetails
}
