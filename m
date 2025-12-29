Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07707E92FD6
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 20:27:15 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50834.1767040025137117255
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 12:27:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=hxEPHrK1;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE63C10092128;
	Mon, 29 Dec 2025 21:27:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1767040023; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=7mDUrMGVE+fJwZiPj/osuXSV3Q74goXL7dj16eVcbTo=;
	b=hxEPHrK1Vd26Kx8JMsMCtNdpfcHXE1wdJLL5JUoehlMBPQ7NEFSZXUmvoghdEnbKKrKl8Y
	lDw+xUz0NteudTuxe4qEWTG6yUtEkfZ3Ht3RXREaTz3BXzPdqiMz0X/o3UrnLNEquG8fiJ
	GgSp2/QXw1jzFrWmu2zGVkVlKH5BI21IVg7jzeLzhWfB57jUBvbjlb958dUFjuQetGbaGN
	H5k8UfYJpRW8jGTkjTXzbpmErDRoD/Uoi6OT9IFb3FgtBzgpAElNOJicehZm/f5/0KO5Ya
	Ngut52Q4RAzcB8i0zo2TIvdAVTR94CEd+oSBdTwp/g5kCPNR7LO50YcOTM9DSw==
Date: Mon, 29 Dec 2025 21:26:59 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.12.y-cip 0/6] RZ/G3S: Backport TSU support
Message-ID: <aVLkE8IzLju8o7hz@duo.ucw.cz>
References: <20251217103222.4183089-1-claudiu.beznea.uj@bp.renesas.com>
 <TY7PR01MB14818367AD749019DCAAF7364CDB3A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xzWlkm43Iz/YsX6P"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB14818367AD749019DCAAF7364CDB3A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 20:27:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21252


--xzWlkm43Iz/YsX6P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I reviewed this series for each branches, looks good to me.
> I can apply this if testing is no issue and there are no other comments.
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2232119=
913
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2232120=
629
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2232120=
713
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

I had some minor comments here,	but those should be fixed in mainline,
first, so they should not block the merge.

5.10 and 6.1 versions look good to me, too.

Reviewed-by: Pavel Machek <pavel@denx.de>
                          					Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--xzWlkm43Iz/YsX6P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaVLkEwAKCRAw5/Bqldv6
8r4FAJ9FVJbMl+aq2DPJIt+zBTEoZzO7aQCfVEF47x7LQrM2c4X7JdQyyxqk8YE=
=jk8t
-----END PGP SIGNATURE-----

--xzWlkm43Iz/YsX6P--

