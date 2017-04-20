From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Thu, 20 Apr 2017 15:55:14 +0100
Subject: [cip-dev] telnet connection and bbb testing
In-Reply-To: <CANm2L4mkv=b5ZEzrC-sJZDa1kWS=qg57X5izFH0LM8trvFYLJg@mail.gmail.com>
	(Don Brown's message of "Wed, 19 Apr 2017 16:42:51 -0400")
References: <mailman.81.1492603209.19013.cip-dev@lists.cip-project.org>
	<CANm2L4mkv=b5ZEzrC-sJZDa1kWS=qg57X5izFH0LM8trvFYLJg@mail.gmail.com>
Message-ID: <87shl3gmct.fsf_-_@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Don Brown <don.f.brown@comcast.net> writes:
(reformatted Don's response)

> Robert Marshall <robert.marshall@codethink.co.uk> wrote:
>>
>>  Don
>>
>>  Our bbb_debian_ramdisk_test2.yaml has a auto_login section defining a
>>  login prompt username and password - was this approach tried and abandoned before
>>  starting to use keeping a telnet session active on the beaglebone-black
>>  tests?
>
> Hi Robert,
>
> Yes. I started with the test tutorial here: https://validation.linaro.org/static/docs/v2/standard-armmp-ramdisk-bbb.html
> You will notice that there is no login or password.
>
> When I had problems getting the test to properly log in to the BBB, I copied and modified the script into
> 'bbb_debian_ramdisk_test2.yaml' to include the username and password. It didn't work at the time, but that was some
> time ago when I knew less about LAVA.
>
> For everyone's benefit:
> The requirement of needing to log into the Beaglebone-Black (BBB) as root prior to running a test is a small, but very
> annoying and persistent problem that Christos and I ran into when we first started to test live on the BBB. If you watch
> the log file of the health check as it is being executed, you'll see that the script makes the connection to the BBB, but then
> it gets hung up. It needs to send a carriage return to the BBB prior to applying the username and password since that is
> what we have to do when we are trying to telnet into the BBB manually.
>
> I'm trying to solve this by writing an 'expect' script that will: 
> 1.) Make the connection to the BBB
> 2.) Wait for something like "'^]'" to be displayed and then wait a second or two
> 3.) Send the '\r' to the BBB so it advances to the "login:" prompt
> 4.) Return control back to the Test Script where it *should* issue the username and password.
>
> If this approach works, I *think* we can call the expect script in place of the 'telnet localhost 8020' - and we can update
> the Device Dictionary so LAVA runs the new command too.
>
> I hope that helps!
>

I'm now using this script - using expect - a wrapper around the telnet
connection_command and getting fairly consistent health check successes
without any manual intervention with the Beaglebone black

Robert
