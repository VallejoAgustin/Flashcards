//
//  ViewController.swift
//  Flashcards
//
//  Created by Agustin Vallejo on 10/13/18.
//  Copyright © 2018 Agustin Vallejo. All rights reserved.
//

import UIKit

struct Flashcard{
    var question: String
    var answer: String
}

class ViewController: UIViewController {
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    
    //array to hold flashcards
    var flashcards = [Flashcard]()
    //to keep track of current card
    var currentIndex = 0
    
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var btnOne: UIButton!
    @IBOutlet weak var btnTwo: UIButton!
    @IBOutlet weak var btnThree: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
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

        readSavedFlashcards()

        if(flashcards.count == 0){
            updateFlashcard(question: "What's the capital of Brazil?", answer: "Brasilia")
        }
        else{
            updateLabels()
            updatePrevNextButtons()
        }
    }


    //still allows for revealing answer functionality
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        frontLabel.isHidden = !frontLabel.isHidden
    }
    
    func updateFlashcard(question: String, answer: String){
        let flashcard = Flashcard(question: question, answer: answer)
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        btnTwo.setTitle(answer, for: .normal)
        
        //pushing onto the stack
        flashcards.append(flashcard)
        currentIndex = flashcards.count - 1
        print("Added new card")
        
        updatePrevNextButtons()
        
        updateLabels()
        
        saveAllFlashcardsToDisk()
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
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex -= 1
        
        updateLabels()
        
        updatePrevNextButtons()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex += 1
        
        //update card
        updateLabels()
        
        updatePrevNextButtons()
    }
    
    func updatePrevNextButtons(){
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        }
        else {
            nextButton.isEnabled = true
        }
        
        if currentIndex == 0 {
            prevButton.isEnabled = false
        }
        else{
            prevButton.isEnabled = true
        }
    }
    
    func updateLabels(){
        let currentFlashcard = flashcards[currentIndex]
        
        //update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
        
        //updates the answer (button 2)
        btnTwo.setTitle(currentFlashcard.answer, for: .normal)
    }
    
    func saveAllFlashcardsToDisk(){
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        
        //save array on disk using user defaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("Flashcards saved to user defaults")
    }
    
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]]{
            let savedCards = dictionaryArray.map{ dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            
            //put all cards in our array
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
        
        if(segue.identifier == "EditSegue"){
            creationController.initialQuestion = frontLabel.text!
            creationController.initialAnswer = backLabel.text!
        }
    }
    
    //trying to commit w/ git global config as me
}

