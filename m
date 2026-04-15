Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37328F531E8
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 21:06:40 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5694.1776287191047757097
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Apr 2026 14:06:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Oly2JmIv;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C9F7A113EDA;
	Wed, 15 Apr 2026 23:06:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776287184;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=H+yYLHeb/oeCD9KqtWzIxnvhrta64yqWsByplSQ6w4A=;
	b=Oly2JmIvFYmAb7XvQzBo7/d5B16AUZQ0UzxavurYFc4un5YLQ8XXNABWrD5+909cycpDbW
	iD03qyrHoxsfCO9megoRn/9QUcyXjFQ3wATB5SYgPDjwz5zgFAb9+i2wE1yDeSxh2iqsqZ
	IVFsSuqo5YoI57+wMqL0O5SiT4WiGfpLX1F4BuoK/xORUCEQ9GaCDqgxDtWAq6XiuIMZEo
	5TdRqVF46QLNGBvPjelIE+SEFS+D91Vni3qfaA9pIpfE7uZ39SgEAU37UJptX1FppGh/g8
	ZGaiYCqd1Abn3qxmXlHIaBaSsRNmArHMr2YFk88CF1Qq9INcTQ2mmvvYOC9OEA==
Date: Wed, 15 Apr 2026 23:06:21 +0200
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: pavel@nabladev.com, jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com
Subject: Re: [cip-dev] [ANNOUNCE] v6.1.167-cip53-rt29
Message-ID: <ad_9zRkp9GfBhk1I@duo.ucw.cz>
References: <ad1FXBucvcGYi9wc@duo.ucw.cz>
 <TY7PR01MB1481834575A4B8D42F262AA35CD222@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P+9GdWHr/AIsJStS"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB1481834575A4B8D42F262AA35CD222@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Apr 2026 21:06:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22731


--P+9GdWHr/AIsJStS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Thanks for the release!

> > Subject: [cip-dev] [ANNOUNCE] v6.1.167-cip53-rt29
> >=20
> > Hi!
> >=20
> > New realtime trees should be available at kernel.org.
> >=20
> > Trees are available at
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?=
h=3Dlinux-6.1.y-cip-rt
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?=
h=3Dlinux-6.1.y-cip-rt-rebase
>=20
> There seems to be an issue with the -rebase branch.
> Could you please check it?
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2450200=
450
>=20

I double-checked and trees seemed ok. So I hit retry on the test, and
now it passes.

I currently push rebase tree, first. Maybe that triggers the test?

Best regards,
								Pavel

--P+9GdWHr/AIsJStS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCad/9zQAKCRAw5/Bqldv6
8qEkAKDBYSVIksiWPCWRLcRnx9XXWUB/qQCgklMZf9nYHgPoLzjLPUPax9OdOw0=
=5oiw
-----END PGP SIGNATURE-----

--P+9GdWHr/AIsJStS--

