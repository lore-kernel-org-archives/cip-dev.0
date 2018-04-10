From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Tue, 10 Apr 2018 18:16:14 +0100
Subject: [cip-dev] [PATCH 0/7] Add HSUSB to r8a7743
In-Reply-To: <1520336087-12870-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520336087-12870-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1523380574.2654.190.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

I've applied this series, thanks.  I added back the compatible strings
that you left out of the last patch, since I didn't see any need to
diverge from upstream there.

Ben.

On Tue, 2018-03-06 at 11:34 +0000, Fabrizio Castro wrote:
> Dear All,
> 
> this series backports all the patches necessary to add HSUSB support
> to the r8a7743.
> 
> Thanks,
> Fabrizio
> 
> Biju Das (5):
> ? usb: renesas_usbhs: Add compatible string for r8a7743/5
> ? ARM: dts: r8a7743: Add HS-USB device node
> ? ARM: dts: iwg20d-q7: Enable HS-USB
> ? ARM: dts: r8a7743: Add USB-DMAC device nodes
> ? ARM: dts: r8a7743: Enable DMA for HSUSB
> 
> Simon Horman (2):
> ? usb: renesas_usbhs: add SoC names to compatibility string
> ????documentation
> ? usb: renesas_usbhs: add fallback compatibility strings
> 
> ?.../devicetree/bindings/usb/renesas_usbhs.txt??????| 22 ++++++++----
> ?arch/arm/boot/dts/iwg20d-q7-common.dtsi????????????|??7 +++-
> ?arch/arm/boot/dts/r8a7743.dtsi?????????????????????| 40 ++++++++++++++++++++++
> ?drivers/usb/renesas_usbhs/common.c?????????????????|??9 +++++
> ?4 files changed, 71 insertions(+), 7 deletions(-)
> 
-- 
Ben Hutchings
Software Developer, Codethink Ltd.
