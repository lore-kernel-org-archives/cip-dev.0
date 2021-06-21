Return-Path: <SRS0=OI9q=LP=lists.cip-project.org=bounce+64572+6563+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E934C4743C
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 19:36:36 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E446102A
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 19:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E446102A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6563+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id yr42YY4521723xjSmWneQXhd; Mon, 21 Jun 2021 12:36:34 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.2054.1624304193448428325
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Jun 2021 12:36:34 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EEB7F1C0B76; Mon, 21 Jun 2021 21:36:29 +0200 (CEST)
Date: Mon, 21 Jun 2021 21:36:29 +0200
From: "Pavel Machek" <pavel@denx.de>
To: Chris.Paterson2@renesas.com, cip-dev@lists.cip-project.org
Subject: [cip-dev] Failing -stable-rc tests
Message-ID: <20210621193629.GA22045@duo.ucw.cz>
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
X-Gm-Message-State: qZHJuKsn0YddpdSRyu4D2dYkx4520388AA=
Content-Type: multipart/mixed; boundary="5fSjiG6CIJpGLBuL0KxP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624304194;
 bh=qzRBG1yDglez7girh9R5w7Ke6oer3durHQoiBK6SK88=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=qjjYh4Sj6xhOi87+LYnWiXQkBQa5CaDoJ4XbZXD/KE0467VPr1kUJ/7tl143c6MgHXN
 cLp9ZQ0UEjE1jl2WTB6Pv8iodiXhWHLDLqRLWKVhbKLkIvtZirNAcCx020Z7jO4jSO/zO
 NumFFGtKmLhCZNTy7Nb51GXeDJNsLDRWhpY=

--5fSjiG6CIJpGLBuL0KxP
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

This is one of the common failures:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/136421=
0937

The other one was not seen today.

Uploading binaries
79------------------
80upload: output/bzImage_siemens_ipc227e_defconfig_5.10.46-rc1_c00b84692/x8=
6/siemens_ipc227e_defconfig/config/.config to s3://download.cip-project.org=
/ciptesting/ci/bzImage_siemens_ipc227e_defconfig_5.10.46-rc1_c00b84692/x86/=
siemens_ipc227e_defconfig/config/.config
81upload: output/bzImage_siemens_ipc227e_defconfig_5.10.46-rc1_c00b84692/x8=
6/siemens_ipc227e_defconfig/kernel/bzImage to s3://download.cip-project.org=
/ciptesting/ci/bzImage_siemens_ipc227e_defconfig_5.10.46-rc1_c00b84692/x86/=
siemens_ipc227e_defconfig/kernel/bzImage
82upload: output/bzImage_siemens_ipc227e_defconfig_5.10.46-rc1_c00b84692/x8=
6/siemens_ipc227e_defconfig/modules/modules.tar.gz to s3://download.cip-pro=
ject.org/ciptesting/ci/bzImage_siemens_ipc227e_defconfig_5.10.46-rc1_c00b84=
692/x86/siemens_ipc227e_defconfig/modules/modules.tar.gz
83fatal error: Could not connect to the endpoint URL: "https://s3.us-west-2=
=2Eamazonaws.com/download.cip-project.org?list-type=3D2&prefix=3Dciptesting=
%2Fci%2F&continuation-token=3D1B7XIJq02rzWljriOBePCr8doMhusLUS2jft0k2cLqJDm=
AxWeWFzs3V30zhXBtgfV87AvBf1P519d7AYS%2Bp7qt3yEDm7KapIDVvcmIAG8WJCA7F3O0u488=
Gs0%2F7oSTol6DRSt%2Btj3%2FJ4pXB7ZEDL47m4GSSNa0YzUJuMi%2B%2F5MyuaYuejHVTPV5m=
Lw0GBv5oSzxDtIktUYrKcshmrP2CJh5A%3D%3D&encoding-type=3Durl"
85
Uploading artifacts for failed job
01:39
86Uploading artifacts...
87output: found 11 matching files and directories   =20
88ERROR: Uploading artifacts as "archive" to coordinator... error  error=3D=
couldn't execute POST against https://gitlab.com/api/v4/jobs/1364210937/art=
ifacts?artifact_format=3Dzip&artifact_type=3Darchive&expire_in=3D1+month: P=
ost https://gitlab.com/api/v4/jobs/1364210937/artifacts?artifact_format=3Dz=
ip&artifact_type=3Darchive&expire_in=3D1+month: dial tcp: i/o timeout id=3D=
1364210937 token=3Dd4_rH_yF
89

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYNDqPQAKCRAw5/Bqldv6
8lXPAKCMUSOILZCneA+9Bpf6nkccpxMhuwCfWgNwEOFRrtw5tA1gmCZzFljQUb4=
=WIJq
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--

--5fSjiG6CIJpGLBuL0KxP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6563): https://lists.cip-project.org/g/cip-dev/message=
/6563
Mute This Topic: https://lists.cip-project.org/mt/83697468/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--5fSjiG6CIJpGLBuL0KxP--
