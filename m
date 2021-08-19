Return-Path: <SRS0=rIiB=NK=lists.cip-project.org=bounce+64572+6697+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC78CC4338F
	for <cip-dev@archiver.kernel.org>; Thu, 19 Aug 2021 07:23:27 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1616160E78
	for <cip-dev@archiver.kernel.org>; Thu, 19 Aug 2021 07:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1616160E78
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3APBYY4521723xwGRy0Sk2Ei; Thu, 19 Aug 2021 00:23:26 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.66584.1629357804897978579
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Aug 2021 00:23:26 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CA90E1C0B77; Thu, 19 Aug 2021 09:23:13 +0200 (CEST)
Date: Thu, 19 Aug 2021 09:23:12 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Old CVE entries worth watching -- was Re: [cip-dev] New CVE entries this week
Message-ID: <20210819072312.GC32099@amd>
References: <CAODzB9ra5A_NkvqgPMhXc8PR17gaC+R3FU4mfA-_scKGo1Mspw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAODzB9ra5A_NkvqgPMhXc8PR17gaC+R3FU4mfA-_scKGo1Mspw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: wrXLGbUiuSnFfWzwPBsy24U3x4520388AA=
Content-Type: multipart/mixed; boundary="9ff3CvuU5OPt0CIGNgyH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1629357806;
 bh=nyIjzmZRDJXmpvYs1mlZ4dnxWkmDDlkpUnHw7oYQaSA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=oDtawIfLfUF1cmDr672VUKRbDKvKZ7iM2UuW9KX/n2tsdSoLSnW0gf4gqH6vadK8PLi
 AUsMkcS9keAGvqtgpapKc0gNh9jifs0E8Gv7Rc39ddb/mNTO3w+uATQP1/+RvFtpY5WBo
 nqP+i7Yq095VDgQG7sJsbhAetFPpVaaKr8I=

--9ff3CvuU5OPt0CIGNgyH
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Content-Disposition: inline

--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I was going through CVE entries for a month or so and these
accumulated in that time. Would it make sense to add them to the
current "watch list"?

** Bluetooth

Unfortunately, not enough info is present here:

CVE-2020-26555 -- BR/EDR pin code pairing broken
CVE-2020-26556 CVE-2020-26557 CVE-2020-26559 CVE-2020-26560 -- bluetooth me=
sh

** BPF

CVE-2021-3600 -- More eBPF  issues. 4.19+, but we still may need to
fix 4.19

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmEeBuAACgkQMOfwapXb+vKIuwCfREBgrHlNRs4+YtvzdkVJUQma
KlAAnjH/R/BaP+rOVmxlsl+dyzgnO7oa
=NEqq
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--

--9ff3CvuU5OPt0CIGNgyH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6697): https://lists.cip-project.org/g/cip-dev/message/=
6697
Mute This Topic: https://lists.cip-project.org/mt/84991735/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--9ff3CvuU5OPt0CIGNgyH--
