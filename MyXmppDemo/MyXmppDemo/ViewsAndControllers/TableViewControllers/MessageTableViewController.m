//
//  MessageTableViewController.m
//  
//
//  Created by 张广洋 on 15/11/15.
//
//

#import "MessageTableViewController.h"

#import "XMPPManager.h"

#import "MessageModel.h"

#import "MessageTableViewCell.h"

@interface MessageTableViewController ()
<UITextFieldDelegate>
{
    NSMutableArray * _messageArr;
    UITextField * _msgTF;
}
@end

@implementation MessageTableViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _msgTF=[[UITextField alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height/2, [UIScreen mainScreen].bounds.size.width, 40)];
    _msgTF.borderStyle=UITextBorderStyleRoundedRect;
    _msgTF.delegate=self;
    _msgTF.returnKeyType=UIReturnKeySend;
    _msgTF.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:_msgTF];
    
    _messageArr=[[NSMutableArray alloc]init];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveMessage:) name:RECEIVE_MESSAGE object:nil];
}

-(void)didReceiveMessage:(NSNotification *)ntfs{
    [_messageArr addObject:ntfs.object];
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
    return _messageArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageCellId" forIndexPath:indexPath];
    MessageModel * msgModel=_messageArr[indexPath.row];
    if ([msgModel.fromJid containsString:[XMPPManager manager].userName]) {
        cell.label.textAlignment=NSTextAlignmentLeft;
        cell.label.textColor=[UIColor blueColor];
        cell.label.text=[NSString stringWithFormat:@"%@:%@",[XMPPManager manager].userName,msgModel.message];
    }else{
        NSRange range=[self.title rangeOfString:@"@"];
        cell.label.textAlignment=NSTextAlignmentRight;
        cell.label.textColor=[UIColor greenColor];
        cell.label.text=[NSString stringWithFormat:@"%@:%@",msgModel.message,[self.title substringToIndex:range.location]];
    }
    return cell;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    MessageModel * model=[[MessageModel alloc]init];
    model.message=_msgTF.text;
    model.fromJid=[NSString stringWithFormat:@"%@@%@",[XMPPManager manager].userName,[XMPPManager manager].doMainName];
    model.toJid=self.title  ;
    [[XMPPManager manager]sendMessage:model];
    [_messageArr addObject:model];
    [self.tableView reloadData];
    return YES;
}

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
