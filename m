Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D7DCA1013
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 19:33:00 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.3716.1757014377708558396
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Sep 2025 12:32:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=MFl5winb;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C1A43103A8404;
	Thu,  4 Sep 2025 21:32:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1757014375;
	h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:
	 references; bh=blQTQrp19IEG4qy5lWELKwgXKbABXe+cdSJKsdKnrD4=;
	b=MFl5winbwTGgXIc+GvusNj/mQ26Qf5YYuo/J8A0DSL5qDXPgMcQf9XCEUZd+JYxIe+w31e
	EBccdd757U5UH5fUPCWpYPL6W6ghT8xZW2PLAMPZea8qAzgUi6ey7e6VbWGb02DYszkzrX
	W12RIhSb/72uMLadIq359fzS8sN2KB3rSQUqxd4OSB4lY5z10VfS+ThAAgsRDJ4Z+67ruW
	nLcm/GmzFGKJ43x7IhjJaMlTW6dlZ73GV6PXGg5ULBeUjW86+CmgYMx36+6lzdCKImpkTX
	VextCgUuVwnOnmNWCS1mebh79BQvmYlhI1ahqy9qjz9qAmkNNVsfA2DtWWBFqg==
Date: Thu, 4 Sep 2025 21:32:48 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>, tomm.merciai@gmail.com
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/55] Add support for CRU/CSI2 on
 Renesas RZ/G3E
Message-ID: <aLnpYPcBpI2Rl22c@duo.ucw.cz>
References: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
 <18621140148CAD06.8194@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0D7JFVAajjk3m9PD"
Content-Disposition: inline
In-Reply-To: <18621140148CAD06.8194@lists.cip-project.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Sep 2025 19:33:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20017


--0D7JFVAajjk3m9PD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This series adds support for the CRU/CSI2 IPs found in the Renesas RZ/G=
3E in
> > Linux 6.12.y-cip. These IPs are similar to those found on the RZ/V2H(P).
> >=20
> > In addition, it includes patches required to successfully run the v4l2-=
compliance
> > tests against the OV5645 and the entire media pipeline.
> >=20
> > This series has been tested on the following hardware setup:
> >=20
> > OV5645 image sensor (Coral Camera) =E2=86=92 RZ/G3E CSI2 =E2=86=92 RZ/G=
3E CRU
>=20
> I'll likely apply these in a hour or in few hours, so you have last chanc=
e to
> comment here :-).

Thank you, applied.

Best regards,
									Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--0D7JFVAajjk3m9PD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaLnpYAAKCRAw5/Bqldv6
8lR8AJ9Hr6Fp/eEN4mFbmKW4UZoHkHGe2gCfW1SOjvm/3kUcrla9tDslfkwmVvs=
=gM9X
-----END PGP SIGNATURE-----

--0D7JFVAajjk3m9PD--

