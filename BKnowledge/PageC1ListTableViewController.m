//
//  PageC1ListTableViewController.m
//  BKnowledge
//
//  Created by keita inazu on 2013/07/07.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import "PageC1ListTableViewController.h"
#import "AppDelegate.h"
#import "PageBBSTableViewController.h"
#import "RegistCommViewController.h"

@interface PageC1ListTableViewController () {
    AppDelegate* delegate;
    int rowcount;
    int rssCount;
    int nowcount;
    int nowRSScount;
    NSMutableArray *list;
    NSMutableArray *rssList;
    NSArray *sectionList;
    int nowSection;
}

@end

@implementation PageC1ListTableViewController

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
    // セクション名を設定する
    sectionList =  [NSArray arrayWithObjects:@"Toppic", @"Comment", nil];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //最初に取得
    delegate = [[UIApplication sharedApplication] delegate];
    delegate.navigationController.navigationBarHidden = NO;
    [self selectRSSList];
    [self selectCList];
    self.title = @"Communication";
    list = delegate.resultCList;
    rssList =delegate.resultRSSList;
    rowcount = [list count];
    rssCount =3;
    nowcount =0;
    nowRSScount =0;
    
    
    // バーにプラスボタンを追加
    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTopic)];
    button.style =UIBarButtonItemStyleBordered;
    self.navigationItem.rightBarButtonItem =button;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) selectCList{
    
    //NSMutableArray *param =[[NSMutableArray alloc] initWithObjects:selectCategory, nil];
    MyHttpRequester *httprequester = [MyHttpRequester alloc];
    NSMutableArray *result = [httprequester selectCListRequest];
    // グローバル変数に保存
    delegate.resultCList = result;
}

-(void) selectRSSList{
    MyHttpRequester *httprequester = [MyHttpRequester alloc];
    NSMutableArray *result = [httprequester selectRSSListRequest];
    // グローバル変数に保存
    delegate.resultRSSList = result;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [sectionList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //return 0;
    if(section== 0){
        NSLog(@"koko: %d",[delegate.resultRSSList count]);
        return rssCount;
    }
    return rowcount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //NSLog(@"koremadekoremade:1    %@",[list objectAtIndex:nowcount]);
    //NSLog(@"koremadekoremade:2    %@",[[list objectAtIndex:nowcount] objectAtIndex:0]);
    //NSLog(@"koremadekoremade:3    %@",[[list objectAtIndex:nowcount] objectAtIndex:1]);
    // Configure the cell...
    //cell.textLabel.text =[[list objectAtIndex:nowcount] objectAtIndex:1];
    if(indexPath.section ==0) {
        //NSLog(@"rsscount: %d",nowRSScount);
        //NSLog(@"rssData: %@",[[rssList objectAtIndex:nowRSScount] objectAtIndex:0]);
        cell.textLabel.text =[[rssList objectAtIndex:nowRSScount] objectAtIndex:0];
        nowRSScount++;
    }else {
        cell.textLabel.text =[[list objectAtIndex:nowcount] objectAtIndex:0];
        nowcount++;
    }
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
    if(indexPath.section ==0){
       // NSLog(@"link: %@",[[rssList objectAtIndex:indexPath.row] objectAtIndex:1]);
        //NSLog(@"description: %@",[[rssList objectAtIndex:indexPath.row] objectAtIndex:2]);
        delegate.rss_row =indexPath.row;
        PageBBSTableViewController *bbs = [self.storyboard instantiateViewControllerWithIdentifier:@"pageRSSC"];
        [delegate.navigationController pushViewController:bbs animated:YES];
    }else {
        PageBBSTableViewController *bbs = [self.storyboard instantiateViewControllerWithIdentifier:@"pageBBS"];
        delegate.bbs_id =[[list objectAtIndex:indexPath.row] objectAtIndex:1];
        //detail.url = [[list objectAtIndex:indexPath.row] objectAtIndex:1];
        //detail.url = list[indexPath.row];
        [delegate.navigationController pushViewController:bbs animated:YES];
    }
    
}

/**
 * 指定されたセクションのセクション名を返す
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        nowSection =0;
    }else {
        nowSection =1;
    }
    return [sectionList objectAtIndex:section];
}

-(void) addTopic {
    RegistCommViewController *regist = [self.storyboard instantiateViewControllerWithIdentifier:@"pageRegistComm"];
    [delegate.navigationController pushViewController:regist animated:YES];
}
@end
