# HID Homework Interview

### Question 1: Code Review
A fellow developer has asked you to review the following code. Please provide your feedback.
```C
1.  char *GetErrorString( int x )
2.  {
3.     // **errorString should be a pointer not array**
4.     // When the function returns:
5.     //    • the call stack will return back to the caller function
6.     //    • the local variable memory will be undefined
7.     // We are assigning it to a string literal
8.     // String literals are generally stored in the read only text segment
9.     // which lives for the duration of the program
10.    // So no memory needs to be allocated with an array for it
12.    // REPLACE WITH (Assumed change for the rest of program)
13.    // char *errorString;
14.    char errorString[20];
15.
16.    switch ( x )
17.    {
18.       case 0:
19.          errorString = "Success -- No error";
20.          break;
21.       case 2:
22.          errorString = "Overflow!";
23.          break;
24.       // **Possible Addition of Cases**
25.       // We should check if we need to handle case 1
26.       // or any other case explicitly
27.       // ADD CODE
28.       // case 1:
29.       //    errorString = "string for error code 1";
30.       //    break;
31.
32.       // **Should have a default case**
33.       // ADD CODE
34.       // default:
35.       //    errorString = "Unhandled error code";
36.       // OR
37.       //    asprintf(&errorString, "Unhandled error code %d", x);
38.       //    break;
39.    }
40.
41.    // **Shouldn't have to do line below**
42.    // When we use a string literal, it is already null terminated
43.    // REMOVE line below
44.    errorString[19] = 0;
45.    return errorString;
46. }
47.
48. void main( void )
49. {
50.    // ** List of Returns **
51.    // We should check the list of returns
52.    // so that we can handle all cases within GetErrorString
53.    int err = DoSomething();
54.
55.    // **consider removing if check below**
56.    // With this if statement, Case 0 within GetErrorString will be ignored
57.    // Depending on what we want, we can remove the if statement
58.    // If we are generally logging things
59.    // We can just print out that it was a success as well
60.    if ( err )
61.    {
62.       printf( "%s\n", GetErrorString( err ) );
63.    }
64. }
```

Other notes for problem above.
With GetErrorString
1. *errorString should be a pointer not array**
   * You can keep the array if you'd like, but you have to make it static so that the memory persists outside of the scope its in
   * you can also malloc some memory on the heap for your string, but that requires the caller to free it after use
   * these two methods above have the increased benefit of allowing the caller to alter the errorString after getting it, but is a little more complex
   * Just make sure the returned errorString pointer is pointing to memory that will persist outside of the scope of the function

2. If you decide to allocate memory instead of using string literals, you have to
   * use strncpy to copy over your string into the allocated memory
   * `strncpy(errorString, "Success -- No error.", errorStringSize)`
   * where errorStringSize is the size of the allocated memory
   * in lines 19, 22, and any other lines you are setting `errorString`
   * Then you can keep the final assignment of the null terminating character in this case (or some other way, just make sure errorString is null terminated)
   * also make sure you fill the memory correclty with whatever method you choose

Let me know if you have any questions.



