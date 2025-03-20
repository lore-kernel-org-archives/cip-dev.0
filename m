Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A6CC28B30
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 11:47:58 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.5477.1742471272410083706
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Mar 2025 04:47:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=dQnBBWE7;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D026C1020404E;
	Thu, 20 Mar 2025 12:47:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742471270; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=8w7GUHpoIjmW/0dWohbZ3T/tL2AjZa8jHjyGiodFU5U=;
	b=dQnBBWE7VCWmVuzpkXGhefKYkgZO64LE/t25jiyua8/CLrI42dI2nSMsgcvWGdU/WhiXM2
	yMer332T3qBkNI4rWBIz0U3OvTyztkFw9zgaUZlq9nTuxUfNLw9+xqqmNz4+RyLosea9U1
	OWA4dJbfDcn+xNFhHrwEn13+N/wD5ql0uGO1UzCmtHjqHU2z1DcXmmxkfscYGuNHKBhSCH
	izR8zwx7f8akS+RMAkHaNjXEeYRpyaKwlSLdVPKLjDxiAasK2rF/tNC6IAwfNFfHeUnwoE
	aWGjyDdQJuZDaodcWoTWKGYSNdhw8CaFQdUMHLdq/G8usFLRlCxfYxdkmrHkGQ==
Date: Thu, 20 Mar 2025 12:47:44 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, jan.kiszka@siemens.com,
	Chris.Paterson2@renesas.com
Subject: Re: [cip-dev] Starting 6.12-cip branch
Message-ID: <Z9wAYJL0y0Q/WnoA@duo.ucw.cz>
References: <182E7EC480622B22.30505@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qQrV7pF6fGJORMlY"
Content-Disposition: inline
In-Reply-To: <182E7EC480622B22.30505@lists.cip-project.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Mar 2025 11:47:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18294


--qQrV7pF6fGJORMlY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> So... I'm starting 6.12-cip branch. It is based on 6.12.19 and I
> already pushed tree to kernel.org:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinux-6.12.y-cip
>=20
> Next steps should be starting testing the branch. Chris, could you
> suggest appropriate gitlab-ci file? [Or even better, could we test the
> branch without the gitlab-ci file, as we are doing for stable trees?]
>=20
> This error will need to be investigated:
>=20
> fatal: Not a valid commit name
> be20a73e03e19005cfa5c1c4d6158af1ba02f056

So we have this in our 6.1 tree:

commit 39a7d6ce0283d0f2b7b5bec585a56954509a6103
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Date:   Fri Jan 24 10:59:57 2025 +0200

    clk: renesas: vbattb: Add VBATTB clock driver
   =20
    commit be20a73e03e19005cfa5c1c4d6158af1ba02f056 upstream.

But that upstream commit does not exist. I'll need to investigate
more.

Most of patches ported okay, I'll push the results now and investigate
the rest.

> These commits will need to be ported from 6.1-rebase branch:
>=20
> Collecting commits
> Parsing commits
> Checking commits not in v6.12
ok > 2 546875ccba938ba4f7b5c616a1a1e334c5f2903f a63fe5138f27d91f850abb52f6a=
0df37991b1e3e net: ravb: Add VLAN checksum support
ok > 3 85c171509821af048a45b435e0fac36edba6a0cb a993245cf3ad5d1164a71475eec=
17fd51e28201f net: ravb: Enable IPv6 TX checksum offload for GbEth
ok > 4 59cceae40c67d943687587912483d68226cd04de e7b69b28560bb977a05ab6ff280=
769b5a2ec1ee4 net: ravb: Enable IPv6 RX checksum offloading for GbEth
ok > 5 e63b5fd02a00aab8e79691359e931dafcd9dfd05 e8486d788dab19ddc25358196c4=
859e3dda4456a net: ravb: Simplify UDP TX checksum offload
ok > 6 4574ba5b711d7f7968c116521ef58d46fd4f89b1 c28d544f32b95153155c94fb741=
1f2d6fa14bcd1 net: ravb: Disable IP header TX checksum offloading
ok > 7 faacdbba01802c89f7043f9a47ad442c1195d307 a7548baf2b4f58b75292cddd358=
30a230c77f9dd net: ravb: Simplify types in RX csum validation
ok > 8 5a2d973e36061cbf8d1ba00a9294244522715e53 15053ac983ab9fc781aeaa006c7=
c8b817b0bbb03 net: ravb: Combine if conditions in RX csum validation
ok > 9 8d2109c1a51525c3586c5bf6f78ab1ce3c2908f8 a1bdc025b634187d6d7cc462c58=
39ece8e102934 net: ravb: Drop IP protocol check from RX csum verification
ok > 10 c4e347a02b14fa2425337473fcb120c62936cbc5 ac242a57ad28de613c61b76cb8=
2b7d30a0e70e37 net: ravb: Disable IP header RX checksum offloading
ok > 11 8e3037924a36505531999df8f5847a68b9272c41 c3aef62f4dd2ce3fe35d45fdc5=
cfdebc02b22285 net: ravb: Factor out checksum offload enable bits
ok > 16 c520bbb523304ba98de9ffeeb0ef289921434125 aefdfb4c1c3ff4503caad2c357=
cab0fc4b910aea arm64: defconfig: Enable VBATTB clock and Renesas RTCA-3
ok > 17 0cd647cd53db0315361e41056e10739a5ee1e668 8d96cc36644ab5500f9b48f2f5=
1d9473d77d29af arm64: dts: renesas: rzg3s-smarc-som: Enable RTC
ok > 18 2d768aee9f5294d2023e824c0906e2e7d1414629 8b8fef2d3115f20327438e7aae=
01cb80b0f87ff0 arm64: dts: renesas: r9a08g045: Add RTC node
ok > 19 ac948eb8ead1265ff034955bdbbb081744f1e7ed 011c639f99a749cbfc5256f91a=
5e6b0dc0c7835a arm64: dts: renesas: rzg3s-smarc-som: Enable VBATTB
ok > 20 23c44956bce5aa79c060fc3e5d51843735e6eda6 b3c797ba7dfe077b81bd521ef9=
4574238f2982e1 arm64: dts: renesas: r9a08g045: Add VBATTB node
ok > 21 8f315a5c7376b2bc324d62a8400184da77f25e28 d0207ac40f9b01a737a657f19f=
66294acc70d8aa rtc: renesas-rtca3: Fix compilation error on RISC-V
ok > 22 d4488377609e36cd9785533c29ccea4b86c292b9 541924b0a8c2a69974ced3cc9d=
56d2f4fd056fac rtc: renesas-rtca3: Add driver for RTCA-3 available on Renes=
as RZ/G3S SoC
ok > 23 71c61a45c951eca67dd2cbc4de9cdd687ece4ead e8e3acfa534f32c5d1afc1255c=
eca88577afa172 dt-bindings: rtc: renesas,rzg3s-rtc: Document the Renesas RT=
CA-3 IP
?? > 24 be20a73e03e19005cfa5c1c4d6158af1ba02f056 db7542114675a85d50f8b41b9c=
f342df7d0a7bf6 clk: renesas: vbattb: Add VBATTB clock driver
ok > 25 cdfd5daf90af8363fb1f58e08c829a775b2e2fc5 d7ae15b36472510c35f08d5c45=
7e1525fff0d960 dt-bindings: clock: renesas,r9a08g045-vbattb: Document VBATTB
ok > 27 e1ef630c56d36770e180f0d0bf7b61b5289f5c48 916eedaa995f67df0b20511964=
9849ea5de83055 clk: Add devm_clk_hw_register_gate_parent_hw()
?? > 34 bad201b2ac4e238c6d4b6966a220240e3861640c 8222bfe0e3fe1ffc98a6d8a8e4=
9284b3bb2c3dad watchdog: rzg2l_wdt: Power on the watchdog domain in the res=
tart handler
ok > 45 91dcdfbc5b770d4501b1a30d087affc9ed4fa6e5 f6e00b23d92b4cac35a5fcfa65=
4fef1c4d999dd5 arm64: dts: renesas: rz{g2l,g2lc}-smarc-som: Update partitio=
n table for spi-nor flash
ok > 47 c0f2ec5683160a8604292516de9bb6edc7073226 32f0604028a5cd99f6de6cc3f1=
0dd1040b50c6dd arm64: dts: renesas: rzg2ul-smarc-som: Enable serial NOR fla=
sh
ignore, 6.1 only: > 151 None 8315d48bdab555e103b02a0a76319cdb351e23c0 Rever=
t "arm64: dts: renesas: rzg2l: Add missing cache-level properties"
??? > 517 None b99f83040dd996d328c7eed0d39c5bcc3ba7c23e Add configuration f=
or gitlab-ci.
>=20
> And these will need to be forward-ported from 6.1 branch:
>=20
> Collecting commits
> Parsing commits
> Checking commits not in v6.12
ok > 1 651dee03696e1dfde6d9a7e8664bbdcd9a10ea7f d08cad4e6b100c19001d46f85ce=
913526ddd767f serial: sh-sci: Increment the runtime usage counter for the e=
arlycon device
ok > 2 5f1017069933489add0c08659673443c9905659e ea067d976d8b26f4c29c0d626b0=
ea371cd4ce19c serial: sh-sci: Clean sci_ports[0] after at earlycon exit
ok > 3 239f11209e5f282e16f5241b99256e25dd0614b6 e526ac9a17969360c770da3f2eb=
ae4b7cf2cfd86 serial: sh-sci: Move runtime PM enable to sci_probe_single()
already? > 4 7cc0e0a43a91052477c2921f924a37d9c3891f0c c7e0eea97bbea76d715b9=
747ab93b22636a90e30 serial: sh-sci: Check if TX data was written to device =
in .tx_empty()
ok > 5 c1117a2fefbcce30cced3a180585e0adebc0fa89 6947ffd86dafa874e841b5a2578=
6d49ea22cf662 serial: sh-sci: Use plain struct copy in early_console_setup()
ok  > 8 d828c6726fe5642d1c71e9edbc4799c959b471cf c2bc4adb340a59dc45e2d32869=
2ff49f609cc9b6 dt-bindings: serial: renesas: Document RZ/G3E (r9a09g047) sc=
if
> 13 None 8da62141b20bae3e0cfb12c3537d530d14f02441 CIP: Bump version suffix=
 to -cip38 after merge from stable
> 14 None f5afe3636e64ff166f857c71488e7de41c1f0e7c Merge tag 'v6.1.129'
> into linux-6.1.y-cip

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--qQrV7pF6fGJORMlY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9wAYAAKCRAw5/Bqldv6
8ogrAJ0SoadZbPlyai11Ekl+SfjNUrP7JwCeJ6tBVawzRQ9jzXUUpjLUiJ2Zjp4=
=h7VQ
-----END PGP SIGNATURE-----

--qQrV7pF6fGJORMlY--

