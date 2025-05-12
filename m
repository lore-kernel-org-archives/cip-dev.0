Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59870C3ABBC
	for <webhook@archiver.kernel.org>; Mon, 12 May 2025 08:01:31 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.45024.1747036889776792164
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 May 2025 01:01:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=ODWZQhXW;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C122310272092;
	Mon, 12 May 2025 10:01:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1747036887; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=pra/Bn7W2T0WhyuwVSceifMgDK1GQqWHDD43KEAONy4=;
	b=ODWZQhXWJrQnheb6b7xhFhiATcWjLWkuUB3S9Du7YCzH3reJjL/IR7X0vDHwpcHNOqh230
	N0zRFfgdMbayG48vTgbyGD76nPjFElS2oC2QYVg0rup6sDDs0KsI7yG1GDq8yO3zMTkp2j
	zxwsMlCbEpRDPEgY4SgPSK4dAVZIiKUdRYul33aTW3QVtiAv/KBis7wdqqBPIFIUpUZXlK
	bVmzJGhQQ+yoW78iPGcr1EgTwb+gl2NAILbC6g56qByyKc9R8FQp50RYb+j5Ejjwcawms8
	GHX57MYtIDVZ4tnrbNYqGDEIHFn/CerxvmaMvtd3K16Oqvo9uhcO9LaluX8k3w==
Date: Mon, 12 May 2025 10:01:21 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 5.10.y-cip 03/37] ASoC: da7213: Add new kcontrol for
 tonegen
Message-ID: <aCGq0e9FcQ1ShAAq@duo.ucw.cz>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
 <20250509093442.4015145-4-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7u9eHWTetlltaEVm"
Content-Disposition: inline
In-Reply-To: <20250509093442.4015145-4-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 May 2025 08:01:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18893


--7u9eHWTetlltaEVm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: David Rau <David.Rau.opensource@dm.renesas.com>
>=20
> commit 64c3259b5f86963c5214e63cfadedaa2278ba0ed upstream.
>=20
> Add new kcontrol for tone generator

DTMF in hardware? What are you using DTMF for these days? And is it
really useful to have special silicon and special code in driver to
accelerate it?

Like I mean... I'll take the patch, but it looks strange.

Best regards,
							Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--7u9eHWTetlltaEVm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaCGq0QAKCRAw5/Bqldv6
8s5IAJ9UySuCuqIkVTgDKOh/QEn4ZoH+3gCgt8GY+54ZGYWnAy7pqN+gBAn9kOE=
=hICh
-----END PGP SIGNATURE-----

--7u9eHWTetlltaEVm--

