Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4158EEA867
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 22:18:17 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.57898.1770934696441857756
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Feb 2026 14:18:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=d05GVzee;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1BE46110763;
	Thu, 12 Feb 2026 23:18:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1770934692;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=LEV00m9fmgDRCkHSLpoqsHFpOkkmInoFm2hsTABTOeM=;
	b=d05GVzee9LhSDOEsVGgprpyB+ma5taPk1jd+GqBM6lydbpIgT6ZzSncishOhNszUYeSRbp
	ClNQdyj5+ABpHZt8ZdW+umi0oc1F7mW2AalH0IgYIdfnu9I+mZ7zCENvysyW7AkKidMXti
	uWsMWrAiAFsICSlgR9ylGJ4GBuUGdpV12vPLcSkwueQO32/CXY9bPVxh33cGZQOp9ewnWE
	8k8tHiLUUixN2C7RXxMgrnc8zt4ZskosnjJUSwbTrvjaqHiOMTFan4UIRnXkqdO7OpDAiU
	WYEGIl9B+XsBr/3XZqGF6BS0WpJBhfK3eiWqm5+yn9FSP67CXpicT/2mcX8mkA==
Date: Thu, 12 Feb 2026 23:18:10 +0100
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com
Cc: cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
Message-ID: <aY5RormTOkKVniEE@duo.ucw.cz>
References: <0840ad9a-685e-4c3a-9259-411aa05be85f@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RM9rrCTxqj/9/wLB"
Content-Disposition: inline
In-Reply-To: <0840ad9a-685e-4c3a-9259-411aa05be85f@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Feb 2026 22:18:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21867


--RM9rrCTxqj/9/wLB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
>=20
>     irc:irc.libera.chat:6667/cip

Sorry, my connection failed in the middle of the meeting. I'll go
through notes and likely send a separate email about -rt maintainance.

Thanks and best regards,
								Pavel
--=20
In cooperation with Nabla.

--RM9rrCTxqj/9/wLB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaY5RogAKCRAw5/Bqldv6
8gR/AJ0adUbhIy6GL31Leo8ccBc0Z5YiNQCeKunFX8c377SK7WtO4GClAEa8Ad0=
=EVU3
-----END PGP SIGNATURE-----

--RM9rrCTxqj/9/wLB--

