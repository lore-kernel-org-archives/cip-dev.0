Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7D1CA1013
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 19:50:31 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.4050.1757015422785527221
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Sep 2025 12:50:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Dvgbwk/L;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1BD49103A8404;
	Thu,  4 Sep 2025 21:50:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1757015420; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=4edSycYul3HZrinC8gv0rYH+BG8FUPPo9faNtmbIkmc=;
	b=Dvgbwk/LHP/zc5G4iZet3p5mNNdwoLQ6ApPCcuQpRbwrciYUJsWWG6UolxbH3tItz05Jgk
	baY424hPrK8ONDzveMGFe7606wyBweOW1wBuz3aWn3d8BOdK9riKAEroXOqWHYZpcPi2Dt
	ZvGyNf9ht03zy6eEVCxGlPWLuVYfFNSH6CJpvbFdcJHfU9wBoDFD1PRrOzS6UXr4MhtUIK
	bG6o7Xg2ffMyEstR5gTY9UnO4DC78AtdO3/dMUMD2LcAjnXd5pVjsop4rAnOww7f4k4r4l
	WXh8bM5Djh3qip1Od5kK+PANyI9ml621rZvzhYv1k+skDj7Tu3GX5YtLq8jfvA==
Date: Thu, 4 Sep 2025 21:50:15 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.1.y-cip] arm64: dts: renesas: rzg3s-smarc-som: Fix
 Ethernet aliases
Message-ID: <aLntd68y6R7tYfeh@duo.ucw.cz>
References: <20250827035801.568246-1-claudiu.beznea.uj@bp.renesas.com>
 <20250827035801.568246-2-claudiu.beznea.uj@bp.renesas.com>
 <TY7PR01MB14818895D45B5E6A30739C66DCD38A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5Rwfn/EBDEbZgWOC"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB14818895D45B5E6A30739C66DCD38A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Sep 2025 19:50:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20019


--5Rwfn/EBDEbZgWOC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Looks good to me.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Thank you, both 6.1 and 5.10 versions look good to me. I'm currently
running tests, I'll apply it if they look ok.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--5Rwfn/EBDEbZgWOC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaLntdwAKCRAw5/Bqldv6
8k06AJ9pi8bIvx08YHMxKsLKy2sD+Qq4/wCdHobtB4VWNjng0/3ywPUGl1p58yM=
=hA6N
-----END PGP SIGNATURE-----

--5Rwfn/EBDEbZgWOC--

