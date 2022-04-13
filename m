Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA2EC433FE
	for <webhook@archiver.kernel.org>; Wed, 13 Apr 2022 15:48:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web10.509.1649810013357626562
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Apr 2022 17:33:34 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 23D0X7Pu016910;
 Wed, 13 Apr 2022 09:33:07 +0900
X-Iguazu-Qid: 2wHHts48jRMimbt4kt
X-Iguazu-QSIG: v=2; s=0; t=1649809987; q=2wHHts48jRMimbt4kt;
 m=vBIJo/VUR2cQDvFieZNQaXoN5i3i3ApD1eQICfGchGY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1110) id 23D0X3dR026117
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 13 Apr 2022 09:33:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrG091hVBDJOGYdGee6BRLDbacjO48w5m5i33gMfizeIbxyx+DOgQamUVVf+hTcjFkjzxTTpRsj1Fhh+cOcJR0TlBUwztHcVP1CxV1+SRx8WfZNOcNGENdvctH96vuvHXdkjEDkthI7UM2NdXF71pvMDFwIwlfhSS5NsW49upM8OckuHNCzQ0uN0SG7ywS6OBfGn0biaH+C+ahdN1+VC7OMC6rkP8/bCG6EdzcOQQ3NBeFZgkY8GKBInl4SeUWomZ2eplQo8ObR8omS0ZLkkIuVmrUE+iHp7Et6xHqGBNeLTPeaYMeetNcqVigc98SamYnP2k098RxcIXi4OeIIihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAKKSYNhuasEs0o61w43axCUqk/yTzwH7WZ4ySH1bTs=;
 b=RCcIk/0d1olc8lTei9kkofBWzFoOfwIHaYQCZc+un7miym+HDLwlGYMIBxYzW5N74LTze79xRy5Mw5oSwFtiXQGucFwbPSkzIqfClF5//vf7T6B1Yf7mJg9+bK7qZ39y6eDUlfQg7sy7qiaiA96B4Efgca++p7oLMJFriPt9iBmXqEc4JsXJxJO7AMucH1cL/rP0oDkd2aO8v9h05SoSnoOqzVIx+UPpCmVNQv33Sz35yRF5dYlf+9tk2qeZffDVrhQKUB7zfa2m5PCBzcyz95ev1teSpa4xzKfUpfYE7ND0zOrDGaKqOLW3w9pqXsiuGXWoKqZXpoE2nWNUWjdqaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <pavel@denx.de>,
        <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v4.19.237-cip71 and v5.10.109-cip5
Thread-Topic: [ANNOUNCE] Release v4.19.237-cip71 and v5.10.109-cip5
Thread-Index: AdhOzasrz9d2LN6vSQ68j5CiQZmkbw==
Date: Wed, 13 Apr 2022 00:32:44 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420BBFB378AB628410699DD92EC9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6800f5cc-a26d-4a77-c0df-08da1ce52063
x-ms-traffictypediagnostic: OS3PR01MB5589:EE_
x-microsoft-antispam-prvs: 
 <OS3PR01MB5589039DFBD63DC3C1943C8292EC9@OS3PR01MB5589.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 DHYzpWsKTglCfvxoNqT3DWqMI0ezgGbVy6RyAt19T5H0Nl1cHsgV2lMJk1XmaNNbrB7KuPuUg3MVkSA2FNXsCwvWI2ZfGIQnWD8J1Y6fOLy8ABzaD42/PyM1VqWIEa92dTPbb0chhgGYcyrVAr9fiwXiRDQ/v2ByD1i/KQtMIKrsJG1+bLG03UZBQUvQ9TxKv8qUY+SupGFTM3mOQotr9OhVMYMyKvFy/KCDknorYlYrkp1VsG09RTooFpCYg0kkGNPJWvIeh5TQ3tYln/u+gzbqpmUcqbfsmOiA48cV8+tTekkylx0+tbM9BfM6HNlEvvddORyaoKkF5SRFTY7Pr0frO0EYew5jQ9HGz78gZ4k0ddS7yX4XL7l87ltqPZjyFR1xSsZc80B8HhYluJYCxB2NhPpGWVMZ+zh8eT6gqJCAWrixFulQU7z+YY7yCl8lYWYO1DIz/TMSwpwdvZO350Bfk7J+UMcjhVevU4X2N2rqM3R9P9RZhKR6qMwMNY2OMzj3RFgYxD8OdHbnATBqnuFisFdcbNE45lA049lPLv7YULGvtD5THyjnxN0pk7GIioesYbY5pDJ1qRbbAC4ET50gov2zkQK2y0DAp7rs+dtbjfwc/pMVrvQheSzanC8ra669bVfR/3Vp6pIA6P1hxiDOJzIgImlLsxtZnRlrWmXyDHqKGrNt3M3GeChoa/WnVfpMHBp+b5Y8UTW9QcnINoOx8xGFpkeTdQmMv5CRzhS0PQeFWe9Sf/aR6TN4NIFR4otT64v5rvmU/oOPYhUjeld5PqQrDO7uw5xiiEWWKS4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(64756008)(66476007)(66446008)(8676002)(4326008)(2906002)(76116006)(6916009)(66556008)(38070700005)(9686003)(7696005)(52536014)(6506007)(5660300002)(33656002)(55016003)(71200400001)(8936002)(83380400001)(122000001)(508600001)(316002)(966005)(54906003)(86362001)(186003)(26005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?enJRVDV3Y3JhNDRSN0w0aXZhc0VCck5uNFZZNzZ0aXhqbS85Q1pFNzI5?=
 =?iso-2022-jp?B?VmlOMHBycDZCS1BUWTR0UC8yR25WWnJFTlJxMzg0VXRFTkI1T0FaMXV2?=
 =?iso-2022-jp?B?aFEwcElMVlNwa1YvOTY2YU4rVFhDUzVWbmw2RnhFN0NBeURkYTJ2V2gw?=
 =?iso-2022-jp?B?aFZwdWFSYkFXWnZjcE4ySTFodUJuOU14bDVPQ1ozb05qS05mY3RVSzdW?=
 =?iso-2022-jp?B?ZCt0YTRQVFQ0dTRjN2k2MUcvc2c0cUdRUWJBWWJTMjlFYklhL0tUVVVz?=
 =?iso-2022-jp?B?SXpJdWsrYlB2Wk1McXd4NXQ2VW1EQVNYRGVNWk9LYWdHQ3h4YkZadFQx?=
 =?iso-2022-jp?B?QmJKSXVVNTZ4VndaaE1iYTBPNUlJNVRZeUM5Y28xUnVwTUVsYWtQRmM2?=
 =?iso-2022-jp?B?WXM4ZnFDUGtzMkhuOVV2T1QrMlZXU2VNRmNYc2M5WDR2cXdNUkpCK3Ar?=
 =?iso-2022-jp?B?ZTluQkVXK0l6Ulk3M1V5MXN6S0c4aXFFK3MzMkxtZkh1ZWZ4UGMrWlZP?=
 =?iso-2022-jp?B?T0VnMlpZc2RBN0NUUmx4NDZ0SGkxWU5XNWhxUVdGRUdpM2hIcFJWRGhn?=
 =?iso-2022-jp?B?UHlpajB5UXRBWTIzaDJLSm1nbE45aENDSkpVYjN1UmxHUDFpL1pBdW5L?=
 =?iso-2022-jp?B?ZnYxU2Vla3h3VXBuK2V5bXp5WG1qY21vbWs0dXBhNXl3RjgvaHlPL2dU?=
 =?iso-2022-jp?B?d01EbURXaTVNcGNMRXR3VGRrc3djdUxEZzBwMzd6K1IzMGtKUHNaRzVl?=
 =?iso-2022-jp?B?M2JlZFNIZFhuOHl4a3VHaWYvZWZwZnFvL09lK2lJdHc0aWtjZ00xQ3pw?=
 =?iso-2022-jp?B?MklPbHdZUEhOUFhWLzh0Mm1uWEVLd0hqc2I1ZWJoMkxqK2RhNG50L08w?=
 =?iso-2022-jp?B?V2xwRGJ0Q3FiTWFRWUFZNVV6YThiYW5pOFR5U1o0Y050emVJSG1QOHhs?=
 =?iso-2022-jp?B?eTJnWUZ0bml3Q3d4ZW5qZUplZVZxYkFnTzMwWEJYZVcvWGRydmJkTlRn?=
 =?iso-2022-jp?B?NXYvWG9tSlZyalZGSXZVUXhqcDM3c3ZsekxIN0MvaUFIS3dSQk1jK3pI?=
 =?iso-2022-jp?B?OUhXVmRMWWZHc2ptRlJldk5jMHhOZ3pnNU51amVwUGQ0Q1JuaVNzNGlk?=
 =?iso-2022-jp?B?UDNLcmN3YWpqc0JPRmQ1YzR0R011L3JoLzEvWnc1amR6blllZkV0Y0VG?=
 =?iso-2022-jp?B?NUNOTU83UUVrVmhCaXlncDJONFV1TEl2ZEFqTmYwakpJdGl0YW9mMWJX?=
 =?iso-2022-jp?B?dU5KdFRYbG9TQUJidkxDZVpjb3pScXVoTGZVS1JRQmE0YWhzazg1bnli?=
 =?iso-2022-jp?B?cVhaa2ovTEZueHF5elVuVG9JS1dtQy8xS2c5WmJOUVltQmpYSUxuenBB?=
 =?iso-2022-jp?B?bTB5cklOT21WVktJN2FrOElGNGpibXoxQ2p6M2x0c3NCb3FsQzk0aC96?=
 =?iso-2022-jp?B?SzQ0VU40TmNvckNwcm5jeEl0V0dJRU9EOWNWN3YzVS9oaVdSQngyVDdl?=
 =?iso-2022-jp?B?V2F1c0RQK0Y2N2RBQXhvODlHWXpYeUY4OHdMWE5ub3NoRm03NHdlZWJO?=
 =?iso-2022-jp?B?NHRMcVIvMTZiMnJSWDZNVXh0MWtmbllzK2pTRW81TFlFRFVLK05tY3Q0?=
 =?iso-2022-jp?B?RGNKWW9zYTcyMUgyZk1jeWVWMmc5NHRkUW53RnduOTlqOExkSmNkNkhO?=
 =?iso-2022-jp?B?WlJ0MmovM013eWtjaVU0ZlhxWnhIYUptVzJnQkdiVHVpNlJaQ1JyUDFO?=
 =?iso-2022-jp?B?NFduTHJlQnBtSGZ5RFFvSWdib2pvRm5Kc2RrZ2Jpa0V1aFpKcXVqaitE?=
 =?iso-2022-jp?B?dlYyNURTcm9wYVd0SDlVR2tnclYyWXZuVUQyei92Zjdtb016OVhlQW9X?=
 =?iso-2022-jp?B?c04vSFRPZlVibWR3NjdHbU5DMXVWRm40TnJvWnZFcjNac05rU3U5cDF4?=
 =?iso-2022-jp?B?TE9SYU9wNXdUM1lSeENWZ0tiQUR4YzFuNTVvYm9BeXVrdWp5VzI0a29v?=
 =?iso-2022-jp?B?czFyUXU2Ukx3aU4yd1FLMlNQZ0ZvQmtCL0k2Wk9XeUN1QXRCMzZFVFp4?=
 =?iso-2022-jp?B?U1NoWEhFRTVmRWlFU3Fob055cFFtNTNWeUwyL3hwdDh2cDVhcEh3U1JH?=
 =?iso-2022-jp?B?VGJwcDdpSHRBdjViZFdaWFdqbFYvWjJQZ2sybFZHdDVWelFlMUpTUy9L?=
 =?iso-2022-jp?B?UnZ4M2tFa3NNQWk0SDhTYnFza2t5Vm1EL1c2UGU4aDZTRDRPMGd4bEVK?=
 =?iso-2022-jp?B?ZTJ0WkxxWnBxZzQ1QzNUZ2o5TEFGRHhSY0RjMFNYeFRFWFZXaEhzdU9r?=
 =?iso-2022-jp?B?b3FNY0dDaExGaDVEdHJRLzRnUXdObFdnUGF1VG5tbnlJclVTeS9qeVRC?=
 =?iso-2022-jp?B?TzQ0bmJPNk16VDl4RWY3c3pVa25rblg0bFNwU0NnQ1NTWXJuVlNkSHdI?=
 =?iso-2022-jp?B?a3p0ajVPWlJTK0g5N29PY09pN2txazZvMnNMUkNhQ0xxb0YzenpWOEI2?=
 =?iso-2022-jp?B?R2djTi9QNVZYNXV4TklYZlY2bVdieERlcUp2ZEw1TG1EWjMwYllIY1ZR?=
 =?iso-2022-jp?B?c1Vna0QyaVBpcldDZm1uN1lLekpiNnh5eVNmag==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6800f5cc-a26d-4a77-c0df-08da1ce52063
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 00:32:44.2374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 bacdRa3mVcgOVNFXpuhd0TQMcryMqQmV/dBBWO9+k0Ae3CisXbfoaF95EKmzY1vY+yeMVljwNSSzbMSTi3WqsCIW8++GcVWk2BEMFMVf4xPhdo0QxKcMRIwKdRw+rrTG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5589
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Apr 2022 15:48:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8049

Hi all,

CIP kernel team has released Linux kernel v4.19.237-cip71 v5.10.109-cip5.
The linux-4.19.y-cip tree has been updated base version from v4.19.235 to v=
4.19.237. And the linux-5.10.y-cip tree has been updated base version from
v5.10.106 to v5.10.109, adding SDHCI and SPI support for RZG2L (r9a07g044).

You can get this release via the git tree at:

  v5.10.109-cip5:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      9c39c65c57028fa2c58fb7579c15f9cb67571acc
    Fixed CVEs:
      - CVE-2022-27666: esp: Fix possible buffer overflow in ESP transforma=
tion
      - CVE-2022-26490: nfc: st21nfca: Fix potential buffer overflows in EV=
T_TRANSACTION
      - CVE-2022-1048:  ALSA: pcm: Fix races among concurrent hw_params and=
 hw_free calls
      - CVE-2022-1016:  netfilter: nf_tables: initialize registers in nft_d=
o_chain()
      - CVE-2022-28356: llc: fix netdevice reference leaks in llc_ui_bind()
    added commits:
      CIP: Bump version suffix to -cip5 after merge from stable
      arm64: dts: renesas: r9a07g044: Create thermal zone to support IPA
      arm64: dts: renesas: r9a07g044: Add TSU node
      arm64: dts: renesas: r9a07g044: Add OPP table
      dt-bindings: thermal: Document Renesas RZ/G2L TSU
      clk: renesas: rzg2l: Add CPG_PL1_DDIV macro
      clk: renesas: r9a07g044: Rename CLK_PLL3_DIV4 macro
      clk: renesas: r9a07g044: Add TSU clock and reset entry
      clk: renesas: r9a07g044: Change core clock "I" from DEF_FIXED->DEF_DI=
V
      arm64: dts: renesas: rzg2l-smarc-som: Enable watchdog
      arm64: dts: renesas: r9a07g044: Add WDT nodes
      arm64: dts: renesas: rzg2l-smarc-som: Enable OSTM
      arm64: dts: renesas: r9a07g044: Add OSTM nodes
      clocksource/drivers/renesas,ostm: Make RENESAS_OSTM symbol visible
      clocksource/drivers/renesas-ostm: Add RZ/G2L OSTM support
      reset: Add of_reset_control_get_optional_exclusive()
      dt-bindings: timer: renesas: ostm: Document Renesas RZ/G2L OSTM
      clk: renesas: r9a07g044: Add OSTM clock and reset entries
      watchdog: Add Watchdog Timer driver for RZ/G2L
      dt-bindings: watchdog: renesas,wdt: Add support for RZ/G2L
      clk: renesas: r9a07g044: Rename CLK_PLL2_DIV16 and CLK_PLL2_DIV20 mac=
ros
      clk: renesas: r9a07g044: Add WDT clock and reset entries
      arm64: dts: renesas: rzg2l-smarc: Enable RSPI1 on carrier board
      arm64: dts: renesas: r9a07g044: Add RSPI{0,1,2} nodes
      spi: spi-rspi: Add support to deassert/assert reset line
      spi: dt-bindings: renesas,rspi: Document RZ/G2L SoC
      clk: renesas: r9a07g044: Add RSPI clock and reset entries
      arm64: dts: renesas: rzg2l-smarc: Enable microSD on SMARC platform
      arm64: dts: renesas: rzg2l-smarc-som: Enable eMMC on SMARC platform
      arm64: dts: renesas: r9a07g044: Add SDHI nodes
      dt-bindings: mmc: renesas,sdhi: Rename RZ/G2L clocks
      dt-bindings: mmc: renesas,sdhi: Add optional SDnH clock
      dt-bindings: mmc: renesas,sdhi: Document RZ/G2L bindings
      dt-bindings: mmc: renesas,sdhi: Fix dtbs-check warning
      dt-bindings: Drop redundant minItems/maxItems
      dt-bindings: Fix errors in 'if' schemas
      clk: renesas: r9a07g044: Add SDHI clock and reset entries
      clk: renesas: rzg2l: propagate return value of_genpd_add_provider_sim=
ple()
      clk: renesas: rzg2l: Check return value of pm_genpd_init()
      clk: renesas: rzg2l: Add missing kerneldoc for resets
      clk: renesas: rzg2l: Add SDHI clk mux support
      mmc: tmio: reinit card irqs in reset routine
      mmc: tmio: reenable card irqs after the reset callback
      mmc: tmio: always restore irq register
      mmc: tmio: always flag retune when resetting and a card is present
      mmc: renesas_sdhi: do hard reset if possible
      mmc: renesas_sdhi: break SCC reset into own function
      mmc: tmio: restore bus width when resetting
      mmc: tmio: abort DMA before reset
      mmc: renesas_sdhi: use custom mask for TMIO_MASK_ALL
      mmc: tmio: support custom irq masks
      mmc: renesas_sdhi: Add a condition of cmd/data timeout for retune
      mmc: tmio: Add data timeout error detection
      mmc: renesas_internal_dmac: add pre_req and post_req support
      mmc: renesas_sdhi: populate hook for longer busy_wait
      mmc: tmio: add hook for custom busy_wait calculation
      mmc: tmio: set max_busy_timeout
      mmc: renesas_sdhi: sort includes
      mmc: renesas_sdhi: don't hardcode SDIF values
      mmc: renesas_sdhi: improve HOST_MODE usage
      mmc: renesas_sdhi: remove superfluous SCLKEN
      mmc: renesas_sdhi: merge the SCC reset functions
      mmc: renesas_sdhi: clear TAPEN when resetting, too
      mmc: renesas_sdhi: simplify reset routine a little
      mmc: renesas_sdhi: populate SCC pointer at the proper place
      mmc: renesas_sdhi: probe into TMIO after SCC parameters have been set=
up
      mmc: renesas_sdhi: only reset SCC when its pointer is populated

  v4.19.237-cip71:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      281476f1d7ee9f59c39dc78e7adb7238cfa54bd0
    Fixed CVEs:
      - CVE-2022-26490: nfc: st21nfca: Fix potential buffer overflows in EV=
T_TRANSACTION
      - CVE-2022-28356: llc: fix netdevice reference leaks in llc_ui_bind()
      - CVE-2022-1016: netfilter: nf_tables: initialize registers in nft_do=
_chain()
      - CVE-2022-27666: esp: Fix possible buffer overflow in ESP transforma=
tion
    added commits:
      CIP: Bump version suffix to -cip71 after merge from stable

Best regards,
   Nobuhiro


