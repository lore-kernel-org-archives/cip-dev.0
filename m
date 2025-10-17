Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD6CCCD195
	for <webhook@archiver.kernel.org>; Fri, 17 Oct 2025 10:45:09 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.12430.1760697905176638110
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Oct 2025 03:45:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=T6h4QlXX;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 43FD910398814;
	Fri, 17 Oct 2025 12:44:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1760697903; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=OQcQKYW1i62wLtqMRcLMppMODOPZR2JyKTgXJefwQ40=;
	b=T6h4QlXXh3O/QVLh4IJWccpRIs21aQrruy4O5QAkptuOeca2LnxB3nM47Y3N4Y0bQTV7fZ
	uVHARh5htjTO01RR5UrFn5MxWlp4mf36RYznVYRqrw/wjyycdGbL7f/I9tPh2SDTAc9bkb
	t2ntNrBRFABj8a7N2qE85LxLdWH0S/YpqIGj7S5oCsA7VtUyin5FF6eM7x7OQePvwsJGkA
	tAtVgFwpGruCbdYcX/1rxx/RpkdgarqORHIXOQdfD9RkhCkof1ePAUQ3Q4MXWgizzBtWWf
	ak1NT70nxBeviJzyM0SmbNpfOR9zM3YEle0Q86zwIOU84iz5fWqluKKeyALJcA==
Date: Fri, 17 Oct 2025 12:44:57 +0200
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [ANNOUNCE] v6.1.155-cip47
Message-ID: <aPIeKZTOb7k4o7bK@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="63q87tJU0+3cnBhM"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Oct 2025 10:45:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20195


--63q87tJU0+3cnBhM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New -cip release should be available at kernel.org.

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
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--63q87tJU0+3cnBhM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaPIeKQAKCRAw5/Bqldv6
8jZJAKCmNVewN3fs3VUJfYsYrK/kKYm09gCfavuwqO2/xGIE4VDBtjs2Np9DiZQ=
=D695
-----END PGP SIGNATURE-----

--63q87tJU0+3cnBhM--

