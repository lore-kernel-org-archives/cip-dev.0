Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A051C43458
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 09:26:29 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.65556.1782984382405788085
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Jul 2026 02:26:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=UcY5SINT;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B7641189A4;
	Thu,  2 Jul 2026 11:26:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1782984379;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=J0z0V+3EDQmMysp8T8SEAGW/9XHQVvg1b8TVHJeQXjo=;
	b=UcY5SINTfMNXoB8deKav6/8qi/IFWnlEgZdVZBfD1whF6faySAYRdxVudOSn9AoaaAcanx
	4c+Dr2WRpD2aFaAMvbPKYa5wvblBbfqfHkeQ0bQYXNCdDfRvc62MGVKs7lEEarf1am+xu9
	/+yrTtrTYFZc3Rq3Wde7VJKZ9HgQ3ZQNOuBYekGu+Qf+LNaHsIepdwMnoIS1lf01X0pFWa
	A4UcKLgvU2uSNDFH8KvHFaVI160S0DyhvLVB5dxQP1vMy7Q/5wD0nT9nE7mcs/bjIIZAiP
	KrTuic0Av3GvHmYZAD/A5nhs/xyY3WB2JGCTcAYg5++astDYOshq8WD13T9b4g==
Date: Thu, 2 Jul 2026 11:26:15 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Ulrich Hecht <uli@fpond.eu>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: CIP downloads not available
Message-ID: <akYut-FQ0Ic8TE5I@duo.ucw.cz>
References: <cf44e61a-f46a-43c3-ad2e-10efe82f2bcd@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X0N1KRI/B/czRQRb"
Content-Disposition: inline
In-Reply-To: <cf44e61a-f46a-43c3-ad2e-10efe82f2bcd@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Jul 2026 09:26:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23378


--X0N1KRI/B/czRQRb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> https://cdn.kernel.org/pub/linux/kernel/projects/cip/ -> 404
>=20
> We are getting complaints that download links are not working, and it
> seems that our as well as other's content is gone right now. Known
> issue? Has anyone heard more about that?

Problem starts at "kernel" subdirectory -- it does not exist.

https://cdn.kernel.org/pub/linux/

Not sure how this is supposed to work. I guess we could talk to
Konstantin Ryabitsev <konstantin@linuxfoundation.org> if we are sure
it is not our problem.

Plus I'll ask you to update your addressbook to pavel@nabladev.com .

Thanks and best regards,
								Pavel

--X0N1KRI/B/czRQRb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCakYutwAKCRAw5/Bqldv6
8isCAJ41+UMLUlKPDhlgXl+1pCcxe4JmxgCcCOjm9aYHbafzueNOPsggq6f6tNU=
=wlYS
-----END PGP SIGNATURE-----

--X0N1KRI/B/czRQRb--

