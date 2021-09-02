Return-Path: <SRS0=mn5f=NY=lists.cip-project.org=bounce+64572+6715+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F010C432BE
	for <cip-dev@archiver.kernel.org>; Thu,  2 Sep 2021 06:28:10 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BC2060F21
	for <cip-dev@archiver.kernel.org>; Thu,  2 Sep 2021 06:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2BC2060F21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id jIvgYY4521723x2jze5cz0lV; Wed, 01 Sep 2021 23:28:08 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.3377.1630564086222092130
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Sep 2021 23:28:07 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 952601C0B7F; Thu,  2 Sep 2021 08:28:00 +0200 (CEST)
Date: Thu, 2 Sep 2021 08:27:59 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entry this week
Message-ID: <20210902062759.GA25051@amd>
References: <CAODzB9orf2AFV9fRwu-VBJxOiJTKvcyhHmihpy3EXH3yB5PEXA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAODzB9orf2AFV9fRwu-VBJxOiJTKvcyhHmihpy3EXH3yB5PEXA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ZNl640t4MPUR5PX2QDpuIhOmx4520388AA=
Content-Type: multipart/mixed; boundary="PzF4HNabwm0HmhMMVDSD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1630564088;
 bh=TNaOoMDHctXvET+j16PKxUJo6VjI4vz7FYo4Vd3U4Nk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=SunxmlL0wXt4bLKnByU1tlmb+wR+8D+Rz+syCxNQGZi+qoM00673GbZVSns21vG5rYM
 ZyJ3Lb+VCQZCRrcxlcNKfyJWLYXocD/BMsrQq11q4IfzLjyQL6A7WCVhNK7YnPioWbIHt
 tb01PYSQpI2+nntDGdQpgEZ2c2f0yX0USmo=

--PzF4HNabwm0HmhMMVDSD
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> * CVE short summary

These summaries are not so short; I simply skip them and go to full
list. Perhaps they don't need to be included, or could include only
CVEs where we need to take an action?

> * CVE detail
>=20
> New CVEs
>=20
> CVE-2021-3739: btrfs: fix NULL pointer dereference when deleting
> device by invalid id
>=20
> Fixed in btrfs tree but not fixed in mainline yet.
> This vulnerability has been introduced since 4.20-rc1 so before 4.20
> kernel aren't affected this vulnerability.
>=20
> Fixed status
>=20
> mainline: [e4571b8c5e9ffa1e85c0c671995bd4dcc5c75091]

This one is queued for 5.10.62, so this is getting fixed for us.

> CVE-2021-3743: out-of-bound Read in qrtr_endpoint_post in net/qrtr/qrtr.c
>=20
> The Qualcomm's IPC router protocol(qrtr) has been introduced since
> 4.15-rc1 so before 4.15 kernels aren't affected.
> Checked on cip-kernel-config, it looks like no CIP member enables QRTR.
>=20
> Fixed status
>=20
> mainline: [7e78c597c3ebfd0cb329aa09a838734147e4f117]

Fixes are queued for 4.19 and 5.10.62, so this is getting fixed for us.

> CVE-2021-3753: A out-of-bounds caused by the race of KDSETMODE in vt
>=20
> Commit ffb324e6f874121f7dce5bdae5e05d02baae7269 introduced race
> condition and oob bug. The commit ffb324e6f874 have been backported to
> 4.4 and 4.19.

Agreed, fixed in 4.19.192 and 4.4.270. Nothing for us to do there.

> Updated CVEs
>=20
> CVE-2020-3702: Specifically timed and handcrafted traffic can cause
> internal errors in a WLAN device that lead to improper layer 2 Wi-Fi
> encryption with a consequent possibility of information disclosure
> over the air for a discrete set of traffic
>=20
> Vulnerability in ath9k driver. 4.4.y-cip/arm/siemens_imx6_defconfig
> and 4.4.y-cip/arm/moxa_mxc_defconfig use ath9k.

Fixed in 4.14 but not 4.4.

> stable/4.14: [2cbb22fd4b4fb4d0822d185bf5bd6d027107bfda,
> 20e7de09cbdb76a38f28fb71709fae347123ddb7,
>   995586a56748c532850870523d3a9080492b3433,
> f4d4f4473129e9ee55b8562250adc53217bad529,
>   61b014a8f8de02bedc56f76620170437f5638588]

Diffstat looks like this:

 key.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)
 main.c |    5 +++++
 1 file changed, 5 insertions(+)
 ath.h |    1 +
 key.c |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)
 ath.h                |    2 +-
 ath5k/mac80211-ops.c |    2 +-
 ath9k/htc_drv_main.c |    2 +-
 ath9k/main.c         |    5 ++---
 key.c                |   34 +++++++++++++++++-----------------
 5 files changed, 22 insertions(+), 23 deletions(-)
 hw.h   |    1=20
 main.c |   87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++-
 2 files changed, 87 insertions(+), 1 deletion(-)

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmEwbu8ACgkQMOfwapXb+vJnGwCgqmAIqR3bZBNKn1ektkvs6Xn8
XhsAnjN5dTQyY3GUGlQ5qBCD9+XZZmrb
=Joh1
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

--PzF4HNabwm0HmhMMVDSD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6715): https://lists.cip-project.org/g/cip-dev/message/=
6715
Mute This Topic: https://lists.cip-project.org/mt/85318439/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--PzF4HNabwm0HmhMMVDSD--
