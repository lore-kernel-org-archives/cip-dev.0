From: pavel@denx.de (Pavel Machek)
Date: Tue, 9 Apr 2019 22:55:54 +0200
Subject: [cip-dev] [PATCH 4.19.y 09/17] arm64: dts: renesas: r8a774c0:
 Add CMT device nodes
In-Reply-To: <1554112696-20706-10-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1554112696-20706-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1554112696-20706-10-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20190409205554.GD3845141@pollux.denx.de>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> From: Biju Das <biju.das@bp.renesas.com>
> 
> commit fa930bb65cf930c48efc01cc90f928a8db99fa94 upstream.
> 
> This patch adds CMT{0|1|2|3} device nodes for r8a774c0 SoC.

I could not apply this, as arch/arm64/boot/dts/renesas/r8a774c0.dtsi does
not exist in my tree.

Plus, you are pushing spdx comment changes. I guess it is ok if it makes your
life easier, but...

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
