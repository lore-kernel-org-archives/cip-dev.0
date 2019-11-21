From: pavel@denx.de (Pavel Machek)
Date: Thu, 21 Nov 2019 09:33:55 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 00/31] Add RZ/G1C SD/eMMC support
In-Reply-To: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
References: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191121083355.GD21324@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> This patch series add SD/eMMC support support for RZ/G1C sbc.
> 
> RZ/G1C eMMC IP is different from other RZ/G1 SoC's. It is having an 
> internal DMA for data transfer which is similar to R-Car Gen3.
> 
> Support for internal DMAC is added in 4.14 kernel and support for 
> RZ/G1C added on 4.20 kernel.
> 
> Backported the relevent patches to linux-4.4.y-cip.
> 
> This patch series is based on linux-4.4.y-cip and all the patches
> in this series are cherry-picked from linux rc tree.

Thanks, applied and pushed out.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191121/f427e7e5/attachment.sig>
