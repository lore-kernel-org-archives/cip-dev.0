Return-Path: <SRS0=Q/Mf=O3=lists.cip-project.org=bounce+64572+6802+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80B8C433FE
	for <cip-dev@archiver.kernel.org>; Thu,  7 Oct 2021 07:31:03 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00EB061130
	for <cip-dev@archiver.kernel.org>; Thu,  7 Oct 2021 07:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 00EB061130
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 1UQwYY4521723xoLaTUdld1k; Thu, 07 Oct 2021 00:31:02 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.8272.1633591860851811937
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Oct 2021 00:31:01 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5C6181C0B87; Thu,  7 Oct 2021 09:30:55 +0200 (CEST)
Date: Thu, 7 Oct 2021 09:30:54 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entry this week
Message-ID: <20211007073054.GA10302@duo.ucw.cz>
References: <CAODzB9rKixC0p_tFV=qR7sTgPqS1ZxuXJJnkPufW+z-m8NFHxA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAODzB9rKixC0p_tFV=qR7sTgPqS1ZxuXJJnkPufW+z-m8NFHxA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: c3sKqbdCQGRKfU3bKbqfsG49x4520388AA=
Content-Type: multipart/mixed; boundary="1DBjnBruIjFNTesGZ1z0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1633591862;
 bh=uSMksWx332wETAwLoRPPlmM28iYYpXmuJvEHoyKucRk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=VYbQH7oq4YlQVkpqULvRApTWMTG5ZAm6/fMejvnQZ8md1T++34qLS4eklElgcZqBHOT
 MdNJwic3R+wBTP6GwR/Bzp4xUTlJ7uO3UTkwgfSvYaxnhiedhxzcLBD+yaucjgVgGMBIR
 fj2tojzsaANwEDppcAoX+gwxdmFo+x6ob1Q=
Message-ID: <20211007073054.ZWG9AeJ7x8lz-nUR7j6E4tMYTHee4FaLXdeA84EFwmo@z>

--1DBjnBruIjFNTesGZ1z0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> It's this week's CVE report.
>=20
> This week reported  new CVEs.
>=20
> * New CVEs
>=20
> CVE-2021-41864: bpf: Fix integer overflow in prealloc_elems_and_freelist()
>=20
> CVSS v3 score is not provided.
>=20
> Patch 30e29a9a2bc6 (bpf: Fix integer overflow in
> prealloc_elems_and_freelist()
=2E..
> Fixed status
>=20
> Fix patch has been merged into bpf tree, but not in the mainline yet.

I guess we can wait for this to be merged through normal channels.

> * Updated CVEs
>=20
> CVE-2019-19449: mounting a crafted f2fs filesystem image can lead to
> slab-out-of-bounds read access in f2fs_build_segment_manager in
> fs/f2fs/segment.c
>=20
> This patch has been merged since 5.10-rc1.
> For 5.4, patch can be applied via git-am. For 4.4 and 4.19, patch can
> be applied via git-am with -3 option.
>=20
> Fixed status
>=20
> mainline: [3a22e9ac71585bcb7667e44641f1bbb25295f0ce]
> stable/5.10: [3a22e9ac71585bcb7667e44641f1bbb25295f0ce]

It may make sense to help with this backport.

> CVE-2021-37159: net: hso: do not call unregister if not registered
>=20
> 4.14, 4.19, and 5.4 have been fixed. 4.4 and 4.9 haven't been fixed
> yet. However, patch can be applied to 4.4 and 4.9 without any
> modification. According to cip-kernel-config, no CIP member use HSO
> module.

Not sure why this has CVE number. We probably need not care.

> CVE-2021-38300: bpf, mips: Validate conditional branch offsets
>=20
> This vulnerability is only affected to MIPS architecture. No cip
> member use MIPS architecture.
>=20
> 5.10 has been fixed. Applying this fix to 4.4, 4.9, 4.19, and 5.4, it
> needs to modify the patch.
>=20
> Fixed status
>=20
> mainline: [37cb28ec7d3a36a5bace7063a3dba633ab110f8b]
> stable/5.10: [c61736a994fe68b0e5498e4e84e1c9108dc41075]

I guess we don't care about MIPS.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYV6iLgAKCRAw5/Bqldv6
8iqCAKCPev+etMNYIa2vTP7SV/6qf+ZzJgCguaVjqBb199MB+q9d2mbcUD/H9Rs=
=b0Ub
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--

--1DBjnBruIjFNTesGZ1z0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6802): https://lists.cip-project.org/g/cip-dev/message/=
6802
Mute This Topic: https://lists.cip-project.org/mt/86134956/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--1DBjnBruIjFNTesGZ1z0--
