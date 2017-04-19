From: don.f.brown@comcast.net (Don Brown)
Date: Wed, 19 Apr 2017 16:42:51 -0400
Subject: [cip-dev] cip-dev Digest, Vol 11, Issue 8
In-Reply-To: <mailman.81.1492603209.19013.cip-dev@lists.cip-project.org>
References: <mailman.81.1492603209.19013.cip-dev@lists.cip-project.org>
Message-ID: <CANm2L4mkv=b5ZEzrC-sJZDa1kWS=qg57X5izFH0LM8trvFYLJg@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Robert,

Yes. I started with the test tutorial here:
https://validation.linaro.org/static/docs/v2/standard-armmp-ramdisk-bbb.html
You will notice that there is no login or password.

When I had problems getting the test to properly log in to the BBB, I
copied and modified the script into 'bbb_debian_ramdisk_test2.yaml' to
include the username and password. It didn't work at the time, but that was
some time ago when I knew less about LAVA.

For everyone's benefit:
The requirement of needing to log into the Beaglebone-Black (BBB) as root
prior to running a test is a small, but very annoying and persistent
problem that Christos and I ran into when we first started to test live on
the BBB. If you watch the log file of the health check as it is being
executed, you'll see that the script makes the connection to the BBB, but
then it gets hung up. It needs to send a carriage return to the BBB prior
to applying the username and password since that is what we have to do when
we are trying to telnet into the BBB manually.

I'm trying to solve this by writing an 'expect' script that will:
1.) Make the connection to the BBB
2.) Wait for something like "'^]'" to be displayed and then wait a second
or two
3.) Send the '\r' to the BBB so it advances to the "login:" prompt
4.) Return control back to the Test Script where it *should* issue the
username and password.

If this approach works, I *think* we can call the expect script in place of
the 'telnet localhost 8020' - and we can update the Device Dictionary so
LAVA runs the new command too.

I hope that helps!





Sincerely,

Don Brown. PMP
don.f.brown at comcast.net
Mobile: (317) 560-0513
Here's to Life, Linux and the Pursuit of Happiness

On Wed, Apr 19, 2017 at 8:00 AM, <cip-dev-request@lists.cip-project.org>
wrote:

> Send cip-dev mailing list submissions to
>         cip-dev at lists.cip-project.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>         https://lists.cip-project.org/mailman/listinfo/cip-dev
> or, via email, send a message with subject or body 'help' to
>         cip-dev-request at lists.cip-project.org
>
> You can reach the person managing the list at
>         cip-dev-owner at lists.cip-project.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of cip-dev digest..."
>
>
> Today's Topics:
>
>    1. telnet connection and bbb testing (Robert Marshall)
>    2. CIP TSC meeting minutes (17 April 2017) (KOBAYASHI Yoshitake)
>    3. Re: CIP TSC meeting minutes (17 April 2017)
>       (Agustin Benito Bethencourt)
>    4. CIP workshop on 30th May at the OSSJ venue
>       (Agustin Benito Bethencourt)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Tue, 18 Apr 2017 15:00:35 +0100
> From: Robert Marshall <robert.marshall@codethink.co.uk>
> To: cip-dev at lists.cip-project.org
> Subject: [cip-dev] telnet connection and bbb testing
> Message-ID: <87inm1izng.fsf@ctlt579.codethink.co.uk>
> Content-Type: text/plain
>
> Don
>
> Our bbb_debian_ramdisk_test2.yaml has a auto_login section defining a
> login prompt username and password - was this approach tried and abandoned
> before
> starting to use keeping a telnet session active on the beaglebone-black
> tests?
>
> Robert
>
>
> ------------------------------
>
> Message: 2
> Date: Tue, 18 Apr 2017 23:42:51 +0900
> From: KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
> To: cip-dev at lists.cip-project.org
> Subject: [cip-dev] CIP TSC meeting minutes (17 April 2017)
> Message-ID: <268e138b-7f80-e674-6772-97806b659711@toshiba.co.jp>
> Content-Type: text/plain; charset=utf-8
>
> Hi all,
>
> I have uploaded meeting minutes for yesterday's CIP TSC conference call.
> https://wiki.linuxfoundation.org/civilinfrastructureplatform/
> tsc-meetings/tsc_mm_apr172017
>
> If you have any comments, please let us know.
>
> Best regards,
> Yoshi
>
>
>
> ------------------------------
>
> Message: 3
> Date: Tue, 18 Apr 2017 17:06:34 +0100
> From: Agustin Benito Bethencourt <agustin.benito@codethink.co.uk>
> To: KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
> Cc: cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] CIP TSC meeting minutes (17 April 2017)
> Message-ID: <58F6398A.2080601@codethink.co.uk>
> Content-Type: text/plain; charset=utf-8; format=flowed
>
> Hi,
>
> On 18/04/17 15:42, KOBAYASHI Yoshitake wrote:
> > Hi all,
> >
> > I have uploaded meeting minutes for yesterday's CIP TSC conference call.
> > https://wiki.linuxfoundation.org/civilinfrastructureplatform/
> tsc-meetings/tsc_mm_apr172017
> >
> > If you have any comments, please let us know.
>
> Thank you very much for formatting and publishing the minutes. I see
> this as a small but relevant improvement towards transparency.
>
> Best Regards
>
> --
> Agustin Benito Bethencourt
> Principal Consultant - FOSS at Codethink
> agustin.benito at codethink.co.uk
>
>
> ------------------------------
>
> Message: 4
> Date: Tue, 18 Apr 2017 17:13:37 +0100
> From: Agustin Benito Bethencourt <agustin.benito@codethink.co.uk>
> To: "cip-dev at lists.cip-project.org" <cip-dev@lists.cip-project.org>
> Subject: [cip-dev] CIP workshop on 30th May at the OSSJ venue
> Message-ID: <58F63B31.8040102@codethink.co.uk>
> Content-Type: text/plain; charset=utf-8; format=flowed
>
> Dear CIP friends,
>
> as you can read in the meeting minutes of yesterday's TSC meeting[1],
> the day before the Open Source Summit Japan starts, May 30th, we will
> organise some specific sessions related with CIP in the same venue.
>
> We are in the process of defining what we will do from 11:00 to 17:00.
> Feel free to:
> * Let us know if you are interested in attending.
> * Provide input on the topics you would like to work on, discuss or
> receive information.
>
> Maybe creating a wiki page to coordinate the activities would be wise,
> right?
>
> Best Regards
>
>
> [1]
> https://wiki.linuxfoundation.org/civilinfrastructureplatform/
> tsc-meetings/tsc_mm_apr172017
>
> --
> Agustin Benito Bethencourt
> Principal Consultant - FOSS at Codethink
> agustin.benito at codethink.co.uk
>
>
> ------------------------------
>
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
>
>
> End of cip-dev Digest, Vol 11, Issue 8
> **************************************
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20170419/3f03fda2/attachment.html>
