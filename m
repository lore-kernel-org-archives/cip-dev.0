Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D56D16804
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 10:40:07 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7562.1767955202667425947
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jan 2026 02:40:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=bliDDUiF;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4BF9610D3F2;
	Fri,  9 Jan 2026 11:39:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767955199;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=LtyX7QxIwE4346YBMcveZ5Ft6zrJVpQVLXig0SeTsbk=;
	b=bliDDUiFdRUVAcZ8g9+0eQPjbj0JVz1cH5EANN9GsczH/g43OLdM/MgltakBz7RiNNGCSA
	PIADxeOHBvlVSEX93J8DLtIAAEKjMJefRnhJhX/+0X1KoecczaVG/Yx1kbgnYe+QblVbTz
	vDXSkLbnciB2n7FA4ENznj5jgZPVDvpp5yo/YccqF3Apneu1Q9Zx8YJsEou8ruKObCIF1/
	Y46BgvOaYydmMIHzjY7jPGN/BCBP1MQlV8H7HFMH2RJkVjNJoVhU3xEBctIM13tlYDRxMB
	wv9DtQeKjRNHazjmZ/SN0G68A5PiPxJpLbZDeuHAptwrPCWPbz7XtFDStNx4ng==
Date: Fri, 9 Jan 2026 11:39:56 +0100
From: Pavel Machek <pavel@nabladev.com>
To: tommaso.merciai.xr@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/22] Add I3C support for RZ/G3E
Message-ID: <aWDa/P7QVLdqjKrA@duo.ucw.cz>
References: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xaGf/9eKhEhEy9TD"
Content-Disposition: inline
In-Reply-To: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jan 2026 10:40:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21501


--xaGf/9eKhEhEy9TD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds I3C support for the Renesas RZ/G3E SoC into
> linux-6.1.y-cip kernel. This includes also nxp,p3t1085 I3C backporting
> for testing purposes.

> Tested using the NXP P3T1085UK-ARD connected to the RZ/G3E SMARC SoM
> via the RZ/G3E SMARC BREAKOUT board.

Do we really need to add nxp,p3t1085 ? AFAICT people would need
special hardware, and then would have to patch their dts anyway.

I'd propose not to include these in -cip, as we could test them in the
test farm, and it is just for testing anyway.

I had some minor comments, but those should not block the merge.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series after 6.12 version, if it passes testing and
there are no other comments.

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--xaGf/9eKhEhEy9TD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaWDa/AAKCRAw5/Bqldv6
8nPSAKCb2hXHL3ThKkv9XS/OZuA05DWetQCeNpI51LTE7cIig0oR3UzUcDSnfSw=
=om/P
-----END PGP SIGNATURE-----

--xaGf/9eKhEhEy9TD--

