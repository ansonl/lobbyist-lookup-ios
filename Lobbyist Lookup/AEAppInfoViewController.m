//
//  AEAppInfoViewController.m
//  Lobbyist Lookup
//
//  Created by Anson Liu on 7/25/14.
//  Copyright (c) 2014 Apparent Etch. All rights reserved.
//

#import "AEAppInfoViewController.h"

@interface AEAppInfoViewController ()

@end

@implementation AEAppInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = [NSString stringWithFormat:@"Lobbyist Lookup v%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];

    self.textView.text = @"Lobbyist Lookup was made during Northern Virginia National Day of Civic Hacking (NDOCH) at National Science Foundation (NSF) in Arlington, VA.\nhttp://hackforchange.org/events/northern-virginia-national-day-of-civic-hacking/\n\nIt addresses the NSF Ethics Challenge of creating a way for federal employees to lookup lobbying status of an individual or organization.\n\nYou may also find utility in using Lobbyist Lookup to be better informed on lobbyist statuses.\n\nSearch Field explanation:\nSurname: An individual lobbyist's surname.\nOrganization: The entity that has registered the filing. May be a hired lobbying firm.\nClient: The entity behind the filing. May be a company (client) that has hired a lobbying firm (organization/registrant).\n\nLobbyist Lookup API is written in Go and performs searches of lobbyist filings on behalf of client devices and browsers. You are free to interact with the API with your own developed app or website. The API's source code is freely available on GitHub: https://github.com/ansonl/lobbyist-lookup.\n\nAll filing data is available to the public at House.gov.";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
