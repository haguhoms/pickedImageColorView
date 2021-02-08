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
        self.pickedImageColorView.setImage("https://zukan.pokemon.co.jp/zukan-api/up/images/index/7659ce2b6e793d5df430205199c7203a.png")
    }

}

