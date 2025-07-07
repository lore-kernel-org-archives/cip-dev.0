Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03105C83F07
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 10:52:19 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.57111.1751885529237874168
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Jul 2025 03:52:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Wzv9Kx/4;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5E9EA10380104;
	Mon,  7 Jul 2025 12:52:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1751885526; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=P8/K+TQwxZf+tv6Hdb0v928sUFPN2QD5RCgPRy2HUrs=;
	b=Wzv9Kx/49esOdwbClIbVqLsIAu4suBQg6/2p9+zonwpNQyfWmOB7JpFaWlGLnMDGWf0f5a
	P7wcNj5/Avtn/ca8TiTuJkSFbGAuXxSRFjmx9XUcbVLJXeps5hCNqnXFF+rTN4z5+cjCaJ
	zphY5ywRtqUsxZhELWqKKz0cHuog7UT7tgUQ9joYgiq8QTN49fJIt+XPUl0h3pHK/AKXnB
	9cl/c+SI/OnCSLU+TeNHHEA129/a56TwC/Fd/Ed5QyhYM0C7oCWLg9M0zmELaHn+v8yVsO
	CVr+fGxDzMwlEqkifhI9s+vT3/ruamB5T6XyAq1OsxhHXKqeQTkCU1bQwjnvGw==
Date: Mon, 7 Jul 2025 12:52:01 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: tommaso.merciai.xr@bp.renesas.com, cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	tomm.merciai@gmail.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/14] Add Support for RZ/G3E ICU
Message-ID: <aGum0TXs8C3epgyr@duo.ucw.cz>
References: <20250704090556.669652-1-tommaso.merciai.xr@bp.renesas.com>
 <TY7PR01MB14818EB0CC35194105AFFD671924FA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y2zKsShx/7EryrZW"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB14818EB0CC35194105AFFD671924FA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Jul 2025 10:52:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19385


--Y2zKsShx/7EryrZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>=20
> I reviewed this series, looks good to me. I can apply, if there are no ot=
her comments.
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thank you, patches look ok to me, too, so I added your tag and applied
the series. vx2 tests are still running, but I believe that's a board
problem.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Y2zKsShx/7EryrZW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaGum0QAKCRAw5/Bqldv6
8sfnAJ9fJNAQntpDOWX9Z1wiNQJqT1qtDwCgpX11SVgM9Ui4hoHvoY+tDCmSITQ=
=s4Kb
-----END PGP SIGNATURE-----

--Y2zKsShx/7EryrZW--

