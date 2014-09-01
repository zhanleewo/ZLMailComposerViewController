//
//  ZLViewController.m
//  ZLMailComposerViewController
//
//  Created by fonky on 14-8-28.
//  Copyright (c) 2014年 Lin Zhan. All rights reserved.
//

#import "ZLMailComposerViewController.h"

@interface ZLMailComposerViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSMutableArray *toRecipients;
@property (nonatomic, strong) NSMutableArray *ccRecipients;
@property (nonatomic, strong) NSMutableArray *bccRecipients;
@property (nonatomic, strong) NSMutableString *content;
@property (nonatomic, strong) NSMutableArray *attachments;



- (IBAction)selectPhoto:(UIBarButtonItem *)sender;
- (IBAction)printHTML:(UIBarButtonItem *)sender;
@end

@implementation ZLMailComposerViewController

- (void) setupComposer {
    
}

- (void) setupComposerWithRecipients:(NSArray *) recipients
                          andSubject:(NSString *) subject
                          andContent:(NSString *) content {

}

- (void) setupComposerWithRecipients:(NSArray *) recipients
                              andCCs:(NSArray *) ccs
                          andSubject:(NSString *) subject
                          andContent:(NSString *) content {

}


- (void) setupComposerWithRecipients:(NSArray *) recipients
                              andCCs:(NSArray *) ccs
                          andSubject:(NSString *) subject
                          andContent:(NSString *) content
                      andAttachments:(NSArray *)attachments {

}

- (void) setupComposerWithRecipients:(NSArray *) recipients
                              andCCs:(NSArray *) ccs
                             andBCCs:(NSArray *) bccs
                          andSubject:(NSString *) subject
                          andContent:(NSString *) content
                      andAttachments:(NSArray *)attachments {

}

- (void) setupComposerWithContent:(NSString *) content
                   andAttachments:(NSArray *) attachments {

}
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
    
    
    NSURL *baseURL = [bundle bundleURL];
    NSData *data = [NSData dataWithContentsOfURL:indexFileURL];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    string = [string stringByReplacingOccurrencesOfString:@"<!-${um-editor-content-placeholder}->" withString:@"<br />来自iPhone客户端"];
    
    [self.webView setKeyboardDisplayRequiresUserAction:NO];
    [self.webView loadData:[string dataUsingEncoding:NSUTF8StringEncoding] MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseURL];
    
    
    //[self.webView loadRequest:[NSURLRequest requestWithURL:indexFileURL]];
}

- (void) composerDidRenderer:(NSURL *) url {

}


- (void) processComposerEvent:(NSURL *) url {
    if([url.host isEqualToString:@"get-contacts"]) {
        
        NSString *contacts = @"[{displayName : \"朱茵\", mailbox : \"zhu.yin@163.com\"}, {displayName : \"张学友\", mailbox : \"jack.chang@163.com\"}, {displayName : \"刘德华\", mailbox : \"andy.liu@163.com\"}, {displayName : \"吴宗宪\", mailbox : \"zongxian.wu@163.com\"}, {displayName : \"James\", mailbox : \"james@163.com\"}, {displayName : \"郭富城\", mailbox : \"fucheng.guo@163.com\"}, {displayName : \"黎明\", mailbox : \"ming.li@163.com\"}, {displayName : \"去哪儿\",mailbox : \"qunaer@163.com\"}]";
        NSString *javascript = [NSString stringWithFormat:@"mailComposer.didGetContacts(%@)", contacts];
        [self.webView stringByEvaluatingJavaScriptFromString:javascript];
    } else if([url.host isEqualToString:@"get-mail"]) {
        
    } else if([url.host isEqualToString:@"add-attachment"]) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickerController.delegate = self;
        [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url = request.URL;
    if([url.scheme isEqualToString:@"umcomposer"]) {
        [self processComposerEvent:url];
        return NO;
    }
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //    NSString *inputPlaceholder = NSLocalizedString(@"Subject", @"Subject");
    //    NSString *contentPlaceholder = NSLocalizedString(@"Content", @"Content");
    //    NSString *script = [NSString stringWithFormat:@"window.initPlaceholder('%@', '%@')", inputPlaceholder, contentPlaceholder];
    //    [webView stringByEvaluatingJavaScriptFromString:script];
}
- (IBAction)backAction:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    }];
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
    NSString *mailRecipients = [self.webView stringByEvaluatingJavaScriptFromString:@"mailComposer.getMailToRecipients()"];
    NSString *mailCcs = [self.webView stringByEvaluatingJavaScriptFromString:@"mailComposer.getMailCcRecipients()"];
    NSString *mailBccs = [self.webView stringByEvaluatingJavaScriptFromString:@"mailComposer.getMailBccRecipients()"];
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

- (NSString *) sizeToString:(NSUInteger) size {

    NSString *str = @"";
    if(size < 1024L) {
        str = [NSString stringWithFormat:@"%luBytes", (unsigned long)size];
    } else if(size >=1024 && size < (1024L * 1024L)) {
        str = [NSString stringWithFormat:@"%luKB", (((unsigned long)size) / 1024L)];
    } else if(size >=(1024L * 1024L) && size < (1024L * 1024L * 1024L)) {
        str = [NSString stringWithFormat:@"%luMB", (((unsigned long)size) / 1024L / 1024L)];
    } else {
        str = [NSString stringWithFormat:@"%luGB", (((unsigned long)size) / 1024L / 1024L/ 1024L)];
    }
    return str;
}

- (UIImage*) scaleImageWithImage:(UIImage*)image
              size:(CGSize)newSize;
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage*)getSubImageFrom: (UIImage*) img withRect: (CGRect) rect {
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // translated rectangle for drawing sub image
    CGRect drawRect = CGRectMake(-rect.origin.x, -rect.origin.y, img.size.width, img.size.height);
    
    // clip to the bounds of the image context
    // not strictly necessary as it will get clipped anyway?
    CGContextClipToRect(context, CGRectMake(0, 0, rect.size.width, rect.size.height));
    
    // draw image
    [img drawInRect:drawRect];
    
    // grab image
    UIImage* subImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return subImage;
}

- (UIImage *) iconForImage:(UIImage *) orgImage {
    UIImage *iconImage = nil;
    CGSize destSize = orgImage.size;
    CGPoint destPos = CGPointMake(0, 0);
    if(destSize.width > destSize.height) {
        destSize.width = destSize.height;
        destPos.x = (destSize.width - destSize.height) / 2.0f;
    } else {
        destSize.height = destSize.width;
        destPos.y = (destSize.height - destSize.width) / 2.0f;
    }
    
    CGRect rect = {.origin = destPos, .size = destSize};
    iconImage = [self getSubImageFrom:orgImage withRect:rect];
    if([UIScreen mainScreen].scale == 2.0f) {
        iconImage = [self scaleImageWithImage:iconImage size:CGSizeMake(96, 96)];
    } else {
        iconImage = [self scaleImageWithImage:iconImage size:CGSizeMake(48, 48)];
    }
    
    return iconImage;
}

#pragma mark - ImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // Obtain the path to save to
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSDate *now = [NSDate date];
    NSString *strDate = [self stringFromDate:now];
    NSString *imageName = [NSString stringWithFormat:@"photo%@.jpg", strDate];
    NSString *iconName = [NSString stringWithFormat:@"icon%@.jpg", strDate];
    
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:imageName];
    NSString *iconPath = [documentsDirectory stringByAppendingPathComponent:iconName];
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    NSUInteger size = 0;
    if ([mediaType isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        size = imageData.length;
        [imageData writeToFile:imagePath atomically:YES];
        
        UIImage *iconImage = [self iconForImage:image];
        NSData *iconData = UIImageJPEGRepresentation(iconImage, 1);
        [iconData writeToFile:iconPath atomically:YES];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    //NSString *script = [NSString stringWithFormat:@"mailComposer.insertImage('%@', '%@')", imageName, imagePath];
    NSString *script = [NSString stringWithFormat:@"mailComposer.didAddAttachment({icon:\"%@\", title:\"%@\", src:\"%@\", type:\"类型:JPEG\", size:\"大小:%@\", error:null})", iconPath, imageName, imagePath, [self sizeToString:size]];
    //;
    [self.webView stringByEvaluatingJavaScriptFromString:script];
}
@end
