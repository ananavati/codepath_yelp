//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "YelpClient.h"

NSString * const kYelpConsumerKey       = @"hkgvcCeg0Jj0ky4AXJ1geQ";
NSString * const kYelpConsumerSecret    = @"26VbkWDhr7g35lwAQJxmXtzK_CI";
NSString * const kYelpToken             = @"T17I2xDRtRo21WX_5WtHq8yLo9gCRqqo";
NSString * const kYelpTokenSecret       = @"HHlCJ4c09EGcJg2jjnzo3Bw1_NA";

@interface MainViewController ()

@property (strong, nonatomic) NSMutableArray *businesses;

@property (nonatomic, strong) YelpClient *client;
@property (weak, nonatomic) IBOutlet UITableView *searchIndexTableView;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void) initialize
{
    self.businesses = [[NSMutableArray alloc] init];
    
    [self getDataFromYelp];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.

    // register the table view cell with the table view
    UINib *yelpBusinessTableViewCellNib = [UINib nibWithNibName:@"YelpBusinessTableViewCell" bundle:nil];
    [self.searchIndexTableView registerNib:yelpBusinessTableViewCellNib forCellReuseIdentifier:@"YelpBusinessTableViewCell"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"YelpBusinessTableViewCell";
    YelpBusinessTableViewCell *cell = [self.searchIndexTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell && self.businesses.count > 0) {
        YelpBusiness *yelpBusiness = self.businesses[indexPath.row];
        [cell setModel:yelpBusiness];
    }
    
    return cell;
}

- (void) apiSuccess:(id) response
{
    NSDictionary *businesses = (NSDictionary *)response;
    [self.businesses removeAllObjects];
    
    for (NSDictionary *business in businesses[@"businesses"]) {
        [self.businesses addObject:[[YelpBusiness alloc] initWithDictionary:business]];
    };
    
    [self.searchIndexTableView reloadData];
}

- (void) apiError:(NSError *) networkError
{
    
}

- (void) getDataFromYelp
{
    if (self) {
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        
        [self.client searchWithTerm:@"Thai" success:^(AFHTTPRequestOperation *operation, id response) {
            [self apiSuccess:response];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self apiError:error];
        }];
    }
}


@end
