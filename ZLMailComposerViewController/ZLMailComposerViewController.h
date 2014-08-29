//
//  ZLViewController.h
//  ZLMailComposerViewController
//
//  Created by fonky on 14-8-28.
//  Copyright (c) 2014年 Lin Zhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLMailComposerViewController : UIViewController <UIWebViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

- (void) setupComposer;

- (void) setupComposerWithRecipients:(NSArray *) recipients
                          andSubject:(NSString *) subject
                          andContent:(NSString *) content;

- (void) setupComposerWithRecipients:(NSArray *) recipients
                              andCCs:(NSArray *) ccs
                          andSubject:(NSString *) subject
                          andContent:(NSString *) content;


- (void) setupComposerWithRecipients:(NSArray *) recipients
                              andCCs:(NSArray *) ccs
                          andSubject:(NSString *) subject
                          andContent:(NSString *) content
                      andAttachments:(NSArray *)attachments;

- (void) setupComposerWithRecipients:(NSArray *) recipients
                              andCCs:(NSArray *) ccs
                             andBCCs:(NSArray *) bccs
                          andSubject:(NSString *) subject
                          andContent:(NSString *) content
                      andAttachments:(NSArray *)attachments;

- (void) setupComposerWithContent:(NSString *) content
                   andAttachments:(NSArray *) attachments;
@end
