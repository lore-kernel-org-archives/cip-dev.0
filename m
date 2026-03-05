Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477D9F47CAF
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 18:29:17 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.51444.1772735352397315642
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Mar 2026 10:29:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=SLU3f39J;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E5C96103DE9;
	Thu,  5 Mar 2026 19:29:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1772735349;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=qtLowp5feCFy9vmvhnav4Paih5WtDEcdi5qd0eljFcw=;
	b=SLU3f39Jxt0j3xuKinG6BrYJv2yUCroLkNZQ1iv1knFIbVOiuwwIu6emXapRV3OiTzdalg
	aRYZcf2Q/icVuqXTsJsMzb9h1raDUJTRIjzgUipf9d2plLXBB5FukWBF5AOZhlEHMl5xGO
	5k8J/3+6uE3Qd8+RnMRLJ3dbHQSx44JiVZwASkIsF48V5MhcHbZ6KYGK7gu6R906GE7pZq
	j6c1BOW5JPBLlaOuq43I9mq1gFcYteqh+YuZdyxkKMH+3eG0aKjFdRXsyqUWe9Wt5R6sTy
	5m54knEYbIuuB1nsVYooJAP1NNkVTAgMKzM+Uh7oU8lnUhDaN/39f2ncZndtTA==
Date: Thu, 5 Mar 2026 19:29:04 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 0/7] i3c: renesas: Add suspend/resume support
Message-ID: <aanLcL59iwhC0q7/@duo.ucw.cz>
References: <20260303092259.13301-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/MFb7rlhjmXZSSbF"
Content-Disposition: inline
In-Reply-To: <20260303092259.13301-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Mar 2026 18:29:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22098


--/MFb7rlhjmXZSSbF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series enable I3C on RZ/G3E SoM and adds suspend/resume support to t=
he
> Renesas I3C controller driver into linux-cip-6.12.y.
>=20
> The series also includes patches required to backport:
>=20
>  - devm_clk_bulk_get_all_enabled()
>=20
> Into linux-cip-6.12.y, which are used by the main suspend/resume patch.

Thank you, applied.

Best regards,
								Pavel

--/MFb7rlhjmXZSSbF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaanLcAAKCRAw5/Bqldv6
8v68AKCSYEYtae4iHqDLbDztD+WQ0bc3wgCghnVTzVup0ocSR7fPi6gzByBv/6Y=
=ypqb
-----END PGP SIGNATURE-----

--/MFb7rlhjmXZSSbF--

