//
//  ViewController.swift
//  PROJECT PIPELINE
//
//  Created by Justin Jaro on 5/7/18.
//  Copyright © 2018 Justin Jaro. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    var statusBar = NSStatusBar.system
    var statusBarItem : NSStatusItem = NSStatusItem()
    var leMenu : NSMenu = NSMenu()
    var openMenuItem : NSMenuItem = NSMenuItem()
    var exitMenuItem : NSMenuItem = NSMenuItem()
    
    var ProjLoc = "Poop"
    
    var Projroot : String = ""
    //var Projroot : String
    
    
    
    // VARIABLES THAT WE KEEP
    struct MyVariables {
        
        static var Projroot = "/Library/Application Support/VLT"
        static var completeUrl = URL(fileURLWithPath: MyVariables.Projroot)
        static var Projname = "Name"
        static var Projfolder = "/Library/Application Support/VLT/Folders.rtf"
        static var Pathall = Projroot + "/" + Projname
        static var Folderbat = "/Users/justinjaro/Documents/VLT/Screen.png"
        static var libpaths = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .localDomainMask, true)
        static var appSupportDir = libpaths[0] + "/VLT/Folder"
        
        
    }
    
    @IBOutlet weak var lblprint: NSTextField!
    @IBOutlet weak var txtbigbox: NSTextField!
    @IBAction func btnPrint(_ sender: Any) {
        
        /// THIS IS MY TESTING BUTTON*****
        
        
        //let fullpath = MyVariables.Projroot + MyVariables.Projfolder
        
       
         MyVariables.completeUrl = URL(fileURLWithPath: MyVariables.Projroot)
        
        // SET FILE TO MOVE TO URL
        let FileMove = URL(fileURLWithPath:MyVariables.appSupportDir)
        
        
       // SET PROJECT FOLDER DIR TO MOVE TO URL
        let Copypath = URL(fileURLWithPath:MyVariables.Projfolder)
        
        
         // SET REMOVE FILE IF THERE
        let removefile = MyVariables.Projfolder + "/Folders"
        
    
        
        let fileManager = FileManager.default
      
        //******* TRIED THIS DIDN'T WORK**********
        //   let Datafile = fileManager.contents(atPath: storeURL)
      //  fileManager.createFile(atPath: Copypath, contents: Datafile,
        //                           attributes: nil)
        
        
        // I need to copy the file Folder into the Projfolder and launch it
        
        
        
         // DELETE FILE
        do
        {
            try fileManager.removeItem(atPath: removefile)
            
        }
        catch let error as NSError {
            print("Remove:\n \(error)")
        }
        
        
        // MOVE ITEM......I GET FILE EXISTS EVEN THOUGH IT WAS TAKEN OUT UP TOP
        do {
             let fileManager = FileManager.default
            try fileManager.moveItem(at: FileMove, to: Copypath)
    }catch let error as NSError {
    print("Move:\n \(error)")
        }
        
        
        // Get contents in directory: '.' (current one)
     
        
        
        // Launches batch file in APP Support
        //NSWorkspace.shared.openFile(MyVariables.appSupportDir)

    }
    @IBAction func btnFolder(_ sender: Any) {
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        if let pathURL = URL.init(string: paths[0]) {
            let dataURL = pathURL.appendingPathComponent("MyFolder")
            do {
                try FileManager.default.createDirectory(atPath: dataURL.absoluteString, withIntermediateDirectories: true, attributes: nil)
            } catch let error as NSError {
                print(error.localizedDescription);
            }
        }
        else {
            print("Error in getting path URL");
        }
        
    }
    @IBOutlet weak var lblName: NSTextField!
    @IBAction func btnOpenproj(_ sender: Any) {
        
        let projfolder = MyVariables.Projfolder
        
        
        NSWorkspace.shared.openFile(projfolder)
        
        print("Opened folder:",projfolder)
       
    }
    @IBOutlet weak var txtProjname: NSTextField!
    override func awakeFromNib() {
        setLabelMessage()
        
        
        
    }
    

    
    
    @IBAction func btnSetProj(_ sender: Any) {
    
        
        MyVariables.completeUrl = URL(fileURLWithPath: MyVariables.Projroot)
        
    
        
        let rootarea = MyVariables.Projroot
        
        
        let projname = txtProjname.stringValue
        
        MyVariables.Projfolder = rootarea + "/" + projname
        
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        if let pathURL = URL.init(string: rootarea) {
            let dataURL = pathURL.appendingPathComponent(txtProjname.stringValue)
          //  print(pathURL);
            do {
                try FileManager.default.createDirectory(atPath: dataURL.absoluteString, withIntermediateDirectories: true, attributes: nil)
            } catch let error as NSError {
                print(error.localizedDescription);
            }
        }
        else {
            print("Error in getting path URL");
        }
        
        // **** DO THE FILE COPY HEREEEEEEEEEEE
        
        
        print("Project folder is:", MyVariables.Projfolder)
        
    }
    //    NSLog("Document directory is \(filePath)")
    //  }

    
        
        
    
    
    
    
    @IBAction func btnOpen(_ sender: Any) {
        
        //Chose Root Project Folder
        
        let openPanel = NSOpenPanel();
        openPanel.title = "Select a folder to watch for videos"
        openPanel.message = "Videos you drop in the folder you select will be converted to animated gifs"
        openPanel.showsResizeIndicator=true;
        openPanel.canChooseDirectories = true;
        openPanel.canChooseFiles = false;
        openPanel.allowsMultipleSelection = false;
        openPanel.canCreateDirectories = true;
        openPanel.delegate = self as? NSOpenSavePanelDelegate;
        
        openPanel.begin { (result) -> Void in
            if(result.rawValue == NSApplication.ModalResponse.OK.rawValue){
                let path = openPanel.url!.path
                //print("selected folder is \(path)");
                
                // Sets Projec Root folder up top in the global
                MyVariables.Projroot = path
             print(MyVariables.Projroot);
                
                
                
            }
            
            
        }
        
    }
    
    
    @IBAction func Copy(_ sender: Any) {
        
        //DON'T WORRY ************
        
        
        
        
        
    }
    
    
    
    
       override func viewDidLoad() {
       super.viewDidLoad()
   
       statusBarItem = statusBar.statusItem(withLength: -1)
       statusBarItem.menu = leMenu
        
        openMenuItem.title = "Open"
        openMenuItem.target = self
        openMenuItem.action = #selector(setWindowVisible)
        openMenuItem.keyEquivalent = ""
        openMenuItem.isEnabled = true
        
        openMenuItem.title = "Project Folder"
        openMenuItem.target = self
        openMenuItem.action = #selector(setWindowVisible)
        openMenuItem.keyEquivalent = ""
        openMenuItem.isEnabled = true
        
        exitMenuItem.title = "Quit"
        exitMenuItem.target = self
        exitMenuItem.action = #selector(setWindowVisible)
        exitMenuItem.keyEquivalent = ""
        
        leMenu.addItem(openMenuItem)
        leMenu.addItem(exitMenuItem)
        setLabelMessage()
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    @IBOutlet weak var theLabel: NSTextField!
    @IBOutlet weak var theButton: NSButton!
    @IBAction func theButton(_ sender: NSButton) {
        //DON'T WORRY ************
        
        
        buttonPresses += 1
        setLabelMessage()
    }
    
    var buttonPresses = 0
    
    func setLabelMessage() {
        theLabel.stringValue = "You've pressed the button \(buttonPresses) times."
        statusBarItem.button?.title = "Presses: \(buttonPresses)"
    }
    
    @objc func setWindowVisible(sender: AnyObject) {
        self.view.window!.orderFrontRegardless()
    }
    
    @objc func quit(sender: AnyObject) {
        NSApp.terminate(self)
    }
    
    
    
    
}

