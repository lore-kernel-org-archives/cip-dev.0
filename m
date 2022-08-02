Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230F4C00140
	for <webhook@archiver.kernel.org>; Tue,  2 Aug 2022 08:18:01 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web12.3692.1659428279156401158
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Aug 2022 01:17:59 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.153, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 2728Heli005316;
 Tue, 2 Aug 2022 17:17:40 +0900
X-Iguazu-Qid: 34trFzylI5RHAzHttF
X-Iguazu-QSIG: v=2; s=0; t=1659428260; q=34trFzylI5RHAzHttF;
 m=0GDe2iLLaJ8NZUeF3hQx7A/TjVlZ6+kOyu/7LGmyGVs=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1510) id 2728Hb4x015098
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 2 Aug 2022 17:17:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9MyPKAcxkLEVfvQ7LiykzagBQiiYgCbMZ9Deb8v5XnsHTIk7fCyOrSsw4SfAIciwhUQ+6c8Xcy6OSFNrWU4jDVqdjvk62xfKpC7FFWrODKZeKrpYMOtJIZea5z4zSRWtx48Rsw7dpdW0J/Wv6LijeCEC8UYKrwgkj9owDZfVKScUEj9/CHltibathZj99r7NQMifp/WiulYRMDeqrSlj1UHX3oWrsSQi/1u/eCyh6fM2ko0rq6c7iJXGW9nCl7Lqi3dy9zE1rr/0u+9aMz1GNP2uC34rQ4FS0Ym+BnAASkwCVNdI+LI29t2w0LrIBWaPC28BRpc0fNsLlgiaU4g1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pi0d37ZbNLo31FIxgQdzA3FEBw4CLM2mX40T5aJ8XU=;
 b=c+RtcFnAguCzAqEim8MnfI8GLC0r8vvWWjJWuHz7Z1V4BZSOvaCW4acm7Gwe1Ph7E/y+eUhUaBH+JKjWpRK695kM87dFrD4LaKSlSZ0JOzdUycWTqSd6L5QZ9wlT0pyiR8ov4nYmKBDgGNNoNFz38Q8qgoaIkZwtdw4XDly/P2IB3FcEsSZielUDqpasTfEFsMtMqFsnLlKUdxM2MhIv4rApu7LMI3xvtlUQN+k99FuxuZ/vPM4nfibLhK+83yrvhrukmMRZ8nQrwsAmj8BTo/qHE3EQppksuXep07DFE2lf+lAF2pB9sw24Fd1WrprZQPNF/TwawESHPs4j1GXtUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <chris.paterson2@renesas.com>,
        <masami.ichikawa@cybertrust.co.jp>, <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Release v4.4.302-cip70
Thread-Topic: [ANNOUNCE] Release v4.4.302-cip70
Thread-Index: AdimSE5m470ULS3xQeW6rTXKwV90Hg==
Date: Tue, 2 Aug 2022 08:17:35 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB942081DBFA4B3D93850D99B2929D9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64db87aa-0280-4e15-fc32-08da745f74c8
x-ms-traffictypediagnostic: OS3PR01MB6536:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 TKxwe/AdFdBtcVm4jL8LO02CWaNzs2Wm1C0EI4yhFPqTDhsaA9b9+8l6zldS7kK/SuPRYjVtHRtj2seYzwe7oJS8ymiTxYgIW3fMd9FwNV497Pvb7YDYw0gzSiW8BSrgGC2Z8etJ3xxWYdF0aiewRZbyJpPwBsS+iaxAddTIUXF2ZRYExiMwgoPyK3SNE7QDAJ6A7gxDK/dcKC/+wsxaC6KRuce0EwhnXq5m/d3VwsjegPIOiYG1UivNcNJj8dqfNUlBpankADQSboBZ+2CxVqrQU8DONsyvYWyxIMsHgK1dvmPvQFHPviZEB/bxHh6ZQH4uqIWgZ+cq5Tokp62K+fxIElEDQzoNzJs9+IHKL5f4X1Bd9re2A/IvWfShqrBw8jVG52dk/CHAR6p1KPF1opLnSdEA5zzh5LLpIQjP4Uu2VW5a9aSHtCnJ18ahhxJxFaorypFKTAmUHt3pKN3MegELmWlhVrSUdjL2PvfW5lLsqMhA2/ml3AzIqNlH9T7gxUNYpxC1bVQc8tQSzC7EJMTtQkXRHXvncga5thceqpzPLDltlAhGZ71LBmKYE1VajN3/tcc5HLHJ5NzsmXXrOt7YW/XlV6sKF9NqNWDvrFsNyy9l4imrup6k0qfhEXDliNmho59cBy7kjaW/klQDUFhSVS+Z+EPhVq3/21JsP9m6BIFutRfxhDiVis40J4whpS6MXTTmLzD62YVRKUDxjfY9seb5JODA06wViZqZ4MCchi13Qs2Aw43zYSAFkK8DJQfzz9dA73ep7Se+PGRfqov7LYVq5qF7ZFOe4RqAAW9dt40gAKLMDXtYGbZTac6lekQyOdM/HCzhDQ5wVvgdkQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(76116006)(186003)(38100700002)(64756008)(66446008)(66476007)(66556008)(66946007)(86362001)(71200400001)(6506007)(83380400001)(7696005)(8676002)(26005)(9686003)(4326008)(6916009)(54906003)(2906002)(478600001)(41300700001)(5660300002)(33656002)(55016003)(8936002)(38070700005)(52536014)(966005)(122000001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VEFaRTNPK1JTblhVdFBRWWNrUE1qdzRtSXZkczlFV2w1TU1mck55cTM5?=
 =?iso-2022-jp?B?QmVqckNuYm9ydFpDWmFKTk1zaXlIajhIM2xlNWJvaFNBbnM4akVtTG82?=
 =?iso-2022-jp?B?WmovV2kwQUp5WmVHZUFPdHkreXBZTU0rNE9ZbTZQdWhnNkdpMXErYUZ2?=
 =?iso-2022-jp?B?alJpV1kwQ1RQdkY3WXEzL0pmS0h1ME9UWUZScGtlSEoyVmJpQVUyM3FW?=
 =?iso-2022-jp?B?QkxzRkZER3hVS0Rva2xKM2dCWExhUGZuYVlQNEYyeVJSSEdlbmV2dGpS?=
 =?iso-2022-jp?B?bm13aEhkV2RKWUVxUVhQR09ZakhHWUpzcTdJMkFnQ1pqbkdlUHFEN3dI?=
 =?iso-2022-jp?B?MU0rQU41UmVYN0czK29Hb0RqRnN2NjlBYTN6T2J1S0o1WEFLK0d6bGhw?=
 =?iso-2022-jp?B?VlQwRm13WldIWEhOMDhneEFOQytuZ0tQUk0rYyt3djdmTWMvUDNWdWx5?=
 =?iso-2022-jp?B?RVZTMDRMdlppaXZsejgzTlgwQi9wVGRQekROR3FyeWRsengxSWRzcUFU?=
 =?iso-2022-jp?B?cVFVSFBvUlZhbURJVDgzNGlDM09qbjgydW5acFQ0aFQwRk45T0gvL2RF?=
 =?iso-2022-jp?B?QUUxNk1WVGVsa3ova3l3Nlo3TFhsdXdDZ3ZtaVFkSmFxR3o1SWhVQ3pu?=
 =?iso-2022-jp?B?QTdrN0pTcCtZWHpNUWcwVlMrLzVMSU9UdzNtcmtLbk1aNk1RVXhmWFBW?=
 =?iso-2022-jp?B?ejJ0d3hsTzlPQURZN3lkUzBMaDNqd3lNbXFvbkJHbkxuanpWeUN5aEI3?=
 =?iso-2022-jp?B?bFFPYzM4c3ZKc1dqbmVnUTNIblpGN3lGQkJ1Y08wWG52RmhBR3hYSkVY?=
 =?iso-2022-jp?B?ZGtmWUFkemZFWDYvdElidFlXeThHYzFpNXJ6UXlqbUhiNllJYk9EM20z?=
 =?iso-2022-jp?B?djZqdk05emtUd0IwN0NVK1pscVFKdjlLalBjeFo1MllIQ2JLR1hLamtM?=
 =?iso-2022-jp?B?L2hCMXNpMm1VSWZ3RU50NjRadWVNUUNxREsyelYrMTNaL0VwODM3dW9W?=
 =?iso-2022-jp?B?THVINDNUU09mdlQ0amxtSm5xelZNOVRBSHE0dDl2UTN1VnFWWXBORTFH?=
 =?iso-2022-jp?B?bGlremF0QTRacWxBUTloMXRxL2NtZUFqTTlvR01sTVNXdHBTQnhSWjlY?=
 =?iso-2022-jp?B?Rk5iQWp1bU9GT0NqczBrR1N3eFU2LzEvVHV3cUM5cFh1WG5adzFkcFAr?=
 =?iso-2022-jp?B?TCtUdGl4MGN1QzB1cVVySkR2ZFl0cldNLy9HelhNUVBkeVZSR0s0Kzhi?=
 =?iso-2022-jp?B?T01aeHVpREZuVGNSc3pkaWM2elFIVWlqS2xUMUIrVlJBSnJVa0RKVmdW?=
 =?iso-2022-jp?B?U3VEek01TmpDR2VvVVVqSE11U0k0OXZHZXhKZDh2VUNhMnFDL0ZBd0N3?=
 =?iso-2022-jp?B?aWtKUXArblJ5eUZXc0RUOU11T1hLTjhaaTJCQnJ2SG15M1RUSGc5MEo3?=
 =?iso-2022-jp?B?QUhuWC9vdlUyQkZVUHZXOVcvVEp3am1STDg5UytuRDM3cldja2hmOVN2?=
 =?iso-2022-jp?B?T0l2bk9PdXRJeCs2R0hyTlRUUFpCSmRhNVViaWVFM0Z5QW1ZTm11ZVpC?=
 =?iso-2022-jp?B?KzMyZW9TcVIyR3FKbllmL2M2eXJGSFIwVjV2aFBhVE5jd28wMTdRclB6?=
 =?iso-2022-jp?B?THlZa3NqblI2VVFhV0xuNWlrbFBPUndUSUM4WVZRcVFxTnhKcit1TWVq?=
 =?iso-2022-jp?B?TjRoWWFiNE40cTM1b1ZwVlNNcDFpTmNCS0ZIOXRFN1hvOVdtaUpGQVZG?=
 =?iso-2022-jp?B?U0lNZlRVWjZ4bHpwb3QvQWRKSWhma0lUUkUxTE5tbGRjS1BkZDRNUElr?=
 =?iso-2022-jp?B?UW5IaTM4dk9rM2dpaDYvM2d3RisycGJCenBZU1NGUDVLandlZ0pMbERi?=
 =?iso-2022-jp?B?bnJpL3U2UFFXbktoWXVvRjJEVk9vaHNWZ2VzM2M4SmN0TzFpUGJTSGxW?=
 =?iso-2022-jp?B?M1FuSjkyYkZWdERHdjlseGsySCsyNktzU2s5eDFhZUtFZjY3NDhyYlN3?=
 =?iso-2022-jp?B?cXBFYzMrRWJpU2h3UnVoVjJzVnBMV0EzMklHLytUTDZKRGtDWjhEY3RX?=
 =?iso-2022-jp?B?RWN0d2ZHWHVteFYrWFlRb0VHNU5sSlJkTzQ4cFVNUzM5cG9oMm5FNG0y?=
 =?iso-2022-jp?B?bUR6S2JxYkdsL01icHdaN0xob1hWN0pjOHFmL3lSa2dRakV1R0V2Z0Jh?=
 =?iso-2022-jp?B?NWxmSE1La1FBZjdxUk9mV05uMDdEZ0Fhd2F3ajJIOVU3ak93M0lWOXov?=
 =?iso-2022-jp?B?cEV6YnJDY1Y5SFc1SUtWaCtsYTZHUThhNHF2c3U4K1BZT01QTlpReGpL?=
 =?iso-2022-jp?B?QndlVUV1Rk5FSm5NYkx5cGZaL09jclJhNmc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 64db87aa-0280-4e15-fc32-08da745f74c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 08:17:35.6078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 TQsXUWho817GgCYuzvRovbs4DeVkHn/I+GAoJ+eyZ4kj6lMujQuuvSLvf7JJ1QtYcEnadHbRsyEVpbfwyLPjIw5jLk9Cpm4tIVi3ZXRC6VAS8qaVqmDLwmiCCuDGvDxC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6536
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Aug 2022 08:18:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8994

[ANNOUNCE] Release v4.4.302-cip70

Hi all,

CIP kernel team has released Linux kernel v4.4.302-cip70.
This applies the required fixes for 4.4.y up to 4.9.320 of the 4.9.y tree.
You can get this release via the git tree at:

  v4.4.302-cip70:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      42722e64d359f47f84e170ac99e4b2dd2d04865b
    Fixed CVEs:
      CVE-2022-23038: xen/grant-table: add gnttab_try_end_foreign_access()
      CVE-2022-23039: xen/gntalloc: don't use gnttab_query_foreign_access()
      CVE-2022-23036: xen/grant-table: add gnttab_try_end_foreign_access()
      CVE-2022-23037: xen/netfront: don't use gnttab_query_foreign_access()=
 for mapped status
      CVE-2022-0001: x86/speculation: Rename RETPOLINE_AMD to RETPOLINE_LFE=
NCE
      CVE-2022-0002: x86/speculation: Rename RETPOLINE_AMD to RETPOLINE_LFE=
NCE
      CVE-2021-26401: x86/speculation: Use generic retpoline by default on =
AMD
      CVE-2022-23040: xen/xenbus: don't let xenbus_grant_ring() remove gran=
ts in error case
      CVE-2022-23042: xen/netfront: react properly to failing gnttab_end_fo=
reign_access_ref()
      CVE-2022-1199: ax25: Fix NULL pointer dereference in ax25_kill_by_dev=
ice
      CVE-2021-4149: btrfs: unlock newly allocated extent buffer after erro=
r
      CVE-2022-26490: nfc: st21nfca: Fix potential buffer overflows in EVT_=
TRANSACTION
      CVE-2022-28356: llc: fix netdevice reference leaks in llc_ui_bind()
      CVE-2022-1016: netfilter: nf_tables: initialize registers in nft_do_c=
hain()
      CVE-2022-1198: drivers: hamradio: 6pack: fix UAF bug caused by mod_ti=
mer()
      CVE-2022-1353: af_key: add __GFP_ZERO flag for compose_sadb_supported=
 in function pfkey_register
      CVE-2022-28390: can: ems_usb: ems_usb_start_xmit(): fix double dev_kf=
ree_skb() in error path
      CVE-2022-30594: ptrace: Check PTRACE_O_SUSPEND_SECCOMP permission on =
PTRACE_SEIZE
      CVE-2022-2380: video: fbdev: sm712fb: Fix crash in smtcfb_read()
      CVE-2022-33981: floppy: disable FDRAWCMD by default
      CVE-2022-1974: nfc: replace improper check device_is_registered() in =
netlink related functions
      CVE-2022-1975: NFC: netlink: fix sleep in atomic bug when firmware do=
wnload timeout
      CVE-2022-1734: nfc: nfcmrvl: main: reorder destructive operations in =
nfcmrvl_nci_unregister_dev to avoid bugs
      CVE-2022-1836: floppy: disable FDRAWCMD by default
      CVE-2022-1652: floppy: use a statically allocated error counter
      CVE-2022-1729: perf: Fix sys_perf_event_open() race against self
      CVE-2022-0494: block-map: add __GFP_ZERO flag for alloc_page in funct=
ion bio_copy_kern
      CVE-2022-1184: ext4: verify dir block before splitting it
      CVE-2022-32981: powerpc/32: Fix overread/overwrite of thread_struct v=
ia ptrace
      CVE-2022-32296: tcp: increase source port perturb table to 2^16
      CVE-2022-1011: fuse: fix pipe buffer lifetime for direct_io
      CVE-2022-1012: secure_seq: use the 64 bits of the siphash for port of=
fset calculation
    added commits:
      CIP: Bump version suffix to -cip70 after merge from stable

Best regards,
   Nobuhiro



