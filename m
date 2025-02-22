Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F4BC021B2
	for <webhook@archiver.kernel.org>; Sat, 22 Feb 2025 09:38:02 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.43470.1740217069333891343
 for <cip-dev@lists.cip-project.org>;
 Sat, 22 Feb 2025 01:37:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=EW+Nd508;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CFC9A10382D37;
	Sat, 22 Feb 2025 10:37:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740217066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ncCIJ5VXDlpkWW1QpHLzM4JOwCVY1jtpgSZIC0TSSk=;
	b=EW+Nd508+gG4QA41rdQhxui0odCFIA7NlUdm8NVUq9BFXHpOv5Lfowhf7Fd2tsomteUVkr
	3/UguWgm67O80RMZHUC+vnI8ygws+peRimHMm1UMzRwMdKwSCHaXDjQSztXx8Oe3uqYDYv
	WoqxjnCo9KYlS1/ZBShDRtqFsgV32khe3j4n1GKk/Y682GP1Ig6jXNEZcLvRDyyCnpyBRT
	/rgjAYES9zxBnkh/nz87o/Xvp1sCdN6jlL/O0V3ZFDjwihMLUsepUW97g1RSM3Qn42GgC6
	ujDCnjpi/OBt+GWL+I6uvpkpwYl64CEfOEOc0zbiVqICel+A2iG5b5PSbpvpaA==
Date: Sat, 22 Feb 2025 10:37:41 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Ulrich Hecht <uli@kernel.org>, Liam Howlett <liam.howlett@oracle.com>,
	Michael Schmitz <schmitzmic@gmail.com>,
	linux-m68k@lists.linux-m68k.org
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] m68k: Add missing mmap_read_lock()
 to sys_cacheflush()
Message-ID: <Z7ma5eOlH/k0fgRg@duo.ucw.cz>
References: <9a7bb5ad805dbb1c8a67186f04500474@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ji6PU0ROc6dS4AYz"
Content-Disposition: inline
In-Reply-To: <9a7bb5ad805dbb1c8a67186f04500474@linux-m68k.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 22 Feb 2025 09:38:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17882


--ji6PU0ROc6dS4AYz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Liam Howlett <liam.howlett@oracle.com>
>=20
> [ Upstream commit f829b4b212a315b912cb23fd10aaf30534bb5ce9 ]
>=20
> When the superuser flushes the entire cache, the mmap_read_lock() is not
> taken, but mmap_read_unlock() is called.  Add the missing
> mmap_read_lock() call.
>=20
> Fixes: cd2567b6850b1648 ("m68k: call find_vma with the mmap_sem held in s=
ys_cacheflush()")
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Link: https://lore.kernel.org/r/20210407200032.764445-1-Liam.Howlett@Orac=
le.com
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> [ mmap_read_lock() open-coded using down_read() as was done prior to v5.8=
 ]
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>

Reviewed-by: Pavel Machek <pavel@denx.de>

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ji6PU0ROc6dS4AYz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ7ma5QAKCRAw5/Bqldv6
8u/vAJ9qOVJI0MPfFxAt62PyEU0K070FDACfadxlw8QUGUAdS0eLF3gN6HYg2sk=
=FutO
-----END PGP SIGNATURE-----

--ji6PU0ROc6dS4AYz--

