Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51503D16810
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 11:03:07 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7853.1767956577091794176
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jan 2026 03:02:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=f+sQTj2R;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9744D10DB6B;
	Fri,  9 Jan 2026 12:02:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767956574;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=/Z/zn3PoRZ5K20QI7LEszUp5UxfiJB+U0Uvit3PHZZU=;
	b=f+sQTj2RROyMPMS78CIbXVjfglp8ec2l2gZ+KQNdezcqjM4DAh1uUDOMxpsepiQSV8A46T
	cUJae6npFwcErBoZEaprXBeYxt5uwzRLfhT3qstuJTFmf6BqTfJr6eGEh6mYM5W/sVgMv/
	1EbL00Igkz6zlqeYE2XkbWCEGziWri19RsBXLBrq+wVe3pERVHKX2xoxCb7Xjad2IJvR1l
	+oQ8zLgrIZHAxQZPqcq4zxDWCoZric0fQUvHHuErrsUhEZmxmv5WOtwuoljleFEheyuhe1
	vuD0Q8UI9fDkIQKtRgXXU8FaNKXSNk6ZtgHjMbMqx/Lf//eb+joqNK9zXqix2w==
Date: Fri, 9 Jan 2026 12:02:49 +0100
From: Pavel Machek <pavel@nabladev.com>
To: tommaso.merciai.xr@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/19] Add I3C support for RZ/G3E
Message-ID: <aWDgWdJhDFKUKyo1@duo.ucw.cz>
References: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+p8Gw3LhbEA+7PYK"
Content-Disposition: inline
In-Reply-To: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jan 2026 11:03:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21502


--+p8Gw3LhbEA+7PYK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds I3C support for the Renesas RZ/G3E SoC into
> linux-6.12.y-cip kernel. This includes also nxp,p3t1085 I3C backporting
> for testing purposes.

Similar to 6.1 series, I'd propose to apply patches 1..14.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can do it if it passes testing and there are no other comments.

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--+p8Gw3LhbEA+7PYK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaWDgWQAKCRAw5/Bqldv6
8ksMAJwK3nr0Qu9FGF06oPTkbWeUz/cf9QCgr3u+HSEefkWEUzmgDx0XM9uvBbE=
=AtJO
-----END PGP SIGNATURE-----

--+p8Gw3LhbEA+7PYK--

