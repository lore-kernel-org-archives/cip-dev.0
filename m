Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19718EA7943
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 19:33:05 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3491.1770233579541023348
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Feb 2026 11:33:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=IzI2S6wz;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C1B1D10EBE0;
	Wed,  4 Feb 2026 20:32:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1770233577; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=oTjlNIVhtQmwbJiuAYD6laURZl5gPO5GyQxbD+YrWj0=;
	b=IzI2S6wzFQdkf3ILAxYXqZFuA8CqpCPBZ4IYMYgosR4zzHXLD3iy4/hidrzzsqybqwJQCw
	xIfugkg9oHAoqx2tkwpUqbL/Zyl+qkTpTLt6wagkZw+xn5rMRaFMg60S8zGR8wyXJ5goh7
	dsDVkCJple1K34tJu8jgAftRe0Q02KUmlcfvn7lWChLZZrKjPb2Jhi5puYo6eg1abBaNwS
	HvthaTHRMJRGDxWcdQ/45Tqt5A+Xn3ceNrd2QlkkpU31Pqp7HgxFBNv97J7r5koFyAzov5
	okhSEKN4kVq25XU+ChEBfIlyb/BlzejpbLeG2AQ341apLRgiN2FVz3AM8pBT9Q==
Date: Wed, 4 Feb 2026 20:32:53 +0100
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v4.19.325-cip128-rt46
Message-ID: <aYOe5Yo3z96vszh4@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h8zMIhtJHYJ38MsZ"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Feb 2026 19:33:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21826


--h8zMIhtJHYJ38MsZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel

--=20
In cooperation with Nabla.

--h8zMIhtJHYJ38MsZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaYOe5QAKCRAw5/Bqldv6
8qGNAJ9ny9XUGV8cxyIQEVOt47Nf+GG7eQCglL4VkoB4JQJbcMYGbJHyFDFu9X8=
=rtx9
-----END PGP SIGNATURE-----

--h8zMIhtJHYJ38MsZ--

