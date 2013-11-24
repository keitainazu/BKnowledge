//
//  PageBBSTableViewController.m
//  BKnowledge
//
//  Created by keita inazu on 2013/07/09.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import "PageBBSTableViewController.h"
#import "RegistCommentViewController.h"
#import "AppDelegate.h"

@interface PageBBSTableViewController (){
        AppDelegate* delegate;
        int rowcount;
        int nowcount;
        NSMutableArray *list;
}

@end

@implementation PageBBSTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //最初に取得
    delegate = [[UIApplication sharedApplication] delegate];
    delegate.navigationController.navigationBarHidden = NO;
    //NSLog(@"bbs_id:%@",delegate.bbs_id);
    [self selectBBSList :delegate.bbs_id];
    self.title = @"BBS";
    list = delegate.resultBBSList;
    rowcount = [list count];
    NSLog(@"countのかず%d",rowcount);
    nowcount =0;
    
    
    // バーにボタンを追加
     UIBarButtonItem *button = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addComment)];
                                button.style =UIBarButtonItemStyleBordered;
    self.navigationItem.rightBarButtonItem =button;
    
    
}

-(void) selectBBSList : (NSString *) bbs_id{
    
    //NSMutableArray *param =[[NSMutableArray alloc] initWithObjects:selectCategory, nil];
    MyHttpRequester *httprequester = [MyHttpRequester alloc];
    NSMutableArray *result = [httprequester selectBBSListRequest :bbs_id];
    // グローバル変数に保存
    NSLog(@"result%d",[result count]);
    delegate.resultBBSList = result;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return rowcount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"bbsCell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:2];
    UILabel *descriptionLabel = (UILabel *)[cell viewWithTag:3];
    descriptionLabel.text = [[list objectAtIndex:nowcount] objectAtIndex:0];
    //cell.textLabel.text =[[list objectAtIndex:nowcount] objectAtIndex:0];
    nowcount++;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void) addComment {
    RegistCommentViewController *regist = [self.storyboard instantiateViewControllerWithIdentifier:@"pageRegistComment"];
    //delegate.bbs_id =[[list objectAtIndex:indexPath.row] objectAtIndex:1];
    ///detail.url = [[list objectAtIndex:indexPath.row] objectAtIndex:1];
    //detail.url = list[indexPath.row];
    [delegate.navigationController pushViewController:regist animated:YES];
}

// 最初に描画されるときのメソッド
-(void)viewDidAppear:(BOOL)animated {
        [self selectBBSList :delegate.bbs_id];
}
@end
