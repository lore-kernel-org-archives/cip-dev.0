Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0296C103E2E8
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 22:07:03 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8439.1773266814596257658
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 15:06:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=GvevY+qL;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BED7E10A45C;
	Wed, 11 Mar 2026 23:06:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773266812;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=h98S9JM6IeJZdLAxfM18XkVbLrAih3xvnayHnzHP4dA=;
	b=GvevY+qLTg5/bcLaybS8ck146Ly3xYX6EDzvdMNowkmlF8bO5SGWsf0XVUY7wAbb+G4SZy
	XH8EXAlwV4UaV+jzDPrQwGi0f1DQf2ez0uXBhboaq7SDw5+q9hFOeNTIuqIwNe12zy70p8
	BqYuxt3blOkIXjppXnf2Wme0oxhk0K3OgV5cJdHTWOsL8GES3fR34rw7fZhqtJMyDWPggc
	28MYqnF46V8ALdyhnE+GfYRnZY6jdKlLb81bMrfbFvb60HOnK5mqzReN8W3vp23OiJMxsL
	PmpYh4xqBcDtAIXIMTbMon2g6cRIULg0Yjrz8ggNkpU5xB18j6psD72Fm7EG0Q==
Date: Wed, 11 Mar 2026 23:06:48 +0100
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
	pavel@nabladev.com, uli@fpond.eu, masami.ichikawa@cybertrust.co.jp,
	chris.paterson2@renesas.com
Subject: Re: [cip-dev] [ANNOUNCE] Release v6.12.76-cip18
Message-ID: <abHneDl3zh3RSgNZ@duo.ucw.cz>
References: <TY7PR01MB148180663612C1BAD4584B06ECD79A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FC+3NaEMJqUdii4E"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB148180663612C1BAD4584B06ECD79A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 22:07:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22344


--FC+3NaEMJqUdii4E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> CIP kernel team has released Linux kernel v6.12.76-cip18.
> The linux-6.12.y-cip tree has been updated base version from v6.12.69 to v6.12.76.
> This release includes updates for the Renesas ARM64 SoC RZ V2H.

Thank you!

I should be releasing v5.10-rt, and v5.10.251-rt146 is available --
could I get matching -cip release?

Best regards,
								Pavel

--FC+3NaEMJqUdii4E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCabHneAAKCRAw5/Bqldv6
8tYuAKCclYz5sZxzbBD2CzeDHVixeMojHwCgrNpM0SxNhId+X92WGgQF8YLR/vs=
=qQJo
-----END PGP SIGNATURE-----

--FC+3NaEMJqUdii4E--

