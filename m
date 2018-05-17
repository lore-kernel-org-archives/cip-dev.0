From: wagi@monom.org (Daniel Wagner)
Date: Thu, 17 May 2018 07:35:06 +0200
Subject: [cip-dev] Reviewing 4.4 stable updates
In-Reply-To: <000301d3ed80$8e0c3d80$aa24b880$@toshiba.co.jp>
References: <1524662329.2587.28.camel@codethink.co.uk>
	<003601d3ec02$20158f90$6040aeb0$@toshiba.co.jp>
	<000501d3ec18$26ef17d0$74cd4770$@toshiba.co.jp>
	<4164408.1bE63kujAu@linux-if6s>
	<b584413d-e8dd-305c-546a-66ee6832772d@siemens.com>
	<000301d3ed80$8e0c3d80$aa24b880$@toshiba.co.jp>
Message-ID: <c69d5a4e-251b-3737-dd52-fa38f2565efe@monom.org>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Daniel,

>> Just out of curiosity, do you also test the cip-rt kernel with fuego? I
>> got a report that a x86 box has problems to boot with the recent cip-rt
>> kernel. In the early device bring up a NULL pointer is dereferenced
>> (late_resume_init). So far I was not able to reproduce it on my machine.
>>
>> Hence if you test the cip-rt kernel I would be interested to get
>> feedback as well :)
> 
> I do test the cip-rt kernel sometimes, but not in an automated way yet (in the end automation requires maintenance and that takes time). With the latest version I didn't have boot problems on x86_64, but I haven't tried on other architectures. I run cyclictest with some load background and got a maximum latency of 125us (only run it for 10 minutes).

Thanks for the feedback. After some more debugging, it looks like the 
boot problem is cased by kexec on the test machine. IOW, the test kernel 
seems just fine.

Thanks,
Daniel
