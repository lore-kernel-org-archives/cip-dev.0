Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29AA10A1E7C
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 11:14:11 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45686.1774523640633762342
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Mar 2026 04:14:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=fO/kc8yK;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1774523627;x=1775733227;bh=
	z/RJPmHZrvTPLeKNyjfTxz/Hv3pZppKpiY/iMA2KWUs=;b=fO/kc8yKyMkgnhFTl01MbuwppCGzBb
	zE+SFyNuN6I8c0pdTBUvaZGO4of0VH15JszxBrsDi5Lso+G16Q9fldmVpBIAXVGXU+8RhKrdCGmoH
	wDYjd+lDCQlRhta9SdODcee5DD1d7fqPuOhcyfRUn/ujAXw0JBvL2CIzE/yLlGvZm0MTu4kyGskZR
	QSYEgwVXOPOi6qK40V3oSQrZklytWkuY1pCUEUxmAUdUDpRvu1kyO1GCzHybPAOUjwMAVGXnuLnd+
	erYNjUHmWL7GMDcVkLUoliYfDNQJfoC6z7auMbAa/gDvdhzlJv6S3rGlUAYEnv2fE125me0K6mRxx
	Z6cg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 62QBDkaP2517735; Thu, 26 Mar 2026 20:13:46 +0900
X-Iguazu-Qid: 2yAbMX92rcMX7KLGme
X-Iguazu-QSIG: v=2; s=0; t=1774523626; q=2yAbMX92rcMX7KLGme; m=in14ML6/mBWLtU9zb2pDE4KjfhcvSrXKm0wPldTVBCY=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fhLkK4KJmzyPQ; Thu, 26 Mar 2026 20:13:45 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUhf7tQ3ipli+QKzSLLkqNyrBOwoeNPSsPrhwXzLfW95xNErlBqapiz9N0L9c9IV8rQh/V4sCIxnvt5niNrHrlfqJoORVpzA+Fit/O6IGaqBtKgqe/s7O7S2w7WsKbpE+fBjI7iXghRMQNQXW+lKxf8UZWboU3XSLCwzkAOiKyyG3f3q7a64nOJHmRTj/LMtGiugfeEwWyafvC3ZZt3G1qvVuZpaEwhekT6jfD3h4SA/Ea28eXmV6R0rj91LoUXGDegFE4ua1TIpFDnKHHZv+yuTQ3T9hDUjzJu6KVVtSgHJHURT4AA5+05cguwbPKgby9OH5iuC/V/e45qgnmla3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Zi7O8U0Gc2oNyyEkcqcanZt2LlC/9swngFJ4hIyOkY=;
 b=bdJc97YzzZ2NpfAoILNLo2jnN9ExCTzWAc0lIRa0vuXStTDq5WvWGsxpcQHt2nouIcVlH+tqKm0UQgEYz1i2ZY9/KD6tsFkFPNkaMdT+YmeSuhip9M/tVSL3xdhLtg+oS9u8yAyfJT8aQh9JUnvxQghlNIpjCfCPAN2xjFfhxdhCBs63B2KW6pGxDFjMxOrl0M45GvvOlCEP2Y6DIBSZLRcUjTTxa/3+bgArZC/oWXxnMOn/ScTnLOgfNeMCvEBvbn7RHFEFfyFK5ck4Wwam7r9qXE/eYTt1m3FXNoISqMcTS5dlQtQ+wzIU/pvntuw8/OC1GcKwN82JS6apUINnww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@nabladev.com>, <masami.ichikawa@cybertrust.co.jp>,
        <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v6.12.78-cip19
Thread-Topic: [ANNOUNCE] Release v6.12.78-cip19
Thread-Index: Ady9ECn9qF4oCmlHTAu9owz8nXQu1g==
Date: Thu, 26 Mar 2026 11:13:42 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818AB3C65FC4871116A464CCD56A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSRPR01MB11504:EE_
x-ms-office365-filtering-correlation-id: a4b27d27-00af-4798-0168-08de8b28bda1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info: 
 WXfp680gAQB54ezxsjl2mySDeC4/aLVN7nt4Wwhyt2Hvw9Os/mfUmSZJBpTcUR/GWAJnZakZg1GlTxDrOuqx4RGdKK67szqSPpAfb2hC5jMXA3DxyKlTR0jjt4k8HwaR6GTTpmGJWWXqHqgBsr1AakPsqwBwOpzWM5Trb15m1vGFbnWfO9gHe7Sq6gJx5qcUc7WbrPHPl3evIg7AzEX17KIuLCqGZOY4UdvRfsr3wGDQux1FNsxnwR1XRTUvROEbNAAQxHq3MggicTSxrYh1iEXd7q4yFHcOlcH0X5rSxOWdwqUHLVCFi+ZSQ1OajuFGepWWVchtH7Rg4YShlIhDOvpYSMteLTNttY9hFPvcQeXs0nJU+f/WHWg/Fzvov0hl3OUCA6pTxuwzTW5usLYnXHAl81tUKcB5tmy7FSPl9g5m/QCPn+qYI/0HItLxupQcbatP53XTugsI3DoSwwYRn5MbLTdQWc/JCHZYYc4h5Ip3damJM1FJ9xD3KpLzhfn1OXVcECXSTOkRg10pKMwXHZvPWY3gjh27iC7MKKUjbYfBhzZ3jLp/2WoFjb5yDIZ9++6O5fHP2RVrgHRypOatFxZU3TWLkQIwFSYkNN5aif3aYnTz2ifXWaahbhN1DSSs7nspfIZLG3fmcfnhPtOp51T6L/ZygDb3CnomJS8jxjpSNsO5fEH8TxWgy67LzqmMpDreTWNq+JfRGQIiloBEMDYF/mxvhNmusuYKzK5YV6ejbT0OuF0zu9XjTjWJjKXB+mU1mrmjwnVGvNHRfr3U3wiIBAUO6PcZbiA2nq7InyE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Y2x4dUFIeVVMTlhKeWJBaENRN2tJalh1VHY4VkdBZkFjTVlka2FENjc5?=
 =?iso-2022-jp?B?M0RMRHpncG4zMEgrRTdjVFZzbGhHK1cwUlQySE53Vy9FdkpZNUFBNjFP?=
 =?iso-2022-jp?B?YWUwZm9UY3ZsSlhGWkJjdzdJSHQ5SXVuaWdYSE1aeHE2VVNKUytaUTZi?=
 =?iso-2022-jp?B?NnAzbCtqUmpCQVF3QjhQNi84WHBOTGI3SXpwWXpsdWszd1FhR3VURU0z?=
 =?iso-2022-jp?B?NmU1azhpSksvb2JFL1phWmFEUXRQQ1NOb3pCZ0kyVTFGelVjQU10aVRG?=
 =?iso-2022-jp?B?eXFsK21OaUtuZWZTYlhWckp0U2F3OHQrSjdjMXZ1NnhBU1huVHUxUHBT?=
 =?iso-2022-jp?B?T3dqU2VzQVk3VVNSdWV2NncrRi9LbjJMYSs2QTVhVHZmVlo1WkQrb1lR?=
 =?iso-2022-jp?B?MzI0MVhISWZBOGd1MDR6aU83SFBGMFF4MVM0VlUwVzZJZjdVNWkxOSs5?=
 =?iso-2022-jp?B?d2pxVUNqVGliT0RZRFE2VUhlYXo3b3hqZndRdUVCbURVN3Y3UnNJbGJO?=
 =?iso-2022-jp?B?V01rVkdzbTA1dW0vM1htcG1wSld2RWtzV1JjSDF1Yi9JVmUvZDh1Vjdy?=
 =?iso-2022-jp?B?ajM5K0JSanpuTmdWU3RIWnhlNFArZVRVVmh4bnJuZ0E0TmdHWTVmb2xP?=
 =?iso-2022-jp?B?R0EzcUQvMWMyNHh1WjR0Yjc3ZmRIc1hQVG5NNER3ZFk3OXozSk04RlRX?=
 =?iso-2022-jp?B?bWl1SThEdkFGZk1odVJmdEV2OGZmdzUxMHdpQlJWNzlWMEdGaW5hTkQ0?=
 =?iso-2022-jp?B?QkpENXhrT0xGUXZzSmp1NmhwbGJ2MGJGd2J4ampCVTdkcE44alNHZVYw?=
 =?iso-2022-jp?B?Tld2UTFRdlB4S0h4RnlkOVJGS2tKTGI0bHRsUFBoYm5wMWZMMDNjd3NL?=
 =?iso-2022-jp?B?d3BRNGdQNEs4OWhDVWpTNDZaTW5lZmtTQTl3N2tHOTE4cVJRUlpFVjNE?=
 =?iso-2022-jp?B?emQ5ZTNwT1NBOWxLOFNHV3JPK1ZqL0lZMFJwRVJWVzJGU29BWFo3aHJ3?=
 =?iso-2022-jp?B?Q216cDhsZC8wTTd4ZWJ5QkVSYzIrYk40SjBVa0FwSXFBRlRTWlY3THJw?=
 =?iso-2022-jp?B?TGNoSmNZekFTeDBkaU11R2IzWnVmbEpLVFpIZ09yNmlnWHdORW93OUp3?=
 =?iso-2022-jp?B?NHp3akV2R1BOYTJZb1ZuTHFsdW9IdG5tYlZwc00xWERIc3JxeENyeVEx?=
 =?iso-2022-jp?B?YmhVUXVId1VhK0diRU5MQ1YvTXRxTDQ5ditvbDFPRlVTZWQ1c2pjT2J3?=
 =?iso-2022-jp?B?VXJvODRzUU1tR0pQblAwOEJqUSs5Mk5Bd2Z5TXVDTzZvbXBWdEJkR0JE?=
 =?iso-2022-jp?B?TXdUUXJJQ0l5b2ZwRlhqUHU1dDVXdngzQjNhbkFTN0QyRWtVUElxdmtm?=
 =?iso-2022-jp?B?TUZZT3FDeEcxQ2VaTytmcEFUZE9uUFlrdk5wbmNVK2xoVEFOQVRvWnMy?=
 =?iso-2022-jp?B?U2JLUFY0Zkpza0pnVCtVL1NXVXB3Uk9CcVFWbENEbmpXMytSUCtsVTZ3?=
 =?iso-2022-jp?B?TmJTLzBuUy9lMFJMdTBxTEs3UmdFUUhTRkIxaDF2RlFuTTBVbXBTVWN5?=
 =?iso-2022-jp?B?V1VON0NKZWV4ZVJBb1J5WHRJK1dSYmdaNms1Z3JUMG94T1h0bXFqV29x?=
 =?iso-2022-jp?B?dGRVaHFWNjdzYU11aURDaHBHck1FWVNaZE9NWXRmWjQzVll2bEkrRXd1?=
 =?iso-2022-jp?B?OTJHQVMwY083ZXhhOTFWenBrd1FyM2grZklzQ3laanF6MDZ0b25IaVZq?=
 =?iso-2022-jp?B?QTBUWXdmNTFMZGVaM1JpNFdLZzBER0NHaTJEWFovRTAzbzBqWmFLRTVH?=
 =?iso-2022-jp?B?WTZleDdHZ2tEZ1hvYVNlalFzZUtFVzJHQTUyNnlVK0R1RlN1Q2w0VnAw?=
 =?iso-2022-jp?B?WVZ6MUpnZ2Q4b3dXam9jS2hLWFN3REtpZ0RtSGNHVm9WZnVITWVULzFS?=
 =?iso-2022-jp?B?Nkx1YldhSDBhUXlhWExsSW9BWnJmUXBUUGloWkN1N2M5R3F5TS9QR3BK?=
 =?iso-2022-jp?B?L3QzRHYyZDBSTmZQazc4cm1zNEtXbC94SzdUT3JHQndtQkN3bzlXYS9Y?=
 =?iso-2022-jp?B?eXd0ZSt2Tk9DQUV0VDFuOEFUTzlDd211YzA5dUI4MWQ3L0s2Nk0ySTFI?=
 =?iso-2022-jp?B?MXRTOEpBOXBIbk5sR3BvRXBYd3pOTTVjMDhRVSsyOHlqWnJsc2Y0c3FW?=
 =?iso-2022-jp?B?WUpkZTJKWis5Y2RRUWpVc3RDeHpPQXZEd0taVkFYbHZnL2ZONk5EYWha?=
 =?iso-2022-jp?B?UXVHZkx4MytFbGZFcGR1R2o5VWNIZWNRQUx6bHlHTG5IUDY3OW9kV1Bv?=
 =?iso-2022-jp?B?eGJwNmVTODFhVTFDMDJDUFZlTVdjWWFGbHZkUXdaQUNCNzhKUjNMRTFp?=
 =?iso-2022-jp?B?d2xUVjJxMGdUYnZQZENoNU50QlphRzFqdC9sZUNlOW9HbTREYUVvWXFv?=
 =?iso-2022-jp?B?cXVlVXBwMFZaMkxqZkhZYnFxdFV1eFladkUyN1hwZkZTd2d4Z2YvVlFT?=
 =?iso-2022-jp?B?S2JIUEtJQmJqSjc5cG1IaUxYRGJnVU9LME9uaEQrZnJiUUpWVDlJeG5v?=
 =?iso-2022-jp?B?a3U2ekNJYz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	iw8EWixcR8XaHIeemBtEsHYd1l66yf6rMBlQGjzNPhLJA3+ZZExxr2dutmtU/D/a1smRdDwr3BsMQDT7sRoAxfyqOyXTrCFS4D4+D337EKh2Fa0gubVWqnElEB65DOgZUmaoWiVrnrYMmmxGxUJlLinEz8Y92/fKUjomnX0tPjrKAZSuN10S54T/Vpk3+u+l9B7Plrn1jzz7V/8cF23GYZAMG66wd0BmCC43OaktalF6IQjP3/BCVjHfCWxsZLTYQ7uagYutbO9EecUaz+AdTsGeFozqT6zLYlVav9wnBf6alVhwSbN1UuG2XxzHft1V8I9oEZ6M1M0Ja+6OK5+qQA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b27d27-00af-4798-0168-08de8b28bda1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 11:13:42.9364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OZNdvNd027AS8OqAOCTN9sv300CWiPBPRf9YZ1pUo23Ob/+e75A1TGJ6AB9/USnXwVAQd66oeZp+cXsE0g/trrzYmU6VAKcAuf8ILi4e6riEYb3FAuajNZ9Mc6fpNWDc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11504
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Mar 2026 11:14:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22581

Hi all,

CIP kernel team has released Linux kernel v6.12.78-cip19.
The linux-6.12.y-cip tree has been updated base version from v6.12.76 to v6=
.12.78.
This release also includes device drivers and fixes for the Renesas
ARM64 SoCs RZ/G3E, RZ/V2N, and RZ/N2H.

Information about this release is as follows:

  v6.12.78-cip19:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      8aea24234867d37d60eef668e5a950942cd95dd4
    fixed CVEs:
      CVE-2024-14027: xattr: switch to CLASS(fd)
      CVE-2025-40119: ext4: fix potential null deref in ext4_mb_init()
      CVE-2026-23226: ksmbd: add chann_lock to protect ksmbd_chann_list xar=
ray
      CVE-2026-23227: drm/exynos: vidi: use ctx->lock to protect struct vid=
i_context member variables related to memory alloc/free
      CVE-2026-23244: nvme: fix memory allocation in nvme_pr_read_keys()
      CVE-2026-23246: wifi: mac80211: bounds-check link_id in ieee80211_ml_=
reconfiguration
      CVE-2026-23253: media: dvb-core: fix wrong reinitialization of ringbu=
ffer on reopen
      CVE-2026-23268: apparmor: fix unprivileged local user can do privileg=
ed policy management
      CVE-2026-23269: apparmor: validate DFA start states are in bounds in =
unpack_pdb
      CVE-2026-23270: net/sched: Only allow act_ct to bind to clsact/ingres=
s qdiscs and shared blocks
      CVE-2026-23271: perf: Fix __perf_event_overflow() vs perf_remove_from=
_context() race
      CVE-2026-23279: wifi: mac80211: fix NULL pointer dereference in mesh_=
rx_csa_frame()
      CVE-2026-23284: net: ethernet: mtk_eth_soc: Reset prog ptr to old_pro=
g in case of error in mtk_xdp_setup()
      CVE-2026-23285: drbd: fix null-pointer dereference on local read erro=
r
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
      CVE-2026-23297: nfsd: Fix cred ref leak in nfsd_nl_threads_set_doit()=
.
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
      CVE-2026-23308: pinctrl: equilibrium: fix warning trace on load
      CVE-2026-23309: tracing: Add NULL pointer check to trigger_data_free(=
)
      CVE-2026-23310: bpf/bonding: reject vlan+srcmac xmit_hash_policy chan=
ge when XDP is loaded
      CVE-2026-23312: net: usb: kaweth: validate USB endpoints
      CVE-2026-23313: i40e: Fix preempt count leak in napi poll tracepoint
      CVE-2026-23315: wifi: mt76: Fix possible oob access in mt76_connac2_m=
ac_write_txwi_80211()
      CVE-2026-23316: net: ipv4: fix ARM64 alignment fault in multipath has=
h seed
      CVE-2026-23317: drm/vmwgfx: Return the correct value in vmw_translate=
_ptr functions
      CVE-2026-23318: ALSA: usb-audio: Use correct version for UAC3 header =
validation
      CVE-2026-23319: bpf: Fix a UAF issue in bpf_trampoline_link_cgroup_sh=
im
      CVE-2026-23324: can: usb: etas_es58x: correctly anchor the urb in the=
 read bulk callback
      CVE-2026-23325: wifi: mt76: mt7996: Fix possible oob access in mt7996=
_mac_write_txwi_80211()
      CVE-2026-23326: xsk: Fix fragment node deletion to prevent buffer lea=
k
      CVE-2026-23334: can: usb: f81604: handle short interrupt urb messages=
 properly
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
      CVE-2026-23344: crypto: ccp - Fix use-after-free on error path
      CVE-2026-23347: can: usb: f81604: correctly anchor the urb in the rea=
d bulk callback
      CVE-2026-23351: netfilter: nft_set_pipapo: split gc into unlink and r=
eclaim phase
      CVE-2026-23352: x86/efi: defer freeing of boot services memory
      CVE-2026-23354: x86/fred: Correct speculative safety in fred_extint()
      CVE-2026-23355: ata: libata: cancel pending work after clearing defer=
red_qc
      CVE-2026-23356: drbd: fix "LOGIC BUG" in drbd_al_begin_io_nonblock()
      CVE-2026-23357: can: mcp251x: fix deadlock in error path of mcp251x_o=
pen
      CVE-2026-23359: bpf: Fix stack-out-of-bounds write in devmap
      CVE-2026-23360: nvme: fix admin queue leak on controller reset
      CVE-2026-23361: PCI: dwc: ep: Flush MSI-X write before unmapping its =
ATU entry
      CVE-2026-23362: can: bcm: fix locking for bcm_op runtime updates
      CVE-2026-23363: wifi: mt76: mt7925: Fix possible oob access in mt7925=
_mac_write_txwi_80211()
      CVE-2026-23365: net: usb: kalmia: validate USB endpoints
      CVE-2026-23367: wifi: radiotap: reject radiotap with unknown bits
      CVE-2026-23369: i2c: i801: Revert "i2c: i801: replace acpi_lock with =
I2C bus lock"
      CVE-2026-23370: platform/x86: dell-wmi-sysman: Don't hex dump plainte=
xt password data
      CVE-2026-23372: nfc: rawsock: cancel tx_work before socket teardown
      CVE-2026-23373: wifi: rsi: Don't default to -EOPNOTSUPP in rsi_mac802=
11_config
      CVE-2026-23378: net/sched: act_ife: Fix metalist update behavior
      CVE-2026-23379: net/sched: ets: fix divide by zero in the offload pat=
h
      CVE-2026-23380: tracing: Fix WARN_ON in tracing_buffers_mmap_close
      CVE-2026-23381: net: bridge: fix nd_tbl NULL dereference when IPv6 is=
 disabled
      CVE-2026-23382: HID: Add HID_CLAIMED_INPUT guards in raw_event callba=
cks missing them
      CVE-2026-23383: bpf, arm64: Force 8-byte alignment for JIT buffer to =
prevent atomic tearing
      CVE-2026-23387: pinctrl: cirrus: cs42l43: Fix double-put in cs42l43_p=
in_probe()
      CVE-2026-23388: Squashfs: check metadata block offset is within range
      CVE-2025-38426: drm/amdgpu: Add basic validation for RAS header
      CVE-2025-38627: f2fs: compress: fix UAF of f2fs_inode_info in f2fs_fr=
ee_dic
      CVE-2025-39764: netfilter: ctnetlink: remove refcounting in expectati=
on dumpers
      CVE-2025-40005: spi: cadence-quadspi: Implement refcount to handle un=
bind during busy
      CVE-2025-40135: ipv6: use RCU in ip6_xmit()
      CVE-2025-40147: blk-throttle: fix access race during throttle policy =
activation
      CVE-2025-40150: f2fs: fix to avoid migrating empty section
      CVE-2025-68239: binfmt_misc: restore write access before closing file=
s opened by open_exec()
      CVE-2025-68334: platform/x86/amd/pmc: Add support for Van Gogh SoC
      CVE-2025-71152: net: dsa: properly keep track of conduit reference
      CVE-2025-71161: dm-verity: disable recursive forward error correction
      CVE-2025-71221: dmaengine: mmp_pdma: Fix race condition in mmp_pdma_r=
esidue()
      CVE-2026-23004: dst: fix races in rt6_uncached_list_del() and rt_del_=
uncached_list()
      CVE-2026-23066: rxrpc: Fix recvmsg() unconditional requeue
      CVE-2026-23070: Octeontx2-af: Add proper checks for fwdata
      CVE-2026-23104: ice: fix devlink reload call trace
      CVE-2026-23138: tracing: Add recursion protection in kernel stack tra=
ce recording
      CVE-2026-23157: btrfs: do not strictly require dirty metadata thresho=
ld for metadata writepages
      CVE-2026-23245: net/sched: act_gate: snapshot parameters with RCU on =
replace
      CVE-2026-23252: xfs: get rid of the xchk_xfile_*_descr calls
      CVE-2026-23274: netfilter: xt_IDLETIMER: reject rev0 reuse of ALARM t=
imer labels
      CVE-2026-23276: net: add xmit recursion limit to tunnel xmit function=
s
      CVE-2026-23277: net/sched: teql: fix NULL pointer dereference in iptu=
nnel_xmit on TEQL slave xmit
      CVE-2026-23278: netfilter: nf_tables: always walk all pending catchal=
l elements
      CVE-2026-23281: wifi: libertas: fix use-after-free in lbs_free_adapte=
r()
      CVE-2026-23321: mptcp: pm: in-kernel: always mark signal+subflow endp=
 as used
      CVE-2026-23364: ksmbd: Compare MACs in constant time
      CVE-2026-23368: net: phy: register phy led_triggers during probe to a=
void AB-BA deadlock
      CVE-2026-23375: mm: thp: deny THP for files on anonymous inodes
      CVE-2026-23386: gve: fix incorrect buffer cleanup in gve_tx_clean_pen=
ding_packets for QPL
      CVE-2026-23391: netfilter: xt_CT: drop pending enqueued packets on te=
mplate removal
      CVE-2026-23392: netfilter: nf_tables: release flowtable after rcu gra=
ce period on error
      CVE-2026-23393: bridge: cfm: Fix race condition in peer_mep deletion
      CVE-2026-23395: Bluetooth: L2CAP: Fix accepting multiple L2CAP_ECRED_=
CONN_REQ
      CVE-2026-31788: In the Linux kernel, the following vulnerability has =
been resolved: xen/privcmd: ...
    added commits:
      CIP: Bump version suffix to -cip19 after merge from stable
      Revert "arm64: dts: renesas: r9a09g057: Add RTC node"
      arm64: dts: renesas: rzt2h-n2h-evk: Enable Ethernet support
      arm64: dts: renesas: r9a09g087: Add GMAC nodes
      arm64: dts: renesas: r9a09g077: Add GMAC nodes
      arm64: dts: renesas: r9a09g087: Add ETHSS node
      arm64: dts: renesas: r9a09g077: Add ETHSS node
      net: pcs: Kconfig: Fix unmet dependency warning
      net: pcs: rzn1-miic: Add RZ/T2H MIIC support
      net: pcs: rzn1-miic: Add per-SoC control for MIIC register unlock/loc=
k
      net: pcs: rzn1-miic: Add support to handle resets
      net: pcs: rzn1-miic: Make switch mode mask SoC-specific
      net: pcs: rzn1-miic: move port range handling into SoC data
      net: pcs: rzn1-miic: Move configuration data to SoC-specific struct
      net: pcs: rzn1-miic: Add missing include files
      net: pcs: rzn1-miic: Drop trailing comma from of_device_id table
      net: pcs: rzn1-miic: Convert to for_each_available_child_of_node() he=
lper
      dt-bindings: net: pcs: renesas,rzn1-miic: Add RZ/T2H and RZ/N2H suppo=
rt
      net: stmmac: dwmac-renesas-gbeth: Add support for RZ/T2H SoC
      net: stmmac: dwmac-renesas-gbeth: Use OF data for configuration
      dt-bindings: net: renesas,rzv2h-gbeth: Document Renesas RZ/T2H and RZ=
/N2H SoCs
      arm64: dts: renesas: rzt2h-n2h-evk: Enable USB2.0 support
      arm64: dts: renesas: r9a09g087: Add USB2.0 support
      arm64: dts: renesas: r9a09g077: Add USB2.0 support
      usb: renesas_usbhs: Add support for RZ/T2H SoC
      dt-bindings: usb: renesas,usbhs: Add RZ/T2H and RZ/N2H support
      phy: renesas: rcar-gen3-usb2: Fix ID check logic with VBUS valid
      phy: renesas: rcar-gen3-usb2: Move debug print after register value i=
s updated
      phy: renesas: rcar-gen3-usb2: Add support for RZ/T2H SoC
      phy: renesas: rcar-gen3-usb2: Allow SoC-specific OBINT bits via phy_d=
ata
      phy: renesas: rcar-gen3-usb2: store drvdata pointer in channel
      dt-bindings: phy: renesas,usb2-phy: Add RZ/T2H and RZ/N2H support
      clk: renesas: r9a09g077: Add Ethernet Subsystem core and module clock=
s
      dt-bindings: clock: renesas,r9a09g077/87: Add Ethernet clock IDs
      clk: renesas: r9a09g077: Add module clocks for SCI1-SCI5
      clk: renesas: r9a09g077: Add USB core and module clocks
      dt-bindings: clock: renesas,r9a09g077/87: Add USB_CLK clock ID
      arm64: dts: renesas: r9a09g087: Add DT nodes for SCI channels 1-5
      arm64: dts: renesas: r9a09g077: Add DT nodes for SCI channels 1-5
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
      arm64: dts: renesas: r9a09g056: Add DMAC nodes
      clk: renesas: r9a09g056: Add entries for the DMACs
      dt-bindings: dma: rz-dmac: Document RZ/V2N SoC support
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
      serial: sh-sci: Update rx_trigger size for RZ/T2H RSCI
      serial: sh-sci: Fix deadlock during RSCI FIFO overrun error
      serial: sh-sci: Merge sh-sci.h into sh-sci.c
      serial: sh-sci: Sort include files alphabetically
      tty: serial: sh-sci: fix RSCI FIFO overrun handling
      serial: sh-sci: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
      clk: renesas: r9a09g047: Add RSCI clocks/resets
      dt-bindings: serial: renesas,rsci: Document RZ/G3E support
      dt-bindings: serial: rsci: Drop "uart-has-rtscts: false"
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Add NMI wakeup button su=
pport
      arm64: dts: renesas: r9a09g056: Add ICU node
      irqchip/renesas-rzv2h: Add support for RZ/V2N SoC
      clk: renesas: r9a09g056: Add entries for ICU
      dt-bindings: interrupt-controller: renesas,rzv2h-icu: Document RZ/V2N=
 SoC
      arm64: dts: renesas: r9a09g087: Add SPI nodes
      arm64: dts: renesas: r9a09g077: Add SPI nodes
      spi: dt-bindings: renesas,rzv2h-rspi: document RZ/T2H and RZ/N2H
      spi: rzv2h-rspi: add support for RZ/T2H and RZ/N2H
      spi: rzv2h-rspi: add support for loopback mode
      spi: rzv2h-rspi: add support for variable transfer clock
      spi: rzv2h-rspi: add support for using PCLK for transfer clock
      spi: rzv2h-rspi: make transfer clock rate finding chip-specific
      spi: rzv2h-rspi: avoid recomputing transfer frequency
      spi: rzv2h-rspi: move register writes out of rzv2h_rspi_setup_clock()
      spi: rzv2h-rspi: make clocks chip-specific
      spi: rzv2h-rspi: make FIFO size chip-specific
      spi: rzv2h-rspi: make resets optional
      clk: renesas: r9a09g077: Add SPI module clocks
      arm64: defconfig: Enable the RZ/V2H(P) RSPI driver
      spi: Add driver for the RZ/V2H(P) RSPI IP
      spi: dt-bindings: Document the RZ/V2H(P) RSPI
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
      arm64: defconfig: Enable RZ/T2H / RZ/N2H ADC driver
      arm64: dts: renesas: rzt2h-rzn2h-evk: Reorder ADC nodes
      arm64: dts: renesas: rzt2h/rzn2h-evk: Enable ADCs
      arm64: dts: renesas: r9a09g087: Add ADCs support
      arm64: dts: renesas: r9a09g077: Add ADCs support
      iio: adc: add RZ/T2H / RZ/N2H ADC driver
      bitfield: Add FIELD_MODIFY() helper
      iio: adc: add helpers for parsing ADC nodes
      property: Add functions to iterate named child
      dt-bindings: iio: adc: document RZ/T2H and RZ/N2H ADC
      clk: renesas: r9a09g077: Add ADC module clocks

Best regards,
  Nobuhiro



