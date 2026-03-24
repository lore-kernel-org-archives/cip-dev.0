Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B457E9A748
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 09:22:35 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15591.1774344144959118404
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Mar 2026 02:22:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Pt4Odc+i;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 06888112121;
	Tue, 24 Mar 2026 10:22:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1774344143;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=HCYRxL614nhI+DHyy8gWOFl8Ty6gmTQd2ghZQLvuLxc=;
	b=Pt4Odc+iGQu9z47m9BLYpPIT0yF8V3lQOZdloyftge89mVu2GZgH33ECc3SzYeGIwKrjvX
	Dqp9oJwjWMNAG70IbnjdTM9ZMYYUTz/buzVBC/4Qf+jeBKSS32g+uiu0+4M7bJ/CrhK8F2
	2ThdZ7z9I/z6j4nTpAW7ZTdcl5z8o2bpWyKFOI8y/IbW1csxXGVH2NXfaFESzXdmGQpc9D
	ciiHn0G22KopXpxGt24+8LxteJ2welq9a5YrH3bOPU/Kr/hrfOx61wYRIQ/ioj+jEtQV3r
	1HkxUOMxWc+qi+JHHX3aMnIsEZ6ljc7XjX0UMtVZIdzpYN4O0RBdAakjA09kiA==
Date: Tue, 24 Mar 2026 10:22:21 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 00/35] Add USB and Ethernet support to RZ/T2H
 and RZ/N2H SoC
Message-ID: <acJXzZga4vox1MXo@duo.ucw.cz>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x06jP6+GgdMPISNI"
Content-Disposition: inline
In-Reply-To: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Mar 2026 09:22:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22541


--x06jP6+GgdMPISNI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This patch series aims to add USB and Ethernet support to the RZ/T2H
> and RZ/N2H SoCs and enable support for it on the EVKs respectively.
> This also includes clock support for enabling these peripherals note
> there is additional clock patch for SCI-SC5 which I have included as
> part of this series which was supposed to be ideally sent during [0]
> was sent out.

I had some minor comments here, but those should be fixed in mainline,
first, so they should not block the merge.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--x06jP6+GgdMPISNI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCacJXzQAKCRAw5/Bqldv6
8pYcAJ4iNjanUQGD+O2BMe3mJaa47dH+cACfcjpV+gBWMzlJ0RUcVyVG45ksGks=
=qiPm
-----END PGP SIGNATURE-----

--x06jP6+GgdMPISNI--

