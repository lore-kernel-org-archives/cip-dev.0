Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F94C83000
	for <webhook@archiver.kernel.org>; Mon, 30 Jun 2025 06:14:56 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.55])
 by mx.groups.io with SMTP id smtpd.web11.32774.1751264093594448842
 for <cip-dev@lists.cip-project.org>;
 Sun, 29 Jun 2025 23:14:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Fk+ieKXI;
 spf=pass (domain: siemens.com, ip: 40.107.159.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuvbD1Lgn/Y2GLOrGzBgedwjxbTukzg6xItzfHdGCdACQZWgYLKVphORH99TOPUlHVsJqeIKnv+Y0vn2xQCm9YgAPTvbHsmckA8hzSKQQ3aDlhB0vvHISejJTxutd/xyjV2xaKA3St+F1WCVg8WhX148/DSfcC3ZA1p9wp2xlX/ace1LjDqRxzzhtEaU6INl7YnIqefnJ+7YJu+U1xRxQfTbp/c6Iltffl9Roja3Q2hrCDH1sGMsAEb38hmHdMX00nwzf3A1PzdGzoLhhW2h8E2Gx++5MvP7OLMT77jQST9AXRo0lY22XGGB/kR13vJDvUOw/RgauRFEaFxls5347w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=655ZcfJ1KM19jWqAdIRk6Kajct+GOzMBUwopSSQm3UA=;
 b=cAa2oHg/7hbSvRj+yhPn0D9eAydcdoZZtkVhfrN/fO7Io7mgxwi0huAn6Jrz2lcc8a8S4MSjkXE7Q7upyraV2qvtlLCPN3Lzpg6Hb2RoZDUw/UUACVs3s1pW+l8KxO4YfgS/WoFdwdOf2kuGuznh2QwT4LYKRUI9NoVQuSgLXZ5rMueH3emn639NwURjMTtCbBeSGhvefjh7v1OSQBCtaU12XcHqDGHy1tXDOR1M45CYUSOuA95+xZmFfatUMXNHdGun5yDG6kVXeibRN4WJVAC2aJIRigZ0MsHKHlZs7TkgLTxh6kV0DYiIdDdovQX5TVHE45Bp1xMq5OMLRM7IuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=655ZcfJ1KM19jWqAdIRk6Kajct+GOzMBUwopSSQm3UA=;
 b=Fk+ieKXI+fje8kZd40tyJtoY9By/MSypyCMh8mSsfV0cT1WUmC+l3jo4q8VL5iY7iaU+JUae7SHK7yKCCnnKIlu5F3h/upwDj8Ho5X6RkWefmbTIE4MeXi8an/kdV5tM3co8MIXdrwNP7Mr71mObFJognni8AKRSqLAcX/YGYhu3Fp50V4orQV1uvMaEE8dowAxWTKMrcbpVpJ6Otih/9kZ9p0ZHnhyzIixUcv3Yn0nH0yXlQVHo8FJbJKmv26ynyRkL2SlwsAN5WsIYvwbP83JUHRfJt/kJ8S22qReazefHwEqMC0RPbYoO0UK9k7EBgmC2YihtOm+9YwawYZP8YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8552.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:422::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Mon, 30 Jun
 2025 06:14:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 06:14:49 +0000
Message-ID: <f3d44404-6439-4d51-b600-3021f72b5d13@siemens.com>
Date: Mon, 30 Jun 2025 08:14:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/4] initramfs-crypt-hook: implement 'noencrypt' option
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Heinisch Alexander <alexander.heinisch@siemens.com>,
 Cetin Gokhan <gokhan.cetin@siemens.com>
References: <20250626-initramfs-crypt-hook-patches-2-v8-0-46f000788686@denx.de>
 <20250626-initramfs-crypt-hook-patches-2-v8-3-46f000788686@denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250626-initramfs-crypt-hook-patches-2-v8-3-46f000788686@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b738a7-d6d5-46d5-4ad2-08ddb79d6b79
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SlB3V0VKd0tDODJPTndERXQyejNlVUhPMC9RNnRTZ2tiTjVEYUpPVlU5cFBS?=
 =?utf-8?B?b1QyMVlUZ2ZiUDBITDF6VktOcHJyYldScUtOelJGQnp0TjdYbnVwTHJiQjNP?=
 =?utf-8?B?M1plUFN3cGhKdE1xNVBzSGhaZ1RmblVtRklEYUxoeEpKMDVFcXVQNnNxS0E1?=
 =?utf-8?B?b3lUdjZMWTdJV1VlYWRDWGxyOEVqcUJZSGh4UXArYW03cTdHM3RjVnMyY1VQ?=
 =?utf-8?B?Yy9zOGt3WklHVU1uZGtEcjUvUi9xYlFoaStjVVd6d3p0R1B0dTJ4T1JPRmw1?=
 =?utf-8?B?cUJ2QVprZXBuY2U2RXp1UUFRWDNhWjVBNkU4MHZ1ZGcrN0QwRTZlUDA2TDRG?=
 =?utf-8?B?b0p4dFp3ejdsUVlnQnVnalkycUdsekplamczMFlOZ3V2T1VVTzN6bWV5QXMr?=
 =?utf-8?B?cGNlSmpSZXUxbXYxazFhVXFja2IycENVRGJnNUJhbFNoUVE2NU13TFhUd3ZF?=
 =?utf-8?B?bVdqK2l0aHMvbmxjNkZhc0cvMTM3L0U1ZU85QWp1MFBzUmVtOVM3a0ZGb1Zy?=
 =?utf-8?B?cXlxNWtnTElvMkgxSkRaRDRQQ0dmOGRMMTkzUVRtRVBCM3VKTmEzRml0OEQ4?=
 =?utf-8?B?NGJZVnUyY3B3cE5XWktremZ3RW1SYnE1bVRsbHA2SE1KOFVROVFtUDdNKzYz?=
 =?utf-8?B?Ti9la0ViRER6T1JNWWNBdmVlZW95QVBrS3J3M0hiSldMUzU1bDF6U09QTTBt?=
 =?utf-8?B?eDNib0tDWlIrV2hCMzE1eEE3VEZ1SXZ3V2VJOVJWL1VoOGZmanRhK01KUWJQ?=
 =?utf-8?B?QWRqTmNBVHBMRTRRb2YvenBpMmYzV1U5NnhQTkIwVGRITExQdU5kanBURXE3?=
 =?utf-8?B?VDRITVc4Zk5QMGtwSENpRTc1UkR0N0lJQTR3NGJpZlB5T1VqaDR1a28vU1VO?=
 =?utf-8?B?NVgxVzVlUUc0ZXJzWnRPOGt2RGpUSmtsM1NpR0lVV0pUdGpRaDlDY1FqK0hU?=
 =?utf-8?B?VDRidE9vYkJhSUdTdGVUU25RaUp0WDNMYmlSTFBscFY3a0dlOFF2Q3BlMnB4?=
 =?utf-8?B?NkZNK2ZnSFF6UTVZZ0Z2blp6akJqTGJkc0xzWDQ0YkNzY2gyUFBtUkRzNllz?=
 =?utf-8?B?U0NoM1N3dUVwZzZXcFdwMU55SWRDQmNyUFlQSGNZSmFGc0dtZ3ExYlYxaGp3?=
 =?utf-8?B?VWxmMlpTVldLSDBRQUM1Um5PTXY5cXFicnVkaDkvNTdKRjRMbkdBbUd5b0E3?=
 =?utf-8?B?eitsZ09uMDJ3U05TWUNmUEtEZGtQbGxnNFBUSzdsT21LZGxnRkxzQUZFVEs4?=
 =?utf-8?B?SGFoQ2g5b3NPOXlQbnlJUWZuZXVBU1RRWGd6S3lHRUJveDVOeWU2YmhoWmpH?=
 =?utf-8?B?OVVDanJ4SGZYNmpMK3pNd1lXTCs5Sjc3b0VLQUdpQkk4Z0R2cklpVkthQ0NG?=
 =?utf-8?B?SVJOdlFlUmt6TWdkYSt6aWFvSDBEM0JzTk5lM1kyWEROQXhPTmFNeVRXTGFZ?=
 =?utf-8?B?OEZOVWgyOTlZVXk3ZTc1L3Vhb05TNU9UT1NSWm1OUVhHUDU2Vjg5SW9GNEs1?=
 =?utf-8?B?ZnRJb1RxK1VuZTU2T0k2bEw1OWY2RmZvUiswakpWZ2RCenYyRGJsNU1Hd2dW?=
 =?utf-8?B?aG9mNVRUNTNSUWt6VzgvbHBFRkQxemVmeWduUTlDdHpsc3JPV1JGQmRkY1hY?=
 =?utf-8?B?TmI3REJuTTZVT2Ryby93Mk5RUlhqMnplM3hhd0czYkFPYVFDSnRmMEFhWi9H?=
 =?utf-8?B?LytZR0Z1S0o1L3ZyeDUzclFaNTVhekpGMkxyNkw2aUlKK3I4RW45MEN4c0Jx?=
 =?utf-8?B?eHlOamlwdDNNTW5rL2JjT1d6a09FR1FzVlI0dHY0b0lIclBsaEhPcDdRb01K?=
 =?utf-8?B?amNiNmVRNXRaS2ppT2Q5UFVmTVY5WU50eC9JZzZtZ3FHN3RuWGNNdEU3MUpL?=
 =?utf-8?B?c0RIaExPQWowY0NGMlVWTnF4WnFtQVRNNnBjbzg2WmtORmdFL3ZVNm51QTlr?=
 =?utf-8?Q?0qUdwLymWCY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dzR0a1N5SjNTTC81U3NVMnlBYkFUQ0xYdkhUYUxTSytMS1EreVFFc3BpZlJy?=
 =?utf-8?B?RUpPMzdhSUxMRWtYMjRBN2xJY200Njg5OENOV1Q5SGc3M1FwdUlpaUpIR2ZE?=
 =?utf-8?B?TC8wVC83R2U2Wkx2ZUdvM3E1TW51NDR5TmpxYTA4NU9IVmFhN1pqWnJydzNN?=
 =?utf-8?B?T2w3Y2VZVjRKMEozaURGWXN5TzU5STRSL3N4S21WZ1FkQnE5Lzc4K2lSREV2?=
 =?utf-8?B?UVk2Q21xQmN4NTFtRjdBdzl4N3lxd2w2aG5ZUFVWLzFQUkpWRldESjJsN0J0?=
 =?utf-8?B?aWpmN1grZXd4ckxsMjVmSGZVV09heGJHaVg5M05iNmE2K0g4d3Z6MllncmVM?=
 =?utf-8?B?N1QzZE03UlhIZlhFc1VPZ2tFU29ZSTA2NktBcEFYUW9hQVNSY0djMCtySy9H?=
 =?utf-8?B?b0ZOclViU0tlRmprTDNRbmoxYWxDVWRUR2Vhd2xLbFJXQ0c2c2R1d2VJQXBJ?=
 =?utf-8?B?MDZZMlMxbHpmSDhOdmcrVTI1UGphMktrRGR2UXR6aGVlVzR4WHVvbUdMZ2ZM?=
 =?utf-8?B?T2R1MWVDN0JjRkFMRk52Mll2dUNZQ05IZjE3c0FxdlN5bnV0MlhITVFVaXND?=
 =?utf-8?B?cWQyUHRCZDRBUUY4aUdyU0h2R0xiMURpaXk5Y1ZEdmw2Syt1SUpvc3pvT0xt?=
 =?utf-8?B?dkRuTVhRUWtUbUU3RTErN1psUW9hZHVUL2hwc0s0VlRiSllnclR3ZEhiN2xZ?=
 =?utf-8?B?S2xTeTF6OWhIdkpndmVvUVFPWVdhTTNFSVFidEZPM2lrUVQxQVRoWENBLzI5?=
 =?utf-8?B?MXVoa1RUcXNIMXhSNXhFeE5GR0xpeXh2azk0SlAzQUJxdys2c0JheFRHaU1j?=
 =?utf-8?B?SHpFdExiSHBhNHo4Z01rYUl3NVViMGlaM0laOXBOQjNXTkNaSisyMnN3N1E5?=
 =?utf-8?B?OGNlTjZ1b244SnhNdyt5TFh6Y3BBNzdCWXhUQlBaS1pockl6clBOY2pjd0J6?=
 =?utf-8?B?cjhmUEdINnNzWXlNS3FRalFiN2VEWk8yUTR6S3B3N3hDTmVjSzc2THI3THhB?=
 =?utf-8?B?Q2hRUDFTNlU1cDU4NllpMlU4VDFhUkhnejFJOW9mbWJFa2JlUlR6T24rSnFq?=
 =?utf-8?B?UVgxZ21pY25XbXVySmFDREZla3RSVU5SNGVvSjNvZ1hOYlJ3YThQNS9GV0tU?=
 =?utf-8?B?c1JuNW5FM3l6TzFEUHBieWZseWd0dTQ4NUNZSnNzTTJWQlBJSk9nTEhiYWFu?=
 =?utf-8?B?dlFEVHFzdTJ4YWVxaTdmSHZvMnVhWisxN3hTdkkxUkM5Qkt2WGZrc3Z6NlZq?=
 =?utf-8?B?UDlSdVFUcEdaNHdmQ1F3VFZiMks4U1ZJeDhxM1U3UEx0amUrT1BUZVZGa08y?=
 =?utf-8?B?cDZJck9qZ2NhN0ZSNGtqU1ExT1F4VWxjN1FqUXhZZ3dRMUw5Sm1vaHhhekY5?=
 =?utf-8?B?bUM3NzdScHVjdWFBV250QmpESEljUktKNytYNTYxK3BhSGxPY0pVZFIwWXMv?=
 =?utf-8?B?ZGZHVm5qSXoyYlkzYnBGbjUvc0h6azF3MFNKaDE2TnlSc3dEM1Roc1YrMUp6?=
 =?utf-8?B?UU9Ua0lkaFFmWFlnSGxIR3czMFpnMnFWcCs3eVBYUWMwdWJtQ1FjcTlRSWho?=
 =?utf-8?B?S3VJd2diMmJVd0puWVBrcDQ0UEFDUVhGNmFWbDNRc2Vvbnp3cWlORmlpYkdQ?=
 =?utf-8?B?Ylo0d1FLRkcrMExCejBNanM4VE91YmdGenNRM3IvYkRwdUVWUUw2Q2VGcVY3?=
 =?utf-8?B?eFBpZUEzeUd1YVVMSWlIVnR1aVBWWUQ4NEVFVTdwcmpjS1BRL3lMWDJJV3dY?=
 =?utf-8?B?aG1GNVVnVGxwWGt1RWlYTWlDZng4bkx3YU85RGlJNkxnN3BKZWh4aVVsdDdt?=
 =?utf-8?B?UjJaeStrM0RobVByRnd2dzFDZWkrMGJXOVBxa3BXcFBQeUE4YlA5d01BMFVz?=
 =?utf-8?B?UGhxSGI2Y2JmWW1JblgrN05lQnhMOE5hbS9PT043UEQ3WitQQTk0Nllpck5T?=
 =?utf-8?B?d1ZkQjJRSUxzYTgwS2FSS015S0RNQlUrT3ZvU2pKdm9RVllWL1hNZzZrTzJj?=
 =?utf-8?B?bXVmdzJjWUFNOWs5MHBjcGlWNkd2UGZMcFJFaVhyNGdaekt4TGoxOGpTMllp?=
 =?utf-8?B?UFFIZjIwYzFHQWlwMEdiQmQyMVoxRWYrc0M5ZTgzVGpwSUVJandkZms5ZlR5?=
 =?utf-8?Q?a5NVlbuD6jjEBWP6b86cWvIOS?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b738a7-d6d5-46d5-4ad2-08ddb79d6b79
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 06:14:49.8826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WPZCjy4TaxwUmdAfMGAJgk4z2qxB80wHELcEMmwzxK+R8+PZPu49FWSQ/zBm1t5/D70fqCkUF3R3Lz3+nvG7fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8552
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Jun 2025 06:14:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19253

On 26.06.25 11:09, Claudius Heine wrote:
> In case encryption needs to be enabled via an update, while still
> allowing the update fall back to work. One update step where encryption
> is supported, but no reencryption is taking place if the device is not
> encrypted.
> 
> For this the `noencrypt` hook is implemented, which requires some
> restructure/reordering of the `local-top-complete` script.
> 
> Signed-off-by: Claudius Heine <ch@denx.de>
> ---
>  doc/README.tpm2.encryption.md                      | 22 +++++++++++++++++++-
>  .../initramfs-crypt-hook/files/local-top-complete  | 24 +++++++++++++++++-----
>  2 files changed, 40 insertions(+), 6 deletions(-)
> 
> diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
> index 3f7e89f34fa4638a42285989e61370d8970afcde..2256f95a039044313807ab75ce219fa3eb7408b6 100644
> --- a/doc/README.tpm2.encryption.md
> +++ b/doc/README.tpm2.encryption.md
> @@ -42,11 +42,12 @@ The initramfs-crypt-hook recipe has the following variables which can be overwri
>  ### CRYPT_PARTITIONS
>  
>  The variable `CRYPT_PARTITIONS` contains the information which partition shall be encrypted where to mount it.
> -Each entry uses the schema `<partition-identifier>:<mountpoint>:<reencrypt or format>`.
> +Each entry uses the schema `<partition-identifier>:<mountpoint>:<reencrypt | format | noencrypt>`.
>  - The `partition-idenitifer` is used to identify the partition on the disk, it can contain a partition label, partition UUID or absolute path to the partition device, e.g. `/dev/sda`.
>  - The `mountpoint` is used mount the decrypted partition in the root file system
>  - `reencrypt` uses `cryptsetup reencrypt` to encrypt the exiting content of the partition. This reduces the partition by 32MB and the file system by a similar amount
>  - `format` creates a empty LUKS partition and creates a file system defined with the shell command given in `CRYPT_CREATE_FILE_SYSTEM_CMD`
> +- `noencrypt` will not try to encrypt the partition if it isn't encrypted already, but will open it if it is. See the section [Encrypting the shared partition via an update](#### Encrypting the shared partition via an update) for more information
>  
>  #### Encrypted root file system
>  
> @@ -58,6 +59,25 @@ The mountpoint is empty as the root partition is mounted  by a seperate initramf
>  Both partitions are encrypted during first boot. The initramfs hook opens `${ABROOTFS_PART_UUID_A}` and `${ABROOTFS_PART_UUID_B}`
>  during boot.
>  
> +#### Encrypting the shared partition via an update
> +
> +With the following requirements, special handling is necessary:
> +
> +- A/B update scheme is used.
> +- Both slots have a shared volume that needs to be encrypted as well.
> +- The system in the field is currently unencrypted, and encryption should be added via an update.
> +- When the update fails, the fallback system needs to deal with an encrypted data partition.
> +
> +In this case, the fallback system needs to support an encrypted shared data partition but would not encrypt it on its own. For this, the `noencrypt` flag can be used.
> +
> +The data partition in the fallback system will have the `noencrypt` flag set, while the update system will set the flag to `reencrypt`. This will handle the following case:
> +
> +- Unencrypted system on slot A is running; the shared data partition has set the `noencrypt` flag and is not encrypted.
> +- Update for enabling encryption is applied to slot B, where the shared data partition has the `reencrypt` flag.
> +- System reboots to slot B, encrypting the shared data partition.
> +- Update fails at a later point and is not blessed; system reboots into the fallback system on slot A.
> +- Fallback system now needs to be able to use the shared data partition.
> +
>  ### CRYPT_CREATE_FILE_SYSTEM_CMD
>  
>  The variable `CRYPT_CREATE_FILE_SYSTEM_CMD` contains the command to create a new file system on a newly
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index e773ec3e165f72de624a17872ed3fa74746f20d8..9038f4b74b94a5c673239da316f0966b77e4b5d3 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -303,15 +303,18 @@ for partition_set in $partition_sets; do
>  	if [ ! -e  "$part_device" ]; then
>  		panic "Could not find device  mapped to '$partition' cannot be encrypted!"
>  	fi
> -	decrypted_part=/dev/mapper/"$crypt_mount_name"
> -	# check if we are trying to mount root
> -	if [ "$partition_mountpoint" = "/" ]; then
> -		echo "ROOT=$decrypted_part" >/conf/param.conf
> -	fi
>  
> +	# If partition is already encrypted, decrypt and continue with next partition:
> +	decrypted_part=/dev/mapper/"$crypt_mount_name"
>  	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
>  			| grep -q "systemd-tpm2\|clevis"; then
>  		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
> +
> +		# check if we are trying to mount root, set ROOT to decrypted partition:
> +		if [ "$partition_mountpoint" = "/" ]; then
> +			echo "ROOT=$decrypted_part" >/conf/param.conf
> +		fi
> +
>  		continue
>  	fi
>  
> @@ -321,6 +324,17 @@ for partition_set in $partition_sets; do
>  		partition_format="reencrypt"
>  	fi
>  
> +	# If partition should not be encrypted, continue with next partition:
> +	if [ "$partition_format" = "noencrypt" ]
> +	then

Inconsistent style - fixing up on merge.

Jan

> +		continue
> +	fi
> +
> +	# check if we are trying to mount root, set ROOT to decrypted partition:
> +	if [ "$partition_mountpoint" = "/" ]; then
> +		echo "ROOT=$decrypted_part" >/conf/param.conf
> +	fi
> +
>  	# service watchdog in the background during lengthy re-encryption
>  	if [ -z "$watchdog_pid" ]; then
>  		service_watchdog &
> 


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

