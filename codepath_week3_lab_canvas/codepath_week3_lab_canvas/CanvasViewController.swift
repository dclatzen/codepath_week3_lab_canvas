//
//  CanvasViewController.swift
//  codepath_week3_lab_canvas
//
//  Created by StudyBlue on 10/25/16.
//  Copyright © 2016 myself. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    
    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        trayDownOffset = trayView.frame.height * 0.8
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x, y: trayView.center.y + trayDownOffset)
        
        // end viewDidLoad
    }
    
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            trayOriginalCenter = trayView.center
        } else if sender.state == .changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        } else if sender.state == .ended {
            var velocity = sender.velocity(in: view)
            
            if velocity.y > 0 {
                UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: { () -> Void in
                    self.trayView.center = self.trayDown
                })
            } else {
                UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: { () -> Void in                    self.trayView.center = self.trayUp
                    
                    print ("Tray moved up")
                })
            }
            
        } else {
            print ("Something went wrong.")
        }
        
        // end didPanTray
    }
    
    
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            
            var imageView = sender.view as! UIImageView
            
            // imageView now refers to the face that you panned on.
            newlyCreatedFace = UIImageView(image: imageView.image)
            
            // instantiate a pan gesture recognizer
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPanNewFace(sender:)))
            
            newlyCreatedFace.isUserInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
            
            
            // simulate picking up
            UIView.animate(withDuration: 0.1, animations: {
                self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            })
            
            // Create a new image view that has the same image as the one you're currently panning.
            view.addSubview(newlyCreatedFace)
            
            // Add the new face to the main view.
            newlyCreatedFace.center = imageView.center
            
            // Initialize the position of the new face.
            newlyCreatedFace.center.y += trayView.frame.origin.y
            
            // Since the original face is in the tray, but the new face is in the main view, you have to offset the coordinates.
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
        } else if sender.state == .changed {
            
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        } else if sender.state == .ended {
            // simulate setting down
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: { () -> Void in
                self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
            
        } else {
            print ("Something went wrong.")
        }
    }
    
    func didPanNewFace(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            
            // get the face that we panned on
            newlyCreatedFace = sender.view as! UIImageView
            
            // simulate picking up
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 3, options: [], animations: {
                self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
            })
            
            // so we can offset by translation later
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
        } else if sender.state == .changed {
            
            // pan the face around
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        } else if sender.state == .ended {
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
                self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
