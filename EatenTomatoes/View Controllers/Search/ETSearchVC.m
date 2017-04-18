//
//  ETSearchVC.m
//  EatenTomatoes
//
//  Created by Saheb Roy on 14/04/17.
//  Copyright © 2017 Saheb Roy. All rights reserved.
//

#import "ETSearchVC.h"
#import "Constraints.h"
#import "ETSearchCell.h"


const NSString *textfieldType = @"1";
const NSString *datetype      = @"3";
const NSString *segment       = @"4";
const NSString *submit        = @"5";
const NSString *blank         = @"10";



@interface ETSearchVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) IBOutlet UITableView *tblview;
@end

@implementation ETSearchVC{
    NSMutableArray *allitems;
}


#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureController];
}

- (void)viewWillAppear:(BOOL)animated{
    [[ETNavigationHandler sharedManager]setNavigation:kETSearch andTitle:nil];
}

- (void)configureController{
    [ETCommon sharedManager].initialController = self.navigationController;
    allitems = [@[@{@"id":@"blank",@"type":blank},
                  [@{@"id":@"search",@"type":textfieldType,@"heading":@"Seach by name",@"placeholder":@"Movie/Series name",@"value":@""}mutableCopy],
                  [@{@"id":@"type",@"type":segment,@"heading":@"Pick a type",@"placeholder":@"Movie/Series",@"value":@"",@"options":@[@"Movie",@"Series"]}mutableCopy],
                  [@{@"id":@"date",@"type":datetype,@"heading":@"Choose a release year",@"placeholder":@"Release year",@"value":@""}mutableCopy],
                  @{@"id":@"submit",@"type":submit,@"placeholder":@"Search",@"value":@""}]mutableCopy];
    
    self.tblview.estimatedRowHeight = 300;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Tableview Methods 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return allitems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *textreuse      = @"textfieldcell";
    static NSString *buttonCell     = @"buttoncell";
    static NSString *blankCell      = @"blankcell";
    static NSString *segmentCell    = @"segmentcell";
    
    ETSearchCell *cell;
    
    NSDictionary *currentDict = [allitems objectAtIndex:indexPath.row];
    switch ([[currentDict valueForKey:@"type"] intValue]) {

            
        case 1:{
            
            cell = [tableView dequeueReusableCellWithIdentifier:textreuse];
            cell.lblTitle.text = [currentDict valueForKey:@"heading"];
            cell.lblTitle.hidden = NO;
            cell.txtField.text = [currentDict valueForKey:@"value"];
            cell.txtField.placeholder = [currentDict valueForKey:@"placeholder"];
            cell.txtField.tag = indexPath.row;
            [cell.txtField addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            return cell;
            break;
        }
        case 3:{
            //date
            cell = [tableView dequeueReusableCellWithIdentifier:buttonCell];
            cell.lblTitle.hidden = NO;
            cell.lblTitle.text = [currentDict valueForKey:@"heading"];
            
            cell.button.tag = (int)indexPath.row;
            [cell.button setTitle:[currentDict valueForKey:@"value"] forState:UIControlStateNormal];
            if(isNullString([currentDict valueForKey:@"value"])){
                [cell.button setTitle:[currentDict valueForKey:@"placeholder"] forState:UIControlStateNormal];
            }
            [cell.button addTarget:self action:@selector(didPressButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button setTitleColor:THEME_Color forState:UIControlStateNormal];
            [cell.button setBackgroundColor:[UIColor whiteColor]];
            return cell;

            break;
        }
        case 4:{
            cell = [tableView dequeueReusableCellWithIdentifier:segmentCell];
            cell.lblTitle.hidden = NO;
            cell.lblTitle.text = [currentDict valueForKey:@"heading"];
            if([[currentDict valueForKey:@"value"]isEqualToString:@"Series"]){
                [cell.segmentedControl setSelectedSegmentIndex:1];
            }else {
                [cell.segmentedControl setSelectedSegmentIndex:0];
            }
            cell.segmentedControl.tag = (int)indexPath.row;
            [cell.segmentedControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
            
            return cell;

            break;
        }
        case 5:{
            
            cell = [tableView dequeueReusableCellWithIdentifier:buttonCell];
            [cell.button setTitle:@"Submit" forState:UIControlStateNormal];
            cell.button.tag = (int)indexPath.row;
            cell.lblTitle.hidden = YES;
            [cell.button addTarget:self action:@selector(performSearch) forControlEvents:UIControlEventTouchUpInside];
            [cell.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.button setBackgroundColor:THEME_Color];
            return cell;

            break;
        }
        case 10:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:blankCell];
            return cell;
            break;
        }
    }
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}


#pragma mark - Action

- (void)didPressButton:(UIButton *)sender{
    NSLog(@"Button Pressed");
    
    //date and genre
    NSMutableDictionary *current = allitems[sender.tag];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    SRPickerView *picker = [[SRPickerView alloc]initWithFrame:screenRect];

    addSubViewOnWindow(picker);
    [picker configureWithItems:current[@"options"] isDate:YES andCompletion:^(NSString *strPicked, int indexOfItem) {
        [current setValue:strPicked forKey:@"value"];
        [self.tblview reloadData];
    }];
}

- (void)segmentChanged:(UISegmentedControl *)control{
    NSMutableDictionary *dict = allitems[control.tag];
    [dict setValue:[control titleForSegmentAtIndex:control.selectedSegmentIndex] forKey:@"value"];
    NSLog(@"Value Changed");
}


- (void)textfieldDidChange:(UITextField *)textfield{
    NSMutableDictionary *dict = allitems[textfield.tag];
    [dict setValue:textfield.text forKey:@"value"];
}

- (void)performSearch{

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id = 'search'"];
    NSString *searchText = [[[allitems filteredArrayUsingPredicate:predicate]lastObject]valueForKey:@"value"];
    
    if(isNullString(searchText)){
        showSimpleAlert(@"Please give a movie/series name to search");
        return;
    }
    
    [ETCommon sharedManager].searchstring = searchText;
    
    // release year
    predicate = [NSPredicate predicateWithFormat:@"id = 'date'"];
    NSString *releaseYear = [[[allitems filteredArrayUsingPredicate:predicate]lastObject]valueForKey:@"value"];
    if(!isNullString(releaseYear)){
        [ETCommon sharedManager].year = releaseYear;
    }
    
    predicate = [NSPredicate predicateWithFormat:@"id = 'type'"];
    NSString *type = [[[allitems filteredArrayUsingPredicate:predicate]lastObject]valueForKey:@"value"];
    if(!isNullString(type)){
        [ETCommon sharedManager].type = type;
    }
    [self performSegueWithIdentifier:kFromSettingsToHomeController sender:self];
}

@end
