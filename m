Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FD2C54E67
	for <webhook@archiver.kernel.org>; Tue, 26 Mar 2024 06:29:37 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.2129.1711434568338871979
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Mar 2024 23:29:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 42Q6T65R3183484; Tue, 26 Mar 2024 15:29:06 +0900
X-Iguazu-Qid: 2yAajzvdac7Aoj1uRQ
X-Iguazu-QSIG: v=2; s=0; t=1711434545; q=2yAajzvdac7Aoj1uRQ; m=l0kGhENtY/7sotx2WVSkP4lk1uw0f1v5+Oj2tTH3n3M=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 42Q6T3S01903197
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 26 Mar 2024 15:29:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUBoyZyrYtcdDXQn0QMDaUswCWA6SwEwNSqZ4BcNPG5hKuZ6FTaNkDxfTJ9ZX+i68nViV0NPLeMe2i7l+E9iNQXlcmN3W0jFbY+Yz959dXK/N1mCcJ8tf88VXhSdGTYfQ3oxG0KpD32FUv8rq0GIlVO7k3vUOQzcLVmd2mL+PKkU4qNQUoBL1e91ugPW/cTJtQ8WHrhu3SDWqj/aum2vCNDFjg4uARrGEVI44Kjuk6fFhoYuvZGNBMMo2oKsEmYyHt6kqTJS1CrvvaEnHwPC8SkMHu+KCjO++59HRJYUL8glMLHfxR1lV5/l4Ig8XKPVhzn9PnmPhTz9cF24XbD+Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eyy9Z68Us62EiaVVqWAmIfE9qnzAevrSj3vvgliFK34=;
 b=Q7LN1pTBQSRnfuHKm/AFjJffpD3Qj7qS65CIVJZL0CV23sZe/cDoAEY2RJeV/0NvZAgtiSUiynmED3inhsbgpaPN1lUZNYQ5pFDWczWfKa+CQ0zX/Yhxc0n7NwETfWdTV1elplSQhC5hmpwQ64HwzQdqHeQ/YWgRXesXGyfVtbS84OfxHtFsiTko4el4qETczfWn4bSfWRPoAVnrwrYbZHyeGj7LlaKZ39962Rn6Ad5BGxaugTYhTM82k4i2GhsuC76GE9Hpd9dQLue4CWMJrw2h9eN1WIBdy6mX0+86rKA3hwHJCKz8QH2mpcf2J74Kc7Z50h1mzJ3cALDcPvVLeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <Chris.Paterson2@renesas.com>, <pavel@denx.de>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>
Subject: [ANNOUNCE] Release v4.19.310-cip108 and v6.1.82-cip17
Thread-Topic: [ANNOUNCE] Release v4.19.310-cip108 and v6.1.82-cip17
Thread-Index: Adp/RrXy7RSIertBR7S2IADM9bgaHw==
Date: Tue, 26 Mar 2024 06:29:00 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB63886C24A1FA29E2DEFA45BC92352@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TY3PR01MB10486:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 mHbES2Xoh4Z+sxny1eEetZX+TZTtvxVTUjDSfrBRAz85alpzkI4pQp1znomUXHHWkF8MbCrqnc+lOIZJMgCTYDtTr3Ppx1Gp5KQ0LTMLfyElGKIudYUPtdpxLP5kvKpi8uAAp7dn2xiyTuzGaiRn44UsJxgm/qlPfYomut21eL/b8dB3ukDrFQI2Na0lQeLio2N9V2jont+cVJmO05cx5XGQD0vSuDepDUrBjLtY4A2XrqqUXl/BBAgIKukor33oh/cYJNikzf8XiHzIX8oTMUKgfnnvHuh+b7UWkNDf+Pi0aE4yUqeBobG7L8Go0bN1nGEZNgzUryPKelBysUtd9QnSeAAREZStWk1vH7EjS6uzI++hWfpzkHHdxceEI4vYfp8+bCSmKMhQ+2o3ruePZWgm9YCb8IcSpMwysLQb+q0aY6z4jApekqJYaRRXI7vp6B/baSCd03gOft9nxNNiMZlxf6TSl422ou+mk8+r0OomfpF7LkNG2LIu+loTkOLVevnVD9zoNBUZFA7sQc4bGskubfE/qAcNP3p3leMt9qYWEZ5G1w4yoo4hg/DrhTj2RnDZwmsIDWSSW5VWWwaaSWqNnv/GSaxfnpp1csAc+wcpVWYfIKseKc8hHKJjgZC/gnUJdBb6habMhESsXRuW44LQyVvg7DxYWA63gGKZPFE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(95630200002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?c0t0RlRtMWxUZDNRT3c5ajVyYUYxVmc4SHcrNmRYMm1oM2VBWDQ0MUt1?=
 =?iso-2022-jp?B?SnJBbXJPN2FnK1ltZC96ekZBNi84bDZ1YlBGZ3Z6TmFrZGM1K1c2ZjhJ?=
 =?iso-2022-jp?B?Rkt1WGl5Ti94YVpMYVczcyswNEQ1RXVUSVovd1FIUXIrTUpwdDlrM2VX?=
 =?iso-2022-jp?B?NThKRXBEbnE0VG9QY2ZYVitMTVZZQ0tqb08zektja1d5Rk1CVUhZS3NC?=
 =?iso-2022-jp?B?YVlKSk1QNms1UGswNjVuV2NWUzBqY3Y2OTNESjJCNmVXQ0EyeDdlek45?=
 =?iso-2022-jp?B?cm55M2paOVJLZHdSbVFhVFdGZGI5bjNtZTdKckV5L0lxV3YxRnNrY1ZO?=
 =?iso-2022-jp?B?L1Nia2pXRk9YMHB0MS9zWHhUTFV3eHJrZUtabVoyV1NCQVFLQXp3RXZR?=
 =?iso-2022-jp?B?TXZpR1JRZ3dGODNjVjA3d0dyeW54OFNHelBQSzF4T0ptUzVpa001WFNW?=
 =?iso-2022-jp?B?V2hpa09wSTYrU1hjUERkYnJZOWlVY2FFUUMwaldvL0xMMzJ3bzE4UGpa?=
 =?iso-2022-jp?B?SUFTWWZiajljQ1lYN1ZDdjRDMjZDOFY1T3dsdlZZOXl5SndQVHZzVkJi?=
 =?iso-2022-jp?B?L0RIcm9BNCtoYzhydlBlUFY4cXJTTzJ4SW9qb0ZaYlBNOFQrNWNmM3pX?=
 =?iso-2022-jp?B?VUloa213VFlHZ0F4VnYwNlJVMDd5ZDhIcW9VcUVZd2RoNk96NHNUaFlS?=
 =?iso-2022-jp?B?dUtuWVJjRmU2YWoxa3c0WmZ6YWF2c2lQb2NuMFN0clZmV1dZYVlkZHgz?=
 =?iso-2022-jp?B?OVIzNzBFd3RTUmJkUE95WXN3Si9jZ3k0amd5UEN6bnpXZWEzN3puYU8y?=
 =?iso-2022-jp?B?aEIyckx6b3lNTkJxMWM2TnRpUGVieGRYeS9mS1VPMTYya1V0c3NzZHYw?=
 =?iso-2022-jp?B?dUJnZmZRaDVUOXpHK0p4d1F1SlgzbFNuR0xTYTk5NzZEckY5NWpZR0V5?=
 =?iso-2022-jp?B?c1J5U0lBeTVzWmJpU3pjQXN2TE4vK2FQU3pDYkZ4dGlkZDdNQng2RXgv?=
 =?iso-2022-jp?B?ZjFTcjlNRE8wNEk2Q0tSNlltemtQSHYzbW9tdkRrNG5MQ1h1MEJCWU0r?=
 =?iso-2022-jp?B?aXgxZEZUVmNJSHpNR1VXeTZoMytBMFI2Y01TMFM5S3daN2hsWTZ5TTFZ?=
 =?iso-2022-jp?B?ZjFqZmx4SEdRYzNrVWFVZGNLYVltWmNCNkJyTlNPeVFrSXUyd2JhaWxJ?=
 =?iso-2022-jp?B?L2JicVZhbjBXNUxsUTJRelFaY3gzNldTZE1UOUJDd1RYUkErZXJMRXB0?=
 =?iso-2022-jp?B?c3VKRlZTOVkyWDhINTE1OUpqM0VnUE85bG5rRzhRazNYaHdCR3pYeDhD?=
 =?iso-2022-jp?B?MzZqb3JIRWVxMWRFOW1aZWhVZ2R5T2hFY2Q1c3NSU1JueXdjd1I2clB2?=
 =?iso-2022-jp?B?R1p2Kzdoc3kxUklYb0E1M0JvcCtYUy9KbGI5TGh1WEZQU1g5cnMvNWFU?=
 =?iso-2022-jp?B?Uk1RNG9vYnJmNlczMHN1SWM0M3gyM2lVVi9UR0dNQk9FRmg5amRabVBa?=
 =?iso-2022-jp?B?VHN2VWJIR1FGd1d4WjRkT3ZBQk1wVXNWMlN4OEVyWXZ3Wk02VkpQNHhM?=
 =?iso-2022-jp?B?WVptQVlkUWVsN2hRYWNhNmt4d0ZXY3pSOVZYNUtYV2FiSjVLSXY5OFZn?=
 =?iso-2022-jp?B?RktlVHZ3VkJPSE5mZnhOQjJJeDVSUlFvbnM5TWQ3YVRBcTlCeG85UUhy?=
 =?iso-2022-jp?B?RUNHOER0QWxGYUtvUXhQZjRwbWVXNGZTWEprci9ZczlvdndhaWJWS2JK?=
 =?iso-2022-jp?B?S28zYTIvVFExUjg4d0c3RmN4dlRJQ2EwZkZubFdLcEZtY3pFR2pLbXJw?=
 =?iso-2022-jp?B?bm9aM1VRRktSQXh3WVE1UmY1aWtHL2JhUlA5OFQrVTZkbjN4NW9SajZJ?=
 =?iso-2022-jp?B?dkpwZUJXaVF6WmJPQVFmOHdmaE1rRUxqNjc0eGFMLzlaOE82UDdORkRr?=
 =?iso-2022-jp?B?MWErUm5VdFFOZEFiNE9XaVBBb2p1U3hYd1prdXNEQVk5cVFWeWloSWZP?=
 =?iso-2022-jp?B?TGExMzV5bDY4aEVVV1pBZ2FrWVNtZS83dktFdDZReFNFNWg0TDBPa29h?=
 =?iso-2022-jp?B?aU1aeFUxUnN5dXdUYXN4TzlxdFU4bFNEUkhRcnFlOUFtRTdVOWNVSmVk?=
 =?iso-2022-jp?B?SExYc1AzNzY3eEgyZkI5UlJyL0FQMExTRURlcFJ1eTFDUlJrUUNTOEl2?=
 =?iso-2022-jp?B?REFjZ01DYmJyQlhrV0ZUUVJmWVBzckFqdkdtcE8rV21GSERVMEJTUm1o?=
 =?iso-2022-jp?B?VXk5SzNGM3VVYldzL21aMzRqVEZGdHNvNEhncmhMSTh4SGtRaysvQzlB?=
 =?iso-2022-jp?B?azNRcFEwbmpoWjQxMk50OUJzdEU0K3IzUWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d1abe0-c8fe-48d6-59cc-08dc4d5e0642
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 06:29:00.6531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R0isb+egdSbuTDyJk/Mf/KBLBziIar8V0Na+ohUe/aOp03b3HDE+Mbkb0l+N8XuHd9cfxJCkqm/Jv+XCJp8yGz948HuEFli1E8S3gP3phmsQDp3RbjPr9aoG9jVJkiPo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10486
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Mar 2024 06:29:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15414

Hi,

CIP kernel team has released Linux kernel v4.19.310-cip108 and v6.1.82-cip1=
7.
The linux-4.19.y-cip tree has been updated base version from v4.19.306 to v=
4.19.310, and the linux-6.1.y-cip tree has been updated base version from
v6.1.80 to v6.1.82.

You can get this release via the git tree at:

  v4.19.310-cip108:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      b39bba29c35ca19fc6eec7baed1210cfa4c70c44
    Fixed CVEs:
      CVE-2023-52437: Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in ra=
id5d"
      CVE-2024-26606: binder: signal epoll threads of self-work
      CVE-2023-52486: drm: Don't unref the same fb many times by mistake du=
e to deadlock handling
      CVE-2024-26600: phy: ti: phy-omap-usb2: Fix NULL pointer dereference =
for SRP
      CVE-2024-1086: netfilter: nf_tables: reject QUEUE/DROP verdict parame=
ters
      CVE-2024-26609: netfilter: nf_tables: reject QUEUE/DROP verdict param=
eters
      CVE-2023-52598: s390/ptrace: handle setting of fpc register correctly
      CVE-2023-52615: hwrng: core - Fix page fault dead lock on mmap-ed hwr=
ng
      CVE-2023-52619: pstore/ram: Fix crash when setting number of cpus to =
an odd number
      CVE-2023-52604: FS:JFS:UBSAN:array-index-out-of-bounds in dbAdjTree
      CVE-2024-26635: llc: Drop support for ETH_P_TR_802_2.
      CVE-2021-33630: net/sched: cbs: Fix not adding cbs instance to list
      CVE-2023-52587: IB/ipoib: Fix mcast list locking
      CVE-2023-52597: KVM: s390: fix setting of fpc register
      CVE-2023-52594: wifi: ath9k: Fix potential array-index-out-of-bounds =
read in ath9k_htc_txstatus()
      CVE-2023-52606: powerpc/lib: Validate size for vector operations
      CVE-2023-52603: UBSAN: array-index-out-of-bounds in dtSplitRoot
      CVE-2024-26636: llc: make llc_ui_sendmsg() more robust against bondin=
g changes
      CVE-2023-52600: jfs: fix uaf in jfs_evict_inode
      CVE-2023-52602: jfs: fix slab-out-of-bounds Read in dtSearch
      CVE-2023-52601: jfs: fix array-index-out-of-bounds in dbAdjTree
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
      CVE-2024-26613: net/rds: Fix UBSAN: array-index-out-of-bounds in rds_=
cmsg_recv
      CVE-2024-26602: sched/membarrier: reduce the ability to hammer on sys=
_membarrier
      CVE-2024-26615: net/smc: fix illegal rmb_desc access in SMC-D connect=
ion dump
      CVE-2023-52607: powerpc/mm: Fix null-pointer dereference in pgtable_c=
ache_add
      CVE-2023-52605: ACPI: extlog: fix NULL pointer dereference check
    added commits:
      CIP: Bump version suffix to -cip108 after merge from stable
      memory: renesas-rpc-if: Clear HS bit during hardware initialization
      arm64: dts: renesas: rzg2: Add RPC-IF Support
      spi: spi-rpc-if: Check return value of rpcif_sw_init()
      memory: renesas-rpc-if: Remove redundant division of dummy
      memory: renesas-rpc-if: Simplify single/double data register access
      memory: renesas-rpc-if: Drop usage of RPCIF_DIRMAP_SIZE macro
      memory: renesas-rpc-if: Return error in case devm_ioremap_resource() =
fails
      memory: renesas-rpc-if: Fix HF/OSPI data transfer in Manual Mode
      memory: renesas-rpc-if: Correct QSPI data transfer in Manual mode
      memory: renesas-rpc-if: fix possible NULL pointer dereference of reso=
urce

  v6.1.82-cip17:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      9697800989924e6cf915d19fdd0704ff259c4413
    Fixed CVEs:
      CVE-2024-26622: tomoyo: fix UAF write bug in tomoyo_write_control()
      CVE-2023-52620: netfilter: nf_tables: disallow timeout for anonymous =
sets
      CVE-2023-2176: Kernel: Slab-out-of-bound read in compare_netdev_and_i=
p
      CVE-2024-26621: mm: huge_memory: don't force huge page alignment on 3=
2 bit
      CVE-2023-28746: Register File Data Sampling (RFDS)
    added commits:
      CIP: Bump version suffix to -cip17 after merge from stable

Best regards,
   Nobuhiro


