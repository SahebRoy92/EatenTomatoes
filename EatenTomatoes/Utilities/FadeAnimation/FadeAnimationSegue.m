//
//  FadeAnimationSegue.m
//  GirlfriendApp
//
//  Created by Saheb Roy on 09/08/16.
//  Copyright © 2016 Saheb Roy. All rights reserved.
//

#import "FadeAnimationSegue.h"

@implementation FadeAnimationSegue

-(void)perform{
    CATransition* transition = [CATransition animation];
    
    transition.duration = 0.3;
    transition.type = kCATransitionFade;
    
    [[self.sourceViewController navigationController].view.layer addAnimation:transition forKey:kCATransition];
    [[self.sourceViewController navigationController] pushViewController:[self destinationViewController] animated:NO];
}

@end
