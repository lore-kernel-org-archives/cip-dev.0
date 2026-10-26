Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2182.1793034498340589955
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Oct 2026 10:08:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=ZBGNevWA;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A5E511074BC;
	Mon, 26 Oct 2026 18:08:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793034492;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=YOFkyrPg8Rb5vU6OgCu8JxHgFDPlTjI1u1v19/vpY+s=;
	b=ZBGNevWAywpxJbAwTcEcLSnJYB+GBnRUi2+Ipug1KEFZDYnI7tokJisTh/z0AtF9AchXoN
	rrW+Ktd2L8CwrgelEiqUF3KC6iwADJRQ7nLb5xrUUYLDtkwjtohpXJlngtIjtPt9dx5VYj
	WRKUdqjsOvbntRspR4ydUf46wfnRG4SBwF5xMyof2/ObH0ZUyGvxOL11xcqFAipHTxhbQq
	vbg0l8yBMmGfZ4hiAu1CY44DQwJ1Oork2xOv9gkNW66lOPDxtvJA4Jjylwu9Q/Y4x3npzO
	GYP0vRm9rwHX5acBFZSFvQwR/9ewoeXyRF9Clg0wq2lcI9q1XPSxlPjW9kEeEQ==
Date: Mon, 26 Oct 2026 18:08:11 +0100
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com, uli@fpond.eu,
	tommaso.merciai.xr@bp.renesas.com, claudiu.beznea.uj@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/2] Fix CVEs related to patches
 backported to the CIP kernel
Message-ID: <at-I-z8mlwo1vrGt@duo.ucw.cz>
References: <1792979286-32200-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ffe72L7cxl4k5s5M"
Content-Disposition: inline
In-Reply-To: <1792979286-32200-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 17:08:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24550


--Ffe72L7cxl4k5s5M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is a patch series that fixes CVEs related to patches backported to
> CIP kernel.
> The following CVEs and commits are addressed in this:

I had some minor comments here, but those should be fixed in mainline,
first, so they should not block the merge.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--Ffe72L7cxl4k5s5M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCat+I+wAKCRAw5/Bqldv6
8pQhAJ9ytno7+0k6NXzleE7XisThBp84RACbBtNH61Xjx4rCqUUCBx2ekckbiFU=
=nnRo
-----END PGP SIGNATURE-----

--Ffe72L7cxl4k5s5M--
