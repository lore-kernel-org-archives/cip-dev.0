Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961F3C61DB9
	for <webhook@archiver.kernel.org>; Sun, 30 Aug 2026 06:47:13 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4504.1788072425955756078
 for <cip-dev@lists.cip-project.org>;
 Sat, 29 Aug 2026 23:47:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=ZjJnRC/r;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 44B3711D230;
	Sun, 30 Aug 2026 08:46:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788072419;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=btUqhNAcYnUIYUAwQoyJCROr7QjB6jEN+xxzzXOFmng=;
	b=ZjJnRC/rqFDiFRBN0QK5N/xwfWUwQwpUozzx4Rvs1jxHFBI1MuZGnOZn3B0wtt+bfzsIc8
	wWEhaOvRH5RTDqLErZOYVeht6HX3h40SUF00ajB6BEaWpJQLqDIsNTnhrMwexYQdxWehOe
	KhkKFD8tSYailPuuZHz6dHHH5cnKZ/SHF5i+tJJpJqedScMqvMUV5zZtyzYR6weSAkmWHq
	HgGDxX0NjOsWvh5hxCHxIMtgF9r5jutu/AWoLAyilespcBQkhl+G7MWo6vOEtgVBmOrt/g
	BpBVRtIRYWarSY2WUkCz9rzAtpZEplgWnweY1tuoFRrEnRIFR+fnYzNhNi5sJQ==
Date: Sun, 30 Aug 2026 08:46:55 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com, uli@fpond.eu,
	claudiu.beznea.uj@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 0/2] Fix for module build in ohci-platform.c
Message-ID: <apPR31SYTp9fma2-@duo.ucw.cz>
References: <1787881897-6475-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uj0JCV2+u7cW4OfG"
Content-Disposition: inline
In-Reply-To: <1787881897-6475-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 30 Aug 2026 06:47:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24046


--uj0JCV2+u7cW4OfG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The commit =E2=80=9C22cb10519e8f (=E2=80=9Dof: Add of_machine_compatible_=
match()=E2=80=9C)=E2=80=9D,
> which was backported to 5.10.y-cip, causes an error when building the
> module in ohci-platform.c.
> This fixes an issue with of_machine_compatible_match().

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
                                                                Pavel

--uj0JCV2+u7cW4OfG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCapPR3wAKCRAw5/Bqldv6
8kQqAJ9WXMrzrVvHqCxo4FoptI31U4c8BwCdFxDazx1amLoL5+DlU+pmCCqSWtw=
=Qj6S
-----END PGP SIGNATURE-----

--uj0JCV2+u7cW4OfG--

