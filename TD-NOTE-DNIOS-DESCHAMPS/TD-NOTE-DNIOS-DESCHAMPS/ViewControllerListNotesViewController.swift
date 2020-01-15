//
//  ViewControllerListNotesViewController.swift
//  TD-NOTE-DNIOS-DESCHAMPS
//
//  Created by local192 on 06/01/2020.
//  Copyright © 2020 local192. All rights reserved.
//


import UIKit
import CoreData

class ViewControllerListNotesViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    var listeNote = [Note]()
    
    @IBOutlet weak var tableViewListNote: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNote()
        tableViewListNote.delegate = self
        tableViewListNote.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadNote()
        tableViewListNote.delegate = self
        tableViewListNote.dataSource = self
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listeNote.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCellNotes = tableView.dequeueReusableCell(withIdentifier: "CellNote", for: indexPath) as! TableViewCellNotes
        cell.setNote(note: listeNote[indexPath.row])
        cell.buttonDeleteNote.tag = indexPath.row
        cell.buttonDeleteNote.addTarget(self, action: #selector(buttonDeleteNoteActivate(_:)), for: .touchUpInside)
        
        cell.buttonEditNote.tag = indexPath.row
        cell.buttonEditNote.addTarget(self, action: #selector(buttonEditNoteActivate(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func buttonEditNoteActivate(_ sender:UIButton){
        print("buttonEditNote Activate index : \(sender.tag)")
        // Appel prepare
        performSegue(withIdentifier: "editOrAddSegue", sender: listeNote[sender.tag])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editOrAddSegue" {
            if let addOrEdit = segue.destination as? ViewController {
                if let mynote = sender as? Note {
                    addOrEdit.editNote = mynote
                }
            }
        }
    }
    
    @objc func buttonDeleteNoteActivate(_ sender: UIButton){
        print("buttonDeleteNote Activate index : \(sender.tag)")
        context.delete(listeNote[sender.tag])
        do {
            try context.save()
        print("buttonDeleteNoteActivate index \(sender.tag) is delete")
        }catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        loadNote()
    }
    
    func loadNote(){
        let fetchRequest:NSFetchRequest<Note> = Note.fetchRequest()
        do{
            listeNote = try context.fetch(fetchRequest)
            tableViewListNote.reloadData()
            print("liste note : ")
            print(listeNote)
        }catch{
            print("Empty database note")
        }
    }
    
    @IBAction func buttonAddNoteAction(_ sender: Any) {
        performSegue(withIdentifier: "editOrAddSegue", sender: nil)
    }
    
}
