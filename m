Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AFECD3436
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 07:25:01 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8328.1778225093591137116
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 May 2026 00:24:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=RYYOrG+J;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B9946112DEC;
	Fri,  8 May 2026 09:24:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1778225091; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=vJhgOQXcnZecQGwmuzZilNo43m4E3LcIlc8Xu/eBKLk=;
	b=RYYOrG+JpZXQKQPu4Acwx6hho2nXWfMeUsyO8vK3m6LfIB1hA7BQDzHlycCgKxhK2n+aO3
	R2iGzXf8dwl7i1b/qA4MJLPEh07Hs0E6LnSackSjpZ4pN5J9bxYPXPz/KM+vvyCjGbsn96
	lArsPMazoEygL9u6iwV7uhfRrpUrprGqp54Al8lhMoUwVV1D68l9cfjbp7vyY+DedHt3F7
	pjXzI4/aRoOOUS0hCndrCQnbnzpZgl1QXiP9SGfJ4O2fOsoVKjfQDNDLEds3L2Ot8JJa+9
	cqX58E62eW7cSxCJcmO4AJcniMxNqbp2Xz1oW8uthWZv8sKE8M6Grm+gzJvGTA==
Date: Fri, 8 May 2026 09:24:48 +0200
From: Pavel Machek <pavel@nabladev.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
	masami.ichikawa@miraclelinux.com
Subject: Dirty Frag vulnerability -- local root vulnerability affecting 4.19
 and newer
Message-ID: <af2PwOLOzplQ4U9q@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BnOi1TvYxBQDOxsC"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 May 2026 07:25:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22918


--BnOi1TvYxBQDOxsC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

Another local root vulnerability went public. This one is called
"Dirty Frag" and kernel team is currently investigating it.

https://lwn.net/Articles/1071719/
https://github.com/V4bel/dirtyfrag

If you have untrusted code running on your system, you may want to let
us know (and investigate). If you don't have esp4, esp6 or rxrpc
modules installed/options, vulnerability may not exist or may be
trickier to exploit.

This is another reminder that defending against local attacker is
hard, and that reducing kernel configuration to only minimum you
really need. [For example these seem to be advanced networking and
distributed filesystem stuff; I am pretty sure I don't need AFS and
likely am not using esp4, either, but Debian has it enabled, and so my
machines are vulnerable.]

Let us know if you believe you may be affected and best regards,
								Pavel



--BnOi1TvYxBQDOxsC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaf2PwAAKCRAw5/Bqldv6
8iPLAJ4iGYMEHTdywJnxx6GBNdT6LbX6KwCePCI6Ztj1c5XigJa/ItVDLNCdcwI=
=lzns
-----END PGP SIGNATURE-----

--BnOi1TvYxBQDOxsC--

