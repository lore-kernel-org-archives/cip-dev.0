From: pavel@denx.de (Pavel Machek)
Date: Tue, 9 Apr 2019 21:49:02 +0200
Subject: [cip-dev] [PATCH 15/18] soc: renesas: r8a774c0-sysc: Fix
 initialization order of 3DG-{A, B}
In-Reply-To: <1553178256-6293-16-git-send-email-biju.das@bp.renesas.com>
References: <1553178256-6293-1-git-send-email-biju.das@bp.renesas.com>
	<1553178256-6293-16-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20190409194902.GB3784888@pollux.denx.de>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu 2019-03-21 14:24:13, Biju Das wrote:
> The workaround for the wrong hierarchy of the 3DG-{A,B} power domains on
> RZ/G2E ES1.0 corrected the parent domains. However, the 3DG-{A,B} power
> domains were still initialized and powered in the wrong order, causing
> 3DG operation to fail.
> 
> Fix this by changing the order in the table at runtime, when running on
> an affected SoC.
> 
> This work is based on the work done by Geert for R-Car E3.
> 
> Fixes: f37d211c687588328 ("soc: renesas: rcar-sysc: Add r8a774c0 support")

I prefer directly including good commit (rather than including bad commit and
then fixing it up). Let me try to fix it up.

Anyway, I merged this and the rest of the series.

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
