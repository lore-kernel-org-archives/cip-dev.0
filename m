Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65568F3ED5C
	for <webhook@archiver.kernel.org>; Mon, 13 Apr 2026 11:29:30 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.270190.1776079763917117933
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Apr 2026 04:29:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=jCwRMOcQ;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9F738112A0F;
	Mon, 13 Apr 2026 13:29:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776079761;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=EgPsCeolapBWlrwh+a96kx9m5lxSGUaxvzVHh6KP9eI=;
	b=jCwRMOcQ2i+zrLki9m1hBWIOT+vCvTbVG/ei2W2keBRcMe9Vh0p5/rJIFF3aUJHwBJ7rFb
	fNIJh+lJiPLZ7eyzWmfnhDB97ab9aEb1M8s8W1KJxTEkduyQEIgDGSrkULDvWRtRzDtI5t
	CfbuXlIj1I9UUM8ligudkZ964X0dItGfveT4GblBMGdHiOEym891ebqapaqDvrCJgZU2TZ
	oDt/AvLnAEA9Epund3tfx9MODSln/Kw8S4i9L6/74P9GIzIYPi9fZHBzPLEys/JU2fNweS
	q4e8AHFyMRqBMahGxtIrIUo+sQoC4EUpHqChmX/34QAiH/XTSgLcFc+yE58ysg==
Date: Mon, 13 Apr 2026 13:29:17 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Ulrich Hecht <uli@fpond.eu>, "pavel@nabladev.com" <pavel@nabladev.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: [ANNOUNCE] Release v4.19.325-cip131
Message-ID: <adzTjVKf34vhQw__@duo.ucw.cz>
References: <459507685.15146.1775979436923@webmail.strato.de>
 <52d1c70f-ac3e-4f4c-9593-c20f08d60e9e@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gJQyLRm17++WtYeo"
Content-Disposition: inline
In-Reply-To: <52d1c70f-ac3e-4f4c-9593-c20f08d60e9e@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Apr 2026 11:29:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22680


--gJQyLRm17++WtYeo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > the CIP kernel team has released Linux kernel v4.19.325-cip131. The lin=
ux-4.19.y-cip tree's base version has been updated to v4.19-st15. The trees=
 are up-to-date with kernel 5.10.252.
> >=20
> > You can get this release via the git tree or as a tarball from https://=
mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.19/
> >=20
> >   v4.19.325-cip131:
> >     repository:
> >       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
> >     branch:
> >       linux-4.19.y-cip
> >     commit hash:
> >       7aeff6c7984c582f96916d12bd33eefbd746459c
> >     Fixed CVEs:
> >       CVE-2025-39889: Bluetooth: l2cap: Check encryption key size on in=
coming connection
> >       CVE-2025-71239: audit: add fchmodat2() to change attributes class
> >       CVE-2026-23241: audit: add missing syscalls to read class
> >       CVE-2026-23243: RDMA/umad: Reject negative data_len in ib_umad_wr=
ite
> >       CVE-2026-23273: macvlan: observe an RCU grace period in macvlan_c=
ommon_newlink() error path
> >       CVE-2026-31411: net: atm: fix crash due to unvalidated vcc pointe=
r in sigd_send()
> >=20
>=20
> Looks like we are phase-shifted on 4.19 between regular (-cip131) and RT
> (-cip130-rt47) again. Was there a particular reason for timing things
> like this?

Sorry about that. As far as I can see, we have few options here.

a) Release new v4.19.325-cip131-cip-rt in next few days.

b) Do an v4.19.325-cip132 in May.

c) Do nothing special.

I believe we can stay with c), but can do b), too :-).

Best regards,
								Pavel=09

--gJQyLRm17++WtYeo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCadzTjQAKCRAw5/Bqldv6
8td8AJ9Lsu/tDIe67ETYLTVkBaP5P5cGiwCgwJ1i9yGZgtKJbQrOCDwqjYzlT6Q=
=dQIh
-----END PGP SIGNATURE-----

--gJQyLRm17++WtYeo--

