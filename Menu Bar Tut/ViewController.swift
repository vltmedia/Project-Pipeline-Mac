//
//  ViewController.swift
//  Menu Bar Tut
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
    
    struct MyVariables {
        static var Projroot = "Desk"
        static var completeUrl = URL(fileURLWithPath: MyVariables.Projroot)
        static var Projfolder = "Desk"
        
    }
    
    @IBOutlet weak var lblprint: NSTextField!
    @IBAction func btnPrint(_ sender: Any) {
         MyVariables.completeUrl = URL(fileURLWithPath: MyVariables.Projroot)
        print(MyVariables.completeUrl)
        
        //lblprint.stringValue = completeUrl
        
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
        
        
    }
    @IBOutlet weak var txtProjname: NSTextField!
    override func awakeFromNib() {
        setLabelMessage()
        
        
        
    }
    

    
    
    @IBAction func btnSetProj(_ sender: Any) {
        
        // lblName.stringValue = txtProjname.stringValue
        let Projname = txtProjname.stringValue
       // let fileUrl = NSURL(string: filePath)
        let Filearea = Projroot + Projname
        
          MyVariables.completeUrl = URL(fileURLWithPath: MyVariables.Projroot)
        
        let url1 =  MyVariables.completeUrl.absoluteURL
        print(url1)
        
        let rootarea = MyVariables.Projroot
        
        let url =  url1.absoluteString
print(url)
        
        let projname = txtProjname.stringValue
        
        MyVariables.Projfolder = rootarea + "/" + projname
        
       let folder: URL? = Foundation.URL(string: Filearea)
       
        let Filess  = URL(string: "Filearea")                 //returns a valid URL
       // let invalidURL = URL(string: "www.example.com/This is a sentence")    //Returns nil
        let url2 = MyVariables.Projroot + "/" + Projname
      // let ProjLoc  = URL(string: url)                 //returns a valid URL
        
        
       // let fileManager = FileManager.default
       // let folderbat = "/Users/justinjaro/Desktop/Purple.png"
        
        //do{
        //    try fileManager.copyItem(atPath: "/Users/justinjaro/Desktop/Purple.png", toPath: Projroot)
        //}catch let error as NSError {
        //    print("error occurred, here are the details:\n \(error)")
        //}
        
         //fileManager.createDirectory(atPath: Projname, withIntermediateDirectories: true, attributes: nil)
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        if let pathURL = URL.init(string: rootarea) {
            let dataURL = pathURL.appendingPathComponent(txtProjname.stringValue)
            print(pathURL);
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
        //    NSLog("Document directory is \(filePath)")
      //  }
        
        
    //}
    
    
    
    
    @IBAction func btnOpen(_ sender: Any) {
        
        
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
                print("selected folder is \(path)");
                
                //let Projroot = path
                
                //self.lblName.stringValue = path
                
                // WE SET THE FULL PROJ PATH HERE
                
                //let Projroot = (path + "/" + self.lblName.stringValue)
                
                let Projroot = path
                MyVariables.Projroot = path
               // self.lblprint.stringValue = "file://" + path

             print(Projroot);
                
                
                
                
               //  FileManager.default.createDirectory(atPath: Newproj, withIntermediateDirectories: true, attributes: nil)
                
                
                // self.watchFolderLabel.stringValue = path; //  no need when binding
             //   self.savePref("watchFolder", value: path);
            }
            
            
        }
        
    }
    
    
    @IBAction func Copy(_ sender: Any) {
        
        
        let fileManager = FileManager.default
        
        // Copy 'hello.swift' to 'subfolder/hello.swift'
        
        do {
            try fileManager.copyItem(atPath: "Folder", toPath: "subfolder/hello.swift")
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
        
        
        
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

