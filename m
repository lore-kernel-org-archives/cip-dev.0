From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Wed, 7 Feb 2018 10:48:17 +0900
Subject: [cip-dev] [ANNOUNCE] 4.4.112-cip18-rt11
In-Reply-To: <9010a9d0-1ea4-bbe3-454d-5720085ed3bd@siemens.com>
References: <20180128111920.36DF85009B1@mail.monom.org>
	<001c01d39eea$6803ed20$380bc760$@toshiba.co.jp>
	<9010a9d0-1ea4-bbe3-454d-5720085ed3bd@siemens.com>
Message-ID: <003b01d39fb5$b9cca590$2d65f0b0$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> -----Original Message-----
> From: Daniel Wagner [mailto:daniel.wagner at siemens.com]
> Sent: Tuesday, February 06, 2018 7:28 PM
> To: Daniel Sangorrin; cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] [ANNOUNCE] 4.4.112-cip18-rt11
> 
> Hi Daniel,
> 
> On 02/06/2018 02:32 AM, Daniel Sangorrin wrote:
> >> -----Original Message-----
> >> From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Daniel Wagner
> > ...
> >> Or to build 4.4.112-cip18-rt11 directly, the following patches should be applied:
> >>
> >>   http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz
> >>
> >>   http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.112-cip18.xz
> >
> > This URL doesn't work.
> 
> Thanks for letting me know. The correct URL is
> 
> https://www.kernel.org/pub/linux/kernel/people/wagi/cip-rt/4.4/

Sorry, but there is no " patch-4.4.112-cip18.xz" on that URL either.

> > Also shouldn't we have 3 patches? lts + cip + rt
> 
> I just create the patches on top of the CIP version. 

Oh, I see. the vanilla linux url (linux-4.4.tar.xz) confused me. 
Then, what we should use is this, right?:
https://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-cip.git/snapshot/linux-cip-4.4.112-cip18.tar.gz
https://www.kernel.org/pub/linux/kernel/people/wagi/cip-rt/4.4/patch-4.4.112-cip18-rt11.patch.xz

> The scripts for
> this are the ones we use for the stable-rt trees. I don't know the
> patches are useful or not. I don't mind dropping the patch services if
> no one needs it. Neither Greg nor Ben are creating patch releases so
> doing the cip-rt patches seems like a waste of time.

Personally, I don't mind if you stop releasing the patches. I have tested
the cip-rt kernel from your git tree and so far I didn't have problems
with long real-time latencies. I also confirmed that meltdown is fixed.

Thanks,
Daniel
