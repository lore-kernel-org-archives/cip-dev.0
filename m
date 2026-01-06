Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A51C47BE0
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 10:08:37 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.87010.1767694109410413521
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 02:08:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=JI01MYBV;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2D2F9109907;
	Tue,  6 Jan 2026 11:08:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767694107;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=vwu7lHFABWfp/NQ+snWFLpyACsEYtFGlgt66vEs+qes=;
	b=JI01MYBV8WbVs2RdUbuqMRSFyK5KpMuSHo6y8Re1duJ3Zey/AYDKgymmKsBVxbBofD9qdq
	u+S1Iv28xOb90QPtSVnj1YgL0v2nmkrAJaOBqMcVl4BiXtYZBrwAPVeZc1h3narBRuvUIT
	d6KVbVx2g/inwKG9LNlZLunamFRcB/bYXDet7IoIL6eGK345GCMvGt7uuEEZt/14IUoXbU
	iFR0OzH0u9YDRhtwPaAP5B43dUSgnZ1caPmdNarTJyt81kH8ESSqmWbv3F6LbgvBQ9M/zD
	TPlQM6/7qVWJRxtQ0ENS86/2PlXjDtFZE4ra+ImBYN2dM2+JiN4Gi0C8FNB3+w==
Date: Tue, 6 Jan 2026 11:08:23 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 5.10.y-cip 0/7] RZ/G3S: Backport TSU support
Message-ID: <aVzfF3jHBtbABaBp@duo.ucw.cz>
References: <20251217103149.4182935-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jQMrYDzzMJkTieZF"
Content-Disposition: inline
In-Reply-To: <20251217103149.4182935-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 10:08:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21324


--jQMrYDzzMJkTieZF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports the TSU (Thermal Sensor Unit) support for RZ/G3S.

Thank you, applied.

Best regards,
								Pavel
--=20
In cooperation with Nabla.

--jQMrYDzzMJkTieZF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaVzfFwAKCRAw5/Bqldv6
8lfIAKCiwMcCrjwvQkfnQMsB0VXtApsbZACeN/kpYeQfYAkmDheP/pljAdS6F3Q=
=jvhQ
-----END PGP SIGNATURE-----

--jQMrYDzzMJkTieZF--

