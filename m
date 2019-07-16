From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 16 Jul 2019 12:01:15 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 15/23] clk: renesas: rcar-gen3:
 Support Z and Z2 clocks with high frequency parents
In-Reply-To: <20190716112230.GB24157@amd>
References: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
	<1563197408-59548-16-git-send-email-biju.das@bp.renesas.com>
	<20190716112230.GB24157@amd>
Message-ID: <OSBPR01MB21034DCBFCBEB273D8D3462FB8CE0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [cip-dev] [PATCH 4.19.y-cip 15/23] clk: renesas: rcar-gen3:
> Support Z and Z2 clocks with high frequency parents
> 
> Hi!
> 
> > Support Z and Z2 clocks with parent frequencies greater than
> > UINT32_MAX Hz (~4.29GHz).
> >
> > The DIV_ROUND_CLOSEST_ULL() macro accepts a 64bit dividend and 32bit
> > divisor. This leads to truncation of the divisor, which is the Z or Z2
> > parent clock frequency in HZ, on platforms where frequency of that
> > clock is greater than UINT32_MAX Hz.
> >
> > To resolve this problem the DIV64_U64_ROUND_CLOSEST() macro, which
> > takes on an unsigned 64bit dividend and divisor, is used.
> >
> > An earlier version of this patch made use of the existing
> > DIV_ROUND_CLOSEST() macro, which accepts the prevailing type of the
> > dividend and divisor. However, this does not compile on 32bit systems,
> > such as i386 and mips, when called with the types used at this call
> > site, an unsigned long long dividend and unsigned long divisor.
> 
> > This work is in preparation for supporting the Z2 clock on the R-Car
> > Gen3 E3 (r8a77990) SoC which has a 4.8GHz parent clock.
> 
> You still store "parent_rate" in "unsigned long". That is going to overflow on
> 32-bit systems, right?

Gen3 SoC's are aarch64. So I think it is ok.

Regards,
Biju
