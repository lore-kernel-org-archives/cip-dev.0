Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6986C61DD3
	for <webhook@archiver.kernel.org>; Thu,  3 Sep 2026 19:33:57 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73.1788464029602492919
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2026 12:33:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=a79IDpSV;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0844111C2CC;
	Thu, 03 Sep 2026 21:33:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788464023;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=nokiNR/S1nICzG6YRb238URLehOa1cxu1amu9hloEwU=;
	b=a79IDpSVYi4EGnrPcOewvvqTTSkJef3rEe4RJasdLpo9icT7Jm6KVlV6wY58yU3vhK2wCw
	LGUjtoh2HnrdJJHfQaI5TWya4MmJVeYaTp2EE7aCJuob6Tlrrji4K7ZkTQmsBlvX3PtF6P
	hmoYkzZ4rB3B2oAKW4bADDxI/hptZgRnfamD1pBGm78axHhrqcD/cvkP9S+wAaVD2WWIVo
	VG6EhZarpPcju+439iCJ9TVfPcap80Lgja7q6ycobLN0Cnij2W8ENl13K9YLMj6T1rl2rI
	GaTUuNJwP/RdaEspwgwrC4RY0WtBaso94AYdonKOWsL9T18AfIAe57zMhqF7bg==
Date: Thu, 3 Sep 2026 21:33:41 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.1.y-cip 00/11] Add ICU error and software interrupt
 support for RZ/V2H and RZ/V2N
Message-ID: <apnLlQHI3mfDjz7V@duo.ucw.cz>
References: <20260902092353.24648-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7MsV2GHgvwnjjxKw"
Content-Disposition: inline
In-Reply-To: <20260902092353.24648-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Sep 2026 19:33:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24092


--7MsV2GHgvwnjjxKw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds support for error and software interrupts in the ICU
> driver for the Renesas RZ/V2H and RZ/V2N SoCs.
>=20
> Patches were cherry-picked from mainline kernel.

Thank you, applied.

Best regards,
								Pavel

--7MsV2GHgvwnjjxKw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCapnLlQAKCRAw5/Bqldv6
8qN6AKCnFgrT1DMa5bu/c/Ze7WdynEY9AgCfRYxYMHWoru/wTmLCeh3jfmgeAT8=
=oYiB
-----END PGP SIGNATURE-----

--7MsV2GHgvwnjjxKw--

