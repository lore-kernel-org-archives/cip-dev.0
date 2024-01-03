Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308ABC3DA6E
	for <webhook@archiver.kernel.org>; Wed,  3 Jan 2024 10:32:14 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.71])
 by mx.groups.io with SMTP id smtpd.web11.14808.1704277926469124135
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jan 2024 02:32:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ECluS+/N;
 spf=pass (domain: siemens.com, ip: 40.107.21.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTa6L90gCQLbAXYDcXfGEjyfpGHTcn82p001f8CC0hTtnY7Bl2b0azW25UQ6i6oyWMXbC7KVGMY1glAiBpXzx7FisaXNUqYrQv804cLj9/Jieq5FUworIGafQyWszg6iB0XOFTKajvyKR9UVaz0II5PIrGJw7cGjQL2XXWhlNslkEb/b8Dy891UwOiFZ6nWdjx2Pvm9/SO8jnly+zGcXDot9FzUE4Xhmif6VTlw6sueIVVuNpd8WV5Xz2BpeglniWE6ERYSgJmD14IvEp2jVNKhIUX31EJ0gqkjjFV84GXIXL+osr6DqQutnvq1W6Yg/3W9zX74SS75OBBsD1eebpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/l0DTgXuMAcJ0gw+uQfeHYL3weUp0MOT3L8HLFnT32s=;
 b=VVmmgbHMRCIW0Hk3l6H/CdQdpNnMa+5e9lXJeMMvzYiOnINevlFUqPhtX+pumkBjSNCr7wD8e4ppwT0AWG6O+QMSgTJJ1huXIftQvyjUrCc+nyBCi+9jJWHMk65eMn91/3jCct7U2Y/UDvfYhF6FbPpMYPmcX6BB61DUk9NgKhi8RIHqsBIcCIhS98q0OfdsAEJW04Ak+KEmbAPC0oWYyPnIxw68I+4CqGGTKU+OTKNl0XRNTb0fOTOgdtkse5IkyHSTha+PweLrb4sRA6jEjIGOrcuxn684C8XO26DOFzwslNmoVKuVYgF5IjCcXjOAeUOIicY57ToGRbxuX0JDEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/l0DTgXuMAcJ0gw+uQfeHYL3weUp0MOT3L8HLFnT32s=;
 b=ECluS+/N8zKTitst4tIIRMgqE50E7mRZ+E9JKfvT1n9JStumkIQQbd1RQsS+ZFkcVOymlvM+cRV445WVgkOl7AwkIHD5RsANR+3bWIz25Nl7FDmsSs64S6wZEqSVrOjZrgbKnNJiMw8BRwujLFT/HFf0jsTBO9Zr+dSpvcvjC2lfGL2Gd7j3dpBzFdu+WCWSh9ushXp7xFdgi19goAt9s0GDJUhQYnovB6u4Kd4hxQ+ZPgozF5iSIAj9D0VeY/vC9kPaUMG0zFXbYnuAUbWDzE4ZLC3mmHNXUwhQYlGdH9Y6QMCXIoDkgBEmBPVdRJNoDzx5hAeoCBDZlFZSqE+yfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6770.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5bc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 10:32:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 10:32:00 +0000
Message-ID: <e6b43450-52e5-4529-8006-de503c30df7b@siemens.com>
Date: Wed, 3 Jan 2024 11:31:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] Release v5.10.205-cip42 and v6.1.67-cip12
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de, uli@fpond.eu
Cc: masami.ichikawa@cybertrust.co.jp, Chris.Paterson2@renesas.com,
 cip-dev@lists.cip-project.org
References: <TYVPR01MB1124522792658D6523F2C04C39299A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
 <77cc26df-0e6d-4415-9f06-6916643ed05a@siemens.com>
In-Reply-To: <77cc26df-0e6d-4415-9f06-6916643ed05a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0332.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: 383ae9d9-bf14-4a27-5f76-08dc0c473849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hIX9Jl2X5hBzxsABVHWJDfXnmMPiSYF4yCXnb3N61SOp3wauM09vxF7afRpHfwd1VOy5lffJnVjHay4/gGns78M1s36J53S4/DUevaB3qIf+JzYz9gSAK/ZFEQxQEpI9o+MT9VOgV/serxamCdRNmlQcY3IzBbbDLGphXAx2DaGb0iw0n8Vsl5bYWx/B8k/W86qqn+o/YdoKVgJmJVY6sb/IRnd6Up12clioSCn87dk6OH8aLb9flPLgm+1vf/24b/tvENxSBzKA1JW4mvOGDn0XLLW79ExHNL/8EbZXjOmL6G7mQJYD/oCmllqEiZ/Z9vrlmjVV0CkYI3/fMEG2Mg7I51ci07Ht7qy76sdsA+ULqerlBnnuQ4LvKDrgeYTxtfRbn37pDH9qoUYl+4rV8gYn2hgELnzhRpvBOLY8YgHOmQFcf2EZHLUlQOHxzJTgssw9X4ScmtkO+R/Mi2MtOxVbgNhPb1G/DeDbLHNZ/E9omhBHOREriAMg1Dj3z/HJ2AYLoVFUySAkSdGkcNlpY23UiyW9yfHi/GdKxJD13StRGCU0cR32HQIReLuLMp7spSr4xr6lhiM92DxCimYuNCzqsTcJ2VWvSFysyMr9Nk3kxBLVNWTTS5UwhTjYpVU3euJ79+0iXMuYM1LT9hFtBw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(83380400001)(36756003)(478600001)(44832011)(5660300002)(966005)(31696002)(53546011)(6506007)(2906002)(6512007)(4326008)(2616005)(66476007)(31686004)(41300700001)(66556008)(66946007)(8676002)(26005)(6486002)(8936002)(316002)(86362001)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bys5RG0zRytWTTJBSWZNR0p6NGRGcmhUOWw4QnViSUtKa1E0L2cvaUdsRE9x?=
 =?utf-8?B?TXd4VnFMVFZCSmNST09yYUhKMDVyY0t0NjExRVlTZ2tiVk1pQVNlRkNPQzd2?=
 =?utf-8?B?cmZhamFzUVVxZ2ZzY2wxMFpNRmhKMUhkV3JuM1Frem1VdXMzQWJ1ZjlIdXRo?=
 =?utf-8?B?Wk0rK1kzbWlhdzVhMXdZcXNOaGxKRXY5OHNrR0hGZ2F3WmwxNUttK09aTU03?=
 =?utf-8?B?QmFsdWdQR3A4bmlOQTBLejM5UlozY2VLN2h6TDlTOTUydE5Ga1J4YjB2c3c3?=
 =?utf-8?B?cklmQ2Q3T0N3ZXJkMmNOWFJNcUVNV3hyTTQ5UkdkZlg3MVl1UXlFbFpKbUFG?=
 =?utf-8?B?QTV6MGFYYXRCdUxyVytVQU9lRy9YL2xCdy9kbS9IRUNJUXVIWkp4aEV2OFlF?=
 =?utf-8?B?NXJnQVFZNHl0NXY2bWZJenphMmFhZzRiaERBOVJXRlI5YWtJditTeVNvYStZ?=
 =?utf-8?B?SXAxL1RvM1lnQ1JNaFl5K1VlZEhXZFV2TGpzZFdRWUt6clZxdXczODdWVkxH?=
 =?utf-8?B?cXZBdVE2UlVoeGNrejRMenY1M3Z5MUlIN1dlK3RLZ3FCYUVrR09NUXphR1p5?=
 =?utf-8?B?UENzd0doYThXc1JuNithNll0SnVxY2tsSDBZK2ZvanVheU5BbHRpTEZ2SFZW?=
 =?utf-8?B?NCtBY0J2d1ZPaFROendQL0RHYStjWmVIcVFzemp3Ymd0TndvODJESTR4aHBr?=
 =?utf-8?B?QmxMT1c3Z29DZkhRQjd4L2FqVzN1bVVuWDJyWEcycDhRcnlEOVlPQ2t2V1Br?=
 =?utf-8?B?dlZoV0NLaHp5cCswaUk1N28wT2FGeDJKakZIcVhJdzlZVkNlSUdFNUdySU1Q?=
 =?utf-8?B?WkRGNnZxdVQxMlA0dlI3M2tzRXhqMStKV0ZmeDVBRlBsdnlKNUV4SHdUQzgx?=
 =?utf-8?B?SjdDUXUvV25aUDZLM3BnVzhOV29UazQvOHFkYkRRNXRNRUNKak1qdVJOMURv?=
 =?utf-8?B?c0ZVWlljTVZPSURRenNReHhRSDNudnZrNUsyYTN1UUdaSzRWOUZxNDlUd1R3?=
 =?utf-8?B?OWNtSzNUSFdFWGZSWW5lWkJ5MTBzYUtYck9kSG93a2dQb0FleWVqTkJ0Mjd1?=
 =?utf-8?B?VDhRN0gyanpkaVZ6NzQ2cTdzYkFRaUd2c2lJRXQ5K1J3Y2hVZGs1a2ZyNVFh?=
 =?utf-8?B?cldWMno0K3NJMjlNNndpL01BR1piZFFQV1hFZHlUNVVKNXFKekFEWDF1L053?=
 =?utf-8?B?ZUlZM1RGS1oxQTZTc0tkMmtzaE9XUnl3bFFGQXA1V2xWeldGQURma0toN1dZ?=
 =?utf-8?B?OGN4TzBYWHRVZmVJKy9OT201UXFCeFFNdFloTGJWZDF3NC9sUlZETFRQejZp?=
 =?utf-8?B?dUV2cHYwbzQrM25UZmozZGZPLzVSRE0rZUtGcW1URjJFdS9Tb2I1Yk5kbXZa?=
 =?utf-8?B?L1VSWHYxRHpwd2VOUUs4UXhvZEZMYXpoME9pd1FKR0lVekx4ZkVsYmRnckJl?=
 =?utf-8?B?Ykx3bUtsZXpnMXBmNWlUQWxSaEdTcXVmVUpJR2FSWm5XK1EwdGRoVWsrZ293?=
 =?utf-8?B?dDFHcDZWeHhxdWNxUXpiSzFkUGtFZnYyeVlOWGRBRGFLcXJzUXNHSDJIYlRN?=
 =?utf-8?B?NytIZ0VQVnl6d2RlbmwwbUNMU2RLeFpTQ1ZCNXBqRG53dU5ZemIrMmczeTQ3?=
 =?utf-8?B?VFlYb2I5cmIwTzZzVXZ0YXN4anJSTVowdStGb1g0YjhzNzJXWU9PVnhvWlBI?=
 =?utf-8?B?T0dNeXB5MTFHOHVtUm9XT29kQ1BpUklmTy9YT0tPYnd6dmRJMmZZbmpWdksv?=
 =?utf-8?B?ZlJOMDRUY1B2R1hkdDUyNVhHdjM3VitKL2x0VkkwOSttbUIxRlJoaFQ5azAv?=
 =?utf-8?B?c1Y3N0FoTkNiYkgzYTFnMnAyWVRDZ2E2dVpraURzMzdUSUplMWhVZzgzdWQx?=
 =?utf-8?B?c1NNb1k3RW13d2JpSU5SR1ZrRjl0MGFZR1lKd3RQeGhycjVjMUdwcEJoZEtQ?=
 =?utf-8?B?YnJNaFQ3Z0VvcVJPUFU3WVVVWFZsREI1UWN5Vy9sMXJ0bS8vOUdqMis5UVZK?=
 =?utf-8?B?WFczaUhtcU9yWVhvdWVBaU93R1hld3NtdTdLZWlBVkNDRjcyWXBEbmdrVGFt?=
 =?utf-8?B?K1NGUDA0Nlg0SFMxWnZCU081TG9ZSmF6Y2U5OVNDZ3YzYm52TWI4R21XUHZI?=
 =?utf-8?B?WG1uWXp0V05aVFN5NVpCclVjL1VjMEhxM3NwUG8xSFR4NTFKejQ4Mk9wbUd4?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383ae9d9-bf14-4a27-5f76-08dc0c473849
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 10:32:00.7350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DwbQzElNsrNdcZKIjjjqBDmuNka7jh+S+8N2Ki9QPS5BRC/mIRM8ZQOfG5ZY9xoOEPmX3W+dEROmE3pTWtfSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6770
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Jan 2024 10:32:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14246

On 02.01.24 16:20, Jan Kiszka wrote:
> On 25.12.23 07:08, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
>> Hi all,
>>
>> CIP kernel team has released Linux kernel v5.10.205-cip42 and v6.1.67-cip12.
>> The linux-5.10.y-cip tree has been updated base version from v5.10.201 to v5.10.205,
>> and The linux-6.1.y-cip tree has been updated base version from v6.1.66 to v6.1.67.
>> The linux-5.10.y-cip tree adds graphics, multimedia and clock drivier patches for Renesas
>> ARM64 SoCs.
>>
>> You can get this release via the git tree at:
>>
>>   v5.10.205-cip42:
>>     repository:
>>       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>>     branch:
>>       linux-5.10.y-cip
>>     commit hash:
>>       3ce67a889168be63cffd93c9aa7cf26532711f7b
>>     Fixed CVEs:
>>       CVE-2023-46862: io_uring/fdinfo: lock SQ thread while retrieving thread cpu/pid
>>     added commits:
>>       CIP: Bump version suffix to -cip42 after merge from stable
>>       arm64: dts: renesas: rzg2lc-smarc-som: Add vdd core regulator
>>       arm64: dts: renesas: rzg2l-smarc-som: Add vdd core regulator
>>       arm64: dts: renesas: r9a07g054: Fillup the GPU node
>>       arm64: dts: renesas: r9a07g044: Add Mali-G31 GPU node
>>       dt-bindings: gpu: mali-bifrost: Document RZ/V2L SoC
>>       dt-bindings: gpu: mali-bifrost: Document RZ/G2L support
>>       arm64: dts: renesas: Drop ADV7535 IRQ
>>       arm64: dts: renesas: rzg2lc-smarc: Link DSI with ADV7535
>>       arm64: dts: renesas: rzg2l-smarc: Link DSI with ADV7535
>>       arm64: dts: renesas: r9a07g054: Add DSI node
>>       arm64: dts: renesas: r9a07g044: Add DSI node
>>       arm64: defconfig: Enable Renesas RZ/G2L MIPI DSI driver
>>       drm: rcar-du: rzg2l_mipi_dsi: Reorder bridge attach
>>       drm: rcar-du: rzg2l_mipi_dsi: Enhance device lanes check
>>       drm: rcar-du: Fix Kconfig dependency between DRM and RZG2L_MIPI_DSI
>>       drm: rcar-du: Add RZ/G2L DSI driver
>>       dt-bindings: display: bridge: renesas,rzg2l-mipi-dsi: Document RZ/V2L support
>>       dt-bindings: display: bridge: Document RZ/G2L MIPI DSI TX bindings
>>       drm: of: Mark empty drm_of_get_data_lanes_count and drm_of_get_data_lanes_ep static
>>       drm: of: Add drm_of_get_data_lanes_count and drm_of_get_data_lanes_ep
>>       drm/bridge: Move devm_drm_of_get_bridge to bridge/panel.c
>>       drm/bridge: Add stubs for devm_drm_of_get_bridge when OF is disabled
>>       drm/bridge: Add a function to abstract away panels
>>       arm64: dts: renesas: r9a07g054: Add vspd node
>>       arm64: dts: renesas: r9a07g054: Add fcpvd node
>>       arm64: dts: renesas: r9a07g044: Add vspd node
>>       arm64: dts: renesas: r9a07g044: Add fcpvd node
>>       media: renesas: vsp1: Add support for RZ/G2L VSPD
>>       media: dt-bindings: media: renesas,vsp1: Document RZ/V2L VSPD bindings
>>       media: dt-bindings: media: renesas,vsp1: Document RZ/G2L VSPD bindings
>>       media: renesas: vsp1: Add VSP1_HAS_NON_ZERO_LBA feature bit
>>       media: vsp1: Use BIT macro for feature identification
>>       media: renesas: vsp1: Add support for VSP software version
>>       media: renesas: vsp1: Add support to deassert/assert reset line
>>       media: vsp1: mask interrupts before enabling
>>       media: vsp1: Use platform_get_irq() to get the interrupt
>>       media: vsp1: Simplify DRM UIF handling
>>       media: vsp1: Fix WPF macro names
>>       media: vsp1: Make use of the helper function
>> devm_platform_ioremap_resource()
>>       media: vsp1: use pm_runtime_resume_and_get()
>>       device property: Add const qualifier to device_get_match_data() parameter
>>       clk: renesas: rzg2l: Fix CPG_SIPLL5_CLK1 register write
>>       clk: renesas: r9a07g044: Add POEG clock and reset entries
>>       clk: renesas: r9a07g044: Add GPT clock and reset entry
>>       clk: renesas: r9a07g044: Add DSI clock and reset entries
>>       clk: renesas: r9a07g044: Add LCDC clock and reset entries
>>       clk: renesas: r9a07g044: Add M4 Clock support
>>       clk: renesas: r9a07g044: Add M3 Clock support
>>       clk: renesas: r9a07g044: Add {M2, M2_DIV2} Clocks support
>>       clk: renesas: r9a07g044: Add M1 clock support
>>       clk: renesas: rzg2l: Add DSI divider clk support
>>       clk: renesas: rzg2l: Add PLL5_4 clk mux support
>>       clk: renesas: rzg2l: Add FOUTPOSTDIV clk support
>>       clk: renesas: r9a07g043: Drop WDT2 clock and reset entry
>>       clk: renesas: r9a07g044: Drop WDT2 clock and reset entry
>>       arm64: dts: renesas: rzg2ul-smarc: Move spi1 pinmux to carrier board DTSI
>>       arm64: dts: renesas: rzg2l: Drop WDT2 nodes
>>       arm64: dts: renesas: rzg2ul-smarc-som: Drop enabling wdt2
>>       arm64: dts: renesas: rz-smarc: Use versa3 clk for audio mclk
>>       clk: vc3: Make vc3_clk_mux enum values based on vc3_clk enum
>>       clk: vc3: Fix output clock mapping
>>       clk: vc3: Fix 64 by 64 division
>>       clk: Add support for versa3 clock driver
>>       clk: fixed-factor: Introduce *clk_hw_register_fixed_factor_parent_hw()
>>       clk: fixed: Remove Allwinner A10 special-case logic
>>       clk: fixed-factor: Introduce devm_clk_hw_register_fixed_factor_index()
>>       clk: fixed: add devm helper for clk_hw_register_fixed_factor()
>>       dt-bindings: clock: versaclock3: Add description for #clock-cells property
>>       dt-bindings: clock: Add Renesas versa3 clock generator bindings
>>
>>   v6.1.67-cip12:
>>     repository:
>>       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>>     branch:
>>       linux-6.1.y-cip
>>     commit hash:
>>       33a81955d654c80f6f9626f5bd3def02b8e85b3a
>>     Fixed CVEs:
>>       None
>>     added commits:
>>       CIP: Bump version suffix to -cip12 after merge from stable
>>       ASoC: dt-bindings: renesas,rz-ssi: Update interrupts and interrupt-names properties
>>
>> Best regards,
>>    Nobuhiro
>>
> 
> Seems v6.1.67-cip12 was not pushed as tarball. I only find the
> corresponding -rt release there:
> 
> https://cdn.kernel.org/pub/linux/kernel/projects/cip/6.1/
> 

Nobuhiro is probably on leave right now. Could someone else help out in
fixing this? I'd like to update our recipes to the latest releases.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


