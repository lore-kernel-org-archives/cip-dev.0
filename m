From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Tue, 10 Apr 2018 18:53:42 +0100
Subject: [cip-dev] [PATCH 0/3] Add SPI flash support to r8a7743
In-Reply-To: <1520531679-9452-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520531679-9452-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1523382822.2654.196.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

I've applied this series, thanks.

Ben.

On Thu, 2018-03-08 at 17:54 +0000, Fabrizio Castro wrote:
> Dear All,
> 
> this patch backports all that is required to add SPI flash
> support to the r8a7743.
> 
> Thanks,
> 
> Fabrizio Castro (3):
> ? spi: rspi: Add r8a7743/5 to the compatible list
> ? ARM: dts: r8a7743: Add QSPI support
> ? ARM: dts: iwg20m: Add SPI NOR support
> 
> ?Documentation/devicetree/bindings/spi/spi-rspi.txt |??5 ++++-
> ?arch/arm/boot/dts/r8a7743-iwg20m.dtsi??????????????| 26 ++++++++++++++++++++++
> ?arch/arm/boot/dts/r8a7743.dtsi?????????????????????| 16 +++++++++++++
> ?3 files changed, 46 insertions(+), 1 deletion(-)
> 
-- 
Ben Hutchings
Software Developer, Codethink Ltd.
