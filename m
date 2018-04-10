From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Tue, 10 Apr 2018 19:04:38 +0100
Subject: [cip-dev] [PATCH 0/4] Add XHCI support to r8a7743
In-Reply-To: <1520589424-15807-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520589424-15807-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1523383478.2654.197.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Fri, 2018-03-09 at 09:57 +0000, Fabrizio Castro wrote:
> Dear All,
> 
> this series adds XHCI support to r8a7743.
> The only patch that hasn't been backported is:
> "usb: host: xhci-plat: Add r8a7743 support"
> 
> The reason for the new commit is that the backporting of the generic
> compatible string for R-Car Gen2 would have brought along a few
> unnecessary bits and pieces, a new commit seemed to address the goal
> more reliably.

That seems reasonable.  I've applied this series, thanks.

Ben.

> Thanks,
> 
> Fabrizio Castro (3):
> ? usb: host: xhci-plat: Add r8a7743 support
> ? dt-bindings: usb-xhci: Document r8a7743 support
> ? ARM: dts: r8a7743: Add xhci support to SoC dtsi
> 
> Simon Horman (1):
> ? ARM: shmobile: enable XHCI_RCAR in defconfig
> 
> ?Documentation/devicetree/bindings/usb/usb-xhci.txt |??4 ++--
> ?arch/arm/boot/dts/r8a7743.dtsi?????????????????????| 18 ++++++++++++++++++
> ?arch/arm/configs/shmobile_defconfig????????????????|??2 ++
> ?drivers/usb/host/xhci-plat.c???????????????????????|??7 +++++--
> ?4 files changed, 27 insertions(+), 4 deletions(-)
> 
-- 
Ben Hutchings
Software Developer, Codethink Ltd.
