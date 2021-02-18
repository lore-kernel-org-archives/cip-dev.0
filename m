Return-Path: <SRS0=wKX/=HU=lists.cip-project.org=bounce+64572+6183+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7E6C433DB
	for <cip-dev@archiver.kernel.org>; Thu, 18 Feb 2021 09:49:31 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E076148E
	for <cip-dev@archiver.kernel.org>; Thu, 18 Feb 2021 09:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E076148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6183+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id lhFyYY4521723xLVRWlXdOD9; Thu, 18 Feb 2021 01:49:29 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.4736.1613641768397077087
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Feb 2021 01:49:28 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 54C921C0B7C; Thu, 18 Feb 2021 10:49:24 +0100 (CET)
Date: Thu, 18 Feb 2021 10:49:23 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Chen-Yu Tsai <wens@csie.org>
Cc: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	masashi.kudo@cybertrust.co.jp
Subject: Re: [cip-dev] Cip-kernel-sec Updates for Week of 2021-02-18
Message-ID: <20210218094923.GA28023@amd>
References: <CAGb2v67v7o16fV4s7GTgO96P5=g3icjNUNGNs0mDdcm2BZYm=w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGb2v67v7o16fV4s7GTgO96P5=g3icjNUNGNs0mDdcm2BZYm=w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 1flPZUgOtuhGrU91ukBXQZMDx4520388AA=
Content-Type: multipart/mixed; boundary="ZNxdAfeJZoenZGo5KyNr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1613641769;
 bh=IC+CJm9fOCpkfTvantD0ip/tO0IP8S+omght1d8Kf0E=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=wO6ezTIyca2j0dbuQV/VQUl+0RJIFo68Jtjh27veOmrxJESMlbLoA2QvVCCj2S2KfCq
 FlBNQNexmedLbIppW0DXlaRARfeMVlWwTt5mnwZi4oCaXqwHgOCl98HXVETQyuoAUV/DC
 esBAJbn22oVZtxlmxqMa3XFjstuvkU0QSHg=

--ZNxdAfeJZoenZGo5KyNr
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2021-02-18 17:21:57, Chen-Yu Tsai wrote:
> Hi everyone,
>=20
> Five new issues this week:
>=20
> CVE-2021-20239 [setsockopt copy_from_user error] - fixed in 5.4 and
> removed from 5.10
> CVE-2021-26930 [xen-blkback error handling] - PR sent
> CVE-2021-26931 [xen backends: BUG_ON in error handling] - PR sent
> CVE-2021-26932 [xen grant mapping error handling] - PR sent
> CVE-2021-26934 [xen unsupported driver] - Xen documentation change
> stating be-alloc display driver is unsupported
>=20
> Linus doesn't seem to be processing PRs for the new merge window yet,
> so we might have to wait a while before the Xen ones are fixed and
> backported.

Well, Xen is not a typical thing to run on embbeded hardware, but I
did not check the configs.

It seems Linus is having power problems:

Best regards,
								Pavel

Date: Tue, 16 Feb 2021 12:25:06 -0800
=46rom: Linus Torvalds <torvalds@linuxfoundation.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: users@linux.kernel.org
Subject: Re: [kernel.org users] Partial power outage in the PDX
datacentre

[-- Attachment #1 --]
[-- Type: multipart/alternative, Encoding: 7bit, Size: 2.2K --]

Sadly, the power at my house is still entirely out, although cell
service
has now been fixed so at least I can read some email without walking
outside.

But with no power for my laptop or workstation, I won't be starting
the
merge window until power is back more widely in they Portland area.

My neighborhood is likely not a priority, so it very possibly will be
a few
more days (so far without power since Sunday evening).

Even the local highway 43 (ok, not a big highway, but still) is still
closed down two days later due to downed trees.

        Linus
=09

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmAuOCMACgkQMOfwapXb+vK3iACgs0B2QRU0o8LW4eMdwwIBpQ8s
fHIAoJS2Sa9fjDB6y8soRGVBfVLP/VBg
=eO5a
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--

--ZNxdAfeJZoenZGo5KyNr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6183): https://lists.cip-project.org/g/cip-dev/message=
/6183
Mute This Topic: https://lists.cip-project.org/mt/80725760/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ZNxdAfeJZoenZGo5KyNr--
