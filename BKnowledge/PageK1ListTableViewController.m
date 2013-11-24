//
//  PageK1ListTableViewController.m
//  BKnowledge
//
//  Created by keita inazu on 2013/06/30.
//  Copyright (c) 2013年 keitaInazu. All rights reserved.
//

#import "PageK1ListTableViewController.h"
#import "AppDelegate.h"
#import "PageKDetail.h"

@interface PageK1ListTableViewController () {
    AppDelegate* delegate;
    int rowcount;
    int nowcount;
    NSMutableArray *list;
}

@end

@implementation PageK1ListTableViewController

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
    delegate = [[UIApplication sharedApplication] delegate];
    self.title = @"List";
    list = delegate.resultKList;
    rowcount = [list count];
    nowcount =0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return rowcount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"配列%@",list[0]);
    static NSString *CellIdentifier = @"Cell";
   // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.text =[[list objectAtIndex:nowcount] objectAtIndex:0];
        nowcount++;

    }
    // Configure the cell...
    //cell.textLabel.text =[[list objectAtIndex:nowcount] objectAtIndex:0];
    //nowcount++;
    //return cell;
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
 
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


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


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
    //NSLog(@"中身%@",list[indexPath.row]);
    if(indexPath.row <= rowcount){
        PageKDetail *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"pageKDetail"];
        detail.url = [[list objectAtIndex:indexPath.row] objectAtIndex:1];
        //detail.url = list[indexPath.row];
        [delegate.navigationController pushViewController:detail animated:YES];
    }

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
   // NSLog(@"スクロールされたよ");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pageKList" object:scrollView];
}


@end
