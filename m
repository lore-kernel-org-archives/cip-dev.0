Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ADDCAC587
	for <webhook@archiver.kernel.org>; Thu, 11 Sep 2025 14:20:10 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.48023.1757600404628504883
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Sep 2025 07:20:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=c2fXEf8S;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8155C1038C108;
	Thu, 11 Sep 2025 16:19:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1757600400; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=aooOUrEgG/fj/JeAmTghqgz1YkUBvjpJCbId8wJRmgc=;
	b=c2fXEf8SF7qFusqduUpIovjcA4+uI2OBkT00EdDVsSYBE6klvgUlDVtCKyh1fBs0v79ULq
	ekQIeevVwbMxNiU9I+HvipAhuE08aMeBpqmwNhGNAprsurtaOzAU/XeiPU23mkPlzhIVBU
	bH+cikbLU9uOmgyIG2g3uHK1ehUT8pmMkbqjDhs23Uu72i6SrRoyy2VbqN49fBmQAa6PC1
	0qcXZ8oiS5aJK0LpILd3mNSdwkgaIe/La8pn1iGCh+8cghISpauWn3boa/6TQNgwbE4NFb
	22ALKJyMYngH1spt/cEaRJ/TeFO+ZS+fH/PpshAs0oD72qpBwpoLFd5gD+BxVw==
Date: Thu, 11 Sep 2025 16:19:54 +0200
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [ANNOUNCE] v5.10.241-cip64
Message-ID: <aMLaVzACLQpN+gFK@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YDskppNyOpnN/dn2"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Sep 2025 14:20:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20039


--YDskppNyOpnN/dn2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New -cip release should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-5.10.y-cip
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-5.10.y-cip-rebase

And their content should be identical.

There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel

--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--YDskppNyOpnN/dn2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaMLaigAKCRAw5/Bqldv6
8q9VAJwNhIto7TtwhrQ7GwFS6wBlVVmZ1ACfR9m/AmvJKJSBZf25OuGUuyzckDk=
=kF5X
-----END PGP SIGNATURE-----

--YDskppNyOpnN/dn2--

