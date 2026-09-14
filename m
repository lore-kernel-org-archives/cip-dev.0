Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0EFC88E66
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 12:13:16 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18592.1789387995040004933
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Sep 2026 05:13:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=a2Orssqy;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4C8C31032EC;
	Mon, 14 Sep 2026 14:13:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789387989;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=X8Vq31qj63Xwd9EuBa2OO2WB5M8L7nkW4xtInwlpH/M=;
	b=a2OrssqyIfDwu5cAfjrVcVRk/gm80dt9J9iLGISHfrucL+OvJ2qd/7eZdi5VCp1ao5cbTy
	83RqDTEGhy6TwFQq/KuhKm0ot4STUBidRGTvTmR/sBeGbDp3dmWSmuwTS4wsLxdvXLXbfK
	Et0ynoP8J6jRQpj56CytBcpRUguNSDDgAwSINle3Z/0Yhwc4mOWCoRrfdgTzhqCJ9+FO/B
	7cnBRP3PtXbDbGlXPnfld/LHdPZIAUVZeAvNwcEkh1qr2u7L3LP93ZNDSmlCUtBbU/kVS6
	gmL6KDP6ZITyOBRUM2cEl26W7FQkcgqUEqzMU/sURcI39EiL7Om+twptIih8gw==
Date: Mon, 14 Sep 2026 14:13:07 +0200
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: ovidiu.panait.rb@renesas.com, cip-dev@lists.cip-project.org,
	pavel@nabladev.com
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/2] Add RSPI DMA support for RZ/V2H
 and RZ/V2N
Message-ID: <aqfk0-jrU-TFz7rL@duo.ucw.cz>
References: <20260913163634.77803-1-ovidiu.panait.rb@renesas.com>
 <TY7PR01MB14818DE7C584C2C09A6AE14B6CDBB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VzVPtw8yIz+HNlHS"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB14818DE7C584C2C09A6AE14B6CDBB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Sep 2026 12:13:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24177


--VzVPtw8yIz+HNlHS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >=20
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
845750901
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
                                                                Pavel

--VzVPtw8yIz+HNlHS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaqfk0wAKCRAw5/Bqldv6
8kDeAJ980B7ppNsyFXo7rtUyJIj3d+0P+gCePjfX0QYIJI1wHVbLe4K1Ay4cMUg=
=plDk
-----END PGP SIGNATURE-----

--VzVPtw8yIz+HNlHS--

