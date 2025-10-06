Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A0ACCA471
	for <webhook@archiver.kernel.org>; Mon,  6 Oct 2025 14:53:59 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.35824.1759762433901477537
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Oct 2025 07:53:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=QTdL5J9Y;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 808C4103A8400;
	Mon,  6 Oct 2025 16:53:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1759762431; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Fd8AK5FG5V2hvMCV0+802I9GeYpXSCAgCiIoYQtyAS0=;
	b=QTdL5J9YHC6vvh0pFqdV2W+EgZgYPTg9Et2Am2Yik5tx5zbTXH2AFNLU3UnFtCfIpBbxK7
	NhOZsOVGWdVEMjEVEsjYII5U5omx7T2V0JAifxyt4qiZszQVY86BNN7HbuvRgV3nQOGbgE
	2YUym0ss+0EBFoSlu/qDQgF7EFvJHydZqxzmFczGX3W5vb2u2rAENlA/WprwYXmffrl6uO
	AYQsK8+qugI1b35q/TXMmwXhoVkKQs8hr/RgIKp3p1Tb24xh8JBYCRVHGgyMUhoMM42H27
	Rt0ALiHQ2Jd6Pg18cc7gs92vonOJUsmXeglw+IWajpv8fuS869CI4YJFONdDKA==
Date: Mon, 6 Oct 2025 16:53:47 +0200
From: Pavel Machek <pavel@denx.de>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: cip-dev@lists.cip-project.org, Jan Kiszka <jan.kiszka@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: Re: Question about git history - linux-5.10.y-cip-rt branch
Message-ID: <aOPX+z+Bdg05IDDv@duo.ucw.cz>
References: <a4d4c0af30fac7d969772bc80f8bfc1163c8d0d1.camel@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OfI4/Qv1ME4YeE1l"
Content-Disposition: inline
In-Reply-To: <a4d4c0af30fac7d969772bc80f8bfc1163c8d0d1.camel@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Oct 2025 14:53:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20160


--OfI4/Qv1ME4YeE1l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> in the git history of the linux-5.10.y-cip-rt branch I see
>=20
>=20
> HEAD
> ...
> 502b544c ("Linux 5.10.240-rt134")
>          tagged as v5.10.240-rt134
>=20
> ff0116cd ("Merge tag 'v5.10.240' into v5.10-rt")
> df639ede ("Mark this as 5.10.239-cip62-rt27 (rt133) release.")
>          tagged as v5.10.239-cip62-rt27
>=20
> c9ee35a3 ("Merge tag 'v5.10.239-cip62' into linux-5.10.y-cip-rt")
> 081888d8 ("Merge tag 'v5.10.239-rt133' into linux-5.10.y-cip-rt")
> d5eca7eb ("Linux 5.10.240")
>          tagged as v5.10.240
> ...

I'm not sure what "between" means in git.

> Why is there a .239 tag between .240 tags? Is that really intended?

If anything went wrong there, it may be too late to fix it now. But I
don't see anything obviously wrong there. Order of git commits in the
log can be unintuitive. Can you explain what problem do you see?

(If tag was not matching corresponding Makefile or localversion-*,
that would be clear problem for example).

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--OfI4/Qv1ME4YeE1l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaOPX+wAKCRAw5/Bqldv6
8nFLAJ9FtUbrGTyAyQ/Vcd1ceYLmelDFOQCgj5Oa14SL2M47jaicQTrR/1C3Vtk=
=MUhT
-----END PGP SIGNATURE-----

--OfI4/Qv1ME4YeE1l--

