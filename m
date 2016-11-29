From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Tue, 29 Nov 2016 10:01:38 +0100
Subject: [cip-dev] Features backports
In-Reply-To: <390B4EACA1A32748BA6BC7F859F7D71655274E10@GSjpTKYDCembx31.service.hitachi.net>
References: <582EF368.4090006@codethink.co.uk>
	<390B4EACA1A32748BA6BC7F859F7D71655274E10@GSjpTKYDCembx31.service.hitachi.net>
Message-ID: <583D43F2.50301@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

On 29/11/16 03:57, ???? / KOGUCHI?TAKUO wrote:
> Hi,
>
> Regarding to Altera Socfpga Cyclone V, we might want to backport from 4.9;
> - L2cache ECC(./arch/arm/mm/cache-l2x0.c)
> - QSPI Flash controller(drivers/mtd/spi-nor/cadence-quadspi.c)
>
> 4.9 is still missing the followings which exist in the verdor tree(linux-socfpga);
> - HPS2FPGA(drivers/fpga/altera-hps2fpga.c)
> - NAND Flash controller(drivers/mtd/nand/denali_dt.c)
> I hope we can encourage Altera to push these features upstream or do it ourselves.

I think we have a good chance once they see we are testing Beaglebone 
Black in the open. That would be a good opportunity we might add value 
to them.

Definitely I would talk to them before. If they are not pushing the 
patches upstream, it would be a good question why.

>
> Takuo
>
>
>> -----Original Message-----
>> From: cip-dev-bounces at lists.cip-project.org
>> [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Agustin Benito
>> Bethencourt
>> Sent: Friday, November 18, 2016 9:26 PM
>> To: cip-dev at lists.cip-project.org
>> Subject: [!][cip-dev] Features backports
>>
>> Hi,
>>
>> as you probably know, the more features we backport, the higher will be the
>> maintenance cost overtime so as a strategy, we need to be very
>> conservative.
>>
>> I sent a mail some days ago about the features backported already by Linaro
>> for their LSK (Linaro Stable Kernel) for your evaluation. I bring today some
>> potential backports related with security features and hardware support that
>> has been identified by Ben H.
>>
>> * UBSAN support:
>> <https://git.kernel.org/linus/c6d308534aef6c99904bf5862066360ae067abc4
>>>
>>
>> * Increased user-space ASLR range for ARM:
>> <https://lwn.net/Articles/667790/>
>>
>> * Page poisoning on free:
>> <https://git.kernel.org/linus/8823b1dbc05fab1a8bec275eeae4709257c2661
>> d>,
>> <https://git.kernel.org/linus/1414c7f4f7d72d138fff35f00151d15749b5beda>
>>
>> * SLAB/SLUB freelist randomisation
>>
>> * Hardened usercopy
>>
>> * Do Members use SLUB? if not, we should take a look at KASAN support for
>> SLAB
>>
>> * drm/tilcdc update? (many bug fixes post-4.4)
>>
>> * AM33xx RTC support:
>>
>> <https://git.kernel.org/linus/461932dfb54ebaf7da438fd8b769a01ce97a9360
>>> ,
>> <https://git.kernel.org/linus/b5a553c08bec14a058501df3fa6eb39f63f00a98>
>>
>>
>> Best Regards
>> --
>> Agustin Benito Bethencourt
>> Principal Consultant - FOSS at Codethink agustin.benito at codethink.co.uk
>> _______________________________________________
>> cip-dev mailing list
>> cip-dev at lists.cip-project.org
>> https://lists.cip-project.org/mailman/listinfo/cip-dev
>

-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
