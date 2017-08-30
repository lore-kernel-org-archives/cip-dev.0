From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 09:59:21 +0200
Subject: [cip-dev] How to back-port upstream BSP patches to CIP kernel
In-Reply-To: <1503081064.2047.130.camel@codethink.co.uk>
References: <90c61c7e-2459-b2dd-56e9-f07b1d5770bd@siemens.com>
	<1503081064.2047.130.camel@codethink.co.uk>
Message-ID: <32309b11-388a-b43f-6297-60e9a7c9a22f@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 2017-08-18 20:31, Ben Hutchings wrote:
> On Mon, 2017-08-07 at 10:59 -0400, Jan Kiszka wrote:
>> Hi Ben,
>>
>> after getting basically all patches for our Quark-based IOT2000 device
>> into upstream, I did the exercise of constructing a corresponding CIP
>> queue from that. The result is an almost 60 patches long series. Now I
>> was wondering if that is palatable for the CIP kernel and if I'm using
>> the right back-port approaches in all cases. Here is queue, first of all:
>>
>> https://github.com/siemens/linux/commits/queues/iot2000-cip
>> (just ignore the "iot2000-hack" tip)
> 
> You need to add the upstream commit hashes to the commit messages, like
> in stable backports.

Sure.

> 
>> There are a number of (presumably) non-brainer patches. But then there
>> are also more invasive back-ports that pulled some refactorings, such as
>>
>> - serial exar split-out
> 
> I think this is fine so long as both drivers (8250_pci and 8250_exar)
> are tested.
> 
>> - support for platform device properties
> 
> This includes API changes (to struct property_entry and
> device_add_property_set()) which I would normally want to avoid.  There
> are no in-tree users of these in 4.4, but CIP members might have
> out-of-tree or backported drivers that use them.

The alternative to backporting that change and all its deps is rewrite
"gpio-exar/8250-exar: Make set of exported GPIOs configurable", avoiding
device properties and maybe falling back to legacy platform_data
structures. That would be a deviation from the upstream patch, though
mostly in style. I'll try that, leaving a remark in the commit log about
the why.

> 
>> - GPIO API extension (converts gpiochip_add into a static inline wrapper
>>   around gpiochip_add_data -> module ABI change)
> 
> CIP doesn't make any promises about module ABI stability, so that's not
> a problem in itself.

Good.

> 
>> - the whole series of EFI capsule changes
> 
> As this is all new stuff, I think it's OK.  However you should remove
> the "default y" for EFI_CAPSULE_QUIRK_QUARK_CSH (upstream too!).
> 
> You left out commit fb7a84cac035 "efi/capsule: Move 'capsule' to the
> stack in efi_capsule_supported()".

Thanks, good point.

> 
>> Besides looking at the concrete case of this queue, I was wondering if
>> some general guidelines for back-porting changes from upstream could be
>> derived from that.
> 
> A general guideline would be: avoid backward-incompatible API changes.
> If you need to make any such changes then call attention to them when
> sending patches for review.

OK, thanks.

Jan
