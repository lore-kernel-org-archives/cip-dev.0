Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344DCCA5FDD
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 13:53:51 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12718.1790949226908304473
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Oct 2026 06:53:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=fYrIjMtW;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A8E351076AE;
	Fri, 02 Oct 2026 15:53:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790949220;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=M4/SP34mYzh94IeSaksvWPU520JUJRy1xJCAHBb5BIo=;
	b=fYrIjMtWyG57klUEcjS3dXOYLeVXA9xeL5JToBupWpE1S8Ty2TNbIimat0TyAPirKhv9ea
	OW6n8rVwKGKgrEUCubPBMGLoCePkYKZ7loZhzszAWX4nNrmm09WfTT2vaI/kkTSEMMFhBu
	uZ7bP2QDNzzUZdb7l35hd0X8nhul4T5F2lGqwXjkHX10//o8R+/jdRG36aVA7ucoLhkfR7
	BJ21VcKdGJ+5M/ogs3pgeJjaoeX0zEdqleoKL3kHP6SUSUlqBj9oszL6ZCfZkkAPQIGXKn
	b1JE8zB9b2BsrfmN8WiALzSYjLj96ZBIdM0pi0FsVPAp3TTt5UugL96XK7WRqA==
Date: Fri, 2 Oct 2026 15:53:37 +0200
From: Pavel Machek <pavel@nabladev.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com,
	cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 5.10.y-cip v2] PCI: rzg3s-host: Fix compilation
 warning
Message-ID: <ar-3YZjt0Y3LUSWq@duo.ucw.cz>
References: <18DABA70C609480B.1715499@lists.cip-project.org>
 <18DABA8A478FA49E.2870736@lists.cip-project.org>
 <a33b1f98-8d7f-4826-b6aa-2058cc81b2db@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wPFp7nYpA0T2xfg0"
Content-Disposition: inline
In-Reply-To: <a33b1f98-8d7f-4826-b6aa-2058cc81b2db@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Oct 2026 13:53:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24420


--wPFp7nYpA0T2xfg0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2026-10-02 16:49:11, claudiu beznea wrote:
>=20
>=20
> On 10/2/26 16:48, claudiu beznea via lists.cip-project.org wrote:
> > Hi,
> >=20
> > I realized just before sending this patch: the v2 should not be in the
> > patch
>=20
> s/before/after

:-).

> > title. Please let me know how would you prefer to handle it.
=2E..
> > > Fix the following compilation warning:
> > >=20
> > > pcie_rzg3s_host.c: In function =E2=80=98rzg3s_pcie_probe=E2=80=99:
> > > ../drivers/pci/controller/pcie-rzg3s-host.c:1558:2: warning: ISO C90
> > > forbids mixed declarations and code [-Wdeclaration-after-statement]
> > > =C2=A0 1558 |=C2=A0 struct rzg3s_pcie_host *host;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 ^~~~~~
> > >=20
> > > With it dropped extra ';' at the end of the moved line.

Why are you moving the line in the first place? Drop the extra ';' and
warning should go away.

Best regards,
								Pavel

--wPFp7nYpA0T2xfg0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCar+3YQAKCRAw5/Bqldv6
8sWqAJ9pa44+X5b7U6tnR49IvtRmZlDrnQCgsAFzT/Bfnk7oYMkn7SnCIAbVnsg=
=r/Xu
-----END PGP SIGNATURE-----

--wPFp7nYpA0T2xfg0--

