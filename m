Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85EBC5AC7A
	for <webhook@archiver.kernel.org>; Fri,  7 Aug 2026 08:24:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37927.1786091095460668687
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Aug 2026 01:24:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=kBTOTNSz;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1786091083;x=1787300683;bh=
	X0Eprrxv1V5WVcYwqYDSlzqU25Qp20I/w2/QUx3jP04=;b=kBTOTNSz6mmZ6hDLXveGiMHUX8W1Rp
	+3nOOIeTY7npSMrCndxVsTPfEQN3YNmte7ISvEoJmyudTzE+s2QbiiT6tO0miTITLpFVMhB5wVsd8
	WyrtsaOf9BF1CQnSTw2roQS17mZUE0ZsZYpsZ+abMgODTzdqfRad9FeD9dk4qgajgWk1wNUGbLCKA
	HPLE54UhVeKUSC+fQvuOFlfMqq65JUcfQQ3toENnPySyOKGsNi3Mjq53R287loKlDw8n1qkSPSS2A
	iBw4xui5ZPJWjLzSSropY4AfE1pQjhto8bq2VCVDc5zDgQV/ZkvjUO9soHDrJyACO2PEEqZw54Hil
	ITig==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 6778OhTB3613212; Fri, 7 Aug 2026 17:24:43 +0900
X-Iguazu-Qid: 2yAbS7Jdrry7UcaVgU
X-Iguazu-QSIG: v=2; s=1; t=1786091082; q=2yAbS7Jdrry7UcaVgU; m=fkf1SehsIlWqOJgqwZWQH1tX7kB4jHDW31Jo6hIi1Pw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hGcdP6qLkzyPQ; Fri,  7 Aug 2026 17:24:41 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wScBIYUSf1NfP/B/Im2629QgKK6u6XuAG+eskKyTiLC/jlo1LrXQFI+jOegRgmD9SQbgx3HMwNQT7Aerdq93fQ/UxKAexAP6aujmlFaXUusNU1sB35Bufp0cupFiK3sGMeTUzsd74RUumFvXrFdCHeEViqcqc+GX/eFdAGpAfBE/P7miV1+m/2HfAmIa7+5YNNfKaBi/X9g5QYdy860VitnMr47Qaf1AkSq99aR26JLq+PPCUXgZ1mb3daSGwhOOl6X1Jo4yTPa6stzHbMdFSSEyb+boHaUdlXI2nITv3pPmrk0bDUkdl6GctiIWRr9skL3OTRVEPdb8dnuDLPUumg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAkhxXHTRNfHaTnKUu8k5dP7r22BW1w+GKbZ24VTN80=;
 b=x8hrdf7Q4wQtYMeRxt1/AfBFcV5P5YUAnFFY2JcsDATbJKIL1nXIanl7/hjfn/pDv2xy0yK8/k+DsNvYVKPISjC9ghln4rQ6++Jc0cZ8diQahZ22Ah4BQVhf598F88yn6js5Q1gd0johlC2QMqFXIymdipnOs0VFRBGIxZeX32WBiB0eBRmD0YA5xBEhOg8e3Hvm418hI9PRBkmQWzmolL98jJJfKWaGkrC3mh6wivk/UUsw6AbphxYpZdfLw/iVi4U9CNhwXnfQkb91jOHfAayKgb3YWQuf+zdIeJj+e3/q4aUSHHFglGyuDQFqNliAh9TbZVhRc84gYq5IsDRbRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@nabladev.com>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>,
        <uli@fpond.eu>
Subject: [ANNOUNCE] Release v5.10.263-cip76
Thread-Topic: [ANNOUNCE] Release v5.10.263-cip76
Thread-Index: Ad0mJoaJjXoG/klGRhmUPti3Wt3qTA==
Date: Fri, 7 Aug 2026 08:24:39 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148181F92E68096A295922530CDD12@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYVPR01MB10862:EE_
x-ms-office365-filtering-correlation-id: 56054ce2-ddfb-4115-ecd1-08def45d52d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|56012099006|11063799006|3023799007|38070700021|6133799003|10067099003;
x-microsoft-antispam-message-info: 
 4rW95AQJmjt99xUXCMF2itnHNhcF382qXkJp72dncqNonvwNYJ9runS5iFbcck3ay9QUaPJBTaR4X/1dk/qBch+QLU1j6WG5t5YfTEYsYx4n37fgKljJk9OqIdCXYsrpvcsXK3k2dVtX15vFeB8Nlra2PHmTbEarNUkbaJ5Lt3gqphuFeW6IHp4q+tU1RpX+Ez0EMfBofo9psteTlKTubyMgrW2feAmoITVLkn5n/3RwOo5vwnuo4J4xJWSD2ot7BwocegGFblAYjELXb+KmJY32FfSDtTbbU+vemHXzlItkIvFTxyWbtYPUHmneuEkChmhRkQS6vFw6MaakbDHPNKXdYqlnJ1YoXAw3DtyOBCg+x9qTdpeFB6YcJ0h57n80Q1lijNyk9mLMncD2V24u4oOXGnlPTGR7jbu38SdVrEUdYEr1ki4qgHBUZgQmRrYKE5irLwKzpMoxuCLAxX8kPdjA4k92W4mZqaiNUFrYXcL7NOjkUedt4e/L1qXo2uLqniaFSqzPFapkqTmN9ZAajFUZ5sMZJkj0WNqfctyi0b2Jz2NqdTJXtdsZ9fhgyHbUnwrM7zlYR9tiFBhpQGkDSwYO45bRq8ITQgVV9hHEWVri+Dv7xJSvUv2Acutfuju1AaalGaAnbDD4hvZjCDR/pRnAn9hxfqtp/shxljr8WPeQdMdzVwebinvbUoKCgyJz78zZo5AYGTfDuk/K73FSgo9dL+WjyzJnD6sh03CjT9w=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(56012099006)(11063799006)(3023799007)(38070700021)(6133799003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SnI5ZFYydUMwVVNDV2dUTTVXOC9taXlrVy8rSm9kVEJac29Wd1pwNCs5?=
 =?iso-2022-jp?B?UjdXZFFnbXFWclZVU053RktYREErNmNxS200U0N0UUxvWGZIeml6ZzlL?=
 =?iso-2022-jp?B?b1NxZDh4aDFjYTVxZTRLZ2ZKVENONCsyazljTXRTamdkYStZT0JDS2pC?=
 =?iso-2022-jp?B?NUNYVUwrUFRZT29tREE3VmNFaWs0N2k0dSthKzB0L0pheFBpRUdkb3l1?=
 =?iso-2022-jp?B?RVN5RzZXUlVCOENLVmpiWTRzdjJpT2NESVExblBQU2piSm9NUS95aHRi?=
 =?iso-2022-jp?B?dS9TM004SHFRZm50NFU2Q2ZIcis1azNRcnVRazhVaHg2RWg0TXlUVkNF?=
 =?iso-2022-jp?B?dU9xSDVxNmNvR0lvR0s2OC9Td0ZXb0wyQWc2bDkvNlJtdnR1andRSVBj?=
 =?iso-2022-jp?B?cFNYUFdlNlZlN2FFYXV3MWZYL1R5c2dnWE90NE1RZUw4ZVg1QlFjQXBO?=
 =?iso-2022-jp?B?MHNWZ0NGMVVGQ1NZYnRQVmZuUk9kcnV6VFhzejhWRkZMSVZ1TWgyT0E4?=
 =?iso-2022-jp?B?SWhYMmt5VC9RMXRFTE1mR1ViOU5TN3oxQnJDcmdaT3RkSTBTZlVFek9h?=
 =?iso-2022-jp?B?MzJHNGdjTDR1TG9mWkplbU9JSzBjZVBXUUc3a2xENnNiYlZOMVBYYkli?=
 =?iso-2022-jp?B?RjVpelRsSzY2QWFrYlE1Tys4V1hWd05FU2tJZEJWQ0VXc2FmQmtNaHkr?=
 =?iso-2022-jp?B?RUQweWJ5WkE0T3FjUDk3RlhrOHBReEJZL0dmeHlhc1lxL0dDUk9RQUdM?=
 =?iso-2022-jp?B?andnS29Bem55VkcyWll0aS9EY3NzdUVGbGYwdFRuQkJCWFFLTUNPN1BS?=
 =?iso-2022-jp?B?U2NxVThQQzg5Qi9peDFPRUhQTGtkTEZYd0RQQUpHYkZmR0FZMHIvSVlX?=
 =?iso-2022-jp?B?VWEvaFZDYi80Q1FMQW5Hb3dMZGREc1VyZ0dPZHJlRUxDWHU2TXFrVmFI?=
 =?iso-2022-jp?B?RUNuZE82aGFudEJaZHVBdjdGbzVvZDhleVVtWmNEZVpOdzdKaUljdnVu?=
 =?iso-2022-jp?B?UXdOeFNEM3dycnRUSGhTSUlyNWZNVGV6RndyZEtoMS9QaHVmUWdkemc5?=
 =?iso-2022-jp?B?UmFncjJobUNNSW5QczM1ZVNwVlVHVVFyT0hTc0FFUW5kOVZFVmtWQ1la?=
 =?iso-2022-jp?B?WHRpUmc4dnRwR0tFc2RLamtuRmlEbCtuMEkrNjNnSWRQdkZkSDZYSGlt?=
 =?iso-2022-jp?B?Z3FBZnF0bThJdndSTUdLRHFteHlXZE1nNFc4a2xBMjNuY0NOZE1Tb2hz?=
 =?iso-2022-jp?B?RmVjbEM3bU5JbHNEZ0F6STFwMFBDdmhSUDhOUGE3UXZ6NTlLTHFBM3ZY?=
 =?iso-2022-jp?B?dENyN1lLU0lwNDBWbUNLemNGcStFL2xMYVo0QWQ4aTBlN0hNeWYwb3Zy?=
 =?iso-2022-jp?B?U2MzK0xsVGFiT3I3d2l4cXBzaFUzTithbnkyWk9WVFlkZmUrZG9PVmNa?=
 =?iso-2022-jp?B?dW9PVGxDQ0Y1SFppN2U2c2IvN3d5Z09CM2RsVWxLdUxTeXowem5QQzR3?=
 =?iso-2022-jp?B?S1JLSy82ZjlRRUpQcUZnT1FNS29XOW1IdzZmZTljN1dHdTFETW82clJE?=
 =?iso-2022-jp?B?VFVFemhwem1XMWlzTkdybVM0bHVZZ2wvUTl4WXVGYmgvM0FEa1pOM3Fa?=
 =?iso-2022-jp?B?bklFcml4cTA2RFpWS3BiUU5kaGxWVlhBNnp1U1dSTXFQMEFtd0J4WTR3?=
 =?iso-2022-jp?B?KzBVUmc1engvYzJTc2txdXJtTHlWT3dGNkxvZlJNS3MzRlhYcnZEOTMr?=
 =?iso-2022-jp?B?WStHMFlpOWFORm9IcGpRcm9XcE1FNWhlMTIyOU45UGlUT01RQUwwcjF5?=
 =?iso-2022-jp?B?dWRrQUJFbGxhVnNPQThmNHBDVDN2UVpWWVY5WFFHYytSS3Q2RDNFK1ds?=
 =?iso-2022-jp?B?bmU0TjZ6UjQyelBYbXR3TFFvZlZjdnpIVnpnNWdXQVhYOFpVb3hqU3NY?=
 =?iso-2022-jp?B?bWJsVzNqNGtYTzgyVjZCcnpWUTYvajJhQ0swbFBCUGhoTkpiSGlaTDZa?=
 =?iso-2022-jp?B?SXZQc3dQSXJhdjdDV3M2T2lkT2xkT09wbHlTY2lhU1BpM2gvNU41dkwv?=
 =?iso-2022-jp?B?MnRxc0prd29nS3ZqNGxzRnB6SXQwei84eGZEalRtSmFXMVozSlN1YnJJ?=
 =?iso-2022-jp?B?Tlc5YlVRZ3NGeGt5WWxyamZtYVRvUXVnNkJCdW5FVHRHVjFmQ1RaVVFQ?=
 =?iso-2022-jp?B?MEhXZ2U0UGYxcWRtQ244azlucGtsemZpRk1KV0VEdVlBeUp3dHNiYmg0?=
 =?iso-2022-jp?B?TmRJK21DOW1lTzcxMTNtbEtncmRYUzk5d0EvUkpvRUovcHZZRDBRU3E0?=
 =?iso-2022-jp?B?YkZwaTBtQTVDMTkrQnNrTXFjaFpPN1lUd1g0OWVFY0RDWSt3NjB3NURo?=
 =?iso-2022-jp?B?eWxuazk1anJ4OXIrWE43K0dCREQvcXpiMHNsZWNjcEFBVkhTVDBZeHVX?=
 =?iso-2022-jp?B?cmFwM0ZCRXlCNi9tT2VrU3pUZXJuRVFYS3BPZ3pMRC9MMUJkaXFzdHdH?=
 =?iso-2022-jp?B?a2x1TzY2OU1DMmdteVJxRno1YWoxUUliM0tabWRJMVh0b3ZvN1BKako3?=
 =?iso-2022-jp?B?L2s1Rkk4VT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	S5p2FGWMhCxXoQoWUlONs7FyDbW6N/akQKfni8O/9PkbNVSXQT5zjQWX+/I6Y0qOLcQAsSM9TQg3aRJ27A+/R98lwdBZ9eophTOZw+Iq6TqItyVnD3grSxHtwUU6gZ3ra/QVpvZz4/zjLaVuyrfDMunLZvhsqiz2KosuFJAdRlecApixQZTzSz5UFJUbOSC06W5sg/y0gL7a3Fz8sw3ht/qEAsn6Tf/X9dGeijr4loPHsxo+BLS9QtBNg9BGW15L/kJaoNTAGbBDyCUU89Xq4jY2my5I2kF0EKFiJ8D/pYQuAkypIonuzZDOFBLpF6GBEWxOyxfWJ84iPqKeyOtXUA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56054ce2-ddfb-4115-ecd1-08def45d52d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 08:24:39.1288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y9GDYvNmtq8/N3lAKfZIOZeDIBCKlm64rMeKnvg/MBiXcGz28Hz8Nai+3InveoVLA5k9Hj9zXu98pRNK4VUdGE8CD96D0grhFnUsNjNr/TOV00bFNifa/snKbzkTC8pL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10862
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Aug 2026 08:24:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23873

Hi all,

CIP kernel team has released Linux kernel v5.10.263-cip76.
The linux-5.10.y-cip tree has been updated base version from v5.10.260 to v=
5.10.263.
This release includes updates to the USB and SDHI drivers for Renesas ARM64=
 RZ
G2 SoCs.

Information about this release is as follows:

  v5.10.263-cip76:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      50209760a3646d8afaca26d50ca2834df369ade9
    fixed CVEs:
      CVE-2022-0742: A memory leak flaw was found in the Linux kernel=1B$B!=
G=1B(Bs ICMPv6 networking protocol, in ...
      CVE-2022-3114: Kernel: Unchecked kcalloc return leads to null pointer=
 dereference.
      CVE-2022-48785: ipv6: mcast: use rcu-safe version of ipv6_get_lladdr(=
)
      CVE-2022-49662: ipv6: fix lockdep splat in in6_dump_addrs()
      CVE-2023-52494: bus: mhi: host: Add alignment check for event ring re=
ad pointer
      CVE-2024-26631: ipv6: mcast: fix data-race in ipv6_mc_down / mld_ifc_=
work
      CVE-2024-27390: ipv6: mcast: remove one synchronize_net() barrier in =
ipv6_mc_down()
      CVE-2025-38550: ipv6: mcast: Delay put pmc->idev in mld_del_delrec()
      CVE-2026-31499: Bluetooth: L2CAP: Fix deadlock in l2cap_conn_del()
      CVE-2026-43216: net: Drop the lock in skb_may_tx_timestamp()
      CVE-2026-43499: rtmutex: Use waiter::task instead of current in remov=
e_waiter()
      CVE-2026-46116: xfrm: defensively unhash xfrm_state lists in __xfrm_s=
tate_delete
      CVE-2026-46135: nvmet-tcp: fix race between ICReq handling and queue =
teardown
      CVE-2026-52942: netfilter: nf_log: validate MAC header was set before=
 dumping it
      CVE-2026-53163: locking/rtmutex: Skip remove_waiter() when waiter is =
not enqueued
      CVE-2026-53392: NFSv4/flexfiles: reject zero filehandle version count
      CVE-2026-53393: nfsd: reset write verifier on deferred writeback erro=
rs
      CVE-2026-53399: nfsd: release layout stid on setlease failure
      CVE-2026-53400: i2c: core: fix adapter registration race
      CVE-2026-53402: fbdev: fbcon: fix out-of-bounds read in err_out of fb=
con_do_set_font()
      CVE-2026-63803: hdlc_ppp: sync per-proto timers before freeing hdlc s=
tate
      CVE-2026-63806: KVM: Replace guest-triggerable BUG_ON() in ioeventfd =
datamatch with get_unaligned()
      CVE-2026-63815: f2fs: bound i_inline_xattr_size for non-inline-xattr =
inodes
      CVE-2026-63818: f2fs: validate orphan inode entry count
      CVE-2026-63827: apparmor: fix use-after-free in rawdata dedup loop
      CVE-2026-63828: apparmor: mediate the implicit connect of TCP fast op=
en sendmsg
      CVE-2026-63829: net: ip_gre: require CAP_NET_ADMIN in the device netn=
s for changelink
      CVE-2026-63830: net: skmsg: preserve sg.copy across SG transforms
      CVE-2026-64189: netfilter: ipset: fix race between dump and ip_set_li=
st resize
      CVE-2026-64206: Bluetooth: L2CAP: cancel pending_rx_work before takin=
g conn->lock
      CVE-2026-64266: fuse: re-lock request before returning from fuse_ref_=
folio()
      CVE-2026-64268: RDMA/siw: bound Read Response placement to the RREAD =
length
      CVE-2026-64271: Input: touchwin - reset the packet index on every com=
plete packet
      CVE-2026-64273: Input: iforce - bound the device-reported force-feedb=
ack effect index
      CVE-2026-64274: Input: goodix - clamp the device-reported contact cou=
nt
      CVE-2026-64275: Input: elan_i2c - prevent division by zero and arithm=
etic underflow
      CVE-2026-64276: Input: synaptics-rmi4 - bound the F30 keymap to the G=
PIO/LED count
      CVE-2026-64277: Input: synaptics-rmi4 - bound the F3A keymap to the G=
PIO count
      CVE-2026-64296: exfat: bound uniname advance in exfat_find_dir_entry(=
)
      CVE-2026-64298: NFSv4: include MAY_WRITE in open permission mask for =
O_TRUNC
      CVE-2026-64299: tracing: Prevent out-of-bounds read in glob matching
      CVE-2026-64303: spi: fsl-lpspi: terminate the RX channel on TX prepar=
e failure path
      CVE-2026-64304: crypto: qat - validate RSA CRT component lengths
      CVE-2026-64306: crypto: drbg - Fix returning success on failure in CT=
R_DRBG
      CVE-2026-64312: crypto: pcrypt - restore callback for non-parallel fa=
llback
      CVE-2026-64313: crypto: ecc - Fix carry overflow in vli multiplicatio=
n
      CVE-2026-64315: crypto: caam - use print_hex_dump_devel to guard key =
hex dumps
      CVE-2026-64316: crypto: caam - use print_hex_dump_devel to guard key =
hex dumps
      CVE-2026-64317: isofs: bound Rock Ridge symlink components to the SL =
record
      CVE-2026-64318: partitions: aix: bound the pp_count scan to the ppe a=
rray
      CVE-2026-64322: udf: validate sparing table length as an entry count,=
 not a byte count
      CVE-2026-64323: udf: validate VAT header length against the VAT inode=
 size
      CVE-2026-64324: udf: validate free block extents against the partitio=
n length
      CVE-2026-64329: usb: typec: ucsi: ccg: Fix use-after-free of ucsi on =
remove
      CVE-2026-64330: usb: typec: tcpm: Validate SVID index in svdm_consume=
_modes()
      CVE-2026-64331: usbip: vudc: fix NULL deref in vep_dequeue()
      CVE-2026-64332: USB: ulpi: fix memory leak on registration failure
      CVE-2026-64333: USB: serial: digi_acceleport: fix write buffer corrup=
tion
      CVE-2026-64334: USB: serial: digi_acceleport: fix hard lockup on disc=
onnect
      CVE-2026-64335: USB: serial: digi_acceleport: fix broken rx after thr=
ottle
      CVE-2026-64337: usb: mtu3: unmap request DMA on queue failure
      CVE-2026-64338: USB: misc: uss720: unregister parport on probe failur=
e
      CVE-2026-64340: USB: legousbtower: fix use-after-free on disconnect r=
ace
      CVE-2026-64342: USB: iowarrior: fix use-after-free on disconnect
      CVE-2026-64343: USB: ldusb: fix use-after-free on disconnect race
      CVE-2026-64344: USB: idmouse: fix use-after-free on disconnect race
      CVE-2026-64345: usb: gadget: f_printer: take kref only for successful=
 open
      CVE-2026-64347: usb: gadget: composite: fix dead empty check in the U=
SB_DT_OTG handler
      CVE-2026-64348: usb: free iso schedules on failed submit
      CVE-2026-64351: net: usb: kalmia: bound RX frame length in kalmia_rx_=
fixup()
      CVE-2026-64359: nilfs2: reject CLEAN_SEGMENTS ioctl with out-of-range=
 segment numbers
      CVE-2026-64360: hfs/hfsplus: zero-initialize buffer in hfs_bnode_read
      CVE-2026-64361: hfs/hfsplus: fix u32 overflow in check_and_correct_re=
quested_length
      CVE-2026-64362: HID: lg-g15: cancel pending work on remove to fix a u=
se-after-free
      CVE-2026-64363: HID: appleir: fix UAF on pending key_up_timer in remo=
ve()
      CVE-2026-64364: HID: multitouch: fix out-of-bounds bit access on mt_i=
o_flags
      CVE-2026-64370: posix-cpu-timers: Fix pid refcount leak in do_cpu_nan=
osleep() error path
      CVE-2026-64371: proc: protect ptrace_may_access() with exec_update_lo=
ck (part 1)
      CVE-2026-64372: cpufreq: pcc: fix use-after-free and double free in _=
OSC evaluation
      CVE-2026-64373: cpufreq: Fix hotplug-suspend race during reboot
      CVE-2026-64374: sched/rt: Have RT_PUSH_IPI be default off for non PRE=
EMPT_RT
      CVE-2026-64375: proc: protect ptrace_may_access() with exec_update_lo=
ck (FD links)
      CVE-2026-64378: writeback: fix race between cgroup_writeback_umount()=
 and inode_switch_wbs()
      CVE-2026-64379: smb: client: mask server-provided mode to 07777 in mo=
defromsid
      CVE-2026-64380: smb: client: harden POSIX SID length parsing
      CVE-2026-64381: smb: client: Fix next buffer leak in receive_encrypte=
d_standard()
      CVE-2026-64403: Bluetooth: L2CAP: validate option length before readi=
ng conf opt value
      CVE-2026-64406: Bluetooth: fix UAF in bt_accept_dequeue()
      CVE-2026-64408: Bluetooth: bnep: pin L2CAP connection during netdev r=
egistration
      CVE-2026-64411: netfilter: ebtables: terminate table name before find=
_table_lock()
      CVE-2026-64412: netfilter: ebtables: module names must be null-termin=
ated
      CVE-2026-64413: netfilter: ebtables: zero chainstack array
      CVE-2026-64420: mfd: cros_ec: Delay dev_set_drvdata() until probe suc=
cess
      CVE-2026-64422: net: ipv4: bound TCP reordering sysctl writes and MTU=
 probe sizes
      CVE-2026-64423: ipv4: igmp: remove multicast group from hash table on=
 device destruction
      CVE-2026-64425: io_uring/io-wq: re-check IO_WQ_BIT_EXIT for each link=
ed work item
      CVE-2026-64429: gpio: eic-sprd: use raw_spinlock_t in the irq startup=
 path
      CVE-2026-64435: audit: Fix data races of skb_queue_len() readers on a=
udit_queue
      CVE-2026-64436: net: af_key: initialize alg_key_len for IPComp states
      CVE-2026-64438: crypto: qat - fix VF2PF work teardown race in adf_dis=
able_sriov()
      CVE-2026-64442: staging: rtl8723bs: fix OOB reads in IE loops in issu=
e_assocreq() and join_cmd_hdl()
      CVE-2026-64445: staging: rtl8723bs: fix WEP length underflow and OOB =
read in OnAuth()
      CVE-2026-64446: staging: rtl8723bs: fix heap buffer overflow in rtw_c=
fg80211_set_wpa_ie()
      CVE-2026-64448: smb: client: restrict implied bcc[0] exemption to res=
ponses without data area
      CVE-2026-64450: tipc: fix out-of-bounds read in broadcast Gap ACK blo=
cks
      CVE-2026-64452: 6lowpan: fix NHC entry use-after-free on error path
      CVE-2026-64455: USB: chaoskey: Fix slab-use-after-free in chaoskey_re=
lease()
      CVE-2026-64456: hwrng: virtio: clamp device-reported used.len at copy=
_data()
      CVE-2026-64461: PCI: mediatek: Fix IRQ domain leak when port fails to=
 enable
      CVE-2026-64462: PCI: altera: Fix resource leaks on probe failure
      CVE-2026-64465: usb: xhci: Fix sleep in atomic context in xhci_free_s=
treams()
      CVE-2026-64468: binder: fix UAF in binder_free_transaction()
      CVE-2026-64469: binder: fix UAF in binder_thread_release()
      CVE-2026-64470: Bluetooth: btusb: fix use-after-free on marvell probe=
 failure
      CVE-2026-64471: Bluetooth: btusb: fix use-after-free on registration =
failure
      CVE-2026-64475: vfio/pci: Release the VGA arbiter client on register_=
device() failure
      CVE-2026-64478: ALSA: usb-audio: avoid kobject path lookup in DualSen=
se match
      CVE-2026-64483: ALSA: firewire: isight: bound the sample count to the=
 packet payload
      CVE-2026-64484: ALSA: es1938: check snd_ctl_new1() return value
      CVE-2026-64487: ALSA: caiaq: fix out-of-bounds read in the Traktor Ko=
ntrol S4 input parser
      CVE-2026-64488: ALSA: aoa: check snd_ctl_new1() return value
      CVE-2026-64494: iio: light: gp2ap002: fix runtime PM leak on read err=
or
      CVE-2026-64495: iio: gyro: bmg160: bail out when bandwidth/filter is =
not in table
      CVE-2026-64496: iio: event: Fix event FIFO reset race
      CVE-2026-64497: iio: chemical: scd30: Cleanup initializations and fix=
 sign-extension bug
      CVE-2026-64500: iio: adc: lpc32xx: Initialize completion before reque=
sting IRQ
      CVE-2026-64503: iio: accel: kxsd9: fix runtime PM imbalance on write_=
raw() error
      CVE-2026-64504: iio: accel: bmc150: clamp the device-reported FIFO fr=
ame count
      CVE-2026-64505: usb: gadget: function: rndis: add length check for he=
ader
      CVE-2026-64510: ACPI: NFIT: core: Fix acpi_nfit_init() error cleanup
      CVE-2026-64514: userfaultfd: gate must_wait writability check on pte_=
present()
      CVE-2026-64534: nvmet-tcp: check INIT_FAILED before nvmet_req_uninit =
in digest error path
      CVE-2026-64538: ipv6: Fix null-ptr-deref in fib6_nh_mtu_change().
      CVE-2026-64540: usbnet: gl620a: fix out-of-bounds read in genelink_rx=
_fixup()
      CVE-2026-64541: net/smc: fix UAF in smc_cdc_rx_handler() by pinning t=
he socket
      CVE-2026-64544: crypto: asymmetric_keys - fix OOB read in pefile_dige=
st_pe_contents
      CVE-2026-64546: drm/edid: fix OOB read in drm_parse_tiled_block()
      CVE-2026-64547: net: usb: net1080: validate packet_len before pad-byt=
e access in rx_fixup
      CVE-2026-64548: bpf, sockmap: reject overflowing copy + len in bpf_ms=
g_push_data()
      CVE-2026-64549: Bluetooth: bpa10x: avoid OOB read of revision string =
in bpa10x_setup()
      CVE-2026-64550: net: qualcomm: rmnet: validate MAP frame length befor=
e ingress parsing
      CVE-2026-64551: sctp: validate STALE_COOKIE cause length before readi=
ng staleness
      CVE-2026-64553: net: psample: fix info leak in PSAMPLE_ATTR_DATA
      CVE-2026-64554: netfilter: bridge: fix stale prevhdr pointer in br_ip=
6_fragment()
      CVE-2026-64589: i2c: core: fix NULL-deref on adapter registration fai=
lure
      CVE-2026-64593: btrfs: do not trim a device which is not writeable
      CVE-2026-64594: usb: gadget: f_fs: initialize reset_work at allocatio=
n time
      CVE-2026-64599: crypto: amlogic - avoid double cleanup in meson_crypt=
o_probe()
      CVE-2026-64602: iio: adc: spear: Initialize completion before request=
ing IRQ
      CVE-2026-64604: KVM: VMX: Grab vmcs12 on CR8 interception update iff =
vCPU is in guest mode
      CVE-2026-64560: posix-cpu-timers: Prevent UAF caused by non-leader ex=
ec() race
    added commits:
      CIP: Bump version suffix to -cip76 after merge from stable
      usb: renesas: Suppress binding attributes
      arm64: dts: renesas: rzg3s-smarc: Enable USB support
      arm64: dts: renesas: r9a08g045: Add USB support
      phy: renesas: rcar-gen3-usb2: Add suspend/resume support
      phy: renesas: rcar-gen3-usb2: Move phy_data->init_bus check
      phy: renesas: rcar-gen3-usb2: Fix an error handling path in rcar_gen3=
_phy_usb2_probe()
      phy: renesas: rcar-gen3-usb2: store drvdata pointer in channel
      phy: renesas: rcar-gen3-usb2: Add support for the RZ/G3S SoC
      phy: renesas: rcar-gen3-usb2: Add support to initialize the bus
      dt-bindings: phy: renesas,usb2-phy: Mark resets as required for RZ/G3=
S
      dt-bindings: phy: renesas,usb2-phy: Document RZ/G3S phy bindings
      usb: renesas_usbhs: Assert/de-assert reset signals on suspend/resume
      dt-bindings: usb: renesas,usbhs: Document RZ/G3S SoC
      usb: host: ohci-platform: Call reset assert/deassert on suspend/resum=
e
      usb: host: ehci-platform: Call reset assert/deassert on suspend/resum=
e
      usb: host: Do not check priv->clks[clk]
      reset: rzg2l-usbphy-ctrl: Check pwrrdy is valid before using it
      reset: rzg2l-usbphy-ctrl: Add suspend/resume support
      reset: rzg2l-usbphy-ctrl: Propagate the return value of regmap_field_=
update_bits()
      reset: rzg2l-usbphy-ctrl: Fix a NULL vs IS_ERR() bug in probe
      reset: rzg2l-usbphy-ctrl: Add support for RZ/G3S SoC
      dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document RZ/G3S suppor=
t
      reset: rzg2l-usbphy-ctrl: Add support for USB PWRRDY
      pinctrl: renesas: rzg2l: Add suspend/resume support for pull up/down
      pinctrl: renesas: rzg2l: Add support for pull-up/down
      clk: renesas: rzg2l: Deassert reset on assert timeout
      clk: renesas: r9a08g045: Add clocks, resets and power domains for USB
      arm64: dts: renesas: r9a07g054: Add max-frequency to SDHI nodes
      arm64: dts: renesas: r9a07g044: Add max-frequency to SDHI nodes
      arm64: dts: renesas: r9a07g044: Rename SDHI clocks
      arm64: dts: renesas: r9a07g043: Add max-frequency to SDHI nodes

Best regards,
  Nobuhiro


