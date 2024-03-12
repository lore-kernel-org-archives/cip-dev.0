Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B2DC54E58
	for <webhook@archiver.kernel.org>; Tue, 12 Mar 2024 10:50:17 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.9])
 by mx.groups.io with SMTP id smtpd.web10.5827.1710240612901620332
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Mar 2024 03:50:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=JT9SjtTg;
 spf=pass (domain: renesas.com, ip: 52.101.228.9, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nO+gLHHd7/DIZwJX/DfKmX+caCqJF1BUTnYZbg3iT4Q67f3+I5eqb3bGyRr7MSf/ef/vEOmSuIlndGG/HD+g2ZMZ7afhOIeq+cdWW7YHr58W/rAOWygCDL+MPAVfEl+h02bgyH0Ti3O6NBj1rNew5RSvHX76ropXZQPVQldFt4+dOtdWUReieSYRhAlFH2wtnOlt9r97tamQovNtZm96H8so4ZO3v8S5Kja9DSZSUzXJL9c1FXM2cbgBj2lOkf6LSVfzAQClZG7Or32PhlBbbY1iSETEzi8gTHxhVWeGY0UEzA/xTbf8wed9y0pjGJzPQA88aaro/YoxAVM0emL4Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpPQcNpB4rrT7HXpRL4J+yyAgEubedyVCSJBDvkQizU=;
 b=C+U/I//KT4FrWY+ksdtG5jf1bsw/mW5Zkux0v33nxhToJ/EjrsP2G84tdIlZASsWRwk7p29I/GH4GU47hOoAsyyGIT7TN+lpJhYiACDa23ryBqOUlOiosRn0SLq4Z1oy8RvMuatsTgKOs3ZP5wbCmLgFyK8h7uFwcef6JuiXv1jcuwrEk3jO63VIPq4kHEU60Xsy8vFHih59gYjQ9XYHilX40/+PhZjCmiAc3+P+XdPBtwvgpryMoCuMP6yu44dO1KEbq6w8Tb+GRx+2jnzynJbchprmBH1Wh5qZCZKfXbuAXl60WohC1a46S26okYDBcziTjmzZpW4JhZNUiJZ60A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpPQcNpB4rrT7HXpRL4J+yyAgEubedyVCSJBDvkQizU=;
 b=JT9SjtTgpvCp5hHNoKiWMCHFdUsaWSu11Yhn6A96lgDK5lCteNEFfwyMeFyS2OAZqTuR8EwbwIZT+ZvGHaeDH8qWhT3HYsYtd9N7EunJyNnGPdIdNT/y4Ulr1DIobpxWpiLYPpIDt4c2g21RfL+nKf5b4RTN/afIKJhvAG0RGA4=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by TYWPR01MB10521.jpnprd01.prod.outlook.com (2603:1096:400:29e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 10:50:08 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::ec68:1357:d0c9:ad1a]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::ec68:1357:d0c9:ad1a%3]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 10:50:08 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "pavel@denx.de"
	<pavel@denx.de>, "uli@fpond.eu" <uli@fpond.eu>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>
Subject: RE: [ANNOUNCE] Release v5.10.212-cip45
Thread-Topic: [ANNOUNCE] Release v5.10.212-cip45
Thread-Index: Adpz/OV5dAvh9TgmQRe2pzr68fqDbAAbTxyQ
Date: Tue, 12 Mar 2024 10:50:08 +0000
Message-ID: 
 <TYWPR01MB1186205FD65E906E2B45636DAB72B2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: 
 <OS0PR01MB638832966C2DFF1BA6799C3092242@OS0PR01MB6388.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB638832966C2DFF1BA6799C3092242@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|TYWPR01MB10521:EE_
x-ms-office365-filtering-correlation-id: 72145b28-11e6-4902-eaf8-08dc42822f59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 6QXjtdThd3X1GPjhLCgsCQlNUxgj17nBTbKQkNPga1/j/ErM9AShzPZ34P5QqiNGlStyBds79hs9Ty6LfPey/kOREwRJMo0+OJEdEcGtU/1oGiu2VkC3nSWVaKaAff7/8dPKv18HBCTr7B/7KidaARl60jbtUByDMGe4KR24F69YlXhreLVJoqeE5T3UucEVobT3nyZ8xL65sy4xtlKOBDiW8LfNhsLzfgojQTmvnXcfEr02Drc3rLsA57Xru0s+D7JwbDVvIUsR+Josf++Qe0X0T56e7MYdTOh8W8KIGS7uZHKOdBf8IJzpn+R7t2tLykLgDVN55KxHPkKH+mnEGY4YR9mECHeM7ikizLk+lFhFLwE8LNQ2THuHwjKOfTO7jWM1z/o9NlIdc78PZOHdiMmTpFvyslJyadQqHhigtUfqUJ7UbVHtLCJWvs8aRiC7NLsVi5DRSvuK/fj4ekmjX5FskzGOs6uKnCBp9HZyWJ/jPzx9u5L7ZIzbjhSvjldmgsySNdk3s4kn5us50AO7V4CnGEi/vNquOp1z0e/I+HNa59fWHvYYG6GdGgHCTQE2Xl5N9BTymcmuEa/UXqY1+fMc3/kvYfVXN02xUNcKcvbTvtMds9+JPE492MZnLXyFDPnFTN0oBTBfDA53ddw1NxMeX6VDmPkQjRauTKBsXHc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZmZKaWprbGFOMEh3S3l2V1ZKWlVhS1NKTXZHZ3hPUk9QUlBsRFY1Q29J?=
 =?iso-2022-jp?B?c1NndlFNRnkwY2gzc09aTkh6LzkzTkh3ZDFqT2tLS0FUVVNpc0NsZ0VN?=
 =?iso-2022-jp?B?bWtWSnJISjkzNEdvMXVhTVdnVzk1WVVDVCtWbXpIUFhPcGo4NTMwaHIx?=
 =?iso-2022-jp?B?RWRiM05yanV5NHpnd2xhYmNyUGNqU2R2Vnh6NXhTRnVCOElqNjRxZmgy?=
 =?iso-2022-jp?B?Z05zdkdEK2RUdDRRcjltYjVjZWlQb21xcDU0VGtteTViM0lnalpkYmZF?=
 =?iso-2022-jp?B?NFdpY1FQbXh0T1pJcjNRbnh2aTA3SHJ1ZURSL1l3VVJPeHpCUWNMOXZF?=
 =?iso-2022-jp?B?aXExWHBXSWs2QlFoSEpMK3J5dzlacnBZSzFJSHR6K3BybHZpQTVJVWZl?=
 =?iso-2022-jp?B?NXJMcTJTNnRRZnU2SzU3eXk3WmwzcmY5c21zdjNVQmhkMlEvWGZjU0Jk?=
 =?iso-2022-jp?B?M2pXRXZtQjZ0R0xpSjdBYkVyQXI4TndyM3RIcjk3b2dvdFl0ZGdUcWtM?=
 =?iso-2022-jp?B?OXNOZ2x3U3VmQlMxQkRmU2JVQVgvd3JCYWlDVDU1a2s4RENBeEF4b2Qw?=
 =?iso-2022-jp?B?azUvSFBBNHlxWm9SanBIRWZPU2hUbFMyTER5dllDajFrWmxST1FYbnVt?=
 =?iso-2022-jp?B?d29naUFBd01ySFRlb1ppT1ZFSDlwbWc2MERsM1NCM21uakdXb1EzSjRV?=
 =?iso-2022-jp?B?YUV3RGdEd2luSHZaazBqenh6MlNPWkJyTDQyQ1lMNnI3M3h0YkM2blJG?=
 =?iso-2022-jp?B?bGJIL09iV1J1QTRob1ZVcjhjZHhaa1lHODFBcDRmRlZMUDhXZ0JIckND?=
 =?iso-2022-jp?B?cTlObnV3M1FFc3FuVm9ycjU0RGYxdXZkeVZscytxY2tmdTZ4SnUvK1VZ?=
 =?iso-2022-jp?B?WDNsajZQWHhXdEhWa0Z6czI1RC8wUWNIellFSEZvM2xwWGJhVG1JQUs1?=
 =?iso-2022-jp?B?aUZQY1FxQXJaUWRKcU04MGN0eDFYREJqcmltV0R6VDJXK3BpekJiaXRr?=
 =?iso-2022-jp?B?dndBTk5DRk9lMUhvNnZyNlpKWjdPYXZEVEF6UVRnRFhLTFdDZEo4Y1V0?=
 =?iso-2022-jp?B?Vm9yazZWSzE5N0c0NWdsUW5la0RucTNmSU1xM3g2WXRSeVhyVkhuYmhF?=
 =?iso-2022-jp?B?Sk9LblZCMENZSFV0bk5kUjExampRajRJVkE4cjBpM1Voa0tjcmxOZk5z?=
 =?iso-2022-jp?B?NGJ1Z244V2hna0szV0U4SUZTUmUyS3d3SzVibHhMR2NDODBYMnErNHlS?=
 =?iso-2022-jp?B?bGlhZFVONDlCdW8yMUJiQjcxdElGOHRoK1E4Z0wzSFovQkpPYXF5aFIz?=
 =?iso-2022-jp?B?encwR3RTNjVzU1AzNTVQZnBPbVNmVkFJTE82T3UyWmlLUTVDNzJIR2x3?=
 =?iso-2022-jp?B?bDcwb1oxRGo2a2FUdVhKNmpIZXVBU2sralAzUGJmN0FXQ2tScWlmSTFG?=
 =?iso-2022-jp?B?RllCVldSYUFwYjcraC9GK0paS0xkUWpGTVhTSzVsVG4xNktnRnV2OGJW?=
 =?iso-2022-jp?B?NjN1UExqaUI3WjNUaVgxUXpvdXNwRW02dlFFUmdITU1qTDNRVXkrTEhh?=
 =?iso-2022-jp?B?OVA2aHZraC9UVHR2K1NWYWg0Wnl5SjQ2YXZ4U2hCUUZROTFsNmkzZC9D?=
 =?iso-2022-jp?B?L2tXUTRLbGNEcTF4c2c4eG01SHN0ZFJJQlVQK2liVVAvSGxFb3p0aXlp?=
 =?iso-2022-jp?B?eExrSmZmOFBqTjI5cERka3hqZEdCaWdrOWt6WktqK0tPUTZvQ2o4c1l2?=
 =?iso-2022-jp?B?LzQwZ1NHVmRoaFBGRzB5YXZQTWJyYmdLZEEvMUVDL0l1OUExcFEzYU85?=
 =?iso-2022-jp?B?N1NrcHQ1RGx4N0ZCWXRkY01aQjk4YUp2VGZkcGNEZXFwMUlycUR3NGlr?=
 =?iso-2022-jp?B?REcwd0ZyNjVIRWNqM24zUUYyUW1XeW05c3g4eS9Cb1pjOUtlTkJ4bHJX?=
 =?iso-2022-jp?B?WEg2M2djTFpIQXpiNGtxMkNFeEx4YkhwNmllcVN0dGR2clhWWTBHbEpz?=
 =?iso-2022-jp?B?TkdEb0VET3JMNko4U0R2T0VwelJURnd1a01Gam9wMnZpcmc4aDlqOS9E?=
 =?iso-2022-jp?B?SHI3T2ZVZkZKaEdacXRVREU3QWFMUm9maTRqQVZwUWNVKzBZMzJFNkhi?=
 =?iso-2022-jp?B?MFhESVhrUG0vb3ozZ0NGci9EbzFVSlUrNVVuejRYazUvd1B5NnQ0Tm55?=
 =?iso-2022-jp?B?SGNoV0IzV2wyRFU2akkvdjIvbnhwMFduVm1OTDlhcWF0VCt5VlV2Si9L?=
 =?iso-2022-jp?B?cGVvTGJ2K0tWT2luUHVZbjU3dDdXbGNUR1QwNytRc0Q5Y1o4NkFPcmFy?=
 =?iso-2022-jp?B?aDE0VjljcEhqNDl0MVFvUWVaU1RMUVVIZGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72145b28-11e6-4902-eaf8-08dc42822f59
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 10:50:08.7356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yU3/uuLKg5dWeHw3PxNWd06qN+3x4A2rigy+/mWG8IX5C4duXd9yQlvj3RdwgqfE+x/6ELKyoHuIUSzlzOXOQbuhkEXj80i7EvHYLgKMLW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10521
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Mar 2024 10:50:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15276

Hello,

> From: nobuhiro1.iwamatsu@toshiba.co.jp
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: Monday, March 11, 2024 9:48 PM
>=20
> Hi,
>=20
> CIP kernel team has released Linux kernel v5.10.212-cip45.
> The linux-5.10.y-cip tree has been updated base version from v5.10.209 to
> v5.10.212.
> This release adds support for Renesas RISC-V SoC (rzfive/r9a07g043f).

Test results:=20
- New (draft) release report: https://cip-playground.gitlab.io/squad-hackin=
g/cip-release-reports/linux-cip/linux-5.10.y-cip/5.10.212-cip45_6d03567cb.h=
tml
- Summary: No new regressions

Kind regards, Chris

>=20
> You can get this release via the git tree at:
>=20
>   v5.10.212-cip45:
>     repository:
>       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>     branch:
>       linux-5.10.y-cip
>     commit hash:
>       6d03567cbcdc99d0c6372154f02172276261f851
>     Fixed CVEs:
>       CVE-2024-23850: btrfs: do not ASSERT() if the newly created subvolu=
me
> already got read
>       CVE-2023-52491: media: mtk-jpeg: Fix use after free bug due to erro=
r
> path handling in mtk_jpeg_dec_device_run
>       CVE-2023-52437: Revert "md/raid5: Wait for
> MD_SB_CHANGE_PENDING in raid5d"
>       CVE-2024-26606: binder: signal epoll threads of self-work
>       CVE-2023-52492: dmaengine: fix NULL pointer in channel
> unregistration function
>       CVE-2023-52486: drm: Don't unref the same fb many times by mistake
> due to deadlock handling
>       CVE-2023-52493: bus: mhi: host: Drop chan lock before queuing buffe=
rs
>       CVE-2024-26614: tcp: make sure init the accept_queue's spinlocks
> once
>       CVE-2024-26600: phy: ti: phy-omap-usb2: Fix NULL pointer dereferenc=
e
> for SRP
>       CVE-2024-1086: netfilter: nf_tables: reject QUEUE/DROP verdict
> parameters
>       CVE-2024-26610: wifi: iwlwifi: fix a memory corruption
>       CVE-2023-52595: wifi: rt2x00: restart beacon queue when hardware
> reset
>       CVE-2024-26609: netfilter: nf_tables: reject QUEUE/DROP verdict
> parameters
>       CVE-2023-52598: s390/ptrace: handle setting of fpc register correct=
ly
>       CVE-2023-52604: FS:JFS:UBSAN:array-index-out-of-bounds in
> dbAdjTree
>       CVE-2023-52429: dm: limit the number of targets and parameter size
> area
>       CVE-2023-52587: IB/ipoib: Fix mcast list locking
>       CVE-2024-26581: netfilter: nft_set_rbtree: skip end interval elemen=
t
> from gc
>       CVE-2023-52597: KVM: s390: fix setting of fpc register
>       CVE-2023-52435: net: prevent mss overflow in skb_segment()
>       CVE-2024-26593: i2c: i801: Fix block process call transactions
>       CVE-2023-52594: wifi: ath9k: Fix potential array-index-out-of-bound=
s
> read in ath9k_htc_txstatus()
>       CVE-2023-52606: powerpc/lib: Validate size for vector operations
>       CVE-2024-1151: net: openvswitch: limit the number of recursions fro=
m
> action sets
>       CVE-2023-52603: UBSAN: array-index-out-of-bounds in dtSplitRoot
>       CVE-2023-52600: jfs: fix uaf in jfs_evict_inode
>       CVE-2023-52602: jfs: fix slab-out-of-bounds Read in dtSearch
>       CVE-2023-52601: jfs: fix array-index-out-of-bounds in dbAdjTree
>       CVE-2024-26627: scsi: core: Move scsi_host_busy() out of host lock =
for
> waking up EH handler
>       CVE-2023-52599: jfs: fix array-index-out-of-bounds in diNewExt
>       CVE-2024-26625: llc: call sock_orphan() at release time
>       CVE-2024-26624: af_unix: fix lockdep positive in sk_diag_dump_icons=
()
>       CVE-2024-0607: netfilter: nf_tables: fix pointer math issue in
> nft_byteorder_eval()
>       CVE-2024-23849: net/rds: Fix UBSAN: array-index-out-of-bounds in
> rds_cmsg_recv
>       CVE-2024-0340: vhost: use kzalloc() instead of kmalloc() followed b=
y
> memset()
>       CVE-2023-52583: ceph: fix deadlock or deadcode of misusing dget()
>       CVE-2024-23851: Kernel crash in drivers/md/dm-ioctl.c when allocate
> memory more than INT_MAX bytes
>       CVE-2024-26613: net/rds: Fix UBSAN: array-index-out-of-bounds in
> rds_cmsg_recv
>       CVE-2024-26602: sched/membarrier: reduce the ability to hammer on
> sys_membarrier
>       CVE-2024-26615: net/smc: fix illegal rmb_desc access in SMC-D
> connection dump
>       CVE-2023-52489: mm/sparsemem: fix race in accessing
> memory_section->usage
>       CVE-2023-52498: PM: sleep: Fix possible deadlocks in core system-
> wide PM code
>       CVE-2023-52607: powerpc/mm: Fix null-pointer dereference in
> pgtable_cache_add
>       CVE-2023-52605: ACPI: extlog: fix NULL pointer dereference check
>       CVE-2024-26601: ext4: regenerate buddy after block freeing failed i=
f
> under fc replay
>       CVE-2023-52497: erofs: fix lz4 inplace decompression
>       CVE-2024-0565: smb: client: fix OOB in receive_encrypted_standard()
>       CVE-2023-52434: smb: client: fix potential OOBs in
> smb2_parse_contexts()
>       CVE-2024-26622: tomoyo: fix UAF write bug in tomoyo_write_control()
>       CVE-2024-0841: hugetlbfs: Null pointer dereference in
> hugetlbfs_fill_super function
>     added commits:
>       CIP: Bump version suffix to -cip45 after merge from stable
>       arm64: dts: renesas: rzg2ul-smarc: Add support for enabling MTU3
>       arm64: dts: renesas: r9a07g043: Add MTU3a node
>       dt-bindings: timer: renesas,rz-mtu3: Document RZ/{G2UL,Five} SoCs
>       dt-bindings: timer: renesas,rz-mtu3: Improve documentation
>       dt-bindings: timer: renesas,rz-mtu3: Fix overflow/underflow interru=
pt
> names
>       cache: Kconfig: Add dependency for RISCV on AX45MP_L2_CACHE
> config
>       riscv: dts: renesas: rzfive-smarc: Enable the blocks which were
> explicitly disabled
>       riscv: dts: renesas: r9a07g043f: Add dma-noncoherent property
>       riscv: dts: renesas: r9a07g043f: Add L2 cache node
>       riscv: dts: renesas: Clean up dtbs_check W=3D1 warning due to empty=
 phy
> node
>       riscv: dts: renesas: rzfive-smarc-som: Drop PHY interrupt support f=
or
> ETH{0,1}
>       riscv: dts: renesas: rzfive-smarc-som: Enable OSTM nodes
>       riscv: dts: renesas: rzfive-smarc-som: Enable WDT
>       riscv: dts: renesas: rzfive-smarc: Enable CANFD/I2C
>       riscv: dts: renesas: r9a07g043f/rzfive-smarc-som: Enable
> ADC/OPP/Thermal Zones/TSU
>       riscv: dts: renesas: Add minimal DTS for Renesas RZ/Five SMARC EVK
>       riscv: dts: renesas: Add initial devicetree for Renesas RZ/Five SoC
>       riscv: Kconfig.socs: Add ARCH_RENESAS kconfig option
>       soc: renesas: Kconfig: Select the required configs for RZ/Five SoC
>       cache: ax45mp_cache: Add non coherent support
>       cache: Add L2 cache management for Andes AX45MP RISC-V core
>       clk: renesas: r9a07g043: Add support for RZ/Five SoC
>       soc: renesas: Identify RZ/Five SoC
>       dt-bindings: cache: andestech,ax45mp-cache: Add DT binding
> documentation for L2 cache controller
>       dt-bindings: clock: r9a07g043-cpg: Add Renesas RZ/Five CPG Clock an=
d
> Reset Definitions
>       dt-bindings: riscv: Add Andes AX45MP core to the list
>       dt-bindings: riscv: Sort the CPU core list alphabetically
>       mmc: host: Kconfig: Make MMC_SDHI_INTERNAL_DMAC config option
> dependant on ARCH_RENESAS
>       clocksource/drivers/riscv: Get rid of clocksource_arch_init() callb=
ack
>       clocksource/drivers/riscv: Increase the clock source rating
>       clocksource/drivers/renesas-ostm: Add support for RZ/V2L SoC
>       irqchip/sifive-plic: Separate the enable and mask operations
>       irqchip/sifive-plic: Make better use of the effective affinity mask
>       irqchip/sifive-plic: Add support for Renesas RZ/Five SoC
>       irqchip/sifive-plic: Disable S-mode IRQs if running in M-mode
>       irqchip/sifive-plic: Improve naming scheme for per context offsets
>       of/irq: Use interrupts-extended to find parent
>       of: also handle dma-noncoherent in of_dma_is_coherent()
>       dma-mapping: make the global coherent pool conditional
>       dma-mapping: add a dma_init_global_coherent helper
>       dma-mapping: simplify dma_init_coherent_memory
>       dma-mapping: allow using the global coherent pool for !ARM
>       dma-direct: add support for dma_coherent_default_memory
>       riscv: Kconfig: Enable cpufreq kconfig menu
>       cacheinfo: clear cache_leaves(cpu) in free_cache_attributes()
>       arm64: dts: renesas: r9a07g043: Split out RZ/G2UL SoC specific part=
s
>       arm64: dts: renesas: r9a07g043: Update IRQ numbers for SSI channels
>       arm64: dts: renesas: r9a07g043: Introduce SOC_PERIPHERAL_IRQ()
> macro to specify interrupt property
>       arm64: dts: renesas: rzg2ul-smarc: Include SoM DTSI into board DTS
>       arm64: dts: renesas: rzg2ul-smarc: Move selecting PMOD_SCI0_EN to
> board DTS
>       clk: versaclock3: Drop ret variable
>       clk: versaclock3: Add missing space between ')' and '{'
>       clk: versaclock3: Use u8 return type for get_parent() callback
>       clk: versaclock3: Avoid unnecessary padding
>       clk: versaclock3: Update vc3_get_div() to avoid divide by zero
>       arm64: defconfig: Enable Renesas VersaClock 3 clock generator confi=
g
>=20
> Best regards,
>    Nobuhiro
>=20
>=20
> --
> Nobuhiro Iwamatsu


