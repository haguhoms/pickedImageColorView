//
//  BaseView.swift
//  pickedImageColorView
//
//  Created by masaki hasegawa on 2021/02/07.
//

import Foundation
import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    internal func commonInit() {
        guard let view = Bundle.loadView(instance: self) else {
            return
        }
        self.addSubview(view)
        view.matchParent(self)
    }
}

