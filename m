Return-Path: <SRS0=7S2c=IR=lists.cip-project.org=bounce+64572+6303+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13056C433E0
	for <cip-dev@archiver.kernel.org>; Fri, 19 Mar 2021 11:25:09 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 971F964ED6
	for <cip-dev@archiver.kernel.org>; Fri, 19 Mar 2021 11:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971F964ED6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6303+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id lEchYY4521723xs392qzTNhy; Fri, 19 Mar 2021 04:25:07 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.4860.1616153105785130589
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Mar 2021 04:25:06 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 161391C0B7C; Fri, 19 Mar 2021 12:25:00 +0100 (CET)
Date: Fri, 19 Mar 2021 12:24:59 +0100
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: "cip-members@lists.cip-project.org" <cip-members@lists.cip-project.org>
Subject: Re: [cip-dev] CIP LAVA maintenance
Message-ID: <20210319112459.GA27349@amd>
References: <166D61BDF351CC05.5206@lists.cip-project.org>
 <OSBPR01MB2392E14F337E62A92502D5B1B7689@OSBPR01MB2392.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB2392E14F337E62A92502D5B1B7689@OSBPR01MB2392.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: YC6eAPrhb1AOBvPGeyAzjiSqx4520388AA=
Content-Type: multipart/mixed; boundary="VpsbptuGgafkDGdO3y3R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616153107;
 bh=Bx3vjDzSmqGgmevMdpubzQswhpg9PP5PZu2/553XNRY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ICHtD+D5Hd2D3uTGZkxt8oc62y8RPT8WrxPnAsjkjw/+1ofYdlC4lTPYyygvGb6EKy/
 TZyoN5NpKaaPbR5A4f7XMDat2K7nCfC8qUujwUUMfmJwdJ/TCe3Bp/0KJSuOWjQxEatkB
 Crwm80c+kQL8J8Z92BwYVc2BcRRPBnRgvEA=

--VpsbptuGgafkDGdO3y3R
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > The CIP LAVA infrastructure will be going down for maintenance very soo=
n.
> > Upgrade Gods permitting, it will all be back online later today.
>=20
> Sorry for the delayed notice. All of the labs are back online now.

Thank you, Renesas boards appear to work.

But I still see random failures from
test:x86_siemens_ipc227e_defconfig :

Pipeline #273166880 has failed!

Project: linux-cip (
https://gitlab.com/cip-project/cip-kernel/linux-cip )
Branch: ci/pavel/linux-test (
+https://gitlab.com/cip-project/cip-kernel/linux-cip/-/commits/ci/pavel/lin=
ux-test
)

Commit: a58c985b (
+https://gitlab.com/cip-project/cip-kernel/linux-cip/-/commit/a58c985b03f0b=
798625dc2890bb8b
+cf17caf5995 )
Commit Message: arm64: dts: renesas: Add support for MIPI Adapt...
Commit Author: Lad Prabhakar
Committed by: Pavel Machek

Pipeline #273166880 (
+https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/273166880
) triggered by
+Pavel Machek ( https://gitlab.com/pavelm )
had 1 failed build.

Job #1111610478 (
https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/1111610478/raw
+)

Stage: test
Name: test:x86_siemens_ipc227e_defconfig

Simple resubmit fixed it:

Pipeline has been fixed and #273166880 has passed!

Project: linux-cip (
https://gitlab.com/cip-project/cip-kernel/linux-cip )
Branch: ci/pavel/linux-test (
+https://gitlab.com/cip-project/cip-kernel/linux-cip/-/commits/ci/pavel/lin=
ux-test
)

Commit: a58c985b (
+https://gitlab.com/cip-project/cip-kernel/linux-cip/-/commit/a58c985b03f0b=
798625dc2890bb8b
+cf17caf5995 )
Commit Message: arm64: dts: renesas: Add support for MIPI Adapt...
Commit Author: Lad Prabhakar
Committed by: Pavel Machek

Pipeline #273166880 (
+https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/273166880
) triggered by
+Pavel Machek ( https://gitlab.com/pavelm )
successfully completed 23 jobs in 2 stages.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmBUigsACgkQMOfwapXb+vKxRQCffpKJlNS3DqO7ahwCRb1ZMmuJ
TzsAn3zxLK3t+2u+BGvfID7GxPMO+hyw
=2ZBu
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--

--VpsbptuGgafkDGdO3y3R
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6303): https://lists.cip-project.org/g/cip-dev/message=
/6303
Mute This Topic: https://lists.cip-project.org/mt/81424532/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--VpsbptuGgafkDGdO3y3R--
