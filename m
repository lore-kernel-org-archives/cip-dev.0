From: pavel@denx.de (Pavel Machek)
Date: Thu, 10 Oct 2019 09:43:12 +0200
Subject: [cip-dev] [PATCH 4.19.y-cip 0/3] Add WLAN/BT support
In-Reply-To: <1570689915-14149-1-git-send-email-biju.das@bp.renesas.com>
References: <1570689915-14149-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191010074312.GB23033@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> This patch series add WLAN/BT support for HiHope RZ/G2M platform.
> 
> This patch series is based on linux-4.19.y-cip and all the patches
> in this series are cherry-picked from linux rc tree.
> 
> Biju Das (3):
>   arm64: dts: renesas: hihope-common: Add PCA9654 I/O expander
>   arm64: dts: renesas: hihope-common: Add BT support
>   arm64: dts: renesas: hihope-common: Add WLAN support

Thank you, series looks good. (Comment about label probably should be
resolved in the mainline, first).

I can apply it unless Iwamatsu wants to do that?

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191010/a39c8273/attachment.sig>
