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

@property (strong, nonatomic) NSMutableArray *searchResults;

@property (nonatomic, strong) YelpClient *client;
@property (weak, nonatomic) IBOutlet UITableView *searchIndexTableView;

@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) UISearchBar *searchBar;

@property (strong, nonatomic) NSDictionary *queryParams;

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
    [self getDataFromYelp:nil];

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
    self.searchBar.showsCancelButton = YES;
    [self.searchBar sizeToFit];
    self.navigationItem.titleView = self.searchBar;
    
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStyleBordered target:self action:@selector(menuItemSelected:)];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.searchResults = nil;
    [self.searchBar resignFirstResponder];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (!self.searchResults.count) {
        NSDictionary *parameters;
        
        if (self.queryParams) {
            parameters = @{@"term": self.searchBar.text, @"category_filter": [self.queryParams objectForKey:@"categories_filter"], @"location" : @"San Francisco"};
        } else {
            parameters = @{@"term": self.searchBar.text, @"location" : @"San Francisco"};
        }

        [self getDataFromYelp:parameters];
    }
}

- (void) menuItemSelected:(id)sender
{
    SearchFilerViewController *searchFilterController = [[SearchFilerViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:searchFilterController];
    navigationController.modalTransitionStyle = UIModalTransitionStyleCoverVertical; // Rises from below
    
    searchFilterController.delegate = self;
    
    [self presentViewController:navigationController animated:YES completion:nil];
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

- (void) getDataFromYelp:(NSDictionary *)queryParams
{
    if (self) {
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        
        if (!queryParams) {
            [self.client searchWithTerm:@"Thai" customParams:nil success:^(AFHTTPRequestOperation *operation, id response) {
                [self apiSuccess:response];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [self apiError:error];
            }];
        } else {
            [self.client searchWithTerm:@"Thai" customParams:queryParams success:^(AFHTTPRequestOperation *operation, id response) {
                [self apiSuccess:response];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [self apiError:error];
            }];
        }
    }
}

- (void)addItemViewController:(SearchFilerViewController *)controller didFinishEnteringItem:(NSDictionary *)item
{
    self.queryParams = item;
}


@end
