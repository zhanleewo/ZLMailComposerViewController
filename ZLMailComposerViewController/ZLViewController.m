//
//  ZLViewController.m
//  ZLMailComposerViewController
//
//  Created by fonky on 14-8-28.
//  Copyright (c) 2014年 Lin Zhan. All rights reserved.
//

#import "ZLViewController.h"

@interface ZLViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)selectPhoto:(UIBarButtonItem *)sender;
- (IBAction)printHTML:(UIBarButtonItem *)sender;
@end

@implementation ZLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadWebView];
    
    //[[UIMenuController sharedMenuController] setMenuItems:nil];
    UIMenuItem *insertImageMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"插入图片", @"") action:@selector(insertImageAction:)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:insertImageMenuItem, nil]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Helper
- (void)insertImageAction:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
- (void)loadWebView {
    [self.webView setDelegate:self];
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *indexFileURL = [bundle URLForResource:@"composer" withExtension:@"html"];
    
    [self.webView setKeyboardDisplayRequiresUserAction:NO];
    [self.webView loadRequest:[NSURLRequest requestWithURL:indexFileURL]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //    NSString *inputPlaceholder = NSLocalizedString(@"Subject", @"Subject");
    //    NSString *contentPlaceholder = NSLocalizedString(@"Content", @"Content");
    //    NSString *script = [NSString stringWithFormat:@"window.initPlaceholder('%@', '%@')", inputPlaceholder, contentPlaceholder];
    //    [webView stringByEvaluatingJavaScriptFromString:script];
}

- (IBAction)selectPhoto:(UIBarButtonItem *)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (IBAction)printHTML:(UIBarButtonItem *)sender {
    //    NSString *title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('title-input').value"];
    //    NSString *html = [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('content').innerHTML"];
    //    NSString *script = [self.webView stringByEvaluatingJavaScriptFromString:@"window.alertHtml()"];
    //    [self.webView stringByEvaluatingJavaScriptFromString:script];
    NSString *mailRecipients = [self.webView stringByEvaluatingJavaScriptFromString:@"mailComposer.getMailRecipients()"];
    NSString *mailCcs = [self.webView stringByEvaluatingJavaScriptFromString:@"mailComposer.getMailCcs()"];
    NSString *mailBccs = [self.webView stringByEvaluatingJavaScriptFromString:@"mailComposer.getMailBccs()"];
    NSString *mailSubject = [self.webView stringByEvaluatingJavaScriptFromString:@"mailComposer.getMailSubject()"];
    NSString *mailContent = [self.webView stringByEvaluatingJavaScriptFromString:@"mailComposer.getMailContent()"];
    
    NSLog(@"To      : %@", mailRecipients);
    NSLog(@"Cc      : %@", mailCcs);
    NSLog(@"Bcc     : %@", mailBccs);
    NSLog(@"Subject : %@", mailSubject);
    NSLog(@"Content : %@", mailContent);
}

- (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
- (void) keyboardWillShow:(NSNotification *)notify {
    
    // _timer   =   [NSTimer    scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(scroll) userInfo:nil repeats:YES];
    
    //    if(([self.toTokenField.textField isFirstResponder]
    //         || [self.ccTokenField.textField isFirstResponder]
    //         || [self.bccTokenField.textField isFirstResponder]
    //         || [self.subjectTextField isFirstResponder]
    //         || [self.dummyTextField isFirstResponder])) {
    // self.navigationController.navigationBarHidden = YES;
    //        [UIView animateWithDuration:0.3 animations:^{
    //            self.scrollView.contentOffset = CGPointMake(0, 170);
    //        } completion:^(BOOL finished) {
    //
    //        }];
    CGRect keyboardFrameEnd = [[[notify userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (keyboardFrameEnd.size.width <= 320) {
        [self performSelector:@selector(removeBar:) withObject:[notify userInfo] afterDelay:0.0];
    }
    //    }
}


- (void)removeBar:(NSDictionary *)dic {
    
    // Locate non-UIWindow.
    UIWindow *keyboardWindow = nil;
    for (UIWindow *testWindow in [[UIApplication sharedApplication] windows]) {
        if (![[testWindow class] isEqual:[UIWindow class]]) {
            keyboardWindow = testWindow;
            break;
        }
    }
    
    // Locate UIWebFormView
	CGRect r = CGRectZero;
    UIScrollView *webScroll = [[self webView] scrollView];
    for (UIView *possibleFormView in [keyboardWindow subviews]) {
        if ([[possibleFormView description] hasPrefix:@"<UIPeripheralHostView"]) {
            for (UIView* peripheralView in [possibleFormView subviews]) {
                
                // hides the backdrop (iOS 7)
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"description beginswith %@", @"<UIKBInputBackdropView"];
                int count = (int)[[possibleFormView subviews] filteredArrayUsingPredicate:predicate].count;
                if ([[peripheralView description] hasPrefix:@"<UIKBInputBackdropView"]) {
                    //skip the keyboard background....hide only the toolbar background
                    NSLog(@"%d %@", count, NSStringFromCGRect(peripheralView.frame));
                    if (count != 1 && [peripheralView frame].origin.y == 0){
                        [[peripheralView layer] setOpacity:0.0];
                    }
                    continue;
                }
                // hides the accessory bar
                if ([[peripheralView description] hasPrefix:@"<UIWebFormAccessory"]) {
                    r = peripheralView.frame;
                    // remove the extra scroll space for the form accessory bar
                    
                    CGRect newFrame = webScroll.frame;
                    newFrame.size.height += peripheralView.frame.size.height;
                    webScroll.frame = newFrame;
                    // remove the form accessory bar
                    [peripheralView removeFromSuperview];
                }
                // hides the thin grey line used to adorn the bar (iOS 6)
                if ([[peripheralView description] hasPrefix:@"<UIImageView"]) {
                    [[peripheralView layer] setOpacity:0.0];
                }
            }
        }
    }
    
	if (!CGRectEqualToRect(CGRectZero, r)) {
        
	}
}
#pragma mark - ImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // Obtain the path to save to
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSDate *now = [NSDate date];
    NSString *imageName = [NSString stringWithFormat:@"photo%@.jpg", [self stringFromDate:now]];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:imageName];
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        [imageData writeToFile:imagePath atomically:YES];
    }
    
    NSString *script = [NSString stringWithFormat:@"mailComposer.insertImage('%@', '%@')", imageName, imagePath];
    [self.webView stringByEvaluatingJavaScriptFromString:script];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
