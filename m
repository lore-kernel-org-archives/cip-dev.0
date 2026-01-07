Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9C8CFD635
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 13:42:55 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6085.1767793370511048351
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 05:42:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Kvr7JhSI;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 05D6C10BB5F;
	Wed,  7 Jan 2026 14:42:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767793368;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=STqObTFObDwqMICXm8JdSFsIgQMf6hOt2idEx4/NEOQ=;
	b=Kvr7JhSI+9JvMF7Ul6M9M6ubaCUOvBG5FFDcocKqdlEqw+cbA3JuYjw5TtBr3dg2EVDPhM
	EyfEJBV5KuXJ/5dYXtQwPHeSicUWE3T5r/to8ywy7UFw+8lN+8UMyFGT4fCKnD8zDwg/fD
	PT85yIMYAvi/Hh9ruSgx5hhtQpVQcb+3PhHcneAJ1Pcf5AMk46T+DswMJaTA1/Rmsx3x8B
	IKrfinB7Bh0201a9+eUjTy/zgX7+bcwPtSd2lWUecYU7IwUJM/Ja+KLzNHVWHS1uxXtxeY
	FhCSPPpdCffuTMRtfLnuQ+dDmAwvMFJuQeHmuanjzHzTp06oWeA/yilzzNRpKQ==
Date: Wed, 7 Jan 2026 14:42:46 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip v2 00/13] Add gpio keys/sleep button support
 for RZ/G3E
Message-ID: <aV5i1sDiHHgfuICx@duo.ucw.cz>
References: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6wYFhMp1mGJ/h2iS"
Content-Disposition: inline
In-Reply-To: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 13:42:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21412


--6wYFhMp1mGJ/h2iS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Add gpio keys support for waking up from s2idle and sleep button support
> for entering to STR. Wakeup of STR is by pressing and holding power
> button. All the patches in this series are cherry-picked from
> mainline.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--6wYFhMp1mGJ/h2iS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaV5i1gAKCRAw5/Bqldv6
8m18AJ0Wp8gueH1rKypuAgfA3t9d8lCjugCgoDO2KEqnpTfeKng1yQr9fYZMv5g=
=iw6/
-----END PGP SIGNATURE-----

--6wYFhMp1mGJ/h2iS--

