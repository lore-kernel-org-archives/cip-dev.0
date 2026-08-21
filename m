Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D15CC5DF89
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 11:55:30 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5756.1787313324855112485
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2026 04:55:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=k+ziOh0+;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1787313309;x=1788522909;bh=
	o9CwD/sATEEEzoVhcVlETPqjSSXJUQnZL98rVLpUk7k=;b=k+ziOh0+E/iQy3+l26t59g2FtvBkqE
	3K8QWiBqzf2SooZnVGmHABa9ZewQH6BOog7h7thID0MVGVgrLyw4yLjIlJkBI9oGYoTCXn+1yW+gW
	DeAj1AT1hhhu6H4QEfDkrFLF6vdZMyNqwwD2k2wUZD6rj+wxrTNGDVFWHw/8MASs5EwpWjkw26d8U
	yOQnXc5Ytm3Z3ow4MdGIZW8BL1zElWGasfv58ZS8+UrWBUxHJSMbHCfyJ+Ij4sIdYJh4asyZxqZqm
	T+Xu6uheVEKWx3Hz0O/QbLyPKpD+8tESe4Clx7vNyaycmbsZL8VVyZd07TIiCReGaJfPiWLp/OLm3
	LL+Q==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 67LBt8KP3382390; Fri, 21 Aug 2026 20:55:08 +0900
X-Iguazu-Qid: 2rWhc6Lorm28zSi3kG
X-Iguazu-QSIG: v=2; s=1; t=1787313308; q=2rWhc6Lorm28zSi3kG; m=gzU5uLlim7Ri+7DPuyYArGGe19noW0MkGl//ZCgWZ8c=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hRJdl01lVz4vym; Fri, 21 Aug 2026 20:55:06 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qkf2dybRL1UGJ3YoWpLyCqvjWosTV5IEFg+bZrAS6rNUVSjFoIxw0ASt2rncCPjEyMcco6wKfqg4qYipF6107F2gyiS+ake1kyqDeEjm2mqe2PZXiK6WeQ3fi8db+UaDfSJJjXzDR3mWlisZkIByNrPKviWhc3MFwgIKRP5IUVGxy1rBsDTUjeKS9g3Lzi2PN4yDgxlcoOsg0ZUEJWQnpEsDCgnc+PhPNL/w2+l7RwcNQGsMfLqDDXlQReTtx6IFp/W+Xske/gm6YQ8BEiHS4v4nPfNIBzM7uVXY8hcD3t7rrbLRQv9LdV0rzrhnZp4k0KnpONUWb807e6yDmG/4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSzQ0hNVUIiK5q4LCljWTAN3sEvr1kJeS8csbZ1UvJU=;
 b=AAoe+lgHo6rgeyoeYCxcXj0Da7+3M3AfNg2hddXllmSS3IOafHYEuGZOKMiGI650wnwDkJdX7GyAGckTPw9T7L5YwmraOPV8MqZ/HIAVqyHOmbrkaI1KpNYFBwdHr8v5Xv3pfSWGYA7nmF/7FkzhuxHSxNSBz1ySm2NCLGpypalPaV3pAbsL8hsnMIXzufZNmyQ9Z/xck1KteH8gYoaGwn6KbCOy5dsUtffwo4azuVNnKlZWS8D0iEfji7yhLh7hEPrNh3OoDqbMl07t4GhTgtkOYOMp/UDpCdWM3jzZU8v81k8ux2gXVdyWk7oljO/iuMd73fd1ygirxS/zW37lTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@nabladev.com>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>,
        <uli@fpond.eu>
Subject: [ANNOUNCE] Release v6.12.104-cip30
Thread-Topic: [ANNOUNCE] Release v6.12.104-cip30
Thread-Index: Ad0xScaqoort8BFFTOqgrfwtiYum0Q==
Date: Fri, 21 Aug 2026 11:55:04 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148182171B43902BB2F2B38AFCDA32@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS7PR01MB17735:EE_
x-ms-office365-filtering-correlation-id: 7b64e4df-38fc-4a0b-c847-08deff7b0a10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10067099003|6133799003|3023799007|56012099006|11063799006|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 OhJpodZtYf0+7NjSsxCy3LMKQdPf2afNIL227ecxXzyv9OMLGcUrAayzS4/XEDaOfatDxGXO6CKiI/Ppt7kfrIZIAQLBU7bgWRAp6cCC5A9rfIDQ7yNb149/Tklz5gXIp/ZWsVjr5tcBKh1L+plA2wbCHYuU2vMp5cDz4jjZuakonv/m+xC0z6Q2B6T9OAkbaz+FeWPKkX8F6zys2htbhlbKcGgXrfn3iyYY4eJZ6eYnbpgRSFqpiEJPkr7aacHYSuXw55S2uGzJDT1eAvvcI0avhhJ5NIzQXnpgxFcvhP6JzzV9KOfsx/1Z4J7cYnDoGJ636fbjh/aTN4BlR983BpEK3q475s4/WvX/UYARoPUv3kiFfapEt3shmdW04BqJxCv6raXo5tacYtD1cOsiaJ/HP7yb1G9F9rovgUcopDxQX1N9aCiymFzEc43LgvI9xHI93n/+xpvBTrg+8/DWG9Q7UmSjMkXabt9bwt7WGjgSCKcWJCvzxP2/7MiAPI9tD966Sw9bLd+ygSRmF0jBJAfS2QeLOfBOZn4j5a/P9lxs9KKv9SIGZfduFDy6YV2n6uuRcTg1EA5xbrtvCI6Ae0OkmBMRLvxNj0GWulu0eG2CYQ5WBIjVnTKCxqijSy/Llic1q1A9BJjcoOdc185kr2xRwhGQMei0ytwnkneCrp68bWIZqEgn3iKO8iP0U5HpyltwNYNjjAT2O7KcyI0OKQBu5BO3GByT6HXM2QFvVG0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(6133799003)(3023799007)(56012099006)(11063799006)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NVNjNGdHdzRwNFNFenNQVnRKV0ZUYkdRaUhXQTlycXNRTEFqek43T25M?=
 =?iso-2022-jp?B?dVdqSXd3U3NGa0JWbWFIMkt4T1pCa2RUYmdxa2RtMWdURG0vemxzcG1n?=
 =?iso-2022-jp?B?RFFhVEF6bnlZQ0hIM0F3Q2RLdXcvVGpLa3VMZnFLN01xbmR3bGNLdWpm?=
 =?iso-2022-jp?B?RUw4Y3NUQjRRRGRHalR5UVIxT0dZaHlsZ1Q0ZEJWVHZpc0s4dCtPMElz?=
 =?iso-2022-jp?B?T1dJUDJ3R1o4WjE5ZVhXcHBOcHNZa2Jhdm1UclpQMU1DQ1V0RUhLQlBX?=
 =?iso-2022-jp?B?d2ZDSk1VQ3g2K2M0VzJFQ0JWbUtEUjJpcUVYUWpEWUdmUDNHU3F3TXJ0?=
 =?iso-2022-jp?B?QXZOai9uTE9hOEN3QjVLaEMyeUpQSk9Da0gwbG8xUXozb3JLUjlDdTQr?=
 =?iso-2022-jp?B?MXk5cHZZdVNxV0IzcmQxbWpOb1RoTTVjc3ViTTNDUU9TUExZa3lIYkxN?=
 =?iso-2022-jp?B?UFpXbCs4NlZpbFNRRlNqZjlmcHhFK1dPbkZqOE5KblEvbGEvdS9xYjdU?=
 =?iso-2022-jp?B?S2tHbnVCYzI3ZU81eUVUUGNDQmtyWVZzU09yNHNqK3hIeGNXVGhpZ3JY?=
 =?iso-2022-jp?B?ejNaakNndzBUeTNKUXhYUXlNWmIrU1luQ1Fna3NUaWl3MExQZExRRGlD?=
 =?iso-2022-jp?B?QWhVOWxZTDFjYS9vUHBpWVNndllHUmRxdXI1YVNJdnlFbVh5K2Fvb2VV?=
 =?iso-2022-jp?B?bTllNCtBZ200Um1sTjFUNExLYzVnK0N2OE9iNGZyejB2R3FURnBPTFJm?=
 =?iso-2022-jp?B?SzhNbVdKN25aa0VSVC9SZG9YWUdMd2ZVQnlVVVQ2eVZpaEVDZkVFai9z?=
 =?iso-2022-jp?B?MnNmY3NxOFBJT3B5VmZCK1hDNkpQWUtDdzFCaUNrSGlmZkFScDZQd0Jz?=
 =?iso-2022-jp?B?QlJlN3JrRHNxUnlUV1dsK1JRM0VjWDZvdVo4SFNvZUgvWVIwMnFZRFdq?=
 =?iso-2022-jp?B?QlpmaWFxY1lwM25rVmVjOEJPd2oybk5oN1Z0UEt3TmVsZHhSck5LU3g5?=
 =?iso-2022-jp?B?SWV2K0FCMmtFcEYzZjRvbUdEaXhWVXNuWGl5ZFJyeERrN1ZoSENUbi9G?=
 =?iso-2022-jp?B?cDhyaDhKM3hDZHdSaGtLS0JjbGM1VjNFSFNZc0FUSjNQQ09ERCt1cjNM?=
 =?iso-2022-jp?B?VlA4U3A2T0hMU2pOTmhGU1FtS1g4SjhlNnVBL3hiYnpIMEdiaUdVbTND?=
 =?iso-2022-jp?B?aEpZWk1GVTJRTVhld1NlcWhYd2YzZ3pvT1FIOTV0Yi84bDNxbDJHeGVU?=
 =?iso-2022-jp?B?c09ZMlpLQUFTMHVxaEpINER4UHNpVlp1SFVhRW5BMFU3ZHN3WGNMcXdB?=
 =?iso-2022-jp?B?OENlaGd2b0R1Wk11RVZQTml1Q21ZQUI4aTlBMWZIU0duVTFFOXBzZFVi?=
 =?iso-2022-jp?B?Z0ZlZWZCQ2hYZ2EzSURnaC81WVhiUzkrcGVXRTF3WXVqNFg5ckJsb2k1?=
 =?iso-2022-jp?B?dHlKRmlQemg0WFh2cTNMNExuUkl6dU52WWZwUFRRV1ZXUFd1U09qencv?=
 =?iso-2022-jp?B?VzhsdWd1d0U5L216SWFDL0Q2RENkVGF6UEhCNUl0emMzWFJnWTBRWTE3?=
 =?iso-2022-jp?B?eWExNUdxTUF4MWdLZk5yV2E0Wm5RRUpUemhBZEtoYzRNajY3QmxIaTFI?=
 =?iso-2022-jp?B?cDNlc0kxVmZmVzBsQ3pDWDluTjJjdk5leVRQRjBEUHRxQTFOWU5sakxZ?=
 =?iso-2022-jp?B?c0FrQmZYcDVyMTh5TnY5SzVlN3pNdlhKcDlFSkgwYTRkYjFCUFJOdExl?=
 =?iso-2022-jp?B?VWlFTmo5eVpHWGR1UEx6amhyRE10b2FDd1l3QTdmcDh1STluaHZYb29l?=
 =?iso-2022-jp?B?VVBUdGZNMngxaTdyZkt0ZHBTVVNkVWJ2Qkx6cWNBQTZSczhJSElqSWR4?=
 =?iso-2022-jp?B?RVhIclJSdzQ2b0lyN1JUeU9rTGlvRFpTM1UrQjBzcEpPUktLNkJqNXlz?=
 =?iso-2022-jp?B?a3lubmZrSUs4alJWR2hLeFIvWmJWeTcwRS9LVDJCKytIYTRHOHdNSlU1?=
 =?iso-2022-jp?B?UUZ2cjdRdFBmRU41TlgzQVU0QnNGU3g0NWRYb1liL2NOOFJZYlhROCsv?=
 =?iso-2022-jp?B?bzZzSDRiSTMwZU1Vd29lN0owaWVZWGpURXFFZHUvbTV6Z0s0QVV0NWZn?=
 =?iso-2022-jp?B?THlGZVpEdjBqUkZhY2h0QTJoWVlJSUlCeElDNTdWT01aeXVuQklZckpF?=
 =?iso-2022-jp?B?NGFFNCs5eThuSE9DeFdrMDZTN25NOHdFYjdJMGNUc2h5L28zeDBtU0tN?=
 =?iso-2022-jp?B?L3BWOE8vU1pJSmxaY0xLek4xOURIWVV5L2RSMGc4cHNXN0N1Y3pJSDIr?=
 =?iso-2022-jp?B?S0pxTjhScDZLNUNaenRuallBOEM5N09sbmhvdWk2WkhXK3FLbzBoY3A0?=
 =?iso-2022-jp?B?ejZlS2FVcnZQdGc2NEE1dHdVOE0zTVA0YVdSRmJ3K3Y5VFpSck42V2ts?=
 =?iso-2022-jp?B?UnY4c3o4TkdwSXhhWm52c2xvN0RDTzJnMWJScUNOVU9GUzdtVVlSRE9y?=
 =?iso-2022-jp?B?eGtCZ0hJeWcvQ3VPa2s5SWpSNjlmVnRMb2JTaVNCMWEvSVZQaGZ1eXhE?=
 =?iso-2022-jp?B?STB4dU9BMD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	ea9MOnav3gov+eNp/baEKLwDHrYqldBcvtwYQAB7/eVffLuR5zNdjbAmiMxGAbv9XwLlPJsnnjJdMNYVpUH4WSV9U4dmNM6kEnx0U8KbcB9yEmpskXrAYybS28d/MQ5hauM63IOqrqkAoCxIFCzSO+lFRpxLLVlQ7FlhBPpNecFLmkdakpYGlRiCJecK3k2jr0oSbQjzkSSt2iulNhvHxi9SJ3niJyjsTJElJfFtEIHfIP+DbReqNJBr3LTr5yxSaIyOFemIXx+Bkv4BWzWiRBIX6+q8sP5mZKpCdNzbwk1ptFCmKoVfBy+ZMaSnpbcdrRF4C11LX6dIONfdiwczFA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b64e4df-38fc-4a0b-c847-08deff7b0a10
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 11:55:04.7613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +LQJ8fW+ZKPWVNguRLSB7/Ex4b8Uz47xWl/kMszE0Mj7vJ8xlwUmaTYflPhO+S4rBLNO59y9Csf6HTlXjHOXNU+sigpVZ7agZooM6KPNcgZ67G7YdENemqPHtC68qoM7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB17735
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Aug 2026 11:55:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23956

Hi all,

CIP kernel team has released Linux kernel v6.12.104-cip30.
The linux-6.12.y-cip tree has been updated base version from v6.12.101 to v=
6.12.104.

Information about this release is as follows:

  v6.12.104-cip30:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      021c2f95227f3aca5dd6bf4c6c761088eb0ea888
    fixed CVEs:
      CVE-2026-68480: x86/bugs: Make Safe-RET robust against interrupt inje=
ction
      CVE-2025-38525: rxrpc: Fix irq-disabled in local_bh_enable()
      CVE-2026-43197: netconsole: avoid OOB reads, msg is not nul-terminate=
d
      CVE-2026-64427: HID: logitech-dj: Fix maxfield check in DJ short repo=
rt validation
      CVE-2026-64563: rhashtable: clear stale iter->p on table restart
      CVE-2026-64586: wifi: brcmfmac: drain bus_reset work on device remova=
l
      CVE-2026-68169: mptcp: pm: userspace: fix use-after-free in get_local=
_id
      CVE-2026-68198: wifi: ath6kl: fix use-after-free in aggr_reset_state(=
)
      CVE-2026-68253: drm/i915/hdcp: check streams[] bounds before overflow
      CVE-2026-68254: drm/i915/vrr: require valid min/max vfreq for VRR
      CVE-2026-68264: drm/xe/pt: Reset current_op in xe_pt_update_ops_init(=
)
      CVE-2026-68266: drm/xe: Hold a dma-buf reference for imported BOs
      CVE-2026-68267: drm/xe/rtp: Add RING_FORCE_TO_NONPRIV_DENY to OA whit=
elists
      CVE-2026-68273: drm/amdgpu: Fix context pstate override handling
      CVE-2026-68276: drm/amdgpu/gfx: fix cleaner shader IB buffer overflow
      CVE-2026-68322: rds: Fix inet6_addr_lst NULL dereference when IPv6 is=
 disabled
      CVE-2026-68367: usb: gadget: f_tcm: synchronize delayed set_alt with =
teardown
      CVE-2026-68451: s390/zcrypt: Validate length for CCA ECC private key =
requests
      CVE-2026-68452: s390/zcrypt: Validate length for CCA AES cipher key r=
equests
      CVE-2026-72111: bpf: Reset register bounds before narrowing retval ra=
nge in check_mem_access()
      CVE-2026-74352: of: reserved_mem: avoid post-init UAF when alloc_rese=
rved_mem_array() fails
      CVE-2026-74440: drm/xe: Wait on external BO kernel fences in exec IOC=
TL
      CVE-2026-74441: usb: typec: ucsi: Fix race condition and ordering in =
port unregistration
      CVE-2026-74442: drm/vmwgfx: avoid destroy_workqueue(NULL) on vkms ini=
t failure
      CVE-2026-74443: drm/vmwgfx: bound DMA command body size against suffi=
x pointer
      CVE-2026-74444: drm/vmwgfx: validate DRAW_PRIMITIVES header size befo=
re division
      CVE-2026-74445: drm/vmwgfx: reject DX_BIND_QUERY without a DX context
      CVE-2026-74446: drm/amdkfd: hold event_mutex while checkpointing CRIU=
 events
      CVE-2026-74447: drm/amdkfd: fix uint32_t overflow in EOP ring buffer =
size alignment
      CVE-2026-74448: drm/amdkfd: fix QID bit leak in pqm_create_queue()
      CVE-2026-74451: drm/panthor: validate firmware interface structure si=
zes
      CVE-2026-74452: drm/panthor: reject firmware sections with oversized =
data
      CVE-2026-74453: drm/vc4: Zero the tile state data array before each B=
IN job
      CVE-2026-74454: drm/vc4: Supply the overflow slot size in BPOS, not t=
he whole bin BO size
      CVE-2026-74455: can: peak_usb: validate uCAN receive record lengths
      CVE-2026-74456: can: peak_usb: peak_usb_start(): fix double free of t=
ransfer buffer on URB submit error
      CVE-2026-74457: can: peak_usb: add bounds check for USB channel index
      CVE-2026-74458: can: kvaser_usb_leaf: kvaser_usb_leaf_wait_cmd(): val=
idate received command extents
      CVE-2026-74459: can: etas_es58x: es58x_read_bulk_callback(): fix RX b=
uffer leak on URB resubmit failure
      CVE-2026-74460: can: ems_usb: validate CPC message lengths
      CVE-2026-74461: i2c: imx: Cancel hrtimer before clearing slave pointe=
r
      CVE-2026-74463: i2c: jz4780: Cache host clock rate at probe to preven=
t CCF prepare_lock deadlock
      CVE-2026-74464: net: openvswitch: fix skb leak on flow key update fai=
lure during ct
      CVE-2026-74465: net: openvswitch: fix potential UAF on meter attach f=
ailure
      CVE-2026-74467: s390/qeth: Check CAP_NET_ADMIN for private ioctls
      CVE-2026-74468: gpio: pch: use raw_spinlock_t for the register lock
      CVE-2026-74469: sctp: prevent peer transport count overflow
      CVE-2026-74470: scsi: scsi_debug: Fix REPORT ZONES alloc_len underflo=
w OOB write
      CVE-2026-74471: tracing: Check return value of __register_event() in =
trace_module_add_events()
      CVE-2026-74472: ublk: reset kernel-owned dev_info fields in ublk_ctrl=
_add_dev()
      CVE-2026-74473: vxlan: use pskb_network_may_pull() in route_shortcirc=
uit()
      CVE-2026-74475: vxlan: use neigh_ha_snapshot() in route_shortcircuit(=
)
      CVE-2026-74476: veth: convert frag_list skbs before running XDP
      CVE-2026-74478: um: vector: fix use-after-free in vector_mmsg_rx()
      CVE-2026-74480: net: bridge: stop fast-leave after deleting a port gr=
oup
      CVE-2026-74481: mm/page_reporting: use system_freezable_wq to fix UAF=
 during suspend
      CVE-2026-74482: mm/huge_memory: unlock i_mmap_rwsem before releasing =
after-split folios
      CVE-2026-74484: binfmt_misc: don't let an 'F' entry pin its own insta=
nce
      CVE-2026-74485: binfmt_misc: reject a flag character as the field del=
imiter
      CVE-2026-74488: wifi: mwifiex: use the subframe length when parsing A=
-MSDU TDLS frames
      CVE-2026-74490: tipc: avoid use-after-free in poll trace queue dumps
      CVE-2026-74492: netfilter: ipset: do not update comments from kernel-=
side hash adds
      CVE-2026-74493: net/smc: fix socket use-after-free during link group =
termination
      CVE-2026-74495: igbvf: Fix leak in TX DMA error cleanup
      CVE-2026-74497: ALSA: usb-audio: Clamp frame size in implicit-feedbac=
k mode
      CVE-2026-74498: ALSA: usb-audio: Fix DMA buffer out-of-bounds write w=
hen fill_max is set
      CVE-2026-74499: ALSA: usb-audio: fix OOB write in snd_usbmidi_akai_ou=
tput()
      CVE-2026-74500: ALSA: usb-audio: fix stack info leak in RME Digiface =
status
      CVE-2026-74501: ALSA: usb-audio: fix use-after-free in ump_to_endpoin=
t()
      CVE-2026-74502: ALSA: ump: fix double free of out_cvts on rawmidi err=
or
      CVE-2026-74503: ALSA: timer: Clear SNDRV_TIMER_IFLG_DEAD once the clo=
se completes
      CVE-2026-74504: ALSA: seq: Fix division by zero in initialize_timer()
      CVE-2026-74505: ALSA: 6fire: Fix UAF at error handling during probe
      CVE-2026-74507: Bluetooth: HIDP: validate numbered report payloads
      CVE-2026-74508: Bluetooth: HIDP: reject frames without a transaction =
header
      CVE-2026-74509: Bluetooth: hci_sync: Fix advertising data UAFs
      CVE-2026-74510: Bluetooth: mgmt: fix UAF in pair command cancellation
      CVE-2026-74511: [REJECTED]: Bluetooth: mgmt: fix pending command UAF =
in EIR updates
      CVE-2026-74512: audit: fix potential use-after-free in audit_del_rule=
()
      CVE-2026-74515: KVM: s390: pci: Reject adapter interrupt forwarding i=
f already enabled
      CVE-2026-74516: KVM: SVM: Update x2APIC MSR intercepts if AVIC is inh=
ibited while L2 is active
      CVE-2026-74518: mm/hugetlb: fix list corruption in allocate_file_regi=
on_entries()
      CVE-2026-74519: pinctrl: devicetree: don't free uninitialized dev_nam=
e on error path
      CVE-2026-74522: ksmbd: fix use-after-free in __close_file_table_ids()
      CVE-2026-74523: qede: sync udp_tunnel ports outside qede_lock in the =
recovery path
      CVE-2026-74524: riscv: mm: Fix out-of-bounds page-table walk during m=
emory hot-remove
      CVE-2026-74525: net: sxgbe: free TX rings on RX allocation failure
      CVE-2026-74531: Bluetooth: hci_conn: hold conn reference in abort_con=
n_sync()
      CVE-2026-74532: Bluetooth: btintel: Validate length before parsing di=
agnostics TLV
      CVE-2026-74535: Bluetooth: ISO: avoid deadlocks in iso_sock_timeout
      CVE-2026-74536: Bluetooth: ISO: fix leaking sk after socket release
      CVE-2026-74540: Bluetooth: L2CAP: fix UAF in l2cap_le_connect_rsp
      CVE-2026-74541: Bluetooth: ISO: clear iso_data always when detaching =
conn from hcon
      CVE-2026-74543: net: udp_tunnel: fix memory leak in udp_tunnel_nic_un=
register()
      CVE-2026-74545: rtase: fix double free of multi-frag skb on DMA map f=
ailure
      CVE-2026-74546: hwmon: (adt7470) Fix divide-by-zero TOCTOU crash in f=
an speed read
      CVE-2026-74547: hwmon: (adt7470) Fix busy-loop and I2C flooding in up=
date thread
      CVE-2026-74548: forcedeth: fix UAF of txrx_stats in nv_remove
      CVE-2026-74549: hwmon: (nct6775-core) Prevent access to unsupported w=
eight registers
      CVE-2026-74550: net: do not send ICMP/NDISC Redirects when peer alloc=
ation fails
      CVE-2026-74551: hwmon: (nzxt-smart2) DMA-align output buffer
      CVE-2026-74552: hwmon: (lm90) Only report alarms if driver is ready
      CVE-2026-74553: hwmon: (nct6775-core) Fix number of temperature regis=
ters for NCT6116
      CVE-2026-74555: scsi: libsas: Fix HA resume deadlock and hisi_sas dis=
k-wake race
      CVE-2026-74556: scsi: libiscsi_tcp: Bound SCSI Response data segment =
to the connection buffer
      CVE-2026-74557: scsi: libiscsi: Fix stale-data leak into the SCSI sen=
se buffer
      CVE-2026-74563: rds: tcp: hold the RCU lock across ipv6_chk_addr() in=
 rds_tcp_laddr_check()
      CVE-2026-74564: netfilter: xt_hashlimit: validate hashtable supports =
XT_HASHLIMIT_RATE_MATCH
      CVE-2026-74565: netfilter: nf_tables: make nft_object rhltable per ta=
ble
      CVE-2026-74566: keys: make keyring key-chunk byte order agree with ke=
yring_diff_objects()
      CVE-2026-74567: keys: fix out-of-bounds read in keyring_get_key_chunk=
()
      CVE-2026-74569: netfilter: nf_conntrack_sip: widen NAT rewrite delta =
to s32 in sip_help_tcp()
      CVE-2026-74572: btrfs: zoned: fix deadlock between metadata writeback=
 and transaction commit
      CVE-2026-74574: dmaengine: idxd: fix fdev setup failure cleanup in id=
xd_cdev_open()
      CVE-2026-74575: thunderbolt: Prevent XDomain delayed work use-after-f=
ree on disconnect
      CVE-2026-74576: mm/slab: prevent unbounded recursion in free path wit=
h new kmalloc type
      CVE-2026-74577: net: mpls: initialize rtm_tos in mpls_getroute()
      CVE-2026-74579: netfilter: nft_payload: fix mask build for partial fi=
eld offload
      CVE-2026-64017: blk-mq: pop cached request if it is usable
      CVE-2026-64575: bpf: tcp: fix double sock release on batch realloc
      CVE-2026-74514: KVM: s390: pci: Fix memory accounting for pinned/unpi=
nned pages
    added commits:
      CIP: Bump version suffix to -cip30 after merge from stable

Best regards,
  Nobuhiro


