Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE3AC5B549
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 16:21:44 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.21044.1749054101481969849
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jun 2025 09:21:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=UN/vqyOa;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 04F0A10397298;
	Wed,  4 Jun 2025 18:21:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1749054099;
	h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:
	 references; bh=Ve2LvHyzeThX42fHkeyfLI4yw1vxnHdCIzfYV8bA8yc=;
	b=UN/vqyOaMSvFNbLQBgrd7FQtrtfSuZi0laLsd5xRAvEyxVYzvnggoxGlZsxOgDGDYU7KYR
	n6bkPudCr+boA92Thspgm7bB2wFzoHWqX1eWo8Qzgn7cGFHaG+QRvZZIPFh5vyfc08ZEvy
	0lO5MtP6CsB/oxBH7Awaz0XLitCcNDZebou2V3nGSuQn0OAyjPYEnmSqeZqzuxmpHEVhQ3
	XjbZ4ZHJgfz5RYM6W7lL11EZTGwfU+fqzaWrBG0ZCZZjIfTJTWUZQ2+yz84obq17eKGclv
	CViMSk19olqU/Tqtm4rxqph7YX0YqrfMqQrIFZMhco0OdL+LxK+fpTjEdLouxQ==
Date: Wed, 4 Jun 2025 18:21:35 +0200
From: Pavel Machek <pavel@denx.de>
To: Chris.Paterson2@renesas.com, cip-dev@lists.cip-project.org,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: Re: [cip-dev] renesas_rzfive offline causing test problems?
Message-ID: <aEByj80Hl01NPJIV@duo.ucw.cz>
References: <1845E2F2408E0360.10841@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C9aN3b8xmAlmT/PN"
Content-Disposition: inline
In-Reply-To: <1845E2F2408E0360.10841@lists.cip-project.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 16:21:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19011


--C9aN3b8xmAlmT/PN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> We are trying to test latest SCIF patches, but apparently rzfive
> target is offline:
>=20
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1852365220
>=20
> (I hit retry, but I doubt it will help).

Ok, so it helped. Sorry for the noise.

BR,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--C9aN3b8xmAlmT/PN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaEByjwAKCRAw5/Bqldv6
8q4mAKDAuDyvrwV3DVOOVage/vvdfwQoaQCeLQrc61zpHFb6Kfcw/JAcsUUWsiI=
=Ron8
-----END PGP SIGNATURE-----

--C9aN3b8xmAlmT/PN--

