Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2BFC87FD1
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 07:01:20 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.12])
 by mx.groups.io with SMTP id smtpd.web11.19347.1754463679125028003
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Aug 2025 00:01:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CfbhYSvn;
 spf=pass (domain: siemens.com, ip: 52.101.83.12, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XL0KY6IOmHYaAlySLXFuAkkgLWM3c75T4aQ0lsGItmtcmeVhNyC64DRrryevsbHwt6IIra3fZGJQQMjLHpa7vYQTiOe/LAziKW8TnIkPz5dC/W2CMdUbNtvpivorLkHsIttL4LJJdUnqdcqtW/ZCp1tEtWEgRYGtcJSIxENjroSkuprP7aA1FpXJmu0GrTpS3IpjaRt34hHVNw+ySL9SpYsQNqMXMneBbX6HcrjSqP4ARI8QIQAqdRjKX9H+ryyeGIGAIX98Wg7WvILuAdRqIaj/dyDzGHslCDTDyF9z5OB//J3iHI0vEW2wYiOUV+HtS7HU3QrY0rP5A5tZW3fGEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JMqrZM7cPZJ48Mhjn0bFcVseAUB3/uh+Fg9fkX3xxY=;
 b=DlcZFTqZzNdcRNsD+qJYuJzAjA9yxAQTQaNOf+sT303lUhffTjc/vfBSxwAwHnu5ZH2FoUxqDMacBrHlB28I1VXdUtAlfow7LChvH7ColLUalFKvHNlryU91ncVXwD7nA1F//M3upp30VKIyfFcPGYXW3hYblnVqbpJ0R4uJ9Vf36JUybRdX1Gx0O5xwn7vg5TwBENIlNsuun1NoZQHX1xGKViTngMXzr4HhdVUhvSYQ6dnXLqsZWY3jG70AuCsSN/gsvXOkZQXdLxz+0w9rnJ13B26UVEkHo5mfwj/tbLlfbf90bH6a01qHl9NDmbRRfF7qL7DpGuW5RnHPn/p0/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JMqrZM7cPZJ48Mhjn0bFcVseAUB3/uh+Fg9fkX3xxY=;
 b=CfbhYSvnJT3eSAfNNH3M1d7VKKYvQb/u0ZSCLF1dBxeghFtKoo3hAYsUx6menXR9Vz3+2rj6w0OEfzjjnyS8cOQzPNsB9AHoL9GaXBV0BFUiQblQ/jdLKCZdVN4bbh9ZXQ0CqUzbhApEmN346LCzlShJ2vadvTztMvC695k+PTCxhfPcd/FsP/QskD73EcKk3b1yK8/fb5LO7nrwFmVTJUrib36G/QS94tc3hnzXacfUwQC4uyrDhz9j0hmAaweIG93JFNo2XGHZLfrUawsJFZkiDCgrmdFS8ZHPhfd///rTU3Hfh99BOwwvVtlVSbvBFkw9asKpN7Ftz3cjLImelQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:421::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Wed, 6 Aug
 2025 07:01:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 07:01:15 +0000
Message-ID: <68a235ad-709a-448e-acdf-d206a8428fdd@siemens.com>
Date: Wed, 6 Aug 2025 09:01:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v4 1/2] kas/opt: Add option for not install
 kernel
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
References: <1754457742-4006-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1754457742-4006-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac9b703-77b6-43eb-718d-08ddd4b708eb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VDVCc0FPNWwvdEMwL1pRK2hobFdOOWhrak9qakh4d0V1M3BUOC9XbHZhQWo0?=
 =?utf-8?B?dXozZXV1b1BOdGhLYjNoSTlldmVzRVBpTmR1ZHltUEw3ZkZ1L2ZKWmNuMGh3?=
 =?utf-8?B?UWUwcVcrL2k2Wkx2MUgzakR4c2JRa25KWlpNRUh0cmt0c0U4ejJDTmFmaDEv?=
 =?utf-8?B?Y0JtcDF0TFVIb0hJbHQxSDZpNUYzVG9PN0hzWnVHeDhvQmR6aEdMOVlpd0oz?=
 =?utf-8?B?QUNrdHVwQ25scFNBNjFTNHRtRy9weVcxMzRkS1ZJcVp6TG9tVXFPMUFOc3BM?=
 =?utf-8?B?Y3p2UFY1dXVkdlZFa0VGYjFvVU1sRUlYeDNSVTJTOVl5ekpxL3orNDlwdUJZ?=
 =?utf-8?B?L1ZERDBzVDZiUHppN0ZjQU5pUzFsTFA2ZXAweStiWFk2ZVFXMmk0bVVwcEZX?=
 =?utf-8?B?cWhqOTBXc01NSDFvTHFabFdSS3JaSUJ3U1VzZEhnS1BSQ0hEMkk2MXk4TEwz?=
 =?utf-8?B?UklycWVyVjJudE1kYWFhc0tOVGo4MWJwdlpycFNlWi9iVHBEZlBJL3RhblZv?=
 =?utf-8?B?VlNXM29CZDE5MmNvYjRIc1ZSZ1M2ZERIL2xrUTdPQTZ3MmswRGQ2ODNEaCtQ?=
 =?utf-8?B?ZGdjUStzVHNMM3ZJTXNSOWszZEdTTWw5R1B3Z3lJUER0R2ZmbVhtZmhDL2pU?=
 =?utf-8?B?RWVaZjhkYWF2MjFQUkNTbHNSdEtoVGRPTUtpYmxVZHZRV0lBVTJiMU5VNytS?=
 =?utf-8?B?bFZ1K0RlOTluYWV1REU3elBVNFlvMEoyQ2U5VVJCcDhBQlQzaEpVSVVzV3hs?=
 =?utf-8?B?cnpNR3JhNGJwNWpqTjMrcGlJbGd3UlJweU41UG9rQXBOKzFkcFZFRGg4QXRj?=
 =?utf-8?B?MC9FbEN5VXIwd3BuSnB3eGJRSTlSdFFQeE1ablorNFMyS1NoOHRFanFsQTBk?=
 =?utf-8?B?cGgxY2FLQ2JtS1pPcWFxelN2cVdQeHArOUk2Ukh1U1grK1IyTkljbW1Yb1Nj?=
 =?utf-8?B?OURrR0hGMHRLUzNnWjRXY0JWRWo5N0h4dHBBbUV5ZTBWNnhPVWt1NG9iQnoz?=
 =?utf-8?B?eHhHYVJiUFVBUG1aVmJJNzlGVUR3Y0ZiazUvNGlsZlVkblRMdm9aWSt1S1kw?=
 =?utf-8?B?WnQvTGhjQzhHTnJHOTFKakRnaWkwZ2cySWc4NFJ1Q2JLNjZ5NFRWOHpzVmdX?=
 =?utf-8?B?RCtWYkRDWEptc3NGTW0vM3I5WldzTVZiT0VwNUwyandaQVZVSUFENlRqd3Yz?=
 =?utf-8?B?ZzdBWEdhc01yRlNNVENJVDMycUNBUm5KM1R2UForVlJ5OVJkL2NxYnVuUzdF?=
 =?utf-8?B?YmJwa2N4QXBhWENXZzNHVXpEUXBRS0FCS2grU0pnOFlyZnhaaFdQanoxNUx2?=
 =?utf-8?B?WFU5RkYwNlJiZko5M2Z3TWhFdE9PNGYyQTBLMm9QenlLOEJuY0dWN25QUlpq?=
 =?utf-8?B?L0NyRW0xYTBNekkzTkhuVkZoSEpxc05Rdmprd053ZGZjaGU1VDBZd3cwOVYw?=
 =?utf-8?B?eU8vRkpraENYUWc3ZTBXS1hmbmYwOTBRdTArTCs2UmJ5NlU0S21NZGQvTkc2?=
 =?utf-8?B?N2dUU2trYXhLd0hQQ0xrU2ZldDVPWFhlYnZhUk8reDdHTVlibzIyRzFxS0l5?=
 =?utf-8?B?TGgrSUhxVFBvaklDcHBFQ1pvV0YwODZYSEFaV2lzV2x1UFRhcTFvWE5MYzlR?=
 =?utf-8?B?SUppVkc4NHpwQzJ3ZndRTy9YaEh1WWVEOEtmZGRLcEZRclQwQTBINXM1bk00?=
 =?utf-8?B?WkNYdlMwK3NVajljblVwakhXZW16Mk9WdHRjaWsrT3lOV0lYdjE1M3hpTDEz?=
 =?utf-8?B?WXFlV1FyZERiWEMrMmptUFFtZllWeW1FSTdscFpEaWVLb2NVMWhsUEpDZzlo?=
 =?utf-8?B?VkJWWjA1QStvSjNsQTQxUEFvVmhrR2tyZEVlZ0dOc3hrenNjc1ZXUzFNT0w2?=
 =?utf-8?B?SWtMWmxUbVRUaWgrU0ZKamhxQVgwUFJzNTNhM0M2L1V1QTl2U2ZjdGlIb25J?=
 =?utf-8?Q?U0Gnf6BpjKQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bUZ6WmhoVTFOYjZWNnlhbTYxUnI4YXRXemVPSTE3bTBMN3JJOE1pSXlCNFF2?=
 =?utf-8?B?T0lSTUsvbHlxMHBoaXEwTWZNOFA5UG9VYUlMYUtET3IrazU3b3FNaWVKTmd0?=
 =?utf-8?B?elR2aEpuMnkrNlY0V2FtOHEwYVhNR0c1QUxmeW9zbUIrNTZvMnZlcVpIR2RH?=
 =?utf-8?B?eXExK3JzL29OMUkwZlVGZnlpZ1A0Znh6TDFDczhMWm5qUUlGMWxoSGl3NUl2?=
 =?utf-8?B?aU9YRkZsNnlITHg4YlBCWFlGNjdSSEdQdzAxZTRGdUpHaDdSSmZaZTErTjVF?=
 =?utf-8?B?eEhFUjRwLzRGNVB5ZW1oWndGY2ErZ1RzUWdTekduWmlURElMdWlSOERTNFhL?=
 =?utf-8?B?V0x2QTI2SFVJRHhaeVRkV05WYXFrWmF4OE04eFUwa1A1Y2hLa2IzRjdFNnE3?=
 =?utf-8?B?dU9hcW0vd1RvYjJQQ0pjdEJrTHM4UkRkN1NjaHF1THhzSGtGL1lGK3hwRmlJ?=
 =?utf-8?B?aVZmNkhhcDlkWDM2LzgzZ1pPNytZTysxd2lvMk1CVWxrRnRRMzBiakd4aU1G?=
 =?utf-8?B?NjBobkNsNnBUQkF1dmN3NUNKVFNVdVBFeHRlcGRXSmlsa1dGTjI3eENhemQr?=
 =?utf-8?B?UjFvQ0JjYUtjenJsTHhzcVVQS0ROSlQvUlRReEVVY2RKZEhmS2NSYlczYlQx?=
 =?utf-8?B?ODJBVEt1QUsybkd3TWtKU2kxc1BrVHJTNDdpRnhHa1J5Y0IwYWRUWEE3eTZT?=
 =?utf-8?B?cWxqcWZaeVJ2aWhvR3h2bll4dzVtZGZQZVdCZlhFMExqK29Hb0ZWNXpkRW10?=
 =?utf-8?B?REtqTDBHZW1oV2lDdVR3SVFMUmRVUWgrbzBWVytqYlJ0S3hDUnNkQTNaYitH?=
 =?utf-8?B?T2lYZjBKcE1ZR3h3eWVSSXRzS0dRSG9xVWdlV3JXMnpYVkJTdFdJY2hZK0FZ?=
 =?utf-8?B?NXVmbUxNZHVOODYyMnB3SEFNYmp1VkFGcGt0dzRnTmlWWGxXZUpBdWkwUW9j?=
 =?utf-8?B?SHJMT3pUU0Y2VVZWWFp6NGJVOWVyeUF1UXJqRHVRczluRGI3MHAwM2xSYUMw?=
 =?utf-8?B?QXFpbWZVT1F6d3E2blh2VUVETkRDbWZsVEJRdldtZE1SV0lRcGF3TCtJWTRE?=
 =?utf-8?B?aDV6NmQ3VUNVUnFqQmdiN0ZuTnE1OE1GOStFT0pzVUh0elRidkt2Q1Z6QlRt?=
 =?utf-8?B?clRKTEt5ajVTZzBUUTRCQzZRSm9LVFRFUldxT1FJVjVESWs2c2xIRnlmbW8r?=
 =?utf-8?B?ZTAvakphWjNuNEw5N1JweDkyMmhjaTl3aUVzdEJQZk0wblgraytRbXB0Z04r?=
 =?utf-8?B?MzkzZDJkcDRCNlNHUlRFTGRqWVpKTXVOell2cWZJTE05bjJwaVpkbU9WY0VR?=
 =?utf-8?B?ZVRzZWd5R3gvY1gvUFQ5VTJXREVxNWhOOUNxR2lrbkN3NE5HdmlTYnRKUE94?=
 =?utf-8?B?MGZnVjhTOUZUZk5QelRRWWJZQzIybGpobDQ2SlZYbGdhWkh6Ui83eEhpN0l4?=
 =?utf-8?B?WktBYlpWZk1xTm1qZUlwNXJzNUJzTlpBYXNhY1pFdVNGZkZ1Um5rVmY5eU1S?=
 =?utf-8?B?WW9aaVlnOGUwZ0g0cGppMk5qQ29CR1p2K3BtR0hlVjNaRXBFVGVQTnl6WjlX?=
 =?utf-8?B?dnNTOFpzSzVTbHM5OUo3cXpkWEZpRjZpbjF3NWJqeEk4RWJmRGVzODJOWWVs?=
 =?utf-8?B?MWZJQ3FSeGFkUWNRamhuL0tKNHZOMGd5Uy9ZNjc0RUhJQ2hUcWdxdkVqOFpk?=
 =?utf-8?B?UTd4Vm9UN3dWVmUxMXBRSXZobk9zM2VVR0RKTTZJTC95V2NkQWplaW9hN3hG?=
 =?utf-8?B?cGwrOTIyYUNucW56MEZGRVh1VGd3Yk80ZGtRbEhkbGhxV1dIcEFieWxBU0pS?=
 =?utf-8?B?SkNpb2VhR0NaK1NiWW1ZbkZPdkMyZkt0UmxSbURSaXVQMXoxeE5uMnhiNWI5?=
 =?utf-8?B?b2tyVG5oVEZFbnNLRXErSkRwMHowUVpKenVFbUJvZUdnRlZJVWNRTG5kR3Bm?=
 =?utf-8?B?MmM3WGRhUVllcm15L1E3K0prR1J5WnlLZFpYaFhGQnJIbXByRDRmcm9tVXFP?=
 =?utf-8?B?dmt4NjkzUGRwN09UK3B4ZmRkTTNpa2habStWaEk5Q0VhS0VUUGdSQ3BtZU5m?=
 =?utf-8?B?SmZZdmd0M2Z6ODhwcHN5Mzcrd2lQaVZoWDEySlRCcW1ITmh1dEc1RFR6VlBG?=
 =?utf-8?Q?NfiZtTfGYB19QqYlHhSY9Plax?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac9b703-77b6-43eb-718d-08ddd4b708eb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 07:01:15.2872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s12DBGn6Liuako3hVHDKesnPoc9GKr8ULf4yFUmRD5Q2axwK/MJ/pRQCxUyRcPYvZzK5ihiJNPKBXUw825sxZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8874
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Aug 2025 07:01:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19682

On 06.08.25 07:22, Nobuhiro Iwamatsu wrote:
> This adds an option to create an image that does not contain the kernel.
> This is mainly intended to provide images for kernel testing.
> When testing the kernel, kernel image files that are not used for testing
> are not necessary in rootfs. Providing images with these files removed
> allows you to reduce the size of the rootfs image.
> 
> wo_kernel is false:
>   -rw-r--r-- 1 iwamatsu iwamatsu 351M Jul 25 17:31 cip-core-image-cip-core-bookworm-qemu-amd64.ext4
> 
> no_kernel is true:
>   -rw-r--r-- 1 iwamatsu iwamatsu 275M Jul 25 17:09 cip-core-image-cip-core-bookworm-qemu-amd64.ext4
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> 
> ---
> v4:
>   - Fix the NO_KERNEL check to 'enable' only.
> v3:
>   - Update commit message.
> v2:
>   - Use KERNEL_NAME instead of IMAGE_INSTALL:remove
>   - Add build:qemu-riscv64-test-nokerne; pipeline
> 
>  .gitlab-ci.yml             | 36 +++++++++++++++++++++++++++-
>  kas/opt/no_kernel.yml      | 17 +++++++++++++
>  scripts/deploy-cip-core.sh | 49 ++++++++++++++++++++++++++++----------
>  3 files changed, 88 insertions(+), 14 deletions(-)
>  create mode 100644 kas/opt/no_kernel.yml
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 628e624..496a56d 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -28,6 +28,7 @@ variables:
>    swupdate_version: default
>    test_function: swupdate
>    separate_home_partition: disable
> +  no_kernel: disable
>  
>  stages:
>    - build
> @@ -69,9 +70,10 @@ default:
>      - if [ "${watchdog}" = "disable" ]; then base_yaml="${base_yaml}:kas/opt/disable-watchdog.yml"; fi
>      - if [ "${security_test}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/security_test.yml"; fi
>      - if [ "${swupdate_version}" = "2022.12" ]; then base_yaml="${base_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
> +    - if [ "${no_kernel}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/no_kernel.yml"; fi
>      - echo "Building ${base_yaml}"
>      - kas build ${base_yaml}
> -    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} wic; fi
> +    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} wic; fi

Another call site of the script below was missing. I've updated that
now, result in next.

Jan

>      - if [ "${build_swu_v2}" = "enable" ]; then
>            mkdir build/previous-image;
>            if [ "${extension}" = "security" ] || [ "${extension}" = "ebg-secure-boot-snakeoil" ]; then
> @@ -229,6 +231,38 @@ build:qemu-arm-test:
>      target:  qemu-arm
>      extension: test
>  
> +build:qemu-amd64-test-nokernel:
> +  extends:
> +    - .build_base
> +  variables:
> +    target:  qemu-amd64
> +    extension: test
> +    no_kernel: enable
> +
> +build:qemu-arm64-test-nokernel:
> +  extends:
> +    - .build_base
> +  variables:
> +    target:  qemu-arm64
> +    extension: test
> +    no_kernel: enable
> +
> +build:qemu-arm-test-nokernel:
> +  extends:
> +    - .build_base
> +  variables:
> +    target:  qemu-arm
> +    extension: test
> +    no_kernel: enable
> +
> +build:qemu-riscv64-test-nokernel:
> +  extends:
> +    - .build_base
> +  variables:
> +    target:  qemu-riscv64
> +    extension: test
> +    no_kernel: enable
> +
>  build:x86-uefi-secure-boot:
>    extends:
>      - .build_base
> diff --git a/kas/opt/no_kernel.yml b/kas/opt/no_kernel.yml
> new file mode 100644
> index 0000000..7bba6a5
> --- /dev/null
> +++ b/kas/opt/no_kernel.yml
> @@ -0,0 +1,17 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation 2025
> +#
> +# Authors:
> +#  Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +local_conf_header:
> +  kernel-version: |
> +    KERNEL_NAME = ""
> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
> index 6e4dfd7..5647381 100755
> --- a/scripts/deploy-cip-core.sh
> +++ b/scripts/deploy-cip-core.sh
> @@ -13,9 +13,10 @@ fi
>  RELEASE=$1
>  TARGET=$2
>  EXTENSION=$3
> -DTB=$4
> -REF=$5
> -DEPLOY=$6
> +NO_KERNEL=$4
> +DTB=$5
> +REF=$6
> +DEPLOY=$7
>  
>  BASE_FILENAME=cip-core-image-cip-core-$RELEASE-$TARGET
>  if [ "${EXTENSION}" != "none" ]; then
> @@ -29,6 +30,23 @@ fi
>  BASE_PATH=build/tmp/deploy/images/$TARGET/$BASE_FILENAME
>  S3_TARGET=s3://download2.cip-project.org/cip-core/$REF/$TARGET/
>  
> +if [ "${NO_KERNEL}" = "enable" ]; then
> +	__BASE_PATH=${BASE_PATH}
> +	BASE_PATH="${BASE_PATH}-nokernel"
> +
> +	echo "Rename from ${BASE_FILENAME}.* to ${BASE_FILENAME}-nokernel.*"
> +
> +	if [ -f "${__BASE_PATH}.tar.gz" ]; then
> +		mv "${__BASE_PATH}.tar.gz" "${BASE_PATH}.tar.gz"
> +	fi
> +	if [ -f "${__BASE_PATH}.swu" ]; then
> +		mv "${__BASE_PATH}.swu" "${BASE_PATH}.swu"
> +	fi
> +	if [ -f "${__BASE_PATH}.wic" ]; then
> +		mv "${__BASE_PATH}.wic" "${BASE_PATH}.wic"
> +	fi
> +fi
> +
>  if [ -f "${BASE_PATH}.wic" ]; then
>  	echo "Uploading artifacts..."
>  	if [ "$DEPLOY" = "swu" ]; then
> @@ -48,17 +66,22 @@ else
>  		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.tar.gz" "${S3_TARGET}"
>  	fi
>  
> -	KERNEL_IMAGE="$BASE_PATH-vmlinu[xz]"
> -	# iwg20m workaround
> -	if [ -f "build/tmp/deploy/images/$TARGET/zImage" ]; then
> -		KERNEL_IMAGE=build/tmp/deploy/images/$TARGET/zImage
> -	fi
> -	# shellcheck disable=SC2086
> -	aws s3 cp --no-progress --acl public-read $KERNEL_IMAGE "${S3_TARGET}"
> -	aws s3 cp --no-progress --acl public-read "${BASE_PATH}-initrd.img" "${S3_TARGET}"
> +	if [ "${NO_KERNEL}" = "enable" ]; then
> +		echo "The image does not include the linux kernel. Therefore, kernel related files will not be uploaded."
> +	else
> +		KERNEL_IMAGE="$BASE_PATH-vmlinu[xz]"
> +		# iwg20m workaround
> +		if [ -f "build/tmp/deploy/images/$TARGET/zImage" ]; then
> +			KERNEL_IMAGE=build/tmp/deploy/images/$TARGET/zImage
> +		fi
> +
> +		# shellcheck disable=SC2086
> +		aws s3 cp --no-progress --acl public-read $KERNEL_IMAGE "${S3_TARGET}"
> +		aws s3 cp --no-progress --acl public-read "${BASE_PATH}-initrd.img" "${S3_TARGET}"
>  
> -	if [ "$DTB" != "none" ]; then
> -		aws s3 cp --no-progress --acl public-read build/tmp/deploy/images/*/"$DTB" "${S3_TARGET}"
> +		if [ "$DTB" != "none" ]; then
> +			aws s3 cp --no-progress --acl public-read build/tmp/deploy/images/*/"$DTB" "${S3_TARGET}"
> +		fi
>  	fi
>  fi
>  


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

