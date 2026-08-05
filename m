Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABB6C55174
	for <webhook@archiver.kernel.org>; Wed,  5 Aug 2026 08:47:04 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.36161.1785919616885064421
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Aug 2026 01:46:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=iPnr3Avk;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 63A0311A57F;
	Wed, 05 Aug 2026 10:46:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1785919610;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=T+jGzXs6yClfqcryuzmHZQePe9LqHJJowWR9hNDzoXA=;
	b=iPnr3Avk0On2Q4JYuR9jb9yzJQYhId6taquxSHPHI98ormxx5HNuDrsQsMIKEyhL5BDngw
	2zwC4RQdBhHLtqtrVCPNz3BFuPN6oUc1Hjch75LzxHt/VJF8IpOtgTHPxB9iS5C0nzpawK
	cLcxI7gOT6dF5u6GvSMRgGmGva1FRoNt7/uWobQ8t5XpdWumD8CO/KuUpPEScXFUvCMFed
	SQDdSmUp2aUKbcxrQPAhEmHj0jklaCRPp+P+xsK/aXyTIcdaOiWyYJxxJPB8QF/LBCZX/G
	k4EHmO0s+Er7XBvJ5ridYVwiKeUO2UY8r/33Xiu2CF/mSZ1F+cYk4o0SC2lszg==
Date: Wed, 5 Aug 2026 10:46:47 +0200
From: Pavel Machek <pavel@nabladev.com>
To: whyshall.dev@gmail.com
Cc: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [ANNOUNCE] Release v4.19.325-cip135
Message-ID: <anL4d800j3arkffa@duo.ucw.cz>
References: <1672269011.888387.1785850990322@webmail.strato.de>
 <1252941.1785911162738531742@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v266rhOBmk5gbOpb"
Content-Disposition: inline
In-Reply-To: <1252941.1785911162738531742@lists.cip-project.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Aug 2026 08:47:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23867


--v266rhOBmk5gbOpb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>=20
> I understand that the CIP project addresses vulnerabilities in the Linux =
4.19.325 base kernel and releases updated versions such as 4.19.325-cipX, w=
ith the latest release currently being 4.19.325-cip135.
>=20
> Could you please let me know:

We don't really have answers to these questions. Due to low quality of
recent CVE entries, we don't track them closely.

> How many CVEs relevant to the 4.19.325 kernel are still unresolved?
> How many of these CVEs are expected to be addressed in future CIP release=
s?
> Is there an estimated CIP release number (cipX) by which all relevant CVE=
s will have been addressed?


Best regards,
											Pavel

--v266rhOBmk5gbOpb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCanL4dwAKCRAw5/Bqldv6
8ib6AKCcHvxxEPp9tMYjCnmzuAuxB2L1kACeJ1bkKq6SLetnrbOBxTSyUhw4ohE=
=ZM8/
-----END PGP SIGNATURE-----

--v266rhOBmk5gbOpb--

