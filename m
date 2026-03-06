Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF24AF01816
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 09:31:31 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.65795.1772789490422804650
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Mar 2026 01:31:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Jk3vEOnA;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6E8BB10A7F2;
	Fri,  6 Mar 2026 10:31:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1772789488;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=3yG7FjtjeaQx1Cu5WOqBEVrheuFDGAB2Hu00nuLrR9I=;
	b=Jk3vEOnAuYQ2RTazjZBFTQiObjbfGGOC5sOKIULBFvJvsITMCOga8tVTriIYp6iermInXe
	FY+gKjdP13zXFYPIcjKo3yK04AD2Gg1OCH4l49dnbGc4co/Qc6zOo+tkqBxeJDDJiCSE19
	N6NKfBIbzRtdPKR7sPC/a2uolXNGEzSw8Lqs4a/LZMsviZ3jqimkwgsw6a1rfXglN791YR
	Wc6M4HDCQDRV1wpPxSb62QMcgueFNGZieSNi0WNNlKJmmWd8UgVwXPAFHZ8uyxZrGkiY6J
	2Ss7DB34v4YC7oOki1e4QZJaOSX5vPxZSVnWWu2XPfPyH4kPSaqKyTcFaaKmRw==
Date: Fri, 6 Mar 2026 10:31:23 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.1.y-cip 0/8] Add RZ/V2N display support
Message-ID: <aaqe61PEV/Ma6qZK@duo.ucw.cz>
References: <20260305153624.19793-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C+E0CFdiS/IfQU0m"
Content-Disposition: inline
In-Reply-To: <20260305153624.19793-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Mar 2026 09:31:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22099


--C+E0CFdiS/IfQU0m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds display support for the Renesas RZ/V2N SoC and EVK
> board.
>=20
> All patches were cherry-picked from mainline kernel.
>=20
> Note: This series depends on:
> https://lore.kernel.org/cip-dev/20260225121003.129467-1-ovidiu.panait.rb@=
renesas.com/

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel


--C+E0CFdiS/IfQU0m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaaqe6wAKCRAw5/Bqldv6
8oI3AJ4u8f0a5EN7OOL0KvpflPxszyA1ewCfQ2flhYDFAoAKBKo/Ynru02qRDkE=
=44Or
-----END PGP SIGNATURE-----

--C+E0CFdiS/IfQU0m--

