From: wagi@monom.org (Daniel Wagner)
Date: Wed, 17 Jul 2019 08:46:22 +0200
Subject: [cip-dev] [ANNOUNCE] 4.4.176-cip31-rt23
In-Reply-To: <20190716201431.GA9557@amd>
References: <20190329110611.1B897500722@mail.monom.org>
	<a86d4f19-790d-58ab-94b4-523a759d87b4@siemens.com>
	<20190715134336.GB16268@amd>
	<58c8af26-00ce-827d-999f-ccd545a0d974@monom.org>
	<20190716201431.GA9557@amd>
Message-ID: <5ffa53b1-b3e4-f99d-6289-1bae9364af3f@monom.org>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Good Morning,

On 7/16/19 10:14 PM, Pavel Machek wrote:
> Hi!
> 
>>>> Is there a chance to update 4.4-rt based on Daniel' 4.4.179-rt181 release, but
>>>> then to 4.4.182 in order to have SACK fixes in?
>>>
>>> Do you want 4.4.184, too, which fixes the SACK fixes? :-).
>>>
>>> I'm up-to 4.4.179-rt181-cip32.
>>>
>>> If I attempt to move forward to 4.4.181-cip3, I get some conflicts in
>>> rather core files.
>>>
>>> Auto-merging kernel/cpu.c
>>> CONFLICT (content): Merge conflict in kernel/cpu.c
>>> Auto-merging include/linux/sched.h
>>> CONFLICT (content): Merge conflict in include/linux/sched.h
>>> Auto-merging arch/x86/include/asm/thread_info.h
>>> CONFLICT (content): Merge conflict in
>>>
>>> I can attempt something, but I'd feel safer waiting for -stable-rt to
>>> solve it for me.
>>
>> FWIW, I am updating the stable-rt tree right now. As noted there are a
>> couple of merge conflicts ahead. Right now I am testing the result of the
>> v4.4.180 merge. So far all looks good and now I am waiting for the test
>> results from the CI system. After that I keep merging.
> 
> Thanks for good news. You have privat CI system, right?

I got a private one at home for development and I am also using the one 
sponsored by LinuxFoundation:

	https://ci-rt.linutronix.de/RT-Test/

I used to push the CIP version for testing to this CI system as well 
(see cip-4.4.y-rt branch). If you are interested to get access to the CI 
system you have to talk to Anna-Maria.

> If sources are available somewhere, I can try to help with testing.

I've just uploaded the v4.4.180-rt182 version. Announcement is coming 
later. I continue with the merging. I keep you updated.

Thanks,
Daniel
