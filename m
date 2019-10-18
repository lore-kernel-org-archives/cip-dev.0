From: pavel@denx.de (Pavel Machek)
Date: Fri, 18 Oct 2019 18:49:33 +0200
Subject: [cip-dev] [PATCH 4.19.y-cip 3/6] dt-bindings: can: rcar_canfd:
 document r8a774a1 support
In-Reply-To: <1571295479-39328-4-git-send-email-biju.das@bp.renesas.com>
References: <1571295479-39328-1-git-send-email-biju.das@bp.renesas.com>
	<1571295479-39328-4-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191018164933.GA25992@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> @@ -29,10 +30,10 @@ enable/disable the respective channel.
>  
>  Required properties for "renesas,r8a774c0-canfd", "renesas,r8a7795-canfd" and
>  "renesas,r8a7796-canfd" compatible:
> -In R8A774C0, R8A7795 and R8A7796 SoCs, canfd clock is a div6 clock and can be
> -used by both CAN and CAN FD controller at the same time. It needs to be scaled
> -to maximum frequency if any of these controllers use it. This is done using the
> -below properties:
> +In R8A774A1, R8A774C0, R8A7795 and R8A7796 SoCs, canfd clock is a div6 clock
> +and can beused by both CAN and CAN FD controller at the same time. It needs

This should be "be used", but I'd propose fixing it in the mainline
and applying this series anyway.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191018/c576cc21/attachment.sig>
