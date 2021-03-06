//
//  Animals.swift
//  AnimalCollector
//
//  Created by Quang Nguyen on 2/12/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import UIKit

class AnimalScore {
    var animals: [String: Animal]
    
    struct Animal {
        var score: Int = 0
    }
    
    init() {
        animals = [
            "sloth": Animal(score: 10),
            "monkey": Animal(score: 10),
            "tiger": Animal(score: 11),
            "lion": Animal(score: 11),
            "bear": Animal(score: 11),
            "eagle": Animal(score: 11),
            "fox": Animal(score: 11),
            "turtle": Animal(score: 11),
            "lemur": Animal(score: 11),
            "cat": Animal(score: 12),
            "fish": Animal(score: 12),
            // TODO add more animals and their scores
            
            // TODO for test remove later
            "jackfruit": Animal(score: 100),
            "capitulum": Animal(score: 101),
            "cliff": Animal(score: 102),
            "dyke": Animal(score: 103),
            
        ]
    }
}
