//
//  SearchFilerViewController.m
//  Yelp
//
//  Created by Arpan Nanavati on 3/23/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "SearchFilerViewController.h"

@interface SearchFilerViewController ()

@property (weak, nonatomic) IBOutlet UITableView *searchFilterView;
@property (strong, nonatomic) NSMutableArray *categories;

@end

@implementation SearchFilerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initialize];
    }
    return self;
}

- (void) registerNib:(NSString *) cellIdentifier
{
    // register the table view cell with the table view
    UINib *tableViewCellNib = [UINib nibWithNibName:cellIdentifier bundle:nil];
    [self.searchFilterView registerNib:tableViewCellNib forCellReuseIdentifier:cellIdentifier];
    
//    self.cellPrototype = [self.searchFilterView dequeueReusableCellWithIdentifier:cellIdentifier];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.searchFilterView.dataSource = self;
    self.searchFilterView.delegate = self;
    
    [self registerNib:@"PriceTableViewCell"];
    [self registerNib:@"GenericUISliderTableViewCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initialize
{
    self.categories = [NSMutableArray arrayWithObjects:
                       @{
                         @"name":@"Price",
                         @"cellIdentifier": @"PriceTableViewCell",
                         @"type":@"segmented",
                         @"numberOfRowsInSection": [NSNumber numberWithInt:1],
                         @"list":@[@"$",@"$$",@"$$$",@"$$$$"]
                         },
                       @{
                         @"name":@"Most Popular",
                         @"type":@"switches",
                         @"cellIdentifier": @"GenericUISliderTableViewCell",
                         @"numberOfRowsInSection": [NSNumber numberWithInt:4],
                         @"list":@[@"Open Now",@"Hot & New",@"Offering a Deal",@"Delivery"]
                         },
                       @{
                         @"name":@"Distance",
                         @"type":@"expandable",
                         @"cellIdentifier": @"GenericUISliderTableViewCell",
                         @"numberOfRowsInSection": [NSNumber numberWithInt:5],
                         @"list":@[@"Auto",@"2 blocks",@"6 blocks",@"1 mile",@"5 miles"]
                         },
                       @{
                         @"name":@"Sort By",
                         @"type":@"expandable",
                         @"cellIdentifier": @"GenericUISliderTableViewCell",
                         @"numberOfRowsInSection": [NSNumber numberWithInt:4],
                         @"list":@[@"Best Match",@"Distance",@"Rating",@"Most Reviewed"]
                         },
                       @{
                         @"name":@"General Features",
                         @"type":@"expandable",
                         @"cellIdentifier": @"GenericUISliderTableViewCell",
                         @"numberOfRowsInSection": [NSNumber numberWithInt:10],
                         @"list":@[@"Take-out",@"Good for Groups",@"Has TV",@"Accepts Credit Cards",@"Wheelchair Accessible",@"Full Bar",@"Beer & Wine only",@"Happy Hour",@"Free Wi-Fi",@"Paid Wi-fi"]
                         }, nil
                       ];

}

#pragma mark -
#pragma mark Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.categories[section][@"name"];
}

- (NSInteger) numberOfSectionsInTableView: (UITableView *)tableView {
    return self.categories.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.categories[section][@"numberOfRowsInSection"] integerValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0f;
}

-(void) priceTableViewCellDidFinish:(id)sender
{
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = self.categories[indexPath.section][@"cellIdentifier"];
    
    Class klass = NSClassFromString(cellIdentifier);
    id cell = [[klass alloc] init];
    
    cell = [self.searchFilterView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ([cell isKindOfClass:[PriceTableViewCell class]]) {
        [cell priceSegments:self.categories[indexPath.section][@"list"]];
//        PriceTableViewCell *cell;
        [cell setDelegate:self];
    }
    else if ([cell isKindOfClass:[GenericUISliderTableViewCell class]]) {
        [cell setupSliderCell:self.categories[indexPath.section][@"list"][indexPath.row]];
    }
    
    return cell;
}

@end
