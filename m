From: pavel@denx.de (Pavel Machek)
Date: Fri, 12 Apr 2019 10:11:26 +0200
Subject: [cip-dev] [PATCH 4.19.y 01/17] clocksource/drivers/sh_cmt:
 Convert to SPDX identifiers
In-Reply-To: <1554112696-20706-2-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1554112696-20706-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1554112696-20706-2-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20190412081126.GB14607@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Mon 2019-04-01 10:58:00, Fabrizio Castro wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> commit efad01173717b0d0ad8a7dc91cc447f19d8447f3 upstream.
> 
> This patch updates license to use SPDX-License-Identifier instead of verbose
> license text.

Thanks, I applied the series.

Strictly speaking patches 1, 4, 16 only alter whitespace, so they
would not be welcome under -stable rules. OTOH they clearly do not
break anything, and ammount of surrounding changes means taking them
is easier than not taking them... so I took them.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190412/247b3868/attachment.sig>
