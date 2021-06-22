Return-Path: <SRS0=j6up=LQ=lists.cip-project.org=bounce+64572+6573+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,WEIRD_QUOTING autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B5BC2B9F4
	for <cip-dev@archiver.kernel.org>; Tue, 22 Jun 2021 12:47:12 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17AA96109E
	for <cip-dev@archiver.kernel.org>; Tue, 22 Jun 2021 12:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17AA96109E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6573+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id alpaYY4521723xCCEgpa5Ng3; Tue, 22 Jun 2021 05:47:11 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.8386.1624366030261056595
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Jun 2021 05:47:10 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E17CF1C0B76; Tue, 22 Jun 2021 14:47:07 +0200 (CEST)
Date: Tue, 22 Jun 2021 14:47:07 +0200
From: "Pavel Machek" <pavel@denx.de>
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Pavel Machek <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [cip-dev] Patches that need porting from 4.19 to 5.10-cip tree
Message-ID: <20210622124707.GA26028@duo.ucw.cz>
References: <20210602100440.GA27003@duo.ucw.cz>
 <OSZPR01MB6877A74A6479B7870A3211F0B7099@OSZPR01MB6877.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSZPR01MB6877A74A6479B7870A3211F0B7099@OSZPR01MB6877.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 4Kn6PJtxl8eWI26X5731ACO9x4520388AA=
Content-Type: multipart/mixed; boundary="CaQhRdOCZwYvj6JYDQt7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624366031;
 bh=WAyMMzEAhkkTxYye7FQIDTXj+Z4DRaSiKPgzrbJxK58=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=roFgvQ2TLfixKGQZBTP17fZv5oUjuHP/X5FbBxhySCC554kDklorMhun5SWbseKpXgv
 onh5XRbO2++lj1XOvgyGWz33d3y7lIuGY5naeuYkLwLKHsRis1wiuLQoaEZspCjRSa7TI
 5sct0X9QSGIUuPu1B2x6jY9ePt0/+PLVOD0=

--CaQhRdOCZwYvj6JYDQt7
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Here is the list of patches that are in 4.19-cip but not yet in
> > 5.10... according to my scripting.
>=20
> Prabhakar has reviewed your list and has submitted all of the relevant pa=
tches in his "Renesas RZ/G2 sync patches from 4.19-cip to 5.10-cip" series =
[0].
>

Thanks a lot for doing this (and sorry for all the false positives
=66rom the script).

I went through the list for entries where existing commit was not
identified, and this is the result:

It looks there's a very little work to do: we need to pull 5.10.18
into our tree and there are 4 patches marked as "not required" we need
to somehow deal with.

Given that we have them in 4.19 (and they add hardware support and are
not really invasive), could I ask for their 5.10 ports? That should be
least surprising. (If they are not required in 4.19 there, we we could
drop them from there, too.)

,,,23,140 49753c6e27ed35223cdab939c34ff1d85f200765 mmc: renesas_sdhi_intern=
al_dmac: Add r8a774e1 support,Not required
,,,103,827 641132722015595793f56fe31765636ddf7a6999 arm64: Add Renesas R8A7=
74C0 support,Not required=20
,,,104,828 b6ddebb2cc793ef2fda081fd2ef2439c158caac4 arm64: Add Renesas R8A7=
74A1 support,Not required=20
,,,107,831 76b8e853948bfaff083afb3dd985eb19f3aab30b dt-bindings: arm: Fix R=
Z/G2E part number,Not required=20

Best regards,
								Pavel


* Patches that need porting from 4.19-cip (second pass)

** We don't need to do anything, as problem is already solved in 5.10 in di=
fferent way

,,,31,632 37c7e76a75a0d5906d792628e4747607a963ba24 arm64: dts: renesas: r8a=
774c0: sort subnodes of the soc node,Already sorted in 5.10

** We don't need to do anything, patch is already in 5.10

(script did not recognize upstream tag)

,,,91,"815 7caccda8939c381fc316f450daa9307d227a4a67 ARM: dts: socfpga: Rena=
me socfpga_cyclone5_de0_{sockit, nano_soc}",Don=E2=80=99t care
,,,30,627 0ccb93953810660266f7095e0541c6db19920642 staging: m57621-mmc: del=
ete driver from the tree.,Don=E2=80=99t care

** We don't need to do anything, patch is already in 5.10-stable

,,,119,843 fc1e3f5d1d7f77be91f85d7d4ce94ebfe3d8d284 kvm: check tlbs_dirty d=
irectly,Don=E2=80=99t care
in 5.10.7
,,,120,844 2c68bb33dad9f3cab171bb64e1766bc5a7e9b7e8 scsi: qla2xxx: Fix cras=
h during driver load on big endian machines,Don=E2=80=99t care
in 5.10.4

** Patch series is already in 5.10.18, we need to pull it to -cip

,,,121,845 98f16e171e2849dba76e2e0346e914452c030dc5 xen-blkback: fix error =
handling in xen_blkbk_map(),Don=E2=80=99t care
upstream: 871997bc9e423f05c7da7c9178e62dde5df2a7f8
,,,122,"846 f84c00fbd27b043fa42a56eaaa14e293877bc69b xen-scsiback: don't ""=
handle"" error by BUG()",Don=E2=80=99t care
upstream: 7c77474b2d22176d2bfb592ec74e0f2cb71352c9
,,,123,"847 717faa776ca2163119239ea58bb78c4d732d8a4f xen-netback: don't ""h=
andle"" error by BUG()",Don=E2=80=99t care
commit 3194a1746e8aabe86075fd3c5e7cf1f4632d7f16 upstream.
,,,124,"848 a01b49a9bf91a723f541139c063c1ff681ac536a xen-blkback: don't ""h=
andle"" error by BUG()",Don=E2=80=99t care
commit 5a264285ed1cd32e26d9de4f3c8c6855e467fd63 upstream.
,,,125,849 271a3984f73c485f4c1b796a61cc5bd3994a0463 xen/arm: don't ignore r=
eturn errors from set_phys_to_machine,Don=E2=80=99t care
commit 36bf1dfb8b266e089afa9b7b984217f17027bf35 upstream.
,,,126,850 e07f06f6bbeed5bf47fed79ac6a57ec62b33304a Xen/gntdev: correct err=
or checking in gntdev_map_grant_pages(),Don=E2=80=99t care
commit ebee0eab08594b2bd5db716288a4f1ae5936e9bc upstream.

** Investigate:

,,,23,140 49753c6e27ed35223cdab939c34ff1d85f200765 mmc: renesas_sdhi_intern=
al_dmac: Add r8a774e1 support,Not required
,,,103,827 641132722015595793f56fe31765636ddf7a6999 arm64: Add Renesas R8A7=
74C0 support,Not required=20
,,,104,828 b6ddebb2cc793ef2fda081fd2ef2439c158caac4 arm64: Add Renesas R8A7=
74A1 support,Not required=20
,,,107,831 76b8e853948bfaff083afb3dd985eb19f3aab30b dt-bindings: arm: Fix R=
Z/G2E part number,Not required=20

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYNHbywAKCRAw5/Bqldv6
8pisAJ9lRyBwyVk2FIY54aj8BSvF/5wNRQCfQiz1tmTKxSjSYHTGji6C0viWdxI=
=tnwh
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--

--CaQhRdOCZwYvj6JYDQt7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6573): https://lists.cip-project.org/g/cip-dev/message=
/6573
Mute This Topic: https://lists.cip-project.org/mt/83254843/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--CaQhRdOCZwYvj6JYDQt7--
