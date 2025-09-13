Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC69CAC587
	for <webhook@archiver.kernel.org>; Sat, 13 Sep 2025 08:53:37 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.1548.1757753615879578663
 for <cip-dev@lists.cip-project.org>;
 Sat, 13 Sep 2025 01:53:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=PeF/jmxE;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ECEE21038C108;
	Sat, 13 Sep 2025 10:53:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1757753613; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=sClccb4OBwHcKpq+iSkgUlBw+oNAnteAsIP4huYY9q8=;
	b=PeF/jmxEU2pIbcLV4p0c8MaMvYwU7HynXobZh3x76iIQ3aNx3RxextLoS+lAxOzzeGfN9D
	oooS8TBMOHvpdnnFGrlrmu4pcgeht70Oq/WleWlLUy+FEVEfhsrEih0rTf2wOM1yL+gbjx
	zX40CyOe+B/PfZHBm6yMQvUe96gwUTHx7TyIs6irZ37MHKsovxPRlgZHeqKT+gKM35XoI+
	wkj08U9Gk7w/66NlQXZVq5vAz2LmTM2BWnMK4zNeCv2o3krxGkXSmB90E0MQYkasc5QG4S
	7CTHh4ozLEjp8v8mhATxa4LzakpZYKzDxyvc3NTVTgY4rfy7t+bRyUGET60FdQ==
Date: Sat, 13 Sep 2025 10:53:28 +0200
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v5.10.241-cip64-rt28
Message-ID: <aMUxCBsZ6Elh/1ve@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iAjDWIPkzJaWxURH"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Sep 2025 08:53:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20047


--iAjDWIPkzJaWxURH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-5.10.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-5.10.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--iAjDWIPkzJaWxURH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaMUxCAAKCRAw5/Bqldv6
8svNAJ9rV/aJOeAza0x6IK9Je5kQIWED3gCeKFYZpSzgHQeIRyZxbOIfCKIF5Lw=
=0uzI
-----END PGP SIGNATURE-----

--iAjDWIPkzJaWxURH--

