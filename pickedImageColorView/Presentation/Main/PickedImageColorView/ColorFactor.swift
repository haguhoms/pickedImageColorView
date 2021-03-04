//
//  ColorFactor.swift
//  pickedImageColorView
//
//  Created by masaki hasegawa on 2021/02/17.
//

import Foundation
import UIKit

struct ColorFactor: Equatable {
    var red: Int
    var green: Int
    var blue: Int
    var alpha: Int

    static var zero: ColorFactor {
        return .init(red: 0, green: 0, blue: 0, alpha: 0)
    }

    var uiColor: UIColor {
        return .init(
            red: CGFloat(self.red) / 255.0,
            green: CGFloat(self.green) / 255.0,
            blue: CGFloat(self.blue) / 255.0,
            alpha: CGFloat(self.alpha) / 255.0
        )
    }

    func calculateMixedColor(count: Int) -> UIColor {
        return .init(
            red: CGFloat(self.red) / CGFloat(count * 255),
            green: CGFloat(self.green) / CGFloat(count * 255),
            blue: CGFloat(self.blue) / CGFloat(count * 255),
            alpha: CGFloat(self.alpha) / CGFloat(count * 255)
        )
    }
}
