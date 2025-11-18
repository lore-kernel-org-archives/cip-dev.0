Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E201CEE35D
	for <webhook@archiver.kernel.org>; Tue, 18 Nov 2025 21:19:11 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7681.1763500742764052541
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Nov 2025 13:19:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=OEhFV6jx;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 00888103AF64D;
	Tue, 18 Nov 2025 22:18:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1763500740; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=LB19qUgydhTI3LkfBwPY6ph4S1Ms9ielg3MEjvwfkUY=;
	b=OEhFV6jxQI9gD9T3S85gFyuMPfF0qup5QwRm2l5y1qnijyqhDN5rV9msuX825jrU5n8HtB
	M10Hld9gMLWM93k2ALIbx+X0ir6yGkGyWHOPz5/IUjPD6Xhl9R3cVGXcvlmRcNdYegC9Qz
	k6uW/AyWog+K9+9kqYIg08Z2L7SYY2DqjbuoDJ6t2CvprIu5iWTllPXeeMpV7+BYj1Y/2S
	3YK5K+khJEcZoeG1SWCXUHGO+hvHhebQastrNV+GvOvb/Zk9TxRo4ArSwifTLmnocbBU6o
	n5KqZ6+pBrYQWBhs8vX+GONUDubtRXNydihkF9pLhcjjjcfKu94KgH+FHvZ9oQ==
Date: Tue, 18 Nov 2025 22:18:58 +0100
From: Pavel Machek <pavel@denx.de>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: Re: [PATCH 6.12.y-cip 0/1] Add RZ/V2H eMMC support
Message-ID: <aRziws/5B3Zv/jpf@duo.ucw.cz>
References: <20251114111403.74450-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Uvfr6AuhLL+WdsFl"
Content-Disposition: inline
In-Reply-To: <20251114111403.74450-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Nov 2025 21:19:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20622


--Uvfr6AuhLL+WdsFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds support in 6.12.y-cip for the eMMC and microSD sub-boards
> connected via the CN15 connector on the RZ/V2H evaluation kit.
>=20
> Patch was cherry-picked from mainline kernel. Note that only the RZ/V2H
> part of the patch was backported, as there is no support currently for
> the RZ/V2N SoC in 6.12.y-cip.

Looks ok to me. I can apply it, unless there's veto or test failure.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Uvfr6AuhLL+WdsFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaRziwgAKCRAw5/Bqldv6
8hXgAJ4qx8mrF/NcJ3yNe+LjtxlDh6lfzgCgtssgBNhg3AzyKLIbe/KTfINpCyU=
=TU7K
-----END PGP SIGNATURE-----

--Uvfr6AuhLL+WdsFl--

