From: pavel@denx.de (Pavel Machek)
Date: Fri, 8 Nov 2019 10:44:34 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 63/83] mmc: tmio: always get number
	of taps
In-Reply-To: <1573115572-13513-64-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<1573115572-13513-64-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191108094434.GL1017@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> commit 43b0b361b0170030603cf76f70b099f3323edcf3 upstream.
> 
> Current code gets number of taps only once and keeps the value. This is
> not correct, we need to obtain it every time before executing tuning,
> so remove the outer if-block.

I'd somehow assume number of tuning parameters would be fixed... Does
the hardware really change it? Out of curiosity, why is it doing so?

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191108/79f69835/attachment.sig>
