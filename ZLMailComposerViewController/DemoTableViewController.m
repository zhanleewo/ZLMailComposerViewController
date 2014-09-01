//
//  DemoTableViewController.m
//  ZLMailComposerViewController
//
//  Created by fonky on 14-8-29.
//  Copyright (c) 2014年 Lin Zhan. All rights reserved.
//

#import "DemoTableViewController.h"
#import "ZLMailComposerViewController.h"

@interface DemoTableViewController ()
@property (nonatomic, strong) NSArray *editModes;
@end

@implementation DemoTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.editModes = @[@"New email", @"Reply email", @"Reply all", @"Forward", @"Redirct", @"Edit draft mail"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.editModes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.editModes[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showMailComposer" sender:indexPath];
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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *nav = segue.destinationViewController;
    ZLMailComposerViewController *composerViewController = (ZLMailComposerViewController *)nav.topViewController;
    NSIndexPath *indexPath = sender;
    NSString *iconPath = [[NSBundle mainBundle] pathForResource:@"avi" ofType:@"png"];
    NSArray *attachments = @[@{@"icon" : iconPath, @"title":@"驯龙高手-1080p.avi", @"src":iconPath, @"type":@"类型:AVI", @"size":@"大小:10.3G", @"error":@"0"}, @{@"icon" : iconPath, @"title":@"敢死队3-1080p.avi", @"src":iconPath, @"type":@"类型:AVI", @"size":@"大小:10.3G", @"error":@"0"}, @{@"icon" : iconPath, @"title":@"蓝精灵2-1080p.avi", @"src":iconPath, @"type":@"类型:AVI", @"size":@"大小:10.3G", @"error":@"0"}];
    
    switch (indexPath.row) {
        case 0://new email
        {
            [composerViewController setupNewComposer];
            break;
        }
        case 1://reply
        {
            [composerViewController setupReplyComposerWithToRecipients:@[@{@"displayName":@"Edward Zhan", @"mailbox":@"test@gmail.com"}]
                                                     andSubject:@"Re:大家早上好"
                                                     andContent:@"\"大家早上好！我是野原新之助，今年五岁\"."];
            break;
        }
        case 2://reply all
        {
            [composerViewController setupReplyAllComposerWithToRecipients:@[@{@"displayName":@"Edward Zhan", @"mailbox":@"test00@gmail.com"}, @{@"displayName":@"James Wang", @"mailbox":@"test01@gmail.com"}]
                                                         andCcRecipients:@[@{@"displayName":@"Edward Zhan", @"mailbox":@"test00@gmail.com"}, @{@"displayName":@"James Wang", @"mailbox":@"test01@gmail.com"}]
                                                     andSubject:@"Re:大家早上好"
                                                     andContent:@"\"大家早上好！我是野原新之助，今年五岁\"."];
            break;
        }
        case 3://forward
        {
            [composerViewController setupForwardComposerWithSubject:@"Fwd:大家早上好"
                                                     andContent:@"\"大家早上好！我是野原新之助，今年五岁\"."
                                                 andAttachments:attachments];
            break;
        }
        case 4://redirect
        {
            [composerViewController setupRedirectComposerWithSubject:@"大家早上好"
                                                  andContent:@"\"大家早上好！我是野原新之助，今年五岁\"."
                                                 andAttachments:attachments];
            break;
        }
        case 5://edit draft mail
        {
            [composerViewController setupDraftComposerWithToRecipients:@[@{@"displayName":@"Edward Zhan", @"mailbox":@"test00@gmail.com"}, @{@"displayName":@"James Wang", @"mailbox":@"test01@gmail.com"}]
                                                         andCcRecipients:@[@{@"displayName":@"Edward Zhan", @"mailbox":@"test00@gmail.com"}, @{@"displayName":@"James Wang", @"mailbox":@"test01@gmail.com"}]
                                                        andBccRecipients:@[@{@"displayName":@"Edward Zhan", @"mailbox":@"test00@gmail.com"}, @{@"displayName":@"James Wang", @"mailbox":@"test01@gmail.com"}]
                                                     andSubject:@"大家早上好"
                                                     andContent:@"\"大家早上好！我是野原新之助，今年五岁\"."
                                                 andAttachments:attachments];
            break;
        }
        default:
        {
            break;
        }
    }
}

@end
