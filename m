Return-Path: <SRS0=TbvL=K4=lists.cip-project.org=bounce+64572+6489+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2A0C4708F
	for <cip-dev@archiver.kernel.org>; Wed,  2 Jun 2021 10:08:25 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF47B613BF
	for <cip-dev@archiver.kernel.org>; Wed,  2 Jun 2021 10:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF47B613BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6489+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id zaA7YY4521723xzkgNVg3nQQ; Wed, 02 Jun 2021 03:08:24 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.11098.1622628286230308297
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jun 2021 03:04:47 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3F5991C0B76; Wed,  2 Jun 2021 12:04:41 +0200 (CEST)
Date: Wed, 2 Jun 2021 12:04:40 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [cip-dev] Patches that need porting from 4.19 to 5.10-cip tree
Message-ID: <20210602100440.GA27003@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: qy3BHZUkStP7njcDgHKoxioCx4520388AA=
Content-Type: multipart/mixed; boundary="u5tLfRfYxDbQxNMc2Zc6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1622628504;
 bh=KMF8dtOg9mSxA8QvCFhSZDqapqSHJOVCXn2T7zXPHMA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=W85qy6uaWHlmwc0uLekcMnEAnG+i4cdauju2ELqNzGYOKv7RvT8GiVD9n3G7ag5oa+m
 GHwAzZJFEaXkxz9yM7rGa87MDIBYT7ENNR3JZUM9SqAfpLOhO/M9V4nfvkx0pSYOzFJZ7
 0EN6FYL3u4O2QmnOdsQLG2aldfdNetgE9CQ=

--u5tLfRfYxDbQxNMc2Zc6
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Here is the list of patches that are in 4.19-cip but not yet in
5.10... according to my scripting.

I pushed script generating this to

git@gitlab.com:cip-project/cip-kernel/lts-commit-list.git
bin/forward.py

Best regards,
								Pavel


* Patches that need porting from 4.19-cip:

6 b4b2650cbf85430cfd0e838b848fc779a9379014 pinctrl: renesas: r8a77965: Add =
QSPI[01] pins, groups and functions
7 783046e9b89118fcce8f932a1dd10ba79552d3c6 pinctrl: renesas: r8a7796: Add Q=
SPI[01] pins, groups and functions
8 905e62d4e852ead346aaf7ae76e314a09a11d218 pinctrl: renesas: r8a77951: Add =
QSPI[01] pins, groups and functions
9 07caae75cd573c78a770e5fb11312ba7d673a7ff pinctrl: renesas: r8a77990: Add =
QSPI[01] pins, groups and functions
10 4e0363080cdb4190bd1d2827321f1b429d84bad3 pinctrl: renesas: r8a77990: Opt=
imize pinctrl image size for R8A774C0
11 cd95c31242acda152274f73abd60a61cbcadac0c pinctrl: renesas: r8a77965: Opt=
imize pinctrl image size for R8A774B1
12 1360fb65cd05d086d215027cc1d0c43a51244c00 pinctrl: renesas: r8a77951: Opt=
imize pinctrl image size for R8A774E1
13 ab6dc69195ac22e8ff068c1c855acb91e680f6d9 pinctrl: renesas: r8a7796: Opti=
mize pinctrl image size for R8A774A1
14 7b9d9793bf4df4f9dfef02a4a493fe6f53b2e28d clk: renesas: r8a774c0: Add RPC=
 clocks
15 2040e52e8e8a6785f0c7d12dc42122900e60f308 clk: renesas: r8a774b1: Add RPC=
 clocks
16 375a1ec05fe71b9c3011eee2a0d3d23d93768924 clk: renesas: r8a774a1: Add RPC=
 clocks
17 4caef8210f620992dacf1b061f0ec308f31b516c spi: rpc-if: Fix use-after-free=
 on unbind
23 d331c0b9639ada0baa2d3737eb6e7328ff7e5984 spi: spi-mem: Fix passing zero =
to 'PTR_ERR' warning
24 80c0e04c6a5a07397a6ae0284b01bc7b64f30845 spi: spi-mem: fix reference lea=
k in spi_mem_access_start
28 445839e697735da852301b00643c338a12ada29e memory: renesas-rpc-if: Make rp=
cif_enable/disable_rpm() as static inline
29 310876d304f306b602afb5fa169933d14a01a32e memory: renesas-rpc-if: Fix a n=
ode reference leak in rpcif_probe()
30 9809d206e61cee897c910aff0121017fb787070e memory: renesas-rpc-if: Fix unb=
alanced pm_runtime_enable in rpcif_{enable,disable}_rpm
31 197a622f5082286e418cfd598834dcc90b34fd20 memory: renesas-rpc-if: Return =
correct value to the caller of rpcif_manual_xfer()
35 ff7d6b51a9ee605f2363aa3e52207478e512c83a dt-bindings: PCI: rcar-pci-host=
: Document r8a774e1 bindings
37 0cf9d7a50c7b6e4e161b0951dc095b95d7765847 dt-bindings: timer: renesas: tm=
u: Document r8a774e1 bindings
38 286116ae7a41b39e1d126a96ceccdc12e6e61e77 dt-bindings: pci: rcar-pci-ep: =
Document missing interrupts property
50 28f5a43839f091edddbec332646183b4d9c60546 dt-bindings: phy: renesas,usb2-=
phy: Add r8a774e1 support
140 49753c6e27ed35223cdab939c34ff1d85f200765 mmc: renesas_sdhi_internal_dma=
c: Add r8a774e1 support
162 5185f29a28f69357e2571eabab706480eb2a9cb6 arm64: dts: renesas: Initial r=
8a774e1 SoC device tree
229 6886f3f499dc78b0e184152fae0b4c80cc0b8675 drm: bridge: Add dual_link fie=
ld to the drm_bridge_timings structure
240 7a23d2d2cc0d03784113e460c3180fdbc49eb62b dt-bindings: display: Add idk-=
1110wr binding
320 1d387d03a3d98834f503c7aaea571d7d4c1f5c39 dt-bindings: mmc: renesas_sdhi=
: Add r8a774b1 support
415 825a0a574f2cf0b82a4ea54db3ff1615499f8162 arm64: dts: renesas: r8a774a1:=
 Add missing assigned-clocks for CAN[01]
418 286155ab664e0873e931c78499bc093c9f773648 arm64: dts: renesas: r8a774a1:=
 Use extended audio dmac registers
627 0ccb93953810660266f7095e0541c6db19920642 staging: m57621-mmc: delete dr=
iver from the tree.
632 37c7e76a75a0d5906d792628e4747607a963ba24 arm64: dts: renesas: r8a774c0:=
 sort subnodes of the soc node
~fatal: Not a valid object name None
732 f437c4e92c6a06adb6bdd9b47ad86ff25eab6c92 arm64: renesas: Enable GPIOLIB=
 to allow GPIO driver selection
fatal: Not a valid object name None
757 23c298f18b709c501148065d3b1843a1e56c2d76 arm64: dts: renesas: cat875: E=
nable PCIe support
fatal: Not a valid object name None
758 ccf5aeb525d50febc096ed65d7321b13569085e0 arm64: dts: renesas: r8a774c0-=
cat874: Add pciec0 support
fatal: Not a valid object name None
759 4f5abfb59eaa94f917cb73d9948ecfb66c833e61 arm64: dts: renesas: r8a774c0:=
 Add PCIe device node
fatal: Not a valid object name None
760 56d76f342f9f70001d8cb3f29a279700f9b12e4c dt-bindings: PCI: rcar: Add de=
vice tree support for r8a774c0
fatal: Not a valid object name None
761 1a75ab1f4df2ae74779936083852ebc7532d80cd arm64: dts: renesas: r8a774c0:=
 Add MSIOF nodes
fatal: Not a valid object name None
762 595a7f055da0526376c7529f7591c7cb3f06f8fb spi: sh-msiof: Add r8a774c0 su=
pport
fatal: Not a valid object name None
763 686bc4f4664ca2515e2596c87e053f70c26cb934 spi: sh-msiof: Add r8a774a1 su=
pport
fatal: Not a valid object name None
764 3c0ca6208e581210266ac1bde0597a8b13d6a337 arm64: dts: renesas: r8a774c0:=
 Add I2C and IIC-DVFS support
fatal: Not a valid object name None
765 6b8ffb2a25fde65773cc98bb37c1f5b86b29d98a dt-bindings: i2c: rcar: Add r8=
a774c0 support
fatal: Not a valid object name None
766 57144a0ab9bdbcf7e51b9a8eefd55b7b8a7ab826 dt-bindings: i2c: sh_mobile: A=
dd r8a774c0 support
fatal: Not a valid object name None
767 3cb9d1fc68b381379438f85e8566be39ca86cde7 i2c: sh_mobile: document suppo=
rt for r8a77990 (R-Car E3)
fatal: Not a valid object name None
768 4267473f0afbfb14a85466040b5d28184790f2cf pinctrl: sh-pfc: r8a77990: Add=
 HSCIF pins, groups, and functions
fatal: Not a valid object name None
769 c559288186c43feee8481cdb677812c9b56c4ebf pinctrl: sh-pfc: r8a77990: Add=
 VIN[4|5] groups/functions
fatal: Not a valid object name None
770 e14007c4eff147aa062d7bc207d889848a95ac40 pinctrl: sh-pfc: Add optional =
arg to VIN_DATA_PIN_GROUP
fatal: Not a valid object name None
771 c2432cc0a06bb67dada320d7e3a8a53d33a7d9ab pinctrl: sh-pfc: Reduce kernel=
 size for narrow VIN channels
fatal: Not a valid object name None
772 1134bc50b536702feb7960496879d964491030b5 arm64: dts: renesas: r8a774c0:=
 Add watchdog support
fatal: Not a valid object name None
773 d02d91565cd06e884ce7c6abc648e70f692afeca dt-bindings: watchdog: renesas=
-wdt: Document r8a774c0 support
fatal: Not a valid object name None
774 685eeb31df5f059ae52a17ea240c0e2bced51936 arm64: dts: renesas: cat875: A=
dd ethernet support
fatal: Not a valid object name None
775 840667a2401281cc6eb43c38a70ba3f2839e9cd2 arm64: dts: renesas: r8a774c0:=
 Add Ethernet AVB node
fatal: Not a valid object name None
776 3ab91b007ba07b8790b5ac91e63abf68a3b63195 dt-bindings: net: ravb: Add su=
pport for r8a774c0 SoC
fatal: Not a valid object name None
777 7464f0a341b18617028767239419527c4a8dc669 arm64: dts: renesas: r8a774c0-=
cat874: Add uSD support
fatal: Not a valid object name None
778 85785a241cd0b07dc9bb7afc6c26a452a9c120eb arm64: dts: renesas: r8a774c0:=
 Add SDHI nodes
fatal: Not a valid object name None
779 e931302e319287e29ec343fcee4789cc2e0723a3 mmc: renesas_sdhi_internal_dma=
c: Whitelist r8a774c0
fatal: Not a valid object name None
780 79936bb2cfd319411e89ee16db624eaa8cad6acf dt-bindings: mmc: renesas_sdhi=
: Add r8a774c0 support
fatal: Not a valid object name None
781 2a8127243eaa15e0a713b7792bc523c2657626d9 dt-bindings: mmc: renesas_sdhi=
: Add r8a77470 support
fatal: Not a valid object name None
782 c1e764da7f384908eb2ba1f0c4a9277c2624b2a8 mmc: renesas_sdhi: Add r8a774a=
1 support
fatal: Not a valid object name None
783 90a422ce4e21b7a2fcfe3d0f2e2d87ec23295679 pinctrl: sh-pfc: r8a77990: Add=
 voltage switch operations for SDHI
fatal: Not a valid object name None
784 d6e55053ae891aa8449d59a6213619f24e96cd75 pinctrl: sh-pfc: r8a77990: Add=
 SDHI pins, groups and functions
fatal: Not a valid object name None
785 71db71d6fcdc19a02756e945c4e7636494ab2705 pinctrl: sh-pfc: r8a77990: Add=
 Audio SSI pins, groups and functions
fatal: Not a valid object name None
786 6743ed6a0d1aa99ba2e0803462de96ac6e7988fb pinctrl: sh-pfc: r8a77990: Add=
 Audio clock pins, groups and functions
fatal: Not a valid object name None
787 8bc5c9ee19e33db1ba0e72e130ca0a9db648f502 arm64: dts: renesas: r8a774c0-=
cat874: Add pincontrol support to scif2
fatal: Not a valid object name None
788 3622335f8805f90163a092d71b26dc0544795806 arm64: dts: renesas: r8a774c0:=
 Add GPIO device nodes
fatal: Not a valid object name None
789 87a67df9ce41fd37fa6eca4150de4075770dda35 dt-bindings: gpio: rcar: Add r=
8a774c0 (RZ/G2E) support
fatal: Not a valid object name None
790 5c3b53f2aacbdcc4cf37fb1cfdb809d5bf60e46a dt-bindings: gpio: rcar: Add r=
8a774a1 (RZ/G2M) support
fatal: Not a valid object name None
791 db269e707a0ca48ec72fb57ee37b57cda3c51780 arm64: dts: renesas: r8a774c0:=
 Add PFC support
fatal: Not a valid object name None
792 b403eaddb8e3aa7dc223acc9460d1f458b089de4 arm64: dts: renesas: r8a774c0:=
 Add INTC-EX device node
fatal: Not a valid object name None
793 8c5724802482b046430e148086ae9f59dbc9add9 pinctrl: sh-pfc: r8a77990: Add=
 INTC-EX pins, groups and function
fatal: Not a valid object name None
794 71ff3592223e16fa3761c64408247256262a05c8 pinctrl: sh-pfc: rcar: Rename =
automotive-only arrays to automotive
fatal: Not a valid object name None
795 527669723d13048c2e9c51648105a6bedd2d1b89 arm64: dts: renesas: r8a774c0:=
 Add secondary CA53 CPU core
fatal: Not a valid object name None
796 3a5215b1dba913b21901a8d6217b9e1cddc90f52 clk: renesas: cpg-mssr: Add r8=
a774c0 support
fatal: Not a valid object name None
797 c8ddda1c217fa5fefab21a9061e552bfaf642b46 dt-bindings: clock: renesas: c=
pg-mssr: Document r8a774c0
fatal: Not a valid object name None
798 ecea245b76dc32d74f9c3bf988331a9c52bb21a7 clk: renesas: cpg-mssr: Add r8=
a774a1 support
fatal: Not a valid object name None
799 2976b26a3565fdc2f670386cf5897a12f6a0f0b2 clk: renesas: rcar-gen3: Add s=
upport for mode pin clock selection
800
fatal: Not a valid object name None
800 c1167ef78ee521291d43fd15e90abd06d4101a8d clk: renesas: rcar-gen3: Add s=
upport for RCKSEL clock selection
fatal: Not a valid object name None
801 d6a86311ff22de60051923eeef768d5bbf215603 clk: renesas: cpg-mssr: Add su=
pport for fixed rate clocks
fatal: Not a valid object name None
802 5a2b81b50d3600f2d8ab5a56b3ff797f7892dde6 clk: renesas: rcar-gen3: Add s=
upport for OSC EXTAL predivider
fatal: Not a valid object name None
803 de6945365656d66517f4dc79fde35598c5286234 clk: renesas: Add r8a774a1 CPG=
 Core Clock Definitions
fatal: Not a valid object name None
804 05c4844d0cea6b5f67bb213138b50a784f0eb0cd clk: renesas: Add r8a774c0 CPG=
 Core Clock Definitions
fatal: Not a valid object name None
805 896d958fa17fa96af56fd6623bf2709f860adcc6 arm64: dts: renesas: r8a774c0:=
 Add SCIF and HSCIF nodes
fatal: Not a valid object name None
806 30aba1d2348d672c5f3d329aa21eafeb4987ad4a dt-bindings: serial: sh-sci: D=
ocument r8a774c0 bindings
fatal: Not a valid object name None
807 4c4c1c48e912195c6fe0ecd93968878eff26c04a dt-bindings: serial: sh-sci: D=
ocument r8a774a1 bindings
fatal: Not a valid object name None
808 4ff8a74d753b87b3be2ad0863d83a7851f489ce3 arm64: dts: renesas: r8a774c0:=
 Add SYS-DMAC controller nodes
fatal: Not a valid object name None
809 405a6a65aae3d091f6150045c800aec620447a69 dmaengine: rcar-dmac: Document=
 R8A774C0 bindings
fatal: Not a valid object name None
810 6c7bed298844e51397a6292cc4f7f68147cbd2db dmaengine: rcar-dmac: Document=
 R8A774A1 bindings
fatal: Not a valid object name None
811 80f5600da4e0e161c33f64b97972464805358d99 arm64: dts: renesas: Add Si-Li=
nux EK874 board support
fatal: Not a valid object name None
812 53b8c67a5cd7b1b06ccfb54e72cccb306db3a7ab arm64: dts: renesas: Add Si-Li=
nux CAT874 board support
fatal: Not a valid object name None
813 70863942b6e2e5c481e34166a4458eabfe66ea34 arm64: dts: renesas: Initial d=
evice tree for r8a774c0
fatal: Not a valid object name None
814 bf68b54fa9e618462220f0e537f23788eaa2a081 dt-bindings: arm: Add si-linux=
 cat87[45] boards
fatal: Not a valid object name None
815 7caccda8939c381fc316f450daa9307d227a4a67 ARM: dts: socfpga: Rename socf=
pga_cyclone5_de0_{sockit, nano_soc}
fatal: Not a valid object name None
816 07872e3a35c87fb2ed45e1d97dd3e0d520563ce6 dt-bindings: irqchip: renesas-=
irqc: Document r8a774c0 support
fatal: Not a valid object name None
817 0b6ed88107a0edd34387d6f6503372aa1b8b26c1 soc: renesas: rcar-rst: Add su=
pport for RZ/G2E
fatal: Not a valid object name None
818 8e6d55825b605ad1ee44f8e915aae8ed929c282c dt-bindings: reset: rcar-rst: =
Document r8a774c0 rst
fatal: Not a valid object name None
819 23167181232538a100b062df5755d5b3d71b7602 soc: renesas: rcar-rst: Add su=
pport for RZ/G2M
fatal: Not a valid object name None
820 130d91f7584a388e60b93d1bc8c814f6940e8bbc soc: renesas: rcar-sysc: Add r=
8a774c0 support
fatal: Not a valid object name None
821 dfd2ff6f8995347155da1c4e06bfb48400f73915 dt-bindings: power: rcar-sysc:=
 Document r8a774c0 sysc
fatal: Not a valid object name None
822 441d6cdc76d76fbd71524cbb23d34dafe664a1c8 soc: renesas: rcar-sysc: Add r=
8a774a1 support
fatal: Not a valid object name None
823 cbed3e68d7df310bf6948f49da8e865be1e78168 dt-bindings: power: Add r8a774=
c0 SYSC power domain definitions
fatal: Not a valid object name None
824 bdd3f78dc7b2dc96b667c2c61818b3a39ac38e03 dt-bindings: power: Add r8a774=
a1 SYSC power domain definitions
fatal: Not a valid object name None
825 785d7afc3e8859704675d9de80bb8d272dcfee99 arm64: defconfig: enable R8A77=
4C0 SoC
fatal: Not a valid object name None
826 4145aff423bdaceb488e6f1b68b4f8d8e81bee82 arm64: defconfig: enable R8A77=
4A1 SoC
fatal: Not a valid object name None
827 641132722015595793f56fe31765636ddf7a6999 arm64: Add Renesas R8A774C0 su=
pport
fatal: Not a valid object name None
828 b6ddebb2cc793ef2fda081fd2ef2439c158caac4 arm64: Add Renesas R8A774A1 su=
pport
fatal: Not a valid object name None
829 61a802c7a80707423375e206e58ef7e5ca9ffca6 soc: renesas: Identify RZ/G2E
fatal: Not a valid object name None
830 895d87e0dbf3763480914ad062dadc1c97aa277e soc: renesas: Identify RZ/G2M
fatal: Not a valid object name None
831 76b8e853948bfaff083afb3dd985eb19f3aab30b dt-bindings: arm: Fix RZ/G2E p=
art number
fatal: Not a valid object name None
832 1148a8e70700a6204e599ea7f8aaef89bed34bc2 dt-bindings: arm: Document RZ/=
G2E SoC DT bindings
fatal: Not a valid object name None
833 296e6f9e7e8543d6a0bf877a53f17331b0bf7445 dt-bindings: arm: Document RZ/=
G2M SoC DT bindings
fatal: Not a valid object name None
834 21da9b1699d543ab6e1b46357d0aa2dbfc865934 pinctrl: sh-pfc: r8a77990: Add=
 R8A774C0 PFC support
fatal: Not a valid object name None
835 5966ab46b8674e58af974681859c9165582422a7 pinctrl: sh-pfc: r8a77990: Add=
 MSIOF pins, groups and functions
fatal: Not a valid object name None
836 158e9af63287618d3c432246af352ad12c0313e0 pinctrl: sh-pfc: r8a77990: Add=
 DU pins, groups and function
fatal: Not a valid object name None
837 ae8c3339f4abb8e7622f70461eaa577b38ec9c4d pinctrl: sh-pfc: r8a77990: Add=
 PWM pins, groups and functions
fatal: Not a valid object name None
838 651bece87545408c40cc747f6f8ff9b535141a7a dt-bindings: pinctrl: sh-pfc: =
Document r8a774c0 PFC support
fatal: Not a valid object name None
839 773c0e700b3ee45f41dd7540eea76cc1e9b4756c pinctrl: sh-pfc: r8a7796: Add =
R8A774A1 PFC support
fatal: Not a valid object name None
840 9dcfa7fb9457ba7eeb2c9bcdf4e7238fb0e2ad4b dt-bindings: pinctrl: sh-pfc: =
Document r8a774a1 PFC support
fatal: Not a valid object name None
841 796b0ba74eb56f983753be661049153071c55af9 CIP: Add a number to the versi=
on suffix
fatal: Not a valid object name None
842 2d19be4653f5e74ed95560b69f94eb6791d49af3 Linux 4.19.177
843 fc1e3f5d1d7f77be91f85d7d4ce94ebfe3d8d284 kvm: check tlbs_dirty directly
844 2c68bb33dad9f3cab171bb64e1766bc5a7e9b7e8 scsi: qla2xxx: Fix crash durin=
g driver load on big endian machines
845 98f16e171e2849dba76e2e0346e914452c030dc5 xen-blkback: fix error handlin=
g in xen_blkbk_map()
846 f84c00fbd27b043fa42a56eaaa14e293877bc69b xen-scsiback: don't "handle" e=
rror by BUG()
847 717faa776ca2163119239ea58bb78c4d732d8a4f xen-netback: don't "handle" er=
ror by BUG()
848 a01b49a9bf91a723f541139c063c1ff681ac536a xen-blkback: don't "handle" er=
ror by BUG()
849 271a3984f73c485f4c1b796a61cc5bd3994a0463 xen/arm: don't ignore return e=
rrors from set_phys_to_machine
850 e07f06f6bbeed5bf47fed79ac6a57ec62b33304a Xen/gntdev: correct error chec=
king in gntdev_map_grant_pages()


--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYLdXuAAKCRAw5/Bqldv6
8uRzAJ9+bXlarPtKscG66Up+wXOcVZg8bQCghovQcfgmQhI+yJ7qewVeGaF0trc=
=iuM2
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--

--u5tLfRfYxDbQxNMc2Zc6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6489): https://lists.cip-project.org/g/cip-dev/message=
/6489
Mute This Topic: https://lists.cip-project.org/mt/83254843/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--u5tLfRfYxDbQxNMc2Zc6--
