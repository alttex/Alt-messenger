//
//  MessagesViewController.swift
//  Alttex_messager
//
//  Created by Vlad Kovryzhenko on 1/16/18.
//  Copyright © 2018 Vlad Kovryzhenko. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    private let CELL_ID = "Cell";
    private let CHAT_SEGUE = "ChatSegue";
    
    private var contacts = [Contact]();
    
    
    @IBOutlet weak var tableView: UITableView!
    

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath);
        
        //cell.textLabel?.text = contacts[indexPath.row].name;
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: CHAT_SEGUE, sender: nil);
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
