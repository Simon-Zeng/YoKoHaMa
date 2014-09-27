//
//  HMFeeDao.h
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HMFee.h"

/**
 *  HMFeeDao is an adapter to get/update/delete HMFee object from database
 */
@interface HMFeeDao : NSObject

/**
 *  Save an HMFee object to DB and return its identifier
 *
 *  @param aFee The object to save
 *
 *  @return The identifier of the saved HMFee
 */
+ (NSNumber *)saveFee:(HMFee *)aFee;

/**
 *  Fetch an HMFee object with the specified identifier
 *
 *  @param identifier The identifier for the HMFee
 *
 *  @return An HMFee object
 */
+ (HMFee *)feeWithIdentifier:(NSNumber *)identifier;
/**
 *  Fetch all the HMFee objects with the specified travelIdentifier
 *
 *  @param travelIdentifier The identifier for the travel
 *
 *  @return An array of HMFee objects
 */
+ (NSArray *)feesWithTravelIdentifier:(NSNumber *)travelIdentifier;

/**
 *  Update the HMFee into DB
 *
 *  @param aFee The HMFee to update
 *
 *  @return Boolean value indicate the update succeed or not
 */
+ (BOOL)updateFee:(HMFee *)aFee;

/**
 *  Delete HMFee objects with the specified identifier from DB
 *
 *  @param identifier The identifier of the HMFee to delete
 *
 *  @return oolean value indicate the delete succeed or not
 */
+ (BOOL)deleteFeeWithIdentifier:(NSNumber *)identifier;

/**
 *  Delete HMFee objects with the specified travel identifier from DB
 *
 *  @param travelIdentifier The travel identifier of the HMFees to delete
 *
 *  @return Boolean value indicate the delete succeed or not
 */
+ (BOOL)deleteFeeWithTravelIdentifier:(NSNumber *)travelIdentifier;

@end
