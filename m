Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C142C35FFA
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 10:25:50 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.4514.1742379945288762084
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 03:25:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=do9ap2OD;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7298A101E91D3;
	Wed, 19 Mar 2025 11:25:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742379943; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=qPvmGmS49xhg5GmwV/q2tUCeaifLZJ+XYKd4pwkg9vg=;
	b=do9ap2ODGwRmQVralvKUQbH8XnMyYf8gjjjTHT/8QFUzf5wYdypo3ymy1FLPAEcRMnCOeD
	4/9tgG4dqJ78LE+fO0INwnH1MGvyM0J1ccbbb7bcg1VQMS+LkCQQkJQWZZmWr/7y7U7tZW
	/tWk09R5B7kUxSjFb/JjXcxXn6pclnnskZa5BDzZoKYMjnV1+lNO7ufRyhq7gUIV+X47Hx
	oMrbWKF/T+AuHtvzvJ6kcD8y48X2cLWkvHSpyMe80Wjbx7NDlSUPaD8xz6dG/1LwZZqhur
	Eh97+wn+TDKq76Pl4iccqMLagSlf+9lDwH+EmCr4G8K0JIz8VETTbCUStdP6/w==
Date: Wed, 19 Mar 2025 11:25:38 +0100
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip v2 00/12] serial: sh-sci: Add support for
 RZ/G3E serial driver
Message-ID: <Z9qboost7EJenr+e@duo.ucw.cz>
References: <20250319101629.2407727-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FS5wpur/9EwVz/B0"
Content-Disposition: inline
In-Reply-To: <20250319101629.2407727-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 10:25:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18275


--FS5wpur/9EwVz/B0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series add support for RZ/G3E SCIF interface to linux-6.1.y-cip kern=
el.
> SCIF interface in Renesas RZ/G3E is similar to the one available in RZ/G2=
L.
> This series add also some fixes found during SoC bring up stage.
>=20
> All patches are cherry-picked from mainline kernel.

Okay, so I just reviewed v1 of this, and was ready to say that I'll
apply it provided there are no other comments and it passes testing.

Now you'll also have to tell me what is the difference between v1 and
v2 :-).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--FS5wpur/9EwVz/B0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9qbogAKCRAw5/Bqldv6
8rjvAKCTHnUKuS94k8mcVJoqYt8rARhs6ACgvmQE+Ye8aI0ohv3NBpYhxqSRSjc=
=3C8X
-----END PGP SIGNATURE-----

--FS5wpur/9EwVz/B0--

