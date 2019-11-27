From: pavel@denx.de (Pavel Machek)
Date: Wed, 27 Nov 2019 20:21:28 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 00/22] Add RZ/G1C SD/eMMC support
In-Reply-To: <1574862420-42606-1-git-send-email-biju.das@bp.renesas.com>
References: <1574862420-42606-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191127192127.GC12777@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> This patch series add SD/eMMC support support for RZ/G1C sbc.
> 
> RZ/G1C eMMC IP is different from other RZ/G1 SoC's. It is having an internal DMA for data transfer which is similar to R-Car Gen3.
> 
> Support for internal DMAC is added in 4.14 kernel and support for RZ/G1C added on 4.20 kernel.
> 
> Backported the relevent patches to linux-4.4.y-cip.

Ok, that was fun.

AFAICT, this clashed with "Add SDHI/eMMC/USB2.0 support" as I applied
them in unexpected order. So #9 and #17 rejected. I fixed up #9 by
hand, and simply dropped #17, as it is "just" documentation.

I believe I got it right, and tests seem to pass:

https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/99052811

...so I pushed the result. Could you verify that it looks how you
expected it, and resubmit patch #17 I dropped?

Thanks and best regards,
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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191127/baf3da52/attachment.sig>
