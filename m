Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB790F41985
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 09:39:31 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15128.1776245963011798941
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Apr 2026 02:39:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Qo0+c82j;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C32F510E33A;
	Wed, 15 Apr 2026 11:39:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776245960;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=sYRDoezdQ5VeN7qVOKPHe1TRjRJUaVenedb1vK6oFBQ=;
	b=Qo0+c82jaG3Kh2u1bQ1FDY56YC9hfPdq4NuCrZGbwaJnWjYGpHijJkJx5UAvPCQfCQwYGO
	CHStuWZoiSIvbxt8hxumN4BfpenmdF9d+dlw7v9tgzzMc5ZLXpB2nNDSeVhKvocczNRvon
	xlvMcSSDlRzOcVQcB2h7QT/1zG27NZHDFd7TA1h+6OCWkL7D7m4x0jRP0Bop9EA/zmesLY
	HawelNU4Vg0rB35dJrsW7YXEZxVWo31ubCPZf/XNc9SMXA5HK4XH/2rrnekUR2nCvdaILt
	Lnqrh3WvIXCCICQKDrWdNdhhdfhghyrJDeeXA8hvPZr/YEei5sMbSMWVcclcxw==
Date: Wed, 15 Apr 2026 11:39:16 +0200
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cosmin-gabriel.tanislav.xa@renesas.com, cip-dev@lists.cip-project.org,
	pavel@nabladev.com
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/11] Add TSU support for RZ/T2H
 and RZ/N2H
Message-ID: <ad9cxLietTNoOoZ2@duo.ucw.cz>
References: <20260410170215.393698-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <TY7PR01MB148184B2C1FBF41C6718DBD1CCD222@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mLpM7NHWOGZHC1Jo"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB148184B2C1FBF41C6718DBD1CCD222@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Apr 2026 09:39:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22704


--mLpM7NHWOGZHC1Jo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs expose the tempe=
rature calibration via SMC SIP and do
> > not have a reset for the TSU peripheral, and use different minimum and =
maximum temperature values compared to
> > RZ/G3E.
> >=20
> > Patches were cherry-picked from upstream kernel, except for patch
> > 7/11 which is needed to fix asynchronous aborts during unbind.
> >=20
> > See the MSTOP series for more details:
> > https://lore.kernel.org/cip-dev/20260115083451.1064048-1-claudiu.beznea=
=2Euj@bp.renesas.com/
>=20
> I reviewed this series, looks good to me.
> I can apply, if tests are OK and there is no comment,
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2453844=
182
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
                                                                Pavel

--mLpM7NHWOGZHC1Jo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCad9cxAAKCRAw5/Bqldv6
8nQ9AKC+Iq8ip10ddPxxMfRVOBqoPGpmIACgrsd9HRg2nACj8TaqiNGJ6E/hqwQ=
=9PiB
-----END PGP SIGNATURE-----

--mLpM7NHWOGZHC1Jo--

