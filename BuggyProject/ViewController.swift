//
//  ViewController.swift
//  BuggyProject
//
//  Created by Benjamin Wu on 1/6/16.
//  Copyright © 2016 IntrepidPursuits. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField?
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var validImageView: UIView?
    var searches: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        validImageView?.backgroundColor = UIColor.red
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.textFieldDidChange(_:)), name: NSNotification.Name.UITextFieldTextDidChange , object: self.textField);
    }

    // MARK: Actions
    // TODO: Rename this
    @IBAction func goButtonTapped() {
        let request = imgurURLRequest()
        imageView?.setImageWith(request, placeholderImage: nil, success: { [weak self] (request, response, image) in
            print("success")
            guard let strongSelf = self else { return } // strong reference to weak self
            strongSelf.imageView?.image = image
        }, failure: { (request, response, error) in
            print("error: \(error)")
        })
    }

    @IBAction func searchesTapped() {
    }

    // MARK: Helpers

    func imgurURLRequest() -> URLRequest {
        // sample: WPOBwNC
        let urlString = String(format: "http://i.imgur.com/%@.png", (textField?.text)!)
        return URLRequest(url: URL(string: urlString)!)
    }

    func isValidString(_ stringToCheck: String?) -> Bool {
        guard let stringLength = stringToCheck?.characters.count else { return false }
        return stringLength >= 4 && stringLength <= 7
    }

    func textFieldDidChange(_ notification: Notification) {
        if isValidString(self.textField?.text) {
            validImageView?.backgroundColor = UIColor.green
        } else {
            validImageView?.backgroundColor = UIColor.red
        }
    }
}

