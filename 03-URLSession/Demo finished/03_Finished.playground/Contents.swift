import Foundation

//: ## URL & URLComponents
//: ### URL from String
//: It's easy to create a `URL` object from a String:
let urlString = "https://itunes.apple.com:80/search/1/file.txt?media=music&entity=song&term=abba#gothere"

/* This is optional URL, it means while creating URL from string, url might be nil. In case when string contains unsafe characters or empty, url would be nil. If you think that string contains unsafe characters then better to create URLComponents first from string and then fetch url from that. */
var url = URL(string: urlString)
//: Let's look at some of the properties of `url`:
url?.absoluteString
url?.relativeString
url?.absoluteURL
url?.baseURL

url?.scheme
url?.host
url?.port
url?.path
url?.query
url?.fragment

url?.pathComponents
url?.lastPathComponent
url?.pathExtension
url?.relativePath

url?.user

/*
 Always remember that all the above properties are read only properties. We can not change them. Use URLComponent instead.

 url?.scheme = "http" // can not do this
 */




//: You can start with a `baseURL`, then add to it.
//: This is useful for building REST API urls.

let baseURL = URL(string: "https://itunes.apple.com")
let relativeURL = URL(string: "search", relativeTo: baseURL)?.appendingPathComponent("item").appendingPathExtension("txt")

relativeURL?.absoluteString
relativeURL?.relativeString
relativeURL?.absoluteURL
relativeURL?.baseURL

relativeURL?.scheme
relativeURL?.host
relativeURL?.port
relativeURL?.path
relativeURL?.query
relativeURL?.fragment

relativeURL?.pathComponents
relativeURL?.lastPathComponent
relativeURL?.pathExtension
relativeURL?.relativePath

relativeURL?.user

/* Session data [Users data] is just 3C's i.e Cookie, Cache and Credentials. The "Data?" which we get as part of response is Response's data ----> it has nothing to do with user's data. Remember that you can not change the URL's properties, they are read only properties. So whenever we are talking of URLSessionConfiguration, then they mainly differ in terms of session's data i.e user's data i.e 3C's i.e Cookies, Caches and Credentials.
 
 But while talking of URLSessionTask objects, we are mainly dealing with the response's data i.e the body of HTTPURLResponse.
 */
//: ### URLComponents
//: URLs sent over the Internet can only contain characters that are letters or digits 
//: on an English-language keyboard, plus a very few punctuation marks, like '-' and '_'.
//: Strings that represent URLs can contain many other characters, including other alphabets.
//: An app must URL-encode any "unsafe" characters before sending the URL.
//: This is also called *percent-encoding*, because unsafe characters are encoded as 
//: one or more pairs of hexadecimal digits, each preceded by '%'.
//: The space character is encoded as `%20` or +.
//: '%' itself is `%25`, and '+' is `%2B`.
//:
//: The easiest way to ensure your URLs are URL-encoded is to build them with `URLComponents`:
/* Additional advantage which you get here in case of URLComponents, apart from encoding of unsafe characters [this is also called as percent encoding], is --> you can change properties here if you want after construction of URLComponents. These are not read only properties : */

/* So easiest way to ensure that your urls are url-encoded is to build them with URLComponents. */
var urlComponents = URLComponents(string: "https://itunes.apple.com/search?media=music&entity=song")
var queryItem = URLQueryItem(name: "term", value: "crowded house")

urlComponents?.queryItems?.append(queryItem)

urlComponents?.url
urlComponents?.string
urlComponents?.queryItems

urlComponents?.scheme
urlComponents?.host
urlComponents?.port
urlComponents?.path
urlComponents?.query
urlComponents?.fragment

/* See this, it got changed. */
urlComponents?.scheme = "http"
urlComponents?.scheme
//: You can even URL-encode an emoji, like "smiling cat face with heart-shaped eyes" —
//: it's `%F0%9F%98%BB`
queryItem = URLQueryItem(name: "emoji", value: "😻")
urlComponents?.queryItems?.append(queryItem)
urlComponents?.url
urlComponents?.string
urlComponents?.queryItems
