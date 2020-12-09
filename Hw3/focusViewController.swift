//
//  focusViewController.swift
//  Hw3
//
//  Created by codeplus on 2/25/20.
//  Copyright © 2020 CS290. All rights reserved.
//

import UIKit

class focusViewController: UIViewController {

    var nameText: String = ""
    var statusText: String = ""
    var speciesText: String = ""
    var originText: String = ""
    var nameImage: UIImage?
    var backgroundImage: UIImage?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var namePicture: UIImageView!
    @IBOutlet weak var backgroundPicture: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = nameText
        statusLabel.text = "Status: " + statusText
        speciesLabel.text = "Species: " + speciesText
        originLabel.text = "Origin Planet: " + originText
        namePicture.image = nameImage
        backgroundPicture.image = backgroundImage
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
