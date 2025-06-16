Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B42CC71136
	for <webhook@archiver.kernel.org>; Mon, 16 Jun 2025 07:18:22 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.24834.1750058299635494770
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Jun 2025 00:18:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=DsOWLk25;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 568C21039EF0B;
	Mon, 16 Jun 2025 09:18:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750058297; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=dtTvlURLO1l4yEB9ysEwB7RVuLgx+oESlEkBTDS1F5I=;
	b=DsOWLk25i6LLV0bi9wsCw85pFwuk9MMOASmsN+QBdfUP42ZP3q2672ORmMKtm55ite0L8k
	Fs08MTYkS2W8muMT9pMBWZrkSlL8w+F5mXXUjQA5MKlX2T7VGKk2X2gAXQouYNbfqmnzix
	o7NcIiHHEgSqkvW6YbEKkCQF9Hu9IwEzGNc8Nt956PgFYsNstLKgJ5dTEKHugPTpqYd0n9
	J6cTzNvjD+Ej8wkNsWa4NbOE4UZ3LpPJapObLzqhwnnUXX/Jmr/BHOZbFSqpMOYLEusE5o
	gCkNngfLpj6WSnTmEY5ydfPBIJVkDewTpPppbEWnRrlZz//X8QXuLOPd9J2X7g==
Date: Mon, 16 Jun 2025 09:18:11 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: claudiu.beznea@tuxon.dev, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.12.y-cip 00/14] RZ/G3S: Backport ADC support
Message-ID: <aE/FM78hdsYqAk9W@duo.ucw.cz>
References: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
 <TY7PR01MB1481838EE14D326D2910542929270A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3JpDAOhfM8MHxetg"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB1481838EE14D326D2910542929270A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Jun 2025 07:18:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19095


--3JpDAOhfM8MHxetg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I reviewed this series, LGTM.
> I can apply, if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thank you, applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--3JpDAOhfM8MHxetg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaE/FMwAKCRAw5/Bqldv6
8r11AJ0ajQ4/ntmP/lS6MCV43DSvjS62dgCgnkKU+jujk5P74Pf3vwUbBFTHV9c=
=m7V6
-----END PGP SIGNATURE-----

--3JpDAOhfM8MHxetg--

