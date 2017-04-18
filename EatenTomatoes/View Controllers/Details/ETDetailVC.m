//
//  ETDetailVC.m
//  EatenTomatoes
//
//  Created by Saheb Roy on 14/04/17.
//  Copyright © 2017 Saheb Roy. All rights reserved.
//


#import "ETDetailVC.h"
#import "Constraints.h"
#import "ETDetailCell.h"
#import "ETDetailHeaderCell.h"

@interface ETDetailVC ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,weak) IBOutlet UITableView *tblView;

@end

@implementation ETDetailVC{
    NSMutableArray *allData;
    float tableviewInitialHeight;
    float maxOffset;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (void)configureController{
    [[ETNavigationHandler sharedManager]setNavigation:kETDetails andTitle:self.selectedMovie.title];
    self.tblView.estimatedRowHeight = 300;

    [self callAPI];
}



- (void)populateValues{
    
    allData = [@[   @{@"title":@"header"},
                    @{@"title":@"Director",@"data":self.selectedMovie.director},
                    @{@"title":@"Starring",@"data":self.selectedMovie.actor},
                    @{@"title":@"Genre",@"data":self.selectedMovie.genre},
                    @{@"title":@"Release Date",@"data":self.selectedMovie.releaseDate},
                    @{@"title":@"Runtime",@"data":self.selectedMovie.runtime},
                    @{@"title":@"Languade",@"data":self.selectedMovie.language},
                    @{@"title":@"Production",@"data":isNullString(self.selectedMovie.production)?@"":self.selectedMovie.production},
                    @{@"title":@"Synopsis",@"data":self.selectedMovie.plot}]mutableCopy];
    
    
    if(isNullString(self.selectedMovie.production)){
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"title = 'Production'"];
        NSDictionary *dic = [[allData filteredArrayUsingPredicate:pred] lastObject];
        [allData removeObject:dic];
    }
    

    [self.tblView reloadData];
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         maxOffset = (self.tblView.contentSize.height - self.tblView.frame.size.height - 20) < 150 ? self.tblView.contentSize.height - self.tblView.frame.size.height : 150;
    });
    
}


#pragma mark - Tableview Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuse = @"cell";
    static NSString *headerCell = @"headercell";
    
    if(indexPath.row == 0){
        ETDetailHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:headerCell];
        [cell.posterImage sd_setImageWithURL:[NSURL URLWithString:self.selectedMovie.posterurl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        
        cell.vwIMDB.hidden = YES;
        cell.vwMC.hidden = YES;
        cell.vwRT.hidden = YES;
        
        if(!isNullString(self.selectedMovie.imdbRating)){
            cell.vwIMDB.hidden = NO;
            cell.lblIMDB.text = self.selectedMovie.imdbRating;
        }
        
        if(!isNullString(self.selectedMovie.rtRating)){
            cell.vwRT.hidden = NO;
            cell.lblRT.text = self.selectedMovie.rtRating;
        }
        
        if(!isNullString(self.selectedMovie.metacriticRating)){
            cell.vwMC.hidden = NO;
            cell.lblMC.text = self.selectedMovie.metacriticRating;
        }
        
        return cell;
        
    }else {
     
        ETDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
        
        cell.title.text = [[allData objectAtIndex:indexPath.row] valueForKey:@"title"];
        cell.desc.text = [[allData objectAtIndex:indexPath.row] valueForKey:@"data"];
        
        return cell;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return allData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}



#pragma mark - API 

- (void)callAPI{
    showLoader(@"");
    [[ServiceManager sharedManager]getMovieDetails:self.selectedMovie withCompletion:^(id response) {
         [self populateValues];
        hideLoader();
    } andFailure:^(NSString *alert) {
        showSimpleAlert(alert);
    }];
    
}

@end
