From: pavel@denx.de (Pavel Machek)
Date: Fri, 8 Nov 2019 10:15:28 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 15/83] mmc: tmio: stop clock when
 0Hz is requested
In-Reply-To: <1573115572-13513-16-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<1573115572-13513-16-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191108091528.GB1017@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> commit 148634d24d4a7dc82a49efcf1a215e1d0695f62c upstream.
> 
> Setting frequency to 0 is not enough, the clock explicitly has to be
> disabled. Otherwise voltage switching (which needs SDCLK to be quiet)
> fails for various cards.
> 
> Because we now do the 'new_clock == 0' check right at the beginning,
> the indentation level of the rest of the code can be decreased a
> little.

>  {
>  	u32 clk = 0, clock;
>

clk = 0 initialization is never used.

> +	for (clk = 0x80000080; new_clock >= (clock << 1); clk >>= 1)
> +		clock <<= 1;

This is black magic. Where does 0x80000080 come from? Would it be
possible to get some comment/explanation?

> +	/* 1/1 clock is option */
> +	if ((host->pdata->flags & TMIO_MMC_CLK_ACTUAL) && ((clk >> 22) & 0x1))
> +		clk |= 0xff;
>  
>  	if (host->set_clk_div)
>  		host->set_clk_div(host->pdev, (clk >> 22) & 1);

What does bit 22 in clk mean? Should it go to temporary variable with
explanation? (Also it is & 1 in one operation and & 0x1 in other
operation).

It seems that low bits of clk variable are used as an actual clock
divider, with high bit doing something else. That is quite
confusing...

Best regards,
								Pavel

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191108/ca8b7e64/attachment.sig>
