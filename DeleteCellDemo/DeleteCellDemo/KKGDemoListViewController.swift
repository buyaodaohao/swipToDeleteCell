//
//  KKGDemoListViewController.swift
//  DeleteCellDemo
//
//  Created by 云联智慧 on 2021/4/12.
//

import UIKit
//状态栏高度
func kStatusBarHeight() -> CGFloat
{

    if #available(iOS 13.0, *)
    {
        let statusBarManager = UIApplication.shared.windows.first?.windowScene?.statusBarManager
        return CGFloat(statusBarManager?.statusBarFrame.size.height ?? 0.0)
    }
    else
    {
        return CGFloat(UIApplication.shared.statusBarFrame.size.height)
    }
    
}
let SCREEN_W = UIScreen.main.bounds.size.width
let SCREEN_H = UIScreen.main.bounds.size.height

let SafeAreaTopHeight = kStatusBarHeight() + 44.0;
func SafeAreaBottomHeight() -> CGFloat {
    if #available(iOS 11.0, *)
    {
        return CGFloat(UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0)
    }
    else
    {
        return 0.0;
    }
}
class KKGDemoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate var tableView : UITableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain);
    fileprivate var dataArray : Array<String> = Array.init();
    /** 这个变量用来记录用户正在操作的那个cell的indexPath */
    var editingIndexPath : IndexPath?;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.init(red: CGFloat(250.0 / 255.0), green: CGFloat(250.0 / 255.0), blue: CGFloat(250.0 / 255.0), alpha: 1.0);
        self.addFakeDatas();
        self.addChildViews();
    }
    
    //MARK: 创建子视图
    /** 创建子视图 */
    fileprivate func addChildViews ()
    {
        let topNavi : UIImageView = self.createCustomNaviWithTitle(titleStr: "示例");
        self.view.addSubview(topNavi);
        self.tableView.frame = CGRect.init(x: 0.0, y: SafeAreaTopHeight, width: SCREEN_W, height: SCREEN_H - SafeAreaBottomHeight() - SafeAreaTopHeight);
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine;
        self.tableView.showsVerticalScrollIndicator = false;
        self.tableView.tableFooterView = UIView.init();
        self.tableView.backgroundColor = UIColor.init(red: CGFloat(250.0 / 255.0), green: CGFloat(250.0 / 255.0), blue: CGFloat(250.0 / 255.0), alpha: 1.0);
        self.view.addSubview(self.tableView);
    }
    //MARK: 创建假数据
    /** 创建假数据 */
    fileprivate func addFakeDatas ()
    {
        self.dataArray.append(contentsOf: ["文字-标识-删除","图片-标识删除","图片+文字标识删除","不可删除的item"]);
    }
    //MARK: 创建导航栏
    /** 创建导航栏 */
    fileprivate func createCustomNaviWithTitle(titleStr : String) -> UIImageView
    {
        //上方导航栏
        let topNavi : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_W, height: SafeAreaTopHeight));
        let top : CGFloat = 10.0; // 顶端盖高度
        let bottom : CGFloat = 10.0; // 底端盖高度
        let left : CGFloat = 10; // 左端盖宽度
        let right : CGFloat = 10; // 右端盖宽度
        let insets = UIEdgeInsets.init(top: top, left: left, bottom: bottom, right: right);
        topNavi.image = UIImage.init(named: "topNaviBg")?.resizableImage(withCapInsets: insets, resizingMode: UIImage.ResizingMode.stretch);
        topNavi.isUserInteractionEnabled = true;
        //返回按钮
        let backBottomBtn = UIButton.init(frame: CGRect.init(x: 0, y: kStatusBarHeight(), width: 60.0, height: 44.0));
        backBottomBtn.backgroundColor = UIColor.clear;
        backBottomBtn.addTarget(self, action: #selector(goBack), for: UIControl.Event.touchUpInside);
        topNavi.addSubview(backBottomBtn);
        let backButton = UIButton.init(frame: CGRect.init(x: 15.0, y: kStatusBarHeight() + (44.0 - 20.0) / 2.0, width: 11.0, height: 20.0));
        backButton.setImage(UIImage.init(named: "backup"), for: UIControl.State.normal);
        backButton.addTarget(self, action: #selector(goBack), for: UIControl.Event.touchUpInside);
        topNavi.addSubview(backButton);

        //标题栏
        let titleLabel = UILabel.init(frame: CGRect.init(x: backBottomBtn.frame.origin.x, y: kStatusBarHeight(), width: SCREEN_W - backBottomBtn.frame.origin.x - backBottomBtn.frame.origin.x, height: SafeAreaTopHeight - kStatusBarHeight()));
        titleLabel.textAlignment = NSTextAlignment.center;
        titleLabel.textColor = UIColor.white;
        titleLabel.font = UIFont.systemFont(ofSize: 17.0);
        titleLabel.text = (titleStr.count != 0) ? titleStr: "";
        topNavi.addSubview(titleLabel);
        return topNavi;
    }
    //MARK: 返回上一页
    /** 返回上一页 */
    @objc private func goBack ()
    {
        self.navigationController?.popViewController(animated: true);
    }
    //MARK: UITableViewDelegate,UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = String.init(format: "Cell%ld%ld", indexPath.section,indexPath.row);//以indexPath来唯一确定cell
        var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier);//出列可重用的cell
        if (cell == nil)
        {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: cellIdentifier);
        }
        cell!.backgroundColor = UIColor.init(red: CGFloat(250.0 / 255.0), green: CGFloat(250.0 / 255.0), blue: CGFloat(250.0 / 255.0), alpha: 1.0);
        let contentStr = self.dataArray[indexPath.row];
        cell?.textLabel?.text = contentStr;
        
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let subH : CGFloat = 100.0;
        return subH;
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        #warning("在这个方法里，你可以决定哪些行可以执行删除操作，我在这里就进行下简单的示范")
        let contentStr : String = self.dataArray[indexPath.row];
        if(contentStr == "不可删除的item")//不可以删除
        {
            return false;
        }
        else
        {
            return true;
        }
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
    {
        #warning("这里是可编辑的那个cell可以执行哪些操作，枚举类型有三个,none,delete和insert")
        return .delete;
    }
   
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        #warning("delete操作按钮可使用枚举中的destructive类型，当使用该类型时，用户往左侧滑动一定程度时候会直接执行删除操作，不用再点击删除按钮")
        let action = UIContextualAction.init(style: UIContextualAction.Style.destructive, title: "") {[weak self] (contextualAction, view, completion) in
            NSLog(" 进行删除操作");
            tableView.setEditing(false, animated: true);
            self?.dataArray.remove(at: indexPath.row);
            self?.tableView.reloadData();
            
        }
        return UISwipeActionsConfiguration.init(actions: [action]);

    }
//    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?
//    {
//        return "删除";
//    }
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath)
    {
        self.editingIndexPath = indexPath;
        self.view.setNeedsLayout()   // 触发-(void)viewDidLayoutSubviews
    }
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?)
    {
        self.editingIndexPath = nil;
    }
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews();
        if(self.editingIndexPath != nil)
        {
            self.configSwipeButtons();
        }
    }
    //MARK: configSwipeButtons
    fileprivate func configSwipeButtons ()
    {
        // 获取选项按钮的reference
        if #available(iOS 11.0, *)
        {
            
            
            for subview in self.tableView.subviews
            {
                #warning("这个之前版本的，是这个层级，更新完层级有变化，请注意")
                
                // iOS 11层级 (Xcode 12.3编译): UITableView -> _UITableViewCellSwipeContainerView -> UISwipeActionPullView
                 if(subview.isKind(of: NSClassFromString("_UITableViewCellSwipeContainerView")!))
                {
                    for subviewInSubview in subview.subviews
                    {
                        if (subviewInSubview.isKind(of: NSClassFromString("UISwipeActionPullView")!) && subviewInSubview.subviews.count >= 1)
                        {
                            // 和iOS 10的按钮顺序相反
                            let deleteButton : UIButton = subviewInSubview.subviews[0] as! UIButton;
                            
                            self.configDeleteButton(deleteButton: deleteButton);
                        }
                    }
                }
                
            }
        }
        else
        {
            #warning("这个根据以前的代码，拿过来的，具体我这边现在没法测试，请注意")
            // iOS 8-10层级 (Xcode 8编译): UITableView -> UITableViewCell -> UITableViewCellDeleteConfirmationView
            let tableCell : UITableViewCell = self.tableView.cellForRow(at: self.editingIndexPath!)!;
            for subview in tableCell.subviews
            {
                if (subview.isKind(of: NSClassFromString("UITableViewCellDeleteConfirmationView")!) && subview.subviews.count >= 1)
                {
                    let deleteButton : UIButton = subview.subviews[0] as! UIButton;
                    self.configDeleteButton(deleteButton: deleteButton);
                }
            }
        }
        
    }
    //MARK: 自定义配置删除按钮
    /** 自定义配置删除按钮 */
    fileprivate func configDeleteButton(deleteButton : UIButton)
    {
        if #available(iOS 11.0, *)
        {
            #warning("我这里对删除按钮进行分别配置")
            /** 第一行是文字删除，我这里就不添加垃圾桶图片作为删除标识了 */
            if(self.editingIndexPath?.row == 0)
            {
                deleteButton.setTitle("删除", for: UIControl.State.normal);
            }
            else if(self.editingIndexPath?.row == 1)
            {
                deleteButton.setImage(UIImage.init(named: "delete-icon"), for: UIControl.State.normal);
                deleteButton.backgroundColor = UIColor.init(red: CGFloat(250.0 / 255.0), green: CGFloat(250.0 / 255.0), blue: CGFloat(250.0 / 255.0), alpha: 1.0);
            }
            else if(self.editingIndexPath?.row == 2)
            {
                deleteButton.setImage(UIImage.init(named: "delete-icon"), for: UIControl.State.normal);
                deleteButton.setTitle("删除", for: UIControl.State.normal);
                deleteButton.setTitleColor(UIColor.init(red: CGFloat(235.0 / 255.0), green: CGFloat(77.0 / 255.0), blue: CGFloat(61.0 / 255.0), alpha: 1.0), for: UIControl.State.normal);
                deleteButton.backgroundColor = UIColor.init(red: CGFloat(250.0 / 255.0), green: CGFloat(250.0 / 255.0), blue: CGFloat(250.0 / 255.0), alpha: 1.0);
            }
            else
            {
                
            }
            
        }
        else
        {
            let imageView = UIImageView.init(frame: CGRect.init(x: (deleteButton.frame.size.width - 38.0) / 2.0, y: (deleteButton.frame.size.height - 38.0) / 2.0, width: 38.0, height: 38.0));
            imageView.image = UIImage.init(named: "delete-icon");
            imageView.isUserInteractionEnabled = false;
            deleteButton.addSubview(imageView);
        }
        
        
        
    }
}
