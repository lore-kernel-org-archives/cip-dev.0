Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B04E7718A
	for <webhook@archiver.kernel.org>; Thu, 19 Dec 2024 11:17:03 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.127079.1734607016640019892
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Dec 2024 03:16:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=IRO2wmey;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 091991048B8DF;
	Thu, 19 Dec 2024 12:16:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1734607014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zhOjxSxcRSaNf0Jj2vISaGosTvyGa8IviFvvclmCO/k=;
	b=IRO2wmeyvsSQcIzDGT7Neb6H+hLj5bnfgCooHu3hvC+8aLWv5dfets0j0J/p7LgkCnCMlm
	6kjRFZvhjotbKf3OFC1iei9vyJYbgnjWDiqlzgCd9bIy4C7kdMlZqJReZ2B1nqbb9ey24I
	rItx3i4qY3Z5NXnmCGgWMb0vcFZvnY89ginOgrjghdwyrMRcxdtMlIrnXhpZZQXq99y1Qy
	G0IwYULBUIiopMEyUtmDdt5FUE/GKwBi8xzOOp8aFXQVA0Chn2AEWvVhOrGEl6IdI+tAtU
	660oe+jWAnzZO8dKmCqmj7irNQEoxqrYiwlQAKmBW1PDmuMcJ/prvVMae7LcPg==
Date: Thu, 19 Dec 2024 12:16:52 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: claudiu.beznea@tuxon.dev, pavel@denx.de, cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [cip dev][PATCH 5.10.y-cip 00/10] watchdog: rzg2l_wdt: Backport
 RZ/G3S support
Message-ID: <Z2QApF86deanxkvM@duo.ucw.cz>
References: <20241218122317.2365272-1-claudiu.beznea.uj@bp.renesas.com>
 <OS0PR01MB63881DBC3B5EC1E36196027292062@OS0PR01MB6388.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r93NfzVFdq1YArvi"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB63881DBC3B5EC1E36196027292062@OS0PR01MB6388.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Dec 2024 11:17:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17479


--r93NfzVFdq1YArvi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I reviewed this series, I had no part to point out.
> I can apply this, if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thank you, applied.

BR,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--r93NfzVFdq1YArvi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ2QApAAKCRAw5/Bqldv6
8tCiAJ9nyZj9DArHJ1p8Q9J88v1Z4JeTvgCeJYZo5uo3OKdhO8zcKakaOvkoXM8=
=l1nj
-----END PGP SIGNATURE-----

--r93NfzVFdq1YArvi--

