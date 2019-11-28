From: pavel@denx.de (Pavel Machek)
Date: Thu, 28 Nov 2019 12:19:27 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip] dt-bindings: mmc: renesas_sdhi: Add
 r8a77470 support
In-Reply-To: <1574928934-18465-1-git-send-email-biju.das@bp.renesas.com>
References: <1574928934-18465-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191128111927.GA5634@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> 
> commit be6f8db406a49511a8d213f9443ae79fe5b086c3 upstream.
> 
> The RZ/G1C (a.k.a. R8A77470) comes with three SDHI interfaces,
> SDHI0 and SDHI2 are compatible with R-Car Gen2 SDHIs, and
> SDHI1 is compatible with R-Car Gen3 SDHIs, as it comes with an
> internal DMAC, therefore SDHI1 is fully compatible with driver
> renesas_sdhi_internal_dmac driver. As a result, the compatible
> strings for the R8A77470 SDHI interfaces are a little bit special.
> Document SDHI support for the RZ/G1C SoC.

Applied, thank you.

gitlab is down, but patches should be on kernel.org.

AFAIU this was last outstanding patch from you, and there's nothing
more to apply for me, right?

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191128/b6d2a7ff/attachment.sig>
