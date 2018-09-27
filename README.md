# SwiftyCoreData



# Manual Install
Download the repository and drag to your project files



# Installation with Cocoapods
Installing SwiftyCoreData is as simple as
```
pod 'CoreDataBC'
```


### Initializing
1) Import the `CoreDataBC` module

2) Create an instance of the CoreDataBC Module
    `private let coreData = CoreDataBC(entity: "<Entity Name>", xcDataModelID: "<Name of your xcDataModelID>")`


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
To update an existing record, call the ```update()``` method. It has three parameters. `key`, `value`, and `newValue`.
The `key` is the attribute name of the value you want to change. 
The `value` is the existing value that is in place
The `newValue` is the new value you want to replace

### Delete a Record

Since the data you have is given as an array of an NSManagedObject, you can remove a record by its index or by the object itself. Just call the ```remove()``` function.

Remove by index
```swift
self.coreData.remove(0)
```

Remove by NSManagedObject
```swift
let objectToRemove = self.coreData.getData()[0]
self.coreData.remove(objectToRemove)
```



