Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FF6E92FD7
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 21:13:45 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.51695.1767042817594801676
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 13:13:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=FUoMakPA;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1CB3610092128;
	Mon, 29 Dec 2025 22:13:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1767042815; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=/s+Wkqf9f9QR6+y/jVc5aQHhkVGJWfZULd73HygzP+4=;
	b=FUoMakPASXBZCBglNaiUFiZ1S5LK11B/e4e/XqexZu//V7Cry8vHNl1iLNxEtzDltKXe3I
	whuH/b2Bcgievih9+xgywUbx2pxSAdcYhUYl53feMOWMSHeiDzTjllaiA2t3az8Q2xOcTM
	qfdEIR6ARQYCty7fOAH43XHISNS/32IqAILU6CaOnlklVIVPLR37Lv4lg4wL3uEOMFdav0
	4gEyrMEyx7KshSqRplNkI1F4VP2M/wo9u9lSza3QpcB/3OEB4KU8UXG8TnAA+RnfdV1mZ7
	+BAfQIpx6DgVdO8c778GXSvJc9h58VKXoZsonkIgza+btCrKri+5CH3LZkif6g==
Date: Mon, 29 Dec 2025 22:13:32 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 0/5] Add gpio keys/sleep button support for
 RZ/G3E
Message-ID: <aVLu/JtNminlDNr9@duo.ucw.cz>
References: <20251219122916.129256-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ofVMqz+FcU1cJZqI"
Content-Disposition: inline
In-Reply-To: <20251219122916.129256-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 21:13:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21255


--ofVMqz+FcU1cJZqI
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

Series looks okay to me. I had some minor comments here, but those
should be fixed in mainline, first, so they should not block the
merge.

Reviewed-by: Pavel Machek <pavel@denx.de>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ofVMqz+FcU1cJZqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaVLu/AAKCRAw5/Bqldv6
8gdGAJ4lHUX8TJHdVM6FjzoA5jb8oB1ScgCdET6F0cZ3ILihS2XXZXq9Bhd27qg=
=QhXj
-----END PGP SIGNATURE-----

--ofVMqz+FcU1cJZqI--

