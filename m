Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E87E7718B
	for <webhook@archiver.kernel.org>; Thu, 19 Dec 2024 18:14:45 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.135456.1734632082252109716
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Dec 2024 10:14:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=PvYsI2yO;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E64C9101ECB02;
	Thu, 19 Dec 2024 19:14:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1734632080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H2zwiGI1PXhBsIa9abIKFvFipgcOsPlY8g0Au+4PV64=;
	b=PvYsI2yOS6Yc7JI3HPpwN67L7XWbd8HjSQmu3AKmgyJpfLasppS+ZAE5iKkubZcL6us0WX
	Nv84S74ehRHvupaHQj4u16qF6/myOn/rdytMUJg0UburebVzIj9uj738uocu9CO7L0aoFb
	RXhsvZP8a8X9g01/7iQ0jAktusisj4iaWWB1RAkHkA6vEnLlZ0ZBxGsOUm+M6JFHx/za1x
	Hex0O8aATMtIidpi8IGaC1FWG+8PSsq1LyrcaTkwCyme/XJf/rvs5Iw2k3seDVwFEGVdl3
	C8xwJpFdYwCwIdZcAnIO2hqCeq2UU1B/rVe2Yo7wOvJqaK/fCH7wKHNS+YIZQA==
Date: Thu, 19 Dec 2024 19:14:34 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: claudiu.beznea@tuxon.dev, pavel@denx.de, cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [cip dev][PATCH 6.1.y-cip 0/8] watchdog: rzg2l_wdt: Backport
 RZ/G3S support
Message-ID: <Z2RiikzFAq/sZdoD@duo.ucw.cz>
References: <20241218122246.2365189-1-claudiu.beznea.uj@bp.renesas.com>
 <OS0PR01MB63887B34A61DD27E9EF3693A92062@OS0PR01MB6388.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9yuWYMDzY5QLJ1U0"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB63887B34A61DD27E9EF3693A92062@OS0PR01MB6388.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Dec 2024 18:14:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17481


--9yuWYMDzY5QLJ1U0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I reviewed this series, I had no part to point out.
> I can apply this, if there are no other comments.

Applied, thank you.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--9yuWYMDzY5QLJ1U0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ2RiigAKCRAw5/Bqldv6
8v/MAJwMngd9pZ2NoYV+PpKAKxKnRSlMMwCgv05YnvKRf1xtTUXreCBpgBmpzaY=
=JlD3
-----END PGP SIGNATURE-----

--9yuWYMDzY5QLJ1U0--

