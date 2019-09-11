From: pavel@denx.de (Pavel Machek)
Date: Wed, 11 Sep 2019 09:54:27 +0200
Subject: [cip-dev] [PATCH 4.19.y-cip 0/4] Add USB support
In-Reply-To: <1568019126-45985-1-git-send-email-biju.das@bp.renesas.com>
References: <1568019126-45985-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20190911075427.GA9517@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> This patch series add USB2.0/USB3.0 support for Hihope RZ/G2M platform.
> 
> This patch series is based on linux-4.19.y-cip and all the patches
> in this series are cherry-picked from linux rc tree.
> 
> Biju Das (3):
>   arm64: dts: renesas: r8a774a1: Fix USB 2.0 clocks
>   arm64: dts: renesas: hihope-common: Add USB 2.0 support
>   arm64: dts: renesas: hihope-common: Enable USB3.0
> 
> Yoshihiro Shimoda (1):
>   phy: renesas: rcar-gen3-usb2: fix imbalance powered flag

Nothing obviously wrong here. Let me apply the series...

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190911/be18f014/attachment.sig>
