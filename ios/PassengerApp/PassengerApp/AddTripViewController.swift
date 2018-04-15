//
//  AddTripViewController.swift
//  PassengerApp
//
//  Created by Comonfort on 4/15/18.
//  Copyright © 2018 Comonfort. All rights reserved.
//

import UIKit
import Foundation

class AddTripViewController: UIViewController {
    
    var repetitionDays: [Bool] = []
    
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!
    @IBOutlet weak var sundayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        //self.showAnimate()
        
        //Initializes array of bools to each day
        for _ in 0...6 {
            repetitionDays.append(false)
        }
        
        redrawButtons()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func ok(_ sender: Any) {
        closePopup()
    }
    
    @IBAction func cancel(_ sender: Any) {
        closePopup()
    }
    
    
    @IBAction func toggleRepetition(_ sender: Any) {
        let button = sender as! UIButton
        
        repetitionDays[button.tag] = !repetitionDays[button.tag]
        
        redrawButtons()
    }
    
    func closePopup()
    {
        //self.removeAnimate()
        self.view.removeFromSuperview()
    }
    
    func showAnimate()
    {
        /*
        self.view.transform = self.view.transform.scaledBy(x: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 1.0
            self.view.transform = self.view.transform.scaledBy(x: 1.0, y: 1.0)
        })
        */
    }
    
    func removeAnimate()
    {
        /*
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 0.0
            self.view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        }, completion: {(finished : Bool) in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        })
        */
    }
    
    func redrawButtons()
    {
        if repetitionDays[0]
        {
			mondayButton.backgroundColor = UIColor(red: 134.0/255.0, green: 192.0/255.0, blue: 255.0/255.0, alpha: 255.0/255.0)
			mondayButton.tintColor = UIColor(red: 210/255.0, green: 253.0/255.0, blue: 255.0/255.0, alpha: 255.0/255.0)
        }
        else{
			mondayButton.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
			mondayButton.tintColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 255.0/255.0)
        }
    }
}
