//
//  PickedImageColorView.swift
//  pickedImageColorView
//
//  Created by masaki hasegawa on 2021/02/07.
//

import Foundation
import UIKit

final class PickedImageColorView: BaseView {

    @IBOutlet private weak var innerView: UIView!
    @IBOutlet private weak var imageView: UIImageView!

    private var colorFrequencies: [ColorFrequency] = []

    // 無視したい色
    private let excludeColors: [ColorFactor] = [
        .init(red: 0, green: 0, blue: 0, alpha: 0),
        .init(red: 1, green: 1, blue: 1, alpha: 1),
    ]

    func setImage(_ imageUrl: String, pickType: PickType) {
        self.imageView.setImage(with: imageUrl, placeholder: nil, completed: { [weak self] response in
            guard let self = self else { return }
            guard case .success(let imageResponse) = response else { return }

            self.pickColor(image: imageResponse.image)

            let pickedColor: UIColor = {
                switch pickType {
                case .major: return self.getMajorColor(colorFrequencies: self.colorFrequencies)
                case .mixed: return self.getMixedColor(colorFrequencies: self.colorFrequencies)
                }
            }()

            self.innerView.backgroundColor = pickedColor
        })
    }
}

// MARK: - pick color
extension PickedImageColorView {

    private func pickColor(image: UIImage) {
        guard let provider = image.cgImage?.dataProvider,
              let data = CFDataGetBytePtr(provider.data) else {
            return
        }

        let numberOfComponents = 4

        let maxWidth: Int = Int(image.size.width)
        let maxHeight: Int = Int(image.size.height)

        for x in 0..<maxWidth {
            for y in 0..<maxHeight {
                let targetPixel = (maxWidth * y + x) * numberOfComponents
                let color: ColorFactor = .init(
                    red: Int(data[targetPixel]),
                    green: Int(data[targetPixel + 1]),
                    blue: Int(data[targetPixel + 2]),
                    alpha: Int(data[targetPixel + 3])
                )

                if !self.excludeColors.contains(color) {
                    self.arrangeColorFrequency(color: color)
                }
            }
        }
    }

    private func arrangeColorFrequency(color: ColorFactor) {
        if let index = self.colorFrequencies.firstIndex(where: { $0.color == color }) {
            self.colorFrequencies[index].count += 1
        }
        else {
            self.colorFrequencies.append(.init(color: color, count: 1))
        }
    }

    private func getMajorColor(colorFrequencies: [ColorFrequency]) -> UIColor {
        guard let majorColor: UIColor = colorFrequencies.sorted(by: { $0.count > $1.count }).first?.color.uiColor else {
            return .init()
        }

        return majorColor
    }

    // FIXME:
    // この処理だと一度全pixelを走査してColorFrequencyの配列を作り、その配列をさらに走査しているので処理が多くなってしまっている
    // mixedに関してはColorFrequencyの配列は必要ないので処理を変えるのが良さそう
    private func getMixedColor(colorFrequencies: [ColorFrequency]) -> UIColor {
        var color: ColorFactor = .zero
        let count: Int = colorFrequencies.reduce(0) { $0 + $1.count }

        colorFrequencies.forEach { colorFrequency in
            let singleCount: Int = colorFrequency.count

            color.red += colorFrequency.color.red * singleCount
            color.green += colorFrequency.color.green * singleCount
            color.blue += colorFrequency.color.blue * singleCount
            color.alpha += colorFrequency.color.alpha * singleCount
        }

        return color.calculateMixedColor(count: count)
    }
}
