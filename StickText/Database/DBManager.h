//
//  DBManager.m
//  ImageOrganizer
//
//  Created by Wony Shin on 10/20/11.
//  Copyright 2011. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Written by Wony Shin
 * This class is to manage BOLO.
 **/

@interface DBManager : NSObject {
    NSString *m_dbName;
    
    // all sticks are stored here, each category will be NSDictionary
    NSMutableArray *m_sticks;
    
    // all sticks are stored here, each category will be NSDictionary
    NSMutableArray *m_punchSticks;
    
    // all sticks are stored here, each category will be NSDictionary
    NSMutableArray *m_noPunchSticks;
    
    // recent sticks are stored here, each item will be NSDictionary
    NSMutableArray *m_recents;
    
    // favorite sticks are stored here, each item will be NSDictionary
    NSMutableArray *m_favorites;
    
    // purchased sticks are stored here, each item will be NSDictionary
    NSMutableArray *m_purchased;
}

@property (nonatomic, retain) NSString *m_dbName;
@property (nonatomic, retain) NSMutableArray *m_sticks;
@property (nonatomic, retain) NSMutableArray *m_punchSticks;
@property (nonatomic, retain) NSMutableArray *m_noPunchSticks;
@property (nonatomic, retain) NSMutableArray *m_recents;
@property (nonatomic, retain) NSMutableArray *m_favorites;
@property (nonatomic, retain) NSMutableArray *m_purchased;

//manage project methods
- (NSMutableArray *)   getAllSticks;
- (NSMutableArray *)   getPunchSticks;
- (NSMutableArray *)   getNoPunchSticks;
- (BOOL) updateStickRecent: (NSString *) serial recent: (NSString *) stick_recent;
- (BOOL) updateStickFavorite: (NSString *) serial favorite: (NSString *) stick_favorite;
- (NSMutableArray *)  getRecents;
- (NSMutableArray *)  getFavorites;
- (NSMutableArray *)  getPurchased: (int) packIndex;
- (void) insertPacks: (int) index;

@end

DBManager *dbManger;   //global variable