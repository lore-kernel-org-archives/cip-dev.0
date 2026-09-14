Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C184CC88E66
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 12:12:46 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18580.1789387965719686175
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Sep 2026 05:12:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=K0yXDnAe;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BD284103762;
	Mon, 14 Sep 2026 14:12:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789387960;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=iVgD1vQw58YhKQr5F7F7hFTYKthOld2F9lNrqYk/SoI=;
	b=K0yXDnAeIxhiDG3VVDF2KFJQNQd0u+IIHXCZ7l4N4SI+wONa9mzgm3DghcPFB8XjysarmG
	gt7fHoslo2HqqjYEP+KJr4SaWq2COgBHXsac4BCCHnfL6QjSXh5voOZzkfbyP/lTCGnkYX
	aJpZd9faoGk36A7vP1Z/BEAixQh6f5HGTWDNgHgh1t4+l07I0ILCoPkx8IJy7hqthfGNwD
	juLH/9+OzgAnYyCwvoI+8UPwMtZrDu3BoKbw7N33y4FqzcrVjWl3eA6U5izgQCeDpxYJj5
	ly3BxSJpgWay34FIPfTd+C903oBPejD0w1nkQEMhOXSW/SY+Vq+qNjKCeh6v1w==
Date: Mon, 14 Sep 2026 14:12:38 +0200
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: ovidiu.panait.rb@renesas.com, cip-dev@lists.cip-project.org,
	pavel@nabladev.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/2] Add RSPI DMA support for RZ/V2H
 and RZ/V2N
Message-ID: <aqfkthTXCdQOceY7@duo.ucw.cz>
References: <20260913163727.77875-1-ovidiu.panait.rb@renesas.com>
 <TY7PR01MB14818789173C2C8D8F9C75388CDBB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mhdaqo49OduzYxMI"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB14818789173C2C8D8F9C75388CDBB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Sep 2026 12:12:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24176


--mhdaqo49OduzYxMI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >  arch/arm64/boot/dts/renesas/r9a09g056.dtsi | 21
> > +++++++++++++++++++++
> > arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 21
> > +++++++++++++++++++++
> >  2 files changed, 42 insertions(+)
> >=20
>=20
> I reviewed this series, looks good to me.
> I can apply this if tests are OK and there are no other comments.
>   Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2=
845749371
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
                                                                Pavel


--mhdaqo49OduzYxMI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaqfktgAKCRAw5/Bqldv6
8l8WAKC5bsmFyLNtNNwLHVjkgr11AGpD8QCggtpYjpongBmOielMpI9E1TSfCY8=
=YPZT
-----END PGP SIGNATURE-----

--mhdaqo49OduzYxMI--

