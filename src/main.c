// The MIT License (MIT)
//
// Copyright (c) 2015 Jeff Olson <olson.jeffery@gmail.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
// main.c - skeleton entry point for a low-level msp430 application

#include <msp430.h>

int main(void) {
   unsigned int count;
   WDTCTL = WDTPW + WDTHOLD; //Stop watchdog timer

   P1OUT = 0; //Configure P1 to output on P1.0
   P1DIR |= 0x01;

   for(;;){
      P1OUT ^= 0x01; //Toggle P1.0 using exclusive-OR
      for(count=0; count<10000; count++){ /* Insert some delay */ }
   }
}
