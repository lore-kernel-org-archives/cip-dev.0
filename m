Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB61C43458
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 07:14:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.86884.1782717253345758212
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2026 00:14:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=AFEe/qob;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1782717241;x=1783926841;bh=
	q5//P2R0JUvdfODnexWJSmHvEitgVjb5ngNuYNV0MX8=;b=AFEe/qobnzA7yLbXQeEiqlD3eKCRls
	+fTZwKQGCxq52RlrJByOlqj/gFwNA46JIt2n3sXFUro+Cdj0dMJo9jZOSGc5zV82y0rYDGZqklYAx
	Pw7r6oSZCVDVp/dhzqUUi+qovyAgsW0OcApUzFSuLY1AzYBwZMZFwHyQ0+b3ke1GSHxCbY63uwVWC
	8YVEOaBoS3gV2qsMozFw2rEFUAd2sdU/MgZjS4KpEUk3HinldigKU4Kl+HLGZ1nQCs0Dmug2ut4ra
	w0Xiuhqg59OHkoyvfvQTK3hJQ/gZqqDLB/dl8vaiQw83K6hawHWwV6TWT+dkKlTV67jstQN5ctFoK
	6pKQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 65T7E09w1718031; Mon, 29 Jun 2026 16:14:00 +0900
X-Iguazu-Qid: 2yAar7SANPMl6Tiv2n
X-Iguazu-QSIG: v=2; s=1; t=1782717240; q=2yAar7SANPMl6Tiv2n; m=CpA9ecaZYUV+4bc93jaJK/dmeMmuvvNTIdtFffIMmO4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gpcvq59hHz1xnZ; Mon, 29 Jun 2026 16:13:59 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNjdVym267Bgp94kLPaygSgLeRDueSKNluMFqTW41gM15r1Non/Z2bxEkscOtTdmMq+j5iytRztfVjFnFl6TAcwhL5qnDxatj3rdcqGbbo6YOh/MW555tEL5TN7gLS8msFuzOgzRKWOBZ9nP8CRgMZiX2J+Y0xzFSQUN3O/mzi1STCsMU37i2uk6YCQyGduDoYUdomEX/3U7YjDHErJaZ5GwnV4xJT+J5H877xZgG7WxUu+9TNzqjOi3VOt6zSjrvBXvZISAbONMg7NXJWN9Dy3CeLlonCz52jjNiKSb1BHwbRleh2QlGg7SwGmrtvYPQ6hFV18vlNa4rl9C/a3DYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s78XUpkSB/4fqJ02QKRvzWFDso20JeJIcjNOrGJ3FxE=;
 b=PNBQ45t3Jcobi2Z7zajaGcHof6pU92fwaKhLbP62Tchj2ljZ/bId7Xd9qYfrNJ1CrQBtD5wsMRKEW3aHdEeUVndyU34kCySQV1x7Fk17Ls1zc9I6heYAID9gDABMwgaegPlY3R9zI2Mch7ClZgT6xkyK7HUkT3Ue0ZoGstQ9fBYiSpXmaa+/ZoHBBiqN7tITT8/foHJbjtXKJQJtXDapeGMtiRZKGA00dRDLJ77K5mtQnVfDbgmwEpg8bk3ZCuEYe6qAEBKuNC26lmFdD6VWGZ62M/UyMCSHKTeWxcNdWi4RdNZyvHVRmfsKlCO2z2tRtb+VS26yqBfN6QSZtjvOEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@nabladev.com>, <jan.kiszka@siemens.com>,
        <chris.paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>,
        <uli@fpond.eu>
Subject: [ANNOUNCE] Release v6.12.94-cip26
Thread-Topic: [ANNOUNCE] Release v6.12.94-cip26
Thread-Index: AQHdB5aqYRVBVyeyZkCbmaUii+TAYg==
Date: Mon, 29 Jun 2026 07:13:57 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148182221920022BF486B0A89CDE82@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY4PR01MB14006:EE_
x-ms-office365-filtering-correlation-id: 96457a19-56ca-4f23-c26d-08ded5adfc7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|11063799006|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info: 
 OB7IQznBkC14evV7/QUV388Amod2Wtl7sKspgMqpcrn2e9TfdRQU8gugHeGiWeLdRxGZCwCGJthiKc9hqiU0Fo631KZZKBYbKsoinyGDKUa5ReoY+CC0bHAqkUMmPizkZVI0AfQ71aFwyzf39xRu7LkIfhdcy9y/c40ci/tFs62HxQMdWSk+5BO60aKTf4HBxdNTFgk2m/6m0WAh6ShurLCMRXQiZx7yVOioMrYJBhAKQSXQnfslHC1Y4L7y8GGzm3FkitpdmxeGWPxllwNsXYCTCJzTvH5VRswiPsXkK1b2MM4KDSZFb4lRK4Z/0wbX7ookDEHQ09uWCVhGE1DaTDlDhw41n7r3qVL3wvBM1Mh/5tHN4OvnRrgaP/dc4GZULGAseb+ufHl+QSAlsY3EZ3gnfpMMyJQx9FxfiTmQyiOxs5hmZmDzRE4iQi4F6BPqL0yaYlfsXPLg3JO2MKmEFXYV8Dw+ZSpI9S5K/1IGpNIOhlCvX5ufhKQ8KyycTNKMsuHGjyvGPNB11X5lzqvVlyAE454DxpXYQGbisQj68ErS0eiGy2LwQnmhR1ylpt8+zEEkhHh65ze8QLTEcAk/5CPt/VGtFqSnIMV1FyrdcZy+1234F9yRFk1U0iKd7UQIrl1pfugT/Wn2RetA4DCAEc0Flx1+Q/EQJK1hl7S0/Swo5+CLpgBfNzCn9J/BXWGxGc1sYduDNP7qXuLxz9weRdcB1mU9KDUyMzfGyhQHxaM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(11063799006)(18002099003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OEpRQTdiYW05ZVJqL0lVU2IrOUNTNHVFRkhxb1RydlI0M0pFNTh5M1Ru?=
 =?iso-2022-jp?B?K0VDc2RSUGVzUWphK0FUS2lJR1RnZjc5M1JNQ0pKUkxwR1VGUEdTWnZU?=
 =?iso-2022-jp?B?eFMzdDNjTGo1K1VjV1BhNUpkYk5xTzNCN2tKUTFlUWs0WkFmYmhiY0J1?=
 =?iso-2022-jp?B?bVBhNzR6OXh4aDNXUzJlOHFMSGphUGNmNGxXZzkzL01KMFRseEpLUkx6?=
 =?iso-2022-jp?B?QnI1RFJkeDc0Ly9Pd3dLazdWWU9tMWVBU0hsbzVTdy9FNisxakVlTnlK?=
 =?iso-2022-jp?B?MjNDdXlMMis4aG1LS1Jrei9sTlNqTnpLbUVqay9hUTVQOUJxYTJRMFdV?=
 =?iso-2022-jp?B?akZyNFRhTHhqWkVScWltMEV0NkpSVVhHR2h2Y1M3RW5kOUlDSFUrRkZi?=
 =?iso-2022-jp?B?Y1l6cFovblVxNmN6bnRkU01wTk85UGpVODNqUGI4ZTNFZUNRZVdwTTZZ?=
 =?iso-2022-jp?B?RXIwT1kvUWF3dFN2RlVYZE9WelA4SGNKT2hmYjkvTkFNY3dNbXdib3p1?=
 =?iso-2022-jp?B?Z2pWVUpMVEViSGwvUXFNL3lGbHFXRnFSUTlCcWxWWkFpdnVXZDk5THpy?=
 =?iso-2022-jp?B?V2N4ZUMza3lXRUNjR2Z6eFVGZFFURm1qV2R2VnpWQkJtQnpHTlhHVkFQ?=
 =?iso-2022-jp?B?QTY0ZG55SFdidTFFMzJDM2dSemZKNitSZlFvTThXcU9KaWg2WUlBS3Bu?=
 =?iso-2022-jp?B?czNSVThUcXpWK09vcjVEVUU4L25ER21iQU9xUWJ3YWlSUFRzY2JsSzJx?=
 =?iso-2022-jp?B?NHJ3NXErU3BHMkkxM0M1ek81TTlYVzZ4M2xCaWN1N3Y2dHNxL2FVUE9l?=
 =?iso-2022-jp?B?TlpobkZaVEUxVXBGS3FpbkZKdUxJbzUxSmxKcWNabW1CV0lYQVRPdXhC?=
 =?iso-2022-jp?B?Y1hiODY1WkV4elMwSk54dDk2ckNDRndhNjZtc2orWEYzZzhVSktVRDFZ?=
 =?iso-2022-jp?B?Qm9Ja2hkYkFrQmpwSjNvU3d4RlZLY0szOFhZbDBHNmlNOFBzVnY0Vk9B?=
 =?iso-2022-jp?B?TStFMWhwTlBHdlJRemZJdjUvT2ZtcWlLRHh2a05nN2l4MzQ5WTVZSVJE?=
 =?iso-2022-jp?B?NXdNZk5jZEFET0xUcit6djJyOWdBT05wbVo4bmRiNERRZFhSNDJlZGI1?=
 =?iso-2022-jp?B?UWJzM2xHTEdjditvOVpXQ2Y5Q1l6aWM1RlZxK2t3em11WDBRRkxHRUJm?=
 =?iso-2022-jp?B?YUhRY0ttcXg1NFFxWS8yM0w3eVZDWEZIeUxycWh6eC9VRUlNS0hBWHlk?=
 =?iso-2022-jp?B?V0NNUEhjS1U4NE85b2xvOThER2dVWW5wVm5HRGlrTlpFZWlUblcrRHBs?=
 =?iso-2022-jp?B?ZkMybTVmb3FQS2d5bFh4MjFkZGowNXpMRnJUd3YrZXdVazZTMGFXMGFB?=
 =?iso-2022-jp?B?KzlOUXlobUZVaERTL1F1S2x1TGZoU2xsRjNDa1RQcTEydmNFVWFsTFNF?=
 =?iso-2022-jp?B?R0dtNFZzQUU1RzNOZ05QWlhlOUhFS3NCaXV5VnVuaXpiZWIxV054RGlw?=
 =?iso-2022-jp?B?UUdJeGptTWdyVDluK3B1UGw3dkZXYWJiZDNFRkdZYnp0aW10bkFpU2dV?=
 =?iso-2022-jp?B?ZFV6eDVYMHgxSFBsQUt2dWJoOTNLemZ2SFJDRTBKMC82MzBEeWo5a1Rp?=
 =?iso-2022-jp?B?ZEtLdUkyYnBRUzBCUC80WE1tMDA0RWxnZmVTc2NjR1Q0QjlDRTdFL1F4?=
 =?iso-2022-jp?B?cTU5MXVHbkxIT1RwdzRMVTVaZ3loU2xnT1g3TytwSTdyQlV4RTQ4djQ2?=
 =?iso-2022-jp?B?dWUyaWwycHU4WUFXMUU4MlZJR0x5Q3UxdldaRG1YZUhsdjUvZlh0c0hs?=
 =?iso-2022-jp?B?WTVtYTliamZRZzMvVXpVM2Ixc2NZU3d6dXJIdzlKWUY5c1kxcndlVlJG?=
 =?iso-2022-jp?B?bm9RVHZsZWV4QmxQR3FNNzd4V1V0RTEwdTNiUUlRSUkvNDU3bXI2ZzBO?=
 =?iso-2022-jp?B?M2ZXb2ZOb0tSVlZkN1hWZldxVllqamlFY0tqakY0elZRWGRuZkw3dkEr?=
 =?iso-2022-jp?B?RzVrZlhzVWFBdHN0azhuRWp1b1BhQUd0dHdJNjY0d0RDSzNDMDB0a3Br?=
 =?iso-2022-jp?B?bXdCWElDVzhSZjc2dE9qdnNQb20ra3lCUXovdXVqc3pNNVg0c3JEVXpk?=
 =?iso-2022-jp?B?Y1F1ZVJhVlN0a0dhUTdURzVvYmVlK0FxYzRPVzY4VnRWci9XSVdoOXFE?=
 =?iso-2022-jp?B?Ni9ZTHdIMEhtdTN1NUYyVnpTNERoYkpwWUFDTWRwQ0RGclNpYmx4eGQ5?=
 =?iso-2022-jp?B?NWVkK0FxTk1YdWxxdnQrOTYvMTgxaEM4a0RlcXp2dHJJa3drbGRoTTZh?=
 =?iso-2022-jp?B?UitzV2FZT0dvUGpISEwxOFQzM01qM2JXckR4NDFscEttanNEOVhLZ1hK?=
 =?iso-2022-jp?B?c25WVlFwUzZIS0l0eUZrYzUrV1NyU1ArOW96a3MzMFRvMWpzV3dsSnc4?=
 =?iso-2022-jp?B?K1BBRVVIU2VneTdhdzBzN2FndjFzQlBUcWZxam1zY3FFcno1K3UxL1Vi?=
 =?iso-2022-jp?B?enlKRk1taytjNEtoQVhCWFAvcDNzUmxyb01idGsvWG9BOFlmYTM1aC9W?=
 =?iso-2022-jp?B?TkVsZGhBUT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	Sv4rllUE23dW/frQ1Ep71IWDKy/1cHnBfd8jc8Vfc9KJPkvm5G32IuO8neJKYVxIpNlLH5erKTKMS4S0BBgkz2vqizDQHCtq5B6VUF0JYG8rI6DvbFQ6NmXEWi9GKYMMljfvzcq3H+2cMxEtnO5Xya3+5tkhNyQtKo7JU9AfHefIriWEOzkV1caydHjRaiuAj2ISddSN8bLuIO5q5PoYZnhlRNqaJNhsIkHFY4vkf+dEA2Cuu52sE2UIT5xu0V4rrqKGTUUTqtzL2nKID7WvU6/5Sd86wGgIaAVFPu+iI3R9WPFqe290Uspmd3SKCd8Kdx5RM42BZ/HnJou7d6bcBQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96457a19-56ca-4f23-c26d-08ded5adfc7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 07:13:57.4980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0M4+Fn4Z9W5Ed/8Qqhb2yGXwPtOrJ+t9zD3xKxSd3drlR7rBvxv5irtVDY/uNSLxOK+BZchF8lUNRUR7L2LhyNo3vE4hiMqvbmNn+0jTlTGmxJfs1zbosmPWGWgCVuGW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14006
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2026 07:14:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23297

Hi all,=0A=
=0A=
CIP kernel team has released Linux kernel v6.12.94-cip26.=0A=
The linux-6.12.y-cip tree has been updated base version from v6.12.92 to v6=
.12.94.=0A=
This release also includes the RSPI patch for Renesas ARM SoCs.=0A=
=0A=
Information about this release is as follows:=0A=
=0A=
  v6.12.94-cip26:=0A=
    repository:=0A=
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git=0A=
    branch:=0A=
      linux-6.12.y-cip=0A=
    commit hash:=0A=
      e00178e6fe853ac0059d15909043e0fd5c19ece9=0A=
    fixed CVEs:=0A=
      CVE-2025-68768: inet: frags: flush pending skbs in fqdir_pre_exit()=
=0A=
      CVE-2026-23346: arm64: io: Extract user memory type in ioremap_prot()=
=0A=
      CVE-2026-43219: net: cpsw_new: Fix potential unregister of netdev tha=
t has not been registered yet=0A=
      CVE-2026-43303: mm/page_alloc: clear page->private in free_pages_prep=
are()=0A=
      CVE-2026-43331: x86/kexec: Disable KCOV instrumentation after load_se=
gments()=0A=
      CVE-2026-45930: net: mctp: ensure our nlmsg responses are initialised=
=0A=
      CVE-2026-46316: KVM: arm64: vgic-its: Drop the translation cache refe=
rence only for the erased entry=0A=
      CVE-2026-46321: tun: free page on short-frame rejection in tun_xdp_on=
e()=0A=
      CVE-2026-46322: tun: free page on build_skb failure in tun_xdp_one()=
=0A=
      CVE-2026-52913: batman-adv: v: stop OGMv2 on disabled interface=0A=
      CVE-2026-52923: ipc: limit next_id allocation to the valid ID range=
=0A=
      CVE-2026-52927: netfilter: ebtables: fix OOB read in compat_mtw_from_=
user=0A=
      CVE-2026-52934: batman-adv: tvlv: reject oversized TVLV packets=0A=
      CVE-2026-52943: net: skbuff: fix missing zerocopy reference in pskb_c=
arve helpers=0A=
      CVE-2026-53080: net/sched: cls_fw: fix NULL dereference of "old" filt=
ers before change()=0A=
      CVE-2026-23247: tcp: secure_seq: add back ports to TS offset=0A=
      CVE-2026-31663: xfrm: hold dev ref until after transport_finish NF_HO=
OK=0A=
      CVE-2026-31703: writeback: Fix use after free in inode_switch_wbs_wor=
k_fn()=0A=
      CVE-2026-43116: netfilter: ctnetlink: ensure safe access to master co=
nntrack=0A=
      CVE-2026-45850: ipvs: skip ipv6 extension headers for csum checks=0A=
      CVE-2026-46203: spi: cadence-quadspi: fix unclocked access on unbind=
=0A=
      CVE-2026-46320: tap: free page on error paths in tap_get_user_xdp()=
=0A=
      CVE-2026-46331: net/sched: fix pedit partial COW leading to page cach=
e corruption=0A=
      CVE-2026-52908: RDMA: During rereg_mr ensure that REREG_ACCESS is com=
patible=0A=
      CVE-2026-52910: bpf: Free reuseport cBPF prog after RCU grace period.=
=0A=
      CVE-2026-52917: sctp: diag: reject stale associations in dump_one pat=
h=0A=
      CVE-2026-52924: sctp: purge outqueue on stale COOKIE-ECHO handling=0A=
      CVE-2026-52929: sctp: stream: fully roll back denied add-stream state=
=0A=
      CVE-2026-52930: ipc/shm: serialize orphan cleanup with shm_nattch upd=
ates=0A=
      CVE-2026-52935: xfrm: espintcp: do not reuse an in-progress partial s=
end=0A=
      CVE-2026-52939: net/rds: fix NULL deref in rds_ib_send_cqe_handler() =
on masked atomic completion=0A=
      CVE-2026-52942: netfilter: nf_log: validate MAC header was set before=
 dumping it=0A=
      CVE-2026-52946: fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync sig=
naling=0A=
      CVE-2026-52947: net: qrtr: fix refcount saturation and potential UAF =
in qrtr_port_remove=0A=
      CVE-2026-52948: i2c: dev: prevent integer overflow in I2C_TIMEOUT ioc=
tl=0A=
      CVE-2026-53131: netfilter: require Ethernet MAC header before using e=
th_hdr()=0A=
      CVE-2026-53132: vsock/virtio: fix potential unbounded skb queue=0A=
      CVE-2026-53133: RDMA/umem: Fix truncation for block sizes >=3D 4G=0A=
      CVE-2026-53134: netfilter: nft_fib: fix stale stack leak via the OIFN=
AME register=0A=
      CVE-2026-53135: drm/amd/display: Fix NULL deref and buffer over-read =
in SDP debugfs=0A=
      CVE-2026-53136: drm/amd/display: Clamp VBIOS HDMI retimer register co=
unt to array size=0A=
      CVE-2026-53137: drm/amd/display: Clamp HDMI HDCP2 rx_id_list read to =
buffer size=0A=
      CVE-2026-53138: drm/amd/display: Bound VBIOS record-chain walk loops=
=0A=
      CVE-2026-53140: drm/v3d: Fix vaddr leak when indirect CSD has zeroed =
workgroups=0A=
      CVE-2026-53143: drm/amdkfd: Fix buffer overflow in SDMA queue checkpo=
int/restore on GFX11=0A=
      CVE-2026-53144: drm/amdkfd: fix NULL dereference in get_queue_ids()=
=0A=
      CVE-2026-53146: thunderbolt: Limit XDomain response copy to actual fr=
ame size=0A=
      CVE-2026-53147: thunderbolt: Validate XDomain request packet size bef=
ore type cast=0A=
      CVE-2026-53148: thunderbolt: Clamp XDomain response data copy to allo=
cation size=0A=
      CVE-2026-53149: thunderbolt: Bound root directory content to block si=
ze=0A=
      CVE-2026-53150: thunderbolt: Reject zero-length property entries in v=
alidator=0A=
      CVE-2026-53152: mmc: dw_mmc-rockchip: Add missing private data for ve=
ry old controllers=0A=
      CVE-2026-53154: mm/hugetlb: restore reservation on error in hugetlb f=
olio copy paths=0A=
      CVE-2026-53156: nvmem: core: fix use-after-free bugs in error paths=
=0A=
      CVE-2026-53158: misc: fastrpc: Fix NULL pointer dereference in rpmsg =
callback=0A=
      CVE-2026-53159: misc: fastrpc: fix DMA address corruption due to find=
_vma misuse=0A=
      CVE-2026-53160: misc: fastrpc: fix use-after-free race in fastrpc_map=
_create=0A=
      CVE-2026-53161: misc: fastrpc: fix use-after-free of fastrpc_user in =
workqueue context=0A=
      CVE-2026-53168: fuse: reject fuse_notify() pagecache ops on directori=
es=0A=
      CVE-2026-53175: inet: frags: fix use-after-free caused by the fqdir_p=
re_exit() flush=0A=
      CVE-2026-53176: IB/isert: Reject login PDUs shorter than ISER_HEADERS=
_LEN=0A=
      CVE-2026-53177: bnxt_en: Fix NULL pointer dereference=0A=
      CVE-2026-53180: timers/migration: Fix livelock in tmigr_handle_remote=
_up()=0A=
      CVE-2026-53181: vsock/vmci: fix sk_ack_backlog leak on failed handsha=
ke=0A=
      CVE-2026-53182: wifi: nl80211: reject oversized EMA RNR lists=0A=
      CVE-2026-53183: mptcp: allow subflow rcv wnd to shrink=0A=
      CVE-2026-53184: udp: clear skb->dev before running a sockmap verdict=
=0A=
      CVE-2026-53185: zram: fix use-after-free in zram_bvec_write_partial()=
=0A=
      CVE-2026-53186: RDMA/srp: bound SRP_RSP sense copy by the received le=
ngth=0A=
      CVE-2026-53189: mm/huge_memory: update file PMD counter before folio_=
put()=0A=
      CVE-2026-53190: drm/virtio: fix dma_fence refcount leak on error in v=
irtio_gpu_dma_fence_wait()=0A=
      CVE-2026-53191: io_uring/net: inherit IORING_CQE_F_BUF_MORE across bu=
ndle recv retries=0A=
      CVE-2026-53192: ALSA: timer: Fix UAF at snd_timer_user_params()=0A=
      CVE-2026-53193: ALSA: timer: Forcibly close timer instances at closin=
g=0A=
      CVE-2026-53194: USB: serial: kl5kusb105: fix bulk-out buffer overflow=
=0A=
      CVE-2026-53195: USB: serial: io_ti: fix heap overflow in build_i2c_fw=
_hdr()=0A=
      CVE-2026-53196: USB: serial: io_ti: fix heap overflow in get_manuf_in=
fo()=0A=
      CVE-2026-53198: ksmbd: fix use-after-free of a deferred file_lock on =
double SMB2_CANCEL=0A=
      CVE-2026-53199: hv_netvsc: use kmap_local_page in netvsc_copy_to_send=
_buf=0A=
      CVE-2026-53202: accel/ivpu: Fix signed integer truncation in IPC rece=
ive=0A=
      CVE-2026-53203: accel/ivpu: Add buffer overflow check in MS get_info_=
ioctl=0A=
      CVE-2026-53205: accel/ivpu: Add bounds checks for firmware log indice=
s=0A=
      CVE-2026-53207: mm/memory-failure: fix hugetlb_lock AA deadlock in ge=
t_huge_page_for_hwpoison=0A=
      CVE-2026-53208: Bluetooth: L2CAP: reject BR/EDR signaling packets ove=
r MTUsig=0A=
      CVE-2026-53209: Bluetooth: hci_sync: reject oversized Broadcast Annou=
ncement prepend=0A=
      CVE-2026-53210: tee: shm: fix shm leak in register_shm_helper()=0A=
      CVE-2026-53212: netfilter: nft_tunnel: fix use-after-free on object d=
estroy=0A=
      CVE-2026-53213: drm/vc4: fix krealloc() memory leak=0A=
      CVE-2026-53214: ipv6: Fix a potential NPD in cleanup_prefix_route()=
=0A=
      CVE-2026-53215: net: mvpp2: refill RX buffers before XDP or skb use=
=0A=
      CVE-2026-53216: net: mvpp2: limit XDP frame size to the RX buffer=0A=
      CVE-2026-53217: net: mvpp2: sync RX data at the hardware packet offse=
t=0A=
      CVE-2026-53218: netfilter: nft_exthdr: fix register tracking for F_PR=
ESENT flag=0A=
      CVE-2026-53219: netfilter: x_tables: avoid leaking percpu counter poi=
nters=0A=
      CVE-2026-53220: netfilter: revalidate bridge ports=0A=
      CVE-2026-53221: ip6_vti: fix incorrect tunnel matching in vti6_tnl_lo=
okup()=0A=
      CVE-2026-53223: net: guard timestamp cmsgs to real error queue skbs=
=0A=
      CVE-2026-53225: sctp: fix uninit-value in __sctp_rcv_asconf_lookup()=
=0A=
      CVE-2026-53227: net: openvswitch: fix possible kfree_skb of ERR_PTR=
=0A=
      CVE-2026-53228: ipv6: sit: reload inner IPv6 header after GSO offload=
s=0A=
      CVE-2026-53229: net/mlx5e: xsk: Fix DMA and xdp_frame leak on XDP_TX =
xmit failure=0A=
      CVE-2026-53230: net/mlx5: Fix slab-out-of-bounds in mlx5_query_nic_vp=
ort_mac_list=0A=
      CVE-2026-53232: net: phy: clean the sfp upstream if phy probing fails=
=0A=
      CVE-2026-53233: netdev: fix double-free in netdev_nl_bind_rx_doit()=
=0A=
      CVE-2026-53234: net: ibm: emac: Fix use-after-free during device remo=
val=0A=
      CVE-2026-53235: net: add pskb_may_pull() to skb_gro_receive_list()=0A=
      CVE-2026-53236: tcp: restrict SO_ATTACH_FILTER to priv users=0A=
      CVE-2026-53237: gpio: mvebu: fix NULL pointer dereference in suspend/=
resume=0A=
      CVE-2026-53238: netlabel: validate unlabeled address and mask attribu=
te lengths=0A=
      CVE-2026-53239: xfrm: policy: fix use-after-free on inexact bin in xf=
rm_policy_bysel_ctx()=0A=
      CVE-2026-53241: ALSA: seq: dummy: fix UMP event stack overread=0A=
      CVE-2026-53242: ALSA: PCM: Fix wait queue list corruption in snd_pcm_=
drain() on linked streams=0A=
      CVE-2026-53245: net/802/mrp: fix vector attribute parsing in mrp_pdu_=
parse_vecattr=0A=
      CVE-2026-53247: net: ethernet: mtk_eth_soc: Fix use-after-free in met=
adata dst teardown=0A=
      CVE-2026-53249: ipv4: restrict IPOPT_SSRR and IPOPT_LSRR options=0A=
      CVE-2026-53251: Bluetooth: ISO: Fix not releasing hdev reference on i=
so_conn_big_sync=0A=
      CVE-2026-53252: Bluetooth: fix memory leak in error path of hci_alloc=
_dev()=0A=
      CVE-2026-53253: Bluetooth: bnep: reject short frames before parsing=
=0A=
      CVE-2026-53254: Bluetooth: RFCOMM: validate skb length in MCC handler=
s=0A=
      CVE-2026-53255: Bluetooth: MGMT: validate advertising TLV before type=
 checks=0A=
      CVE-2026-53256: Bluetooth: RFCOMM: hold listener socket in rfcomm_con=
nect_ind()=0A=
      CVE-2026-53261: devlink: Release nested relation on devlink free=0A=
      CVE-2026-53262: l2tp: pppol2tp: hold reference to session in pppol2tp=
_ioctl()=0A=
      CVE-2026-53263: 6lowpan: fix off-by-one in multicast context address =
compression=0A=
      CVE-2026-53264: net/sched: act_api: use RCU with deferred freeing for=
 action lifecycle=0A=
      CVE-2026-53265: dm cache policy smq: check allocation under invalidat=
e lock=0A=
      CVE-2026-53266: netfilter: bridge: make ebt_snat ARP rewrite writable=
=0A=
      CVE-2026-53267: netfilter: nft_ct: bail out on template ct in get eva=
l=0A=
      CVE-2026-53268: netfilter: conntrack_irc: fix possible out-of-bounds =
read=0A=
      CVE-2026-53269: netfilter: synproxy: add mutex to guard hook referenc=
e counting=0A=
      CVE-2026-53270: ipvs: clear the svc scheduler ptr early on edit=0A=
      CVE-2026-53271: ksmbd: fix NULL-deref of opinfo->conn in oplock/lease=
 break notifiers=0A=
      CVE-2026-53272: erofs: fix use-after-free on sbi->sync_decompress=0A=
      CVE-2026-53273: tee: optee: prevent use-after-free when the client ex=
its before the supplicant=0A=
      CVE-2026-53274: net/smc: fix sleep-inside-lock in __smc_setsockopt() =
causing local DoS=0A=
      CVE-2026-53275: ipv6: mcast: Fix use-after-free when processing MLD q=
ueries=0A=
    added commits:=0A=
      CIP: Bump version suffix to -cip26 after merge from stable=0A=
      arm64: dts: renesas: r9a09g047e57-smarc: Enable RSPI0=0A=
      arm64: dts: renesas: r9a09g047: Add RSPI nodes=0A=
      spi: rzv2h-rspi: Fix silent failure in clock setup error path=0A=
      spi: rzv2h-rspi: Simplify clock rate search function signatures=0A=
      spi: rzv2h-rspi: Fix invalid SPR=3D0/BRDV=3D0 clock configuration=0A=
      spi: rzv2h-rspi: Fix max_speed_hz advertising prohibited bit rate=0A=
      spi: rzv2h-rspi: Add support for RZ/G3L (R9A08G046)=0A=
      spi: rzv2h-rspi: add support for DMA mode=0A=
      spi: rzv2h-rspi: split out PIO transfer=0A=
      spi: rzv2h-rspi: enable TX buffer empty interrupt=0A=
      spi: rzv2h-rspi: set TX FIFO threshold to 0=0A=
      spi: rzv2h-rspi: set MUST_RX/MUST_TX=0A=
      spi: rzv2h-rspi: store RX interrupt in state=0A=
      spi: rzv2h-rspi: use device-managed APIs=0A=
      spi: rzv2h-rspi: do not set SPI_TRANS_FAIL_IO=0A=
      spi: rzv2h-rspi: remove call to spi_finalize_current_transfer()=0A=
      spi: rzv2h-rspi: fix rzv2h_rspi_transfer_one() indentation=0A=
      spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/G3E SoC support=0A=
      spi: dt-bindings: renesas,rzv2h-rspi: Document dmas property=0A=
      spi: dt-bindings: renesas,rzv2h-rspi: allow multiple DMAs=0A=
      spi: dt-bindings: renesas,rzv2h-rspi: document optional support for D=
MA=0A=
      clk: renesas: r9a09g047: Add entries for the RSPIs=0A=
      driver core: Add device probe log helper dev_warn_probe()=0A=
      dmaengine: Add devm_dma_request_chan()=0A=
=0A=
Best regards,=0A=
  Nobuhiro=0A=


