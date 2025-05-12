Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267E3C3ABC3
	for <webhook@archiver.kernel.org>; Mon, 12 May 2025 16:08:46 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.54451.1747066116615422810
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 May 2025 09:08:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=L6BZLwbB;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5FBC5101EC1F1;
	Mon, 12 May 2025 18:08:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1747066115; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=yjqien+GIsQT64ONy9uWXTbl60KSKTgu6tymZm3JUSM=;
	b=L6BZLwbBFNuFo7+ybkdbe1MmP+mr+QpuT4Gr3/2XQVG7tQAYWTGhCtCSZCJrK1jtmEmOfW
	aMKlbA0en1IN26GJhCaUGxrDWCe/6wXfmKD5OPqgr7kAYXCZqnbzBvbr2IdGv4fORL/RhQ
	aTlHGMehix4fdVcfXdXfxoPmPfa0df8nu/dreAN5uwbmffCAl6TZytE40Q9DHke6D77M5d
	HRdiFdLyAiGGq5tyM98kbyUjlXgg0UqXeXG/j7AEnwlYEnCPfLFELk3GvmvXxMQWQ8yt6J
	+hWvOJVTnMPpAe0UJqd/CC5rpiqJG+LcUk0b0AbYlJNjGghiHEhqbfaO8E2S/Q==
Date: Mon, 12 May 2025 18:08:32 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 5.10.y-cip 00/37] RZ/G3S: Backport audio support
Message-ID: <aCIdABx3/lmEnii9@duo.ucw.cz>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EAEjhdLwtKGfVq/Q"
Content-Disposition: inline
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 May 2025 16:08:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18900


--EAEjhdLwtKGfVq/Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports the Renesas RZ/G3S audio support to v5.10.y CIP.

Thank you, applied.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--EAEjhdLwtKGfVq/Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaCIdAAAKCRAw5/Bqldv6
8muPAKCI1NyU+Zh3P4c7XJm5PsLwIZdBOACeJPz8BV5iFVMebjaH+BlfDSMdS6E=
=9GrW
-----END PGP SIGNATURE-----

--EAEjhdLwtKGfVq/Q--

