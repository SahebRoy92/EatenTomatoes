//
//  ETHomeVC.m
//  EatenTomatoes
//
//  Created by Saheb Roy on 13/04/17.
//  Copyright © 2017 Saheb Roy. All rights reserved.
//

#import "ETHomeVC.h"
#import "Constraints.h"
#import "ETListCell.h"
#import "ETMovieModel.h"
#import "ETDetailVC.h"
#import "UIScrollView+SVPullToRefresh.h"

@interface ETHomeVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,weak) IBOutlet UICollectionView *listCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *lblCriteriaSearch;

@end

@implementation ETHomeVC{
    NSMutableArray *allMovies;
    int totalResult, currentPageNum;
    ETMovieModel *selectedMovie;
}


#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupController];
}

- (void)setupController{
    [ETCommon sharedManager].initialController = self.navigationController;
    allMovies = [@[]mutableCopy];
    currentPageNum = [ETCommon sharedManager].currentPage;

    [self.listCollectionView addPullToRefreshWithActionHandler:^{
        currentPageNum++;
        [self callAPI];
    } position:SVPullToRefreshPositionBottom];
    
    self.lblCriteriaSearch.text = [NSString stringWithFormat:@"Searching : %@",[ETCommon sharedManager].searchstring];
    
    showLoader(@"Fetching Results");
    [self callAPI];
}

- (void)viewWillAppear:(BOOL)animated{
    [self configureController];
}

- (void)configureController{
    [[ETNavigationHandler sharedManager]setNavigation:kETHome andTitle:@""];
}


#pragma mark - CollectionView Methods

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"cell";
    
    ETListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuse forIndexPath:indexPath];
    ETMovieModel * thisMovie = allMovies[indexPath.row];
    
    cell.titleName.text = thisMovie.title;
    [cell.moviePoster sd_setImageWithURL:[NSURL URLWithString:thisMovie.posterurl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    cell.moviePoster.layer.masksToBounds = YES;
    
    return cell;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return allMovies.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    selectedMovie = allMovies[indexPath.row];
    [self performSegueWithIdentifier:kFromHomeToDetailsController sender:self];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}



#pragma mark - Collectionview Refresh

/*
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == [allMovies count]-1) {
        if(totalResult >= [allMovies count] && ([allMovies lastObject])){
            currentPageNum = currentPageNum+1;
            [self callAPI];
        }
    }
}
*/



#pragma mark - Collectionview Layout



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat fl = self.listCollectionView.frame.size.width/2;
    
    ETMovieModel * thisMovie = allMovies[indexPath.row];
    float height = sizeOfLabel(thisMovie.title, fl-10);
    float supposeSize = height>20?height:20;
    
    NSLog(@"\n Title --- %@ \n Height -- %f \n Width --%f",thisMovie.title,height,fl - 10);
    
    CGSize mElementSize = CGSizeMake(fl-1, fl+supposeSize);
    return mElementSize;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,0,0,0);
}


#pragma mark - API Call and Data Handling

- (void)callAPI{

    [ETCommon sharedManager].currentPage = currentPageNum;
    [[ServiceManager sharedManager]getMoviesWithReleaseDate:[ETCommon sharedManager].year andSearchText:[ETCommon sharedManager].searchstring andType:[ETCommon sharedManager].type withCompletion:^(id response) {
        NSLog(@"%@",response);
        totalResult = [[response valueForKey:@"totalResults"] intValue];
        for (NSDictionary *dic in [response valueForKey:@"Search"]) {
            
            ETMovieModel *model = [[ETMovieModel alloc]init];

            model.posterurl     = dic[@"Poster"];
            model.title         = dic[@"Title"];
            model.type          = dic[@"Type"];
            model.imdbID        = dic[@"imdbID"];
            
            [allMovies addObject:model];
        }
        hideLoader();
        [self.listCollectionView reloadData];
        
    } andFailure:^(NSString *failureString) {
        hideLoader();
        showAlertWithDescAndAction(failureString, @[@"Ok"], ^(int index) {
            if(index == 0){
                [self.navigationController popViewControllerAnimated:YES];
            }
        });
    }];
}


#pragma mark - Navigation 

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:kFromHomeToDetailsController]){
        ETDetailVC *vc = [segue destinationViewController];
        vc.selectedMovie = selectedMovie;
    }
}


@end
