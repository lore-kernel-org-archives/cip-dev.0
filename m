Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E53C5475B
	for <webhook@archiver.kernel.org>; Mon, 11 Mar 2024 21:48:42 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.5848.1710193712778236791
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Mar 2024 14:48:33 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 42BLmB2F1992835; Tue, 12 Mar 2024 06:48:11 +0900
X-Iguazu-Qid: 2yAawbgn14TnqaV1MX
X-Iguazu-QSIG: v=2; s=0; t=1710193691; q=2yAawbgn14TnqaV1MX; m=2PzCCNqlg+iieZvmmhlFtfISiX6Son9pK06f2237D/4=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 42BLm9Ws2786977
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 12 Mar 2024 06:48:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heRRZfH7dOp/CCw78jQnzoFGeVzZyWdnlTcrELQGTEUGy4xa6xs26XBd1/BD0evZim2oRuRiYZGfLJKW4y/i1Kl8Lb154aEm7O+GnIvqpK/w5+tf9YZX0zSfJncXkP4yE2qdBupWwS24a9Iqe7cqsxBjV0s9MkNIMiJp8fP0yyWLxQEB6elzhX9D+DSuL+oy0uyJ+rtmNn1zC7tuZ1I6iU6ZeJeZ5G9zXflyrv0Aj5VyKlPmlDbfAsdeXIxz5RmsYr3XjDZATsWp2czhzsndFhUhQF9kmnJyWIIkbnn+t/lZBi7q5AiQAo3Dx9t0ux9QJSR6Qc8pUcRt3ra6dcpWFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcCDIiyKuZki/4HryKrckL9xzjQZlr2r9cruH1ehyUQ=;
 b=B1o7BI82Gt4i0NoEh+lmMZ+x0/zYRO57KBqcfoKchdiStrawCD3b7eFJQLu+7XWBG6Ocx4aO8k0xvMKPLLlzYhSADNeLtTlWlkYQFp/t1dihfBMoxWsMhr+F+h2pTtqYdDuPUwuslCKLTb/FaR5FZdFi3WnCy4aY/OCnhaKKaz1kU9zYOydVw82CaOusie8aCHgbW1DNadFeAm9BOGyBHkl7A4Fxf29SujiISzlOCZngnCLqdeIut4Z3NgjHiR91djGuD+CC75xR6C/62V2kFB2zM8V788sdSTkr6otuTzNYbPO/IHVcKO3X7VshNwHQhHgYdJeJoo6vzDTnLWxG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v5.10.212-cip45
Thread-Topic: [ANNOUNCE] Release v5.10.212-cip45
Thread-Index: Adpz/OV5dAvh9TgmQRe2pzr68fqDbA==
Date: Mon, 11 Mar 2024 21:48:06 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB638832966C2DFF1BA6799C3092242@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYCPR01MB10431:EE_
x-ms-office365-filtering-correlation-id: ab33cc1e-85e9-478d-fa42-08dc4214efac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 g2/ZgWkAZ9lho28qdbkR9b2bwQ/Uw344uUwpwcMZvKufXXoI73ds2isOJXPX64v1+ZMrmsUx4lI5j6cg15CZnMZLVlH1xlV9JaHcXuOBXlrJlRKPS64dzHaVoov93AItJ0K23P7nYut63tcPtnFqFVfjbB+4B79YWOSPIUhTQb0WcMJpEi+JGjqXXAO865wLqKV00+IaTcWYNb4MtRe3kng8jle+3HNfwG8j6rXm5Gj+ZVT1KRkihw/M6P0O5c6DZQdsswTnL7nn9KweVLkILfrNDSlBEfZyBlbPFZi8hNrg0FaZaFegJQI1V7RjuQQiejz4ileuZOvqj4zdlebpxzfr5uvo1Np9LOK1c4LRRc2Wo8EppnddOz0qJElO8G9sLuTRgyLP047qUTywELhwgygPgpKeGuHtldHFs7xNK8TBI/w65i4gYVebc30rUFVfD7Hedpj4CiqEr7cHh3dLv67LjFLGIAgl/1BrNPvld0OTN35pMFaOeuZ8S1EQqyR2aOM2PaprvU9ggsdsh9uqxioAzV1vSLrOgX2g2yqlaRzcrSjpKYIyPMZ5J29zJ/4WiB50rJ8rLt6Zpf8v20SPvSnicxokCnO2u8+sfbFKFSnCVcJBETQ18mx74auzPeuuRVoiPkvKihQi9VJNhlkeBjPU2ucSwOuH7uQwbz49hpgRxPzmlZ59BQSbuGWsPF29
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bnFnemhaaXNwdVF1WnNNU3djbnNyL0k0TmhQeFZUNzhjQXFxS0s3R0N6?=
 =?iso-2022-jp?B?YkY5ZkpwMzh2M0taTC80Z1IwVDNiUVcvRTRlL2lMWmY1ZmFROFRVaGRB?=
 =?iso-2022-jp?B?Sy8yY1JFRGExT0NxMTJ0TEg3VkM2SStydDZyYjVLRFA3blc0czNVMHZn?=
 =?iso-2022-jp?B?NXJIU0VoZjZFUmNuc1pkdyt1MXJObkRXZlFsNi9ZbXdEV2pTUGJsNVJw?=
 =?iso-2022-jp?B?dDJEdUdJN1FCVzU2M29BVHpicmU3RTBodk1RZi8vZ0tEVFN6bXN6RUxv?=
 =?iso-2022-jp?B?NU5Majh4cm44dTYyVXZTQk9vUXlhWTc1THBFNllhTC9CTFdUMXg2QzU1?=
 =?iso-2022-jp?B?UjA0R0swTVordzNZQnh5dUlWVTJOSFdqZjJUWnlrY3NUczdpbEI0akxn?=
 =?iso-2022-jp?B?ZWpJUjhMZzUxTGFOM1pRKzJKZ2lrK212cnFFOTI3OUxFWE9WMHg2SnNo?=
 =?iso-2022-jp?B?cFM5L3NVTlY5NFpra0VWQnFUVmxoOWpyWm5nTzdxMG9UWWRHZzV6Vm5L?=
 =?iso-2022-jp?B?N0VveUpwVnZ3K2lCOCsxa001d2hBQWRjaGZaRE9zekpMU0Y0eXRXamlu?=
 =?iso-2022-jp?B?ZmQram13N2pnZjd3Y0FRQ2I4K3JoK3R1amVta3lDUTZkS0IrT1J4N2Rv?=
 =?iso-2022-jp?B?SGx5V3FVWlpXNlVBWEk0Y2pDeTMyOHBocEhCL0NGWUltMjE3UjlaTElP?=
 =?iso-2022-jp?B?VUNGQnFtcDVFMU5qQm1XaWF5eklSS0RMMmhSTTBVSG1KbXpxcEk2aW1j?=
 =?iso-2022-jp?B?TTVWU3J4dHJYQU0yT09BY0ZiQVRvbXBCd1JoZ2dMM21ZRVlGUUtONkRU?=
 =?iso-2022-jp?B?MW5UZmZJMm5BRi9sZWE0eVp5dmNVd0sxTE1tKzFKLzd0T2x5ZHFYblhn?=
 =?iso-2022-jp?B?NkVpQ29UZEFVR3ZoOUlqaTNZNEhsK1ozNFd0UnE0WUxtVU5rcGtaSGtN?=
 =?iso-2022-jp?B?K0luTk9qWUYwVHBZbG82WU5mY29sVlpnMExjSmpuUithcHFIbmtqQ21G?=
 =?iso-2022-jp?B?Y0JTajR5ejBTdk5rTi80cExhSWxYNEpZQk4vd0JGcGVFblliRityaEVH?=
 =?iso-2022-jp?B?NnNGMFpBQ29YSUtxbVFFbm5SaHZjZkNCUzZRd3RGeDhXNlpPUmhYYUFw?=
 =?iso-2022-jp?B?Mm9sMC94YjFOVFdadDBkNFUvMW11QWxjV0RhS0pwVWRramhQOFY2ZFYz?=
 =?iso-2022-jp?B?MXNLeFcxZCtENC9qOE5MWXV1SDFVVVhIcUhVbWlmVTFxUzJURVN2Z0Yv?=
 =?iso-2022-jp?B?Y3NFQ2NwY25tdUpPYVk1SGdEa041UnRzQ3F5SENISFBzeTNTS2c2b29B?=
 =?iso-2022-jp?B?UG9MYkdvc2V0MlFGNXFUYitmS0hHcVE0TUVNQXdnZGxJek85QkNkcUpi?=
 =?iso-2022-jp?B?Yjh5WTB2OTJwcDJZM0F2bks5SXdLckxyNzdhZTZPdGczWFgrSXMwcmhW?=
 =?iso-2022-jp?B?QTR3U1ZuRlJSYUt6MHRtcFlGUld5V2F2eXE3ZytocDJmRm93L29Ea3ht?=
 =?iso-2022-jp?B?VktMN3NucWgzcXgzSG5tTXN5eHIraGN5Q0lma00rNndnZDRBRkFEMDBW?=
 =?iso-2022-jp?B?MnE0TWt5UjlwdkxYN1NJVndUc1I1aWtvSkFmV0xRdUVPNHpzc3I3Y3ZD?=
 =?iso-2022-jp?B?dyt2SGpMOWZBSzZ0OW5zZHBSakd4RWhRRlVQQVA1a1B3SVlRZmRwZkox?=
 =?iso-2022-jp?B?REtGbFc0WFBja1RHSW8yUFVGNHl5WE5wNmRjZzNWMGxwMUROTTBoelhr?=
 =?iso-2022-jp?B?TTF6SmFiS1RNaDJOL1Fzc0pEYk5LQTZiWnJFdUVjb2NCSHowTnRob2h6?=
 =?iso-2022-jp?B?Q24xZ2tpd1c2aFhPZTlGQWJGYm1TdWdPZGs1NDg2VytQOURXTWgwQm9k?=
 =?iso-2022-jp?B?SE84aEJ5VUVoaUg3WVFTYkg1WFhRRHZnaFBheDNKTUszTjlDVkh2c3Yy?=
 =?iso-2022-jp?B?M0FINWJLWStiSGM2UVd5U2ZzVlBBU21qV2N2THl0QTJPa01uTlB1QnJk?=
 =?iso-2022-jp?B?cUJVNThxRnZYK25yVU1ORzBtNkdpSjVIL2RHVFROelhmbHdVN2VlN3Y3?=
 =?iso-2022-jp?B?QldsRHpYTXp4NnF4UW9sWGhsM2duSnRiMHJtZGZJQW84MUw1dnZ4UWkr?=
 =?iso-2022-jp?B?dFBuT1V4eTFpNng3ZStFdkhFZVUwcDEwM1BoQmMrMmNFbDc4S29MdFJ0?=
 =?iso-2022-jp?B?R3dhMDM3VUxrSmpDa3k0TmRPbkJiaitnc08rNzd6VmFPRlJjOUQ2bFUw?=
 =?iso-2022-jp?B?dWthaU5xRHVzaWR2VFBnbjdpYVAwLzFTVFExVWNXdFVyMXRMOXVOWm9D?=
 =?iso-2022-jp?B?NTlrSkdqaFVMUjFMRzcxKzB5SEJ3dFBPNkE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab33cc1e-85e9-478d-fa42-08dc4214efac
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 21:48:06.7477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F12+x/eTFDyEnWyYWDADejm6QAb3urqITIziUZ1ueTRIlsN1mwZAIRoRTtIFnSfQYIC/ApLIGe5qhS5/cX3N0bsrkvQ2rIooS+uncqGooGHtDJosY7k6Lh5WwpXkGCfj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10431
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Mar 2024 21:48:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15273

Hi,

CIP kernel team has released Linux kernel v5.10.212-cip45.
The linux-5.10.y-cip tree has been updated base version from v5.10.209 to v=
5.10.212.
This release adds support for Renesas RISC-V SoC (rzfive/r9a07g043f).

You can get this release via the git tree at:

  v5.10.212-cip45:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      6d03567cbcdc99d0c6372154f02172276261f851
    Fixed CVEs:
      CVE-2024-23850: btrfs: do not ASSERT() if the newly created subvolume=
 already got read
      CVE-2023-52491: media: mtk-jpeg: Fix use after free bug due to error =
path handling in mtk_jpeg_dec_device_run
      CVE-2023-52437: Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in ra=
id5d"
      CVE-2024-26606: binder: signal epoll threads of self-work
      CVE-2023-52492: dmaengine: fix NULL pointer in channel unregistration=
 function
      CVE-2023-52486: drm: Don't unref the same fb many times by mistake du=
e to deadlock handling
      CVE-2023-52493: bus: mhi: host: Drop chan lock before queuing buffers
      CVE-2024-26614: tcp: make sure init the accept_queue's spinlocks once
      CVE-2024-26600: phy: ti: phy-omap-usb2: Fix NULL pointer dereference =
for SRP
      CVE-2024-1086: netfilter: nf_tables: reject QUEUE/DROP verdict parame=
ters
      CVE-2024-26610: wifi: iwlwifi: fix a memory corruption
      CVE-2023-52595: wifi: rt2x00: restart beacon queue when hardware rese=
t
      CVE-2024-26609: netfilter: nf_tables: reject QUEUE/DROP verdict param=
eters
      CVE-2023-52598: s390/ptrace: handle setting of fpc register correctly
      CVE-2023-52604: FS:JFS:UBSAN:array-index-out-of-bounds in dbAdjTree
      CVE-2023-52429: dm: limit the number of targets and parameter size ar=
ea
      CVE-2023-52587: IB/ipoib: Fix mcast list locking
      CVE-2024-26581: netfilter: nft_set_rbtree: skip end interval element =
from gc
      CVE-2023-52597: KVM: s390: fix setting of fpc register
      CVE-2023-52435: net: prevent mss overflow in skb_segment()
      CVE-2024-26593: i2c: i801: Fix block process call transactions
      CVE-2023-52594: wifi: ath9k: Fix potential array-index-out-of-bounds =
read in ath9k_htc_txstatus()
      CVE-2023-52606: powerpc/lib: Validate size for vector operations
      CVE-2024-1151: net: openvswitch: limit the number of recursions from =
action sets
      CVE-2023-52603: UBSAN: array-index-out-of-bounds in dtSplitRoot
      CVE-2023-52600: jfs: fix uaf in jfs_evict_inode
      CVE-2023-52602: jfs: fix slab-out-of-bounds Read in dtSearch
      CVE-2023-52601: jfs: fix array-index-out-of-bounds in dbAdjTree
      CVE-2024-26627: scsi: core: Move scsi_host_busy() out of host lock fo=
r waking up EH handler
      CVE-2023-52599: jfs: fix array-index-out-of-bounds in diNewExt
      CVE-2024-26625: llc: call sock_orphan() at release time
      CVE-2024-26624: af_unix: fix lockdep positive in sk_diag_dump_icons()
      CVE-2024-0607: netfilter: nf_tables: fix pointer math issue in
nft_byteorder_eval()
      CVE-2024-23849: net/rds: Fix UBSAN: array-index-out-of-bounds in rds_=
cmsg_recv
      CVE-2024-0340: vhost: use kzalloc() instead of kmalloc() followed by =
memset()
      CVE-2023-52583: ceph: fix deadlock or deadcode of misusing dget()
      CVE-2024-23851: Kernel crash in drivers/md/dm-ioctl.c when allocate m=
emory more than INT_MAX bytes
      CVE-2024-26613: net/rds: Fix UBSAN: array-index-out-of-bounds in rds_=
cmsg_recv
      CVE-2024-26602: sched/membarrier: reduce the ability to hammer on sys=
_membarrier
      CVE-2024-26615: net/smc: fix illegal rmb_desc access in SMC-D connect=
ion dump
      CVE-2023-52489: mm/sparsemem: fix race in accessing memory_section->u=
sage
      CVE-2023-52498: PM: sleep: Fix possible deadlocks in core system-wide=
 PM code
      CVE-2023-52607: powerpc/mm: Fix null-pointer dereference in pgtable_c=
ache_add
      CVE-2023-52605: ACPI: extlog: fix NULL pointer dereference check
      CVE-2024-26601: ext4: regenerate buddy after block freeing failed if =
under fc replay
      CVE-2023-52497: erofs: fix lz4 inplace decompression
      CVE-2024-0565: smb: client: fix OOB in receive_encrypted_standard()
      CVE-2023-52434: smb: client: fix potential OOBs in smb2_parse_context=
s()
      CVE-2024-26622: tomoyo: fix UAF write bug in tomoyo_write_control()
      CVE-2024-0841: hugetlbfs: Null pointer dereference in hugetlbfs_fill_=
super function
    added commits:
      CIP: Bump version suffix to -cip45 after merge from stable
      arm64: dts: renesas: rzg2ul-smarc: Add support for enabling MTU3
      arm64: dts: renesas: r9a07g043: Add MTU3a node
      dt-bindings: timer: renesas,rz-mtu3: Document RZ/{G2UL,Five} SoCs
      dt-bindings: timer: renesas,rz-mtu3: Improve documentation
      dt-bindings: timer: renesas,rz-mtu3: Fix overflow/underflow interrupt=
 names
      cache: Kconfig: Add dependency for RISCV on AX45MP_L2_CACHE config
      riscv: dts: renesas: rzfive-smarc: Enable the blocks which were expli=
citly disabled
      riscv: dts: renesas: r9a07g043f: Add dma-noncoherent property
      riscv: dts: renesas: r9a07g043f: Add L2 cache node
      riscv: dts: renesas: Clean up dtbs_check W=3D1 warning due to empty p=
hy node
      riscv: dts: renesas: rzfive-smarc-som: Drop PHY interrupt support for=
 ETH{0,1}
      riscv: dts: renesas: rzfive-smarc-som: Enable OSTM nodes
      riscv: dts: renesas: rzfive-smarc-som: Enable WDT
      riscv: dts: renesas: rzfive-smarc: Enable CANFD/I2C
      riscv: dts: renesas: r9a07g043f/rzfive-smarc-som: Enable ADC/OPP/Ther=
mal Zones/TSU
      riscv: dts: renesas: Add minimal DTS for Renesas RZ/Five SMARC EVK
      riscv: dts: renesas: Add initial devicetree for Renesas RZ/Five SoC
      riscv: Kconfig.socs: Add ARCH_RENESAS kconfig option
      soc: renesas: Kconfig: Select the required configs for RZ/Five SoC
      cache: ax45mp_cache: Add non coherent support
      cache: Add L2 cache management for Andes AX45MP RISC-V core
      clk: renesas: r9a07g043: Add support for RZ/Five SoC
      soc: renesas: Identify RZ/Five SoC
      dt-bindings: cache: andestech,ax45mp-cache: Add DT binding documentat=
ion for L2 cache controller
      dt-bindings: clock: r9a07g043-cpg: Add Renesas RZ/Five CPG Clock and =
Reset Definitions
      dt-bindings: riscv: Add Andes AX45MP core to the list
      dt-bindings: riscv: Sort the CPU core list alphabetically
      mmc: host: Kconfig: Make MMC_SDHI_INTERNAL_DMAC config option dependa=
nt on ARCH_RENESAS
      clocksource/drivers/riscv: Get rid of clocksource_arch_init() callbac=
k
      clocksource/drivers/riscv: Increase the clock source rating
      clocksource/drivers/renesas-ostm: Add support for RZ/V2L SoC
      irqchip/sifive-plic: Separate the enable and mask operations
      irqchip/sifive-plic: Make better use of the effective affinity mask
      irqchip/sifive-plic: Add support for Renesas RZ/Five SoC
      irqchip/sifive-plic: Disable S-mode IRQs if running in M-mode
      irqchip/sifive-plic: Improve naming scheme for per context offsets
      of/irq: Use interrupts-extended to find parent
      of: also handle dma-noncoherent in of_dma_is_coherent()
      dma-mapping: make the global coherent pool conditional
      dma-mapping: add a dma_init_global_coherent helper
      dma-mapping: simplify dma_init_coherent_memory
      dma-mapping: allow using the global coherent pool for !ARM
      dma-direct: add support for dma_coherent_default_memory
      riscv: Kconfig: Enable cpufreq kconfig menu
      cacheinfo: clear cache_leaves(cpu) in free_cache_attributes()
      arm64: dts: renesas: r9a07g043: Split out RZ/G2UL SoC specific parts
      arm64: dts: renesas: r9a07g043: Update IRQ numbers for SSI channels
      arm64: dts: renesas: r9a07g043: Introduce SOC_PERIPHERAL_IRQ() macro =
to specify interrupt property
      arm64: dts: renesas: rzg2ul-smarc: Include SoM DTSI into board DTS
      arm64: dts: renesas: rzg2ul-smarc: Move selecting PMOD_SCI0_EN to boa=
rd DTS
      clk: versaclock3: Drop ret variable
      clk: versaclock3: Add missing space between ')' and '{'
      clk: versaclock3: Use u8 return type for get_parent() callback
      clk: versaclock3: Avoid unnecessary padding
      clk: versaclock3: Update vc3_get_div() to avoid divide by zero
      arm64: defconfig: Enable Renesas VersaClock 3 clock generator config

Best regards,
   Nobuhiro


--
Nobuhiro Iwamatsu


