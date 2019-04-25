//
//  PersonModel.swift
//  RutinaGymApp
//
//  Created by Mike on 4/24/19.
//  Copyright © 2019 UTNG. All rights reserved.
//

class PersonModel{
    var id: String?
    var name: String?
    var day: String?
    var muscle: String?
    var exercise: String?
    var repetitions: String?
    
    init(id: String?, name: String?, day: String?,muscle: String?,exercise: String?, repetitions: String?){
        self.id = id
        self.name = name
        self.day = day
        self.muscle = muscle
        self.exercise = exercise
        self.repetitions = repetitions
    }}
