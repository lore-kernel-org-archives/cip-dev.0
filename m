From: pavel@denx.de (Pavel Machek)
Date: Tue, 16 Jul 2019 13:24:53 +0200
Subject: [cip-dev] [PATCH 4.19.y-cip 21/23] clk: renesas: rcar-gen3: Fix
 cpg_sd_clock_round_rate() return value
In-Reply-To: <1563197408-59548-22-git-send-email-biju.das@bp.renesas.com>
References: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
	<1563197408-59548-22-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20190716112453.GC24157@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> This is not conform the clk API design.
> 
> This patch fixes that by making sure cpg_sd_clock_calc_div() considers
> only the division values defined in cpg_sd_div_table[].
> With this fix, the cpg_sd_clock_round_rate() always return a support
> clock rate.

This is not quite correct english, but I guess it is too late to fix
that.

Best regards,
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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190716/bf232362/attachment.sig>
