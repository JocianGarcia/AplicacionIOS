//
//  ViewController.swift
//  RutinaGymApp
//
//  Created by Mike on 4/24/19.
//  Copyright © 2019 UTNG. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //creating a cell using the custom class
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        //the artist object
        let person: PersonModel
        
        //getting the artist of selected position
        person = personList[indexPath.row]
        
        //adding values to labels
        cell.lblName.text = person.name
        cell.lblDay.text = person.day
        cell.lblMuscle.text = person.muscle
        cell.lblExercise.text = person.exercise
        cell.lblRepetitions.text = person.repetitions
        
        //returning cell
        return cell
    }
     var personList = [PersonModel]()
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldDay: UITextField!
    @IBOutlet weak var textFieldMuscle: UITextField!
    @IBOutlet weak var textFieldExercises: UITextField!
    @IBOutlet weak var textFieldRepetitions: UITextField!
    @IBOutlet weak var tblPersons: UITableView!
    
    @IBAction func buttonAddRutina(_ sender: UIButton) {
        addPerson()
    }
    
    @IBOutlet weak var labelMessage: UILabel!
    
    //this function will be called when a row is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //getting the selected artist
        let person  = personList[indexPath.row]
        
        //building an alert
        let alertController = UIAlertController(title: person.name, message: "Dame los valores a Actualizar", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Actualizar", style: .default) { (_) in
            
            //getting artist id
            let id = person.id
            
            //getting new values
            let name = alertController.textFields?[0].text
            let day = alertController.textFields?[1].text
            let muscle = alertController.textFields?[2].text
            let exercise = alertController.textFields?[3].text
            let repetitions = alertController.textFields?[4].text
            
            //calling the update method to update artist
            self.updatePerson(id: id!, name: name!, day: day!, muscle: muscle!, exercise: exercise!, repetitions: repetitions!)
        }
        
        let cancelAction = UIAlertAction(title: "Eliminar", style: .cancel) { (_) in
            //deleting artist
            self.deletePerson(id: person.id!)
        }
        //adding two textfields to alert
        alertController.addTextField { (textField) in
            textField.text = person.name
        }
        alertController.addTextField { (textField) in
            textField.text = person.day
        }
        alertController.addTextField { (textField) in
            textField.text = person.muscle
        }
        alertController.addTextField { (textField) in
            textField.text = person.exercise
        }
        alertController.addTextField { (textField) in
            textField.text = person.repetitions
        }
        
        //adding action
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //presenting dialog
        present(alertController, animated: true, completion: nil)
    }
    
    func updatePerson(id:String, name:String, day:String, muscle:String, exercise: String, repetitions:String){
        //creating artist with the new given values
        let person = ["id":id,
                      "Name": name,
                      "Day": day,
                      "Muscle":muscle,
                      "Exercise":exercise,
                      "Repetitions":repetitions
        ]
        
        //updating the artist using the key of the artist
        refPersons.child(id).setValue(person)
        
    }
    
    func deletePerson(id:String){
        refPersons.child(id).setValue(nil)
        
    }
    
    
    var refPersons: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        FirebaseApp.configure()
        
        //getting a reference to the node artists
        refPersons = Database.database().reference().child("Persons");
        
        //observing the data changes
        refPersons.observe(DataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                //clearing the list
                self.personList.removeAll()
                
                //iterating through all the values
                for artists in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let artistObject = artists.value as? [String: AnyObject]
                    let name  = artistObject?["Name"]
                    let id  = artistObject?["id"]
                    let day = artistObject?["Day"]
                    let muscle = artistObject?["Muscle"]
                    let exercise = artistObject?["Exercise"]
                    let repetitions = artistObject?["Repetitions"]
                    
                    //creating artist object with model and fetched values
                    let person = PersonModel(id: id as! String?, name: name as! String?, day: day as! String?, muscle: muscle as! String?, exercise: exercise as! String?, repetitions: repetitions as! String?)
                    
                    //appending it to list
                    self.personList.append(person)
                }
                
                //reloading the tableview
                self.tblPersons.reloadData()
            }
        })
        
    }
    
    func addPerson(){
        let key = refPersons.childByAutoId().key
        
       
        let person = ["id":key,
                      "Name": textFieldName.text! as String,
                      "Day": textFieldDay.text! as String,
                      "Muscle": textFieldMuscle.text! as String,
                      "Exercise": textFieldExercises.text! as String,
                      "Repetitions": textFieldRepetitions.text! as String
            
        ]
        
        refPersons.child(key ?? "a").setValue(person)
        
    }


}


