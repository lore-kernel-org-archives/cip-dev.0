From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 16 Jul 2019 11:56:44 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 21/23] clk: renesas: rcar-gen3: Fix
 cpg_sd_clock_round_rate() return value
In-Reply-To: <20190716112453.GC24157@amd>
References: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
	<1563197408-59548-22-git-send-email-biju.das@bp.renesas.com>
	<20190716112453.GC24157@amd>
Message-ID: <OSBPR01MB2103F5277237480DEAE453D7B8CE0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [cip-dev] [PATCH 4.19.y-cip 21/23] clk: renesas: rcar-gen3: Fix
> cpg_sd_clock_round_rate() return value
> 
> Hi!
> 
> > This is not conform the clk API design.
> >
> > This patch fixes that by making sure cpg_sd_clock_calc_div() considers
> > only the division values defined in cpg_sd_div_table[].
> > With this fix, the cpg_sd_clock_round_rate() always return a support
> > clock rate.
> 
> This is not quite correct english, but I guess it is too late to fix that.

Yes, I agree with you. It is too late to fix it.

Regards,
Biju
