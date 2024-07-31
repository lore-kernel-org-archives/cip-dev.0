Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ECAC3DA64
	for <webhook@archiver.kernel.org>; Wed, 31 Jul 2024 06:54:56 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.37274.1722408879743965637
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jul 2024 23:54:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 600661C0082; Wed, 31 Jul 2024 08:54:36 +0200 (CEST)
Date: Wed, 31 Jul 2024 08:54:35 +0200
From: Pavel Machek <pavel@denx.de>
To: Chris Paterson <chris.paterson2@renesas.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Something wrong with gitlab-6.1 testing
Message-ID: <Zqnfq6ZqUiZbTAT+@duo.ucw.cz>
References: <ZqPp4nE4f1jOnJJI@duo.ucw.cz>
 <OS0PR01MB6388F7B33E56D44B35FA2B6792B62@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <TYYPR01MB1240224190BB552D4C5507154B7B72@TYYPR01MB12402.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2lacGvFSJm9aG2zI"
Content-Disposition: inline
In-Reply-To: <TYYPR01MB1240224190BB552D4C5507154B7B72@TYYPR01MB12402.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jul 2024 06:54:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16689


--2lacGvFSJm9aG2zI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Example can be seen here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/746701=
6656

+ git reset --hard origin/
264
fatal: ambiguous argument 'origin/': unknown revision or path not in the wo=
rking tree.
265
Use '--' to separate paths from revisions, like this:
266
'git <command> [<revision>...] -- [<file>...]'
267
+...
+ '[' '!' -f /opt/cip-kernel-config/6.1.y-cip/arm64/renesas_defconfig /opt/=
cip-kernel-config/6.10.y/arm64/renesas_defconfig ']'
277
/opt/build_kernel.sh: line 169: [: /opt/cip-kernel-config/6.1.y-cip/arm64/r=
enesas_defconfig: binary operator expected
278
+ [[ renesas_defconfig =3D=3D *.config ]]
279
+ cp /opt/cip-kernel-config/6.1.y-cip/arm64/renesas_defconfig /opt/cip-kern=
el-config/6.10.y/arm64/renesas_defconfig arch/arm64/configs/
280
cp: will not overwrite just-created 'arch/arm64/configs/renesas_defconfig' =
with '/opt/cip-kernel-config/6.10.y/arm64/renesas_defconfig'
281
<!DOCTYPE html>
282
<html lang=3D"en">
283
  <head>
284
    <meta http-equiv=3D"content-type" content=3D"text/html;
    charset=3DUTF-8">
    ...

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--2lacGvFSJm9aG2zI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZqnfqwAKCRAw5/Bqldv6
8iseAJ4hlBrWrf4kxibCSa/2dsdWajElXgCfVQOaVYVrmRhpIx5HciGs78bSKTI=
=4r06
-----END PGP SIGNATURE-----

--2lacGvFSJm9aG2zI--

