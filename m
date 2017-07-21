From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Fri, 21 Jul 2017 17:19:15 +0200
Subject: [cip-dev] Kernel feature support - architecture options and
 drivers
In-Reply-To: <1500643130.12197.123.camel@codethink.co.uk>
References: <1500643130.12197.123.camel@codethink.co.uk>
Message-ID: <2b838876-3237-ab6f-4377-0bbbdc7c6e65@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 2017-07-21 15:18, Ben Hutchings wrote:
> Intel Quark support (CONFIG_X86_INTEL_QUARK) is enabled in the
> siemens_iot2000 config.  Are you really using Quark SoCs?

Yeah...
http://w3.siemens.com/mcms/pc-based-automation/en/industrial-iot/pages/default.aspx.
This revision will stop being shipped at latest in 2020, but there will
be a lot of these chips in the field until then.

Likely all needed patches will be in 4.13 (just still struggling to get
userspace software ported from the Intel BSP to mainline). So I'm
planning to submit the essential patches for CIP integration "soon".

> uhci-hcd (CONFIG_USB_UHCI_HCD) is for obsolete hardware (so far as I
> know) but is enabled in the plathome_obsvx1, siemens_server and toshiba
> x86 configs.  Please disable it.

You need it for old USB 2.0 chipsets that have separate USB 1.1 and 2.0
interfaces. Those would then no longer word with 1.1 devices. But I bet
none of the provided products contain that.

> KVM (CONFIG_VIRTUALIZATION) adds a large attack surface (guest-to-host)
> and is likely to be hard to maintain in the long term.  Several of the
> configurations (hitachi_omap, plathome_obsvx1, siemens_iot2000,
> siemens_server) enable this.  Do you need it?

Not on the IOT2000 (f...ine Yocto rules made that pop up, I still need
to convert to a plain defconfig), not for production purposes on our
server, but we do have products (not listed so far) with KVM.

With - buzzword alarm - "edge computing", it is getting more and more
important as isolation tool for "apps". Containers/namespaces are
sometimes not strong enough.

I can contribute to reviewing patches when needed or talk to the current
maintainers to have a look as well. At least on x86, it is mature by
now. ARM seems to be catching up quickly.

> /dev/mem (CONFIG_DEVMEM) is needed by some userland drivers, though UIO
> provides a cleaner way to do this.  Please check whether you can disable
> it.

I just explained this these days to someone who wanted to build an API
around it. In current embedded, it can be tricky, but I'm with you and
will promote its removal further.

> 
> Chrome platform support (CONFIG_CHROME_PLATFORMS) is enabled in the
> siemens_server config.  Assuming you don't need to support these
> platforms, please disable it.

Ack.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
