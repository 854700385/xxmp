//
//  MainTableViewController.m
//  
//
//  Created by 张广洋 on 15/11/15.
//
//

#import "MainTableViewController.h"

#import "XMPPManager.h"

#import "FriendModel.h"

#import "FriendTableViewCell.h"

@interface MainTableViewController ()

@end

@implementation MainTableViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //监听获取好友列表的广播
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(upadteFriendList) name:UPDATE_FRIEND_LIST object:nil];
    //显示登陆界面
    [self showLoginVC];
}

//显示登陆界面
-(void)showLoginVC{
    UIStoryboard * mainSB=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * loginVC=[mainSB instantiateViewControllerWithIdentifier:@"login_VC"];
    [self presentViewController:loginVC animated:NO completion:nil];
}

//更新好友列表
-(void)upadteFriendList{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[XMPPManager manager]getFriendList].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    FriendModel * oneModel=[[XMPPManager manager]getFriendList][indexPath.row];
    cell.userNameLabel.text=oneModel.jid;
    if (![oneModel.status isEqualToString:@"unavailable"]) {
        cell.statusLabel.text=@"在线";
        cell.statusLabel.textColor=[UIColor greenColor];
    }else{
        cell.statusLabel.text=@"不在线";
        cell.statusLabel.textColor=[UIColor grayColor];
    }
    return cell;
}
/*
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendTableViewCell * cell=(FriendTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    if ([cell.statusLabel.text isEqualToString:@"在线"]) {
        
    }
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    [self.tableView indexPathForSelectedRow];
    [segue.destinationViewController setTitle:((FriendModel *)[[XMPPManager manager]getFriendList][[self.tableView indexPathForSelectedRow].row]).jid];
}


@end
