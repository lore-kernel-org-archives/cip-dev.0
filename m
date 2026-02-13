Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8BFEDF157
	for <webhook@archiver.kernel.org>; Fri, 13 Feb 2026 12:09:22 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.70196.1770984560395163532
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Feb 2026 04:09:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=cEY9EXVi;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0E38B10FFE3;
	Fri, 13 Feb 2026 13:09:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1770984557;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=C16wTdCsnL8gOHmDjGecYyhuASQZ5xA2wuPqgn/VFpg=;
	b=cEY9EXViL8HRrSz8pNU+nM+Y/pycpS+SQL6ooHVaHkjBg4OmMfqf76LJXAntJMzSPi23lK
	NqAHErWHDSTGzRcAwA6ks/Pxbe6bFCBAxczk1cAUbBAPk/s2xx58k3//4JHCVwp3TYjDbX
	5o3IOD7HV3Dcg3TC5k5vIHrAKtgcUMCGWsPUfJm2qLsJdKyBxdbOkYcqXa3pFoTZ8LtaO8
	P0pitvwvw/T4I/3gI7Z4CeZHAog+1bOAHia7ZR4kZmsVbX+GCgjs2iNnx0gwAm3sxt3+hz
	fUxsxUq0X5M87o9n/VhohjzZ/XGr8/ehYTUtahEgRE6JGHTa0bJgj0s7IFXFEg==
Date: Fri, 13 Feb 2026 13:09:10 +0100
From: Pavel Machek <pavel@nabladev.com>
To: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Cc: jan.kiszka@siemens.com, nobuhiro.iwamatsu.x90@mail.toshiba,
	cip-dev@lists.cip-project.org, pavel@nabladev.com,
	masami.ichikawa@cybertrust.co.jp, uli@fpond.eu,
	chris.paterson2@renesas.com
Subject: Re: [cip-dev] [ANNOUNCE] Release v5.10.249-cip69, v6.1.162-cip51 and
 v6.12.69-cip17
Message-ID: <aY8UZpBealEWp0/3@duo.ucw.cz>
References: <TY7PR01MB14818948CDCC24C4DE8F193D0CD61A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <e3ba1e13-a952-4e32-9893-040801f3edeb@siemens.com>
 <CACe6DC5LCgdoPRddKHO+KwnDw6MSaFCfKHmZPb7R1TNyQhSfqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UNH7dNIsgSGmcKLO"
Content-Disposition: inline
In-Reply-To: <CACe6DC5LCgdoPRddKHO+KwnDw6MSaFCfKHmZPb7R1TNyQhSfqA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Feb 2026 12:09:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21873


--UNH7dNIsgSGmcKLO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > CIP kernel team has released Linux kernel v5.10.249-cip69, v6.1.162-c=
ip51 and
> > > v6.12.69-cip17.
> > > The linux-5.10.y-cip tree has been updated base version from v5.10.24=
7 to
> > > v5.10.249, the linux-6.1.y-cip tree has been updated base version fro=
m v6.1.159
> > > to v6.1.162, and the linux-6.12.y-cip tree has been updated base vers=
ion from
> > > v6.12.66 to v6.12.69.
> > > This release includes updates for Renesas ARM64 SoCs. Please check th=
e following
> > > information.
> > >
> >
> > Thanks! Did you also trigger the tarball generation, and is just
> > kernel.org a bit slow to perform them?
>=20
> Hmm, that's a bit odd.
>=20
> I am executing the tar generation trigger  with git push.
> I just confirmed that the trigger was running.
> I will wait a bit, and if the archive is not created, I will ask to
> admin.

Normally, they send some kind of result over email.

Best regards,
								Pavel

--=20
In cooperation with Nabla.

--UNH7dNIsgSGmcKLO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaY8UZgAKCRAw5/Bqldv6
8v8rAJ9t99BhyojAiXNQDhnNIpCSuslqjgCePDnahL9iqfKJ/IjAaHxvzgDG2oo=
=CoPt
-----END PGP SIGNATURE-----

--UNH7dNIsgSGmcKLO--

