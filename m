Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57647C369DC
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 09:56:26 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.15589.1745920584415391739
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 02:56:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Vvoh7iE+;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2C03C1026A6DE;
	Tue, 29 Apr 2025 11:56:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745920582; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=hNI+1HkgfIbBVRhZEuXtVo7MRIzH1sSZS9Vpt22mAqs=;
	b=Vvoh7iE+HNEbAFCYz6PWpQNUGwVCNNz0YcPMksXlaGEk33gbo3uJKBBNaeMv4R2vrngKVu
	RQqFjGVqoUWWbIE+sxZnsZUFCuYAaq8cO6v4CAaiHZMZEAE/CFQUmNPHbjtuUKFlFdlIGy
	isvYmkrxValK0GLENqJ/eA8fK55+ThdBE1u5xQxvkOJ2HAyYHzresXGUGkiRMWCz53UNZ/
	/2bNocdiadeetYGxFTT+8fEwqRbQ2PNXwFrgX4TClnb5hNCSHojMXsaFftsZvBiBrS9kkP
	DWC5oadX3So1g2GqPE6w4jamLrTYtq152m5DKOrz7guBH/jzusSEL2tfpSWvDA==
Date: Tue, 29 Apr 2025 11:56:18 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH v5.10.y-cip 0/3] RZ/G3S: Backport DMA
Message-ID: <aBCiQhG6jIe7KP50@duo.ucw.cz>
References: <20250428050116.3081804-1-claudiu.beznea.uj@bp.renesas.com>
 <aA8nwI87irhzJxS3@duo.ucw.cz>
 <d8ff6b74-0508-453e-946a-83491659316c@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ylX8qBFxhrXU0VQr"
Content-Disposition: inline
In-Reply-To: <d8ff6b74-0508-453e-946a-83491659316c@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 09:56:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18710


--ylX8qBFxhrXU0VQr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> Series backports the Renesas RZ/G3S DMA support to v5.10.y CIP.
> >=20
> > Thank you. Series looks okay to me, and I can apply it if there are no
> > other comments and it passes testing.
> >=20
> > If you wanted to help me, adding note "All the patches are already in
> > v6.12-cip" would be nice. (I checked few, and assume they are).
>=20
> Yes, they are all present in v6.12-cip. Sorry for not mentioning it. I'll
> keep it in mind for the next submissions.

Thank you, applied.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ylX8qBFxhrXU0VQr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaBCiQgAKCRAw5/Bqldv6
8nDgAJ91RN617hfNsYtE1fcWoyEfRbaNMgCfbG3zDp+q5MP7jWmkZUfziDY1xys=
=IL+0
-----END PGP SIGNATURE-----

--ylX8qBFxhrXU0VQr--

