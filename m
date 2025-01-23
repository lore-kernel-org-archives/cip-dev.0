Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA1FC02182
	for <webhook@archiver.kernel.org>; Thu, 23 Jan 2025 15:34:31 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.13550.1737646466347664592
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Jan 2025 07:34:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=e+aWqMvu;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EFF2D1092C1E8;
	Thu, 23 Jan 2025 16:34:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1737646464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eaOPCjrLOwi/wJEny5TY2tvy9EDRJlLYgMji9/nCJls=;
	b=e+aWqMvus0pTwPAq7UtAb9M4EIBntHBOPahpBGl8zoiBOOMqB0B5a6t+peRGGF4kUTknfx
	K2XBZ1p9Prm6z071XI1os3ewEgHKDqarBkreKmt2D3nKeUMoZQHlWHLkroglibcKKLiA2E
	1gVH8s2xGJsXpOXuIzmMxgxZm+QEre8b+xBrT+qfx8WWs9fZa3h5wDkTVEZHP34kw9z3/m
	FdyKuu9YLMMPRIYHx8CKnEOLX44LY0gt8qQnbydN/mUqp9XtHVXhmf9EUsA8s401JozSpE
	jshi7aEIV3PFHZlBzYprv1S+7SYjjYU4HhM/Qukdy0DTcfXqR5gBQCJAFB3p5g==
Date: Thu, 23 Jan 2025 16:34:19 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: cip-dev@lists.cip-project.org, pavel@denx.de
Subject: Re: [cip-dev] [PATCH v6.1.y-cip 01/14] clk: Add Sunplus SP7021 clock
 driver
Message-ID: <Z5Jhe0daf2R/nH0j@duo.ucw.cz>
References: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
 <20250122115120.2885015-2-claudiu.beznea.uj@bp.renesas.com>
 <OS0PR01MB6388CDA2AEED05007496E31892E02@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <00ac7a78-c715-4027-864f-15433cafa129@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7mwgnpwdTeVsznFX"
Content-Disposition: inline
In-Reply-To: <00ac7a78-c715-4027-864f-15433cafa129@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Jan 2025 15:34:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17610


--7mwgnpwdTeVsznFX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I understand that the SP7021 driver itself is unrelated to Renesas SoCs=
 or this patch series.
> > However, would you consider applying the patch as is without deleting t=
he driver?
>=20
> Sure!

That would be one option. Another would be to apply just the
include/linux/clk-provider.h with different title/changelog,
explaining this adds only generic function and where it is originally
=66rom.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--7mwgnpwdTeVsznFX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ5JhewAKCRAw5/Bqldv6
8mGlAJ9ZqiN8+c+ROmEgAXODmxxS5u2LZACgkW9yVqxUXCriARNJNgqWF69vKqs=
=HqHu
-----END PGP SIGNATURE-----

--7mwgnpwdTeVsznFX--

