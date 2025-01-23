Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2664C02182
	for <webhook@archiver.kernel.org>; Thu, 23 Jan 2025 15:16:31 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.13019.1737645382100458397
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Jan 2025 07:16:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=GFvVwtVS;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 877D11093CD95
	for <cip-dev@lists.cip-project.org>; Thu, 23 Jan 2025 16:16:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1737645380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+YhzXR1estek+nw0oM5GzF43gcCQe95n+gyEclwhdHU=;
	b=GFvVwtVS0/jOkgrqVBcW/EgbZ2JBd6zRXQUQTzWQ0vnBlZuAkjmO4m5JFcdXwagblBj/Wr
	ecAKbmD4OQfOJBnexJNsUxq4e8ZurfqAArS92W7myHxJty8susepJ+p7UeVmO5UsYNxS/U
	qkAM8WwzPzLzTCe7A/AehUtPFa6y8lP2z2dERzkzJlVt6LBqqluAmHMC1NeMy9EVNmA1Zk
	axDUkdjeh74sub5zpGLPCKbzDgI0O9cCVsuWolrqlPiajjNQkZe+W3pYQ+Ks8c424q1slD
	mQ1dT43Uk2BxByaOc5NvcE9Hir5i/I9XLEuSnDHFfoWERiBlK3lf4kDy24ZHCQ==
Date: Thu, 23 Jan 2025 16:16:09 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
Message-ID: <Z5JdOQSUmbFdWR0B@duo.ucw.cz>
References: <137e2abc-e5fd-4050-9471-6f27d33c6983@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VHvRQEsPKZIBe5nS"
Content-Disposition: inline
In-Reply-To: <137e2abc-e5fd-4050-9471-6f27d33c6983@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Jan 2025 15:16:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17609


--VHvRQEsPKZIBe5nS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The IRC meeting is scheduled to UTC (GMT) 13:00:

Battery died at the wrong moment, sorry about that.

6.1-rt: I asked on the lists at Jan 17, and no response so far.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--VHvRQEsPKZIBe5nS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ5JdOQAKCRAw5/Bqldv6
8royAJ49YgSq0uoEEoAvQF2XhDukz3kq1gCfQGBqAQEdhlBJdmicYE2epEYjGaU=
=+GRo
-----END PGP SIGNATURE-----

--VHvRQEsPKZIBe5nS--

