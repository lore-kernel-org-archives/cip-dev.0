Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB83CC021A0
	for <webhook@archiver.kernel.org>; Thu, 13 Feb 2025 22:13:34 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.6556.1739484806837302678
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Feb 2025 14:13:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=N74fEjkN;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2BFEE102FD50B;
	Thu, 13 Feb 2025 23:13:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1739484804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=S6Jq+4hjLKdf92KbKil0jwfx21So7fi5Jh6lkxtiQ94=;
	b=N74fEjkNgC6uLw3BJH/o5THDQCYP4VdvNfj8vXdPxZukLFciayBk+nZA5DyfOX3yL6PTMT
	yr5X/TdLfM7j0B748mkX7q0Tuof173ybRSjIsdZCK4illBrxK198+C4Rse1ad8EfkrrAgG
	NDzokGzC+VQebxrs3NV4wTpytFeXoSw5MKMmJyRvzOcbvb/+5qM6ckJVsbEPRVAG75kC7C
	RP90OIDrI1MmZfq+P/jCF/JmXdHm9lhrTlyQ6CW1gIxPzfQl94bUpcil53PcOECJpCDJMf
	J97GOpGsgl5guW8acktHXzGrsJVy+2OiAQzrn3DB7h8RDjSyIW01d184h6uF7A==
Date: Thu, 13 Feb 2025 23:13:19 +0100
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [ANNOUNCE] v6.1.128-cip37
Message-ID: <Z65ufyXRGmdQeG25@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EKQmyFE9DR0sX+Ft"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Feb 2025 22:13:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17832


--EKQmyFE9DR0sX+Ft
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
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--EKQmyFE9DR0sX+Ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ65ufwAKCRAw5/Bqldv6
8mRQAJ9RwO6JAwNgBVzeXndeAl9p3+/JEwCgsrUONFMpCQD0vY6TVvPBsyw7au8=
=gd85
-----END PGP SIGNATURE-----

--EKQmyFE9DR0sX+Ft--

