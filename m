Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365C3CDC173
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:02:29 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88472.1767700938800588489
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 04:02:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=OaQuFdDk;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E05DC1097A4;
	Tue,  6 Jan 2026 13:02:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767700936;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=TXcKh4CcjgfgbIPzsovX8jhQzi5a4jjyA8QJ8OsUaKM=;
	b=OaQuFdDkVEiSEe72122TSKyf14QOOls5Q4ct4TBgbC+InfLk00RyFeDZrdhJQZdnJ36Zyo
	7yQ9qDowL3VVk3PFXWDdbUnfwcmoFIA5E/mpaS2rmL/GXmzXqnRQCWUlz3C/BnHDB1TF9i
	rqqeQAhONLOBCryMxPXUSjsTccpYM4J9f6FDyJbv+O0+gm3ItgafmlUwsKdjJEStkS3iKm
	hMyt9D8PsyTwJP0/Rqn6mt198spXvMRtq/TpLSjoo1pZVaNWqv3IiCHpGJ9ORub+Kmfp/1
	evjb7ekJKGHrnIGDShDvFzVEohAe0T5TFk7rhXsT50d1R50eRJTigu9pSvMSRQ==
Date: Tue, 6 Jan 2026 13:02:13 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12-y.cip 0/5] Add RZ/V2N GBETH support
Message-ID: <aVz5xRL2CoI/6l/q@duo.ucw.cz>
References: <20251229084237.3634-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8nygpijCYDxeV8wX"
Content-Disposition: inline
In-Reply-To: <20251229084237.3634-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 12:02:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21359


--8nygpijCYDxeV8wX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds GBETH support for the Renesas RZ/V2N SoC.
>=20
> Patches were cherry-picked from mainline kernel.

6.1 version looked okay, and this looks okay, too. I'll run the tests
and likely apply it soon.

Best regards,
								Pavel
--=20
In cooperation with Nabla.

--8nygpijCYDxeV8wX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaVz5xQAKCRAw5/Bqldv6
8rdhAKCc/fD0NXjlVt8FJ7ylaT1BDiXruwCfbLycygKpX6g/30AYyVObhjeWSxM=
=je+U
-----END PGP SIGNATURE-----

--8nygpijCYDxeV8wX--

