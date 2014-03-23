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

#define kLabelFrameMaxSize CGSizeMake(265.0, 200.0)

@interface MainViewController ()

@property (strong, nonatomic) NSMutableArray *businesses;

@property (nonatomic, strong) YelpClient *client;
@property (weak, nonatomic) IBOutlet UITableView *searchIndexTableView;

@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) UISearchBar *searchBar;

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
    
    self.searchIndexTableView.dataSource = self;
    self.searchIndexTableView.delegate = self;
    
    static NSString *cellIdentifier = @"YelpBusinessTableViewCell";
    
    // register the table view cell with the table view
    UINib *yelpBusinessTableViewCellNib = [UINib nibWithNibName:cellIdentifier bundle:nil];
    [self.searchIndexTableView registerNib:yelpBusinessTableViewCellNib forCellReuseIdentifier:cellIdentifier];

    self.cellPrototype = [self.searchIndexTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    [self showSearchBar];
}

- (void) showSearchBar {
    UISearchBar *tempSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.searchIndexTableView.frame.size.width, 0)];
    self.searchBar = tempSearchBar;
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"Search Yelp...";
    [self.searchBar sizeToFit];
    
    
    float buttonWidth = 44;
    float buttonHeight = 44;
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.searchIndexTableView.frame.size.height/2 - buttonHeight/2, buttonWidth, buttonHeight)];
    [leftButton setTitle:@"filter" forState:UIControlStateNormal];
    [leftButton setShowsTouchWhenHighlighted:YES];
//    leftButton.alpha = 0;
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    [barButton setCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = barButton;
    
    self.navigationItem.titleView = self.searchBar;
}

- (void) hideSearchBar {
    self.navigationItem.titleView = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *cellIdentifier = @"YelpBusinessTableViewCell";
//    YelpBusinessTableViewCell *cell = [self.searchIndexTableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (cell && self.businesses.count > 0) {
////        YelpBusiness *yelpBusiness = self.businesses[indexPath.row];
////        [cell setModel:yelpBusiness];
//        return cell.frame.size.height;
//    }
    
    // TODO : arpan ask Tim what is the best practice to calculate the height
    return 150.0f;
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
