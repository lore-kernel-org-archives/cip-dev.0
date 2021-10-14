Return-Path: <SRS0=HSEd=PC=lists.cip-project.org=bounce+64572+6824+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E283C433EF
	for <cip-dev@archiver.kernel.org>; Thu, 14 Oct 2021 06:55:59 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C54C60D07
	for <cip-dev@archiver.kernel.org>; Thu, 14 Oct 2021 06:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C54C60D07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id PoxdYY4521723xgCmqIawhNh; Wed, 13 Oct 2021 23:55:57 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.5963.1634194555546868426
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Oct 2021 23:55:56 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9E04B1C0BB1; Thu, 14 Oct 2021 08:55:46 +0200 (CEST)
Date: Thu, 14 Oct 2021 08:55:45 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entry this week
Message-ID: <20211014065545.GA18251@amd>
References: <CAODzB9qOyXSQ=P0x1CrPEC1=mCW3PUN4_Zx9hp0ZPpZWbM1WUw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAODzB9qOyXSQ=P0x1CrPEC1=mCW3PUN4_Zx9hp0ZPpZWbM1WUw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: eXT2VKYnn2KSytz1eQBLILPKx4520388AA=
Content-Type: multipart/mixed; boundary="YShkSQ9FKV9Adv4XKJDE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1634194557;
 bh=LosbxbFr2sbOfLv7MLvlQ+t79EzGOqNNHYjzBFcQsL8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=oxfeRlIDPZ3ymyCEly1sVAtH/YexvqKgCSqPWPQeQXy0iRk0OqOtOUaXgkuEkYbI7Xa
 txnaQCNX1UppQV/oSrsv/OCBkt12m+p725cHULf3J6xcQfI/ie/VvlyBl30y30Ret8XF/
 va3gg+FVVh9pq/sMpCC3B44HYPKNt2DYI68=
Message-ID: <20211014065545.8UBwMqPyAuqvT0-ttQaz_eMS75wWm-r2eAOcUTbug3s@z>

--YShkSQ9FKV9Adv4XKJDE
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> * New CVEs
>=20
> CVE-2021-0935: bug is in ipv6 and l2tp code.
>=20
> This CVE addresses two commits, one in the ipv6 stack and the other in l2=
tp.
> There is two introduced commits one is 85cb73f ("net: ipv6: reset
> daddr and dport in sk if connect() fails") was merged in 4.12 and the
> other commit 3557baa ("[L2TP]: PPP over L2TP driver core") was merged
> in 2.6.23-rc1.
>=20
> Fixed commits have been merged since 4.16-rc7 so 4.16 or later kernels
> don't affect this vulnerability.
>=20
> Commit 2f987a76("net: ipv6: keep sk status consistent after datagram
> connect failure") fixes 85cb73f and commit b954f940("l2tp: fix races
> with ipv4-mapped ipv6 addresses") fixes commit 3557baa.
>=20
> To apply patches to 4.4, it needs to fix conflicts.
>=20
> CVSS v3 score is not provided.
>=20
> Fixed status
>=20
> mainline: [2f987a76a97773beafbc615b9c4d8fe79129a7f4,
> b954f94023dcc61388c8384f0f14eb8e42c863c5]
> stable/4.4: not fixed yet

Others are fixed, but this one may be worth watching. Fortunately it
is not remote attack, AFAICT.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmFn1HEACgkQMOfwapXb+vJOwwCcD6JHQKoPlzpu0gfHlxOXsbVU
qqAAnjjiMkADfz2fItH9gdGOG+F8tGPv
=llFL
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--

--YShkSQ9FKV9Adv4XKJDE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6824): https://lists.cip-project.org/g/cip-dev/message/=
6824
Mute This Topic: https://lists.cip-project.org/mt/86301612/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--YShkSQ9FKV9Adv4XKJDE--
