Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44495E7BDB4
	for <webhook@archiver.kernel.org>; Mon, 16 Feb 2026 12:30:22 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18539.1771245019263596850
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Feb 2026 04:30:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=HHifId7u;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AFD6F10E4FC;
	Mon, 16 Feb 2026 13:30:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1771245016; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=EyHtMiqS1Ths0Kq33voww8eBKj+YxW7YFlDoqp8hCi4=;
	b=HHifId7uw+FP0uID6Mfbe57KeSPw6781g6WNxOr9dUwF82oCaMgtXNIroF6xUK+TtrOCFK
	idRTm2ZLK0LYItLZvruq3avTx2BJvMDslDOW7c3oUhJQbqU1bAVLGcvQ0lobl/MAm4FImY
	a/zIYlB1MXLsfq+J9wm8nR5pqKFCLfabDtEhd1L+eUGcLexgQaA6ZZSl6y4iCAa3TG2a61
	OyrODIPgJL1Jhl/CtaG7sURWUW+pLWFVMVA59AL2Oy07Q5VkpBuGHGYQQ9oITaJqsXixbL
	gMeslPzkmeNcwO5fWr3ju96nFO/DFBWup8zUdo6vawV8UGmGtxFhEZSojiIc/g==
Date: Mon, 16 Feb 2026 13:30:13 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Chris.Paterson2@renesas.com, cip-dev@lists.cip-project.org
Subject: Something wrong with stable-rc testing?
Message-ID: <aZMN1SgBFLYJt5Oe@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SYhvHdZ1ug44l75G"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Feb 2026 12:30:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21880


--SYhvHdZ1ug44l75G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

There's something wrong with -stable-rc testing, see

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/2=
324617201

I tried clicking around the results, and I see:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/131237=
64183

Something went wrong with SQUAD watch job submission. SQUAD returned:
86
23:42:49
SQUAD URL: https://squad.ciplatform.org//api/watchjob/linux-stable-rc/linux=
-6.12.y/6.12.72-rc1_4b487d46d/arm64_renesas_defconfig_r8a774a1-hihope-rzg2m=
-ex
87
23:42:49
SQUAD Backend: cip

squad url does not load for me.

Can someone take a look?

Thanks,
									Pavel
--=20
In cooperation with Nabla.

--SYhvHdZ1ug44l75G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaZMN1QAKCRAw5/Bqldv6
8n54AKC2L61avcRMVluLMEXbZsWFts3qZwCgtRrNC8nP5Jtqhl8/oOac6s5JUr8=
=ktl4
-----END PGP SIGNATURE-----

--SYhvHdZ1ug44l75G--

