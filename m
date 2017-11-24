From: wagi@monom.org (Daniel Wagner)
Date: Fri, 24 Nov 2017 09:48:20 +0100
Subject: [cip-dev] Applying for CIP work
In-Reply-To: <5A16B242.9050502@codethink.co.uk>
References: <DM5PR0501MB37344E0B91EF88799DA1A27BC52F0@DM5PR0501MB3734.namprd05.prod.outlook.com>
	<5A0EC9D9.5070708@codethink.co.uk>
	<DM5PR0501MB37341EF656B618DF85E4D6B9C52C0@DM5PR0501MB3734.namprd05.prod.outlook.com>
	<5A16B242.9050502@codethink.co.uk>
Message-ID: <687ad80d-4618-59aa-f13b-6fb437eb5437@monom.org>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Tiejun,

Sorry for the late response. Just in the middle of a release...

On 11/23/2017 12:34 PM, Agustin Benito Bethencourt wrote:
> Hi Tiejun,
> 
> On 18/11/17 08:01, Tiejun Chen wrote:
>> Agustin,
>>
>> Very? glad to meet you guys. I hope I can contribute to CIP.
>>
>> I'm trying to understand insight of CIP based some public materials
>> from your team. And then I will go to check kernel project. On my side
>> I'm curious if anyone started working Preempt RT CIP Kernel.
> 
> Daniel Wagner, in CC, is the CIP RT kernel maintainer. Daniel, can you
> provide an update on where you are at or tell Tiejun?

Sure. So far I create an initial cip-rt tree. It is not to do date. Ben
already created a cip-13, I am still on cip7-rt2. Those version are only
compile tested and not tested on real hardware. Currently, I am setting
up a test environment for the bbb. That is, I have all in place I am
working on finding a base config for the kernel. After that I'll update
my tree on Ben's tree. Also I need to apply the stable-rt patches from
Steven.

Yeah and I should move my tree kernel.org today... busy times :)

One thing we could work together is writing/collecting tests which are
relevant for rt. Anyway, I have Steven's ktest running but I didn't
grasp Steven's test suite so far.

Thanks,
Daniel
