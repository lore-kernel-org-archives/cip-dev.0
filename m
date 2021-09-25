Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37120C433F5
	for <webhook@archiver.kernel.org>; Sat, 25 Sep 2021 20:06:33 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.10894.1632600391092377944
 for <cip-dev@lists.cip-project.org>;
 Sat, 25 Sep 2021 13:06:31 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6D9E31C0BF7; Sat, 25 Sep 2021 22:06:25 +0200 (CEST)
Date: Sat, 25 Sep 2021 22:06:25 +0200
From: Pavel Machek <pavel@denx.de>
To: Chris.Paterson2@renesas.com, cip-dev@lists.cip-project.org
Subject: Prompt timeouts on ipc227e board -- randomness related?
Message-ID: <20210925200625.GA19637@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 25 Sep 2021 20:06:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6749


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

It is not first time I see this failure:

https://lava.ciplatform.org/scheduler/job/444336


[[0;32m  OK  [0m] Started Login Service.
[[0m[0;31m*     [0m] (1 of 2) A start job is running for=E2=80=A6ate sshd h=
ost keys (7s / no limit)[K[[0;1;31m*[0m[0;31m*    [0m] (1 of 2) A start job=
 is running for=E2=80=A6ate sshd host keys (8s / no limit)[K[[0;31m*[0;1;31=
m*[0m[0;31m*   [0m] (1 of 2) A start job is running for=E2=80=A6ate sshd ho=
st keys (9s / no limit)[K[ [0;31m*[0;1;31m*[0m[0;31m*  [0m] (2 of 2) A star=
t job is running for=E2=80=A6evices-eth0.device (8s / 1min 30s)[   19.85532=
8] systemd[1]: apt-daily-upgrade.timer: Adding 3min 2.027476s random time.
[   19.864207] systemd[1]: apt-daily.timer: Adding 1h 54min 15.794344s rand=
om time.
[   21.406490] systemd[1]: apt-daily-upgrade.timer: Adding 55min 47.041488s=
 random time.
[   21.415357] systemd[1]: apt-daily.timer: Adding 11h 48min 4.457495s rand=
om time.
[   22.049807] systemd[1]: apt-daily-upgrade.timer: Adding 3min 54.125406s =
random time.
[   22.058500] systemd[1]: apt-daily.timer: Adding 8h 34min 47.388595s rand=
om time.
[   22.511646] systemd[1]: apt-daily-upgrade.timer: Adding 25min 13.015405s=
 random time.
[   22.520510] systemd[1]: apt-daily.timer: Adding 11h 58min 24.212170s ran=
dom time.
[K[[0;32m  OK  [0m] Started Regenerate sshd host keys.
wait for prompt timed out
end: 2.3.4.1 login-action (duration 00:00:24) [common]
case: login-action
case_id: 9417066
definition: lava
duration: 23.98

Any idea what is going on there? Is it just a test problem, or do we
have kernel regression that only happens sometimes?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYU+BQQAKCRAw5/Bqldv6
8lK/AJ9XG+P7uadSvjydqjdK/kiMDPtmkACfarFpuGjZYF8D+q+4T6HqaTMx4mQ=
=aXrF
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--

