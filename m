Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5363.1795470255155276493
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Nov 2026 13:44:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=bf42FKg9;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D221110D3C0;
	Mon, 23 Nov 2026 22:44:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795470248;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=aluOIfBQWbodV2Sx2WSfSWxiyoPjwl48WBd8JQ/eXEs=;
	b=bf42FKg9FkCuvCZvtU/ynFGHs7EXtIT6HiLs7/jMZAkg3LU9V/Sa7rybdLNytRmpamYQZH
	BIdbpLPnJtpSJPhoFGY7Jn9oPq02TNSgOBci9eEqJDfkU/oWnwb8ZfkC8LAWmo0BQb4Go2
	6LY3hXbTQhsYbcj5Umlxd6rIXM/TthXtBs2gYlEXSvO5vt3+smZFZs8oQ5uzdE+ZOjeYF4
	zhMSn+B8cX8GoBkRx1R6Ijcju9PUY92wevqIyp05b1ZduOTibkmIzipsmWlQS6HbinLL0Y
	5i13ea2TmAbw6+MUZia8PCHbWYArvWmYQUF1eX+xvHnrNdrdFV3zdZw0Uej0VQ==
Date: Mon, 23 Nov 2026 22:44:05 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.12.y-cip 00/35] i3c: Backport I3C support for Renesas
 RZ/G3S
Message-ID: <awSzpbvC6xKPC5nJ@duo.ucw.cz>
References: <20261117115038.1485554-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2NDJ2yskx0/LQnAC"
Content-Disposition: inline
In-Reply-To: <20261117115038.1485554-1-claudiu.beznea@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 23 Nov 2026 21:44:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25051


--2NDJ2yskx0/LQnAC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Series backports the I3C support for the Renesas RZ/G3S.
>

Looks good to me. I can apply the series if there are no other
comments and if it passes testing.

Best regards,
							Pavel

--2NDJ2yskx0/LQnAC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCawSzpQAKCRAw5/Bqldv6
8hNvAKC06PwVjlaTx1ziMLoW2BDLFY510ACcCvnDYtItZAROqxD5Qer1JPj/pX4=
=0uy/
-----END PGP SIGNATURE-----

--2NDJ2yskx0/LQnAC--
