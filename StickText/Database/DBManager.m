//
//  DBManager.m
//  ImageOrganizer
//
//  Created by Wony Shin on 10/20/11.
//  Copyright 2011. All rights reserved.
//

#import "DBManager.h"
#import <sqlite3.h>


@implementation DBManager

@synthesize m_dbName = m_dbName;
@synthesize m_sticks = m_sticks;
@synthesize m_punchSticks = m_punchSticks;
@synthesize m_noPunchSticks = m_noPunchSticks;
@synthesize m_recents = m_recents;
@synthesize m_favorites = m_favorites;
@synthesize m_purchased = m_purchased;

///////////////////////////////////////////
/// initialize
///////////////////////////////////////////

- (id) init
{
	self = [super init];
	if (self != nil) {
        m_sticks = [[NSMutableArray alloc] init];
        
        m_recents = [[NSMutableArray alloc] init];
        
        m_favorites = [[NSMutableArray alloc] init];
        
        m_punchSticks = [[NSMutableArray alloc] init];
        
        m_noPunchSticks = [[NSMutableArray alloc] init];

        m_purchased = [[NSMutableArray alloc] init];
	}
    
	return self;
}


///////////////////////////////////////////
/// release
///////////////////////////////////////////

- (void) dealloc {
    if (m_dbName != nil) {
        [m_dbName release];
    }
    
    [m_sticks removeAllObjects];
    [m_sticks release];
    
    [m_recents removeAllObjects];
    [m_recents release];
    
    [m_favorites removeAllObjects];
    [m_favorites release];
    
    [super dealloc];
}

#pragma mark -
#pragma mark project management methods
- (NSMutableArray *) getAllSticks {
    // First Remove All Objects
    [m_sticks removeAllObjects];
    
    sqlite3 *database;
    
    // Open Database
	if (sqlite3_open([m_dbName UTF8String], &database) != SQLITE_OK) {
		sqlite3_close(database);
		
		NSLog(@"DBManager: getAllSticks : Open database Error!");
		return nil;
	}
    
	sqlite3_stmt *selectStatement;
    
    // Make Query
//	NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM tableSticks ORDER BY stick_index"];
	NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM tableSticks ORDER BY stick_title"];
    if (sqlite3_prepare_v2(database, [selectSql UTF8String], -1, &selectStatement, NULL) == SQLITE_OK) {
		while (sqlite3_step(selectStatement) == SQLITE_ROW) {
            NSString * stick_serial = [[NSString alloc] initWithFormat:@"%d", sqlite3_column_int(selectStatement, 0)];
            NSString * stick_index = [[NSString alloc] initWithFormat:@"%d", sqlite3_column_int(selectStatement, 1)];
            NSString * stick_recent = [[NSString alloc] initWithFormat:@"%.0f", sqlite3_column_double(selectStatement, 2)];
            NSString * stick_favorite = [[NSString alloc] initWithFormat:@"%d", sqlite3_column_int(selectStatement, 3)];
            NSString * stick_category = [[NSString alloc] initWithFormat:@"%d", sqlite3_column_int(selectStatement, 4)];
            NSString *stick_title = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(selectStatement, 5)];
            
            NSDictionary *dicStick = [[NSDictionary alloc] initWithObjectsAndKeys:stick_serial, @"serial", stick_index, @"index", stick_recent, @"recent", stick_favorite, @"favorite", stick_category, @"category", stick_title, @"title", nil];
                
            [m_sticks addObject: dicStick];
            
            [dicStick release];
            [stick_index release];
            [stick_recent release];
            [stick_favorite release];
            [stick_category release];
            [stick_title release];
		}
	}
	else {
		sqlite3_finalize(selectStatement);
		sqlite3_close(database);
		return nil;
	}
	
	sqlite3_finalize(selectStatement);
	sqlite3_close(database);
    
    return m_sticks;
}

- (NSMutableArray *) getPunchSticks {
    // First Remove All Objects
    [m_punchSticks removeAllObjects];
    
    sqlite3 *database;
    
    // Open Database
	if (sqlite3_open([m_dbName UTF8String], &database) != SQLITE_OK) {
		sqlite3_close(database);
		
		NSLog(@"DBManager: getPunchSticks : Open database Error!");
		return nil;
	}
    
	sqlite3_stmt *selectStatement;
    
    // Make Query
//	NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM tableSticks where stick_category like 0 ORDER BY serial"];
	NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM tableSticks where stick_category like 0 ORDER BY stick_title"];
	
    if (sqlite3_prepare_v2(database, [selectSql UTF8String], -1, &selectStatement, NULL) == SQLITE_OK) {
		while (sqlite3_step(selectStatement) == SQLITE_ROW) {
            NSString * stick_serial = [[NSString alloc] initWithFormat:@"%d", sqlite3_column_int(selectStatement, 0)];
            NSString * stick_index = [[NSString alloc] initWithFormat:@"%d", sqlite3_column_int(selectStatement, 1)];
            NSString * stick_recent = [[NSString alloc] initWithFormat:@"%.0f", sqlite3_column_double(selectStatement, 2)];
            NSString * stick_favorite = [[NSString alloc] initWithFormat:@"%d", sqlite3_column_int(selectStatement, 3)];
            NSString * stick_category = [[NSString alloc] initWithFormat:@"%d", sqlite3_column_int(selectStatement, 4)];
            NSString *stick_title = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(selectStatement, 5)];
            
            NSDictionary *dicStick = [[NSDictionary alloc] initWithObjectsAndKeys:stick_serial, @"serial", stick_index, @"index", stick_recent, @"recent", stick_favorite, @"favorite", stick_category, @"category", stick_title, @"title", nil];
            
            [m_punchSticks addObject: dicStick];
            //NSLog(@"stick_title=%@", stick_title);
            [dicStick release];
            [stick_index release];
            [stick_recent release];
            [stick_favorite release];
            [stick_category release];
            [stick_title release];
		}
	}
	else {
		sqlite3_finalize(selectStatement);
		sqlite3_close(database);
		return nil;
	}
	
	sqlite3_finalize(selectStatement);
	sqlite3_close(database);
    
    return m_punchSticks;
}

- (NSMutableArray *) getNoPunchSticks {
    // First Remove All Objects
    [m_noPunchSticks removeAllObjects];
    
    sqlite3 *database;
    
    // Open Database
	if (sqlite3_open([m_dbName UTF8String], &database) != SQLITE_OK) {
		sqlite3_close(database);
		 
		NSLog(@"DBManager: getPunchSticks : Open database Error!");
		return nil;
	}
    
	sqlite3_stmt *selectStatement;
    
    // Make Query
//	NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM tableSticks where stick_category like 1 ORDER BY stick_index"];
	NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM tableSticks where stick_category like 1 ORDER BY stick_title"];
	
    if (sqlite3_prepare_v2(database, [selectSql UTF8String], -1, &selectStatement, NULL) == SQLITE_OK) {
		while (sqlite3_step(selectStatement) == SQLITE_ROW) {
            NSString * stick_serial = [[NSString alloc] initWithFormat:@"%d", sqlite3_column_int(selectStatement, 0)];
            NSString * stick_index = [[NSString alloc] initWithFormat:@"%d", sqlite3_column_int(selectStatement, 1)];
            NSString * stick_recent = [[NSString alloc] initWithFormat:@"%.0f", sqlite3_column_double(selectStatement, 2)];
            NSString * stick_favorite = [[NSString alloc] initWithFormat:@"%d", sqlite3_column_int(selectStatement, 3)];
            NSString * stick_category = [[NSString alloc] initWithFormat:@"%d", sqlite3_column_int(selectStatement, 4)];
            NSString *stick_title = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(selectStatement, 5)];
            
            NSDictionary *dicStick = [[NSDictionary alloc] initWithObjectsAndKeys:stick_serial, @"serial", stick_index, @"index", stick_recent, @"recent", stick_favorite, @"favorite", stick_category, @"category", stick_title, @"title", nil];
            
            [m_noPunchSticks addObject: dicStick];
            
            [dicStick release];
            [stick_index release];
            [stick_recent release];
            [stick_favorite release];
            [stick_category release];
            [stick_title release];
		}
	}
	else {
		sqlite3_finalize(selectStatement);
		sqlite3_close(database);
		return nil;
	}
	
	sqlite3_finalize(selectStatement);
	sqlite3_close(database);
    
    return m_noPunchSticks;
}

- (BOOL) updateStickRecent: (NSString *) serial recent: (NSString *) stick_recent {
    sqlite3 *database;
    
    // Open Database
    if (sqlite3_open([m_dbName UTF8String], &database) != SQLITE_OK) {
		sqlite3_close(database);
		
		NSLog(@"Open database Error!");
		return NO;
	}
    
    NSString *selectSql;
    
    selectSql = [NSString stringWithFormat: @"update tableSticks set stick_recent = \"%@\" where serial like \"%@\" ", stick_recent, serial];
    
    NSLog(@"%@", selectSql);
    
    if (sqlite3_exec(database, [selectSql UTF8String], nil, nil, nil) != SQLITE_OK)
    {
        
        NSLog(@"Error while update stick recent (%@) SQL Data. : %s", stick_recent, sqlite3_errmsg(database));
        sqlite3_close(database);
        return NO;
    }
    
    sqlite3_close(database);
    
    return YES;
}

- (BOOL) updateStickFavorite: (NSString *) serial favorite: (NSString *) stick_favorite {
    sqlite3 *database;
    
    // Open Database
    if (sqlite3_open([m_dbName UTF8String], &database) != SQLITE_OK) {
		sqlite3_close(database);
		
		NSLog(@"Open database Error!");
		return NO;
	}
    
    NSString *selectSql;
    
    selectSql = [NSString stringWithFormat: @"update tableSticks set stick_favorite = \"%@\" where serial like \"%@\" ", stick_favorite, serial];
    
    NSLog(@"%@", selectSql);
    
    if (sqlite3_exec(database, [selectSql UTF8String], nil, nil, nil) != SQLITE_OK)
    {
        NSLog(@"Error while update stick favorite (%@) SQL Data. : %s", stick_favorite, sqlite3_errmsg(database));
        sqlite3_close(database);
        return NO;
    }
    
    sqlite3_close(database);
    
    return YES;
}

- (NSMutableArray *) getRecents {
    // First Remove All Objects
    [m_recents removeAllObjects];
    
    sqlite3 *database;
    
    // Open Database
	if (sqlite3_open([m_dbName UTF8String], &database) != SQLITE_OK) {
		sqlite3_close(database);
		
		NSLog(@"DBManager: getRecents : Open database Error!");
		return nil;
	}
    
	sqlite3_stmt *selectStatement;
    
    // Make Query
	NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM tableSticks where stick_recent <> 0 ORDER BY stick_recent DESC"];
	
    if (sqlite3_prepare_v2(database, [selectSql UTF8String], -1, &selectStatement, NULL) == SQLITE_OK) {
		while (sqlite3_step(selectStatement) == SQLITE_ROW) {
            NSString * stick_serial = [[NSString alloc] initWithFormat:@"%d", sqlite3_column_int(selectStatement, 0)];
            NSString * stick_index = [[NSString alloc] initWithFormat:@"%d", sqlite3_column_int(selectStatement, 1)];
            NSString * stick_recent = [[NSString alloc] initWithFormat:@"%.0f", sqlite3_column_double(selectStatement, 2)];
            NSString * stick_favorite = [[NSString alloc] initWithFormat:@"%d", sqlite3_column_int(selectStatement, 3)];
            NSString * stick_category = [[NSString alloc] initWithFormat:@"%d", sqlite3_column_int(selectStatement, 4)];
            NSString * stick_title = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(selectStatement, 5)];
            
            NSDictionary *dicStick = [[NSDictionary alloc] initWithObjectsAndKeys:stick_serial, @"serial", stick_index, @"index", stick_recent, @"recent", stick_favorite, @"favorite", stick_category, @"category", stick_title, @"title", nil];
            
            [m_recents addObject: dicStick];
            
            [dicStick release];
            [stick_index release];
            [stick_recent release];
            [stick_favorite release];
            [stick_category release];
            [stick_title release];
		}
	}
	else {
		sqlite3_finalize(selectStatement);
		sqlite3_close(database);
		return nil;
	}
	
	sqlite3_finalize(selectStatement);
	sqlite3_close(database);
    
    return m_recents;
}

- (NSMutableArray *) getFavorites {
    // First Remove All Objects
    [m_favorites removeAllObjects];
    
    sqlite3 *database;
    
    // Open Database
	if (sqlite3_open([m_dbName UTF8String], &database) != SQLITE_OK) {
		sqlite3_close(database);
		
		NSLog(@"DBManager: getFavorites : Open database Error!");
		return nil;
	}
    
	sqlite3_stmt *selectStatement;
    
    // Make Query
	NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM tableSticks where stick_favorite like 1 ORDER BY stick_index"];
	
    if (sqlite3_prepare_v2(database, [selectSql UTF8String], -1, &selectStatement, NULL) == SQLITE_OK) {
		while (sqlite3_step(selectStatement) == SQLITE_ROW) {
            NSString * stick_serial = [[NSString alloc] initWithFormat:@"%d", sqlite3_column_int(selectStatement, 0)];
            NSString * stick_index = [[NSString alloc] initWithFormat:@"%d", sqlite3_column_int(selectStatement, 1)];
            NSString * stick_recent = [[NSString alloc] initWithFormat:@"%.0f", sqlite3_column_double(selectStatement, 2)];
            NSString * stick_favorite = [[NSString alloc] initWithFormat:@"%d", sqlite3_column_int(selectStatement, 3)];
            NSString * stick_category = [[NSString alloc] initWithFormat:@"%d", sqlite3_column_int(selectStatement, 4)];
            NSString * stick_title = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(selectStatement, 5)];
            
            NSDictionary *dicStick = [[NSDictionary alloc] initWithObjectsAndKeys:stick_serial, @"serial", stick_index, @"index", stick_recent, @"recent", stick_favorite, @"favorite", stick_category, @"category", stick_title, @"title", nil];
            
            [m_favorites addObject: dicStick];
            
            [dicStick release];
            [stick_index release];
            [stick_recent release];
            [stick_favorite release];
            [stick_category release];
            [stick_title release];
		}
	}
	else {
		sqlite3_finalize(selectStatement);
		sqlite3_close(database);
		return nil;
	}
	
	sqlite3_finalize(selectStatement);
	sqlite3_close(database);
    
    return m_favorites;
}

- (NSMutableArray *)  getPurchased: (int) packIndex
{
    // First Remove All Objects
    [m_purchased removeAllObjects];
    
    sqlite3 *database;
    
    // Open Database
	if (sqlite3_open([m_dbName UTF8String], &database) != SQLITE_OK) {
		sqlite3_close(database);
		
		NSLog(@"DBManager: getRecents : Open database Error!");
		return nil;
	}
    
	sqlite3_stmt *selectStatement;
    
    // Make Query
//	NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM tableSticks where stick_purchased > 0 ORDER BY stick_title"];
  	NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM tableSticks where stick_purchased = %d ORDER BY stick_title", packIndex];
	
    if (sqlite3_prepare_v2(database, [selectSql UTF8String], -1, &selectStatement, NULL) == SQLITE_OK) {
		while (sqlite3_step(selectStatement) == SQLITE_ROW) {
            NSString * stick_serial = [[NSString alloc] initWithFormat:@"%d", sqlite3_column_int(selectStatement, 0)];
            NSString * stick_index = [[NSString alloc] initWithFormat:@"%d", sqlite3_column_int(selectStatement, 1)];
            NSString * stick_recent = [[NSString alloc] initWithFormat:@"%.0f", sqlite3_column_double(selectStatement, 2)];
            NSString * stick_favorite = [[NSString alloc] initWithFormat:@"%d", sqlite3_column_int(selectStatement, 3)];
            NSString * stick_category = [[NSString alloc] initWithFormat:@"%d", sqlite3_column_int(selectStatement, 4)];
            NSString * stick_title = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(selectStatement, 5)];
            NSString * stick_purchased = [[NSString alloc] initWithFormat:@"%d", sqlite3_column_int(selectStatement, 6)];
            
            NSDictionary *dicStick = [[NSDictionary alloc] initWithObjectsAndKeys:stick_serial, @"serial", stick_index, @"index", stick_recent, @"recent", stick_favorite, @"favorite", stick_category, @"category", stick_title, @"title", stick_purchased, @"purchased", nil];
            
            [m_purchased addObject: dicStick];
            
            [dicStick release];
            [stick_index release];
            [stick_recent release];
            [stick_favorite release];
            [stick_category release];
            [stick_title release];
            [stick_purchased release];
		}
	}
	else {
		sqlite3_finalize(selectStatement);
		sqlite3_close(database);
		return nil;
	}
	
	sqlite3_finalize(selectStatement);
	sqlite3_close(database);
    
    return m_purchased;
}

- (void) insertPacks: (int) index
{
    NSMutableArray* packArray1 = [[NSMutableArray alloc] initWithObjects:
    @"INSERT INTO 'tableSticks' VALUES(21,20,0,'false',0,'Awesome!',1)",
    @"INSERT INTO 'tableSticks' VALUES(22,21,0,'false',0,'BYOB',1)",
    @"INSERT INTO 'tableSticks' VALUES(23,22,0,'false',0,'Call Me!',1)",
    @"INSERT INTO 'tableSticks' VALUES(24,23,0,'false',0,'Crap!',1)",
    @"INSERT INTO 'tableSticks' VALUES(25,24,0,'false',0,'Do I Look Like I Give a Shit?!',1)",
    @"INSERT INTO 'tableSticks' VALUES(26,25,0,'false',0,'Good Morning!',1)",
    @"INSERT INTO 'tableSticks' VALUES(27,26,0,'false',0,'Good Night!',1)",
    @"INSERT INTO 'tableSticks' VALUES(28,27,0,'false',0,'I''m Sorry!',1)",
    @"INSERT INTO 'tableSticks' VALUES(29,28,0,'false',0,'Let''s Hang Out!',1)",
    @"INSERT INTO 'tableSticks' VALUES(30,29,0,'false',0,'My Phone''s About To Die!',1)",
    @"INSERT INTO 'tableSticks' VALUES(31,30,0,'false',0,'Running Late!',1)",
    @"INSERT INTO 'tableSticks' VALUES(32,31,0,'false',0,'See You Tonight!',1)",
    @"INSERT INTO 'tableSticks' VALUES(33,32,0,'false',0,'Seriously?',1)",
    @"INSERT INTO 'tableSticks' VALUES(34,33,0,'false',0,'Sucks To Be You!',1)",
    @"INSERT INTO 'tableSticks' VALUES(35,34,0,'false',0,'TGIF',1)",
    @"INSERT INTO 'tableSticks' VALUES(36,35,0,'false',0,'Thank You!',1)",
    @"INSERT INTO 'tableSticks' VALUES(37,36,0,'false',0,'That Stinks!',1)",
    @"INSERT INTO 'tableSticks' VALUES(38,37,0,'false',0,'Way To Go!',1)",
    @"INSERT INTO 'tableSticks' VALUES(39,38,0,'false',0,'Where Are You?',1)",
    @"INSERT INTO 'tableSticks' VALUES(40,39,0,'false',0,'Yo! Whaddup!',1)",
                                  //additional
    @"INSERT INTO 'tableSticks' VALUES(92,91,0,'false',0,'SMH!',1)",
                                  ///no punchline
    @"INSERT INTO 'tableSticks' VALUES(81,80,0,'false',1,'Awesome!',1)",
    @"INSERT INTO 'tableSticks' VALUES(82,81,0,'false',1,'I''m Sorry!',1)",
    @"INSERT INTO 'tableSticks' VALUES(83,82,0,'false',1,'My Phone''s About To Die!',1)",
    @"INSERT INTO 'tableSticks' VALUES(84,83,0,'false',1,'Sucks To Be You!',1)",

                                  nil];
    
    NSMutableArray* packArray2 = [[NSMutableArray alloc] initWithObjects:
    @"INSERT INTO 'tableSticks' VALUES(41,40,0,'false',0,'BRB!',2)",
    @"INSERT INTO 'tableSticks' VALUES(42,41,0,'false',0,'Congratulations',2)",
    @"INSERT INTO 'tableSticks' VALUES(43,42,0,'false',0,'Cool',2)",
    @"INSERT INTO 'tableSticks' VALUES(44,43,0,'false',0,'Epic Fail!',2)",
    @"INSERT INTO 'tableSticks' VALUES(45,44,0,'false',0,'Funny!',2)",
    @"INSERT INTO 'tableSticks' VALUES(46,45,0,'false',0,'Good Morning!',2)",
    @"INSERT INTO 'tableSticks' VALUES(47,46,0,'false',0,'Good Night!',2)",
    @"INSERT INTO 'tableSticks' VALUES(48,47,0,'false',0,'Happy Birthday!',2)",
    @"INSERT INTO 'tableSticks' VALUES(49,48,0,'false',0,'Just Hanging!',2)",
    @"INSERT INTO 'tableSticks' VALUES(50,49,0,'false',0,'Just Kidding!',2)",
    @"INSERT INTO 'tableSticks' VALUES(51,50,0,'false',0,'Keep Rocking!',2)",
    @"INSERT INTO 'tableSticks' VALUES(52,51,0,'false',0,'Have A Nice Day!',2)",
    @"INSERT INTO 'tableSticks' VALUES(53,52,0,'false',0,'On My Way',2)",
    @"INSERT INTO 'tableSticks' VALUES(54,53,0,'false',0,'ROFLOL',2)",
    @"INSERT INTO 'tableSticks' VALUES(55,54,0,'false',0,'Shit Happens!',2)",
    @"INSERT INTO 'tableSticks' VALUES(56,55,0,'false',0,'That Sucks!',2)",
    @"INSERT INTO 'tableSticks' VALUES(57,56,0,'false',0,'U Da Man!',2)",
    @"INSERT INTO 'tableSticks' VALUES(58,57,0,'false',0,'Whatever',2)",
    @"INSERT INTO 'tableSticks' VALUES(59,58,0,'false',0,'Yeah Right!!!',2)",
    @"INSERT INTO 'tableSticks' VALUES(60,59,0,'false',0,'ZZZ',2)",
                                  //additional
    @"INSERT INTO 'tableSticks' VALUES(93,92,0,'false',0,'Cool Story Bro!',2)",
                                  ///no punchline
    @"INSERT INTO 'tableSticks' VALUES(85,84,0,'false',1,'Funny!',2)",
    @"INSERT INTO 'tableSticks' VALUES(86,85,0,'false',1,'Keep Rocking!',2)",

                                  nil];
    
    NSMutableArray* packArray3 = [[NSMutableArray alloc] initWithObjects:
    @"INSERT INTO 'tableSticks' VALUES(61,60,0,'false',0,'Are You Ok?',3)",
    @"INSERT INTO 'tableSticks' VALUES(62,61,0,'false',0,'Blah! Blah! Blah!',3)",
    @"INSERT INTO 'tableSticks' VALUES(63,62,0,'false',0,'Can''t Sleep!',3)",
    @"INSERT INTO 'tableSticks' VALUES(64,63,0,'false',0,'Don''t Be Stupid!',3)",
    @"INSERT INTO 'tableSticks' VALUES(65,64,0,'false',0,'Don''t Know!',3)",
    @"INSERT INTO 'tableSticks' VALUES(66,65,0,'false',0,'Gnarly',3)",
    @"INSERT INTO 'tableSticks' VALUES(67,66,0,'false',0,'Great!',3)",
    @"INSERT INTO 'tableSticks' VALUES(68,67,0,'false',0,'Happy Birthday!',3)",
    @"INSERT INTO 'tableSticks' VALUES(69,68,0,'false',0,'Have Fun!',3)",
    @"INSERT INTO 'tableSticks' VALUES(70,69,0,'false',0,'Hugs & Kisses',3)",
    @"INSERT INTO 'tableSticks' VALUES(71,70,0,'false',0,'Huh? OMG!',3)",
    @"INSERT INTO 'tableSticks' VALUES(72,71,0,'false',0,'I Love You Too!',3)",
    @"INSERT INTO 'tableSticks' VALUES(73,72,0,'false',0,'I Love You!',3)",
    @"INSERT INTO 'tableSticks' VALUES(74,73,0,'false',0,'I''m Sick',3)",
    @"INSERT INTO 'tableSticks' VALUES(75,74,0,'false',0,'Just Chillin',3)",
    @"INSERT INTO 'tableSticks' VALUES(76,75,0,'false',0,'Later!',3)",
    @"INSERT INTO 'tableSticks' VALUES(77,76,0,'false',0,'Let''s Party!',3)",
    @"INSERT INTO 'tableSticks' VALUES(78,77,0,'false',0,'Rolling My Eyes',3)",
    @"INSERT INTO 'tableSticks' VALUES(79,78,0,'false',0,'Sup Dawg?',3)",
    @"INSERT INTO 'tableSticks' VALUES(80,79,0,'false',0,'What The F…?',3)",
                                  //additional
    @"INSERT INTO 'tableSticks' VALUES(94,93,0,'false',0,'Talk to the Hand',3)",
                                  ///no punchline
    @"INSERT INTO 'tableSticks' VALUES(87,86,0,'false',1,'Are You Ok?',3)",
    @"INSERT INTO 'tableSticks' VALUES(88,87,0,'false',1,'Gnarly',3)",
    @"INSERT INTO 'tableSticks' VALUES(89,88,0,'false',1,'I''m Sick',3)",
    @"INSERT INTO 'tableSticks' VALUES(90,89,0,'false',1,'Later!',3)",
    @"INSERT INTO 'tableSticks' VALUES(91,90,0,'false',1,'Rolling My Eyes',3)",
                                  nil];
    
    NSMutableArray* packArray4 = [[NSMutableArray alloc] initWithObjects:
    @"INSERT INTO 'tableSticks' VALUES(95,94,0,'false',0,'Christmas Bombed!',4)",
    @"INSERT INTO 'tableSticks' VALUES(96,95,0,'false',0,'Christmas Cheers!',4)",
    @"INSERT INTO 'tableSticks' VALUES(97,96,0,'false',0,'Christmas Hater!',4)",
    @"INSERT INTO 'tableSticks' VALUES(98,97,0,'false',0,'Christmas Shopping!',4)",
    @"INSERT INTO 'tableSticks' VALUES(99,98,0,'false',0,'Christmas Shopping!',4)",
    @"INSERT INTO 'tableSticks' VALUES(100,99,0,'false',0,'Christmasalicious!!!',4)",
    @"INSERT INTO 'tableSticks' VALUES(101,100,0,'false',0,'Happy Holidays!',4)",
    @"INSERT INTO 'tableSticks' VALUES(102,101,0,'false',0,'Happy Holidays!',4)",
    @"INSERT INTO 'tableSticks' VALUES(103,102,0,'false',0,'Happy New Year!',4)",
    @"INSERT INTO 'tableSticks' VALUES(104,103,0,'false',0,'Have A Great Summer!',4)",
    @"INSERT INTO 'tableSticks' VALUES(105,104,0,'false',0,'Ho! Ho! Ho!',4)",
    @"INSERT INTO 'tableSticks' VALUES(106,105,0,'false',0,'Home For Christmas!',4)",
    @"INSERT INTO 'tableSticks' VALUES(107,106,0,'false',0,'Is It Too Late To Be Good?',4)",
    @"INSERT INTO 'tableSticks' VALUES(108,107,0,'false',0,'Let It Snow!',4)",
    @"INSERT INTO 'tableSticks' VALUES(109,108,0,'false',0,'Merry Christmas Happy New Year!',4)",
    @"INSERT INTO 'tableSticks' VALUES(110,109,0,'false',0,'Merry Christmas!',4)",
    @"INSERT INTO 'tableSticks' VALUES(111,110,0,'false',0,'Merry Xmas!',4)",
    @"INSERT INTO 'tableSticks' VALUES(112,111,0,'false',0,'Santa Belly!',4)",
    @"INSERT INTO 'tableSticks' VALUES(113,112,0,'false',0,'Santa''s Helper',4)",
    @"INSERT INTO 'tableSticks' VALUES(114,113,0,'false',0,'See You Soon!',4)",
    @"INSERT INTO 'tableSticks' VALUES(115,114,0,'false',0,'We''re On Our Way!',4)",
                                  
    @"INSERT INTO 'tableSticks' VALUES(116,115,0,'false',1,'Christmas Bombed!',4)",
    @"INSERT INTO 'tableSticks' VALUES(117,116,0,'false',1,'Christmas Cheers!',4)",
    @"INSERT INTO 'tableSticks' VALUES(118,117,0,'false',1,'Christmas Shopping!',4)",
    @"INSERT INTO 'tableSticks' VALUES(119,118,0,'false',1,'Happy Holidays!',4)",
    @"INSERT INTO 'tableSticks' VALUES(120,119,0,'false',1,'Happy Holidays!',4)",
    @"INSERT INTO 'tableSticks' VALUES(121,120,0,'false',1,'Have A Great Summer!',4)",
    @"INSERT INTO 'tableSticks' VALUES(122,121,0,'false',1,'Home For Christmas!',4)",
    @"INSERT INTO 'tableSticks' VALUES(123,122,0,'false',1,'Let It Snow!',4)",
    @"INSERT INTO 'tableSticks' VALUES(124,123,0,'false',1,'Merry Xmas!',4)",
    @"INSERT INTO 'tableSticks' VALUES(125,124,0,'false',1,'See You Soon!',4)",
                                  nil];
    
    
    /*
    NSDictionary *dicStick = [[NSDictionary alloc] initWithObjectsAndKeys:stick_serial, @"serial", stick_index, @"index", stick_recent, @"recent", stick_favorite, @"favorite", stick_category, @"category", stick_title, @"title", nil];
    
    [m_sticks addObject: dicStick];
    
    [dicStick release];
    NSString* tempStr111111 = @"INSERT INTO tableSticks (stick_title) VALUES ";
    */
    switch (index) {
        case 1:
            for( int i = 0; i < packArray1.count; i++ )
                [self runInsertQuery:[packArray1 objectAtIndex:i]];
            break;
        case 2:
            for( int i = 0; i < packArray2.count; i++ )
                [self runInsertQuery:[packArray2 objectAtIndex:i]];
            break;
        case 3:
            for( int i = 0; i < packArray3.count; i++ )
                [self runInsertQuery:[packArray3 objectAtIndex:i]];
            break;
        case 4:
            for( int i = 0; i < packArray4.count; i++ )
                [self runInsertQuery:[packArray4 objectAtIndex:i]];
            break;
            
        case 0:
            for( int i = 0; i < packArray1.count; i++ )
                [self runInsertQuery:[packArray1 objectAtIndex:i]];
            for( int i = 0; i < packArray2.count; i++ )
                [self runInsertQuery:[packArray2 objectAtIndex:i]];
            for( int i = 0; i < packArray3.count; i++ )
                [self runInsertQuery:[packArray3 objectAtIndex:i]];
            for( int i = 0; i < packArray4.count; i++ )
                [self runInsertQuery:[packArray4 objectAtIndex:i]];
            break;
        default:
            break;
    }
}

- (void) runInsertQuery: (NSString *) queryString
{
    sqlite3 *database;
    
    // Open Database
	if (sqlite3_open([m_dbName UTF8String], &database) != SQLITE_OK) {
		sqlite3_close(database);
		
		NSLog(@"DBManager: getAllSticks : Open database Error!");
	}
    
	sqlite3_stmt *compiledStatement;
    
    // Make Query
    if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK) {
        sqlite3_step(compiledStatement);
        sqlite3_finalize(compiledStatement);
	}
    else
    {
        NSLog(@"Problem with prepare statement%s",sqlite3_errmsg(database));
    }  
    
	sqlite3_close(database);
}

@end
