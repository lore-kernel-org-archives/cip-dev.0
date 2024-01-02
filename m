Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640C7C46CD2
	for <webhook@archiver.kernel.org>; Tue,  2 Jan 2024 15:20:48 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.46])
 by mx.groups.io with SMTP id smtpd.web10.31102.1704208843707895958
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Jan 2024 07:20:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mdP3sOI1;
 spf=pass (domain: siemens.com, ip: 40.107.21.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+GlP7NdAj9FnQhRQK+r++uUJt5JmE6UuhNXjqtBz4XAN/uaFiQRMgHF5DSDfdrZHXi95ACrtvpJhm5Sl1nf82ihg/yOXmWO6t9nZ6l9+3FNei1LW20fU+UFMqSyN7KKHlpayOp8rVMC8yEX8EnHgdrY7sKJvk/LRoKlFGgBz5MKkQPB0EJl9a8W6LhglW/Ma82SjiVHbV1+l9DfJzQxbVR1Ab+MhxFNpix3frjYHYFf/G9in97t/+C4XDGptcY52xpS9tEfbgvz7ohjWihqAlCbTPpXY0bDvsiCiGp767aNXHJrWuGrOqrAxBY8Nm/HkDeq9Eo7RQTvwta22vlKyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/dRD2sXKNISDcHeDjc1u/haZWukZ/f3JEBQh2juN98=;
 b=lz8dlZ+dnVhVMkxFB3FfwAtgcXwSTjxC+WueHiRkvooieYeE82jQykK5GGA76zJFrh8TkGHOohrN5jMqEeU8B709r6ROuTzqkIkI1FhWc8QprRtIQwLYBzUghVEWj4VtCVqEIe0kbeelTOmnkGm1cfnEwNVkiGxgBjPS5agbfcbNo+IJuSJO5F8Em6vYZL11S+Kd/BtUcylYypLpVkFcGR2JD1RERT2noOVwkLC8x4Aw3tc288BQN9p2JFx4lQ9IiO4YzY2dYz8QR4h1ag6WxLTGwRLSorpiFbmW4iyKfDU2Etn4B/DYH2YIIzlgJYSTJfcsPfI3e1qzK8+bFL/IeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/dRD2sXKNISDcHeDjc1u/haZWukZ/f3JEBQh2juN98=;
 b=mdP3sOI1EkNsZDbTiWUjRoYaHoTDgmJbcdqEPMJ4LP5mtlqjdQ5k6/vUaxqcyQJALPBwP+ECZLsvxvPrZvzvy731bR9o7Lm3pxQzrNAphVht8ALh0K5B6Svqz/BFzJV41gRZLhNW5NS/iDXnR/e5+rmzx8hm1jQjIzLBjbeh9H8Y+trIqeKCFJljvhjJFZsYdbdZzWO0TzLKAySaf7BsPEbsBh+280rbJT3Vos2ofOCHOAMkB0H/Xy4bbuemb1i+KXEz70O84yhc3Btvwf7DNDy6EuQfh2eM8n6C9YEQo/O9FdJb6sQhi8sv7R1RQdaWCQWWIMSa0eMKgwtVdU0M0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6986.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:305::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 15:20:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 15:20:40 +0000
Message-ID: <77cc26df-0e6d-4415-9f06-6916643ed05a@siemens.com>
Date: Tue, 2 Jan 2024 16:20:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] Release v5.10.205-cip42 and v6.1.67-cip12
Content-Language: en-US
To: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Cc: pavel@denx.de, masami.ichikawa@cybertrust.co.jp,
 Chris.Paterson2@renesas.com, uli@fpond.eu
References: <TYVPR01MB1124522792658D6523F2C04C39299A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <TYVPR01MB1124522792658D6523F2C04C39299A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: d81191a2-5cc2-477b-6018-08dc0ba660fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UP/s3ceR86TY9XKUp4sSG+tLuXGiVISYv3s3mazYKneCClTDymoyDdzbV86QNA7nT98PFm7XFWoZuVXg9m9IhMM6z+QCZE33RS5Ll7fBIHctgOKLI4N+r+5H2Lx8lMNVikHftr8UoMO8ANbTum5E+FhEL0aEH3wtihhbi+6gPOk+osqZQQdb8uYdsj+vdQ5yC/4tIvQL2LFkWd6hxIBQTkGk/geu8hcreZwLUgis7Ion6IdN33CQ9vrXaSvfw/8yxn1IWigypVqeK0rmqTn2MlkxJHyHmlNPMa4ZlsKJLO1Fh8wWIFbqfLs3B/eHwqf3fN6mejmmw7vYhPcNAk8WyGO5aABCJyGgN4np/8FOgvoVqekjZjbaUQ5uoVFyrylPil2QC26GBfdp6vmXOkIATr90LfFy4CGZUF701NWkdq8rCTX0DM94l/QohBciK3oboPP81NXGGOIQlVr0817hmhegYU9z8oxjtdrqqG1l1gqvr/zgy19WIOgA5z1Cw25TSeU6MorZ4Vtnjc/03d8NUshT2Z/1b1Cvn+WYg9Cng0H3E4I3zsrJ9DaOYfnvIEQbCyS9qGd/R5sG9VgsKFU5Hr+xoiZaEVE5NqdZKcij/l2pagtSJ43Ws7wXBG+pPx/7NVH4wu23AnNwCQ4N5NuXyjrXZ3KsjKCXdcN11QSrCgLRSbDRqT0UwziEH+khj6xq
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(83380400001)(38100700002)(316002)(66556008)(966005)(6486002)(66946007)(478600001)(66476007)(5660300002)(2906002)(44832011)(4326008)(8936002)(8676002)(26005)(2616005)(41300700001)(53546011)(31696002)(6506007)(86362001)(6512007)(82960400001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UkY5ejlMb1labU0vakJWd05uUldMRkdPRnZoWXBuR09DZ2JtRTJDWFVOanZ6?=
 =?utf-8?B?VWx4ZUE5ZGJMcHNZUFhiSDY0aVQ5VDdkZFNLQ1FvZ2srRDVRZkIwSy84bEdz?=
 =?utf-8?B?ZGtKSk1KbnpUcTZja29WNmZqalRWS1BiS0RKTTJyNStyb3o4MitmTW9CZFFj?=
 =?utf-8?B?ckhOR1JQSTI5TGdmVXdXa0ZyMUgweUlTVm5VdU1ZejI2S3psNTV1eXpVekNu?=
 =?utf-8?B?RFdtVml2VUErbnB6bTRnWFZ6T2cyUHdvaldPYXRKTWNBT2M3OWYzRWFZVXlx?=
 =?utf-8?B?RXNDRktzc1EwQkhtRnZ4M0k2T3VqUmNsdi9zOWdUQ0VvQ2JsTWNpYWV1eDN0?=
 =?utf-8?B?eWJncXp0SnF0UldOK1dGUm15bW5UalJQTHJac2t3SU9IZktGdUNQcmRwbkxp?=
 =?utf-8?B?QTdSNEJ6c0xIZTlmSFdDK0kvT1JsUHhXTCtTVFdYUUxlM2h4aTRhdUc4T3Fi?=
 =?utf-8?B?WUg3SHpWcmtGVytONWhObndveU5zMUZZcDJiWDIxRS9yTFZqT29zZWg5S1Ri?=
 =?utf-8?B?dVFEaFM2YnRqU1BpU0hhN0hrS3ExQngrcnVlYzExd2dmeWJaOFVFVG9pOVBo?=
 =?utf-8?B?OUw0aDl5SlJPVHZWTHhRMmtnUzVTR3JlOEVSOTVBZFNkMGNXMjJHd0w5S2g0?=
 =?utf-8?B?YzF3cy9nbjRUVU9KMThPa1k1WWFjd3E5YVNpaWR2UW9pRkFUdy9QaDBrRUF6?=
 =?utf-8?B?TGNXMWdzWFh1c1A3ZEhTZi9xUkJmQ1FRS0ZqcE9LQnpGL2RaVWlHT3I0amFO?=
 =?utf-8?B?TDU3V2pJODBXT1c3aG5IK3VTMFppZUVkWDRwa01YS1BaSWltMjFIT3lXOHNo?=
 =?utf-8?B?dHV6emJkRTYwdDdERG0xOWlJRmJVMTl2WFpwNmFTMGNOdDdnQUp2WDk1Sklk?=
 =?utf-8?B?bHAxQ1FvdjhOajhmUnZWdkVrWmVwTjRnOTE4ZjA3K0x3MncwVzJpZUk3V2k1?=
 =?utf-8?B?bHAvZ1ZyUUxkZ3dKczUwTm5YSlpjSkJpSWVzVVRWaWVaUEphVVFiQUl6bEZW?=
 =?utf-8?B?L09UODNFbVNROGhSSzZLQ3JLL2tSN3VlT0tkQ3luVVdTaENqMTFOQWlZMVcz?=
 =?utf-8?B?TWk3c0VpQ09FTmxJN1FmSE5yckJVS2lyNUd5bmNHajY5STk3YkNZQVp4eVhn?=
 =?utf-8?B?YXhmVzBsNlhFQXBZMmNhTlIvU1ppL0dlRVBpOU9vZHlxMnhUMjhucmIvaHVo?=
 =?utf-8?B?Rm9YdUFPaUNSRFpieWt1U3RYZ25jamdWaUxXVnlWNDg5QWdGY2xGZEJXNEh0?=
 =?utf-8?B?OVRGOUpadmJvdCtLNlllc3dvbTUydlZsYy9GaVZnY1o0NS93RldldXJtSGw1?=
 =?utf-8?B?ZVRkZTBaanFQaEIwSmhzNzFQc3NFR2U1bVFrUFpyeklaTmtSbG1od0IydDRt?=
 =?utf-8?B?V2V2Yy83MUF1czFsNnZXZC9DRjk1SmUrODZScmFnOWVuTzNub1d4ZmZEb3dT?=
 =?utf-8?B?aFI2QTdDTmNURUo5UWJIK3pjb2ZGTFhpQUtZWVpHVkFvTUlBak1OSStHZlVz?=
 =?utf-8?B?OUl3Z24waHVoQUFPZEtlcHlaZVBOYUZySEVVQ1FVOWRrWUQrVW9YMmZ0Y29l?=
 =?utf-8?B?Ylk2WFBsVDFlTFlxVmpHMFFoaXFENVNQQWRZeEpYTVI5SjZyR0pES1YvRWRN?=
 =?utf-8?B?dG8rckJ5angxTDZuM2psRlVEcU8zTEdmYnk1QWRBQm5ZdTVLd0YyMmU3N0No?=
 =?utf-8?B?Yms3ZFJlMGNPK1pSbnladHJ1Nmxtd29lYTZTZHJDV3pDYUFJc1ViaUQxd21O?=
 =?utf-8?B?WXR1QmV4cGhBOHE3QlhOc05wbmJnd1hBN1pkem81Vkp1N3FOWWZMV1dGMks5?=
 =?utf-8?B?ei9CcTBydTBsMSszUkc3Zk8xMGFHdzJBYmFpa2lhYVJyZjhBQWpGL0NmR3hP?=
 =?utf-8?B?YkVkeVo0aktPNzNEOFJMK1MrYk16cXA4MERFUEo2b1VOUERYSGVsSHF5NVpI?=
 =?utf-8?B?cWJnQ3NWQ2ZDaG9ZVHFyYmJDSjVDSlUxSHY3dWkvZU1TWC9XaFdueVV3UEFl?=
 =?utf-8?B?ZGViNFo0VmZiMWluUkVHSk5HOW1HU0g5T3VYUGR5L1QySDZPZ1ZDSldOZlgv?=
 =?utf-8?B?c1JvQ2p4RTVWTDlMZ1FYRStIdStjbFc4eXBJOWJzZ1ZraStOZytzeXZQZ2lM?=
 =?utf-8?B?MFlVdVRFMnRHOVZSUytYKzJFOGEzR0FvOXFxRGlBUGxZMjMzVE9zSzFSdUdT?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81191a2-5cc2-477b-6018-08dc0ba660fd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 15:20:40.0628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+NH5nDiTiCDXGp8SLL0c0VmUk2BQalIZloU0+2DmFxDoGsfgMZ/2hSC4StQgbDyrq6VqnJsXDPCepOAnLDuAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6986
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Jan 2024 15:20:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14231

On 25.12.23 07:08, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi all,
> 
> CIP kernel team has released Linux kernel v5.10.205-cip42 and v6.1.67-cip12.
> The linux-5.10.y-cip tree has been updated base version from v5.10.201 to v5.10.205,
> and The linux-6.1.y-cip tree has been updated base version from v6.1.66 to v6.1.67.
> The linux-5.10.y-cip tree adds graphics, multimedia and clock drivier patches for Renesas
> ARM64 SoCs.
> 
> You can get this release via the git tree at:
> 
>   v5.10.205-cip42:
>     repository:
>       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>     branch:
>       linux-5.10.y-cip
>     commit hash:
>       3ce67a889168be63cffd93c9aa7cf26532711f7b
>     Fixed CVEs:
>       CVE-2023-46862: io_uring/fdinfo: lock SQ thread while retrieving thread cpu/pid
>     added commits:
>       CIP: Bump version suffix to -cip42 after merge from stable
>       arm64: dts: renesas: rzg2lc-smarc-som: Add vdd core regulator
>       arm64: dts: renesas: rzg2l-smarc-som: Add vdd core regulator
>       arm64: dts: renesas: r9a07g054: Fillup the GPU node
>       arm64: dts: renesas: r9a07g044: Add Mali-G31 GPU node
>       dt-bindings: gpu: mali-bifrost: Document RZ/V2L SoC
>       dt-bindings: gpu: mali-bifrost: Document RZ/G2L support
>       arm64: dts: renesas: Drop ADV7535 IRQ
>       arm64: dts: renesas: rzg2lc-smarc: Link DSI with ADV7535
>       arm64: dts: renesas: rzg2l-smarc: Link DSI with ADV7535
>       arm64: dts: renesas: r9a07g054: Add DSI node
>       arm64: dts: renesas: r9a07g044: Add DSI node
>       arm64: defconfig: Enable Renesas RZ/G2L MIPI DSI driver
>       drm: rcar-du: rzg2l_mipi_dsi: Reorder bridge attach
>       drm: rcar-du: rzg2l_mipi_dsi: Enhance device lanes check
>       drm: rcar-du: Fix Kconfig dependency between DRM and RZG2L_MIPI_DSI
>       drm: rcar-du: Add RZ/G2L DSI driver
>       dt-bindings: display: bridge: renesas,rzg2l-mipi-dsi: Document RZ/V2L support
>       dt-bindings: display: bridge: Document RZ/G2L MIPI DSI TX bindings
>       drm: of: Mark empty drm_of_get_data_lanes_count and drm_of_get_data_lanes_ep static
>       drm: of: Add drm_of_get_data_lanes_count and drm_of_get_data_lanes_ep
>       drm/bridge: Move devm_drm_of_get_bridge to bridge/panel.c
>       drm/bridge: Add stubs for devm_drm_of_get_bridge when OF is disabled
>       drm/bridge: Add a function to abstract away panels
>       arm64: dts: renesas: r9a07g054: Add vspd node
>       arm64: dts: renesas: r9a07g054: Add fcpvd node
>       arm64: dts: renesas: r9a07g044: Add vspd node
>       arm64: dts: renesas: r9a07g044: Add fcpvd node
>       media: renesas: vsp1: Add support for RZ/G2L VSPD
>       media: dt-bindings: media: renesas,vsp1: Document RZ/V2L VSPD bindings
>       media: dt-bindings: media: renesas,vsp1: Document RZ/G2L VSPD bindings
>       media: renesas: vsp1: Add VSP1_HAS_NON_ZERO_LBA feature bit
>       media: vsp1: Use BIT macro for feature identification
>       media: renesas: vsp1: Add support for VSP software version
>       media: renesas: vsp1: Add support to deassert/assert reset line
>       media: vsp1: mask interrupts before enabling
>       media: vsp1: Use platform_get_irq() to get the interrupt
>       media: vsp1: Simplify DRM UIF handling
>       media: vsp1: Fix WPF macro names
>       media: vsp1: Make use of the helper function
> devm_platform_ioremap_resource()
>       media: vsp1: use pm_runtime_resume_and_get()
>       device property: Add const qualifier to device_get_match_data() parameter
>       clk: renesas: rzg2l: Fix CPG_SIPLL5_CLK1 register write
>       clk: renesas: r9a07g044: Add POEG clock and reset entries
>       clk: renesas: r9a07g044: Add GPT clock and reset entry
>       clk: renesas: r9a07g044: Add DSI clock and reset entries
>       clk: renesas: r9a07g044: Add LCDC clock and reset entries
>       clk: renesas: r9a07g044: Add M4 Clock support
>       clk: renesas: r9a07g044: Add M3 Clock support
>       clk: renesas: r9a07g044: Add {M2, M2_DIV2} Clocks support
>       clk: renesas: r9a07g044: Add M1 clock support
>       clk: renesas: rzg2l: Add DSI divider clk support
>       clk: renesas: rzg2l: Add PLL5_4 clk mux support
>       clk: renesas: rzg2l: Add FOUTPOSTDIV clk support
>       clk: renesas: r9a07g043: Drop WDT2 clock and reset entry
>       clk: renesas: r9a07g044: Drop WDT2 clock and reset entry
>       arm64: dts: renesas: rzg2ul-smarc: Move spi1 pinmux to carrier board DTSI
>       arm64: dts: renesas: rzg2l: Drop WDT2 nodes
>       arm64: dts: renesas: rzg2ul-smarc-som: Drop enabling wdt2
>       arm64: dts: renesas: rz-smarc: Use versa3 clk for audio mclk
>       clk: vc3: Make vc3_clk_mux enum values based on vc3_clk enum
>       clk: vc3: Fix output clock mapping
>       clk: vc3: Fix 64 by 64 division
>       clk: Add support for versa3 clock driver
>       clk: fixed-factor: Introduce *clk_hw_register_fixed_factor_parent_hw()
>       clk: fixed: Remove Allwinner A10 special-case logic
>       clk: fixed-factor: Introduce devm_clk_hw_register_fixed_factor_index()
>       clk: fixed: add devm helper for clk_hw_register_fixed_factor()
>       dt-bindings: clock: versaclock3: Add description for #clock-cells property
>       dt-bindings: clock: Add Renesas versa3 clock generator bindings
> 
>   v6.1.67-cip12:
>     repository:
>       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>     branch:
>       linux-6.1.y-cip
>     commit hash:
>       33a81955d654c80f6f9626f5bd3def02b8e85b3a
>     Fixed CVEs:
>       None
>     added commits:
>       CIP: Bump version suffix to -cip12 after merge from stable
>       ASoC: dt-bindings: renesas,rz-ssi: Update interrupts and interrupt-names properties
> 
> Best regards,
>    Nobuhiro
> 

Seems v6.1.67-cip12 was not pushed as tarball. I only find the
corresponding -rt release there:

https://cdn.kernel.org/pub/linux/kernel/projects/cip/6.1/

Jan

-- 
Siemens AG, Technology
Linux Expert Center


