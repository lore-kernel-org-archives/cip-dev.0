Return-Path: <SRS0=TEPw=N7=lists.cip-project.org=bounce+64572+6720+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31847C433EF
	for <cip-dev@archiver.kernel.org>; Thu,  9 Sep 2021 07:08:42 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61E1060E94
	for <cip-dev@archiver.kernel.org>; Thu,  9 Sep 2021 07:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 61E1060E94
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NAshYY4521723xJEOnrIKTY3; Thu, 09 Sep 2021 00:08:41 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.4101.1631169719877820676
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Sep 2021 23:42:01 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 25FE21C0B76; Thu,  9 Sep 2021 08:41:54 +0200 (CEST)
Date: Thu, 9 Sep 2021 08:41:49 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entry this week
Message-ID: <20210909064148.GA5892@amd>
References: <CAODzB9oqUztiFZjcd0=dSBJ-bDjfdZ4eW8R69=m0fuZmKOb0qg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAODzB9oqUztiFZjcd0=dSBJ-bDjfdZ4eW8R69=m0fuZmKOb0qg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: tk7sRQ33dm84uiwxp3pW0ccwx4520388AA=
Content-Type: multipart/mixed; boundary="kr6vpELyaCnN4DJQwGtW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1631171321;
 bh=bwtf3FH71341n7NYUdp7l+xjV111bBGHrl2gXbmboOk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Xh3LOHOr1DlDiQSpVESSJS3p8h0YW0mJvXlxfwo56B7w5iWQPWP7mhMhsNAtmOtxE54
 8YFW8QKjyFcGOIX+BL2vin5ysivOOCcfhzM7nHyLCKl1/ECU3S5zZ5SMH3mlbF4PavaOp
 33kYk8EwvXrzQOhIyDjJVdaU3/qSsBWWvsU=

--kr6vpELyaCnN4DJQwGtW
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> CVE-2021-3759: memcg: charge semaphores and sem_undo objects
>=20
> This causes DoS attack. Patch was merged into mainline this week.
>=20
> for 4.19, it needs modify or apply following patches to apply commit
> 18319498fdd4.

I don't think we need to care about this one. Embedded systems don't
usually run untrusted code...

> CVE-2021-40490: A race condition was discovered in
> ext4_write_inline_data_end in fs/ext4/inline.c in the ext4 subsystem
> in the Linux kernel through 5.13.13.

This is already queued to 4.4 and 4.19; we can simply wait.

> CVE-2021-38198: KVM: X86: MMU: Use the correct inherited permissions
> to get shadow page
>=20
> 4.14 has been fixed this week.
>=20
> mainline: [b1bd5cba3306691c771d558e94baa73e8b0b96b7]
> stable/4.14: [cea9e8ee3b8059bd2b36d68f1f428d165e5d13ce]

KVM. Tricky code and not exactly focus on CIP code. But perhaps
someone fixes it for us :-).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmE5rKwACgkQMOfwapXb+vLKSQCeOf9oitgYLwA0kDSOWT7ewITV
ak4AnRhrnlDig20tjn2JKj96ZQGgE6oH
=W+ht
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--

--kr6vpELyaCnN4DJQwGtW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6720): https://lists.cip-project.org/g/cip-dev/message/=
6720
Mute This Topic: https://lists.cip-project.org/mt/85476557/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--kr6vpELyaCnN4DJQwGtW--
