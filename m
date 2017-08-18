From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 18 Aug 2017 19:31:04 +0100
Subject: [cip-dev] How to back-port upstream BSP patches to CIP kernel
In-Reply-To: <90c61c7e-2459-b2dd-56e9-f07b1d5770bd@siemens.com>
References: <90c61c7e-2459-b2dd-56e9-f07b1d5770bd@siemens.com>
Message-ID: <1503081064.2047.130.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Mon, 2017-08-07 at 10:59 -0400, Jan Kiszka wrote:
> Hi Ben,
> 
> after getting basically all patches for our Quark-based IOT2000 device
> into upstream, I did the exercise of constructing a corresponding CIP
> queue from that. The result is an almost 60 patches long series. Now I
> was wondering if that is palatable for the CIP kernel and if I'm using
> the right back-port approaches in all cases. Here is queue, first of all:
> 
> https://github.com/siemens/linux/commits/queues/iot2000-cip
> (just ignore the "iot2000-hack" tip)

You need to add the upstream commit hashes to the commit messages, like
in stable backports.

> There are a number of (presumably) non-brainer patches. But then there
> are also more invasive back-ports that pulled some refactorings, such as
> 
> - serial exar split-out

I think this is fine so long as both drivers (8250_pci and 8250_exar)
are tested.

> - support for platform device properties

This includes API changes (to struct property_entry and
device_add_property_set()) which I would normally want to avoid.  There
are no in-tree users of these in 4.4, but CIP members might have
out-of-tree or backported drivers that use them.

> - GPIO API extension (converts gpiochip_add into a static inline wrapper
>   around gpiochip_add_data -> module ABI change)

CIP doesn't make any promises about module ABI stability, so that's not
a problem in itself.

> - the whole series of EFI capsule changes

As this is all new stuff, I think it's OK.  However you should remove
the "default y" for EFI_CAPSULE_QUIRK_QUARK_CSH (upstream too!).

You left out commit fb7a84cac035 "efi/capsule: Move 'capsule' to the
stack in efi_capsule_supported()".

> Besides looking at the concrete case of this queue, I was wondering if
> some general guidelines for back-porting changes from upstream could be
> derived from that.

A general guideline would be: avoid backward-incompatible API changes.
If you need to make any such changes then call attention to them when
sending patches for review.

Ben.

> Thanks in advance,
> Jan
> 
> PS: I can send the series, likely in chunks, in a couple of weeks, once
> I had a chance to test the stuff on real hw (out of reach right now).
> 

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
