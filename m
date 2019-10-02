From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Wed, 2 Oct 2019 08:31:40 +0000
Subject: [cip-dev] Testing results for 4.19-cip-rt
In-Reply-To: <20191002082238.GA9041@amd>
References: <20191002082238.GA9041@amd>
Message-ID: <TYAPR01MB22856D44519AE15F3CD9D5C3B79C0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 02 October 2019 09:23
>
> Hi!
>
> I pushed -cip-rt version to kernel.org, which got me automatic test on
> gitlab:
>
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/309275693
>
> ...compile okay, but run_tests failed; unfortunately I don't quite
> understand what went wrong with the test. Can someone help?

It looks like test join #4665[0] failed due to internet connectivity issues in the lab.

I've re-run the job and it passes[1], so you should be okay.
I've also re-run the GitLab CI test job[2], so GitLab will show the pipeline as a success[3].


[0] https://lava.ciplatform.org/scheduler/job/4665
[1] https://lava.ciplatform.org/scheduler/job/4716
[2] https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/309590344
[3] https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/85866813

Kind regards, Chris

>
> Thanks,
> ????? ??????? ??????? ??????? ??????? ??????? ??????? ??????? ??????? Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
