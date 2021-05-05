Return-Path: <SRS0=wJG2=KA=lists.cip-project.org=bounce+64572+6418+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E1EC433B4
	for <cip-dev@archiver.kernel.org>; Wed,  5 May 2021 07:52:05 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84E0A613C4
	for <cip-dev@archiver.kernel.org>; Wed,  5 May 2021 07:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E0A613C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6418+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id tNClYY4521723xHllitT0Gqv; Wed, 05 May 2021 00:52:03 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.4732.1620201122432135872
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 May 2021 00:52:03 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 33D461C0B87; Wed,  5 May 2021 09:51:50 +0200 (CEST)
Date: Wed, 5 May 2021 09:51:49 +0200
From: "Pavel Machek" <pavel@denx.de>
To: Chen-Yu Tsai <wens@csie.org>
Cc: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	masashi.kudo@cybertrust.co.jp
Subject: Re: [cip-dev] Cip-kernel-sec Updates for Week of 2021-05-05
Message-ID: <20210505075149.GA29521@amd>
References: <CAGb2v65PfUtwZX8c+W2Yygk3XTOTxfXU0SoFUjXUAh2wYuHmyA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGb2v65PfUtwZX8c+W2Yygk3XTOTxfXU0SoFUjXUAh2wYuHmyA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: g986l3SXq7l4DgoFbuYUWY6ix4520388AA=
Content-Type: multipart/mixed; boundary="UbAxSgL4OsFHRjJhMI5f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620201123;
 bh=Ir8l3/Ij+qr5v+yEpospc9M+N8Ulv75ufF626FmQxWA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=VgbxPvtsfxLl1XnwU9XgATuYMlL8DcuuGeyl/KViTvi54fJLUnSM4YOtjHEnFSKRI1Q
 jv0zgiw+kWA3Q5Rd1JHtJU3YSyoLvZ7FamwJ/C4smsF7tKupiATcOZ6xUFLgidnidgeZL
 fNkZ/iOJt29JzHIssECZNoUOLQA+qkPQ+zM=

--UbAxSgL4OsFHRjJhMI5f
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Two new CVEs this week:
>=20
> - CVE-2021-31829 [bpf: stack pointer protection from speculative
> arithmetic] - fixed
>   Fixes just landed in mainline as part of the merge window. Fixes not
> tagged for stable.

Could you push your changes to cip-kernel-sec?

These are queued for 5.10.35 and 4.19, I believe they may be related.

v |8373088d4 b9b34d o: 5.10| bpf: Fix masking negation logic upon negative =
dst register
a |fbb1ea771 b9b34d o: 4.19| bpf: Fix masking negation logic upon negative =
dst register
a |024fb2412 801c60 o: 5.10| bpf: Fix leakage of uninitialized bpf stack un=
der speculation

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmCSTpUACgkQMOfwapXb+vJHFwCfTZ8mIGk/7Ecc7gRbFxMPASH4
87MAn2f5RElvJ1mprAt2+1/eV/30eQoA
=j1xQ
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--

--UbAxSgL4OsFHRjJhMI5f
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6418): https://lists.cip-project.org/g/cip-dev/message=
/6418
Mute This Topic: https://lists.cip-project.org/mt/82597445/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--UbAxSgL4OsFHRjJhMI5f--
