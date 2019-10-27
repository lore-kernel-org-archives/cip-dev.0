From: pavel@denx.de (Pavel Machek)
Date: Sun, 27 Oct 2019 08:45:38 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 48/57] ASoC: rsnd: src: Avoid a
 potential deadlock
In-Reply-To: <1571295929-47286-49-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
	<1571295929-47286-49-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191027074538.GB28383@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org


On Thu 2019-10-17 08:05:20, Biju Das wrote:
> From: Jiada Wang <jiada_wang@mentor.com>
> 
> commit ba164a49f8f7390b036713bf8a70a150a938c670 upstream.
> 
> lockdep warns us that priv->lock and k->k_lock can cause a
> deadlock when after acquire of k->k_lock, process is interrupted
> by src, while in another routine of src .init, k->k_lock is
> acquired with priv->lock held.
> 
> This patch avoids a potential deadlock by not calling soc_device_match()
> in SRC .init callback, instead it adds new soc fields in priv->flags to
> differentiate SoCs.

Could this be moved near the patch it fixes? Or even merged to it?
Introducing deadlocks is bad for bisection at the very least...

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191027/34db6ccb/attachment.sig>
