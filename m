Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8B5C4450A
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 10:51:50 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10190.1784199107533286031
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Jul 2026 03:51:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=FVecD6Bp;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 87046119DF9;
	Thu, 16 Jul 2026 12:51:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784199105;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=/wAksVqXFwQJEx683oHHN8kzD2c3zBqE2AmPFLV6Dyw=;
	b=FVecD6BpJUn2ruP8C1pz11K/QBu3JLyn5LORoprz2lk3mSdy0I5isZGDGsXE5/zK7lD4rN
	dIMFUtEdrY26PdUiMkV0nqd57x2BKWtyHL0FPP/ZhkReOBTZNT4PRHGOpNRON6aSNamwVf
	/VTmFsblOoYkWxf1lS8RH5vr0u/ShgkQ7JOoepbxEaT/SXU2GSP2YnG9Wi3bGG3FBTi+8R
	/9IkguXQsSF6uemzlqXmhwufYzRrJjYHfv0MsPn2yHQbMlRGflWVllLr+MUqwaVvH6xuik
	/nxJDhLJosYL3QJGkGUzYm+6fOZyvuRPgfqcY4LfpSa7s+KYyXm36JqjGwhLIw==
Date: Thu, 16 Jul 2026 12:51:44 +0200
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@nabladev.com, biju.das.jz@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/8] Add xSPI support to RZ/T2H and
 RZ/N2H SoCs
Message-ID: <ali3wExG4j1r02cS@duo.ucw.cz>
References: <20260706182328.5237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TY7PR01MB14818D949B2AB9210CF312A6ECDC72@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y/cj0yaJYEOOswcX"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB14818D949B2AB9210CF312A6ECDC72@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jul 2026 10:51:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23619


--y/cj0yaJYEOOswcX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >   arm64: dts: renesas: r9a09g077: Add xSPI nodes
> >   arm64: dts: renesas: r9a09g087: Add xSPI nodes
> >   arm64: dts: renesas: rzt2h-n2h-evk: Enable xSPI nodes
>=20
> I reviewed this series, looks good to me.
> I can apply this if tests are OK and there are no other comments.
>   Reviewed-by: Nobuhiro Iwamatsu
> >   <nobuhiro.iwamatsu.x90@mail.toshiba>

I had some minor comments here, but those should be fixed in mainline,
first, so they should not block the merge.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
                                                                Pavel

--y/cj0yaJYEOOswcX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCali3wAAKCRAw5/Bqldv6
8hKYAJ4gdtt6ocDRWZZguouk00Cb6RaH0ACgsq4UR+lGHw2hstkdxaJFr+6RHBY=
=QRdR
-----END PGP SIGNATURE-----

--y/cj0yaJYEOOswcX--

