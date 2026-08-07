Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2C7C2A09B
	for <webhook@archiver.kernel.org>; Fri,  7 Aug 2026 18:45:51 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.49314.1786128341460101110
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Aug 2026 11:45:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=i20zJZLB;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5630E11B0A6;
	Fri, 07 Aug 2026 20:45:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1786128335; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=c9aQnfFG/KNL31Q3U7LhO35beWdtikCNLxiYRcoon0k=;
	b=i20zJZLBE8Noh+3wnaKmKn44nu5rt30XfxUu/BLhRd+8MCiTeRhmbiynIZGSMcd98nhrSX
	Dql4OY84J52r9HxHuLUNvCIoks+plheMFWtmQniXpPl73j9nYTfPpgItTbM9XvKYlLMZsd
	xSN2rHx7H6vzmVdGLpaSWNpH9JjuLytO8Mbkk+bho4T3mWBBpdRkdRBGQdqVRUOi9v40OW
	wagp5ZSNWOy3jxdYMzE06zWblh0dq6G0crsyUckl6eqSfB2Y2Ih4IFMRWGvP5xrf7Gyt4u
	5LHTSqPVb4e2psQWu5IGEPSq/8FxBFJiqdBFlCP9t48hQXXIa7dVCsfnqied+A==
Date: Fri, 7 Aug 2026 20:45:30 +0200
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [ANNOUNCE] v6.1.182-cip59
Message-ID: <anYnylBgFcYFi1W1@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l4Jv0/OmDKOQ12T+"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Aug 2026 18:45:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23878


--l4Jv0/OmDKOQ12T+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New -cip release should be available at kernel.org.

We did this one early, due to recent vulnerabilities, including
CVE-2026-64560. If you have untrusted code running on your systems,
you should update. =20

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.1.y-cip
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.1.y-cip-rebase

And their content should be identical.

There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel

--l4Jv0/OmDKOQ12T+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCanYnygAKCRAw5/Bqldv6
8uf2AJwP0JL+r1kqJtuUtS2PCSvif+xJgQCguXWdp8AHYx8NGatfqp4QJ1HneWI=
=g5lu
-----END PGP SIGNATURE-----

--l4Jv0/OmDKOQ12T+--

