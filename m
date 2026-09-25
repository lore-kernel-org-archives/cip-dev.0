Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE6DC9830E
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 12:35:54 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7070.1790339744292020148
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Sep 2026 05:35:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=LpFSQ5tU;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C0666105A3D;
	Fri, 25 Sep 2026 14:35:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790339738;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=iwrkte5l6tej8iFWPyvsI3+uyWup4DBNylF0lrvXyuM=;
	b=LpFSQ5tU1gSx+nGe+WE1KkM/QVGX9TqtnCuc69BbKn2epENYnQM8vFpbf3glMQY7CgOBJH
	DXOUeuWLBBVelnYD0FJ5pV6lmPNC2l2wucSB1mbDJOWeaSKohpFvZupyVqOXGxjjqfgdJO
	SD74vkKVEC9XfB2xQlA2Ca7bQlx7TK3AhRssXUzp9H7hUfPMoOKIWrx+AHpRtaTRAMkSVd
	YTdGsV4kFf3OurqHHgv4fXvnL1Zu/89pbXMwzx8pW770xV/CMfpwlxhKTez50O8nNbNNs6
	LZ5dRuN6ecOVzXpjTi02wVPUJowmn2r0q2XtCkQmWQVhbmD454353dhJmn2igw==
Date: Fri, 25 Sep 2026 14:35:36 +0200
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@nabladev.com, biju.das.jz@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/10] Add RTC support to RZ/V2N SoC
Message-ID: <arZqmPVYmmmUvwd6@duo.ucw.cz>
References: <20260917091621.18551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TY7PR01MB14818BBA6AF0337F57A84D1F9CD802@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fKkKxm0+A8yFNMv/"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB14818BBA6AF0337F57A84D1F9CD802@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Sep 2026 12:35:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24348


--fKkKxm0+A8yFNMv/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series aims to add RTC support to RZ/V2N SoC. The RTC IP on
> > RZ/V2N SoC is identical to one found on the RZ/V2H(P) SoC for which pat=
ches
> > have been already backported.

> I reviewed this series, looks good to me.
> I can apply this if tests are no issues and there are no other comments.
>   Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2=
881566985
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Looks good to me, too.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

As you are already running the tests, I'll let you apply the series.

Thank and best regards,
                                                                Pavel

--fKkKxm0+A8yFNMv/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCarZqmAAKCRAw5/Bqldv6
8hPpAKCvDziKSm1NXro+lYucCUFs6tRxUACfZKuW+n5AY6yldc39dmA0CkRJaQU=
=OSUn
-----END PGP SIGNATURE-----

--fKkKxm0+A8yFNMv/--

