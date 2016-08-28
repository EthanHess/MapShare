//
//  Picture+CoreDataProperties.h
//  MapShare
//
//  Created by Ethan Hess on 8/27/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Picture.h"

NS_ASSUME_NONNULL_BEGIN

@interface Picture (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *picData;

@end

NS_ASSUME_NONNULL_END
