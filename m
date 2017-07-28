From: hidehiro.kawai.ez@hitachi.com (=?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=)
Date: Fri, 28 Jul 2017 04:49:05 +0000
Subject: [cip-dev] Kernel feature support - architecture options and
 drivers
In-Reply-To: <1500643130.12197.123.camel@codethink.co.uk>
References: <1500643130.12197.123.camel@codethink.co.uk>
Message-ID: <04EAB7311EE43145B2D3536183D1A8445B96609D@GSjpTKYDCembx31.service.hitachi.net>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

I'm sorry for the late reply.

> From: Behalf Of Ben Hutchings

> nouveau (CONFIG_DRM_NOUVEAU) is enabled in the hitachi_omap config.  I'm
> not sure how this could be useful in an OMAP system, and I don't expect
> the driver to be supportable.  Please disable it.
 
> e100 (CONFIG_E100) and e1000 (CONFIG_E1000) drivers are enabled in
> several configs (hitachi_omap, plathome_obsvx1, siemens_server) but are
> not maintained upstream.  (Don't confuse e1000 with e1000e, which is for
> PCI Express and is still maintained.)  Please disable them.

These drivers are not used.  We'll simply disable them.

> USB-attached network drivers (CONFIG_USB_USBNET) are enabled in several
> configs (hitachi_omap, toshiba_tegra, plathome_obsvx1) but few of them
> seem to be properly maintained upstream.  Do you need them?

It is used as a convenient network interface for engineering.
If it is difficult to support them for super long term, we don't mind
too much even if CIP doesn't support them.

> KVM (CONFIG_VIRTUALIZATION) adds a large attack surface (guest-to-host)
> and is likely to be hard to maintain in the long term.  Several of the
> configurations (hitachi_omap, plathome_obsvx1, siemens_iot2000,
> siemens_server) enable this.  Do you need it?

It is not used at this point, but may be need in the future.

As long as we don't use KVM to build up a multi tenant VM service,
i.e. all users are the same legitimate user, the security risk of
guest-to-host attack will not become higher.  So with regard to the
security risk, it will not be a problem for some use cases.

> /dev/kmem (CONFIG_DEVKMEM) is only rarely needed for kernel debugging,
> but is enabled in many configs.  Please disable it.
> 
> /dev/mem (CONFIG_DEVMEM) is needed by some userland drivers, though UIO
> provides a cleaner way to do this.  Please check whether you can disable
> it.

I tried to grep executable files in /usr/{bin,sbin}, and I found multiple
commands which may access /dev/mem.  But I'm not sure how much impact
disabling /dev/mem has on us.  We also use /dev/mem for a user land
driver, but we will be able to reimplement it via UIO.


By the way, I think that `supporting a feature' is not the same as
`enabling a feature'.  Does `please disable it' mean that this is a
suggestion for a secure config, or imply that CIP shouldn't support
this feature?

Best regards,

Hidehiro Kawai
Hitachi, Ltd. Research & Development Group
