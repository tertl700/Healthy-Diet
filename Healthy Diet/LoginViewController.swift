//
//  ViewController.swift
//  Healthy Diet
//
//  Created by Tommy Ertl on 3/21/19.
//  Copyright © 2019 Tommy Ertl. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        spinner.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.performSegue(withIdentifier: "createAccountSegue", sender: Any?.self)
        }
    }

}

