From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Tue, 15 May 2018 13:06:39 +0900
Subject: [cip-dev] Reviewing 4.4 stable updates
In-Reply-To: <000701d3dcf0$88242bd0$986c8370$@toshiba.co.jp>
References: <1524662329.2587.28.camel@codethink.co.uk>
	<000701d3dcf0$88242bd0$986c8370$@toshiba.co.jp>
Message-ID: <003601d3ec02$20158f90$6040aeb0$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org
> [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Daniel Sangorrin
> Sent: Thursday, April 26, 2018 8:53 AM
> To: 'Ben Hutchings' <ben.hutchings@codethink.co.uk>;
> cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] Reviewing 4.4 stable updates
...
> I saw there is already a 4.4.129 on the linux-stable-rc.git linux-4.4.y.
> Test results so far show no regressions (altough i see failures that might need
> investigation?):
> Pixel: https://lkml.org/lkml/2018/4/22/732
> Linaro: https://lkml.org/lkml/2018/4/23/116
> Kerneltests: https://lkml.org/lkml/2018/4/23/823
> dmseg: https://lkml.org/lkml/2018/4/23/1028
> 
> I will run some tests with Fuego.

Sorry for the late response. I tested LTS 4.4.129 with Fuego and most tests worked correctly.
There were a few errors on some of the LTP tests (see the file attached).

fcntl35.c:98: FAIL: an unprivileged user init the capacity of a pipe to 65536 unexpectedly, expected 4096
getxattr04.c:72: FAIL: getxattr() failed to get an existing attribute
inotify07.c:157: FAIL: didn't get event: mask=40000004
inotify08.c:150: FAIL: didn't get event: mask=4
[Note] These 4 errors could be related with some configuration, so I need to investigate them further.

For fanotify07 and fanotify08 I got some timeout errors:
tst_test.c:1015: INFO: Timeout per run is 0h 05m 00s
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Cannot kill test processes!
Congratulation, likely test hit a kernel bug.
Exitting uncleanly...

Dhinakar Kalyanasundaram mentioned that this bug was fixed in kernel 4.14, and Tim Bird updated the Fuego LTP documentation suggesting that backporting the patch "fanotify: Release SRCU lock when waiting for userspace response" should fix the hang.
https://patchwork.kernel.org/patch/9659809/

Shall I backport it and test?

Thanks,
Daniel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Fuego-LTP-defaultspec-LTS4.4.129-results.xlsx
Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
Size: 54610 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20180515/4f02e9de/attachment-0001.xlsx>
