From: pavel@denx.de (Pavel Machek)
Date: Thu, 6 Feb 2020 23:50:17 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 00/35] Renesas RZ/G2 extend
	peripheral support
In-Reply-To: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <20200206225017.GA24014@duo.ucw.cz>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> This patch series adds supports for following peripherals supported by RZ/G2N
> a] CAN and CANFD
> b] IPMMU/FCPF/FCPV/VSP
> c] USB
> d] DU/LVDS/HDMI/FDP1/PWM
> 
> This patch series is based on top of series [1] all the patches 
> in this series are cherry-picked from upstream.
> 
> [1] https://patchwork.kernel.org/project/cip-dev/list/?series=235707&submitter=&state=*&q=&archive=both&delegate=
>

Series looks okay to me (I'll have some minor comments later). Tests
seem to pass:

https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/115667302

I'll push the series if there are no objections.

Best regards,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20200206/19fc0074/attachment.sig>
