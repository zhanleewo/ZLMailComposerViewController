
//
//  ZLMailComposerNavigationControllerViewController.m
//  ZLMailComposerViewController
//
//  Created by fonky on 14-8-29.
//  Copyright (c) 2014年 Lin Zhan. All rights reserved.
//

#import "ZLMailComposerNavigationController.h"

@interface ZLMailComposerNavigationController ()

@end

@implementation ZLMailComposerNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSUInteger)supportedInterfaceOrientations {
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationPortrait;
    }
    
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate
{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return NO;
    }
    return YES;
}

@end
