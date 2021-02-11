Return-Path: <SRS0=+Pjs=HN=lists.cip-project.org=bounce+64572+6171+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552DEC433E0
	for <cip-dev@archiver.kernel.org>; Thu, 11 Feb 2021 11:39:10 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853F764DB1
	for <cip-dev@archiver.kernel.org>; Thu, 11 Feb 2021 11:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853F764DB1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6171+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NnNRYY4521723xUILd5qLrhX; Thu, 11 Feb 2021 03:39:08 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.7270.1613043547783325110
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Feb 2021 03:39:08 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 405211C0B8A; Thu, 11 Feb 2021 12:39:03 +0100 (CET)
Date: Thu, 11 Feb 2021 12:39:02 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Chen-Yu Tsai <wens@csie.org>
Cc: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	masashi.kudo@cybertrust.co.jp
Subject: Re: [cip-dev] Cip-kernel-sec Updates for Week of 2021-02-11
Message-ID: <20210211113902.GA30740@amd>
References: <CAGb2v64SEFQBXfGhC_WDP-2SyJbtAdzmsdZjbiygUhP9pE4a0g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGb2v64SEFQBXfGhC_WDP-2SyJbtAdzmsdZjbiygUhP9pE4a0g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: oDkR9lncmkP7lFGlCFO4Ays3x4520388AA=
Content-Type: multipart/mixed; boundary="Kaa3KWDO1vXMg6Ln4joG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1613043548;
 bh=VndERxVbau5rnDgKhSyD/UC/dVRVEZsHChRRc5t9zMY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=BCnxqjgCnDIaS/DBfML5qob7RQw1xuUXaB7DbFtqnToVk774sxopmlLEtUD0p/wOdiA
 j5SweP8w5pi5MWLDpjGNkJawM+WJemnUk6PBRQUeTMiqe3l8jWmQosKE/UY/Nl3ogwWkx
 P+WIoBq0OYdn3K9hnzgD+WT2wwMxlqnR+pE=

--Kaa3KWDO1vXMg6Ln4joG
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Six new issues this week:
> - CVE-2020-12362, CVE-2020-12363, CVE-2020-12364:
>   CVEs from Intel Advisory affecting Intel Graphics Driver. Details
> unknown

It seems there's more for the intel graphics, but it is not mentioned
in our repository. OTOH trailer there that these are rather old
issues, fixed in 5.5...

Best regards,
								Pavel

https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-0=
0438.html

CVEID: CVE-2020-0544

Description: Insufficient control flow management in the kernel mode
driver for some Intel(R) Graphics Drivers before version 15.36.39.5145
may allow an authenticated user to potentially enable escalation of
privilege via local access.

CVSS Base Score: 8.8 High

CVSS Vector: CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:C/C:H/I:H/A:H



CVEID: CVE-2020-0521

Description: Insufficient control flow management in some Intel(R)
Graphics Drivers before version 15.45.32.5145 may allow an
authenticated user to potentially enable escalation of privilege via
local access.

CVSS Base Score: 7.7 High

CVSS Vector: CVSS:3.1/AV:L/AC:H/PR:L/UI:N/S:C/C:H/I:H/A:L

=2E..

Affected Products:
Intel=AE Graphics Drivers for 3rd, 4th, 5th, 6th, 7th, 8th, 9th and 10th
Generation Intel=AE Processors for Windows* 7, 8.1 and 10 before
versions 15.33.51.5146, 15.36.39.5145, 15.40.46.5144, 15.45.32.5164,
26.20.100.8141, 27.20.100.8587 and Intel=AE Graphics Drivers for Linux
before Linux kernel version 5.5.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmAlF1UACgkQMOfwapXb+vICswCfZUkDo4OHhX9vFapArmWeeoVu
woEAn0gYfyKFpiofn1M06cqelOLHDInn
=GkWq
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--

--Kaa3KWDO1vXMg6Ln4joG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6171): https://lists.cip-project.org/g/cip-dev/message=
/6171
Mute This Topic: https://lists.cip-project.org/mt/80553474/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Kaa3KWDO1vXMg6Ln4joG--
