//
//  AEViewController.m
//  Lobbyist Lookup
//
//  Created by Anson Liu on 6/14/14.
//  Copyright (c) 2014 Apparent Etch. All rights reserved.
//

#import "AEViewController.h"
#import "UIView+FindFirstResponder.h"

@interface AEViewController ()

@property (strong, nonatomic) NSMutableArray *userActivityArray;

@end

@implementation AEViewController

#pragma mark - Handle data methods

- (void)requestData {
    NSMutableArray *keys = [[NSMutableArray alloc] init];
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    if ([self.surnameTextField.text length] > 0) {
        [keys addObject:surnameParam];
        [values addObject:[self.surnameTextField.text lowercaseString]];
    }
    
    if ([self.organizationTextField.text length] > 0) {
        [keys addObject:organizationParam];
        [values addObject:[self.organizationTextField.text lowercaseString]];
    }
    
    if ([self.clientTextField.text length] > 0) {
        [keys addObject:clientParam];
        [values addObject:[self.clientTextField.text lowercaseString]];
    }
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
    
    RequestMenuData *obj = [RequestMenuData alloc];
    
    [obj getData:self withParams:dict];
}

- (void)dataReady:(NSArray *)array {
    //NSLog(@"%@", array);
    [self.activityIndicator stopAnimating];
    [self.activityIndicator setHidden:YES];
    [self enableFields];
    [self performSegueWithIdentifier:@"ShowLookupResult" sender:array];
}

- (void)dataFailed:(NSString *)text {
    [self.activityIndicator stopAnimating];
    [self.activityIndicator setHidden:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Lookup Failed" message:text delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [alert show];
    [self enableFields];
}

#pragma mark - UI change methods

- (void)disableFields {
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        self.iconImageView.alpha = 0.2;
    }
    
    [self.legislationInfoButton setEnabled:NO];
    [self.aboutAppButton setEnabled:NO];
    
    [self.surnameTextField setEnabled:NO];
    [self.organizationTextField setEnabled:NO];
    [self.clientTextField setEnabled:NO];
    [self.lookupButton setEnabled:NO];
    [self.lookupButton setTitleColor:[UIColor colorWithRed:0.85 green:0.67 blue:0.11 alpha:1.0] forState:UIControlStateDisabled];
    [self.lookupButton setTitle:@"Searching..." forState:UIControlStateDisabled];
}

- (void)enableFields {
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        self.iconImageView.alpha = 1.0;
    }
    
    [self.legislationInfoButton setEnabled:YES];
    [self.aboutAppButton setEnabled:YES];
    
    [self.surnameTextField setEnabled:YES];
    [self.organizationTextField setEnabled:YES];
    [self.clientTextField setEnabled:YES];
    [self.lookupButton setEnabled:YES];
    [self.lookupButton setTitleColor:nil forState:UIControlStateNormal];
    [self.lookupButton setTitle:@"Lookup" forState:UIControlStateNormal];
}

- (void)textFieldDidChange {
    if ([self.surnameTextField.text length] > 0 || [self.organizationTextField.text length] > 0 || [self.clientTextField.text length] > 0) {
        [self.lookupButton setEnabled:YES];
        [self.lookupButton setTitleColor:nil forState:UIControlStateNormal];
        [self.lookupButton setTitle:@"Lookup" forState:UIControlStateNormal];
        
    }
    else {
        [self.lookupButton setEnabled:NO];
        [self.lookupButton setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [self.lookupButton setTitle:@"At least 1 field required." forState:UIControlStateDisabled];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
        
        if (nextResponder == self.lookupButton)
            [self.view endEditing:YES];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
        
        //make search
        [self lookupButtonClicked:self];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (void)keyboardShow:(NSNotification*)notification
{
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameEnd = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameEndRect = [keyboardFrameEnd CGRectValue];
    
    inputViewOriginalFrame = self.inputView.frame;
    
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:0.1];
	[UIView setAnimationBeginsFromCurrentState:YES];
    
    
    
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        self.iconImageView.alpha = 0.2;
        self.inputView.frame = CGRectMake(self.view.frame.origin.x, keyboardFrameEndRect.origin.y - self.inputView.frame.size.height, self.view.frame.size.width, self.inputView.frame.size.height);
    }
    else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        if (self.inputView.frame.size.height > self.view.frame.size.height - keyboardFrameEndRect.size.width) {
            self.inputView.frame = CGRectMake(self.inputView.frame.origin.x, self.inputView.frame.origin.y, self.inputView.frame.size.width, self.view.frame.size.height - keyboardFrameEndRect.size.width);
        }
        else {
            self.inputView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.size.height - keyboardFrameEndRect.size.width - self.inputView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        }
        
        [self.navigationController.navigationBar setHidden:YES];
        
        self.iconImageView.alpha = 0;
    }
    
	[UIView commitAnimations];
}

- (void)keyboardHide:(NSNotification*)notification
{
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationBeginsFromCurrentState:YES];
    
	self.inputView.frame = inputViewOriginalFrame;
    
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        self.iconImageView.alpha = 1.0;
    }
    else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        [self.navigationController.navigationBar setHidden:NO];
    }
    
	[UIView commitAnimations];
}

- (void)keyboardFrameChange:(NSNotification*)notification {
    /*
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameEnd = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameEndRect = [keyboardFrameEnd CGRectValue];
    
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
     */
}

- (IBAction)lookupButtonClicked:(id)sender {
    [self disableFields];
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
    [self requestData];
    [self.view endEditing:YES];
}

- (IBAction)legislationInfoButtonClicked:(id)sender {
    [self performSegueWithIdentifier:@"ShowLegislationInfo" sender:sender];
}

- (IBAction)aboutButtonClicked:(id)sender {
    [self performSegueWithIdentifier:@"ShowAppInfo" sender:sender];
}

- (void)deviceOrientationDidChange:(NSNotification*)notification {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    
        if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.2];
            [UIView setAnimationBeginsFromCurrentState:YES];
            
            if ([self.view findFirstResponder])
                self.iconImageView.alpha = 0.2;
            else
                self.iconImageView.alpha = 1.0;

            [self.navigationController.navigationBar setHidden:NO];
            
            [UIView commitAnimations];
        }
        else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.2];
            [UIView setAnimationBeginsFromCurrentState:YES];
            
            self.iconImageView.alpha = 0;
            
            if ([self.view findFirstResponder])
                [self.navigationController.navigationBar setHidden:YES];
            else
                [self.navigationController.navigationBar setHidden:NO];
            
            [UIView commitAnimations];
        }
    }
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.activityIndicator setHidden:YES];
    [self.activityIndicator setColor:[UIColor darkGrayColor]];
    
    [self.lookupButton setEnabled:NO];
    
    [self.surnameTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.organizationTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.clientTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    //[self.legislationInfoButton setHidden:YES];
    //[self.aboutAppButton setHidden:YES];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    //on 2.0.4 update, add user activities to public search and device search
    if (![defaults boolForKey:kAddUserActivityVersionUserDefaultsKey]) {
        if ([[NSProcessInfo processInfo] respondsToSelector:@selector(operatingSystemVersion)] && [[NSProcessInfo processInfo] operatingSystemVersion].majorVersion >= 9 && [NSUserActivity class]) {
            
            NSLog(@"%ld", (long)[[NSProcessInfo processInfo] operatingSystemVersion].majorVersion);
            
            if (!self.userActivityArray)
                self.userActivityArray = [[NSMutableArray alloc] init];
            
            NSUserActivity* lookupLobbyistsActivity = [[NSUserActivity alloc] initWithActivityType:@"com.ansonliu.lookupLobbyists"];
            lookupLobbyistsActivity.title = @"Lookup Federal Lobbyists";
            lookupLobbyistsActivity.userInfo = @{@"id": @"com.ansonliu.lookupLobbyists"};
            lookupLobbyistsActivity.keywords = [NSSet setWithArray:@[@"Lobbyists",@"Lookup", @"Federal", @"Congress", @"Anson", @"Liu", @"NSF", @"Reference", @"Senate", @"House", @"Gift Eligibility", @"NDOCH"]];
            lookupLobbyistsActivity.eligibleForPublicIndexing = YES;
            lookupLobbyistsActivity.eligibleForSearch = YES;
            [lookupLobbyistsActivity becomeCurrent];
            [self.userActivityArray addObject:lookupLobbyistsActivity];
            
            NSLog(@"added user activites");
        } else {
            NSLog(@"tried to add user activites but sys version <9");
        }
        [defaults setBool:YES forKey:kAddUserActivityVersionUserDefaultsKey];
        [defaults synchronize];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segue method

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.navigationController.navigationBar setHidden:NO];
    if ([[segue identifier] isEqualToString:@"ShowLookupResult"]) {
        AEShowLookupResult *showLookupResult = [segue destinationViewController];
        
        showLookupResult.resultArray = sender;
    }
}
@end
