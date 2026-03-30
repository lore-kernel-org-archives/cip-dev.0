Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6B0FF4953
	for <webhook@archiver.kernel.org>; Mon, 30 Mar 2026 06:36:35 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45167.1774852589217494902
 for <cip-dev@lists.cip-project.org>;
 Sun, 29 Mar 2026 23:36:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=Dpt652CK;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1774852584;x=1776062184;bh=
	lS+fBya9qxcAtEwYdc4OUmDttaPYWqIJBh0jxHzQwHY=;b=Dpt652CKpjyg09kj1P73XeIU4YEMNC
	WmtDHYDV/Zqr072yPkw73f+vgJ1m8BCjbSQlGeJFhHgcrGloRubAsQtXbAjc68lki6LnCYEsXsSny
	rolpeRSkkMiyoUWmRnhMjJTEqc5YT9nqnPUY5Uc9L+WTHoSz4Y+cDz1aTgo/3BL35zJbsPOQsx1S9
	0/NlupdcZEsR6gpjypWwnqSZVPMxNqlZnEl0Occb7QkqgcIoyl31+GQ3OJGOSvROXrm86M0HmQEtx
	Ii05dtUhaJfeyh8T4AeENfxKDGUJuRfun54XgW6eT9itRm3wLP3QQqR1U25GIvUNp4cDEPXDMkrSC
	fHJw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 62U6aNDG3685058; Mon, 30 Mar 2026 15:36:23 +0900
X-Iguazu-Qid: 2rWhMF1GnzOtbuB6uR
X-Iguazu-QSIG: v=2; s=0; t=1774852582; q=2rWhMF1GnzOtbuB6uR; m=3qwyASJh5avkH+71Mra8QfBQiBJ6T8k5XcvED1jBEyc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fkhNP6YHYz4vyq; Mon, 30 Mar 2026 15:36:21 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSrgr7hKQEcxaqZs0Bd02NXmGbt8krXLXkc+LZ/ihafmsRfdvVW7tzdhFmZSyv1Y6WhqcYd9U8ayW/9ChDSVRoKCNObbF8E3b6cfgAtLcc2nGlorQAhj2Maot7hez4RXSPGh0qu0ImZBvF/289hUwjqVZ5ZE6yOcBBa5+Bt5bgsd5TtYDiqP6PP/+uzqKtabFnjWA7Z52E5eIZg2Qq8N6XvyhrxHBJzirWl7Es9oGJXCN5OONWAy+X7ca+XuXiN08ECVG/OGWaeN7+6r5Di2U/AgKp7f9cHD2jdiirp79w+R2eMOJ69N6Nh3y5F41URt/kmJ/9goNiwWIUC3TttdTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prWVoHh/+kkAgq6hwBMOeR/u5dEIxBq94yK7hkT/Oe4=;
 b=ODlU7Zsvb/87qd5kyDSYC0NaYC3St41tTkoih8AgXgA4FZVcRAOfAEwO4TYry9aUQJTkHlCHE/9uWl3DbiBLdfDfMGfOjrXdxjIkHcG4g3FJMKk6hgPGYnmpOS0SmYiSMKWyEA10V+DqkJC+OyQhzCAh6KrhbFpWt0Y9pxgzlHHs23cIza9fCJ++6u3E50I6t3fFBbO/7LjxMELrbmUqKB8pUfomQB41EkV5/a/xf82CVGooc0rXoXNL0yp2JO8kdJaP4z/Si/KKwHOxB3SlJCPafykwi9WXII+XI4RD9VByqe3NPcHW2xvM5ha0MAyH+uRy51quT6I8SVYlrat+fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@nabladev.com>,
        <masami.ichikawa@cybertrust.co.jp>, <masami.ichikawa@cybertrust.co.jp>,
        <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v6.1.167-cip53
Thread-Topic: [ANNOUNCE] Release v6.1.167-cip53
Thread-Index: AdzAD1G3MokO+YqFQIO9U7X33vk8SA==
Date: Mon, 30 Mar 2026 06:36:18 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818BA7A4AD7369626685051CD52A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB8843:EE_
x-ms-office365-filtering-correlation-id: e99206a6-aae9-43b8-fb9f-08de8e26a66d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info: 
 t1w1FqFnMK2XHiOoIkIMKGLvOnEuSGpPRodaX9xMpXi6G2ZsmTQ5RGH69armIGU3s1DAoZIgdyeG1hLkc7pSQne5UxzoTHOvYNlVzA2MpDypNGRVILGWK0TjFHcSCg6YzW5wKQl0zgxf0KXdRQVFTy/M3hASvnIYzs5sVpBljzlri2jcm26xPUDGuttkNM4nis1mipLZ1qDqPj6+BgqAZOSHxbcdGQIUG7OrOfQ/9ljl0KiSRv2m1TSfsgrkb79re723S7IBYu/y+74y/+gR7tDc6H1HxP0ysCzl4VpVP1c2kZNPB411aICifU1Yg/8lNm7PFjvU6uzHDB7esFjjYx/GxvMCicjEwzfD4YTjYJkK35eCCvCBT+0V8C1U/zbyB28cjURgcXt6SzTH3cn4HhKM9JcO/hBZTVPPlD5jHw4Jk0wXr/urRU81x3/DgoLSVkEzC/rgdIFcPgPlprrZcDihta1MfAWmkNiuLhUdGawyTH4+FbEW5pDVGnZECLDBlTemVcyb/SF2U8eSdmuDzcPSnIkKgFIy3NfraNjsvQ40F+QF07N8cZ4te5N9gXUOaewPYwcCzjMSp1xrrzNOBmSnF/jy21/yPEQoqqEzDLZCAPbAkWuChwxX+VZ2giffJv5y6EDTQRkNFJWQG341aCPmru2y9DDGtqipRufidUrYWbg1+VjwNUg7aX1psaMiMDJ9B27JL2KchyqyZIh/TANH0r2iqItsddgpnLhWjpb05e35AtVbe3biX7Za1RczRoKeUNmf4hdOD9OvuXgki4OLJ9kyTP5SPfcTLi3rTjI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?V0tBUnNtSXVyM3ZzV0RPQy9GeXorSnV6ZE01R0Q5M0tlbzBDRVoxRjZS?=
 =?iso-2022-jp?B?SjJyeVI1L2RpdnZaVUJFR0ZwQkV6ODRpci9mZXVrK2FRNTdsYUdwTXFL?=
 =?iso-2022-jp?B?SUNxY2ZwemFLd0tWM3EybkVXUkdZREdKYlY3ek9LcG1LWXZVaFlaanFZ?=
 =?iso-2022-jp?B?bDFYZFl4cFBFV2x4UVUvY0hsQ2ZJcS9uMHNpdW9ybzFoSlVLOWNsdk40?=
 =?iso-2022-jp?B?aUo5bW85NjVoWVR0MnIrRWhxb202c2w2clYraWozOEZET0VYajNFK0Mx?=
 =?iso-2022-jp?B?RUdOZGM1VHUyUGduUFBuUi8zQkljUmhTcGlScGpDZzNRKzg2dldsaU5x?=
 =?iso-2022-jp?B?U3JYZ3M4RklWOGdtWkR3UjJIKzhYQWZvcmp1NTF2d3dvT1FrYkdPUDV5?=
 =?iso-2022-jp?B?WlRQVkZORm05dUNXblNHd0NTcWNUekYxcld1RFRXR2ptWk9pekgzNWwv?=
 =?iso-2022-jp?B?MkpncnNxQ0hrZ3NRYm9wRm9vK3ViZSs4SiswM1dDRFh2aWJVNjdCdHZw?=
 =?iso-2022-jp?B?ZjdEbWFmNmpsLy8vZmNoWlQwN2FUc3ZWWENXRDFuMGJlYWRHalJaVG5X?=
 =?iso-2022-jp?B?dGZndCtIN09zanpTY2lZRmRYQnNna1JXSy85Rk9LanpQb08rY3A0Rkt4?=
 =?iso-2022-jp?B?RnltKzd2bEtZKzM1Yk1OL1ROTDdWeTQ3c0xtQlNBVUEyY0tsRW5KQ3VB?=
 =?iso-2022-jp?B?blpHTVpLcXp3Sk1aZHRnMGtMRTd0dGNaSVMwcmJhaW42M0F0cmY3eHFS?=
 =?iso-2022-jp?B?SE5Ic1d4aldEUldoL01lc0Y3aGJ3VGt1cGx5R25BMmpLR2d2cDhjcmoz?=
 =?iso-2022-jp?B?Zk5oZmFZV0M4ZnZkNmVEL24rdE01WXVKWGF4K0wxckROVkZYNzBQTy9T?=
 =?iso-2022-jp?B?UVdlejlhL2pBQnJNQWQ2akJjLzNnUG04NE9xQkNsSHo1WUR4MDRXV2dy?=
 =?iso-2022-jp?B?RldRMXFXU2M4YWJMdjA1aEVjS0hUTEtNMEVGNWlrMWx0L0NzZUtvQ2ZH?=
 =?iso-2022-jp?B?OTZZU0JjdFFhcHV4SE12b2R5NXl2aURHOGR6akVab2EzVm5CZjdwbGRp?=
 =?iso-2022-jp?B?RHlUZFdtdVZjR2YyMTFhalliRWJFaTBaTUZaR2I1SHU3eW1KNks0ZUVh?=
 =?iso-2022-jp?B?QVZCY3lhOHZpVlc4SHkvaUF5SmN2MWt5ZTQyWDlDOWpQZDY0YTVidmZp?=
 =?iso-2022-jp?B?YjhXMjFLRW5FT0JlU3ZHcEhmNVVsYVFDejNvUjN1SzAxZDNSczY2MndR?=
 =?iso-2022-jp?B?NXBqQzVrS3FLdGtuVGNvdklBcnk1TlFDdm5KUVhuMGVHMWlkbEEyL0Y2?=
 =?iso-2022-jp?B?Ri8rN1JOMWJsS2F6bnlJRHAxRWY1dkMvbFJyME0wRk5OYzVNVC9BODN5?=
 =?iso-2022-jp?B?K3hpTENUYzU2RVp1MTMvbnR0ZEdIUjJtNEN1QzlLSkZUTDNCOVVDcHpB?=
 =?iso-2022-jp?B?b0hudnpxZmFOdUlyUHh4UTFlcG44bVkxSFRoNTQzaFVPeEFmVlprUmFv?=
 =?iso-2022-jp?B?UmFxbUxRRXFqcmpLd0JnR1hvSDR5UEc2UDBmcXdBWXRGTGVFSnlCWVdp?=
 =?iso-2022-jp?B?KzZnY2tsR25QTEh0WVU3Vmo1c3lkV1dzZXFRSjZMZkVqMWhxN2t6WFVH?=
 =?iso-2022-jp?B?cytVVEZlZUhtd2hQVjlxUUxwYTIwMm1PQ0JFRHRHeG42Vndsb1FmUkFO?=
 =?iso-2022-jp?B?NmhKUExvOU16ODBYN09GaFMzWlpHa0FFeWwyMXc3OEM3Tnh1aENmTlIz?=
 =?iso-2022-jp?B?QllQdVhidVRaNVhWS2pla2NqbEN6NmpiS1AyUlFqRG1jbDBqc3pneDBB?=
 =?iso-2022-jp?B?Z0hEdEJCU0hlNGcvU3Z5WEt1a1JVa1pXZ3pheEdYMjlJK0NvamZWUVJv?=
 =?iso-2022-jp?B?N0lzUFhyK1ZoUTBmQ2JkUlFPR2JyT0J4Mzg3ZVMvK1BxVWZvZ2h1d1ZI?=
 =?iso-2022-jp?B?MDd5bkFNSTZ2QStmV21PaXU4WG5GYjIxN3lRbW5ZbHUxcFJNaWF5YUZo?=
 =?iso-2022-jp?B?c1JwWURGb2luRFF0MmtodWI3cFBhc0VQelRIbzlkbUJibERaTGpSTU5C?=
 =?iso-2022-jp?B?Z2VhZkd2cWx6N05VMndOYzB1M0VsQ3QrWW9mMEtRSGxKbE8vKzZQQ2Rh?=
 =?iso-2022-jp?B?VC9welR1TzhpRm50dTc2TXc2d2VWSWJzKytiUUIvaGZvMno0OHpYNnhv?=
 =?iso-2022-jp?B?V0J5UlJFWktGY1ZhZFF0OG9Rc1pZZjNXMnVYNEFNc25WSk4yNFVLc1RV?=
 =?iso-2022-jp?B?UnZoQzJKQVV1cmNPR0xNOXBaMXR5NFVFcHZHOHJLZ2Nxd1VmT3J5L1lW?=
 =?iso-2022-jp?B?cTQvZEJHZTByOUVpZ3BMTnVKU0RQNUpBdFA5aWxSYzY0NnlxdkFJbkpN?=
 =?iso-2022-jp?B?TzlJMW4rVURKU0FxYWZ0OFNSVWs3MXJNNWJFeThqSlRZSlg0elM4VkMz?=
 =?iso-2022-jp?B?aXQzNUl6RjdsOGJWejNGK2RjaUUrY3pRSlhJYmdwSktKZmt3dXB5RFA0?=
 =?iso-2022-jp?B?OWtRcXU5eUpvR3U1d0hkakRmZTMweHlyYTBvQjh4V0dZM05QVlVaa08r?=
 =?iso-2022-jp?B?Z2dyc21tUT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	NNKoutftajx/5lEXQZo/skB5fB8Bji2xOC2mYkqQan3Z3VJFmiE7xZuXhmqjUI69U3mH7LEhOQT+LpF8TteN8/FkoW8Y8Z/q6tOpvTlrMreb2n/isGQMJWokp23EFyGCbpk4TiruuKosey3VZRlpYm0iTZMQvhepkAawApHso4q0f9LYD3Pv57vFClYOfVEPU9bOeioGGs6TCIz7Y9/yv73nGJ1ab2S9aWVioqjntTJMfPHPde2nfJ+bqxhnvZ5W7+m8rlHfhkZSIS9TaqUg0bMc2f3N+U4aGm+XPb+JNFSRDGpRh8hQBzGNdv9rkX0U9khGx9ycV+aDy6f6bcxD9w==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e99206a6-aae9-43b8-fb9f-08de8e26a66d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 06:36:18.4722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Yzlww9FcPaycPZOotjuSkiq4hAY9FHyV7+DAiiTdLOKiFTiNpvNW47/xunbLH5pOW1g0oLvN6QhQWXWd5p+oB1Hd7iGmi6vhN+p4t2f2NPO9X9ArHj72zl+tYHdHPQr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8843
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Mar 2026 06:36:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22603

Hi all,

CIP kernel team has released Linux kernel v6.1.167-cip53.
The linux-6.1.y-cip tree has been updated base version from v6.1.164 to v6.=
1.167.
This release includs device driver updates for Renesas ARM64 SoC RZ/T2H, RZ=
/G3E, RZ/V2N, and RZ/V2H(P).

Information about this release is as follows:

  v6.1.167-cip53:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      885c0acc79344f2d760dc21d1cf161992f207770
    fixed CVEs:
      CVE-2025-71239: audit: add fchmodat2() to change attributes class
      CVE-2025-71265: fs: ntfs3: fix infinite loop in attr_load_runs_range =
on inconsistent metadata
      CVE-2025-71266: fs: ntfs3: check return value of indx_find to avoid i=
nfinite loop
      CVE-2025-71267: fs: ntfs3: fix infinite loop triggered by zero-sized =
ATTR_LIST
      CVE-2026-23231: netfilter: nf_tables: fix use-after-free in nf_tables=
_addchain()
      CVE-2026-23241: audit: add missing syscalls to read class
      CVE-2026-23242: RDMA/siw: Fix potential NULL pointer dereference in h=
eader processing
      CVE-2026-23243: RDMA/umad: Reject negative data_len in ib_umad_write
      CVE-2026-23273: macvlan: observe an RCU grace period in macvlan_commo=
n_newlink() error path
      CVE-2023-53228: drm/amdgpu: drop redundant sched job cleanup when cs =
is aborted
      CVE-2023-53510: scsi: ufs: core: Fix handling of lrbp->cmd
      CVE-2023-53545: drm/amdgpu: unmap and remove csa_va properly
      CVE-2024-47809: dlm: fix possible lkb_resource null dereference
      CVE-2024-49979: net: gso: fix tcp fraglist segmentation after pull fr=
om frag_list
      CVE-2024-49998: net: dsa: improve shutdown sequence
      CVE-2024-50298: net: enetc: allocate vf_state during PF probes
      CVE-2024-56719: net: stmmac: fix TSO DMA API usage causing oops
      CVE-2025-21676: net: fec: handle page_pool_dev_alloc_pages error
      CVE-2025-21682: eth: bnxt: always recalculate features after XDP clea=
ring, fix null-deref
      CVE-2025-38105: ALSA: usb-audio: Kill timer properly at removal
      CVE-2025-38162: netfilter: nft_set_pipapo: prevent overflow in lookup=
 table allocation
      CVE-2025-38192: net: clear the dst when changing skb protocol
      CVE-2025-38250: Bluetooth: hci_core: Fix use-after-free in vhci_flush=
()
      CVE-2025-38626: f2fs: fix to trigger foreground gc during f2fs_map_bl=
ocks() in lfs mode
      CVE-2025-38659: gfs2: No more self recovery
      CVE-2025-38704: rcu/nocb: Fix possible invalid rdp's->nocb_cb_kthread=
 pointer access
      CVE-2025-39748: bpf: Forget ranges when refining tnum after JSET
      CVE-2025-39764: netfilter: ctnetlink: remove refcounting in expectati=
on dumpers
      CVE-2025-39863: wifi: brcmfmac: fix use-after-free when rescheduling =
brcmf_btcoex_info work
      CVE-2025-40005: spi: cadence-quadspi: Implement refcount to handle un=
bind during busy
      CVE-2025-40135: ipv6: use RCU in ip6_xmit()
      CVE-2025-40358: riscv: stacktrace: Disable KASAN checks for non-curre=
nt tasks
      CVE-2025-68206: netfilter: nft_ct: add seqadj extension for natted co=
nnections
      CVE-2025-68239: binfmt_misc: restore write access before closing file=
s opened by open_exec()
      CVE-2025-68265: nvme: fix admin request_queue lifetime
      CVE-2025-71067: ntfs: set dummy blocksize to read boot_block when mou=
nting
      CVE-2025-71156: gve: defer interrupt enabling until NAPI registration
      CVE-2025-71161: dm-verity: disable recursive forward error correction
      CVE-2025-71221: dmaengine: mmp_pdma: Fix race condition in mmp_pdma_r=
esidue()
      CVE-2026-23100: mm/hugetlb: fix hugetlb_pmd_shared()
      CVE-2026-23113: io_uring/io-wq: check IO_WQ_BIT_EXIT inside work run =
loop
      CVE-2026-23141: btrfs: send: check for inline extents in range_is_hol=
e_in_parent()
      CVE-2026-23154: net: fix segmentation of forwarding fraglist GRO
      CVE-2026-23157: btrfs: do not strictly require dirty metadata thresho=
ld for metadata writepages
      CVE-2026-23204: net/sched: cls_u32: use skb_header_pointer_careful()
      CVE-2026-23227: drm/exynos: vidi: use ctx->lock to protect struct vid=
i_context member variables related to memory alloc/free
      CVE-2026-23245: net/sched: act_gate: snapshot parameters with RCU on =
replace
      CVE-2026-23253: media: dvb-core: fix wrong reinitialization of ringbu=
ffer on reopen
      CVE-2026-23270: net/sched: Only allow act_ct to bind to clsact/ingres=
s qdiscs and shared blocks
      CVE-2026-23271: perf: Fix __perf_event_overflow() vs perf_remove_from=
_context() race
      CVE-2026-23274: netfilter: xt_IDLETIMER: reject rev0 reuse of ALARM t=
imer labels
      CVE-2026-23277: net/sched: teql: fix NULL pointer dereference in iptu=
nnel_xmit on TEQL slave xmit
      CVE-2026-23279: wifi: mac80211: fix NULL pointer dereference in mesh_=
rx_csa_frame()
      CVE-2026-23281: wifi: libertas: fix use-after-free in lbs_free_adapte=
r()
      CVE-2026-23284: net: ethernet: mtk_eth_soc: Reset prog ptr to old_pro=
g in case of error in mtk_xdp_setup()
      CVE-2026-23286: atm: lec: fix null-ptr-deref in lec_arp_clear_vccs
      CVE-2026-23287: irqchip/sifive-plic: Fix frozen interrupt due to affi=
nity setting
      CVE-2026-23289: IB/mthca: Add missed mthca_unmap_user_db() for mthca_=
create_srq()
      CVE-2026-23290: net: usb: pegasus: validate USB endpoints
      CVE-2026-23291: nfc: pn533: properly drop the usb interface reference=
 on disconnect
      CVE-2026-23292: scsi: target: Fix recursive locking in __configfs_ope=
n_file()
      CVE-2026-23293: net: vxlan: fix nd_tbl NULL dereference when IPv6 is =
disabled
      CVE-2026-23296: scsi: core: Fix refcount leak for tagset_refcnt
      CVE-2026-23298: can: ucan: Fix infinite loop from zero-length message=
s
      CVE-2026-23300: net: ipv6: fix panic when IPv4 route references loopb=
ack IPv6 nexthop
      CVE-2026-23303: smb: client: Don't log plaintext credentials in cifs_=
set_cifscreds
      CVE-2026-23304: ipv6: fix NULL pointer deref in ip6_rt_get_dev_rcu()
      CVE-2026-23306: scsi: pm8001: Fix use-after-free in pm8001_queue_comm=
and()
      CVE-2026-23307: can: ems_usb: ems_usb_read_bulk_callback(): check the=
 proper length of a message
      CVE-2026-23309: tracing: Add NULL pointer check to trigger_data_free(=
)
      CVE-2026-23312: net: usb: kaweth: validate USB endpoints
      CVE-2026-23315: wifi: mt76: Fix possible oob access in mt76_connac2_m=
ac_write_txwi_80211()
      CVE-2026-23317: drm/vmwgfx: Return the correct value in vmw_translate=
_ptr functions
      CVE-2026-23318: ALSA: usb-audio: Use correct version for UAC3 header =
validation
      CVE-2026-23319: bpf: Fix a UAF issue in bpf_trampoline_link_cgroup_sh=
im
      CVE-2026-23321: mptcp: pm: in-kernel: always mark signal+subflow endp=
 as used
      CVE-2026-23324: can: usb: etas_es58x: correctly anchor the urb in the=
 read bulk callback
      CVE-2026-23335: RDMA/irdma: Fix kernel stack leak in irdma_create_use=
r_ah()
      CVE-2026-23336: wifi: cfg80211: cancel rfkill_block work in wiphy_unr=
egister()
      CVE-2026-23339: nfc: nci: free skb on nci_transceive early error path=
s
      CVE-2026-23340: net: sched: avoid qdisc_reset_all_tx_gt() vs dequeue =
race for lockless qdiscs
      CVE-2026-23343: xdp: produce a warning when calculated tailroom is ne=
gative
      CVE-2026-23351: netfilter: nft_set_pipapo: split gc into unlink and r=
eclaim phase
      CVE-2026-23352: x86/efi: defer freeing of boot services memory
      CVE-2026-23356: drbd: fix "LOGIC BUG" in drbd_al_begin_io_nonblock()
      CVE-2026-23357: can: mcp251x: fix deadlock in error path of mcp251x_o=
pen
      CVE-2026-23359: bpf: Fix stack-out-of-bounds write in devmap
      CVE-2026-23362: can: bcm: fix locking for bcm_op runtime updates
      CVE-2026-23364: ksmbd: Compare MACs in constant time
      CVE-2026-23365: net: usb: kalmia: validate USB endpoints
      CVE-2026-23367: wifi: radiotap: reject radiotap with unknown bits
      CVE-2026-23368: net: phy: register phy led_triggers during probe to a=
void AB-BA deadlock
      CVE-2026-23370: platform/x86: dell-wmi-sysman: Don't hex dump plainte=
xt password data
      CVE-2026-23372: nfc: rawsock: cancel tx_work before socket teardown
      CVE-2026-23378: net/sched: act_ife: Fix metalist update behavior
      CVE-2026-23379: net/sched: ets: fix divide by zero in the offload pat=
h
      CVE-2026-23381: net: bridge: fix nd_tbl NULL dereference when IPv6 is=
 disabled
      CVE-2026-23382: HID: Add HID_CLAIMED_INPUT guards in raw_event callba=
cks missing them
      CVE-2026-23388: Squashfs: check metadata block offset is within range
      CVE-2026-23391: netfilter: xt_CT: drop pending enqueued packets on te=
mplate removal
      CVE-2026-23392: netfilter: nf_tables: release flowtable after rcu gra=
ce period on error
      CVE-2026-23395: Bluetooth: L2CAP: Fix accepting multiple L2CAP_ECRED_=
CONN_REQ
      CVE-2026-23396: wifi: mac80211: fix NULL deref in mesh_matches_local(=
)
      CVE-2026-23397: nfnetlink_osf: validate individual option lengths in =
fingerprints
      CVE-2026-23398: icmp: fix NULL pointer dereference in icmp_tag_valida=
tion()
      CVE-2026-31788: In the Linux kernel, the following vulnerability has =
been resolved: xen/privcmd: ...
    added commits:
      CIP: Bump version suffix to -cip53 after merge from stable
      arm64: defconfig: Enable RZ/G3E USB3 PHY driver
      arm64: dts: renesas: r9a09g047e57-smarc: Enable USB3HOST
      arm64: dts: renesas: r9a09g047: Add USB3 PHY/Host nodes
      phy: renesas: Add Renesas RZ/G3E USB3.0 PHY driver
      dt-bindings: phy: renesas: Document Renesas RZ/G3E USB3.0 PHY
      usb: host: xhci-rcar: Add Renesas RZ/G3E USB3 Host driver support
      usb: host: xhci-plat: Add .post_resume_quirk for struct xhci_plat_pri=
v
      usb: host: xhci-rcar: Move R-Car reg definitions
      dt-bindings: usb: Document Renesas RZ/G3E USB3HOST
      clk: renesas: r9a09g047: Add USB3.0 clocks/resets
      dt-bindings: clock: renesas,r9a09g047-cpg: Add USB3.0 core clocks
      arm64: dts: renesas: r9a09g047e57-smarc: Enable rsci{2,4,9} nodes
      arm64: dts: renesas: renesas-smarc2: Move aliases to board DTS
      arm64: dts: renesas: r9a09g047: Add RSCI nodes
      serial: sh-sci: Add support for RZ/G3E RSCI
      serial: rsci: Rename early_console data, port_params and callback() n=
ames
      serial: sh-sci: Add finish_console_write() callback
      serial: sh-sci: Make sci_scbrr_calc() public
      serial: sh-sci: Add support for RZ/G3E RSCI clks
      serial: sh-sci: Add RSCI_PORT_SCIF32 port ID
      serial: sh-sci: Rename port SCI_PORT_RSCI->RSCI_PORT_SCIF16
      serial: sh-sci: Add sci_is_rsci_type()
      serial: sh-sci: Use devm_reset_control_array_get_exclusive()
      serial: rsci: Drop unused TDR register
      serial: rsci: Drop unused macro DCR
      serial: sh-sci: Drop extra lines
      serial: rsci: Drop rsci_clear_SCxSR()
      serial: sh-sci: Drop checking port type for device file{create, remov=
e}
      serial: rsci: Add set_rtrg() callback
      bitfield: Add FIELD_MODIFY() helper
      serial: sh-sci: Update rx_trigger size for RZ/T2H RSCI
      serial: sh-sci: Fix deadlock during RSCI FIFO overrun error
      serial: sh-sci: Merge sh-sci.h into sh-sci.c
      serial: sh-sci: Sort include files alphabetically
      tty: serial: sh-sci: fix RSCI FIFO overrun handling
      serial: sh-sci: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
      arm64: defconfig: Enable Renesas RZ/T2H serial SCI
      serial: sh-sci: Add support for RZ/T2H SCI
      serial: sh-sci: Use private port ID
      serial: add PORT_GENERIC definition
      serial: sh-sci: Replace direct stop_rx/stop_tx calls with port ops in=
 sci_shutdown()
      serial: sh-sci: Introduced sci_of_data
      serial: sh-sci: Introduced function pointers
      serial: sh-sci: Fix a comment about SCIFA
      serial: sh-sci: simplify locking when re-issuing RXDMA fails
      serial: sh-sci: let timeout timer only run when DMA is scheduled
      serial: sh-sci: Call sci_serial_{in,out}() directly
      serial: sh-sci: mark OF related data as maybe unused
      clk: renesas: r9a09g047: Add RSCI clocks/resets
      dt-bindings: serial: renesas,rsci: Document RZ/G3E support
      arm64: dts: renesas: r9a09g056: Add DMAC nodes
      clk: renesas: r9a09g056: Add entries for the DMACs
      dt-bindings: dma: rz-dmac: Document RZ/V2N SoC support
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Add NMI wakeup button su=
pport
      arm64: dts: renesas: r9a09g056: Add ICU node
      irqchip/renesas-rzv2h: Add support for RZ/V2N SoC
      clk: renesas: r9a09g056: Add entries for ICU
      dt-bindings: interrupt-controller: renesas,rzv2h-icu: Document RZ/V2N=
 SoC
      can: rcar_canfd: Add support for FD-Only mode
      dt-bindings: can: renesas,rcar-canfd: Specify reset-names
      dt-bindings: can: renesas,rcar-canfd: Document renesas,fd-only proper=
ty
      irqchip/renesas-rzv2h: Add suspend/resume support
      irqchip/renesas-rzv2h: Remove unneeded includes
      irqchip/renesas-rzv2h: Prevent TINT spurious interrupt during resume
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable DU and DSI
      arm64: dts: renesas: r9a09g056: Add DU and DSI nodes
      arm64: dts: renesas: r9a09g056: Add FCPV and VSPD nodes
      clk: renesas: r9a09g056: Add clocks and resets for DSI and LCDC modul=
es
      dt-bindings: display: renesas,rzg2l-du: Add support for RZ/V2N SoC
      media: dt-bindings: media: renesas,vsp1: Document RZ/V2N SoC
      media: dt-bindings: media: renesas,fcp: Allow three clocks for RZ/V2N=
 SoC
      media: dt-bindings: media: renesas,fcp: Document RZ/V2N SoC
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable DU and DSI
      arm64: dts: renesas: r9a09g057: Add DU and DSI nodes
      arm64: dts: renesas: r9a09g057: Add FCPV and VSPD nodes
      drm: renesas: rz-du: Drop ARCH_RZG2L dependency
      drm: renesas: rz-du: Add support for RZ/V2H(P) SoC
      drm: renesas: rz-du: mipi_dsi: Add support for RZ/V2H(P) SoC
      drm: renesas: rz-du: mipi_dsi: Add LPCLK clock support
      drm: renesas: rz-du: mipi_dsi: Add function pointers for configuring =
VCLK and mode validation
      drm: renesas: rz-du: mipi_dsi: Add dphy_late_init() callback for RZ/V=
2H(P)
      drm: renesas: rz-du: mipi_dsi: Add feature flag for 16BPP support
      drm: renesas: rz-du: mipi_dsi: Use mHz for D-PHY frequency calculatio=
ns
      drm: renesas: rz-du: mipi_dsi: Make "rst" reset control optional for =
RZ/V2H(P)
      drm: renesas: rz-du: mipi_dsi: Add OF data support
      drm: renesas: rz-du: mipi_dsi: Add min check for VCLK range
      drm: renesas: rz-du: mipi_dsi: Use VCLK for HSFREQ calculation
      drm: renesas: rz-du: mipi_dsi: Simplify HSFREQ calculation
      clk: renesas: r9a09g057: Add clock and reset entries for DSI and LCDC
      clk: renesas: rzv2h: Add support for DSI clocks
      clk: renesas: rzv2h: Use GENMASK for PLL fields
      clk: renesas: rzv2h: Add instance field to struct pll
      dt-bindings: display: renesas,rzg2l-du: Add support for RZ/V2H(P) SoC
      media: dt-bindings: media: renesas,fcp: Document RZ/V2H(P) SoC
      media: dt-bindings: media: renesas,vsp1: Document RZ/V2H(P)
      dt-bindings: display: bridge: renesas,dsi: Document RZ/V2H(P) and RZ/=
V2N
      dt-bindings: display: bridge: renesas,dsi: allow properties from dsi-=
controller
      i3c: renesas: Add suspend/resume support
      i3c: renesas: Factor out hardware initialization to separate function
      i3c: renesas: Store clock rate and reset controls in struct renesas_i=
3c
      i3c: renesas: Switch to clk_bulk API and store clocks in private data
      i3c: renesas: Simplify return statement in 'renesas_i3c_daa'
      clk: Provide devm_clk_bulk_get_all_enabled() helper
      clk: provide devm_clk_get_optional_enabled_with_rate()
      clk: Provide managed helper to get and enable bulk clocks
      arm64: dts: renesas: rzg3e-smarc-som: Enable I3C support
      ASoC: renesas: rz-ssi: Add support for 32 bits sample width
      ASoC: renesas: rz-ssi: Add support for 24 bits sample width
      ASoC: renesas: rz-ssi: Move DMA configuration
      ASoC: renesas: rz-ssi: Remove trailing comma in the terminator entry
      ASoC: renesas: rz-ssi: Use dev variable in probe()
      ASoC: renesas: rz-ssi: Fix rz_ssi_priv::hw_params_cache::sample_width
      ASoC: renesas: rz-ssi: Fix channel swap issue in full duplex mode
      iopoll: Do not use timekeeping in read_poll_timeout_atomic()

Best regards,
  Nobuhiro


