Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8548CC54E65
	for <webhook@archiver.kernel.org>; Thu, 22 May 2025 06:18:17 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.17479.1747894694128741414
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 May 2025 23:18:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=PjmZk8F1;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3FB281039728C;
	Thu, 22 May 2025 08:18:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1747894692; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=ltM3IRl9wnGp7iTSY+UmsGtBbgbMFGVsw+KWOUWTn1M=;
	b=PjmZk8F1kyS6q6xPPY7PIdVrbFpeM21F/mk1lq0sQRkXIY/WKiPDlIG+mr9eIZCa5Px+ty
	inFwbDKJ//CRzCAYAQ+8WmSFa4JnxGUKzAJoHyTarWaTWyWX5+GkC8oxiAJI9oRxAojlAZ
	3UZOGNcAsIZ3BX0ILHvXaHteAIuH13QW6CZqQEVSD48Ql9VvwmpdhEKnEsn1Ee6ZTwcxlR
	wBOOUSSeM4f8ZjRG0+culh0I0lz1tBHpePBtUE5GzfBAU8Obd5TLfj09BvAkzxFpsy5HAL
	JWRhaVsch5v0bkOvP80m4ZSdgBCh01Q7uMPC/Piwhb2oxIL+1PA4cDNtfxL1hw==
Date: Thu, 22 May 2025 08:18:07 +0200
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v4.19.325-cip120-rt42
Message-ID: <aC7Bny4epDWETgQl@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W2fa6hqb3KsVThMn"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 May 2025 06:18:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18936


--W2fa6hqb3KsVThMn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org. I believe we
should start with codenames. This one would be "Deep Thought".

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--W2fa6hqb3KsVThMn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaC7BnwAKCRAw5/Bqldv6
8r4rAKCRkIvmS9eSF/SxRjO3a2KwvdpHQgCbBZxAha0QWK3c6Wdar2JA1RuTG98=
=0IVb
-----END PGP SIGNATURE-----

--W2fa6hqb3KsVThMn--

