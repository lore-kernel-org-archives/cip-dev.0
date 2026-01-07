Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F67CFD633
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 13:42:35 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6033.1767793346970818314
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 05:42:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=GVGISSrm;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0A3DD10D42B;
	Wed,  7 Jan 2026 14:42:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767793344;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=z7ALeVKfmywgNO47TZGz2gZDhzLuNUV82iNd3ubr6oA=;
	b=GVGISSrmmlkGiSm8Yr2Rur6nzSM/F4HblT7nQUbH9ODBO/xYpsMy9q3iQB1aLEK9ULdSm0
	j74SVstzCjalgSYMmcC4vhx6a+NpNdFTv4T4mi3qY635L935rw0OGnlnFjagJOtB0Le11M
	bqdanjx6X2VomViJCqq6cFpnZ8iMnAuJP0IUoMjbDKU1TkvbglIlWklx6rTwM6UtsbpJT4
	thgX3a4yD1fKM7s7XOs/Pc6F0u2n36lmp51LKUqurJzxN/6mi/GKCzU00DfFDhJwZBRvYO
	Jxz1BxF40fFnT7rZwyPWnKFTJxyXQpPEGSoTo1uiH/PMax+S3LZaMU/F73Rfdg==
Date: Wed, 7 Jan 2026 14:42:20 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip v2 0/6] Add gpio keys/sleep button support for
 RZ/G3E
Message-ID: <aV5ivN7FZvCS/Ps7@duo.ucw.cz>
References: <20260106104151.88020-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ScH7Xgidtn8fcIsP"
Content-Disposition: inline
In-Reply-To: <20260106104151.88020-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 13:42:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21411


--ScH7Xgidtn8fcIsP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Add gpio keys support for waking up from s2idle and sleep button support
> for entering to STR. Wakeup of STR is by pressing and holding power
> button. All the patches in this series are cherry-picked from mainline.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--ScH7Xgidtn8fcIsP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaV5ivAAKCRAw5/Bqldv6
8rZRAJ4lSWAyhDz6MfyXWtqwQQ8dUa5w7wCfU2edRPYC2JcPrUy9nCWpNqfLmAg=
=tpkg
-----END PGP SIGNATURE-----

--ScH7Xgidtn8fcIsP--

