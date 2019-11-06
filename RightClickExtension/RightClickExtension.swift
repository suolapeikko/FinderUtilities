//
//  RightClickExtension.swift
//  RightClickExtension
//
//  Created by Antti Tulisalo on 27/08/2019.
//  Copyright © 2019 Antti Tulisalo. All rights reserved.
//

import Cocoa
import FinderSync

class FinderSync: FIFinderSync {
    
    override init() {
        super.init()
        
        NSLog("FinderSync() launched from %@", Bundle.main.bundlePath as NSString)
        
        // Set up the directory we are syncing
        FIFinderSyncController.default().directoryURLs = [URL(fileURLWithPath: "/")]
    }
    
    override func menu(for menuKind: FIMenuKind) -> NSMenu {

        // Produce a menu for the extension (to be shown when right clicking a folder in Finder)
        let menu = NSMenu(title: "")
        menu.addItem(withTitle: "Open Terminal", action: #selector(openTerminalClicked(_:)), keyEquivalent: "")
        menu.addItem(withTitle: "Create empty.txt", action: #selector(createEmptyFileClicked(_:)), keyEquivalent: "")
        menu.addItem(withTitle: "Copy selected paths", action: #selector(copyPathToClipboard), keyEquivalent: "")

        return menu
    }

    /// Copies the selected file and/or directory paths to pasteboard
    @IBAction func copyPathToClipboard(_ sender: AnyObject?) {
        
        guard let target = FIFinderSyncController.default().selectedItemURLs() else {
            
            
            NSLog("Failed to obtain targeted URLs: %@")

            return
        }
        
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
        var result = ""
        
        // Loop through all selected paths
        for path in target {
            result.append(contentsOf: path.relativePath)
            result.append("\n")
        }

        pasteboard.setString(result, forType: NSPasteboard.PasteboardType.string)
    }

    /// Opens a macOS Terminal.app window in the user-chosen folder
    @IBAction func openTerminalClicked(_ sender: AnyObject?) {
        
        guard let target = FIFinderSyncController.default().targetedURL() else {
            
            NSLog("Failed to obtain targeted URL: %@")
            
            return
        }
        
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/open")
        task.arguments = ["-a", "terminal", "\(target)"]
        
        do {
            
            try task.run()

        } catch let error as NSError {
            
            NSLog("Failed to open Terminal.app: %@", error.description as NSString)
        }
    }

    /// Creates an empty file with name "untitled" under the user-chosen Finder folder.
    /// If file already exists, append it with a counter.
    @IBAction func createEmptyFileClicked(_ sender: AnyObject?) {
        
        guard let target = FIFinderSyncController.default().targetedURL() else {
            
            NSLog("Failed to obtain targeted URL: %@")
            
            return
        }

        var originalPath = target
        let originalFilename = "newfile"
        var filename = "newfile.txt"
        let fileType = ".txt"
        var counter = 1
        
        while FileManager.default.fileExists(atPath: originalPath.appendingPathComponent(filename).path) {
            filename = "\(originalFilename)\(counter)\(fileType)"
            counter+=1
            originalPath = target
        }
        
        do {
            try "".write(to: target.appendingPathComponent(filename), atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            
            NSLog("Failed to create file: %@", error.description as NSString)
        }
    }
}
