From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Thu, 26 Apr 2018 08:52:55 +0900
Subject: [cip-dev] Reviewing 4.4 stable updates
In-Reply-To: <1524662329.2587.28.camel@codethink.co.uk>
References: <1524662329.2587.28.camel@codethink.co.uk>
Message-ID: <000701d3dcf0$88242bd0$986c8370$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Ben,

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org
> [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Ben Hutchings
> Sent: Wednesday, April 25, 2018 10:19 PM
> To: cip-dev at lists.cip-project.org
> Subject: [cip-dev] Reviewing 4.4 stable updates
> 
> I intended to bounce the review messages for 4.4.128 to this list so
> everyone could see them, but this seems to be blocked by some mail
> filter.

We received a message from Greg on the cip-dev list saying:

***
Responses should be made by Fri Apr 13 18:34:54 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.128-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.
***

Fri Apr 13 is in the past but better late than never I guess!.

> Instead I've saved them to an mbox file which is available from:
> http://download.cip-project.org/cip-kernel/stable-4.4.128-review.mbox

Just for those who don't know, you can open it with a text editor. 
Or you can just use linux-stable-rc.git for testing the patches.

> However, the review for 4.4.129 has now started so if all reviewers
> have subscribed to stable at vger.kernel.org then we can start with that
> instead.

I saw there is already a 4.4.129 on the linux-stable-rc.git linux-4.4.y.
Test results so far show no regressions (altough i see failures that might need investigation?):
Pixel: https://lkml.org/lkml/2018/4/22/732
Linaro: https://lkml.org/lkml/2018/4/23/116
Kerneltests: https://lkml.org/lkml/2018/4/23/823
dmseg: https://lkml.org/lkml/2018/4/23/1028

I will run some tests with Fuego.

Thanks,
Daniel






> 
> Ben.
> 
> --
> Ben Hutchings
> Software Developer, Codethink Ltd.
> 
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
