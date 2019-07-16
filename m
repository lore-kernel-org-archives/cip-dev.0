From: pavel@denx.de (Pavel Machek)
Date: Tue, 16 Jul 2019 13:22:30 +0200
Subject: [cip-dev] [PATCH 4.19.y-cip 15/23] clk: renesas: rcar-gen3:
 Support Z and Z2 clocks with high frequency parents
In-Reply-To: <1563197408-59548-16-git-send-email-biju.das@bp.renesas.com>
References: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
	<1563197408-59548-16-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20190716112230.GB24157@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> Support Z and Z2 clocks with parent frequencies greater than UINT32_MAX Hz
> (~4.29GHz).
> 
> The DIV_ROUND_CLOSEST_ULL() macro accepts a 64bit dividend and 32bit
> divisor. This leads to truncation of the divisor, which is the Z or Z2
> parent clock frequency in HZ, on platforms where frequency of that clock is
> greater than UINT32_MAX Hz.
> 
> To resolve this problem the DIV64_U64_ROUND_CLOSEST() macro, which takes
> on an unsigned 64bit dividend and divisor, is used.
> 
> An earlier version of this patch made use of the existing
> DIV_ROUND_CLOSEST() macro, which accepts the prevailing type of the
> dividend and divisor. However, this does not compile on 32bit systems, such
> as i386 and mips, when called with the types used at this call site, an
> unsigned long long dividend and unsigned long divisor.

> This work is in preparation for supporting the Z2 clock on the
> R-Car Gen3 E3 (r8a77990) SoC which has a 4.8GHz parent clock.

You still store "parent_rate" in "unsigned long". That is going to
overflow on 32-bit systems, right?

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190716/6e2e8f98/attachment.sig>
