//
//  AttachmentTableViewController.swift
//  EmailAttachment
//
//  Created by Simon Ng on 5/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import MessageUI


class AttachmentTableViewController: UITableViewController {

    enum MINEType: String {
        case jpg = "image/jpeg"
        case png = "image/png"
        case doc = "application/msword"
        case ppt = "application/vnd.ms-powerpoint"
        case html = "text/html"
        case pdf = "application/pdf"
        
        init?(type: String) {
            switch type.lowercased() {
                case "jpg": self = .jpg
                case "png": self = .png
                case "doc": self = .doc
                case "ppt": self = .ppt
                case "html": self = .html
                case "pdf": self = .pdf
                default: return nil
            }
        }
    }
    
    let filenames = ["10 Great iPhone Tips.pdf", "camera-photo-tips.html", "foggy.jpg", "Hello World.ppt", "no more complaint.png", "Why Wyn.doc"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Enable large title
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        return filenames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = filenames[indexPath.row]
        cell.imageView?.image = UIImage(named: "icon\(indexPath.row)");

        return cell
    }
    func showEmail(attachment: String){
        
        // Check if device could sned email
        guard MFMailComposeViewController.canSendMail() else {
            print("This device doesn't allow you to send mail")
            return
        }
        
        let emailTitle = "Great Photo and Doc"
        let messageBody = "Hey, Check this out!"
        let toRecipients = ["k022298@gmail.com"]
        
        // Initialize mail editor and add content
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setSubject(emailTitle)
        mailComposer.setMessageBody(messageBody, isHTML: false)
        mailComposer.setToRecipients(toRecipients)
        
        // Determine file name and file extension
        let fileparts = attachment.components(separatedBy: ".")
        let filename = fileparts[0]
        let fileExtension = fileparts[1]
        
        // Get file path and use NSData to read file
        guard let filePath = Bundle.main.path(forResource: filename, ofType: fileExtension) else {
            return
        }
        
        // Get file data and MINE type
        if let fileData = try? Data(contentsOf: URL(fileURLWithPath: filePath)), let mineType = MINEType(type: fileExtension) {
            
            //  Add attachment
            mailComposer.addAttachmentData(fileData, mimeType: mineType.rawValue, fileName: filename)
            
            // Show mail composer on the screen
            present(mailComposer, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFile = filenames[indexPath.row]
        showEmail(attachment: selectedFile)
    }
    

}
extension AttachmentTableViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result {
        case MFMailComposeResult.cancelled:
            print("Mail cancelled")
        case MFMailComposeResult.saved:
            print("Mail saved")
        case MFMailComposeResult.sent:
            print("Mail sent")
        case MFMailComposeResult.failed:
            print("Failed to send: \(error?.localizedDescription ?? "")")
        }
        
        dismiss(animated: true, completion: nil)
    }
}
