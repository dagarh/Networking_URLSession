import Foundation
//: ## URLSession Challenge
//: __Instruction:__ Do the TODOs.
//:
//: Now we'll look more closely at `URLSessionConfiguration`.
//: ### Session Configurations & Sessions
//: The quickest way to get a session is to use the shared singleton session object:
let sharedSession = URLSession.shared
//: The shared singleton session object uses the __default configuration__,
//: for example, its `allowsCellularAccess` property has the default value `true`:
/* We can not change the values of configuration object in case of this sharedSession. So in order to setup your own configured session, you need to use separate URLSessionConfiguration object and then construct URLSession object from that. */

sharedSession.configuration.allowsCellularAccess
//: You cannot change this value in the session:
sharedSession.configuration.allowsCellularAccess = false
// check the value of allowsCellularAccess:
sharedSession.configuration.allowsCellularAccess
//: TODO: To create a session that doesn't allow cellular access,
//: first create a configuration object:
let myDefaultSessionConfiguration = URLSessionConfiguration.default

// check the value of allowsCellularAccess:
myDefaultSessionConfiguration.allowsCellularAccess

/* For non-background configuration, setting it to true should be your habit.  */
myDefaultSessionConfiguration.waitsForConnectivity


//: TODO: Then change its `allowsCellularAccess` property to `false`:
myDefaultSessionConfiguration.allowsCellularAccess = false

// check the value of allowsCellularAccess:
myDefaultSessionConfiguration.allowsCellularAccess
//: TODO: Set `waitsForConnectivity` to `true`, for this non-background configuration:
myDefaultSessionConfiguration.waitsForConnectivity = true
//: TODO: Set `multipathServiceType` to `.handover`, and update `allowsCellularAccess` to match:
myDefaultSessionConfiguration.multipathServiceType = .handover
myDefaultSessionConfiguration.allowsCellularAccess = true
//: TODO: Now create a session with this configuration:
let myDefaultSession = URLSession(configuration: myDefaultSessionConfiguration)


// check the session's values of the configuration properties you set:
myDefaultSession.configuration.allowsCellularAccess
myDefaultSession.configuration.waitsForConnectivity
myDefaultSession.configuration.multipathServiceType.rawValue

//: You can also create a session with the default configuration, if you don't need to change any properties:
let defaultSession = URLSession(configuration: .default)
//: And the value of `allowsCellularAccess` is the default value `true`:
defaultSession.configuration.allowsCellularAccess
defaultSession.configuration.waitsForConnectivity
//: ### Customize the Cache
//: The disk capacity of the default configuration is 10 million bytes:
/* It is 10 MB. It means this configuration stores cache file on disk. */
URLSessionConfiguration.default.urlCache?.diskCapacity
//: TODO: Look at the memory capacity of the cache:

/* It is half MB. It means, this configuration contains some cache information in RAM. */
myDefaultSessionConfiguration.urlCache?.memoryCapacity

/* It means this configuration also stores cookies, you could disable it if you want. */
myDefaultSessionConfiguration.httpShouldSetCookies

/* It means this configuration will accept cookies "onlyFromMainDocumentDomain" */
myDefaultSessionConfiguration.httpCookieAcceptPolicy.rawValue

/* This is where users credentials would be stored. And user's credentials are stored using a Keychain [Keychain is a password management system]. */
myDefaultSessionConfiguration.urlCredentialStorage

/*
 Always remember that you could make this default configuration object as ephemeral configuration object by manually setting all 3C's off for disk. But there is no need because that is available already for us.
 
 And same is true in case of ephemeral configuration. You can make ephemeral configuration as default configuration also by setting 3C's on for disk but there is no need to do that because default is readily available.
 
 So conclusion is : you can change any of the configuration objects to any other by changing settings for cookies, caches and credentials. But you should try to get configurations accordingly rather than trying to convert one from another.
 */
//: TODO: Create a new ephemeral configuration, and check the disk and memory capacity of its cache:
/*
 This session configuration does not store any of the sessions data i.e 3C's on disk. That's why disk capacity is zero. So, it is considered to be a private session. But if you want to customise it you can do so as discussed above.
 */

let ephemeralSessionConfiguration = URLSessionConfiguration.ephemeral

/* No persistance on disk. */
ephemeralSessionConfiguration.urlCache?.diskCapacity

/* Caches, Cookies and Credentials --> only in memory */
ephemeralSessionConfiguration.urlCache?.memoryCapacity

/* Would never be persisted on disk. */
ephemeralSessionConfiguration.httpShouldSetCookies
ephemeralSessionConfiguration.httpCookieAcceptPolicy.rawValue

/* Carefully check that credentials are stored in memory only. So they would never be persisted on disk in case of ephemeral. */
ephemeralSessionConfiguration.urlCredentialStorage
//: An ephemeral configuration has no persistent storage for cache, cookies or credentials,
//: but there might be a situation where you want a persistent cache, 
//: and are happy with not persisting cookies or credentials.
//:
//: TODO: Create a URLCache object with `memoryCapacity` 512000 and `diskCapacity` 10000000, and
//: assign it to the configuration's `urlCache` property:

// check the value of diskCapacity:

/* You could also specify disk path as nil, in which case it would use default path. */
let urlCache = URLCache(memoryCapacity: 512000, diskCapacity: 10000000, diskPath: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)

ephemeralSessionConfiguration.urlCache = urlCache

ephemeralSessionConfiguration.urlCache?.diskCapacity

/*
 So always remember that for URLSessionConfiguration is for session's data i.e for managing session's data i.e 3C's --> cookie, cache and credential, not for managing URLResponse's data, which we manage with the help of diff-2 task's objects.
 */


