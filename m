From: pavel@denx.de (Pavel Machek)
Date: Mon, 13 May 2019 21:03:35 +0200
Subject: [cip-dev] [PATCH 4.4.y 02/52] clk: shmobile: rcar-gen2: Add
 quirks for the RZ/G1C
In-Reply-To: <1557761837-24993-3-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1557761837-24993-3-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20190513190335.GC27497@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Mon 2019-05-13 16:36:27, Fabrizio Castro wrote:
> This patch adds a quirk for clocks "sd0" and "sd1" for the
> RZ/G1C (a.k.a. r8a77470) SoC, similarly to what has been done
> upstream with commit:
> 5bf2fbbef50c ("clk: renesas: cpg-mssr: Add r8a77470 support")
> 
> and also customizes the settings for the PLLs.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>  drivers/clk/shmobile/clk-rcar-gen2.c | 39 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
> 
> +#define CPG_PLL_CONFIG_INDEX_RZG1C(md)	((((md) & BIT(14)) >> 13) | \
> +					 (((md) & BIT(13)) >> 13))
> +
>  struct cpg_pll_config {
>  	unsigned int extal_div;
>  	unsigned int pll1_mult;
> @@ -282,6 +300,14 @@ static const struct cpg_pll_config cpg_pll_configs[8] __initconst = {
>  	{ 2, 208, 106, 200 }, { 2, 208,  88, 200 },
>  };
>  
> +static const struct cpg_pll_config cpg_pll_configs_rzg1c[4] __initconst = {
> +	/* EXTAL div	PLL1 mult x2	PLL3 mult */
> +	{ 1,		156,		50,	},
> +	{ 1,		120,		56,	},
> +	{ /* Invalid*/				},
> +	{ 1,		104,		50,	},

Coding style says "/* Invalid */". And just initializing with zeros
using {} is valid C, but was somehow surprising to me.

[No need to do anything. I'll probably just apply the patch for cip-4.4].

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190513/ee828ae1/attachment.sig>
