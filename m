Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AC1C28B30
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 11:18:18 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.5031.1742469487601094673
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Mar 2025 04:18:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=gUrvFgZf;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AF3951020404E;
	Thu, 20 Mar 2025 12:18:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742469485; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=GuTJrtKVR5BmLJ0d8KcBmunULlue2AkhdZpKTEHuqb4=;
	b=gUrvFgZf6vOMNnprdWRvv/xQIc++BPITKgQHOWWcjlyz43QrkHOSPk+RybtAex4+LXUFhe
	04bFNKqyDWq+gN/C4J3YBSLh5B5lLjRMrwe6kw5lSbtuOt3NHRc8JsY/GUWLRSk0hkEvvx
	ImGQ60WYz2Q+6RxbndHA1tg7HtzgQNFxARE8lfSmHXQnUTX7VTjHalrkIghcgO0RNCFiAR
	0XYHZtUsUKqKW2Ycg41wdZXh3InrNTjLLd/7+StDlzZytUZyOKYfsyDZWDFpwV+UoBu9R6
	AV3D2HHsSXvtjwjTkxQKZYjZD2FP3Xy4EWLRPnFU1P0IrUk7VvJygn9tBH+BnQ==
Date: Thu, 20 Mar 2025 12:18:00 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com, Chris.Paterson2@renesas.com
Subject: Starting 6.12-cip branch
Message-ID: <Z9v5aLZhun8zwFk2@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oKpCf7zpeowhcKOG"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Mar 2025 11:18:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18293


--oKpCf7zpeowhcKOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

So... I'm starting 6.12-cip branch. It is based on 6.12.19 and I
already pushed tree to kernel.org:

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.12.y-cip

Next steps should be starting testing the branch. Chris, could you
suggest appropriate gitlab-ci file? [Or even better, could we test the
branch without the gitlab-ci file, as we are doing for stable trees?]

This error will need to be investigated:

fatal: Not a valid commit name be20a73e03e19005cfa5c1c4d6158af1ba02f056

These commits will need to be ported from 6.1-rebase branch:

Collecting commits
Parsing commits
Checking commits not in v6.12
2 546875ccba938ba4f7b5c616a1a1e334c5f2903f a63fe5138f27d91f850abb52f6a0df37=
991b1e3e net: ravb: Add VLAN checksum support
3 85c171509821af048a45b435e0fac36edba6a0cb a993245cf3ad5d1164a71475eec17fd5=
1e28201f net: ravb: Enable IPv6 TX checksum offload for GbEth
4 59cceae40c67d943687587912483d68226cd04de e7b69b28560bb977a05ab6ff280769b5=
a2ec1ee4 net: ravb: Enable IPv6 RX checksum offloading for GbEth
5 e63b5fd02a00aab8e79691359e931dafcd9dfd05 e8486d788dab19ddc25358196c4859e3=
dda4456a net: ravb: Simplify UDP TX checksum offload
6 4574ba5b711d7f7968c116521ef58d46fd4f89b1 c28d544f32b95153155c94fb7411f2d6=
fa14bcd1 net: ravb: Disable IP header TX checksum offloading
7 faacdbba01802c89f7043f9a47ad442c1195d307 a7548baf2b4f58b75292cddd35830a23=
0c77f9dd net: ravb: Simplify types in RX csum validation
8 5a2d973e36061cbf8d1ba00a9294244522715e53 15053ac983ab9fc781aeaa006c7c8b81=
7b0bbb03 net: ravb: Combine if conditions in RX csum validation
9 8d2109c1a51525c3586c5bf6f78ab1ce3c2908f8 a1bdc025b634187d6d7cc462c5839ece=
8e102934 net: ravb: Drop IP protocol check from RX csum verification
10 c4e347a02b14fa2425337473fcb120c62936cbc5 ac242a57ad28de613c61b76cb82b7d3=
0a0e70e37 net: ravb: Disable IP header RX checksum offloading
11 8e3037924a36505531999df8f5847a68b9272c41 c3aef62f4dd2ce3fe35d45fdc5cfdeb=
c02b22285 net: ravb: Factor out checksum offload enable bits
16 c520bbb523304ba98de9ffeeb0ef289921434125 aefdfb4c1c3ff4503caad2c357cab0f=
c4b910aea arm64: defconfig: Enable VBATTB clock and Renesas RTCA-3
17 0cd647cd53db0315361e41056e10739a5ee1e668 8d96cc36644ab5500f9b48f2f51d947=
3d77d29af arm64: dts: renesas: rzg3s-smarc-som: Enable RTC
18 2d768aee9f5294d2023e824c0906e2e7d1414629 8b8fef2d3115f20327438e7aae01cb8=
0b0f87ff0 arm64: dts: renesas: r9a08g045: Add RTC node
19 ac948eb8ead1265ff034955bdbbb081744f1e7ed 011c639f99a749cbfc5256f91a5e6b0=
dc0c7835a arm64: dts: renesas: rzg3s-smarc-som: Enable VBATTB
20 23c44956bce5aa79c060fc3e5d51843735e6eda6 b3c797ba7dfe077b81bd521ef945742=
38f2982e1 arm64: dts: renesas: r9a08g045: Add VBATTB node
21 8f315a5c7376b2bc324d62a8400184da77f25e28 d0207ac40f9b01a737a657f19f66294=
acc70d8aa rtc: renesas-rtca3: Fix compilation error on RISC-V
22 d4488377609e36cd9785533c29ccea4b86c292b9 541924b0a8c2a69974ced3cc9d56d2f=
4fd056fac rtc: renesas-rtca3: Add driver for RTCA-3 available on Renesas RZ=
/G3S SoC
23 71c61a45c951eca67dd2cbc4de9cdd687ece4ead e8e3acfa534f32c5d1afc1255ceca88=
577afa172 dt-bindings: rtc: renesas,rzg3s-rtc: Document the Renesas RTCA-3 =
IP
24 be20a73e03e19005cfa5c1c4d6158af1ba02f056 db7542114675a85d50f8b41b9cf342d=
f7d0a7bf6 clk: renesas: vbattb: Add VBATTB clock driver
25 cdfd5daf90af8363fb1f58e08c829a775b2e2fc5 d7ae15b36472510c35f08d5c457e152=
5fff0d960 dt-bindings: clock: renesas,r9a08g045-vbattb: Document VBATTB
27 e1ef630c56d36770e180f0d0bf7b61b5289f5c48 916eedaa995f67df0b205119649849e=
a5de83055 clk: Add devm_clk_hw_register_gate_parent_hw()
34 bad201b2ac4e238c6d4b6966a220240e3861640c 8222bfe0e3fe1ffc98a6d8a8e49284b=
3bb2c3dad watchdog: rzg2l_wdt: Power on the watchdog domain in the restart =
handler
45 91dcdfbc5b770d4501b1a30d087affc9ed4fa6e5 f6e00b23d92b4cac35a5fcfa654fef1=
c4d999dd5 arm64: dts: renesas: rz{g2l,g2lc}-smarc-som: Update partition tab=
le for spi-nor flash
47 c0f2ec5683160a8604292516de9bb6edc7073226 32f0604028a5cd99f6de6cc3f10dd10=
40b50c6dd arm64: dts: renesas: rzg2ul-smarc-som: Enable serial NOR flash
151 None 8315d48bdab555e103b02a0a76319cdb351e23c0 Revert "arm64: dts: renes=
as: rzg2l: Add missing cache-level properties"
517 None b99f83040dd996d328c7eed0d39c5bcc3ba7c23e Add configuration for git=
lab-ci.

And these will need to be forward-ported from 6.1 branch:

Collecting commits
Parsing commits
Checking commits not in v6.12
1 651dee03696e1dfde6d9a7e8664bbdcd9a10ea7f d08cad4e6b100c19001d46f85ce91352=
6ddd767f serial: sh-sci: Increment the runtime usage counter for the earlyc=
on device
2 5f1017069933489add0c08659673443c9905659e ea067d976d8b26f4c29c0d626b0ea371=
cd4ce19c serial: sh-sci: Clean sci_ports[0] after at earlycon exit
3 239f11209e5f282e16f5241b99256e25dd0614b6 e526ac9a17969360c770da3f2ebae4b7=
cf2cfd86 serial: sh-sci: Move runtime PM enable to sci_probe_single()
4 7cc0e0a43a91052477c2921f924a37d9c3891f0c c7e0eea97bbea76d715b9747ab93b226=
36a90e30 serial: sh-sci: Check if TX data was written to device in .tx_empt=
y()
5 c1117a2fefbcce30cced3a180585e0adebc0fa89 6947ffd86dafa874e841b5a25786d49e=
a22cf662 serial: sh-sci: Use plain struct copy in early_console_setup()
8 d828c6726fe5642d1c71e9edbc4799c959b471cf c2bc4adb340a59dc45e2d328692ff49f=
609cc9b6 dt-bindings: serial: renesas: Document RZ/G3E (r9a09g047) scif
13 None 8da62141b20bae3e0cfb12c3537d530d14f02441 CIP: Bump version suffix t=
o -cip38 after merge from stable
14 None f5afe3636e64ff166f857c71488e7de41c1f0e7c Merge tag 'v6.1.129'
into linux-6.1.y-cip

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--oKpCf7zpeowhcKOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9v5aAAKCRAw5/Bqldv6
8hjZAJ9ytxgL0gcqDu50zDOffTdvs+qdUACfTXVCOCXgyFP1mZXcpNLNzAtKS2U=
=AFYc
-----END PGP SIGNATURE-----

--oKpCf7zpeowhcKOG--

