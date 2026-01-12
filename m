Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F68CF45C1
	for <webhook@archiver.kernel.org>; Mon, 12 Jan 2026 18:12:05 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39740.1768241516053990094
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Jan 2026 10:11:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=eIJa3dI7;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 543EE1088E7;
	Mon, 12 Jan 2026 19:11:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768241513;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Fsa0SHxGg+UMMQXFQNjWGto5AvusD0bRTIrfSVDUPFk=;
	b=eIJa3dI79ktCj5a3JLOOaa3SPIQmm+EFToZ32OmtYTQCwVne+6YG5ONts6bDBEHd45ZhE2
	kKq6Xmi1+vKcaTBtSKlS3Jp+hd+2iDgMi2rwHlpZYzDvZK33PxsBPg/UW1sAc0H1/EdEYG
	pUP3E2Foym0C/lKAQIZ3UxHgU8Sax1P/RDOfHdCHPGpjiuQWSzAADe7R33hceEWX/Bdjgk
	aIIBY6c8riy0J/uBkOGrjrIpTuj0pqQskTdWhTBbbJTdH6m9CkiX7rsayocjlD98+Mc2hy
	UTv1ZtOj6TdemQKEykApFSyKnPglNbPr1dv7dWi/GVVRmpatArAWuyt1gkOp3Q==
Date: Mon, 12 Jan 2026 19:11:48 +0100
From: Pavel Machek <pavel@nabladev.com>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/8] Add RZ/V2H RTC support
Message-ID: <aWU5ZA0FWar2mb4t@duo.ucw.cz>
References: <20260109121622.46030-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzPxpdEMpepCce4z"
Content-Disposition: inline
In-Reply-To: <20260109121622.46030-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Jan 2026 18:12:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21533


--NzPxpdEMpepCce4z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds RTC support for the Renesas RZ/V2H SoC.
>=20
> Patches were cherry-picked from mainline kernel.

Thank you, applied and pushed out.

Best regards,
							Pavel
--=20
In cooperation with Nabla.

--NzPxpdEMpepCce4z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaWU5ZAAKCRAw5/Bqldv6
8vJJAJ9lY7AoD5XtfXvlNHDIoUZG5yRd6gCghWHhQK5ISDk8mlCfx5BPBn+o7Hk=
=E6t5
-----END PGP SIGNATURE-----

--NzPxpdEMpepCce4z--

