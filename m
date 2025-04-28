Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB98C36005
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 07:03:35 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.42258.1745823716118910165
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Apr 2025 00:01:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=BDbfCcgW;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9474A1026CE84;
	Mon, 28 Apr 2025 09:01:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745823714; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=kWmDs0sfE/Q8QpYS1ypWoddZInnGWq0I/U0xuS65tlg=;
	b=BDbfCcgWTg6uPFx7TyJZ4m2lPTDEkqA/eSuL1nR/O00208QHtbf8L5CkJuwNcldUUa4kjP
	D3gMVUf5J7iSg3SQnsrkTawcGep1HbzsBkSYzvSSkPP+0AdfpMuTrzaxD7q1Ec1/DyHc79
	Y0INOjiz8kR3AEV2FVBhqAiNFCkprRchNDE6PXNCGPdLQtCsnSKuBe4vnZdnMjMVH7Uejp
	/7BNSFwTHHlthefT5AGAduLaGwHRlw2Ne0g76e/JvRO8iQmWhu4grHDP8z62FGGXfYGaT4
	blBa4Tzu96+xqmrUiRrU9PSMBfSRuPVRRHbJTeuDBILdy+avI2u8cMU60PQU0g==
Date: Mon, 28 Apr 2025 09:01:51 +0200
From: Pavel Machek <pavel@denx.de>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH v6.1.y-cip 0/3] RZ/G3S: Backport DMA
Message-ID: <aA8n3//LURDQGhq2@duo.ucw.cz>
References: <20250428050051.3081705-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YA29mLRe7ZnvkXsf"
Content-Disposition: inline
In-Reply-To: <20250428050051.3081705-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 07:03:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18682


--YA29mLRe7ZnvkXsf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports the Renesas RZ/G3S DMA support to v5.10.y CIP.


Thank you. Same as 5.10 -- series looks okay to me, and I can apply it
if there are no other comments and it passes testing.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--YA29mLRe7ZnvkXsf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaA8n3wAKCRAw5/Bqldv6
8rfOAJ9bUd4Xhoto285ISPjkRBydJqDnbACgvmbjj0Ho5BvYdUYn64KFCWRtN1c=
=VfZh
-----END PGP SIGNATURE-----

--YA29mLRe7ZnvkXsf--

