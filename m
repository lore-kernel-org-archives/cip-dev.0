Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46951CFD317
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 10:00:17 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13446.1763978407627900856
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Nov 2025 02:00:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=HXCakbwX;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 840E610078562;
	Mon, 24 Nov 2025 11:00:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1763978405; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=zPpmonEznBwWWVskA/h4+/tRTNB+eCfltivKMnBXfI4=;
	b=HXCakbwXJ6WPuaEFfKmkp6ZuDUfDenzAHxRPXNFEPDgoyINoO58ZGEPUcy1vW891RJeeSI
	cstRRPrNwN9Gbq0GZRRgQ2kcttkq0IwCiceA7UBDB304J15N5kFu7sZtLxlPi0LXzc5bAl
	AwYUgrQXOJDtvLJOPf6ec3u5CN96MndFZvlZt3n41ZWQW8hSnOvv9uvpCQVi4LY4lH6guI
	P/H5aTfZIsopirmDJVkgjGxf/l6so8BF24cQvRYoJpk3/LkOGByDBD9gNQttKzwAo3BTnH
	eVyOF0y6lYnGTtB8LoNocXhnzVu1UdY1rDhAO9qrIjUW3CaGs4ITm6gjYxfRRg==
Date: Mon, 24 Nov 2025 10:59:59 +0100
From: Pavel Machek <pavel@denx.de>
To: iwamatsu@gmail.com
Cc: ovidiu.panait.rb@renesas.com, cip-dev@lists.cip-project.org,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/9] Add RZ/V2H USB2.0 support
Message-ID: <aSQsn6Py2b+OhCVX@duo.ucw.cz>
References: <20251120165726.18296-1-ovidiu.panait.rb@renesas.com>
 <CACe6DC6LKK9Pc0Xa1H5gMYO_xhwpeyg2x39Sau0tgHKPpHX3Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hYeAhS8lmhHvCnuq"
Content-Disposition: inline
In-Reply-To: <CACe6DC6LKK9Pc0Xa1H5gMYO_xhwpeyg2x39Sau0tgHKPpHX3Tg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Nov 2025 10:00:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20705


--hYeAhS8lmhHvCnuq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This series adds USB2.0 support for the Renesas RZ/V2H SoC.
> >
> > Patches were cherry-picked from mainline kernel.
>=20
> Looks good to me,  I can apply this series if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Thank you, applied and pushed out.

I'm getting problems testing this, but I believe they are caused by
not enough boards in the test labs.

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2173447147

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--hYeAhS8lmhHvCnuq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaSQsnwAKCRAw5/Bqldv6
8k9vAJwKsV5Wxh0MO+8CTZkPBIF4leWKbwCfdcORhELnWDWtoAh95r1Ip9sCfZs=
=KnwY
-----END PGP SIGNATURE-----

--hYeAhS8lmhHvCnuq--

