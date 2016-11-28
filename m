From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Mon, 28 Nov 2016 15:17:34 +0100
Subject: [cip-dev] Features backports
In-Reply-To: <2a7cf15f-4b7b-b23d-5385-e72e16fe465a@siemens.com>
References: <582EF368.4090006@codethink.co.uk>
	<2a7cf15f-4b7b-b23d-5385-e72e16fe465a@siemens.com>
Message-ID: <583C3C7E.5000904@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

On 28/11/16 14:47, Jan Kiszka wrote:
> On 2016-11-18 13:26, Agustin Benito Bethencourt wrote:
>> Hi,
>>
>> as you probably know, the more features we backport, the higher will be
>> the maintenance cost overtime so as a strategy, we need to be very
>> conservative.
>>
>> I sent a mail some days ago about the features backported already by
>> Linaro for their LSK (Linaro Stable Kernel) for your evaluation. I bring
>> today some potential backports related with security features and
>> hardware support that has been identified by Ben H.
>>
>> * UBSAN support:
>> <https://git.kernel.org/linus/c6d308534aef6c99904bf5862066360ae067abc4>
>>
>> * Increased user-space ASLR range for ARM:
>> <https://lwn.net/Articles/667790/>
>>
>> * Page poisoning on free:
>> <https://git.kernel.org/linus/8823b1dbc05fab1a8bec275eeae4709257c2661d>,
>> <https://git.kernel.org/linus/1414c7f4f7d72d138fff35f00151d15749b5beda>
>>
>> * SLAB/SLUB freelist randomisation
>>
>> * Hardened usercopy
>>
>> * Do Members use SLUB? if not, we should take a look at KASAN support
>> for SLAB
>>
>> * drm/tilcdc update? (many bug fixes post-4.4)
>>
>> * AM33xx RTC support:
>>
>> <https://git.kernel.org/linus/461932dfb54ebaf7da438fd8b769a01ce97a9360>,
>> <https://git.kernel.org/linus/b5a553c08bec14a058501df3fa6eb39f63f00a98>
>>
>
> To add two features areas from our requirement list:
>
> - Distributed Switch Architecture, basically the level of 4.8 would be
>    sufficient. However, there might be too many dependencies on
>    networking core changes. If we pick 4.9 as next SLTS, then this
>    becomes obsolete.
>
> - Graphic support for AM57xx from more recent kernels, but things may
>    even still depend on TI's vendor kernel (in which case it would be
>    too early).
>
> Both are a bit vague yet, but I'm trying to clarify more details.
> Comments are already welcome, of course.

This is good. It allows us to dig a little and provide some light.

>
> Jan
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
>

-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
