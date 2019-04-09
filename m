From: pavel@denx.de (Pavel Machek)
Date: Tue, 9 Apr 2019 22:56:39 +0200
Subject: [cip-dev] [PATCH 01/11] pinctrl: sh-pfc: r8a77990: Add Audio
 clock pins, groups and functions
In-Reply-To: <1553247610-33056-2-git-send-email-biju.das@bp.renesas.com>
References: <1553247610-33056-1-git-send-email-biju.das@bp.renesas.com>
	<1553247610-33056-2-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20190409205639.GE3845141@pollux.denx.de>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Fri 2019-03-22 09:40:00, Biju Das wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> This patch adds AUDIO_CLK{A,B,C}, AUDIO_CLKOUT, AUDIO_CLKOUT{1,2,3}
> pins, groups and functions to the R8A77990 SoC.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> [simon: rebase]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> (cherry picked from commit 4c833b2fa5b6b121cc657e5f24b8c3585a8c37ea)
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>

I could not apply this on c312fd1d432e36f9012127fe3c1d2b7023afae48-based tree.

I have         struct sh_pfc_pin_group common[117];
while the patch expects struct sh_pfc_pin_group common[123];

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
