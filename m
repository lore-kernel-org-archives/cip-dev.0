From: wolfgang.mauerer@siemens.com (Wolfgang Mauerer)
Date: Mon, 16 Apr 2018 16:34:15 +0200
Subject: [cip-dev] ARM64 and Debian LTS
In-Reply-To: <606a799a-cf5c-4f10-3789-19084d3f38e4@siemens.com>
References: <1536891.WlvLrdFcEH@linux-if6s>
	<606a799a-cf5c-4f10-3789-19084d3f38e4@siemens.com>
Message-ID: <5d070551-9255-5849-24fd-c9b5456522d1@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



On 16.04.2018 16:23, [ext] Jan Kiszka wrote:
> On 2018-04-16 15:52, Agust?n Benito Bethencourt wrote:
>> Hi Ben,
>>
>> is there any discussion going on about when ARM64 can make it as supported
>> architecture? Is it something expected for 2019 or is it not on the roadmap
>> yet?
>
> /me confused: https://wiki.debian.org/SupportedArchitectures and
> https://www.debian.org/ports/#portlist-released list arm64 as supported
> already.

the problem is: supported architecture != LTS architecture.

If we as CIP want arm64 support, we need to either wait for Debian 10
as base platform (which will hopefully include LTS for arm64 by
default), or use our newly to-be-found monetary influence to motivate
Debian to include arm64 in LTS for older releases.

Best regards, Wolfgang

>
> Jan
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
>
