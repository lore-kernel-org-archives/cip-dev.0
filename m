Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E6BC77B73
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 19:25:34 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.18207.1685993132888738462
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jun 2023 12:25:33 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3E3C31C0AB3; Mon,  5 Jun 2023 21:25:29 +0200 (CEST)
Date: Mon, 5 Jun 2023 21:25:28 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com
Subject: v6.1-cip: state of forward porting
Message-ID: <ZH42qOnp/GCT1rYJ@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNCrbBxHGSeIIKVX"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 19:25:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11823


--PNCrbBxHGSeIIKVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I moved 6.1-cip branch a bit forward. Below is a summary of patches
that needed forward-porting according to my scripts. Let me know if I
missed some.

These were too tangled for quick forward-port these. I may take
another look, but if you provided 6.1 versions of these, it would be
very helpful.

pick 350550b5c3690 can: rcar_canfd: Add shared_global_irqs to struct rcar_c=
anfd_hw_info
pick 85f15bd6204ad can: rcar_canfd: Add postdiv to struct rcar_canfd_hw_info
pick 189d6cf10005e can: rcar_canfd: Add multi_channel_irqs to struct rcar_c=
anfd_hw_info

I believe these are sorted. "x" means git cherry-pick did its job,
otherwise there's a note what happened there. Please review,
especially lines not marked with simple "x".

Tree is now available at
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.1.y-cip
=2E

If there's nothing obviously wrong and if we can solve those
rcar_canfd patches, I believe we can start thinking about doing
6.1.31-cip1 release (after getting permission from TSC).

Best regards,
									Pavel

x 8 93582bdfd0cf5aeeb4451ade1076a455c53d8a85 f0f6960f132cdf82ed0fcb61de7c49=
6d33f0998f arm64: defconfig: Enable RZ/V2M xHCI and USB3.1 DRD controller s=
upport
x 9 a17039b630c59da98de153ef50cdf6a06393cfce b5395e1d8ca82b9870b327b022cba6=
0cb35e68db arm64: dts: renesas: rzv2mevk2: Enable USB3 role switch
x 10 967219e5d410ccb3e072c712ec3d665c6346876f c6a7b1812a513fcf2d8b70ed57066=
5b3e320da1f arm64: dts: renesas: rzv2mevk2: Enable USB3 DRD, Peripheral and=
 Host
reject, x 11 670e2a8b9b02ff52c7ca43204459693b3c574b00 88edb63ad6f9ccaac8196=
a3e0933bc7e95e7b61f arm64: dts: renesas: r9a09g011: Add USB3 DRD, device an=
d host nodes
x 12 ec5499d338ece9db9b7590649d3cfcc4d7f9603d bccbaf3a01c388aabfcc0c74fb94e=
3823de43f69 xhci: split out rcar/rz support from xhci-plat.c
x 14 c52c9acc415eb6ff54f658492f8c53da0fc3528a 22490cafbbc30cd60c2dd536d3a65=
4ea2bb6aa00 xhci: host: Add Renesas RZ/V2M SoC support
x 15 224eb5311d6a8c180932465873d809b48a2470bf 3df94e6fe0b7b4e585db64634d35b=
08b05180d8b usb: host: xhci-plat: Add reset support
x 16 8c6e8b09617915e8af3ab7dbfecd8f0a9c7cf94f 80ecb8abe65bed11b477d5bd3bfe3=
4b7e1ab8834 usb: host: xhci-plat: Improve clock handling in probe()
x 17 3827fa1ef38f52d9de7ec6e52b4f724dd7b60bb2 ee69f886d8faed656652856536d6d=
ea5399b35cb usb: gadget: udc: renesas_usb3: Add role switch support for RZ/=
V2M
reject, fixed up 18 9cad72dfc5567c66ab0e5a0a2474c5f36c268694 82488a4d35043d=
2dfd016777c50852cc678c54c4 usb: gadget: Add support for RZ/V2M USB3DRD driv=
er
x 19 9486e56c49be7dc771ecae9bf67b1034cd440d10 1d3c8f216288da8f30c681a9f1368=
49887fceb9b dt-bindings: usb: Add RZ/V2M USB3DRD binding
x 20 2c5502a4dc9ffb9145ef80e642be0f1f03c037e8 8ccff97b1eb82ff21765061e280e6=
340beb629cb dt-bindings: usb: renesas,usb3-peri: Document RZ/V2MA bindings
x 22 29218d6ce4da741f8a1a86974999e8790683c23b 7230698aa48a7d433a4c254a158d7=
92b9353b67b dt-bindings: usb: renesas,usb3-peri: Update reset, clock-name a=
nd interrupts properties
x 24 e696d70f600abbe2b7fe81008bcb24d239a74672 8a65b3acef105b4cf00a5c954a1c6=
bce9c054177 dt-bindings: usb: renesas,usb-xhci: Document RZ/V2M support
x 25 569d23e9bf58464887c55aa0d2bdb0ead97f8592 a27fdb2a10ea63ba6763f72a438c7=
15fed3f6d4f usb: typec: hd3ss3220: Add polling support
x 26 5edf5b51e760af749c4a8e67cde92db4f3680be5 f56ffd67d164278cb89a9a0a8dce6=
6c49f3676fe clk: renesas: r9a09g011: Add USB clock and reset entries


Collecting commits
Parsing commits
Checking commits not in v6.1

empty -- 4 2ac909916b520df09a23f152bb9016d7b892b496 e2fc1489778b2e111ac99cb=
302910cc064dea302 arm64: dts: renesas: r9a09g011: Fix I2C SoC specific stri=
ngs
x 7 f30ec5df80a0a3328ad6b9c2434ccaa331505307 0820bfab4ade63371e84b874025ab4=
22f3481c5c dt-bindings: i2c: renesas,rzv2m: Change maintainer to Fabrizio C=
astro
empty -- 8 0a4eecf96c640886226f1ca7fdbb11bb20bc55b9 92b1b541ac58f906cf3de84=
5e78657c7d0695f72 dt-bindings: i2c: renesas,rzv2m: Fix SoC specific string
x 12 594edf2c61f2eb79234e642e3a82d7ae02e7a241 80dd8fb41524ed7e4edb87d7a5e47=
64d87004f56 arm64: dts: renesas: rzv2mevk2: Enable watchdog
x 13 753a4ae153788225a30b0ee9dd18da83f1d94447 25ab1afc23fc164c3d58010aff8d8=
d9a83ade85d arm64: dts: renesas: r9a09g011: Add watchdog node
empty -- 14 f769f97917c1e756e12ff042a93f6e3167254b5b f1fd97180e51028adfc4d8=
4074586355c0d9dd97 watchdog: rzg2l_wdt: Handle TYPE-B reset for RZ/V2M
x 18 b9e88ba6dcda4cd2d36e27dadb6acab4fad8a80f 254392f95d90a8218a8e36b096372=
9cc9019fa9d arm64: dts: renesas: r9a09g011: Add system controller node
x 19 c6b1737f45ca708fee76a30afb4a7b0247455749 5463099b2570ffb47e3bcf2ddd785=
1713034defb arm64: dts: renesas: r9a09g011: Add L2 Cache node
x 20 11ffdcdfa2125859b298f9a66f9eefba493a37c0 9725f13b490c2386cd92259b10269=
12e4d9b44de arm64: dts: renesas: r9a09g011: Reword ethernet status
empty -- 21 278f5015a3deaa2ea0db6070bbc2a8edf2455643 5629e5f655683b0b82ae39=
fd60d0c7f3fbc56584 arm64: dts: renesas: r9a09g011: Fix unit address format =
error
conflict -- 22 d459f557ad76f449687e76fcb94f1009551dd669 3bbf7d2df1591628e87=
ad0b67a8ce210e3994e05 clk: renesas: r9a09g011: Add TIM clock and reset entr=
ies
x 24 05d11e2f4460752fa5f7ce7657e1b040056c1736 f4e7601712112cfbac46dc6ccb98a=
782954b6014 arm64: dts: renesas: rzg2l: Add clock-names and reset-names to =
DMAC nodes
x 25 86de3bbfe45e5a7e64d4f24a1c034725072420d8 daa763034394e5e316a3abe53dd43=
84dc83e5e05 dmaengine: sh: rz-dmac: Remove unused rz_dmac_chan.*_word_size
x 26 d1e71a3a7ab9db0168b6885171e0576383216ac8 cef64144a01153251c6aa0af3917b=
090ed446235 dmaengine: sh: rz-dmac: Add reset support
x 27 5aaf9079d740ebe57f10dfefb1850011d6bb7b2a 74d90642d65ce887c912795714ab9=
f11afb66b7c dt-bindings: dma: rz-dmac: Document clock-names and reset-names
x 54 7e20044052317d5f2942b061c4cacdb6790790a2 18aad59a356c7d80d8a0b0b43e6ae=
9c7f5aa7d86 soc: renesas: Identify RZ/V2M SoC
x 55 a884f187760ee0c6033296aa50845e2d1e0e8430 3357f7cd9869e844e3acbf52d8fa6=
bfcf4f1b8fb dt-bindings: arm: renesas: Document Renesas RZ/V2M System Confi=
guration
x 67 41a87e789c7c2cdeb302331043f866c0138f0413 5cc2bf5a71bd32768378ab12e5bdb=
fcb6834be3d pinctrl: renesas: rzg2l: remove unnecessary check from rzg2l_dt=
_node_to_map()
resulted in empty commit -- 68 6ba6f0f5910d5916539268c0ad55657bb8940616 7a0=
0d91d3c43fe9c4a7dd9bdf29f4aa60657d2c2 watchdog: rzg2l_wdt: Issue a reset be=
fore we put the PM clocks
merge conflict, unsure about correct resolution -- 73 ea6ff7792203ad6786bda=
75d1dabf33311c8bef4 f0c6374c8c202e81ba250213a7db7902470328be can: rcar_canf=
d: Add multi_channel_irqs to struct rcar_canfd_hw_info
merge conflict -- 74 a1dcfbdfd1d0f7843f381f7c58cc87a0f8c11f6c e793c081f3874=
8f641845c07840fc841eca520e2 can: rcar_canfd: Add postdiv to struct rcar_can=
fd_hw_info
merge conflict -- 75 841645cfc773cdd0a21c67357c53845f2e972f91 0dcb8826905b9=
0ba34a82ee6c7147101d7679b6f can: rcar_canfd: Add shared_global_irqs to stru=
ct rcar_canfd_hw_info
x 76 ce7c5382758b13dd4dfa2eb2f4989f9a27c58ffe 83921730bd09625a82fac5d8df052=
d2833898277 can: rcar_canfd: rcar_canfd_probe: Add struct rcar_canfd_hw_inf=
o to driver data
x 77 68399ff574e4faf42b8d85da9339ca3ee2892cc7 730b759e4722fbe592c4657d9c989=
ff0dacdc3a2 can: rcar_canfd: Use devm_reset_control_get_optional_exclusive
x 83 1625fbc1f73f1fa8f77c38ea554cc0b2327b156b cb31bf1b3e572eb19e69791147b7c=
7ea147844c2 clk: renesas: rzg2l: Support sd clk mux round operation
already have this one, as 962ff7ecb60b684fe15 | 318 None ea0b1f0a5d697c3ce2=
4586974e8646c37db58cf1 ASoC: sh: rz-ssi: Add rz_ssi_set_substream() helper =
function
already have this one, as 33748744f15a110a233b | 370 None f9312cb2b6719daf6=
b74b063b47b5a6be5b65779 clk: renesas: rzg2l: propagate return value of_genp=
d_add_provider_simple()


--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--PNCrbBxHGSeIIKVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZH42qAAKCRAw5/Bqldv6
8n95AJ9FSHm7nZIok3kyQjD2mf17mirlmgCfeKEfOs3Ui1YBrPN7sdsFT/P/Oh4=
=gDu0
-----END PGP SIGNATURE-----

--PNCrbBxHGSeIIKVX--

