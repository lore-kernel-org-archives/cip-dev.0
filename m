Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83323CFA76C
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 10:12:05 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8417.1763719922976497163
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Nov 2025 02:12:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=MJbyZKkY;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF58A101E0E54;
	Fri, 21 Nov 2025 11:11:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1763719921; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=241JNOcQeiApaTgxOXK7iIxrdfWYcJgqBXKjOXl4HvU=;
	b=MJbyZKkYt/h9wyibom8OnZbwXz4H9MDKDybqc/r8PZbgekGI+1PF3AqIwtL8dNBVDNmpDs
	xUMfrp+LAP5V0IZa4DK9stQ/Q4fmCexmtYNwajvReykV5W2sFrqBcHhKKklzKqgngUIo66
	4miTqW0XtEnOUd6l78En8hLZd2IZJGcNfgkzQacj8V1sAITwq7WmDNo+7o+menTjuvaQ+F
	Hryz5cDugXHG4GXBJVq8VK0NTqsuM8AfM1BLkRkSf3342TMwJqDUr30j84sD8NzboVITSE
	MK4XHJmAhPTI08K49LSLPKbZpG2kqZUyS0SrLNoYkqh12tt4ZZ7xFFiuPK5oZw==
Date: Fri, 21 Nov 2025 11:11:57 +0100
From: Pavel Machek <pavel@denx.de>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 0/6] Add RZ/V2H XSPI support
Message-ID: <aSA67VOYs/hokrnR@duo.ucw.cz>
References: <20251121080737.20611-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D/2LXBix30r7+nxG"
Content-Disposition: inline
In-Reply-To: <20251121080737.20611-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Nov 2025 10:12:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20678


--D/2LXBix30r7+nxG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds XSPI support for the Renesas RZ/V2H SoC and enables the
> MT25QU512ABB8E12 flash device used on the RZ/V2H EVK board.
>=20
> Patches were cherry-picked from mainline kernel.

This looks okay to me, I can apply it if there are no other comments
and it passes testing.

Best regards,
                                                                Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--D/2LXBix30r7+nxG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaSA67QAKCRAw5/Bqldv6
8nOAAJ4ol3Lb1emV54u4SRo72u2cGzGVygCglJnvRFGtLkzhGe6CDNszK/jU+B8=
=jyAq
-----END PGP SIGNATURE-----

--D/2LXBix30r7+nxG--

