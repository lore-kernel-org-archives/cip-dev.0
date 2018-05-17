From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Thu, 17 May 2018 10:44:11 +0900
Subject: [cip-dev] Reviewing 4.4 stable updates
In-Reply-To: <b584413d-e8dd-305c-546a-66ee6832772d@siemens.com>
References: <1524662329.2587.28.camel@codethink.co.uk>
	<003601d3ec02$20158f90$6040aeb0$@toshiba.co.jp>
	<000501d3ec18$26ef17d0$74cd4770$@toshiba.co.jp>
	<4164408.1bE63kujAu@linux-if6s>
	<b584413d-e8dd-305c-546a-66ee6832772d@siemens.com>
Message-ID: <000301d3ed80$8e0c3d80$aa24b880$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> -----Original Message-----
> From: Daniel Wagner [mailto:daniel.wagner at siemens.com]
> Sent: Tuesday, May 15, 2018 4:54 PM
> To: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> Cc: agustin.benito at codethink.co.uk; cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] Reviewing 4.4 stable updates
> 
> Hi Daniel,
> 
> >>> Dhinakar Kalyanasundaram mentioned that this bug was fixed in kernel 4.14,
> >>> and Tim Bird updated the Fuego LTP documentation suggesting that
> >>> backporting the patch "fanotify: Release SRCU lock when waiting for
> >>> userspace response" should fix the hang.
> >>> https://patchwork.kernel.org/patch/9659809/
> >>>
> >>> Shall I backport it and test?
> >
> > It would be of a great help.
> >
> > Can you send these reports to cip-testing-results ?
> 
> Just out of curiosity, do you also test the cip-rt kernel with fuego? I
> got a report that a x86 box has problems to boot with the recent cip-rt
> kernel. In the early device bring up a NULL pointer is dereferenced
> (late_resume_init). So far I was not able to reproduce it on my machine.
> 
> Hence if you test the cip-rt kernel I would be interested to get
> feedback as well :)

I do test the cip-rt kernel sometimes, but not in an automated way yet (in the end automation requires maintenance and that takes time). With the latest version I didn't have boot problems on x86_64, but I haven't tried on other architectures. I run cyclictest with some load background and got a maximum latency of 125us (only run it for 10 minutes).

Thanks,
Daniel Sangorrin
