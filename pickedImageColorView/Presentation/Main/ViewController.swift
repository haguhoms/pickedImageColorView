//
//  ViewController.swift
//  pickedImageColorView
//
//  Created by masaki hasegawa on 2021/02/05.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var pickedImageColorView: PickedImageColorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.pickedImageColorView.setImage("https://1.bp.blogspot.com/-aE1d5IM9FuY/XwkxlUXaVYI/AAAAAAABaC4/5Y9ueDFkL-ktyOHXczaj5dvlCXieT-pigCNcBGAsYHQ/s400/syougatsu_mark_mochi.png", pickType: .mixed)
    }

}

