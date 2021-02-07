//
//  Bundle+.swift
//  pickedImageColorView
//
//  Created by masaki hasegawa on 2021/02/07.
//

import Foundation
import UIKit

extension Bundle {

    static func loadView(instance: UIView) -> UIView? {
        let t = type(of: instance)
        let bundle = Bundle(for: t)
        let nib = UINib(nibName: String(describing: t), bundle: bundle)
        return nib.instantiate(withOwner: instance, options: nil).first as? UIView
    }

    static var appVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
}
