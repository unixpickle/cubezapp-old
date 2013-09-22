//
//  ANAccountView.h
//  Qube
//
//  Created by Alex Nichol on 9/10/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANBlurredScrollLayout.h"
#import "ANAccountPage.h"
#import "ANAccountSyncView.h"
#import "ANPasswordButton.h"

@class ANAccountView;

@protocol ANAccountViewDelegate <NSObject>

- (void)accountViewSyncPressed:(ANAccountView *)accountView;
- (void)accountView:(ANAccountView *)accountView autosyncSet:(BOOL)flag;
- (void)accountViewPasswordPressed:(ANAccountView *)accountView;
- (void)accountView:(ANAccountView *)accountView emailSet:(NSString *)email;
- (void)accountView:(ANAccountView *)accountView nameSet:(NSString *)newName;

@end

@interface ANAccountView : ANBlurredScrollLayout <ANAccountPage, UITextFieldDelegate> {
    UITextField * emailField;
    UITextField * nameField;
    ANPasswordButton * passwordButton;
    ANAccountSyncView * syncView;
    
    UIButton * logoutButton;
}

@property (nonatomic, weak) id<ANAccountViewDelegate> delegate;
@property (readonly) UITextField * emailField;
@property (readonly) UITextField * nameField;
@property (readonly) ANPasswordButton * passwordButton;
@property (readonly) ANAccountSyncView * syncView;

- (void)passwordPressed:(id)sender;
- (void)syncPressed:(id)sender;
- (void)syncSwitchPressed:(id)sender;

@end
