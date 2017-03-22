//
//  DetailViewController.swift
//  Project1
//
//  Created by Juan Garcia on 3/21/17.
//  Copyright © 2017 Juan Garcia. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var selectedImage : String?
    
    //MARK - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        if let imageToLoad = selectedImage {
            title = imageToLoad
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
