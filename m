Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95754CD4F3C
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 02:43:34 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15343.1763001805731607881
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Nov 2025 18:43:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=Op8ICb5f;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key1.smx;t=1763001781;x=1764211381;bh=
	n4skjJheLCF7Gw8aoIKdqEMS1yY42+qu6s1hesNY4gM=;b=Op8ICb5fBwo9Hx+uPl+Ga7Wn10caIY
	Mn7mFwNTvLgLIUnnLLAR5qmfSOGaBoMR0dkWrOGZ0J3/5EF10sMcNOO+/TpXeNhzAjvAM3ho9Z+ze
	cIfDUFNsPGYvq5cO2UCUXKFVYJTrZut6/O4CR/c7xcEMtNkUgmRTq8UIINeoNBruia0zDtw5ertih
	AV8R95rDmHp8Lp8TzbVn1xGzleORuwbN8+4JtCqVSNT9s+cWHKhD3Ai90XdKgatdYt7glEZr8S84D
	1xd/KB0egw3cD6lhSiZB/IUlRbOllMnHvfh8f7fi4x4JbO5DYf2iiNukdpsNnjhTlSdtf6XePp5Ql
	UUcA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 5AD2h0O43229032; Thu, 13 Nov 2025 11:43:00 +0900
X-Iguazu-Qid: 2rWgP4I4zUft8LYLg5
X-Iguazu-QSIG: v=2; s=0; t=1763001779; q=2rWgP4I4zUft8LYLg5; m=iH/hU0Ftl2qMNmhtKH05niVjIeOmcvwcSSd/MZnQnLA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4d6PhL6jq4z4vyk; Thu, 13 Nov 2025 11:42:58 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZg6NkaUubcm84qGYXf+M2B8Uu8bAI2GdtxEDJ47P23CGpZUBtpDv7pfkh3eyLjo8gPrN0GnGGcDr8UvtmDOc+EDJ7ZLUEIlIP+7mDbnjWaluPGIeGYmTXG25fUc1iCNIVTKtFwtblFTghZOMHKLvKNUJ/3oz5rW+3YTx1bdP2fYz0Dxmn87HYx5/7Cj3IDoBw62mNW90t19tU7d5G4GPdaAgo7S0XlxIvOrX8KHHkraB5pggyBNtkbwEKxsaiiATGRklzMIVU5ezJfZi/V6/Ifir+0lh3TIJycXEi+xM6hZUBC88r0Hv51LM2JemaIl6Hv/46D6Jx0PG+bu67LuQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vao6aIqVvBNBHf2tg0U0WwyekmzFwKImcWXfIM3zM3k=;
 b=n27rRMroHsZhP8cZNgfoupVUCiHa+0C19ERdMRYNp8S1ORnff2B43AsjVoOxD5Gs3daEyIybtrnfA9gExsJbs36qkJGUt9FhXDWEjzJ6jZpvb8sXI9Bwx3TK9Cr8JtaeGhqopUkAEZk7oeEC3Ak72hoz628eah7DOAPanrOKxMdOlRwozDewgeTGW3PrOvm/Zl1JSM2NZMTFK/Ik3mVxCgrwMLZm7cbGPiDrxu+ISA//F3Kn3dNmlTXKK+3GTZeO6VUB0BoXzaMJ4ANYsRcEjoenDWMwN5KG4bfdpL4rg7BoR/THUAatmHB4nAFDEs+81+OTDCN7HL8DENERKgOv9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v6.12.57-cip12
Thread-Topic: [ANNOUNCE] Release v6.12.57-cip12
Thread-Index: AdxURsSJO3HA0h8JQaGMrQ79SQQPNQ==
Date: Thu, 13 Nov 2025 02:42:56 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818DE9E5FA482DF56447AE0CDCDA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY4PR01MB17148:EE_
x-ms-office365-filtering-correlation-id: 80050505-1656-4b72-d3a5-08de225e5a0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|18002799006;
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230040)(376014)(1800799024)(18002799006);DIR:OUT;SFP:1501;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bGhTL3N3ZGFKTjBFV09oRURBZ0YxRDNSNE92NXRTQnVnNXNDVlRtVmZN?=
 =?iso-2022-jp?B?bkJFMEt0R1JPeHRWR0x0NVJlejFCOGtDRUlQb2haRkJ1RnNCTHo4RGx5?=
 =?iso-2022-jp?B?K3cxcHVVaEpsdzczNWdac012VjNhbkdncFBsOWFGeDdxSDFmbE90NXNN?=
 =?iso-2022-jp?B?UVIrdU9Ca3pvT0UvR0VuTGhWSEhpQWc1Q24wWTVpSk00WEZUK0lzQzRm?=
 =?iso-2022-jp?B?MDhWeFR0Nk1UbWJHa2s3Nkhmc3c4YzIveVNUblRpSERyRndRbkozM2x0?=
 =?iso-2022-jp?B?dWtXdkNJWGVuZXVOVGZaaEZmajcxYUM5ZmVzYXdid3RuZHYwTm0vQ3ZY?=
 =?iso-2022-jp?B?UmI2V28zaS9mUGhIY0t6dzJvUmVmeSsyUVZFNzJkZTNKMjg4bnNnNVo2?=
 =?iso-2022-jp?B?WXVkVXRDV0sxeWZ6WWk0Wk1NTmh4VWo3ZWZwaEczTFEwM2dJQzhSaC9Z?=
 =?iso-2022-jp?B?Z0dkVmhhc3VSZGtLVXcwaGZEYXZRZXpSRnhuVlpyOG41R1F4d3U5dmNK?=
 =?iso-2022-jp?B?TStZR1NFT3hIUHF3bzhmRkhybVRXbzRnSUhWMFkxY0ZlMHhoRzJUMUZT?=
 =?iso-2022-jp?B?NHNyaWpGbExKZDZOUjhBbkZPNnl4TmkyUFNQWUhucTVRY2VnRlI5aXdo?=
 =?iso-2022-jp?B?L2RJckFwRHlzSUFjQjQ1cit2SE9NSENWam9xSVZ3SWVaV0l6cEUxYm1O?=
 =?iso-2022-jp?B?dlA1L0dQTUNuUXNyRFZJVGdiY2JaQUJEQzVqejZkYXhuckx4ejI5SDNx?=
 =?iso-2022-jp?B?VVFLUmJKRytzTGNPOE1tSnNyNjNYaTgwclZ0aEFvSHpYNVR0V3JsQ0xO?=
 =?iso-2022-jp?B?MkFLWVl2ZzBiT0ZmdDZWTWFsb3VDTDNSWGdkbkU4RWpzc3JQMGdiOFlj?=
 =?iso-2022-jp?B?T1hQSjZPdlBVVmVINXVzUlU3dXQ1NHFXcERsSGUwbWdpZWw5b0VURzZm?=
 =?iso-2022-jp?B?NXpmTVFmSTdVWlFXOGNLMnhrNUl0ckluem42dHhhYWdJL2duODRCTWo5?=
 =?iso-2022-jp?B?cDdhYjBScHpSZnZISnY3VjhSV1AwTmZQdjlsQ040VWE1TFRlcEt3VlBk?=
 =?iso-2022-jp?B?Z2lxTFhia0xXZVZQalZOTnBaRTBDQVhhRG5OUTRXanBXQ2ZKTDBOdVU4?=
 =?iso-2022-jp?B?WEFRQVF3bnozSHZJSGovYjJuVlh5bWZzdk9DWmVldWtvelBPalV6U0Y2?=
 =?iso-2022-jp?B?MTNPc1c4bUdjbnh2SGJQWHMxbTllMDNraW9aTDFPc3hYWWNITHdBSkcz?=
 =?iso-2022-jp?B?ZXNXVTFrOGhQNzZaTDZhV25yNUxxRFZCV2JCNjhIOFMrWDlQUjhGK1Zi?=
 =?iso-2022-jp?B?L3dGdGovaWVZMFk4L1QwckplOHlxaEpYUWVWQkpsODBVN1FCM0tTU3d0?=
 =?iso-2022-jp?B?YXVpQ0NucUkyY0VxdWF1Y2FXc0FzalJPZlJONXRqWk05bGZhbWR2Skhx?=
 =?iso-2022-jp?B?U1d0c3B0VDdPTlpsWHc1dmJsOUkxYjloSEM5QlVOMDlEV0kvT1FCamZ3?=
 =?iso-2022-jp?B?T0t5WFdDeXJ1S25sVWMvMTJsVnd2MXRpUDRDdGFJek1FODlFeFB3QjJz?=
 =?iso-2022-jp?B?dDkyN3NKU21LSi9GSjNrR0luMnR6elhocXIvaFZMWThOR2tBOVVEY0Qz?=
 =?iso-2022-jp?B?QllhaExMbGRmWFI2Q2hGQ0ZjYXJMbk41RHFxRU9FVFRpOEc5aDdqdno2?=
 =?iso-2022-jp?B?QlJhUTZVTTFWcDZmZ2lqU0pBeWtTL3JjUHRYRllEUXorUTc3cDNLdXlD?=
 =?iso-2022-jp?B?YmVzMVhpV3VtenZuVmFydlRIaFJtbllYdk14RTFZdnY4Wm9ML3gzWnpt?=
 =?iso-2022-jp?B?S3NEL3FRa2hJblJiNHlPVDJqM1hTS0Y5V0VwTlRqbHlFZ0hQNlV0WWtk?=
 =?iso-2022-jp?B?VUpnYmJWYlowZ1V6Mm1Eb2xxb040TVlyMktFeUxIMUxEenk0U2l1c01w?=
 =?iso-2022-jp?B?TEFVeUJUVjU0TW5GbHJvSEw5L3VVRnprRGNpa2lDS1lRWndVUWptSGdQ?=
 =?iso-2022-jp?B?NDBHc1FEK3Y3Y0xXc3hYYkhHQjR5QTBpdVY1ZlZITlFUUmI0YTI5QTlj?=
 =?iso-2022-jp?B?bmVQL0xoK25vWjFjWkpoNVhIKzNyRHpRYWVNRHF4WnFaYzZOVi9CY1J5?=
 =?iso-2022-jp?B?RHBrUjhvQ05FYTgyTjBZa3hnRlpXdmQxbzZyVEdiWDRpRWJpaU55NjFH?=
 =?iso-2022-jp?B?L1l0QXdOeFIvWUlmd2xKTXRDSnVLeGU4TjRTK1MycDY0UlFlaEFESytP?=
 =?iso-2022-jp?B?cFRmeFlDZzVWamIraGVwaDEyZHo5dklEZHpnRWxPQXpoNVl4QzhXY3Bp?=
 =?iso-2022-jp?B?eEN2bjMvV1ZyTHFodXJiUjc3cXZ6Z1kxSFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80050505-1656-4b72-d3a5-08de225e5a0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 02:42:56.6069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K8mu7s0/hVVbMYxXk53go2JIZR+fDD4Dm4ojgMG0gynaCc9wEu/ckLsJJ0eO56WQtbz3rA57P1GN5fDykrsguGuGkK3LUbitWn6FdlEeezDKEcNiPTeHZjoakcZ4Fi+V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB17148
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Nov 2025 02:43:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20517

Hi all,

CIP kernel team has released Linux kernel v6.12.57-cip12.
The linux-6.12.y-cip tree has been updated base version from v6.12.55 to v6=
.12.57.

This release includes updates for the Ethernet functionality of the Renesas
ARM64 SoC RZV2H.

Information about this release is as follows:

  v6.12.57-cip12:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      1f2c83cc9df00f9694aa21974a4af4d4cfb5cd0e
    fixed CVEs:
      CVE-2025-40084: ksmbd: transport_ipc: validate payload size before re=
ading handle
      CVE-2025-39678: platform/x86/amd/hsmp: Ensure sock->metric_tbl_addr i=
s non-NULL
      CVE-2025-40106: comedi: fix divide-by-zero in comedi_buf_munge()
      CVE-2024-57995: wifi: ath12k: fix read pointer after free in ath12k_m=
ac_assign_vif_to_vdev()
      CVE-2025-40083: net/sched: sch_qfq: Fix null-deref in agg_dequeue
      CVE-2025-38643: wifi: cfg80211: Add missing lock in cfg80211_check_an=
d_end_cac()
      CVE-2025-21833: iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE
      CVE-2025-37860: sfc: fix NULL dereferences in ef100_process_design_pa=
ram()
      CVE-2025-22105: bonding: check xdp prog when set bond mode
      CVE-2025-23130: f2fs: fix to avoid panic once fallocation fails for p=
infile
      CVE-2025-37803: udmabuf: fix a buf size overflow issue during udmabuf=
 creation
    added commits:
      CIP: Bump version suffix to -cip12 after merge from stable
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Fix pinctrl node name fo=
r GBETH1
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable GBETH
      arm64: dts: renesas: r9a09g057: Add GBETH nodes
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Replace RZG2L macros
      dt-bindings: net: dwmac: Increase 'maxItems' for 'interrupts' and 'in=
terrupt-names'
      dt-bindings: net: Define interrupt constraints for DWMAC vendor bindi=
ngs
      clk: renesas: r9a09g057: Add clock and reset entries for GBETH0/1
      clk: renesas: r9a09g057: Add clock and reset entries for USB2
      dt-bindings: clock: renesas,r9a09g057-cpg: Add USB2 PHY and GBETH PTP=
 core clocks
      arm64: dts: renesas: r9a09g047: Enable Tx coe support
      arm64: dts: renesas: rzg3e-smarc-som: Enable eth{0-1} (GBETH) interfa=
ces
      arm64: dts: renesas: r9a09g047: Add GBETH nodes
      net: stmmac: Add DWMAC glue layer for Renesas GBETH
      net: stmmac: provide stmmac_pltfr_find_clk()
      net: stmmac: provide generic implementation for set_clk_tx_rate metho=
d
      net: stmmac: provide set_clk_tx_rate() hook
      net: phy: Add helper for mapping RGMII link speed to clock rate
      dt-bindings: net: Rename renesas,r9a09g057-gbeth.yaml
      dt-bindings: net: renesas-gbeth: Add support for RZ/G3E (R9A09G047) S=
oC
      dt-bindings: net: Document support for Renesas RZ/V2H(P) GBETH
      clk: renesas: r9a09g047: Add clock and reset signals for the GBETH IP=
s
      pinctrl: renesas: rzg2l: Fix OEN resume
      pinctrl: renesas: rzg2l: Drop oen_read and oen_write callbacks
      pinctrl: renesas: rzg2l: Add PFC_OEN support for RZ/G3E SoC
      pinctrl: renesas: rzg2l: Unify OEN handling across RZ/{G2L,V2H,V2N}
      pinctrl: renesas: rzg2l: Remove OEN ops for RZ/G3E
      pinctrl: renesas: rzg2l: Unify OEN access by making pin-to-bit mappin=
g configurable
      pinctrl: renesas: rzg2l: Parameterize OEN register offset
      pinctrl: renesas: rzg2l: Add support for RZ/V2N SoC
      dt-bindings: pinctrl: renesas: Document RZ/V2N SoC

Best regards,
  Nobuhiro


