From: pavel@denx.de (Pavel Machek)
Date: Thu, 21 Nov 2019 09:02:12 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 0/6] Add CMT/RWDT support
In-Reply-To: <1574268440-33507-1-git-send-email-biju.das@bp.renesas.com>
References: <1574268440-33507-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191121080212.GB21324@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed 2019-11-20 16:47:14, Biju Das wrote:
> This patch series add CMT/RWDT support for RZ/G1C based iwg23s-sbc.
> 
> Backported the relevent patches to linux-4.4.y-cip.

Thanks, applied with v2 of the first patch.

Best regards,
								Pavel

> Biju Das (6):
>   dt-bindings: watchdog: renesas-wdt: Document r8a77470 support
>   ARM: dts: r8a77470: Add watchdog support to SoC dtsi
>   ARM: dts: iwg23s-sbc: Enable watchdog support
>   dt-bindings: timer: renesas, cmt: Document r8a77470 CMT support
>   ARM: dts: r8a77470: Add CMT SoC specific support
>   ARM: dts: iwg23s-sbc: Enable cmt0

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191121/9cc96492/attachment.sig>
