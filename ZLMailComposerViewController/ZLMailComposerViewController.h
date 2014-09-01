//
//  ZLViewController.h
//  ZLMailComposerViewController
//
//  Created by fonky on 14-8-28.
//  Copyright (c) 2014年 Lin Zhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLMailComposerViewController : UIViewController <UIWebViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

- (void) setupNewComposer;

- (void) setupReplyComposerWithToRecipients:(NSArray *) toRecipients
                                 andSubject:(NSString *) subject
                                 andContent:(NSString *) content;

- (void) setupReplyAllComposerWithToRecipients:(NSArray *) toRecipients
                               andCcRecipients:(NSArray *) ccRecipients
                                    andSubject:(NSString *) subject
                                    andContent:(NSString *) content;

- (void) setupForwardComposerWithSubject:(NSString *) subject
                              andContent:(NSString *) content
                          andAttachments:(NSArray *) attachments;

- (void) setupDraftComposerWithToRecipients:(NSArray *) toRecipients
                            andCcRecipients:(NSArray *) ccRecipients
                           andBccRecipients:(NSArray *) bccRecipients
                                 andSubject:(NSString *) subject
                                 andContent:(NSString *) content
                             andAttachments:(NSArray *) attachments;

- (void) setupRedirectComposerWithSubject:(NSString *) subject
                               andContent:(NSString *) content
                           andAttachments:(NSArray *) attachments;
@end
