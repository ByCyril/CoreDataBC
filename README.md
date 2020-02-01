# CoreDataBC (Deprecated)

## Overview
CoreDataBC is a high level framework that is built on top of CoreData. It's purpose is to make it easy for developers to interact with their Data Models.

This is what the simplicity of the framework looks like

#### Initialize
`let coreData = CoreDataBC("<Entity Name>", "<XCDataModelID>")`
#### Save Data
`self.coreData.pushSingleValue(["<Attribute>": <Value to save>])`
#### Retrieve Data
`self.coreData.retrieveData()`
#### Update Existing Data
`self.coreData.update(dataToUpdate, ["<attribute>": "<new value>"])` 

`datatoUpdate` is a reference variable (of type `NSManagedObject`) of the object you want to update. The following parameter is a dictionary of the values you are trying to update with.

#### Delete Data
`self.coreData.delete(<dataToDelete>)` 

`dataToDelete` is a variable that is of type `NSManagedObject`

#### Accessing the data
`let data = self.coreData.getData()` which returns an array of `[NSManagedObject]`. To access the values from an `NSManagedObject`, use the `value(forKey:_ )` function.


## Manual Install
Download the repository and drag to your project files



## Installation with Cocoapods
Installing CoreDataBC is as simple as
```
pod 'CoreDataBC'
```


### Initializing
1) Import the `CoreDataBC` module

2) Create an instance of the CoreDataBC Module
    `private let coreData = CoreDataBC(entity: "<Entity Name>", xcDataModelID: "<Name of your xcDataModelID>")`

### Prerequisites
Make sure you have your Data Model and youe Entities all setup before proceeding. 

### Saving Data - Single Entry
To save one entry, create a dictionary of the items you want to save. In this case, I am trying to add my contact info.

```swift
private let record = ["name": "Cyril Garcia", "email": "garciacy@bycyril.com"]
```

Call the pushSingleValue() method 

```swift
self.coreData.pushSingleValue(record)
```

### Saving Data - Multiple Entries
Create a few dictionaries of values

```swift
private let  recordOne = ["name": "Cyril", "email": "garciacy@bycyril.com"]
private let  recordTwo = ["name": "Kobe", "email": "kobe@gmail.com"]
private let  recordThree = ["name": "Micheal", "email": "micheal@gmail.com"]
```

Call the pushMultipleValues() method

```swift
self.coreData.pushMultipleValues([recordOne, recordTwo, recordThree])
```

### Retrieve Records
Retrieving records is failry simple with CoreDataBC. All you do is call the retrieveData() method. There are three ways you can retrieve records, either by sorted, filtered, or all.

```swift
self.coreData.retrieveData()
```

To access the items you've retrieved, call the ```getData()``` function which returns an array of an NSManagedObject.
```swift
self.coreData.getData()
```

### Update an existing record
To update an existing record, call the ```update()``` method. It has two parameters. `ReferenceObject`, `NewValue`.
The `ReferenceObject` is of type `NSManagedObject` and it is a reference to the record you want to update.
The `NewValue` is a dictionary of the new value you want to update with.

```swift
self.coreData.update(recordToUpdate, ["name": "Cy"])
```

### Delete a Record

Since the data you have is given as an array of an NSManagedObject, you can remove a record by its index or by the object itself. Just call the ```delete()``` function.

Delete by index
```swift
self.coreData.delete(0)
```

Delete by NSManagedObject
```swift
let objectToRemove = self.coreData.getData()[0]
self.coreData.delete(objectToRemove)
```

### Developed by Cyril

