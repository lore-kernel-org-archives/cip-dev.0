Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4698ACA0ED3
	for <webhook@archiver.kernel.org>; Wed,  4 Sep 2024 13:22:48 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.87])
 by mx.groups.io with SMTP id smtpd.web10.50022.1725456158221293627
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Sep 2024 06:22:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oMf70Jjo;
 spf=pass (domain: siemens.com, ip: 40.107.247.87, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXIwUWRDpPjzuXPYJ6d1tWoUYK6tEXPYlFyB05YGdyMOemD+isp7oTSRbbEZTOfi345BV7p14cTaS4NYW8Bh2yK1UFkifwAxlLaQbZyFqEsNCIIsf4T5y0PGVPtYlRQT4OnPj4PWpLko3Q3ooz8OIPKGIBLLwACR4WZIbxcHtaRhTOSDFO/nkjozaB6QgNvjcooYRQ/phz/6mlWQYpMlV1dFDiQRiTWPkqno+wE9b8YJ2x9SK12reP4bkRvGXMcd2lIor6Pfea8hUtAg7+aZbP8TcajrJvLp9rzXSt1LNuLbjdBkx6PpEzjfkFlW9y4NY/7xptW1+V44rdGyTGYbtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhLLWiwhKVPInRy5fCDqJ8nUegMumEgEDBjThoB/DDo=;
 b=MtcMjB429XRi5oKP8aXSiIArNmrIy7MhrgPOyIWAzKG8d7BImeBOYToaPUxHb/+wgm8BxCzjInvRjCTXnowz896mtUwErMh/QfnXqi0N0tkl8/oWUo+ZXt4LLhVZh2UyO4rudV/H3jN/j7WOkBvrCFs8DcFiYYfM6SKMBRHYtUzXq05gjZhMnhBAqR8JsWTMu5YMdtwMm4eg7qqrW7hFaPS8WmnA8gr6Aryg34o8JdoQNiXB/I3qWjhMg1242RWzfl3i38pXCCGAXB7AGtf01Tg67xn8HiK8po8UnfOgauE4aDty4/fT+3xu9938MAvvv0s4NQFD5W4w0UkTNBMvtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhLLWiwhKVPInRy5fCDqJ8nUegMumEgEDBjThoB/DDo=;
 b=oMf70JjoWCc1tGSSbtpNzId9iTAt5rTU8mYoaMRVVQNsJIOg2Bm83/sEp0fanMAXNBtwzBHhwKbvM/QvQJQKrRAUTMyIk14yYQGIlmwMzBUzemtjAHqs9c0ixijHyVcocOKwMOGqc7qKWCBlxh72umh9cvg7dUsmPQCm8H/fr8Y7s2koKDjSI6TLfuYqswvIr81huhF1sxs0ElZ58l8BDBk84/uI0Ovta+WuT+2n31oxxCNFUj9w8wpm7oBztq+zqMG05iHlOUc5HQm4KQ5vrlvG3zuEsDdIpebZRWerI6mhrAApDgebycpA/LO44V2ooaJF2BPS+rTTvEvKIjKiqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PA4PR10MB5563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:260::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 13:22:29 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%6]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 13:22:29 +0000
Message-ID: <f7a92fdc-894c-417e-b999-16f0c3b1c405@siemens.com>
Date: Wed, 4 Sep 2024 15:22:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH][isar-cip-core] scripts/lib/wic/plugins/source:
 Use F-string instead of traditional .format() method
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com, srinuvasan <srinuvasan.a@siemens.com>
References: <20240904064223.869919-1-srinuvasan.a@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <20240904064223.869919-1-srinuvasan.a@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0425.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::12) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PA4PR10MB5563:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b791d8d-80fb-409a-5888-08dccce49fee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|4022899009;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ekwzMlEyOGtybllQRlhieGVtM3lieTBRR2pObm9UODVlTkZkQ3dFbjRxRlFq?=
 =?utf-8?B?UEFoU1NKZjdLS0dUVWVkMDZnM2pKdGxwT0Z5MFRiNHlzdmI1Tkpwb05GM3oy?=
 =?utf-8?B?VHRUVVdqVXZ4WDdLQmFmZFBPd3NyZFdvWDJlaDRscG8wUGVBSzdHbXNnejFv?=
 =?utf-8?B?WkZWQ1cwUHdzRjVncmVVUGs4V2g5OHFRdFZ3MGg5SHplZU9qcGhHdnlQTnNC?=
 =?utf-8?B?ejRBZEJNWGFlZlVrTUZrMmVwQmsrc3Q2TXR5a0RIbU9CVkF5ZHNZeUQ2a0ZC?=
 =?utf-8?B?aENveTl1UWp4RXpJeUZHUW0xZ2dJVWpQeGJBcGxWMTIzSjFkSmdGWXhPU3d1?=
 =?utf-8?B?L201TllRaU9DdUJ2Ty92TVdCYy9DNjBqNDZieDZTZnE5c0hiUjYvNDR0ckdX?=
 =?utf-8?B?QTVwaE9SMWs0NkU1ZDZxUThaYmNvYktPeldDWktMUHdoam9FUm5iWmJMTnRO?=
 =?utf-8?B?QitueEdVaVZyTC9zRm5oRThPZGNIMU82SFI3T0Z3ZlpkRDY3N3JYd2NPSith?=
 =?utf-8?B?aGx6RjVEL3F3ckZHM29SV3V6QWJwYnV6N0xDYjFhSnhWY1lRa1Z0emFqbXJK?=
 =?utf-8?B?YTlwWkRKUTVXVWk1NUxkQi9zTFo1NHVzbzJuWlJHTmlUa0JUR3BaUWpzRWxS?=
 =?utf-8?B?empFVmV6Qmw0T2c3UUJ6MW9EdVhyaEV3alp4MmNhd0hGQUFQMlpDOVIvdHFm?=
 =?utf-8?B?VnppWjRLaVpYb08zbSt4b0hYTUlVOGxNVU4zbHU0Rnp3aTJUN3YwUXl2ZG1N?=
 =?utf-8?B?RHFSR0o1SzRLMGlKYWc4cGxZY1VoTU1CNWkyNFA3SS9sTlc5RkZmY1VrUElt?=
 =?utf-8?B?TTZiZVIwWTFWQjdqR1ZwSWJVNVZybVBiMnFJVnVmb0xzU0drNTlZVm1uc1Bz?=
 =?utf-8?B?YTQ5RUJqUExUVWtVVWs0WllUNWN2dkVHS0IycTh6MzQzR1dwOVZDYWJNc05s?=
 =?utf-8?B?b3NmVmw4NzhXZTZna0dXY01YNS9NenBPNGEyS2RSY21VaGRGaitTelkrLzBK?=
 =?utf-8?B?WnB5NE5DcGw3OXB0SytCVVRDbjlJVUJ1SWd5THNVdU1DN24wd1BMenlBQ01i?=
 =?utf-8?B?K3l1MThIVWtXOE95ZDZ6WkhSVzIzaCs4ZUVEaHBMSmJxTWVQbHhjUlJtbkdZ?=
 =?utf-8?B?RkhIaGNZb0hJbTdlZGhSc082RjltTEFXcjA0bjkxVm5aSDBhMHBMUHZUWU5X?=
 =?utf-8?B?cXJ4d01rL2tYZHFGR2RxWlJabkw2M2hveld1NlgwdGZ1UkN2NjA4UnBFNkpl?=
 =?utf-8?B?MWdpcU5qUTRVQ1E4SVJvRjBJcnFuUnVGZFZ5dmQydkR2UVNBS1Q3RUFIck1n?=
 =?utf-8?B?YkZGS21PbC9hcGQzQTdiZ215dkNtOVA5S3ZiSHF2ODloZEpraUV4cTlEYUNF?=
 =?utf-8?B?NVZJa2R6S1dqSXRuVmZTTFRrazhndXJGcWN5V0ZqV1hKY0dEd2VSZDhXN25L?=
 =?utf-8?B?bXQrLzB5cWJuTVVmb1d1ZVJibS9ablZGbzROcTVBZTRUTllzcnZvSlg1S29x?=
 =?utf-8?B?OEN6b1pyRXAwb2pXaWtuTTRRMHp6YnV1aFFLQTUra1VJZDk2am5YemppeVAz?=
 =?utf-8?B?Sk5PQUhORWdEcVhmVERSanJBanpmaXRwMjNNMFpkWnlZWlBLazUzcENCZVQw?=
 =?utf-8?B?KzJLSHNrZityNnNqdnNkRDdMVjBkTWNoRDI1anRUd0R3a3lHSE5tM08xYmhG?=
 =?utf-8?B?UGJDVGZ5VFdiQS9kdWhSQzJ4azU3MU5Lc0dwbG9DYjBybGJ2Y095bnN4Zmxm?=
 =?utf-8?Q?CVJmvfVXMF+Dz0r6oI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4022899009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WnAvUU82ZDFhZWIxN045WTlnTVBVSUZJeExxK0ZSYkpsYXNGeG0vNStjTkU4?=
 =?utf-8?B?OGF4ZGVjYUdNQ0tOa1c0ZHRTMEluZ3VPT2tsKzMzSExENkNGLzhZZmdCRitI?=
 =?utf-8?B?MjdNVi9sOGs3NFZhSGVoNGpURWE5d1RPZkUwVVY5M3RPM2JwbHl2RFNDd1dh?=
 =?utf-8?B?akNRektNSFdHNEhBNDMyWkhQNVhYTU9RZ055dTZOTlZOZEVtUSt4NjNvb0Rt?=
 =?utf-8?B?T09XcUoxVHJ4NUVwRnRsZEw1QXUwSFNUT1E3RU5xRjM0T1dXV3pvSDgzUEh0?=
 =?utf-8?B?SG5OTGJTaFFaeDdRaUwyTDNlbXo2Q1dhYzc5d1dreEtaZTZORXRwZ2pOa2NL?=
 =?utf-8?B?SUtrT0EwWnVXbnNSY2RrUjhVSHVOenpFZzNwdlNrazdEcHVLYnM3NFBGeXd4?=
 =?utf-8?B?bUNKa1oyRW9oSDhKWWtmdGFRekRudHowUVNYbUVndUhFT09ScnZ4ZVhHbUE4?=
 =?utf-8?B?RVlWajJ6OTY5RmtseHU1OGxVTXR6eEF0L1BEeGpHQUpkYnhiYi9hU25TM0JZ?=
 =?utf-8?B?cWVkYnQ4NWtpdmdBMVJ3SWZlSEdYNW1FMHFLZmp1RXV2UFQxT2lUMkoyYWFZ?=
 =?utf-8?B?WUd2LzgyTE8zWUtMMzU3SXVHNHFJZ2F1K1hVQ2VDODBla1NzRG5hQVFmRE5E?=
 =?utf-8?B?MFNwU1k0eWRtVjA0bk11RFFZQ2RBSzZ2UmxuMk96Zk9NZC9ZT0FuQi9lbWF4?=
 =?utf-8?B?SW51L2ZSeGorZzlVT05OL2lpWWh5QUMzVVYyMDJMZFgydXJnNWNGekpMQlV2?=
 =?utf-8?B?ZEptTURpd0NjclV5K1Y5UlArbjhSR0lWWCtlYThsa3VtWG9yOU1CWnVZbEls?=
 =?utf-8?B?WlZEemFLK3ZycXp4cXJ2Tys2emt2YUhyd3JJSlFyNGQzMGdMV2xrM0tibkxx?=
 =?utf-8?B?dlROYVpTNXl4bkFCZ0grSWFBV1FhNEpQZC9TcFJsZGJNOGdlR0lKbSttcEx6?=
 =?utf-8?B?VGFadzR3ME5iYmJZWWNyVW5YcHdkaUxXellGQzFQdXlMZGszUXk2US8wajlZ?=
 =?utf-8?B?NWZZMUZ5VE5OSXhsS1ZvbVVqanlnclFneGlmUGdObjVJcm9HV3BINlh0QmNQ?=
 =?utf-8?B?VE1vQWs1cGlITVUrbFlWYW1lUTdnSThnOFdlc01TcjlvaFcvRnhkSTJ5Q1BT?=
 =?utf-8?B?ME10VWtoZS95NFZtTFFJUk45OXd5ZTNkUFZDMnNzS1RjY01GMHdFRGF0RlY4?=
 =?utf-8?B?QXVRY2VGMkR1cm5HYnVmazBVYlB5bkJiaTVpZWdZcG5QTTluMTlZT2V1SSts?=
 =?utf-8?B?andLTHRhb2paTE1reXJVQXRiQW04aEZLaHlVSzJ2WEFOMjlhcEFwQWJVbTI2?=
 =?utf-8?B?STVUREM4UTUyQndZUWtsbzZraFUvNzBXaHdJbUs4Tng0am1oOE9oS0oycTFv?=
 =?utf-8?B?SXJmTnMwVG9zejlUMkFOL3dYYTlScU5MSytOdC9pakpwNGdDSGRUV2pNeDBx?=
 =?utf-8?B?eFZ0ZUVoY0JtNERVaHdMNkRXKzJ2Q1lKRmM4VThjSDkwbHRyZ2RzUzIrbG93?=
 =?utf-8?B?dlZ0TnVXT0VNQWs1VE15c012c2xzakNGRDliUVF6R2VZcGoveEtKL0puWjJJ?=
 =?utf-8?B?SHBQaEVFVHlvV2lScUQ3YTV4TVJrNW0vSEFhdnNNZ25TRlRDS0xCMWp0R0Ja?=
 =?utf-8?B?eDhnaHk5OVhYZ3EyL0tqcVVBNVhkdFBoV2psZFpIS3dmOTloYkRGOHQ4KzZy?=
 =?utf-8?B?TE1GUE5LbmRPM3kzaXJ0eXk0Y0U3WFArTStCWnB0Wk5mSEV2Y3ZLVHltQm12?=
 =?utf-8?B?Zmk1YmlMMFR3dVNQUGtsWnlsdytyd0xuNElla1FERGdjdDllNHljRVAyZ2JC?=
 =?utf-8?B?bEN4cm9kQWRyOHFnN3MxNzlxRmpSNTFLaUcrcmtaK2ZXU2RFN3UyTlBzSUpL?=
 =?utf-8?B?NjJMVXhGSHlzQ1QxTTV5V3dyK2FOQkNuL1BnM2ZWUGQyV0ZPOXF4eXBpMmFy?=
 =?utf-8?B?R2FVQmJhenU2UThtQ3Z3RCsyRkM4ZWJSR2xTbUtQS2dWdzYxSks0REQ4OVBR?=
 =?utf-8?B?bzJ3eDRpMmJnaGIzNGQ0U3FOZmJ6NElQMi9wTnp0RWxQT3hyUE95OWlVNS93?=
 =?utf-8?B?cm02MVpKT0ZENmJSZ1NNS0M1QWREVThSV2pnWFZDQ2pOeUlHdHFWR2NqSEkv?=
 =?utf-8?B?eGxHMWpGMWp0RkROUWhCMzJXT0tia3pTS3haWVJJQ2FjQWtyVmwrQkhTbzhZ?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b791d8d-80fb-409a-5888-08dccce49fee
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 13:22:29.1029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVPj2PLaO/iwSpWA3jHwChGdR+TsEseIZk9essA+ZcfTqc8i8Cvu8Mj9IfL0DBUv/NBEihIoYfK5+mgPZFItNB+EPkhW4f4+Sur4wCb1FYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5563
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Sep 2024 13:22:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16847

Hi,

On 9/4/24 8:42 AM, Srinuvasan A via lists.cip-project.org wrote:
> From: srinuvasan <srinuvasan.a@siemens.com>
> 
> Use f string for string interpolation and formatting instead of traditional .format()
> method.
> 
> f-strings are generally preferred due to their readability,simplicity and efficiency,
> and moreover there is no functional changes apart from the optimization.
> 
> Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
> ---
>   .../wic/plugins/source/efibootguard-boot.py   | 31 +++++--------------
>   .../wic/plugins/source/efibootguard-efi.py    | 17 +++-------
>   2 files changed, 12 insertions(+), 36 deletions(-)
> 
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> index 2b06fd1..ad749fb 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> @@ -170,29 +170,16 @@ class EfibootguardBootPlugin(SourcePlugin):
>               msger.error("Bitbake variable 'EFI_LIB_ARCH' not set, exiting\n")
>               exit(1)
>   
> -        efistub = "{rootfs_path}/usr/lib/{libpath}/efibootguard/kernel-stub{efiarch}.efi"\
> -            .format(rootfs_path=rootfs_path,
> -                    libpath=libarch,
> -                    efiarch=efiarch)
> +        efistub = f'{rootfs_path}/usr/lib/{libarch}/efibootguard/kernel-stub{efiarch}.efi'
>           uefi_kernel_name = "linux.efi"
> -        uefi_kernel_file = "{deploy_dir}/{uefi_kernel_name}"\
> -            .format(deploy_dir=deploy_dir, uefi_kernel_name=uefi_kernel_name)
> -        kernel = "{deploy_dir}/{kernel_image}"\
> -            .format(deploy_dir=deploy_dir, kernel_image=kernel_image)
> -        initrd = "{deploy_dir}/{initrd_image}"\
> -            .format(deploy_dir=deploy_dir, initrd_image=initrd_image)
> -        cmd = 'bg_gen_unified_kernel {efistub} {kernel} {uefi_kernel_file} \
> -            -c "{cmdline}" -i {initrd}'.format(
> -                cmdline=cmdline,
> -                kernel=kernel,
> -                initrd=initrd,
> -                efistub=efistub,
> -                uefi_kernel_file=uefi_kernel_file)
> +        uefi_kernel_file = f'{deploy_dir}/{uefi_kernel_name}'
> +        kernel = f'{deploy_dir}/{kernel_image}'
> +        initrd = f'{deploy_dir}/{initrd_image}'
> +        cmd = f'bg_gen_unified_kernel {efistub} {kernel} {uefi_kernel_file} -c "{cmdline}" -i {initrd}'
>           if dtb_files:
>               for dtb in dtb_files:
> -                cmd += ' -d {deploy_dir}/{dtb_file}'.format(
> -                    deploy_dir=deploy_dir,
> -                    dtb_file=os.path.basename(dtb))
> +                dtb_file=os.path.basename(dtb)
> +                cmd += f' -d {deploy_dir}/{dtb_files}'
>           exec_cmd(cmd, as_shell=True)
>   
>           cls._sign_file(signee=uefi_kernel_file, source_params=source_params)
> @@ -206,9 +193,7 @@ class EfibootguardBootPlugin(SourcePlugin):
>               msger.info("sign with script %s", sign_script)
>               orig_signee = signee + ".unsigned"
>               os.rename(signee, orig_signee)
> -            sign_cmd = "{sign_script} {orig_signee} {signee}"\
> -                .format(sign_script=sign_script, orig_signee=orig_signee,
> -                        signee=signee)
> +            sign_cmd = f'{sign_script} {orig_signee} {signee}'
>               exec_cmd(sign_cmd)
>           elif sign_script and not os.path.exists(sign_script):
>               msger.error("Could not find script %s", sign_script)
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> index 48f7523..c443d14 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> @@ -73,16 +73,14 @@ class EfibootguardEFIPlugin(SourcePlugin):
>           creator.deploy_dir = deploy_dir
>   
>           distro_arch = get_bitbake_var("DISTRO_ARCH")
> -        bootloader = "/usr/lib/{libpath}/efibootguard/efibootguard{efiarch}.efi".format(
> -                        libpath=libarch,
> -                        efiarch=efiarch)
> +        bootloader = f'/usr/lib/{libarch}/efibootguard/efibootguard{efiarch}.efi'
>           part_rootfs_dir = "%s/disk/%s.%s" % (cr_workdir,
>                                                part.label,
>                                                part.lineno)

Why did you not replace the old string format in this patch? I see only 
the str.format calls replaced.

Quirin
>           create_dir_cmd = "install -d %s/EFI/BOOT" % part_rootfs_dir
>           exec_cmd(create_dir_cmd)
>   
> -        name = "boot{}.efi".format(efiarch)
> +        name = f'boot{efiarch}.efi'
>   
>           signed_bootloader = cls._sign_file(name,
>                                              bootloader,
> @@ -116,11 +114,7 @@ class EfibootguardEFIPlugin(SourcePlugin):
>           sign_script = source_params.get("signwith")
>           if sign_script and os.path.exists(sign_script):
>               work_name = name.replace(".efi", ".signed.efi")
> -            sign_cmd = "{sign_script} {signee} \
> -            {cr_workdir}/{work_name}".format(sign_script=sign_script,
> -                                             signee=signee,
> -                                             cr_workdir=cr_workdir,
> -                                             work_name=work_name)
> +            sign_cmd = f'{sign_script} {signee} {cr_workdir}/{work_name}'
>               exec_cmd(sign_cmd)
>           elif sign_script and not os.path.exists(sign_script):
>               msger.error("Could not find script %s", sign_script)
> @@ -128,9 +122,6 @@ class EfibootguardEFIPlugin(SourcePlugin):
>           else:
>               # if we do nothing copy the signee to the work directory
>               work_name = name
> -            cp_cmd = "cp {signee} {cr_workdir}/{work_name}".format(
> -                signee=signee,
> -                cr_workdir=cr_workdir,
> -                work_name=work_name)
> +            cp_cmd = f'cp {signee} {cr_workdir}/{work_name}'
>               exec_cmd(cp_cmd)
>           return work_name
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16844): https://lists.cip-project.org/g/cip-dev/message/16844
> Mute This Topic: https://lists.cip-project.org/mt/108260811/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

