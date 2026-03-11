Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D81104BED7
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:34:08 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18071.1773225243005814266
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:34:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=U0zt9iUh;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1F2DC1034E7;
	Wed, 11 Mar 2026 11:33:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773225240;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=R8t90ilgRg60Tq396o9cnxkJuJeyu09JMvORiX6XxDw=;
	b=U0zt9iUhrWxrgTbfCBqMnKIDYTjPsg/75BfaX4hZYD/W4h1e6SzdyRVxs2YZBqMQph52CC
	BwvJPat8ojFOd9GYBNkY52oKmtfncRuCLVzBXvM+tVDp+NslHhSi6fro7BvA+I4Dse7kTk
	E1eRSdTbqaMKjyHlH53L66dOB40QFWqH/l5qNub4G++LV1Ht8cWxFjsscRWvNxiLZdX4U0
	IBDhER5jBIsx7PdaYVZ+yfHJ4RYg24jHXpDUi8B1G/hIMN9J5TNAsbESY801g+Eusgn8+e
	panUnDnD4hveFANhtp5azFtRwJANNFhKrl16WfvKQNSXKUGpG4DgUUo5riUcWQ==
Date: Wed, 11 Mar 2026 11:33:58 +0100
From: Pavel Machek <pavel@nabladev.com>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/5] Add RZ/V2N Interrupt Controller
 Unit (ICU) support
Message-ID: <abFFFqQp78B8reP5@duo.ucw.cz>
References: <20260310155050.39087-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OeX8lwO1s1hpA8zq"
Content-Disposition: inline
In-Reply-To: <20260310155050.39087-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:34:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22275


--OeX8lwO1s1hpA8zq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds Interrupt Controller Unit (ICU) support for the
> Renesas RZ/V2N SoC.
>=20
> Patches were cherry-picked from mainline kernel.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--OeX8lwO1s1hpA8zq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCabFFFgAKCRAw5/Bqldv6
8vvhAKC7sQC4eI0HTeiY0+DoV9Qg6Z/HagCeMO5RknYc8V03pMHDS+s3pVEeOUM=
=o3ia
-----END PGP SIGNATURE-----

--OeX8lwO1s1hpA8zq--

