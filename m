From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Tue, 10 Apr 2018 18:40:04 +0100
Subject: [cip-dev] [PATCH 0/4] Add MSIOF support to r8a7743
In-Reply-To: <1520530089-4988-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520530089-4988-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1523382004.2654.195.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

I've applied this series, thanks.

Ben.

On Thu, 2018-03-08 at 17:28 +0000, Fabrizio Castro wrote:
> Dear All,
> 
> this series backports all that is required to add MSIOF support
> to r8a7743.
> 
> Thanks,
> 
> Fabrizio Castro (3):
> ? spi: sh-msiof: Add compatible strings for r8a774[35]
> ? spi: sh-msiof: Add r8a774[35] to the compatible list
> ? ARM: dts: r8a7743: Add MSIOF[012] support
> 
> Simon Horman (1):
> ? spi: sh-msiof: Add R-Car Gen 2 and 3 fallback bindings
> 
> ?Documentation/devicetree/bindings/spi/sh-msiof.txt | 18 +++++---
> ?arch/arm/boot/dts/r8a7743.dtsi?????????????????????| 48 ++++++++++++++++++++++
> ?drivers/spi/spi-sh-msiof.c?????????????????????????|??5 ++-
> ?3 files changed, 65 insertions(+), 6 deletions(-)
> 
-- 
Ben Hutchings
Software Developer, Codethink Ltd.
