Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8D8C5B56A
	for <webhook@archiver.kernel.org>; Tue, 11 Aug 2026 12:30:17 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.53004.1786451414982066288
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Aug 2026 05:30:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Y3wo3i4f;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F21D011BA04;
	Tue, 11 Aug 2026 14:30:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1786451408;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=vx4hijFdw7NBRbUDqSy4T6buAf5p7ncFkMOf+gUrdmo=;
	b=Y3wo3i4fp2keFn6UQ1yaTRR8j3XO+4jNUgSE9+gGBlIVUwQEP0484VhzzSWm8PVbTINyAB
	h4FTKponYVUIwMTaqqaVa44ivJNH/fQBO0PegQP2CyCTB1K+RPz3YTAMUWymMMiUZuwwci
	RlojgblbEZrac2kIJP45nk+T/7W8aM8tHKq8bhec99bqTp8db8dM8PkYXE+t+dc9pcsjxN
	Uod5MIAHD9NeTceZK67axmFanoFUKnHuXDvYWHNHhV7A+DDUIQU+mahHa9OTVDSPtZbQu0
	1lbyqLyyGtsNdhmLF72YRKMUjD+nXLm3PM3fHco9MRUNb+Ug72tYTE1i5jjLCQ==
Date: Tue, 11 Aug 2026 14:30:06 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Regina Nkenchor <rnkenchor@linuxfoundation.org>
Cc: cip-dev@lists.cip-project.org
Subject: Re: CIP TSC meeting today?
Message-ID: <ansVzqROFs7pBmUd@duo.ucw.cz>
References: <ansDfyfjUgGYHWMG@duo.ucw.cz>
 <CAJcAxAPae4NT8ZoETMhNFu2nb+VPceL0j6UkA0cPxOotEigxUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/HD5UTHA8T2LMjX3"
Content-Disposition: inline
In-Reply-To: <CAJcAxAPae4NT8ZoETMhNFu2nb+VPceL0j6UkA0cPxOotEigxUg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Aug 2026 12:30:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23898


--/HD5UTHA8T2LMjX3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Yes, the CIP TSC meeting is scheduled for today at 1:00 PM UTC.

That is in 30 minutes from now. Would you have a link to corresponding
Google docs / Zoom bridge?

Thanks,
								Pavel

> Best,
> Regina
>=20
> On Tue, Aug 11, 2026 at 1:12=E2=80=AFPM Pavel Machek <pavel@nabladev.com>=
 wrote:
>=20
> > Hi!
> >
> > I have just got email from Regina "Regina Nke Reminder: CIP TSC
> > Meeting =E2=80=93 Tuesday, August 11, 2026 at 1:00 PM" . But my notes s=
ay no
> > TSC meeting today... So which is it?

--/HD5UTHA8T2LMjX3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCansVzgAKCRAw5/Bqldv6
8ll5AJ0c4XoFnOTFNvFvm5d2F3Ajxq5kuACeM5kuLASx0ecfSRY5KyPMtEu9G/c=
=hVmM
-----END PGP SIGNATURE-----

--/HD5UTHA8T2LMjX3--

