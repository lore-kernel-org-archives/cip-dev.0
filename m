From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Tue, 10 Apr 2018 18:13:00 +0100
Subject: [cip-dev] [PATCH 00/15] Add UART support to r8a7743
In-Reply-To: <1520247731-25239-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520247731-25239-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1523380380.2654.187.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

I've applied this series, thanks.

Ben.

On Mon, 2018-03-05 at 11:01 +0000, Fabrizio Castro wrote:
> This series aims at adding UART support to r8a7743 by backporting
> the relevant patches from upstream.
> As per upstream, since two of the serial interfaces live on the
> camera daughter board, we rework the DT architecture to better
> accomodate all the possible HW variants.
> 
> Finally, in order to get CTS/RTS to work this series backports
> fixes made by Geert some time ago.
> 
> Thanks,
> Fabrizio
> 
> Biju Das (1):
> ? ARM: dts: iwg20d-q7: Add chosen node
> 
> Fabrizio Castro (3):
> ? ARM: dts: iwg20d-q7: Rework DT architecture
> ? ARM: dts: iwg20d-q7-dbcm-ca: Add device trees for camera DB
> ? ARM: dts: iwg20d-q7: Add support for ttySC3
> 
> Geert Uytterhoeven (11):
> ? serial: sh-sci: Update DT binding documentation for GPIO modem lines
> ? serial: sh-sci: Update DT binding documentation for dedicated RTS/CTS
> ? serial: sh-sci: Always set TIOCM_CTS in .get_mctrl() callback
> ? serial: sh-sci: Add support for GPIO-controlled modem lines
> ? serial: sh-sci: Do not open-code sci_getreg()
> ? serial: sh-sci: Add more Serial Port Register documentation
> ? serial: sh-sci: Add more Serial Port Control/Data Register
> ????documentation
> ? serial: sh-sci: Correct pin initialization on (H)SCIF
> ? serial: sh-sci: Add pin initialization for SCIFA/SCIFB
> ? serial: sh-sci: Fix support for hardware-assisted RTS/CTS
> ? serial: sh-sci: Add DT support for dedicated RTS/CTS
> 
> ?.../bindings/serial/renesas,sci-serial.txt?????????|???4 +
> ?arch/arm/boot/dts/Makefile?????????????????????????|???1 +
> ?arch/arm/boot/dts/iwg20d-q7-common.dtsi????????????| 127 +++++++++++++++
> ?arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi???????????|??43 +++++
> ?arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dts????|??19 +++
> ?arch/arm/boot/dts/r8a7743-iwg20d-q7.dts????????????| 100 +-----------
> ?drivers/tty/serial/Kconfig?????????????????????????|???1 +
> ?drivers/tty/serial/sh-sci.c????????????????????????| 177 ++++++++++++++++++---
> ?drivers/tty/serial/sh-sci.h????????????????????????|??24 ++-
> ?9 files changed, 365 insertions(+), 131 deletions(-)
> ?create mode 100644 arch/arm/boot/dts/iwg20d-q7-common.dtsi
> ?create mode 100644 arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi
> ?create mode 100644 arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dts
> 
-- 
Ben Hutchings
Software Developer, Codethink Ltd.
