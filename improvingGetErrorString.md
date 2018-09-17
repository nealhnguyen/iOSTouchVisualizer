# HID Homework Interview

## Question 1: Code Review
**A fellow developer has asked you to review the following code. Please provide your feedback.**

*Note: I am assuming this is in C*
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

## Question 2

**You are asked to filter a noisy, but slowly-shifting sensor signal using a low-pass, finite impulse response (FIR) filter.  Derive the mean delay, and expected SNR boost (noise standard deviation of output compared to input) for two filter variations, plotting your results:**

**N filter taps, uniformly weighted:**
* `y[n] = (x[n] + ... + x[n-N+1])/N`

**M filter taps, harmonically weighted:**
* `z[n] = (M*x[n] + (M-1)*x[n-1] ... + 1*x[n-M+1]) / (M*(M+1)/2`

*Note all work is shown in `FIR Filter Analysis.pdf`*

*I was also unable to finish analysis on the harmonically weighted filter, so I will provide my intuiton and thoughts* 😭

**a) What depths (N and M) are needed to boost the SNR by a factor of 5?**

From looking around I found that the SNR boost for the uniformly weighted filter is N^1/2. Thus N=25 for the uniformly weighted filter will boost SNR by a factor of 5.

The harmonically weighted filter will give more precedence to the recent points. This tells me that it works less to average out past signals and will be more prone to noise. So it would probably require a much larger number of taps (M) than N to obtain an SNR boost of 5.

**b) Which filter has the lowest mean delay at the required depth?**

The uniformly weighted moving average is calculated to have a delay of N/2. The harmonically weighted filter is calculated to have a delay of M/3. Thus the harmonically weighted filter has a lower delay when using the same number of taps as the uniformly weighted filter.

I can't intuitively think of a reason to support an answer. I would need to figure out how to calculate the SNR boost of the harmonically weighted filter. At that point simple algebra to solve the M number of taps to needed to get an SNR boost of 5 could then be plugged into M/3 to determine if it is smaller than 25/2 (N/2).

**c) Which setup do you recommend as a tradeoff between SNR and delay?**

The things that must be considered for this problem are:
1. the optimal number of taps for SNR boost and delay
1. the speed and SNR boost requirements
1. the amount of noise we can generally expect

From graphing just the tradeoff of SNR boost and delay for the uniformly weighted filter. I find that you get diminishing returns after 4 taps. I found that it takes 25 taps to get an SNR boost of 5. That is quite far from the optimal tap count for the uniformly weighted filter. You must weigh how far from the optimal number of taps we are going for each filter. *I determined the optimal tap count by finding the point when SNR boost and delay intersect intersect on the same scale. This is shown in my work. In hindsight, I should normalize them because having an SNR boost of 1 does not necessarily have an equal importance of having a delay of 1.*

As noted in the previous paragraph, we must understand what SNR and delay is ideal. Through human interfacing surveys, I'll assume that we have determined that an SNR boost of 5 is ideal as stated in the problem statement. Thus it just becomes a math game of which filter has a lower delay for that SNR. But one caveat is that if increasing the SNR threshold slightly lower introduces a much lower delay in one filter, it is worth exploring a lower SNR boost requirement and doing the same calculation for which filter introduces the smallest delay.

Finally, understanding amount of noise we must deal with is important. If noise is relatively small, it is worth lowering the SNR boost requirements. I will again assume that thorugh user studies and research, an SNR of 5 is best.

## Question 3

1. App to show fingers on screen 👍
2. Updating XY coordinates with uniform filter 👍
3. Updating XY coordinates with harmonic filter 📌 TODO
4. Visualize touches passing throuhg both filters simultaneously. 📌 TODO
5. Play with number of taps with uniform filter 👍
6. Play with number of taps with harmonic filter 📌 TODO

The user experience is reduced as I increase the number of taps for the uniform filter. It starts mattering at N = 1000. I did not notice much benifit to adding the filter for the touch visualizer. But I can see where it would be useful when analyzing for general swipe commands. At which point, it seemed N=10 was when I saw things slow down past a threshold I was okay with. 