Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BFBC25B78
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 11:04:12 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.45])
 by mx.groups.io with SMTP id smtpd.web11.19549.1716894241151666129
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 May 2024 04:04:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=V5vYrHXI;
 spf=pass (domain: siemens.com, ip: 40.107.105.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXCTeQFchYP0rq/HlYs0KBv7ejqkUcIK89PyVCfp9NhlS/6VZhqogZVL4oxZmo9XrNeoPFXFGswPV6SjfZpOAjExIonlyZCa5JaNLsiy1KpeTfZg3cFA3DarTe2qrIInREL1VE6KPf/sdGgvSEmgmKynodVQ+w+j4mt5Cs2bTriUKdefXS41uHNUG+1+EsrsEQ9JMLnJNIqGah78s9mHEJlbgWQCNz7OmUj2Z4YmNXjUw4y70fln4cCV4mkPr3voSkIybaOZiWrWs5t51mWkzbAr61KZeYxX7z3o85I+1fHRR1yIPqQVnnRdXDLsoyBc9+/4nUmYmasCLpL+TWq3PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3avcwfJjSgqwJKsqp8WZdVzOyq4TehbNgool32TemU=;
 b=CrWbkcPL4Grs2zwM3ChuzLIaVlLHZlP7AZT/jMYu/VUi3UFC7b1ofOpz/fXQ5mgGy4jzjdiicJegkXZP0DMB6Z6CmVq0a3y3oHKMKNzs4HwOsKJeniB50ItACzHJciwH/X0dNP19gaX4qhAYmYpMNCh0l83NhY/saYMDpCm684dJgrwrND8OuCLzTxxBCQCiz2VQybKryVyFuH1dqqCI8Da9sk9Q3TNBVqq+wpypyum9cHg+x+LtXKUDpDXXhcXaPUGBa/+YOSzsL9mnz0ig25rHNPfxfI7o1RxNvMLXubk1eZBKKnadBIozUqp5sBWtrOcKl5fStmdxHBtA1rIJ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3avcwfJjSgqwJKsqp8WZdVzOyq4TehbNgool32TemU=;
 b=V5vYrHXIKgVElXgp1fwE9XTLEKpObYITDuMQcKAvFxVQVHqVmkc+veTS2GymP3UJstGEH7DR2RpNs64DnslC+2HbWCzm7Qe/P4BhtOhRZcagd7D9xpLWbgWrsfkZdVHP8LGYenhHv8PFcKCRLW4730iYDXRiz1+oRoRHO5TJr2MCXgf35WgZ+lHxCDvlhr0gaBWNTL9seJuITESVGHuS61RlBovDgTGgWKp5mXVHjlhvW6aYjEz6zTtruphAiHZuVGwdibVZglg/n0vQTuXjWdaIM9G583OVnXjgIYUsaf5Y/DBG3M8CEoOV2KQJMnDOYYSvc9XAHYaVGdGLxKXR3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8552.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:422::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 11:03:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 11:03:58 +0000
Message-ID: <34342449-52e0-421f-b4aa-d7307050f80d@siemens.com>
Date: Tue, 28 May 2024 13:03:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v4] encrypt_partition.clevis:
 select tpm2_device for encryptition
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 gokhan.cetin@siemens.com, cip-dev@lists.cip-project.org
References: <20240528093656.21040-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240528093656.21040-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: 740dab78-1e94-46fb-4763-08dc7f05df71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VzZlbmQ4dFpkbzZ1L1A0SC9NZmpRZXZBSS9Ec0s0Z2dMVk1IRXc2cktwdGVQ?=
 =?utf-8?B?M1dMbnQ3OUZMTmczNDNSTHRZamx3eVg0NDJndWNEajFSZ1JqZEpYMzFVUXMy?=
 =?utf-8?B?QnhNSmtYNXNXTXp1WXFZVFJhVFlUL1ozWHV0SGRGWWszU25sRkdlZ3FmUXY2?=
 =?utf-8?B?U3o5KysyaHhOa3ZHYStrNEp0TTJaeFRTVkRSeEVtMHQrWjlKc1dxUFhVTnN0?=
 =?utf-8?B?aW02NUlEaDNsVVVLZ0RRN1k1d2tvSGsvY1prRDhlVk9QT1diZzBxL0hsVzMw?=
 =?utf-8?B?VFRyWVRFTXNNdU1oOGczc0U2MlRjNktScm9hZGl1TFRQd0lMYUI0ZERDdGpS?=
 =?utf-8?B?dzZEd3Z6L0ppUkQvTHY3TW00OGhQRUZRVlI2eEpBQ0ovc2JrcjN1ZDV0TzE1?=
 =?utf-8?B?aFlyWHF5aXJWd0NpUFN1QUl4eU1CVGVjcTcxdFE0aFhlZ01tbzR4T2ptMHUw?=
 =?utf-8?B?ZXV0RUZJaHBhbVNSQ3Nra1hEUjN1U0hPSW11cFgzaWFXRUVoaWM1dUl2L05h?=
 =?utf-8?B?VzExVlYxRUlERkZzZ3VTZnoxSGZXQk1Yb1FtZ3V3ajdRV2ZiTXgxNmF1Ukx1?=
 =?utf-8?B?Mm5YZjRNUUJIRUNvNWJGandmQzVUR3ZSQ1EyVVlGQUFCRFpnRTZpUTJIK08v?=
 =?utf-8?B?NW1wall1VXNveG14YUo3VjRtWHNPYloyNEs0VEc2czVPK3A0WnBpZ0VEZkcv?=
 =?utf-8?B?QXYyRm1LVFNkOGxPMTVEVTNjMlk3Qm5RMnZHa0lMcHM1amI0dG9zcVRFZno4?=
 =?utf-8?B?ak1TS21WWlFLaXh4QTN3ZFdDNWs4dmp4T0gxMmYyZHFqRWZjc2tROHcwbWIw?=
 =?utf-8?B?SU5HK0wrYll4b2VwSE4yZWV3b3NiUG5ZeU5WcERRdlp5Y3ZFakdlNll5Si9N?=
 =?utf-8?B?QkxqZUdpcGNoR25ScUh6UjhEaWR5VGJqRGV5elRUSmdoRnp1ZEhEYmlFZU9m?=
 =?utf-8?B?Z0FBZStEdEV1N2taMWx4MTNFYWYrYUNCK3FkZnBIMTVtTE1JWW1hNGovWUdO?=
 =?utf-8?B?T0s0ZG05RGZnOVpuNkhLaXVKa1pXbXhxejlFR2J1RHk3ME9KbEJ6T1ZNTG9k?=
 =?utf-8?B?U0hjaGxUVVNxcXhJZTBLVVhzUWdNcnp5Q244Nm8vdFFTQlJkZllsMTFGdU9C?=
 =?utf-8?B?YnQrS2R2dTdzVFNscnZWdmxmT211b0ZYQ0NYcUxvQUdzUWltWVk5WTZabThR?=
 =?utf-8?B?dkxzeUFTV2FmYS9hZXFUWkYrNnY1em9GUkJkanl2MHUvbTFudnNsM3lvaEtL?=
 =?utf-8?B?cTZsUkc5bytmanF6STJ3ZHBQYk9KamU2MmFEVzR3K1hleWNpQ3JlWkNyZDcz?=
 =?utf-8?B?UE9ZYzd3Zk1sa2o5MkNiRzZGY0Q0T3plcDMwRWlkRWx3SU56RTkzcGVEMW5O?=
 =?utf-8?B?RlpPZ2I5ejNYUkNHcWdGUXZNQ1BqbnEyM3BHQnRPc1JacS95SmkrS0wwMm9J?=
 =?utf-8?B?S3l5V0ZVNWJlUlpVQmEyMER5TE9iU3Uyc0FrWXcxb0hybHFvSXFzRVhxM3J3?=
 =?utf-8?B?SkNuL3kzVWtaVHNOU2VPYUZnam8vSStaZVZpMk9YSzdmMGE5WDRPQWxHTXYr?=
 =?utf-8?B?N1V1UDZjcUFiSEJSS2FSdENqSjhjS0lVOCtad1pjdHNjUU5rQWFOMnNGU1Vv?=
 =?utf-8?Q?AV41ySWHeFfOtCIAvxw47tmVbLejbpZDKNtqWLHNol0k=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bXdUTm5MT21TMERaVGk2TFU0SmdJUkhnYjFGSGcwaGI2eGU1S3picFY0ODBl?=
 =?utf-8?B?MXU3NlRwMUZUKzJuU2luZHpzdE4rZXBjRC9sU0E3TGtGUWozMHBSWlNaSjUx?=
 =?utf-8?B?WCsxS2o5a2J2YTVNNHRReGd4ZGVpZ1VNMHBuN1N1MTR1Wm0rUWhXQ0gyL2VS?=
 =?utf-8?B?VURZN1hMOXB4aUJ3andXcEhhK2lja2h0WVFIa3NwS1l5VVRIVHRJOURNRkFs?=
 =?utf-8?B?aDk0NnI0dmVvbDFkUWtmVldyWTcxZnhPSTFUejdsT21jZEpEMGRwT1NJeG9O?=
 =?utf-8?B?Y0VTNUdTTnM0aUhyS01xbC9icVpTaUlCd3NVWElBL1NjVyszOTJyZ0lGdHhT?=
 =?utf-8?B?Z01uQmFqWFV3WkV2Q09pRTBYNVFXb1lzSU8rd1hOMnk3NzgyMEsyZ3ByOE5V?=
 =?utf-8?B?STVvck43ODdLWVAwNXdnTTRqZStpdFhvdUtBOGNMUC81ejVTaElaUzYvcmNh?=
 =?utf-8?B?TGxVelM0WVlWNWZ0NklsWmlQTVovZGk0bUU1U0pJZXdDN0RodkV3L0RudUtJ?=
 =?utf-8?B?WXV0aXptelViQWZRZ3gvWjJOYjFFMWRZTmhFRVpXb3FwRSttb2JNczUrY3Q4?=
 =?utf-8?B?NVRQUDRxODgzWmNQTERaa0VKYWp2eTM2ejdzYjRZeUZFNE4wZDhMT21adisx?=
 =?utf-8?B?dGpBck5BR0grYUkxOGpRNDQ4bHJ6NkRzWmFORXpLbjBmSU5mNFJGdGp5NXFn?=
 =?utf-8?B?WHhnZmFPUlZwY3lldG13NmdJeGhxcldJdkpOWStIZ0QvLzdBV056bmhxUHNC?=
 =?utf-8?B?N0FRaVBjbGovbENyVzVoWGg1QkVCSW1uU3Iwd3lRbDJMU0JZRU1vMFhpYWFv?=
 =?utf-8?B?LzV3N0dIOHRQaEVEbTJWSUI2UWxIeEVPL3NPTVF5cFIxb1p3U2FIaW5CeW00?=
 =?utf-8?B?UjdSNzU2NUlZZHI3QkFvTXAvNjhLWHVJeGVzY0ZUd3haNHY5ZDZhTmJENzNT?=
 =?utf-8?B?d24rK3UrU1A0ZWFTYkgxaGtMdkw5ZURucHZKZGVHTVhRcHh0cVNMdW5odkVh?=
 =?utf-8?B?OW1rTmlpMFZDWkRlYUQ3NnFhb0N4M2JqTExHNm5IcnZIelhjY1FWRzBwcjdH?=
 =?utf-8?B?ZFE3d25ORnJoSVErU2lUNkp4WGxFTFBhcngyemw4cjc1Qi9uOHUxUjJnNGFW?=
 =?utf-8?B?d1NJcy9jQXl4T25VWXBwODJ5WGJNNm1SeENtVHpvdFBtZHZwNnFUVjVRTWRH?=
 =?utf-8?B?NEd0cEkxZTNYSjZFSnRWbGJxeTV0VWNDeWk4anJDOWFuMXBmb0NIZmRoay82?=
 =?utf-8?B?UmErNThCYmlzdE9GSUtITU1VSzE3WkZGT1dZamwrZElsRHZnK3dvME12SVRM?=
 =?utf-8?B?eExMMjA5QnUxdTRQbUFla0ZxK3ZPUzVmNEh1dnN5Y011NG50WUhoSzdxQ0o1?=
 =?utf-8?B?bHMzc3F1ZzZPOWk5KzRCWXRVVnhleFo1WmZRY2hHbmpmWGwwbmdIMmNWaTJa?=
 =?utf-8?B?eVArMG1pSExiMnNoSXVwVDcycFNUN1plWFdRUUNEOUhsT2tBejY2SDkweE9L?=
 =?utf-8?B?UEJ3ZGpzOVFUZWhLajQwN25BQ2NORC91SUo2NGtxWVFkMmZvNFBBVFpIVkVM?=
 =?utf-8?B?TFB2ZU9kYzR2UzExQUtUN3Jiekt5WFgxTU5mRzZnazkveGhRdHlQR05PaUND?=
 =?utf-8?B?SmlLTjFBdE1XSnNDdzJLWllqWnRQUkNiYS91c21lcjBBS21GbjZ6Qkd1Mjdo?=
 =?utf-8?B?bTZUalN3d0FBK2JWQmNOdHlpQlJIN0RpZnlCd2E0Skt6OFhvRlluUG4wT25a?=
 =?utf-8?B?L1ByTUYvWFREQ2kvUWoxZXRRNjVycWFGZnVMcWlpTGhtUTcyeEhMcGJuWklB?=
 =?utf-8?B?MGZyajdBdm1rbkY4end3VVF6cm9mUEVLQnFscy95a2FwUDJXVmhXWHV5c0lT?=
 =?utf-8?B?VjhGN2dOcFhSa1F5djRuazZHV21RMTdJcUhuTDFqK04wVEtvaWJOdXdSQ0U0?=
 =?utf-8?B?dStURWZXdFptZUdRVnpMcHFaWSs2K2ZzUDJlQ1J2RXZlZ09nQy9IaEhPcjBh?=
 =?utf-8?B?am1uVzYvTTIyc3REVzU3MnpEKzhQMmdsVmliVnJDc3hvMXFOK1dSNDJ2aVph?=
 =?utf-8?B?M0dpLzZYYUNSYjF4SldEb3BBUjRwVVhETm85ZVZ2UmxNVFU2Tm9ZUU9mNElR?=
 =?utf-8?B?UU91R3Z1Q2hZSzF3OExNbWVQY3FCUTFnS2Z0WFRyMGZ6cDVFdVJnQnRYclMr?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740dab78-1e94-46fb-4763-08dc7f05df71
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 11:03:58.1428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ElV7X3fYeVtGEpJ2RTXPVNKTHUzVJkwcQaJp7+cPaRF8oYdKS0icNPx5mxGT4DOIjGwSsKovWJ8/ac7VC9YLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8552
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 May 2024 11:04:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15962

On 28.05.24 11:36, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This change allows to preselect the TPM2 device for clevis in Debian
> bookworm and later.
> 
> As clevis is intented to provided TPM2 based disk encryption
> with Debian bullseye and earlier the TPM2 device selection was not avaiable
> or implemented. Since clevis v19(part of Debian bookworm) the TPM2
> device can be selected with the variable TPM2TOOLS_TCTI[1].
> 
> Setting the variable as no effect in older versions, so
> no version check was implemented.
> 
> No interface change as systemd-cryptenroll already allows
> selecting the tpm2 device.
> 
> [1]: https://github.com/latchset/clevis/commit/c6fc63fc055c18927decc7bcaa07821d5ae37614
> 
> Reported-by: Gokhan Cetin  <gokhan.cetin@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v4:
>  - use correct format of TPM2TOOLS_TCTI `<tcti-name>:<tcti-option-config>` according to
>  https://github.com/tpm2-software/tpm2-tools/blob/master/man/common/tcti.md#tcti-configuration.
> 
> Changes v3:
>  - reword commit message that the disable setting was intentional
> 
> Changes v2:
>  - reword commit message to clarify intent
> 
>  .../files/encrypt_partition.clevis.script                 | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> index ddb3eab..ceeacd1 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> @@ -13,8 +13,8 @@
>  open_tpm2_partition() {
>  	partition_device="$1"
>  	crypt_mount_name="$2"
> -	#tpm_device="$3"
> -	if ! /usr/bin/clevis luks unlock -n "$crypt_mount_name" \
> +	tpm_device="$3"
> +	if ! TPM2TOOLS_TCTI="device:$tpm_device" usr/bin/clevis luks unlock -n "$crypt_mount_name" \
>  		 -d "$partition_device"; then
>  		panic "Can't decrypt '$partition_device' !"
>  	fi
> @@ -23,11 +23,11 @@ open_tpm2_partition() {
>  enroll_tpm2_token() {
>  	partition_device="$1"
>  	passphrase="$2"
> -	#tpm_device="$3"
> +	tpm_device="$3"
>  	tpm_key_algorithm="$4"
>  	pcr_bank_hash_type="$5"
>  	if [ -x /usr/bin/clevis ]; then
> -		clevis luks bind -d "$partition_device" tpm2 '{"key":"'"$tpm_key_algorithm"'", "pcr_bank":"'"$pcr_bank_hash_type"'","pcr_ids":"7"}' < "$passphrase"
> +		TPM2TOOLS_TCTI="device:$tpm_device" clevis luks bind -d "$partition_device" tpm2 '{"key":"'"$tpm_key_algorithm"'", "pcr_bank":"'"$pcr_bank_hash_type"'","pcr_ids":"7"}' < "$passphrase"
>  	else
>  		panic "clevis not available cannot enroll tpm2 key!"
>  	fi

Thanks, applied.

Jan
-- 
Siemens AG, Technology
Linux Expert Center


