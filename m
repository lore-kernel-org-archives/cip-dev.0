Return-Path: <SRS0=NWY9=OP=lists.cip-project.org=bounce+64572+6749+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A839C433EF
	for <cip-dev@archiver.kernel.org>; Sat, 25 Sep 2021 20:06:34 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13ED36108E
	for <cip-dev@archiver.kernel.org>; Sat, 25 Sep 2021 20:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 13ED36108E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0JwaYY4521723x603BtHWcGz; Sat, 25 Sep 2021 13:06:32 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.10894.1632600391092377944
 for <cip-dev@lists.cip-project.org>;
 Sat, 25 Sep 2021 13:06:31 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6D9E31C0BF7; Sat, 25 Sep 2021 22:06:25 +0200 (CEST)
Date: Sat, 25 Sep 2021 22:06:25 +0200
From: "Pavel Machek" <pavel@denx.de>
To: Chris.Paterson2@renesas.com, cip-dev@lists.cip-project.org
Subject: [cip-dev] Prompt timeouts on ipc227e board -- randomness related?
Message-ID: <20210925200625.GA19637@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: OyRvXW0bmfdQctbhtYSANpRnx4520388AA=
Content-Type: multipart/mixed; boundary="Beoqm7w5yBJkSyM6X7fD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1632600392;
 bh=5XQOXWEEXan06PZXDvkR7dco7y4N1GsdEAOIKyRyd5s=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=WU7AzwBwSsfTEnyQXTeaYlN2BEkV0IZuGz+ExlDtJ5hqnMZOYd7aT9O7Mv3jBRQIF6u
 a3Ytjoai8wORnsayAZxyRNdcyrhvKQUCU/fcZIw9Vcwu05aVqr4jVDGqGyvruz1N6gx1Z
 iw9vRk+0M4YVLqRQdgD5DnQueVmk/J8LKE8=
Message-ID: <20210925200625.2HihaxZzNEv0N_V-ZIegYgYVAMtuFAPkeXMEksxGkRg@z>

--Beoqm7w5yBJkSyM6X7fD
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline

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

--Beoqm7w5yBJkSyM6X7fD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6749): https://lists.cip-project.org/g/cip-dev/message/=
6749
Mute This Topic: https://lists.cip-project.org/mt/85867572/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Beoqm7w5yBJkSyM6X7fD--
