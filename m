Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF78CCF9F8
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 18:30:55 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4883.1762194646032883647
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Nov 2025 10:30:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Bzy9cPLX;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 46AF610398810;
	Mon,  3 Nov 2025 19:30:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1762194643; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=G6jrthxbNcuG02w5eiI8IZu/jerxHDzogfMyCaWIzWc=;
	b=Bzy9cPLXvSXCcCgDH0HtY6E6kIVuJYqASKgLnaCuSCTQ7GYOQ38eDwZJwy/8zYcLoa/Pfh
	SkaW3PVai7CdGB9LswoJJ0OcciBx7JzvNcRWmvevExCMVqKhfP0IORQ91EfooQg2BZofCv
	LsOc4xt/pLd8UPs6WrBIp4DVuWmy6yP0lGSlSZmv3eQ93v3a9qqIPMnGBO7+6J/lWNElvv
	2M3GP9hwoELbv9PcGHIrkR3vFNg9p9CVzd9wbYH6w8gGF3y9tNXJ/NzfGujoVdiX9QxfX8
	GfnofH0mvD6EwE69Nv9WClo+q91NCcsgaBJRN0LBwOImaryYWU2BsmIuNEG1rQ==
Date: Mon, 3 Nov 2025 19:30:38 +0100
From: Pavel Machek <pavel@denx.de>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH 6.1.y-cip 00/25] Add RZ/G3E GBETH support
Message-ID: <aQj0zqPbRZSpUZVL@duo.ucw.cz>
References: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KndDz7JlEm5r3GuI"
Content-Disposition: inline
In-Reply-To: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Nov 2025 18:30:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20345


--KndDz7JlEm5r3GuI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I've got this one twice:

Date: Mon,  3 Nov 2025 12:25:19 +0100
=46rom: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@to=
shiba.co.jp>, Pavel
        Machek <pavel@denx.de>
Subject: [PATCH 6.1.y-cip 00/25] Add RZ/G3E GBETH support
X-Mailer: git-send-email 2.43.0

I assume series are same and I can just ignore one of them...?

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--KndDz7JlEm5r3GuI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQj0zgAKCRAw5/Bqldv6
8va4AKDBlTVMESBZnG5xLeg2a3tUQeoqyACeN9IM0e6Bv4mv0v+WoSgF2LIY/Ag=
=Zsiu
-----END PGP SIGNATURE-----

--KndDz7JlEm5r3GuI--

