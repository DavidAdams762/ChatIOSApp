//
//  JBLoginViewController.m
//  Jabber Client
//
//  Created by ADAMS David on 03/07/2015.
//  Copyright (c) 2015 ADAMS David. All rights reserved.
//

#import "JBLoginViewController.h"

@implementation JBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

@synthesize loginField, passwordField;

- (IBAction)login {
    [[NSUserDefaults standardUserDefaults] setObject:self.loginField.text forKey:@"userID"];
    [[NSUserDefaults standardUserDefaults] setObject:self.passwordField.text forKey:@"userPassword"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    BuddyViewController *buddyController = [self.storyboard instantiateViewControllerWithIdentifier:@"showBuddys"];
    [self presentViewController:buddyController animated:YES completion:nil];
}

- (IBAction)hideLogin{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end