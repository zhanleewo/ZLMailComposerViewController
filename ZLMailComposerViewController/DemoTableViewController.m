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
    switch (indexPath.row) {
        case 0://new email
        {
            [composerViewController setupComposer];
            break;
        }
        case 1://reply
        {
            [composerViewController setupComposerWithRecipients:nil
                                                     andSubject:nil
                                                     andContent:nil];
            break;
        }
        case 2://reply all
        {
            [composerViewController setupComposerWithRecipients:nil
                                                         andCCs:nil
                                                     andSubject:nil
                                                     andContent:nil];
            break;
        }
        case 3://forward
        {
            [composerViewController setupComposerWithRecipients:nil
                                                         andCCs:nil
                                                     andSubject:nil
                                                     andContent:nil
                                                 andAttachments:nil];
            break;
        }
        case 4://redirect
        {
            [composerViewController setupComposerWithContent:nil
                                                 andAttachments:nil];
            break;
        }
        case 5://edit draft mail
        {
            [composerViewController setupComposerWithRecipients:nil
                                                         andCCs:nil
                                                        andBCCs:nil
                                                     andSubject:nil
                                                     andContent:nil
                                                 andAttachments:nil];
            break;
        }
        default:
        {
            break;
        }
    }
}

@end
