//
//  ViewController.m
//  iOSDemoProject
//
//  Created by Yash on 08/03/18.
//  Copyright © 2018 infosys. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController
@synthesize tableRowsArray;
@synthesize responseData;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    self.tableview.estimatedRowHeight = 200.0;
    
    UINavigationBar* navbar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    UINavigationItem* navItem = [[UINavigationItem alloc] initWithTitle:@"iOS Demo project"];
    [navbar setItems:@[navItem]];
    [self.view addSubview:navbar];
    navbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
//    self.responseData = [NSMutableData data];
//    NSURL *url = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    _urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"jsonData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    _jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    tableRowsArray = [_jsonDict valueForKey:@"rows"];
    
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
    // set the title
    self.tableview = [self makeTableView];
    [self.view addSubview:self.tableview];
}

-(UITableView *)makeTableView
{
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0,50,self.view.frame.size.width,self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    return self.tableview;
}

#pragma NSURLConnection to get json from url

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed: %@", [error description]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //Getting your response string
    NSString *responseString = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",responseString);
    self.responseData = nil;
}

#pragma Table View Data Source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0f;
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
   // return 1;
}

// Return the row for the corresponding section and row
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    _rowTitle = [[UILabel alloc] initWithFrame:CGRectMake(170,0,300, 30)];
    _rowTitle.textColor = [UIColor blackColor];
    id title = [[tableRowsArray objectAtIndex:indexPath.row] valueForKey:@"title"];
    NSLog(@"%@",title);
    _rowTitle.text = (title == [NSNull null]) ? @"":[[tableRowsArray objectAtIndex:indexPath.row] valueForKey:@"title"];
    _rowTitle.font = [UIFont fontWithName:@"Arial" size:12.0f];
    [cell addSubview:_rowTitle];
    
    _rowDescription = [[UILabel alloc] initWithFrame:CGRectMake(170,30,self.view.frame.size.width - 170 - 10,50)];
    _rowDescription.textColor = [UIColor blackColor];
    id description = [[tableRowsArray objectAtIndex:indexPath.row] valueForKey:@"description"];
    _rowDescription.text = (description == [NSNull null]) ? @"":[[tableRowsArray objectAtIndex:indexPath.row] valueForKey:@"description"];
    _rowDescription.font = [UIFont fontWithName:@"Arial" size:12.0f];
    [cell addSubview:_rowDescription];
    
    _rowDescription.numberOfLines = 0;
    _rowDescription.translatesAutoresizingMaskIntoConstraints = false;
    _rowImage = [[UIImageView alloc] initWithFrame:CGRectMake(15,10,150,100)];
    
    id imageUrl = [[tableRowsArray objectAtIndex:indexPath.row] valueForKey:@"imageHref"];
    imageUrl = (imageUrl == [NSNull null]) ? @"noImage.png": imageUrl;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",imageUrl]];
    _rowImage.image = [UIImage imageWithCIImage:[CIImage imageWithContentsOfURL:url]];
    
    [cell addSubview:_rowImage];
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
