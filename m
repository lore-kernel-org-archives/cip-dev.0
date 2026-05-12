Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554ABCD4855
	for <webhook@archiver.kernel.org>; Tue, 12 May 2026 08:01:13 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.70729.1778572864900442969
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 May 2026 01:01:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=d+G5n2OH;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C0B5610A112;
	Tue, 12 May 2026 10:00:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1778572858;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=g+Zpf94C06g6DHzAxc3e8gDQbhna4u8G4j+iQusXqrI=;
	b=d+G5n2OHHVulgWYFrVkVx5olQnM3hfkHEVJpvxhcZecOQ2V5JR/og+tL5MU/dY7O5i7dTn
	CvPFZKuXlXetbh8h2GTjwT2Z/pKVxVYKF2/iVvrsnRk6er7BXRJ8V7HLaRfsOFf75JX73M
	qAspFQKNIxnwoMjxRLvGNYHq8E2LCwyL4K/Kci84jPse3K+JsqJHzB0LWsxbKgzNWibiI2
	T2Ly/M3oCOL2Y/L10k//XpPrQRgLxtra74s+P2Yg3KyJW4mTuv5XhCmM49VT+C2ywbqulb
	BWBVFnranMpWI+vWcIkVkauu0/0EY29aeaTEaW/m8+ZIMmidz9f0m8a7KP07IQ==
Date: Tue, 12 May 2026 10:00:48 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable@vger.kernel.org, Bryan Brattlof <bb@ti.com>,
	Daniel Wagner <daniel.wagner@monom.org>,
	Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 0/4] ARM: stable backports
Message-ID: <agLeMIrCfFVypBav@duo.ucw.cz>
References: <20260511135357.2786242-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GN9Z98QuV/CIH4vB"
Content-Disposition: inline
In-Reply-To: <20260511135357.2786242-1-bigeasy@linutronix.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 May 2026 08:01:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22926


--GN9Z98QuV/CIH4vB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is a backport of ARM related fixes. This applies cleanly to v6.18
> and v6.12. I have an updated batch for v6.6 and v6.1 because this does
> not apply cleanly.
>=20
> #1 and #2 are prerequisites for #3.

People often use stable-dep-of: header for that.

> Can't tell the origin of #3 (fix hash_name() fault). It might be there
> since the begin of time.
>=20
> #4 (fix branch predictor hardening) fixes commit f5fe12b1eaee2 ("ARM:
> spectre-v2: harden user aborts in kernel space") which is v4.20-rc2.
>=20
> If there are no objections I would post the v6.6 version once this is
> accepted and then rebase the PREEMPT_RT bits on top of this.

I don't see anything obviously wrong with the series.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
								Pavel

--GN9Z98QuV/CIH4vB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCagLeMAAKCRAw5/Bqldv6
8k4YAJ9h+PIe12p8Y5G7mPqKrlzzi6zhpwCdHbIPkY4dhb3ey2X1jYYYNCqOguo=
=B6hv
-----END PGP SIGNATURE-----

--GN9Z98QuV/CIH4vB--

