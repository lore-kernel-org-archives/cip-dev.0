Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB94DC36008
	for <webhook@archiver.kernel.org>; Wed, 26 Mar 2025 12:00:18 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.20338.1742990416580833427
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Mar 2025 05:00:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=CaOnPvjV;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B241110246DA1;
	Wed, 26 Mar 2025 13:00:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742990414; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=QAbPbZvfYL7n+a1xwcpkNNdN7I5im2draC+uwVbQ6Io=;
	b=CaOnPvjVE6iOgFGg+68gRqPdshOqSMP60hrLDBZEG/X2l4N9Uzy/6ntU6QtsnQVHrGFYm1
	pTCo3JB59KsNIAU3JLHiyMLAM1vx5pTVv1UzZhPfVQR6IGUoQ54VbywuHCOH0taq5/2vQ5
	cVXOCiz50HdatFVepBm+d1urbtQSvmRLfGM6Vh8wTsteDYXwNLTyj5rVkkI3HBnc+J5dmk
	kl7senjpalCWL8QCaRV7J+oFg+jdOUfuKdkJnghcbw/GCTVICfJySoT8SN+nfwv7acMmXN
	fiD+WoWVlZEjcyiCGyHuY3P9JVTwlHJRtPTIiSFzYjdJeY7u2TYTVWjRCQqMsw==
Date: Wed, 26 Mar 2025 13:00:07 +0100
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 00/16] Add support for Renesas RZ/G3E SoC and
 SMARC-EVK platform
Message-ID: <Z+PsR57OVSKQNArL@duo.ucw.cz>
References: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FK8HFQIVa+12wb0X"
Content-Disposition: inline
In-Reply-To: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Mar 2025 12:00:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18369


--FK8HFQIVa+12wb0X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds initial support for the Renesas RZ/G3E SoC and
> RZ/G3E SMARC EVK platform to linux-6.12.y-cip kernel. The RZ/G3E device i=
s a
> general-purpose microprocessor with a quad-core CA-55, single core CM-33,
> Ethos-U55 NPU, Mali-G52 3-D Graphics and other peripherals.
>=20
> All patches are cherry-picked from mainline kernel.

Thank you, applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--FK8HFQIVa+12wb0X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ+PsRwAKCRAw5/Bqldv6
8iL3AJ9grns6lvCn27BpOzARK4HdYgDXOwCfSsalYSPMkR0FwTFosSHMKlPS/Pk=
=6ABH
-----END PGP SIGNATURE-----

--FK8HFQIVa+12wb0X--

