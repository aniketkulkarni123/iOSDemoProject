//
//  ViewController.m
//  iOSDemoProject
//
//  Created by Yash on 08/03/18.
//  Copyright © 2018 infosys. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"

@interface ViewController ()
@end

@implementation ViewController
@synthesize tableRowsArray;
@synthesize responseData;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    self.tableview.estimatedRowHeight = 200.0;
    
    [self.tableview registerClass:[TableViewCell class] forCellReuseIdentifier:@"cellIdentifier"];
    UINavigationBar* navbar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    UINavigationItem* navItem = [[UINavigationItem alloc] initWithTitle:@"iOS Demo project"];
    [navbar setItems:@[navItem]];
    [self.view addSubview:navbar];
    navbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    //Fetching data from local json
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"jsonData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    _jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    tableRowsArray = [_jsonDict valueForKey:@"rows"];

    /* Uncomment for fetching json from url */
    //    NSString *url_string = [NSString stringWithFormat: @"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"];
    //    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
    //    _jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    //     tableRowsArray = [_jsonDict valueForKey:@"rows"];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    // Do any additional setup after loading the view, typically from a nib.
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //minimum size of your cell, it should be single line of label if you are not clear min. then return UITableViewAutomaticDimension;
    return UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    //Create UITableView
    self.tableview = [self makeTableView];
    [self.view addSubview:self.tableview];
}

-(UITableView *)makeTableView
{
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0,50,self.view.frame.size.width,self.view.frame.size.height) style:UITableViewStylePlain];
    return self.tableview;
}

#pragma Table View Data Source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130.0f;
}

// Return the number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Return the number of rows for each section in your static table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableRowsArray.count;
}

// Return the row for the corresponding section and row
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    TableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    id title = [[tableRowsArray objectAtIndex:indexPath.row] valueForKey:@"title"];
    //check if value is null if it is put it to blank ""
    cell.rowTitle.text = (title == [NSNull null]) ? @"":[[tableRowsArray objectAtIndex:indexPath.row] valueForKey:@"title"];
    
    id description = [[tableRowsArray objectAtIndex:indexPath.row] valueForKey:@"description"];
    cell.rowDescription.text = (description == [NSNull null]) ? @"":[[tableRowsArray objectAtIndex:indexPath.row] valueForKey:@"description"];
    
    // Fetch images using GCD
    dispatch_queue_t downloadThumbnailQueue = dispatch_queue_create("GetImage", NULL);
    dispatch_async(downloadThumbnailQueue, ^{
        id imageUrl = [[tableRowsArray objectAtIndex:indexPath.row] valueForKey:@"imageHref"];
        imageUrl = (imageUrl == [NSNull null]) ? @"": imageUrl;
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",imageUrl]];
        UIImage *image = [UIImage imageWithCIImage:[CIImage imageWithContentsOfURL:url]];
        if(imageUrl == [NSNull null]){
            image = [UIImage imageNamed:@"noImage.png"];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            TableViewCell *cellToUpdate = [self.tableview cellForRowAtIndexPath:indexPath];
            if (cellToUpdate != nil) {
                [cellToUpdate.rowImage setImage:image];
                [cellToUpdate setNeedsLayout];
            }
        });
    });
    return cell;
}
#pragma Table View Delegate
// Customize the section headings for each section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_jsonDict valueForKey:@"title"];
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // your action here
}

@end
