//
//  ViewController.swift
//  CounterJS
//
//  Created by Bruno on 06/06/2020.
//  Copyright © 2020 Bruno. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController {

    @objc dynamic var counterText : String = "loading..."
    @IBOutlet var webView: WKWebView!
    @IBAction func didClickButton(_ sender: Any) {
        webView.evaluateJavaScript("add(1000)", completionHandler: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = Bundle.main.url(forResource: "index", withExtension: "html")!
        webView.configuration.userContentController.add(self, name: "counter")
        webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
    }
}

extension ViewController : WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        counterText = message.body as! String
    }
}
