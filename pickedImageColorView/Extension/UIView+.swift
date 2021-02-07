//
//  UIView+.swift
//  pickedImageColorView
//
//  Created by masaki hasegawa on 2021/02/07.
//

import Foundation
import UIKit

extension UIView {

    func matchParent(_ parent: UIView, isEnableSafe: Bool = false) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if isEnableSafe, #available(iOS 11.0, *) {
            self.topAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.topAnchor).isActive = true
            self.leadingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.leadingAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.trailingAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
        else {
            self.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
            self.leadingAnchor.constraint(equalTo: parent.leadingAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: parent.trailingAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
        }
    }
}
