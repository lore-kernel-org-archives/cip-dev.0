Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0945CCF9F8
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 10:49:05 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6873.1762339740894881194
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Nov 2025 02:49:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=U/u1xdaV;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 410541003CE0E;
	Wed,  5 Nov 2025 11:48:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1762339738; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=uVo/l1F2hGEcoNHSfB/JA6mesn0x3FYXoOZfq40yC0w=;
	b=U/u1xdaV68fTXEl0qXKIqzjLrllUiAKfmBwBjh8rU2ruyLAWrycm28vmQk5uSvdtP0xXFu
	9gkAJx5x2zvcqZl6lJsxw+hLpSHR2jirhbNkG1NqPLlx0snU9LyZWw+UI9MWygHbX9yEYc
	GM4iukvcKfJc1bQ4J0SN6qigg0MfCj31nquxnaxmUm011FCdqkrPW6hJvYfkYpXjSIVO6+
	n9WMyMhuq59c5yvqTD6V0mg4eIt5ynD/nMLhKkbZXUanyNWnJ7FECaCsBL/783+ZTgeXq2
	NlPP/4R9zNMqZemxlm0IoSNiVS3hYnl0hdKLcyM0sz8Rao2sEjPjitXiJSnjCA==
Date: Wed, 5 Nov 2025 11:48:53 +0100
From: Pavel Machek <pavel@denx.de>
To: biju.das.jz@bp.renesas.com
Cc: John Madieu <john.madieu.xa@bp.renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/22] Add RZ/G3E GBETH support
Message-ID: <aQsrldDm96rIxlNU@duo.ucw.cz>
References: <20251103113817.36331-1-john.madieu.xa@bp.renesas.com>
 <aQsW7v7fTWuS5Zi9@duo.ucw.cz>
 <TY3PR01MB113467095AF7FBC653DD1A8C586C5A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v+lypXEy3mSuCD3W"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB113467095AF7FBC653DD1A8C586C5A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Nov 2025 10:49:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20359


--v+lypXEy3mSuCD3W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Add RZ/G3E GBETH support to cip-6.12. While at it, also backport
> > > RZ/V2N Pinctrl and OEN dependencies.
> >=20
> > I agree that most of the issues are best solved in mainline and should =
not block merge (provided this
> > passes testing and there are no other comments).
> >=20
> > Please take a look at
> >=20
> > "[cip-dev] [PATCH 6.12.y-cip 01/22] soc: renesas: Add config option for=
=2E.."
> >=20
> > It may make sense to put that one at end of series, and I can probably =
do it while applying, but I'd
> > like confirmation.
>=20
> We planned to add RZ/V2N later on 6.1. To cleanly apply RZ/G3E pinctrl pa=
tches from mainline, we need
> RZ/V2N pinctrl patches which depends on that config option for building i=
t.
>=20
> So, it makes sense to add Config option before RZ/V2N pinctrl patches, so=
 that at least we can build it.
>

What I'm saying is that having kernel with

+config ARCH_R9A09G056
+       bool "ARM64 Platform support for RZ/V2N"
+       default y if ARCH_RENESAS
+       help
+         This enables support for the Renesas RZ/V2N SoC variants.

but no working rz/v2n support seems to be confusing to me, and I don't
believe that's a way things are usually done. Can you correct me or
explain why it is required here?

Thanks and best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--v+lypXEy3mSuCD3W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQsrlQAKCRAw5/Bqldv6
8npjAJ9UyXM0GF+86XqY3Iy/qUk+p6aBZQCgjBZfPR3rtJJhraQq1L3CCPWMh0w=
=BCqF
-----END PGP SIGNATURE-----

--v+lypXEy3mSuCD3W--

