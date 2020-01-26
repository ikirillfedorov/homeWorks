//
//  DirectoryViewController.swift
//  HW 33-34 UITableView Navigation
//
//  Created by Kirill Fedorov on 11/06/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

class DirectoryViewController: UITableViewController {
    
    var path = String()
    var contents = [String]()
    
    init(folderPath: String, style: UITableView.Style) {
        
        self.path = folderPath
        do {
            self.contents = try FileManager.default.contentsOfDirectory(atPath: self.path)
        } catch let error as NSError {
            print("Error = \(error)")
        }
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.path.lastPathComponent()
        
        let addFolderBarButton = UIBarButtonItem(title: "Add folder",
                                                 style: UIBarButtonItem.Style.done,
                                                 target: self,
                                                 action: #selector(addFolderAction))
        
        let editBarButton = UIBarButtonItem(title: "edit",
                                            style: UIBarButtonItem.Style.done,
                                            target: self,
                                            action: #selector(actionEdit))
        
        self.navigationItem.rightBarButtonItems = [editBarButton, addFolderBarButton]
        self.contents = sortContent(contents: self.contents)
        hideHiddenFiles()
    }
    
    //MARK: - Help functions
    private func isDirectoryAt(fileName: String) -> Bool {
        let fileManager = FileManager.default
        var isDirectory: ObjCBool = false
        let filePath = self.path.appendingPathComponent(String: fileName)
        if fileManager.fileExists(atPath: filePath, isDirectory:&isDirectory) {
            isDirectory = isDirectory.boolValue ? true : false
        }
        return isDirectory.boolValue
    }
    
    private func sortContent(contents:[String]) -> [String] {
        var folders = [String]()
        var files = [String]()
        for objName in self.contents {
            if isDirectoryAt(fileName: objName) {
                folders.append(objName)
            } else {
                files.append(objName)
            }
        }
        return folders.sorted(by: {$0 < $1}) + files.sorted(by: {$0 < $1})
    }
    
    func hideHiddenFiles() {
        self.contents.removeAll(where: {$0.hasPrefix(".")})
    }
    
    func fileSize(path: String) -> UInt64 {
        var fileSize : UInt64 = UInt64()
        
        do {
            let attr = try FileManager.default.attributesOfItem(atPath: path)
            fileSize = attr[FileAttributeKey.size] as! UInt64
            
            let dict = attr as NSDictionary
            fileSize = dict.fileSize()
        } catch {
            print("Error: \(error)")
        }
        return fileSize
    }
    
    func convertFileSize(from size: UInt64) -> String {
        let units = ["B", "KB", "MB", "GB", "TB"]
        var index = 0
        var fileSize = (Double)(size)
        while fileSize > 1024 && index < units.count {
            fileSize /= 1024
            index += 1
        }
        return "\((Int)(fileSize)) \(units[index])"
    }
    
    func folderSize(from folderPath: String) -> UInt64 {
        var resultSize: UInt64 = 0
        let fileName = folderPath.lastPathComponent()
        if isDirectoryAt(fileName: fileName) {
            guard let newFiles = FileManager.default.subpaths(atPath: folderPath) else { return 0}
            for file in newFiles {
                resultSize += fileSize(path: folderPath.appendingPathComponent(String: file))
            }
        } else {
            resultSize += fileSize(path: fileName)
        }
        return resultSize
    }
    
    //MARK: - Actions
    @objc func addFolderAction(sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Enter new folder name", message: "Enter name for creating folder", preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (alert: UIAlertAction!) in
            let newFolderName = alertController.textFields?.first?.text ?? "New Folder"
            let newFolderPath = self.path.appendingPathComponent(String: newFolderName)
            do {
                try FileManager.default.createDirectory(atPath: newFolderPath, withIntermediateDirectories: true, attributes: nil)
            } catch let error as NSError {
                print("Error = \(error)")
            }
            
            if !(self.contents.contains(newFolderName)) && newFolderName != "" {
                self.contents.insert(newFolderName, at: 0)
                self.tableView.beginUpdates()
                let newIndexPath = NSIndexPath.init(row: 0, section: 0)
                self.tableView.insertRows(at: [newIndexPath as IndexPath], with: UITableView.RowAnimation.left)
                self.tableView.endUpdates()
            }
        })
        
        alertController.addTextField(configurationHandler: { (UITextField) in
            UITextField.placeholder = "Enter folder name here"
            UITextField.textAlignment = .center
        })
        
        alertController.addAction(action)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
        
        
    }
    
    @objc func actionEdit() {
        let isEditing = tableView.isEditing
        tableView.setEditing(!isEditing, animated: true)
        
        let editingBarButton = UIBarButtonItem(barButtonSystemItem: isEditing ? .edit : .done, target: self, action: #selector(actionEdit))
        
        if var tempArray = navigationItem.rightBarButtonItems {
            tempArray[1] = editingBarButton
        }
    }
}

// MARK: - UITableViewDataSource
extension DirectoryViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifire = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifire) ?? UITableViewCell(style: .value1, reuseIdentifier: identifire)
        
        // Configure the cell...
        if isDirectoryAt(fileName: (self.contents[indexPath.row])) {
            cell.detailTextLabel?.text = convertFileSize(from: folderSize(from: self.path.appendingPathComponent(String: self.contents[indexPath.row])))
        } else {
            cell.detailTextLabel?.text = convertFileSize(from: fileSize(path: self.path.appendingPathComponent(String: self.contents[indexPath.row])))
        }
        
        let fileName = self.contents[indexPath.row]
        cell.textLabel?.text = fileName
        cell.imageView?.image = isDirectoryAt(fileName: fileName) ? UIImage(named: "folder.png") : UIImage(named: "file.png")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let removeObjectPath = (self.path as NSString).appendingPathComponent(self.contents[indexPath.row])
            self.contents.remove(at: indexPath.row)
            
            do {
                try FileManager.default.removeItem(atPath: removeObjectPath)
            } catch let error as NSError {
                print("Error = \(error)")
            }
            
            self.tableView.beginUpdates()
            let newIndexPath = NSIndexPath.init(row: indexPath.row, section: indexPath.section)
            self.tableView.deleteRows(at: [newIndexPath as IndexPath], with: UITableView.RowAnimation.left)
            self.tableView.endUpdates()
        }
    }
}

// MARK: - UITableViewDelegate
extension DirectoryViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let fileName = self.contents[indexPath.row]
        
        if isDirectoryAt(fileName: fileName) {
            let path = self.path.appendingPathComponent(String: fileName)
            let vc = DirectoryViewController(folderPath: path, style: .plain)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - Extensions
extension String  {
    func appendingPathComponent(String: String) -> String {
        return (self as NSString).appendingPathComponent(String)
    }
    func lastPathComponent() -> String {
        return String((self as NSString).lastPathComponent)
    }
}

