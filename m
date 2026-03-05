Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8F2EEF325
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 08:39:40 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39810.1772699979568695592
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Mar 2026 00:39:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=NCZMfwLm;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 430CB103754;
	Thu,  5 Mar 2026 09:39:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1772699977;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=CoLJfzrR81OuALKGs1ciRBCoH2B14ommSwT6eoQ/o3o=;
	b=NCZMfwLmEjCQXsCZCYy09hhsGlSNgv6P4UdQpoHpLNXip4kLSj/3QjRdtAn90BCe6iS0ZX
	73hCthli37+6oa388GRwmGE9QcQkzJJO0iWIJpTinNxlf0AXIqqqMaxaptqDHvpqxsJ8hU
	GUkFhRKCVVsvEc1tOp+Xn670o8r7Wx0bcffCqou7hoeYrQP3XyXABRRsywzlJEBHPdV0q9
	U0sbttf0fGr5KrHCQiVRQjU1HgxzKQ02aJQsBdzaIDedokiBy1cb/Xa9ZLdnSOkDNH5vZ7
	tgphWapp8OUAmu/QNn4giAjpgRcRYGhTKnkH0pHaPznpivsAy1vaqJ5R0+QHPg==
Date: Thu, 5 Mar 2026 09:39:35 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 0/7] i3c: renesas: Add suspend/resume support
Message-ID: <aalBRx4TfPvH47Fr@duo.ucw.cz>
References: <20260303092259.13301-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lsefVci59aENLdyk"
Content-Disposition: inline
In-Reply-To: <20260303092259.13301-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Mar 2026 08:39:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22075


--lsefVci59aENLdyk
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
> Into linux-cip-6.12.y, which are used by the main suspend/resume
> patch.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--lsefVci59aENLdyk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaalBRwAKCRAw5/Bqldv6
8h7oAJ4unWzKqG7bYJCFU7L5bfqengqluACfRN7wHMZcRxuvZobkh1rm5RByOWI=
=R6hP
-----END PGP SIGNATURE-----

--lsefVci59aENLdyk--

