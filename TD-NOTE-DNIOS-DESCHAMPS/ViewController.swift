//
//  ViewController.swift
//  TD-NOTE-DNIOS-DESCHAMPS
//
//  Created by local192 on 06/01/2020.
//  Copyright © 2020 local192. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var TextNoteTitle: UITextField!
    @IBOutlet weak var textNoteDesc: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func actionNoteSave(_ sender: Any) {
        let newNote = Note(context: context)
        newNote.title = TextNoteTitle.text
        newNote.desc =  textNoteDesc.text
        newNote.date_creation =  NSDate() as Date
        
        ad.saveContext()
        TextNoteTitle.text = ""
        textNoteDesc.text = ""
    }
    
}

