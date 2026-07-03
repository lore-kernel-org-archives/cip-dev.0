Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3EBC43458
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 21:13:04 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.101073.1783113173682632922
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 14:12:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=KmY9QZ+d;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1F9B0118C22;
	Fri,  3 Jul 2026 23:12:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1783113171;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=h86NWlHZwOdivaFWowqqwBF4hJjQQtsUa6WArcxb3Vw=;
	b=KmY9QZ+dxiRQvKsTnud1oQzhjmkHRTaq49laGnoBU14tTOuJl5cbcEh6TmwRPOrZw1B/2j
	t9NL41SAe3jWxItccBIITeu/CmKqpDODTL9wI4lTHWXnBobAlybhHauV7fxql0xrUC/yU7
	BjFqW0pqgWeZ6gkmm+5gspOQjPZAiAU/afKB3t3Ktx0GbIWgp2jHTy6XSx0wOLn2s7Wkto
	FpF4k9pZupNOVHzc6XsoF9HIrND+BMv6ZE5t7ESwVj5h1FZzFxKJRsY7j3XlWaKJwlCGVE
	ygcPEepQVKdYGzt5C3ZwVwjGTnPbZliR9JrwtTbQiU0LS50/jo0/emg27GQurQ==
Date: Fri, 3 Jul 2026 23:12:49 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 0/4] Add PCIe support to RZ/V2N SoC
Message-ID: <akgl0XRpDkjmOgIi@duo.ucw.cz>
References: <20260703152803.29302-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V/QK491kkNCxphSE"
Content-Disposition: inline
In-Reply-To: <20260703152803.29302-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 21:13:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23454


--V/QK491kkNCxphSE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This patch series aims to add PCIe support to RZ/V2N SoC.
> The driver patches have been already backported. All the
> patches have been cherry-picked from upstream kernel.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
                                                                Pavel

--V/QK491kkNCxphSE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCakgl0QAKCRAw5/Bqldv6
8lEEAJsHUXV34UR27ZCPHAlhO8IwYgwReACeOlV1mJ/vU0+YpDSYaihaXbO3/KU=
=dadJ
-----END PGP SIGNATURE-----

--V/QK491kkNCxphSE--

