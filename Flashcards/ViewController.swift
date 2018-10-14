//
//  ViewController.swift
//  Flashcards
//
//  Created by Agustin Vallejo on 10/13/18.
//  Copyright © 2018 Agustin Vallejo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var btnOne: UIButton!
    @IBOutlet weak var btnTwo: UIButton!
    @IBOutlet weak var btnThree: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //make card view have shadow and round corners
        card.layer.cornerRadius = 20.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        //same for actual labels (prevents shadow from not showing b.c. of clipsToBounds clipping to the round bounds
        backLabel.layer.cornerRadius = 20.0
        backLabel.clipsToBounds = true
        frontLabel.layer.cornerRadius = 20.0
        frontLabel.clipsToBounds = true
        
        //makes buttons have a rounded border radius of Color Literal color
        btnOne.layer.cornerRadius = 20.0
        btnOne.layer.borderWidth = 3.0
        btnOne.layer.borderColor = #colorLiteral(red: 0, green: 0.9131734967, blue: 0.8942715526, alpha: 1)
        btnTwo.layer.cornerRadius = 20.0
        btnTwo.layer.borderWidth = 3.0
        btnTwo.layer.borderColor = #colorLiteral(red: 0, green: 0.9131734967, blue: 0.8942715526, alpha: 1)
        btnThree.layer.cornerRadius = 20.0
        btnThree.layer.borderWidth = 3.0
        btnThree.layer.borderColor = #colorLiteral(red: 0, green: 0.9131734967, blue: 0.8942715526, alpha: 1)
    }


    //still allows for revealing answer functionality
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        frontLabel.isHidden = !frontLabel.isHidden
    }
    
    @IBAction func didTapBtnOne(_ sender: Any) {
        btnOne.isHidden = true
    }
    
    @IBAction func didTapBtnTwo(_ sender: Any) {
        frontLabel.isHidden = true
    }
    
    @IBAction func didTapBtnThree(_ sender: Any) {
        btnThree.isHidden = true
    }
    
    //trying to commit w/ git global config as me
}

