From: daniel.wagner@siemens.com (Daniel Wagner)
Date: Tue, 6 Feb 2018 11:27:33 +0100
Subject: [cip-dev] [ANNOUNCE] 4.4.112-cip18-rt11
In-Reply-To: <001c01d39eea$6803ed20$380bc760$@toshiba.co.jp>
References: <20180128111920.36DF85009B1@mail.monom.org>
	<001c01d39eea$6803ed20$380bc760$@toshiba.co.jp>
Message-ID: <9010a9d0-1ea4-bbe3-454d-5720085ed3bd@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Daniel,

On 02/06/2018 02:32 AM, Daniel Sangorrin wrote:
>> -----Original Message-----
>> From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Daniel Wagner
> ...
>> Or to build 4.4.112-cip18-rt11 directly, the following patches should be applied:
>>
>>   http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz
>>
>>   http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.112-cip18.xz
> 
> This URL doesn't work.

Thanks for letting me know. The correct URL is

https://www.kernel.org/pub/linux/kernel/people/wagi/cip-rt/4.4/

> Also shouldn't we have 3 patches? lts + cip + rt

I just create the patches on top of the CIP version. The scripts for
this are the ones we use for the stable-rt trees. I don't know the
patches are useful or not. I don't mind dropping the patch services if
no one needs it. Neither Greg nor Ben are creating patch releases so
doing the cip-rt patches seems like a waste of time.

Thanks,
Daniel
