//
//  ViewController.swift
//  Isgokc
//
//  Created by Feras Salous  on 5/28/19.
//  Copyright © 2019 Feras Salous . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //displays dua
    @IBOutlet var duaDisplayed:UITextView!
    //array for saved duas
    var duaSaved : [String] = []
    //displays ayat
    @IBOutlet var ayahDisplayed:UITextView!
    //array of saved ayah
    var ayahSaved:[String] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readDuaFile()
        readAyahFile()
    }
    /*
     This Function reads my dua file and generates a random dua upon opening of iphone app
     */
    func readDuaFile()
    {
        let fileURLPath = Bundle.main.path(forResource: "testtest2", ofType: "txt" )
        var readString: String = ""
        do
        {
            readString = try String(contentsOfFile: fileURLPath!, encoding: String.Encoding.utf8)
        }
        catch let error as NSError
        {
            print("Failed")
            print(error)
        }
        print(readString)
        let duaSaved : [String] = readString.components(separatedBy: "***")
        duaDisplayed.text = duaSaved.randomElement()
    }
    
    func readAyahFile()
    {
        let fileURLPath = Bundle.main.path(forResource: "ayay", ofType: "txt" )
        var readString: String = ""
        do
        {
            readString = try String(contentsOfFile: fileURLPath!, encoding: String.Encoding.utf8)
        }
        catch let error as NSError
        {
            print("Failed")
            print(error)
        }
        print(readString)
        let _ayahSaved : [String] = readString.components(separatedBy: "***")
        ayahDisplayed.text = _ayahSaved.randomElement()
    }
}

