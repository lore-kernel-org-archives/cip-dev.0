Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EC0C43458
	for <webhook@archiver.kernel.org>; Tue,  7 Jul 2026 20:17:28 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.156.1783455442928185494
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jul 2026 13:17:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=OVEchgJD;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6F420118FE8;
	Tue,  7 Jul 2026 22:17:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1783455440;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=NunWxtMPiNNcDOwRWPO5CfbQqC4427Nv/k+oW9D9ERo=;
	b=OVEchgJDtRMIm8RMxjS8ZLAhsiHtjY8Bskd97pLqEgEqsdOJ/2FeP+Ka/myHMcvZvM5lgL
	qJmPw7U37ziOiIWGk0qcShtXbOF71hMEdEnTTWTnNsah/ZbNJ9SBLYT6W1ZsTD6/ByRN3v
	gufUWl8Giypn1/kU0wk7bBVkuQ+o4EN4k5+0io1Rw3k2tF8rJsKJ+cJG1umcOGJCJXUQn1
	k/e8QtKWEJgxo7qqgac64rNcchSRTE9UlQuvL3Ki46BEiBQFkZPrX2VN81TNl9GPsNoghr
	NWevA6ww+bEKL5qX5d2av7aXjLJqpftMvq0IfhDg5d0PXGBQyKo1uK5WK7XaEg==
Date: Tue, 7 Jul 2026 22:17:13 +0200
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@nabladev.com, biju.das.jz@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 6.12.y-cip v2 00/10] Add pin configuration and
 GPIO IRQ support to Renesas RZ/T2H SoC
Message-ID: <ak1eyZZU2KzTw3TP@duo.ucw.cz>
References: <20260702102349.23431-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TY7PR01MB1481845D862F3FDD700499334CDF02@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zqP8fGcn5PFIFQXI"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB1481845D862F3FDD700499334CDF02@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Jul 2026 20:17:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23474


--zqP8fGcn5PFIFQXI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series aims to backport pin configuration and GPIO IRQ suppo=
rt to
> > Renesas RZ/T2H and RZ/N2H SoCs. Enabling of GPIO IRQ support to
> > SoC/board DTS/I will be done as a follow-up series along with xSPI supp=
ort.
> >=20
> > All the patches have been cherry-picked from upstream kernel 7.2-rc1.
> > Patches apply on top v6.12.94-cip26 (commit-id e00178e6fe853).
>=20
> I reviewed this series, looks good to me.
> I apply this, thanks.

I had some minor comments here, but those should be fixed in mainline,
first, so they should not block the merge.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
                                                                Pavel

--zqP8fGcn5PFIFQXI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCak1eyQAKCRAw5/Bqldv6
8uO3AKCyK4aj7862YwA59pBLC7D1iTF4HgCgpfzVmWWNnbTjRqu66pYKCHvpl+Q=
=C6dL
-----END PGP SIGNATURE-----

--zqP8fGcn5PFIFQXI--

