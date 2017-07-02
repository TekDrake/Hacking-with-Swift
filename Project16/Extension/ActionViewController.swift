//
//  ActionViewController.swift
//  Extension
//
//  Created by Juan Garcia on 6/29/17.
//  Copyright © 2017 Juan Garcia. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {
    
    @IBOutlet weak var script: UITextView!
    
    var pageTitle = ""
    var pageURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        
        if let inputItem = extensionContext!.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first as? NSItemProvider {
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [unowned self] (dict, error) in
                    
                    let itemDictionary = dict as! NSDictionary
                    let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as! NSDictionary
                    
                    //print(javaScriptValues)
                    
                    if let title = javaScriptValues["title"] {
                        self.pageTitle = title as! String
                    }
                    if let page = javaScriptValues["URL"] {
                        self.pageURL = page as! String
                    }
                    
                    if !self.pageTitle.isEmpty {
                        DispatchQueue.main.async {
                            self.title = self.pageTitle
                        }
                    }
                }
            }
        }
        
        // Get the item[s] we're handling from the extension context.
        
        // For example, look for an image and place it into an image view.
        // Replace this with something appropriate for the type[s] your extension supports.
        //        var imageFound = false
        //        for item in self.extensionContext!.inputItems as! [NSExtensionItem] {
        //            for provider in item.attachments! as! [NSItemProvider] {
        //                if provider.hasItemConformingToTypeIdentifier(kUTTypeImage as String) {
        //                    // This is an image. We'll load it, then place it in our image view.
        //                    weak var weakImageView = self.imageView
        //                    provider.loadItem(forTypeIdentifier: kUTTypeImage as String, options: nil, completionHandler: { (imageURL, error) in
        //                        OperationQueue.main.addOperation {
        //                            if let strongImageView = weakImageView {
        //                                if let imageURL = imageURL as? URL {
        //                                    strongImageView.image = UIImage(data: try! Data(contentsOf: imageURL))
        //                                }
        //                            }
        //                        }
        //                    })
        //
        //                    imageFound = true
        //                    break
        //                }
        //            }
        //
        //            if (imageFound) {
        //                // We only handle one image, so stop looking for more.
        //                break
        //            }
        //        }
        
        // Adding keyboard notifications
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func done() {
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": script.text]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        
        extensionContext!.completeRequest(returningItems: [item])
    }
    
    //  MARK: - Keyboard notification
    
    func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
            script.contentInset = UIEdgeInsets.zero
        } else {
            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        script.scrollIndicatorInsets = script.contentInset
        
        let selectedRange = script.selectedRange
        script.scrollRangeToVisible(selectedRange)
    }
    
}
