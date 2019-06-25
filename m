From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Tue, 25 Jun 2019 06:10:22 +0000
Subject: [cip-dev]
	[Git][cip-project/cip-kernel/cip-kernel-sec][master]	Import
	more data
In-Reply-To: <5d0bebf82257_470e3fd2b3244620356163@sidekiq-asap-03-sv-gprd.mail>
References: <5d0bebf82257_470e3fd2b3244620356163@sidekiq-asap-03-sv-gprd.mail>
Message-ID: <TY2PR01MB33234EA30D2934C21A792F2AD0E30@TY2PR01MB3323.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

I'm not sure where the script that imports new issues and sends these e-mails is located, but it looks like it is not calling "scripts/cleanup.py".
I run cleanup.py, and I noticed that it modified most yaml issue files.

Thanks,
Daniel

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org <cip-dev-bounces@lists.cip-project.org> On Behalf Of Ben
> Hutchings
> Sent: Friday, June 21, 2019 5:27 AM
> To: cip-dev at lists.cip-project.org
> Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] Import more data
> 
> 
> Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec
> <https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec>
> 
> 
> Commits:
> 
> 
> *	4975a489
> <https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/4975a4892b252c9bbfbf878f762ee590d24
> db76d>
> 	by Ben Hutchings at 2019-06-20T20:26:18Z
> 	Import more data
> 
> 
> 19 changed files:
> 
> 
> *	+ issues/CVE-2019-0136.yml
> *	+ issues/CVE-2019-0157.yml
> *	issues/CVE-2019-10142.yml
> *	+ issues/CVE-2019-11477.yml
> *	+ issues/CVE-2019-11478.yml
> *	+ issues/CVE-2019-11479.yml
> *	issues/CVE-2019-11810.yml
> *	issues/CVE-2019-11833.yml
> *	issues/CVE-2019-11884.yml
> *	issues/CVE-2019-12379.yml
> *	issues/CVE-2019-12380.yml
> *	issues/CVE-2019-12382.yml
> *	issues/CVE-2019-12454.yml
> *	+ issues/CVE-2019-12818.yml
> *	+ issues/CVE-2019-12819.yml
> *	+ issues/CVE-2019-12881.yml
> *	issues/CVE-2019-3846.yml
> *	+ issues/CVE-2019-3896.yml
> *	issues/CVE-2019-5489.yml
> 
> 
> Changes:
> 
> *	issues/CVE-2019-0136.yml
> <https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/4975a4892b252c9bbfbf878f762ee590d24
> db76d#48d7e7a13742047afc68bf38b5656fc049b1a73b>
> ________________________________
> 
> 	1 	+description: |-
> 	2 	+  Insufficient access control in the Intel(R) PROSet/Wireless WiFi Software
> 	3 	+  driver before version 21.10 may allow an unauthenticated user to
> 	4 	+  potentially enable denial of service via adjacent access.
> 	5 	+references:
> 	6 	+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-0136
> 	7 	+- https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00232.html
> 
> *	issues/CVE-2019-0157.yml
> <https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/4975a4892b252c9bbfbf878f762ee590d24
> db76d#7b0b5fe4c28efb2ebd4020c61b5243dfc1910d45>
> ________________________________
> 
> 	1 	+description: |-
> 	2 	+  Insufficient input validation in the Intel(R) SGX driver for Linux may
> 	3 	+  allow an authenticated user to potentially enable a denial of service via
> 	4 	+  local access.
> 	5 	+references:
> 	6 	+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-0157
> 	7 	+-
> https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00235.html?wapkw=cve-2019
> -0157
> 
> *	issues/CVE-2019-10142.yml
> <https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/4975a4892b252c9bbfbf878f762ee590d24
> db76d#0dbadb945b4c9dc156c08bef804d63777245570b>
> ________________________________
> 
> ...	 ...	 @@ -14,6 +14,7 @@ comments:
> 14 	14 	 introduced-by:
> 15 	15 	   mainline: [6db7199407ca56f55bc0832fb124e1ad216ea57b]
> 16 	16 	 fixed-by:
> 	17 	+  linux-3.16.y: [bfa8c73482dae6bafc0741cbfd63f84d11311b36]
> 17 	18 	   linux-4.14.y: [1a3a561df5e176a4422270e3d2cca1cd835b292e]
> 18 	19 	   linux-4.19.y: [e9ec5073c90d6de2ca5338bd67f7935b19d7c0c7]
> 19 	20 	   linux-4.19.y-cip: [e9ec5073c90d6de2ca5338bd67f7935b19d7c0c7]
> 
> *	issues/CVE-2019-11477.yml
> <https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/4975a4892b252c9bbfbf878f762ee590d24
> db76d#8e05c0fdc243484e3e297c8e8805c8875e63876b>
> ________________________________
> 
> 	1 	+description: DoS through u16 overflow of TCP_SKB_CB(skb)->tcp_gso_segs
> 	2 	+references:
> 	3 	+- https://patchwork.ozlabs.org/patch/1117155/
> 	4 	+-
> https://github.com/Netflix/security-bulletins/blob/master/advisories/third-party/2019-001.md
> 	5 	+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11477
> 	6 	+- https://wiki.ubuntu.com/SecurityTeam/KnowledgeBase/SACKPanic
> 	7 	+- https://usn.ubuntu.com/usn/usn-4017-1
> 	8 	+- https://usn.ubuntu.com/usn/usn-4017-2
> 	9 	+- https://launchpad.net/bugs/1831637
> 	10 	+comments:
> 	11 	+  Ubuntu-tyhicks: Known as "SACK Panic"
> 	12 	+reporters:
> 	13 	+- Jonathan Looney
> 	14 	+introduced-by:
> 	15 	+  mainline: [832d11c5cd076abc0aa1eaf7be96c81d1a59ce41]
> 	16 	+fixed-by:
> 	17 	+  linux-3.16.y: [ef27e3c531782ec8213108e11e5515f9724303c7]
> 	18 	+  linux-4.14.y: [d632920554c5aec81d8a79c23dac07efcbabbd54]
> 	19 	+  linux-4.19.y: [c09be31461ed140976c60a87364415454a2c3d42]
> 	20 	+  linux-4.19.y-cip: [c09be31461ed140976c60a87364415454a2c3d42]
> 	21 	+  linux-4.4.y: [4657ee0fe05e15ab572b157f13a82e080d4b7d73]
> 	22 	+  linux-4.4.y-cip: [4657ee0fe05e15ab572b157f13a82e080d4b7d73]
> 	23 	+  linux-4.9.y: [cc1b58ccb78e0de51bcec1f2914d9296260668bd]
> 	24 	+  linux-5.1.y: [d907a0770bb23deacd7087263aa6e242d91d3075]
> 	25 	+  mainline: [3b4929f65b0d8249f19a50245cd88ed1a2f78cff]
> 
> *	issues/CVE-2019-11478.yml
> <https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/4975a4892b252c9bbfbf878f762ee590d24
> db76d#667fe53c5c9f5c2f8e1938c02cc23d3270e0dddd>
> ________________________________
> 
> 	1 	+description: tcp_fragment fragmentation can exceed socket memory limits
> 	2 	+references:
> 	3 	+- https://patchwork.ozlabs.org/patch/1117156/
> 	4 	+-
> https://github.com/Netflix/security-bulletins/blob/master/advisories/third-party/2019-001.md
> 	5 	+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11478
> 	6 	+- https://wiki.ubuntu.com/SecurityTeam/KnowledgeBase/SACKPanic
> 	7 	+- https://usn.ubuntu.com/usn/usn-4017-1
> 	8 	+- https://usn.ubuntu.com/usn/usn-4017-2
> 	9 	+- https://launchpad.net/bugs/1831638
> 	10 	+comments:
> 	11 	+  Ubuntu-tyhicks: |-
> 	12 	+    This vulnerability results in exhausted CPU resources on kernels < 4.15
> 	13 	+    This vulnerability results in exhausted kernel memory on kernels >= 4.15
> 	14 	+reporters:
> 	15 	+- Jonathan Looney
> 	16 	+fixed-by:
> 	17 	+  linux-3.16.y: [dc97a907bc76b71c08e7e99a5b1b30ef4d5e4a85]
> 	18 	+  linux-4.14.y: [9daf226ff92679d09aeca1b5c1240e3607153336]
> 	19 	+  linux-4.19.y: [ec83921899a571ad70d582934ee9e3e07f478848]
> 	20 	+  linux-4.19.y-cip: [ec83921899a571ad70d582934ee9e3e07f478848]
> 	21 	+  linux-4.4.y: [ad472d3a9483abc155e1644ad740cd8c039b5170]
> 	22 	+  linux-4.4.y-cip: [ad472d3a9483abc155e1644ad740cd8c039b5170]
> 	23 	+  linux-4.9.y: [e358f4af19db46ca25cc9a8a78412b09ba98859d]
> 	24 	+  linux-5.1.y: [a38c401b4afafd11a127f250cb382c476bdeed9e]
> 	25 	+  mainline: [f070ef2ac66716357066b683fb0baf55f8191a2e]
> 
> *	issues/CVE-2019-11479.yml
> <https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/4975a4892b252c9bbfbf878f762ee590d24
> db76d#8da6d636b2bc0d4cd080d8a5bcf3f02dc32191fc>
> ________________________________
> 
> 	1 	+description: TCP minimum MSS hardcoded to 48 which can lead to DoS
> 	2 	+references:
> 	3 	+- https://patchwork.ozlabs.org/patch/1117157/
> 	4 	+- https://patchwork.ozlabs.org/patch/1117158/
> 	5 	+-
> https://github.com/Netflix/security-bulletins/blob/master/advisories/third-party/2019-001.md
> 	6 	+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11479
> 	7 	+- https://wiki.ubuntu.com/SecurityTeam/KnowledgeBase/SACKPanic
> 	8 	+- https://launchpad.net/bugs/1832286
> 	9 	+comments:
> 	10 	+  Ubuntu-tyhicks: |-
> 	11 	+    This issue is primarily due to the TCP spec not defining a minimum
> 	12 	+     value for the Minimum Segment Size (MSS). The Linux kernel cannot safely put
> 	13 	+     a restriction on the MSS because it may break valid TCP connections. This
> 	14 	+     issue will be addressed by allowing a system administrator to raise the
> 	15 	+     smallest acceptable MSS value but there will be no default mitigation by
> 	16 	+     default.
> 	17 	+reporters:
> 	18 	+- Jonathan Looney
> 	19 	+fixed-by:
> 	20 	+  linux-3.16.y: [6b7e7997ad3505db7de85ff12276fc84659481d3,
> 7ce5a5796ca119c5c6935ea9f4e785f0cb7f39b7]
> 	21 	+  linux-4.14.y: [cd6f35b8421ff20365ff711c0ac7647fd70e9af7,
> f2aa4f1a05e0987e812809dbc489bd294fdae5ae]
> 	22 	+  linux-4.19.y: [7f9f8a37e563c67b24ccd57da1d541a95538e8d9,
> 59222807fcc99951dc769cd50e132e319d73d699]
> 	23 	+  linux-4.19.y-cip: [7f9f8a37e563c67b24ccd57da1d541a95538e8d9,
> 59222807fcc99951dc769cd50e132e319d73d699]
> 	24 	+  linux-4.4.y: [e757d052f3b8ce739d068a1e890643376c16b7a9,
> f938ae0ce5ef7b693125b918509b941281afc957]
> 	25 	+  linux-4.4.y-cip: [e757d052f3b8ce739d068a1e890643376c16b7a9,
> f938ae0ce5ef7b693125b918509b941281afc957]
> 	26 	+  linux-4.9.y: [8e39cbc03dafa3731d22533f869bf326c0e6e6f8,
> 7e9096287352d0416f3caa0919c90bd9ed2f68d3]
> 	27 	+  linux-5.1.y: [2efabe3e1491f10bf3cf82ae1a371755ba054a1b,
> 1cebce3b9cb3ec174f367d9e5f1537578ec538dc]
> 	28 	+  mainline: [5f3e2bf008c2221478101ee72f5cb4654b9fc363,
> 967c05aee439e6e5d7d805e195b3a20ef5c433d6]
> 
> *	issues/CVE-2019-11810.yml
> <https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/4975a4892b252c9bbfbf878f762ee590d24
> db76d#3f408e0b7d84d5c614cdb2f20fed055f31dad801>
> ________________________________
> 
> ...	 ...	 @@ -10,6 +10,7 @@ references:
> 10 	10 	 introduced-by:
> 11 	11 	   mainline: [c4a3e0a529ab3e65223e81681c7c6b1bc188fa58]
> 12 	12 	 fixed-by:
> 	13 	+  linux-3.16.y: [bd0908fbd84009cb5f01cf1a258a6f7fd78b6b3a]
> 13 	14 	   linux-4.14.y: [90fca247abf6adc1ee6eef9b3de199448c8a4ad6]
> 14 	15 	   linux-4.19.y: [8032fc9120c211cd40beef4c91c8206f4167e523]
> 15 	16 	   linux-4.19.y-cip: [8032fc9120c211cd40beef4c91c8206f4167e523]
> 
> *	issues/CVE-2019-11833.yml
> <https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/4975a4892b252c9bbfbf878f762ee590d24
> db76d#6d659be46a1d8a73c7f3d053f52b6a81b7295933>
> ________________________________
> 
> ...	 ...	 @@ -6,6 +6,7 @@ references:
> 6 	6 	 introduced-by:
> 7 	7 	   mainline: [a86c61812637c7dd0c57e29880cffd477b62f2e7]
> 8 	8 	 fixed-by:
> 	9 	+  linux-3.16.y: [13c4be25bdcbe5045f9b17ad875c3253a4888e45]
> 9 	10 	   linux-4.14.y: [d7d9e4823b658eb795f4a379d121d3f0539c1117]
> 10 	11 	   linux-4.19.y: [25d010f4e0ece1ddf0d8d57942c0b0f1568fe498]
> 11 	12 	   linux-4.19.y-cip: [25d010f4e0ece1ddf0d8d57942c0b0f1568fe498]
> 
> *	issues/CVE-2019-11884.yml
> <https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/4975a4892b252c9bbfbf878f762ee590d24
> db76d#32887c1d8ebf21de53d439b34b63ff2c2d7f24b5>
> ________________________________
> 
> ...	 ...	 @@ -7,6 +7,7 @@ references:
> 7 	7 	 comments:
> 8 	8 	   Debian-carnil: similar issue to CVE-2011-1079.
> 9 	9 	 fixed-by:
> 	10 	+  linux-3.16.y: [acaf43aa7ede1e500532f1f5d910e207f89d5e1f]
> 10 	11 	   linux-4.14.y: [2c33156b2d2f5efe820d8efdd610fb168c9acf72]
> 11 	12 	   linux-4.19.y: [c6d1f9b4b2cb768e29f5d44af143f25ad89062b1]
> 12 	13 	   linux-4.19.y-cip: [c6d1f9b4b2cb768e29f5d44af143f25ad89062b1]
> 
> *	issues/CVE-2019-12379.yml
> <https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/4975a4892b252c9bbfbf878f762ee590d24
> db76d#cc649dc5fed34033b060d6a9c888220a17ef37e4>
> ________________________________
> 
> ...	 ...	 @@ -9,5 +9,7 @@ comments:
> 9 	9 	   Debian-bwh: |-
> 10 	10 	     There is no memory leak, and the purported "fix" actually
> 11 	11 	     introduces a security issue.  I have sent a patch to revert it.
> 	12 	+introduced-by:
> 	13 	+  mainline: [1da177e4c3f41524e886b7f1b8a0c1fc7321cac2]
> 12 	14 	 ignore:
> 13 	15 	   all: Invalid
> 
> *	issues/CVE-2019-12380.yml
> <https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/4975a4892b252c9bbfbf878f762ee590d24
> db76d#98fd29f5932cb6f5d33bf96a638dc80109acd5a4>
> ________________________________
> 
> ...	 ...	 @@ -10,5 +10,9 @@ comments:
> 10 	10 	   Debian-bwh: |-
> 11 	11 	     All the code involved runs at boot before userland starts, so
> 12 	12 	     there is no "denial of service".
> 	13 	+introduced-by:
> 	14 	+  mainline: [b8f2c21db390273c3eaf0e5308faeaeb1e233840]
> 	15 	+fixed-by:
> 	16 	+  mainline: [4e78921ba4dd0aca1cc89168f45039add4183f8e]
> 13 	17 	 ignore:
> 14 	18 	   all: Invalid
> 
> *	issues/CVE-2019-12382.yml
> <https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/4975a4892b252c9bbfbf878f762ee590d24
> db76d#03ffb9b81a7bbc566374fcc4f45665ce80635137>
> ________________________________
> 
> ...	 ...	 @@ -11,5 +11,8 @@ comments:
> 11 	11 	   Debian-bwh: |-
> 12 	12 	     Root can set a long string and maybe (but probably not) cause a
> 13 	13 	     null pointer dereference.  No security impact.
> 	14 	+  Ubuntu-tyhicks: |-
> 	15 	+    There's no security impact here as there's no chance of a NULL
> 	16 	+     pointer derefence. I've requested that MITRE reject this CVE.
> 14 	17 	 ignore:
> 15 	18 	   all: Invalid
> 
> *	issues/CVE-2019-12454.yml
> <https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/4975a4892b252c9bbfbf878f762ee590d24
> db76d#8302bbd052d9172f01ac5c2fd56d4d32c9331c11>
> ________________________________
> 
> ...	 ...	 @@ -8,6 +8,9 @@ references:
> 8 	8 	 -
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?h=for-5.3&id=a54988113985ca
> 22e414e132054f234fc8a92604
> 9 	9 	 - https://lkml.org/lkml/2019/5/29/705
> 10 	10 	 comments:
> 	11 	+  Ubuntu-tyhicks: |-
> 	12 	+    There's no security impact here from what I can tell. I've requested
> 	13 	+     that MITRE reject this CVE.
> 11 	14 	   bwh: kstrndup() was the correct function to use here.
> 12 	15 	 ignore:
> 13 	16 	   all: Invalid
> 
> *	issues/CVE-2019-12818.yml
> <https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/4975a4892b252c9bbfbf878f762ee590d24
> db76d#48dbd4dd2bf82f0bac0d69174fd84c3922c88c04>
> ________________________________
> 
> 	1 	+description: |-
> 	2 	+  An issue was discovered in the Linux kernel before 4.20.15. The
> 	3 	+  nfc_llcp_build_tlv function in net/nfc/llcp_commands.c may return NULL. If
> 	4 	+  the caller does not check for this, it will trigger a NULL pointer
> 	5 	+  dereference. This will cause denial of service. This affects
> 	6 	+  nfc_llcp_build_gb in net/nfc/llcp_core.c.
> 	7 	+references:
> 	8 	+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-12818
> 	9 	+- https://git.kernel.org/linus/58bdd544e2933a21a51eecf17c3f5f94038261b5
> 	10 	+-
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=58bdd544e2933a21a51eecf17c3f5f
> 94038261b5
> 	11 	+-
> https://github.com/torvalds/linux/commit/58bdd544e2933a21a51eecf17c3f5f94038261b5
> 	12 	+- https://www.kernel.org/pub/linux/kernel/v4.x/ChangeLog-4.20.15
> 
> *	issues/CVE-2019-12819.yml
> <https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/4975a4892b252c9bbfbf878f762ee590d24
> db76d#7b3bc19d6dc16fcf031a1414813fa02760eb38a2>
> ________________________________
> 
> 	1 	+description: |-
> 	2 	+  An issue was discovered in the Linux kernel before 5.0. The function
> 	3 	+  __mdiobus_register() in drivers/net/phy/mdio_bus.c calls put_device(),
> 	4 	+  which will trigger a fixed_mdio_bus_init use-after-free. This will cause a
> 	5 	+  denial of service.
> 	6 	+references:
> 	7 	+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-12819
> 	8 	+- https://git.kernel.org/linus/6ff7b060535e87c2ae14dd8548512abfdda528fb
> 	9 	+-
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=6ff7b060535e87c2ae14dd8548512
> abfdda528fb
> 	10 	+- https://github.com/torvalds/linux/commit/6ff7b060535e87c2ae14dd8548512abfdda528fb
> 
> *	issues/CVE-2019-12881.yml
> <https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/4975a4892b252c9bbfbf878f762ee590d24
> db76d#3cf19c003c2ea34c51106060d1e52102b8c3d0b0>
> ________________________________
> 
> 	1 	+description: ''
> 	2 	+references:
> 	3 	+- https://gist.github.com/oxagast/472866fb2c3d439e10499d7141d0a520
> 	4 	+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-12881
> 	5 	+comments:
> 	6 	+  Debian-carnil: Unclear status on the issue (e.g. if upstream is aware)
> 
> *	issues/CVE-2019-3846.yml
> <https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/4975a4892b252c9bbfbf878f762ee590d24
> db76d#ab6e4222149579eb6acce72c98259008854e805f>
> ________________________________
> 
> ...	 ...	 @@ -5,3 +5,5 @@ description: |-
> 5 	5 	 references:
> 6 	6 	 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3846
> 7 	7 	 - https://lore.kernel.org/linux-wireless/20190529125220.17066-1-tiwai at suse.de/
> 	8 	+fixed-by:
> 	9 	+  mainline: [13ec7f10b87f5fc04c4ccbd491c94c7980236a74]
> 
> *	issues/CVE-2019-3896.yml
> <https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/4975a4892b252c9bbfbf878f762ee590d24
> db76d#7e74ab88f79071d5850a89476022455d64ed6da0>
> ________________________________
> 
> 	1 	+description: |-
> 	2 	+  A double-free can happen in idr_remove_all() in lib/idr.c in the Linux
> 	3 	+  kernel 2.6 branch. An unprivileged local attacker can use this flaw for a
> 	4 	+  privilege escalation or for a system crash and a denial of service (DoS).
> 	5 	+references:
> 	6 	+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3896
> 	7 	+- https://bugzilla.redhat.com/show_bug.cgi?id=1694812
> 
> *	issues/CVE-2019-5489.yml
> <https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/4975a4892b252c9bbfbf878f762ee590d24
> db76d#3dd3e403bdf13d75d7dd8a78ab418d0ffe373b0d>
> ________________________________
> 
> ...	 ...	 @@ -51,6 +51,7 @@ reporters:
> 51 	51 	 introduced-by:
> 52 	52 	   mainline: [1da177e4c3f41524e886b7f1b8a0c1fc7321cac2]
> 53 	53 	 fixed-by:
> 	54 	+  linux-3.16.y: [b96659f18c61120dbf8b4cc36fbc05589bf9dc02]
> 54 	55 	   linux-4.14.y: [212c5685825c1ed45ac3a191dd7ada6e5889bfa2]
> 55 	56 	   linux-4.19.y: [f580a54bbd522f2518fd642f7d4d73ad728e5d58]
> 56 	57 	   linux-4.19.y-cip: [f580a54bbd522f2518fd642f7d4d73ad728e5d58]
> 
> 
> ?
> View it on GitLab
> <https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/4975a4892b252c9bbfbf878f762ee590d24
> db76d> .
> You're receiving this email because of your account on gitlab.com. If you'd like to receive fewer emails, you can
> adjust your notification settings.
