From: daniel.wagner@siemens.com (Daniel Wagner)
Date: Wed, 7 Feb 2018 12:28:58 +0100
Subject: [cip-dev] [ANNOUNCE] 4.4.112-cip18-rt11
In-Reply-To: <003b01d39fb5$b9cca590$2d65f0b0$@toshiba.co.jp>
References: <20180128111920.36DF85009B1@mail.monom.org>
	<001c01d39eea$6803ed20$380bc760$@toshiba.co.jp>
	<9010a9d0-1ea4-bbe3-454d-5720085ed3bd@siemens.com>
	<003b01d39fb5$b9cca590$2d65f0b0$@toshiba.co.jp>
Message-ID: <eea25add-1e9f-6e20-e1e1-d5d21c27225b@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org


Hi Daniel,

>> Thanks for letting me know. The correct URL is
>>
>> https://www.kernel.org/pub/linux/kernel/people/wagi/cip-rt/4.4/
> 
> Sorry, but there is no " patch-4.4.112-cip18.xz" on that URL either.

Argh :) This should read patch-4.4.112-cip18-rt11.patch.xz

>>> Also shouldn't we have 3 patches? lts + cip + rt
>>
>> I just create the patches on top of the CIP version. 
> 
> Oh, I see. the vanilla linux url (linux-4.4.tar.xz) confused me. 
> Then, what we should use is this, right?:
> https://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-cip.git/snapshot/linux-cip-4.4.112-cip18.tar.gz
> https://www.kernel.org/pub/linux/kernel/people/wagi/cip-rt/4.4/patch-4.4.112-cip18-rt11.patch.xz

Yes. these are the right URLs.

>> The scripts for
>> this are the ones we use for the stable-rt trees. I don't know the
>> patches are useful or not. I don't mind dropping the patch services if
>> no one needs it. Neither Greg nor Ben are creating patch releases so
>> doing the cip-rt patches seems like a waste of time.
> 
> Personally, I don't mind if you stop releasing the patches. I have tested
> the cip-rt kernel from your git tree and so far I didn't have problems
> with long real-time latencies. I also confirmed that meltdown is fixed.

Right, I'll stop doing the patches.

Good to hear that the cip-rt works for you!

Thanks,
Daniel
