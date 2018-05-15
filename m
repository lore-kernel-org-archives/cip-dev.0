From: daniel.wagner@siemens.com (Daniel Wagner)
Date: Tue, 15 May 2018 09:53:37 +0200
Subject: [cip-dev] Reviewing 4.4 stable updates
In-Reply-To: <4164408.1bE63kujAu@linux-if6s>
References: <1524662329.2587.28.camel@codethink.co.uk>
	<003601d3ec02$20158f90$6040aeb0$@toshiba.co.jp>
	<000501d3ec18$26ef17d0$74cd4770$@toshiba.co.jp>
	<4164408.1bE63kujAu@linux-if6s>
Message-ID: <b584413d-e8dd-305c-546a-66ee6832772d@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Daniel,

>>> Dhinakar Kalyanasundaram mentioned that this bug was fixed in kernel 4.14,
>>> and Tim Bird updated the Fuego LTP documentation suggesting that
>>> backporting the patch "fanotify: Release SRCU lock when waiting for
>>> userspace response" should fix the hang.
>>> https://patchwork.kernel.org/patch/9659809/
>>>
>>> Shall I backport it and test?
> 
> It would be of a great help.
> 
> Can you send these reports to cip-testing-results ?

Just out of curiosity, do you also test the cip-rt kernel with fuego? I
got a report that a x86 box has problems to boot with the recent cip-rt
kernel. In the early device bring up a NULL pointer is dereferenced
(late_resume_init). So far I was not able to reproduce it on my machine.

Hence if you test the cip-rt kernel I would be interested to get
feedback as well :)

Thanks,
Daniel
