//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-08-11.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableViewer: UITableView!
    var Tweets: [Tweet]!
    var refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        //set auto layout.
        tableViewer.dataSource = self
        tableViewer.rowHeight = 150
        tableViewer.estimatedRowHeight = 30
        //refresh control.
        refreshControl.addTarget(self, action: #selector(TimelineViewController.PulledToRefresh(_:)), for: .valueChanged)
        tableViewer.insertSubview(refreshControl, at: 0)
        fetchTweets()
        // Do any additional setup after loading the view.
    }
    
    @objc func PulledToRefresh(_ refreshControl: UIRefreshControl){
        fetchTweets()
    }
    
    //get the getHomeTimeLine function from APIManager.
    func fetchTweets() {
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                self.Tweets = tweets!
                self.tableViewer.reloadData()
            }
        }
    }
    
    @IBAction func onLogOut(_ sender: Any) {
        APIManager.logout()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if Tweets != nil{
            return Tweets!.count
        }
        else{
            return 0}
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
         let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweetVariable = Tweets[indexPath.row]
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
