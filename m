Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5D0C83F17
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 08:34:39 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.73618.1752482071523760323
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 01:34:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=B8lt5y1F;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 40B3D10397286;
	Mon, 14 Jul 2025 10:34:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1752482069;
	h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:
	 references; bh=WlK5w3v8d4AdVyLH3xA8Ds+Wt09KBxYHJkOYgMT2XCM=;
	b=B8lt5y1Fto+oW8j9PDdGaUFlU1/y6gdthSX3CU5DcOeYHfnNpW2k3lVGMWCkH+D4fttSER
	ixZsMjL6K/sbYNRjv8a0eTe32m62pkjqUgsWqT3bCUr6illGh0X43VVtUAlc14/6i4q80J
	ZBlwUz0FxM+8VkvZrB1YMz3rNOOcptuMfMkFJb+R43Kb4THlLp7BqAUFEYG8PYYQWTLr8h
	usvkSKml1g7BiyMXs67ZPZHeELNXlbxQHKFVj+B5ZeIaxtXhW2/esmT9HUOCMs2HMclp4+
	DDBnJSUqQyhivuDmx6+WepZOqSR0adGTHfRP2LUQ6/jXWKkw8IvLMlnpgkHI6A==
Date: Mon, 14 Jul 2025 10:34:25 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/8] RZ/G2L DU enhancements
Message-ID: <aHTBEeihrQH1PJBq@duo.ucw.cz>
References: <20250711155633.103449-1-biju.das.jz@bp.renesas.com>
 <aHODWBPDTudaoNV/@duo.ucw.cz>
 <TY3PR01MB11346B27385EF1C42125F09AC8655A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <185211008098CFED.7957@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/KCHtc1IkcfphMQ9"
Content-Disposition: inline
In-Reply-To: <185211008098CFED.7957@lists.cip-project.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 08:34:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19426


--/KCHtc1IkcfphMQ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > This patch series for enhancing RZ/G2L DU driver.
> > > > All the patches are cherry-picked from mainline.
> > >=20
> > > Thank you, looks good to me. I assume it is same as 6.1 version?
> > >=20
> > > Mailing list damaged the patches, but 6.1 version came in ok, so I gu=
ess I can just apply that
> > > instead. (Assuming no other comments and okay tests).
> > >=20
> > > (And I guess we should think about sending patches as one series "6.1,
> > > 6.12 -- subject", when they are identical).
> >=20
> > Yes, I agree. But I have notices that, sometimes cherry-pick adjusts th=
e line position for patches
> > automatically even though it is identical patches across 5.10/6.1/6.12.
> > In such cases, if applying patch fails one can cherry-pick it.
>=20
> Aha, yes, so that can no longer be automatically applied.
>=20
> Can I ask for re-send of the patch to pavel@denx.de? Unfortunately
> mailing list damaged this set and I don't see a way to easily pull
> them out of mailing list archives.

Standby. I believe I got good copy from patchwork.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--/KCHtc1IkcfphMQ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaHTBEQAKCRAw5/Bqldv6
8rV7AJ9zhyHxhvXiXIal5+pANiIjQp/JSQCfbDVnXsoU+jp9HPvD8PsKHh8SghU=
=fgCs
-----END PGP SIGNATURE-----

--/KCHtc1IkcfphMQ9--

