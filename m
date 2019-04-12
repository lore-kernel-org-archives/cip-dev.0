From: pavel@denx.de (Pavel Machek)
Date: Fri, 12 Apr 2019 09:54:46 +0200
Subject: [cip-dev] [PATCH 4.19.y 1/9] i2c: sh_mobile: document support
 for r8a77990 (R-Car E3)
In-Reply-To: <1553688789-43441-2-git-send-email-biju.das@bp.renesas.com>
References: <1553688789-43441-1-git-send-email-biju.das@bp.renesas.com>
	<1553688789-43441-2-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20190412075446.GA13324@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed 2019-03-27 12:13:01, Biju Das wrote:
> From: Simon Horman <horms+renesas@verge.net.au>
> 
> Document support for the IIC code for the r8a77990 (R-Car E3).
> 
> It is not considered compatible with existing fallback bindings
> due to the documented absence of automatic transmission registers.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> (cherry picked from commit fca34b910ddc556c51294d58287f7c33863dddef)
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>

Thanks, I applied the series.
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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190412/7f63e93c/attachment.sig>
