From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Mon, 12 Mar 2018 16:26:16 +0000
Subject: [cip-dev] [PATCH 09/15] serial: sh-sci: Add pin initialization
 for SCIFA/SCIFB
In-Reply-To: <1520247731-25239-10-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520247731-25239-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1520247731-25239-10-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520871976.23626.79.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Mon, 2018-03-05 at 11:02 +0000, Fabrizio Castro wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Before, the driver relied on initialization by the boot loader, or by
> implicit reset state.
> 
> Note that unlike on (H)SCIF, the RTS/CTS bits exist only if dedicated
> RTS/CTS pins are available, which depends on the SoC and UART instance.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> (cherry picked from commit e9d7a45a039913497a57887d85f5decfda4679f0)
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
[...]

Shouldn't we also take:

5f76895e4c71 serial: sh-sci: Fix late enablement of AUTORTS
cfa6eb239154 serial: sh-sci: Fix (AUTO)RTS in sci_init_pins()

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
