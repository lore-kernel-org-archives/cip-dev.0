Return-Path: <SRS0=FRos=LM=lists.cip-project.org=bounce+64572+6534+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA7FC49361
	for <cip-dev@archiver.kernel.org>; Fri, 18 Jun 2021 08:01:56 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02D8F61164
	for <cip-dev@archiver.kernel.org>; Fri, 18 Jun 2021 08:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D8F61164
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6534+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ozLhYY4521723xlJBMAhqNMr; Fri, 18 Jun 2021 01:01:55 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.5049.1624003314066270348
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Jun 2021 01:01:54 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CEE651C0B76; Fri, 18 Jun 2021 10:01:51 +0200 (CEST)
Date: Fri, 18 Jun 2021 10:01:51 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entries this week
Message-ID: <20210618080151.GA25229@amd>
References: <20210610170538.GA12973@amd>
 <CAODzB9rvyCg+=EctmFES3K+_Zi9pOxBJP5AWS8X6to311sscBw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAODzB9rvyCg+=EctmFES3K+_Zi9pOxBJP5AWS8X6to311sscBw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 4dsomDuw8JRGBYf4eine4ORpx4520388AA=
Content-Type: multipart/mixed; boundary="Hp7rdnsiPAQJHwHjsszc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624003315;
 bh=BHm+c4dQlLjB2sF4m8WTiztexETCCuC3oZixooazgYg=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=cI0tNgkBBOrrKoVmEq71smX0wxKKEdlQ0MLO77SL6C8WTwlnMjb+I9n5d1b0gl360XV
 UB1bnH/gQvL6FeLHWUnFPggZK6KTmWYbz1Eoax3hRK/kf7g8Ck9Ie7d7IeYTte+aSgT3r
 SYguioR/o26pQ9kqno8BhIawhH3w6F4eyOs=

--Hp7rdnsiPAQJHwHjsszc
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > CVE-2020-36385 -- An issue was discovered in the Linux kernel before 5.=
8.1. net/bluetooth/hci_event.c has a slab out-of-bounds read in hci_extende=
d_inquiry_result_evt, aka CID-51c19bf3d5cf.
> >
>=20
> According to the  CVE-2020-36385.yml it describes 'RDMA/ucma: Rework
> ucma_migrate_id() to avoid races with destroy'. However According to
> the  CVE-2020-36385.yml it describes 'RDMA/ucma: Rework
> ucma_migrate_id() to avoid races with destroy'. However, the
> description of 'An issue was discovered in the Linux kernel before
> 5.8.1 ...' seems like CVE-2020-36386.

You are right, something went wrong with the import. It is corrected
now.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmDMUu4ACgkQMOfwapXb+vIOowCgpC9fonsRKYF57IzmoaGJEYO3
JRYAnR3OdWwr7+1DA1mVPcZ50paRucxr
=uuqe
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--

--Hp7rdnsiPAQJHwHjsszc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6534): https://lists.cip-project.org/g/cip-dev/message=
/6534
Mute This Topic: https://lists.cip-project.org/mt/83449660/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Hp7rdnsiPAQJHwHjsszc--
