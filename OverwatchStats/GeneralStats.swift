import UIKit
import Alamofire
import SDWebImage
import SVProgressHUD

class GeneralStats:UIViewController{

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var levelNum: UILabel!
    @IBOutlet weak var quickPlayTitle: UILabel!
    @IBOutlet weak var competitivePlayTitle: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var competitiveRankLabel: UILabel!
    @IBOutlet weak var competitiveRankNum: UILabel!
    @IBOutlet weak var quickPercent: UILabel!
    @IBOutlet weak var compPercent: UILabel!
    @IBOutlet weak var compPlayTime: UILabel!
    @IBOutlet weak var quickPlayTime: UILabel!
    
    
    var player:Player? // Player info from last ViewController
    
    override func viewWillAppear(animated: Bool) {
    self.navigationController?.navigationBar.hidden = false
    self.tabBarController?.title = "Profile"
    }
    
    override func viewDidLoad() {
        
        SVProgressHUD.showWithStatus("Loading...") // Present loading indicator
        
        /**
         * Pass the player object on to the secondTab which is the HeroStats ViewController
         * Pass the variables quickPTime & compPTime on to the thirdTab which is the PlayTime
         * ViewController.
         **/
        
        
        let secondTab = self.tabBarController?.viewControllers![1] as! QuickHeroStats
        secondTab.player = self.player
        
        let thirdTab =  self.tabBarController?.viewControllers![2] as! CompHeroStats
        thirdTab.player = self.player
        
        /**
         * Update interface
         **/
        
        self.nameLabel.text = player!.name
        self.levelNum.text = player!.level
        
        if(player!.compRank == ""){
            player!.compRank = "N/A"
        }
        self.competitiveRankNum.text = player!.compRank
        self.quickPercent.text = player!.totalQWinPerc
        self.compPercent.text = player!.totalCWinPerc
        self.compPlayTime.text = player!.cTime
        self.quickPlayTime.text = player!.qTime
        
        
        /*
         * Circular UIImageView
         **/
        self.avatarImage.layer.cornerRadius = 10.0
        self.avatarImage.clipsToBounds = true;
        
        /**
         * Border for UIImageView
         **/
        self.avatarImage.layer.borderWidth = 3.0
        self.avatarImage.layer.borderColor = UIColor.blackColor().CGColor
        
        /**
         * Setup image using SDWebImage Library
         **/
        self.avatarImage.sd_setImageWithURL(NSURL(string: player!.avatar))
        
    }
}





