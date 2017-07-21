From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 21 Jul 2017 18:11:11 +0100
Subject: [cip-dev] Kernel feature support - architecture options and
 drivers
In-Reply-To: <2b838876-3237-ab6f-4377-0bbbdc7c6e65@siemens.com>
References: <1500643130.12197.123.camel@codethink.co.uk>
	<2b838876-3237-ab6f-4377-0bbbdc7c6e65@siemens.com>
Message-ID: <1500657071.12197.183.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Fri, 2017-07-21 at 17:19 +0200, Jan Kiszka wrote:
> On 2017-07-21 15:18, Ben Hutchings wrote:
> > Intel Quark support (CONFIG_X86_INTEL_QUARK) is enabled in the
> > siemens_iot2000 config.  Are you really using Quark SoCs?
> 
> Yeah...
> http://w3.siemens.com/mcms/pc-based-automation/en/industrial-iot/pages/default.aspx.
> This revision will stop being shipped at latest in 2020, but there will
> be a lot of these chips in the field until then.
>
> Likely all needed patches will be in 4.13 (just still struggling to get
> userspace software ported from the Intel BSP to mainline). So I'm
> planning to submit the essential patches for CIP integration "soon".

I assume you're aware of erratum #24 affecting the LOCK prefix?  There
seems to be no solution except to use Intel's forked version of binutils
which deletes the LOCK prefix.  I don't know if it's an issue for kernel
code, but probably not - the kernel shouldn't use LOCK if CONFIG_SMP is
not enabled, and in any case shouldn't get a page fault on such an
instruction..

> > uhci-hcd (CONFIG_USB_UHCI_HCD) is for obsolete hardware (so far as I
> > know) but is enabled in the plathome_obsvx1, siemens_server and toshiba
> > x86 configs.  Please disable it.
> 
> You need it for old USB 2.0 chipsets that have separate USB 1.1 and 2.0
> interfaces. Those would then no longer word with 1.1 devices. But I bet
> none of the provided products contain that.

I know there were some UHCI/EHCI pairings but I haven't seen a UHCI in a
long time.

> > KVM (CONFIG_VIRTUALIZATION) adds a large attack surface (guest-to-host)
> > and is likely to be hard to maintain in the long term.  Several of the
> > configurations (hitachi_omap, plathome_obsvx1, siemens_iot2000,
> > siemens_server) enable this.  Do you need it?
> 
> Not on the IOT2000 (f...ine Yocto rules made that pop up, I still need
> to convert to a plain defconfig), not for production purposes on our
> server, but we do have products (not listed so far) with KVM.
> 
> With - buzzword alarm - "edge computing", it is getting more and more
> important as isolation tool for "apps". Containers/namespaces are
> sometimes not strong enough.
[...]

I understand that - just trying to check that is actually being used.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
