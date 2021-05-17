//
//  ViewController.swift
//  ShortURL
//
//  Created by AnkurLahiry on 05/17/2021.
//  Copyright (c) 2021 AnkurLahiry. All rights reserved.
//

import UIKit
import ShortURL

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let shorterURL = ShortURLService()
        shorterURL.delegate = self
    }
}

extension ViewController: ShortURLServiceDelegate {
    func didGenerate(short url: String, for longURL: String) {
        print("Success")
        print("\(url)")
        print("\(longURL)")
    }
    
    func didFailGenerate(for longURL: String, error: Error?) {
        print("Failed")
        print(longURL)
        print("\(String(describing: error))")
    }
}
