//
//  PickedImageColorView.swift
//  pickedImageColorView
//
//  Created by masaki hasegawa on 2021/02/07.
//

import Foundation
import UIKit

struct ColorFrequency {
    let color: UIColor
    var count: Int
}

final class PickedImageColorView: BaseView {

    @IBOutlet private weak var innerView: UIView!
    @IBOutlet private weak var imageView: UIImageView!

    private var pickedColors: [UIColor] = []

    func setImage(_ imageUrl: String) {
        self.imageView.setImage(with: imageUrl, placeholder: nil, completed: { [weak self] _ in
            guard let self = self else { return }
            self.pickColor()
            let colorFrequencies = self.arrangeColorFrequency()
            let majorColor = self.getMajorColor(colorFrequencies: colorFrequencies)
            self.innerView.backgroundColor = majorColor
        })
    }
}

// MARK: - pick color
extension PickedImageColorView {

    private func pickColor() {
        guard let image = self.imageView.image,
              let provider = image.cgImage?.dataProvider,
              let data = CFDataGetBytePtr(provider.data) else {
            return
        }

        let numberOfComponents = 4

        let maxWidth: Int = Int(image.size.width)
        let maxHeight: Int = Int(image.size.height)

        let alphaColor: UIColor = .init(red: .zero, green: .zero, blue: .zero, alpha: .zero)

        for x in 0..<maxWidth {
            for y in 0..<maxHeight {
                let targetPixel = (maxWidth * y + x) * numberOfComponents
                let color: UIColor = .init(
                    red: CGFloat(data[targetPixel]) / 255.0,
                    green: CGFloat(data[targetPixel + 1]) / 255.0,
                    blue: CGFloat(data[targetPixel + 2]) / 255.0,
                    alpha: CGFloat(data[targetPixel + 3]) / 255.0
                )

                // 透明色は除く
                if alphaColor != color {
                    self.pickedColors.append(color)
                }
            }
        }
    }

    private func arrangeColorFrequency() -> [ColorFrequency] {
        var colorFrequencies: [ColorFrequency] = []
        
        self.pickedColors.enumerated().forEach { index, pickedColor in
            if colorFrequencies.contains(where: { colorFrequency in
                colorFrequency.color == pickedColor
            }) {
                let index = colorFrequencies.firstIndex(where: { $0.color == pickedColor })!
                colorFrequencies[index].count += 1
            }
            else {
                colorFrequencies.append(.init(color: pickedColor, count: 1))
            }
        }

        return colorFrequencies
    }

    private func getMajorColor(colorFrequencies: [ColorFrequency]) -> UIColor {
        guard var majorColor: ColorFrequency = colorFrequencies.first else {
            return .init()
        }

        colorFrequencies.forEach { colorFrequency in
            if colorFrequency.count > majorColor.count {
                majorColor = colorFrequency
            }
        }

        return majorColor.color
    }
}
