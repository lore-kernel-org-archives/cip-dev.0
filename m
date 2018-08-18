From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Sat, 18 Aug 2018 03:07:04 +0100
Subject: [cip-dev] [PATCH 05/42] soc: renesas: Add R-Car RST driver
In-Reply-To: <1532626980-17190-6-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1532626980-17190-6-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1534558024.3135.18.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu, 2018-07-26 at 18:42 +0100, Fabrizio Castro wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Add a driver for the Renesas R-Car Gen1 RESET/WDT and R-Car Gen2/Gen3
> and RZ/G RST module.
> 
> For now this driver just provides an API to obtain the state of the mode
> pins, as latched at reset time.??As this is typically called from the
> probe function of a clock driver, which can run much earlier than any
> initcall, calling rcar_rst_read_mode_pins() just forces an early
> initialization of the driver.
> 
> Despite the current simple and almost identical handling for all
> supported SoCs, the driver matches against SoC-specific compatible
> values, as the features provided by the hardware module differ a lot
> across the various SoC families and members.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Dirk Behme <dirk.behme@de.bosch.com>
> (cherry picked from commit 527c02f66d263d2eeff237a2326c3278cfc03d3b)
> (Added renesas directory to driver/soc/Makefile. Modified
> drivers/soc/renesas/Makefile to only compile rcar-rst.c for R-Car
> Gen2. Removed R-Car Gen3 and R-Car Gen1 from rcar_rst_matches and
> stripped read mode pins logic from the driver. Got rid of
> rcar_rst_read_mode_pins, advertising rcar_rst_init instead)
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
[...]
> --- /dev/null
> +++ b/drivers/soc/renesas/rcar-rst.c
> @@ -0,0 +1,81 @@
> +/*
> + * R-Car Gen2 and RZ/G RST Driver
> + *
> + * Copyright (C) 2016 Glider bvba
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.??See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/of_address.h>
> +#include <linux/soc/renesas/rcar-rst.h>
> +
> +#define WDTRSTCR_RESET		0xA55A0002
> +#define WDTRSTCR		0x0054
> +
> +static int rcar_rst_enable_wdt_reset(void __iomem *base)
> +{
> +	iowrite32(WDTRSTCR_RESET, base + WDTRSTCR);
> +	return 0;
> +}
> +
> +struct rst_config {
> +	int (*configure)(void *base);	/* Platform specific configuration */
> +};
> +
> +static const struct rst_config rcar_rst_gen1 __initconst = {
> +	.configure = NULL,
> +};

This variable is unused here, so please delete it.

> +static const struct rst_config rcar_rst_gen2 __initconst = {
> +	.configure = rcar_rst_enable_wdt_reset,
> +};
[...]

The configure operation was added in commit
69e0d1b8db8f8cc319f966ec3eb2fffce28c4f28 upstream.  So I think it
should be added in a separate commit here, or at least both upstream
commits should be mentioned in the commit message for the backport.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
