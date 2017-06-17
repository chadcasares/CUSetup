//
//  ViewController.swift
//  CUSetup
//
//  Created by Chad Casares on 2/20/17.
//  Copyright © 2017 Chatham University. All rights reserved.
//

import Cocoa
//import AppKit

class ViewController: NSViewController {
    
    @IBOutlet var talk: NSButton!
    @IBOutlet weak var spinner: NSProgressIndicator!
    @IBAction func talky(_ sender: NSButton!) {
        let path = "/bin/bash"
        let arguments = ["/Library/Chatham/Scripts/userSetup.sh"]
        
        (sender as NSButton).isEnabled=false
        spinner.startAnimation(self)
        
        
        let task = Process.launchedProcess(launchPath: path, arguments: arguments)
        task.waitUntilExit()
    
        
        let alert = NSAlert()
        alert.messageText = "Setup Complete!"
        alert.informativeText = "You will need to restart in order for the changes to take effect."
        alert.addButton(withTitle: "OK")
        
        alert.beginSheetModal(for: self.view.window!, completionHandler: { (returnCode) -> Void in
            if returnCode == NSAlertFirstButtonReturn {
                let path = "/bin/bash"
                let arguments = ["/Library/Chatham/Scripts/logout.sh"]
                
                let logout = Process.launchedProcess(launchPath: path, arguments: arguments)
                logout.waitUntilExit()
                
            }
        })
    
        
        (sender as NSButton).isEnabled=true
        spinner.stopAnimation(self)
        
    }
    //----------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    //----------------------------------------------
    override func viewDidAppear() {
        let presOptions: NSApplicationPresentationOptions = [
            .hideDock,
            .hideMenuBar,
            .disableAppleMenu,
            .disableProcessSwitching,
            .disableSessionTermination,
            .disableHideApplication,
            .autoHideToolbar
        ]
        
        let optionsDictionary = [NSFullScreenModeApplicationPresentationOptions :
            NSNumber(value: presOptions.rawValue as UInt)]
        
        self.view.enterFullScreenMode(NSScreen.main()!, withOptions:optionsDictionary)
        self.view.wantsLayer = true
    }
    
}

