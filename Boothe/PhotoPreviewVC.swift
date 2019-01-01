//
//  PhotoPreviewVC.swift
//  Boothe
//
//  Created by William  Uchegbu on 10/10/18.
//  Copyright © 2018 William  Uchegbu. All rights reserved.
//

import UIKit

class PhotoPreviewVC: UIViewController {
    @IBOutlet weak var photoPreview: UIImageView!
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoPreview.image = image
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func createNode(_ sender: Any) {
        let node = UIImageView(image: #imageLiteral(resourceName: "Node Icon"))
        
        node.frame = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 20, height: 20)
        
        node.isUserInteractionEnabled = true
        node.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
        self.view.addSubview(node)
        
    }
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        recognizer.setTranslation(.zero, in: self.view)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
