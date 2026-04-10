Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88346E9907E
	for <webhook@archiver.kernel.org>; Fri, 10 Apr 2026 10:30:31 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.153393.1775817028201891200
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Apr 2026 03:30:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=ZnXCoS9U;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1775817011;x=1777026611;bh=
	buEJZJ7YmmxBkdIXWg7QCkr2gC5XiJKlYfCbtI6QorY=;b=ZnXCoS9UuQVrbv/ycdHxrj8MTexRIC
	lFriG80yxO00t0adeurYEkSSGHcmW8JwLzKvzHAeYYucn4ipKfFuIx6CPSkE8ergJh8G/jipKW1lh
	jpnefPMyKeJBeouj/tUoNDLJGxCEr0VsiA4lypl5P8EEyRo6Ky+X8dcXjPGkhmLxazxP34qVe6KEa
	t6zh5+AvOXd7+5yx/sQfuNwYxDL+Bqf2b+GFNZEtz/pjWj3jyaGMCCSyLVkNjgWKNx/rtbloo3W9h
	2yLPHWkMF+bzB6PC0t/uk9EYfGJUP0aroK1MSiuiEUYpubfj8PO4cZHeQQHO416JbbTUZA1rhoga9
	D2EA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 63AAUA5n1941062; Fri, 10 Apr 2026 19:30:10 +0900
X-Iguazu-Qid: 2rWhfSiM7JVX6fb4y0
X-Iguazu-QSIG: v=2; s=0; t=1775817010; q=2rWhfSiM7JVX6fb4y0; m=MbMZI3VFRPVRPk2/lqv8HQCNtX5jF/gR7J6HO+/OLXA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fsY350Xngz1xnZ; Fri, 10 Apr 2026 19:30:09 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGM6r9nPAaMqMxm2rX0EeRTC7D2P4PrcQbmayfh3VXDDNU46lVPYvH9de/WQ1lamDD26lbtszxwiEihn27c8L/0QaBmUTE361nnkNDrvhkvllerWV+z2vt0AxjpcYItFwe6y9rPtGn1XEXVfEk2g1kCoMvvlNEIDu4e9zxA/9bUskuJ29qVBy2kZh7Y9OYmkx5eLt5tpd7wNWyXgwI3C8q5is5Wr8O810+kb6pRnLXrQShCAK8fUSNJjCZhTnxM0+lpoKpHRgcTrfsoj+T65vszQO7OnzICGQ5JITH3BSJIZ1H+CRh40nAg37wvyWpj8MwXYdOgr6UrfzAR+UDjVuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9uzFzyuZSTF5wvF0Eb+etn05D7CxO23JY8erKREQ7c=;
 b=ybYFHXeWBTaH5KPEEkq+U6pUpl5FKQbc7vkw0cXRwuvzdvXIwZlg9qyhaVZsoT7cQJIR5gF+u9eBY8oW4L4ZIbk+84Kx7jKIIKO7X5Zd/X8kxok1vhe9Qd2J6sk5vFa+NthOeRrrTrjEtpkzhVAc/EvmD8ma1b9p5w6kjSDTizrvaYKyQCCjcYteBriEAjvtC+whU0TfW10XeCEP47oJCkAlgCsHjhZs+7x2Y2pyKTUg9VVoLfi546F5HHpyJt6UJQp33ceyLkjav1e6izYrT6TfZtCPml21d5vcaCxH0CZDeZwBAKJz4OKJl6mKHn/isSTR4Ulj/TpqViX2LrFA4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@nabladev.com>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>,
        <uli@fpond.eu>
Subject: [ANNOUNCE] Release v6.12.80-cip20
Thread-Topic: [ANNOUNCE] Release v6.12.80-cip20
Thread-Index: AdzI1OyrmS6fXUl5TZmszCx3/ZYb0w==
Date: Fri, 10 Apr 2026 10:30:06 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148185CAF8DF293FBC83DC7BCCD592@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB6584:EE_
x-ms-office365-filtering-correlation-id: 1b1f1553-02bf-42e9-dee6-08de96ec222e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info: 
 /f35GlCbkBxzb3NXP8Q9NHKVSv9oHP88unJClYt/7D53hBNB/BHkZxWJ+isPfT+oR9UBK2ZIcQHKWRM0tUHiHxArhkKLco/gunsIv/zJX9LqYaAbYHKCTmePGQcG14T228o7Pv69fLnu99VXcKeH3ZjTqpsoJFRnuk3yxPTGtkZtS50Y2UEcOpauaTLevFtl2svy1J0VbpiSJw2eZc3vriK2099Agsun3us4Yb5VOHaimrmDzU/MRX72Ac/EW2WYHsxpcMjpbkaX91CqzP5o+AmgfugWQ7U4iQHvNogd1vs9Zmhuwm99eHkXzMT7/S0PnCVc/Iq72ygdb1OsIR4X8WcNlxj3P80ifANR3QiYPKGi360WCtEJYwFJ796ybu462SDbNRBDba8Vw3kUXnt8vsSeEqrN3JfkA0RqYCh0X2Da7UU5+i5abPU8QyrDIASD6K7+H1w/GSTTzsLfvKU2UWPSpfvxQQXK4k2rV3ZXYlGW1d7QIT7coU+n4yI+TpWLgrhlilzgRiLeIRW7nDDibnxWfm79cbquQoCIn7iXLRnbSJHbeCIemgo///ebz+2d85M/PvRV2/vv8mWP5/w/BOcMpJGF9n8Xq3O5dPdH6wjzOhboPZ3y8WUCTlmjN5u6Ln4GhJj/yZ9ua6E5NuJJJqo6aTxR3MLuMJiIIfZEOCekjMp2mB9YFInbgf9O+PCbCDi+YXe9IMf1O8HgsTtVsUjlA3ATJinGRHMeBAmUC01F9+DgXz4pxgaB4j5dROzYOXfuvjHrC7RoQ7F774Z99613TpCnVQVo8Ht3+cvl5cA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UzQwM204bXc0bXB0RS82ejFCRzByWmhFams5UE51MEJOT0xxRlAvSXZI?=
 =?iso-2022-jp?B?SE1EdUU2TFhlMXZYaHhzaS95UmwwK1dFYnkvc0pzcFhRbk5LTHRmZ1NQ?=
 =?iso-2022-jp?B?ajU3TzM4UXRQN0MrYkhXUGowS2N4WmMxMHgzVG5UdlBUZ1ZGMFFlTEFP?=
 =?iso-2022-jp?B?STZaQk9CUnhLK1l3aUQ3ZExwWWtSc0JFY2hLb0V5ek1tK0xMTFkxSURD?=
 =?iso-2022-jp?B?bk5hYWMvZGUyZ2pkV3RQQWYrVVNhejFCdnZOb2txTTh3dnFncjlsTTdn?=
 =?iso-2022-jp?B?amNZL25ETENHY0pBQXNRUzJjd3J4cTZCZnA1ZTF3OXhHZm9wblJvZlRQ?=
 =?iso-2022-jp?B?WlMwNXhxekxyNFIvNTdSMG9xbmRibVhsbm9ybFlnMzY5WUxsM2FQWjJh?=
 =?iso-2022-jp?B?V01BU00xYmx2T2lFNVF2dkpCdTIxUkY1OXFXbS9LdkZwaXVBVlREck0r?=
 =?iso-2022-jp?B?bFgvd0ZoWkNrc0huT2FHK0hrUnl3c1oyMHcvdSt2ZGQ0V1RGbERreVV1?=
 =?iso-2022-jp?B?UkJGbEYrSlI2ZlUyaElZZTJkd3djeVZSd3ZzcVNQVlNIQWV6cnpQUisw?=
 =?iso-2022-jp?B?YmVKdmc3K3hMb0VXZVVwUDZNWCtDNld3TTVRWWpaSG5IL1h2ejlnUmhJ?=
 =?iso-2022-jp?B?cXU2em1jUU5PSUdUQzZ2emhsekJRTTZpZTN0eFlMZDJ1bjNPNzJGMWNY?=
 =?iso-2022-jp?B?Q3ZjcWxoL3VsQkNLYksxUzlZZEZIQXhMaXFPeWt6TFFkSmRpWVRxeE53?=
 =?iso-2022-jp?B?QW9ReFNnYkVaZjRLU2hZV01ENktUS21ZSUx0K29CeUhVUUZTZ0VDVkZJ?=
 =?iso-2022-jp?B?dU13QXF5NVZqVElHNnIySmFvTDg3MnZPS1lHa0JGMmVPWjBvLzVMU1h1?=
 =?iso-2022-jp?B?RkMyZlN1dDBFODlMYUxUUkFpRFBWTVd6S05uMVhJaklyRHYxMThzWTlY?=
 =?iso-2022-jp?B?b2JmVDBXd05XU1BONitoRmpvTkFRUkNKQ1A2R2xVYjlhV21Wb1hqL0lx?=
 =?iso-2022-jp?B?NGZJdnArL0lPLzZ3dnVReGExWnBsOG9PdnRNK0pPYklDbVgvVXF0TzRQ?=
 =?iso-2022-jp?B?WnlvRE9aWmN0Y2p1WmpTQ2hsWHRrbHgyZmJCdFgraDM3REpkaW1sUXlz?=
 =?iso-2022-jp?B?NmhqNWUySmkranVLVVB6Ynh1eEZYdHd3bXp4NGc1MFY3YlRiQUNSamZN?=
 =?iso-2022-jp?B?S1BpSHU4KzlBN2ZuY3VXS1Y2T242TnF0SUZ2YTA1K2FEVElHMENZbklG?=
 =?iso-2022-jp?B?OFdFVDJEOGM5V21ra2M0YWVyR0FNaDR4dlVJUkwxRVZSaXV5REZSc3o1?=
 =?iso-2022-jp?B?dE5UUTdUMElNbTFzRkpZMFZGR2dzSWgrL1VmbU4wS1V5K0x0OVFZL3lP?=
 =?iso-2022-jp?B?K1o4MXRHOE1LY2psUVR4OFNrZHFGTkp4UjlqQkVZb1RaaWpwUGhWL2dT?=
 =?iso-2022-jp?B?VHQybGJhbjhsUlliS0ZtSjZMbGh5Z3ptTFJodzNvQUdqeEhhdEZKa3Q0?=
 =?iso-2022-jp?B?YjdaOXN3R1YyeFFkT0pudVBKeTBHRExvTElLUlFtOGRncU45UWpMS1Bi?=
 =?iso-2022-jp?B?VmdsaW14YTJkYUVLbWp0cW0xSDlpbmlqWjAyME83UTdFMC9WMlc1aENC?=
 =?iso-2022-jp?B?M3ROT2w2bEY5Y3MyaW1jSnJ4RWVnMDBkWDdFOENEeEp0UDloaFo1anJJ?=
 =?iso-2022-jp?B?YzNuQWI1MnRxSVZMaDRxMmZ2dTdWajVhQXI3cmRuanNnTnlGbno5V3dy?=
 =?iso-2022-jp?B?cXJXYkhJdDRwMGRhUDVwWkdHZy9RcktENmxxRm96dHF1RG0rS3VJMm51?=
 =?iso-2022-jp?B?SThCTFpaM2twQk9tbUxRSUNEMm9xNUdJMWw4ZzhZV21SZWlWSmpTTGJj?=
 =?iso-2022-jp?B?dDlPSWFzaHJBbHhhUURQY0VBMWNXMU03ZVlCTHRlY0ticnk3UWFvNVZh?=
 =?iso-2022-jp?B?TGJ3eVVEOWRHeEwzc2FhK0xOOTNjN1RTNHp1OGFiQTlHcDVjN1JmNDEx?=
 =?iso-2022-jp?B?VXpQL1ppcWl4WEhaSUdvNTUrWXVJRGQ0V3lod3Y4dlVXOUFFWjRIZHJ4?=
 =?iso-2022-jp?B?bURvZ2YwM3E4YXhCOU5RaDJ4WUh0eGgyL1FvQ1E2bnNUQlFLYXlndlNG?=
 =?iso-2022-jp?B?TmJtdlFSSkp1TXNPVU1yZ2l5NGxaNnpwaEtZbHppNHA0OVFwckhxMTU2?=
 =?iso-2022-jp?B?akZhMU1PUEQwdGZITXNBLzcwcG4zZDNOVHlIMzQvdi9weHcxbk5KUG1o?=
 =?iso-2022-jp?B?UFd3dzRQd3JpQjFHVGp1SUNoSmNHWHdLdmV0Zm8wdUgwN2RONjhnVjdn?=
 =?iso-2022-jp?B?WkgyQjJlN3pxRTNsbTlRTU9WUmxBV2d1SWs5R1FLQmd3bkVNcm9zeDlu?=
 =?iso-2022-jp?B?Sjg2TnY5ZTE4MWxKRi9EQjZSU25OcGpKbTEzSWRCazZrM29NbmpFRExC?=
 =?iso-2022-jp?B?UE56aEFJNmNGQlFWUnp6TlJtcGE3VkZHalQxbkFTblhrNmUzRVlhSHN2?=
 =?iso-2022-jp?B?amRadWZuUE5zdkxrRnRDd1YvVTQyTjlQZTBXc2RLNVMrcmRKczBEVXBX?=
 =?iso-2022-jp?B?QllJQUxsZz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	Koq84Cgs8Rtm8GfRIB8JLcHzektGfTdc4apfylbEmFR63xRbwLVS4CeFCoVwYGniyxzd1lBJH2dmeRFUI/QImV9uM7eYsm5O78Yv52ts2/U4MEnIgYoqsaJDOIyEUx3pTZnAD39xPWh6juG2h7R7tqJRy0v4oSGFRgZh349BdugZYH3ory3qFXU7M2upA+YHN3132/G3MM3Zu0BlQ+sv2NcbZnL7xts7mbgkakqZTXqKzTvliHvMDhKjBFULx+kHF1/xLvuf+8PMFTImBhKjw2wePd1yXApctFG60/KILsnLyQobw+Ls2LSeAjCHtD1vpnBr8a5g2LrE8tK9SKRLRw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1f1553-02bf-42e9-dee6-08de96ec222e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 10:30:06.3038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/PE8q6LoeCBC8qYvix11skDEdTdCJ5VUR4Q3i55E+929OHo9VhQQ2TGm1rEJ/5tIIFIFEUZIg9v7yJ9V1RnGnM0vOLhF2X8JgFcSDSrPk0OQghWDUECXIuA8Bey2vfJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6584
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Apr 2026 10:30:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22661

Hi all,

CIP kernel team has released Linux kernel v6.12.80-cip20.
The linux-6.12.y-cip tree has been updated base version from v6.12.78 to v6=
.12.80.
Additionally, this CIP release includes updates for PCIe, CANFD, and TSU in=
 Renesas ARM64 SoCs.

Information about this release is as follows:

  v6.12.80-cip20:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      e43f121b9042dd81d570b346d74a84e0a4f53795
    fixed CVEs:
      CVE-2025-22116: idpf: check error for register_netdev() on init
      CVE-2025-22117: ice: fix using untrusted value of pkt_len in
ice_vc_fdir_parse_raw()
      CVE-2025-68175: media: nxp: imx8-isi: Fix streaming cleanup on releas=
e
      CVE-2025-68736: landlock: Fix handling of disconnected directories
      CVE-2026-22981: idpf: detach and close netdevs while handling a reset
      CVE-2026-22985: idpf: Fix RSS LUT NULL pointer crash on early ethtool=
 operations
      CVE-2026-22993: idpf: Fix RSS LUT NULL ptr issue after soft reset
      CVE-2026-23207: spi: tegra210-quad: Protect curr_xfer check in IRQ ha=
ndler
      CVE-2026-23210: ice: Fix PTP NULL pointer dereference during VSI rebu=
ild
      CVE-2026-23255: net: add proper RCU protection to /proc/net/ptype
      CVE-2026-23401: KVM: x86/mmu: Drop/zap existing present SPTE even whe=
n creating an MMIO SPTE
      CVE-2026-23414: tls: Purge async_hold in tls_decrypt_async_wait()
      CVE-2026-23417: bpf: Fix constant blinding for PROBE_MEM32 stores
      CVE-2026-31406: xfrm: Fix work re-schedule after cancel in xfrm_nat_k=
eepalive_net_fini()
      CVE-2026-31408: Bluetooth: SCO: Fix use-after-free in sco_recv_frame(=
) due to missing sock_hold
    added commits:
      CIP: Bump version suffix to -cip20 after merge from stable
      arm64: dts: renesas: r9a09g056: Add TSU nodes
      arm64: dts: renesas: r9a09g056: Use syscon compatible for the system =
controller
      arm64: dts: renesas: r9a09g056: Move interrupt-parent to root node
      PM: domains: Add RZ/V2N compatible to PM domain detach list
      clk: renesas: r9a09g056: Add clock and reset entries for TSU
      dt-bindings: thermal: r9a09g047-tsu: Document RZ/V2N TSU
      dt-bindings: thermal: r9a09g047-tsu: Document RZ/V2H TSU
      arm64: dts: renesas: r9a09g087m44-rzn2h-evk: Enable CANFD
      arm64: dts: renesas: r9a09g077m44-rzt2h-evk: Enable CANFD
      arm64: dts: renesas: r9a09g087: Add CANFD node
      arm64: dts: renesas: r9a09g077: Add CANFD node
      can: rcar_canfd: Add RZ/T2H support
      dt-bindings: can: renesas,rcar-canfd: Document RZ/T2H and RZ/N2H SoCs
      clk: renesas: r9a09g077: Add CANFD clocks
      clk: renesas: r9a09g077: Propagate rate changes through mux parents
      dt-bindings: clock: renesas,r9a09g077/87: Add PCLKCAN ID
      dt-bindings: clock: renesas,r9a09g077/87: Add XSPI0/1 IDs
      arm64: dts: renesas: rzg3s-smarc-som: Set bypass for Versa3 PLL2
      arm64: defconfig: Enable PCIe for the Renesas RZ/G3S SoC
      arm64: dts: renesas: rzg3s-smarc: Enable PCIe
      arm64: dts: renesas: rzg3s-smarc-som: Add PCIe reference clock
      arm64: dts: renesas: r9a08g045: Add PCIe node
      arm64: dts: renesas: r9a08g045: Use syscon compatible for the system =
controller
      PCI: rzg3s-host: Fix device node reference leak in rzg3s_pcie_host_pa=
rse_port()
      PCI: rzg3s-host: Drop the lock on RZG3S_PCI_MSIRS and RZG3S_PCI_PINTR=
CVIS
      PCI: rzg3s-host: Use pci_generic_config_write() for the root bus
      PCI: rzg3s-host: Initialize MSI status bitmap before use
      PCI: Add Renesas RZ/G3S host controller driver
      dt-bindings: PCI: Add Renesas RZ/G3S PCIe controller binding
      PCI: Move link up wait time and max retries macros to pci.h
      clk: renesas: r9a08g045: Add PCIe clocks and resets
      arm64: dts: renesas: r9a09g057: Add CANFD node
      arm64: dts: renesas: r9a09g056: Add CANFD node
      dt-bindings: can: renesas,rcar-canfd: Document RZ/V2H(P) and RZ/V2N S=
oCs
      clk: renesas: r9a09g056: Add entries for CANFD
      clk: renesas: r9a09g057: Add entries for CANFD

Best regards,
  Nobuhiro

--
Nobuhiro Iwamatsu


