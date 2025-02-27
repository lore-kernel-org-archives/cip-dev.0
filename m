Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C023C021BE
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 09:16:18 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.58])
 by mx.groups.io with SMTP id smtpd.web11.7040.1740647775104761467
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 01:16:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Xti0OxFw;
 spf=pass (domain: siemens.com, ip: 40.107.162.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjXN7iUB5WDZ4dAdslgvekSv2hP3YC8iBhC47mAASh3sAXutVXM2NI+fARuxu2ZjEiBTSgqYTVkM21RrtuINt2OfqZBTAR8eGc/XMEzKMAvkdRBNuAwePp07OMiRwqOf2ZvbfKfTBtDpG0XI56oYZQ5USRAFrOFv5FSKGow1uk++Fr3ckiif6BQSI6yQ1KnKn9d7yzxBKZLqITiIsz8B13CLYmddP+YJbpZyda/UgFtstH3lZnN5CjWGhz5K53t6F9+D65qS9SaMpbv/7mHSZ9599EEwqCkqT2tjwaFMYuUus0/g7dbCoYgDDd54B//8ZqogI/RhfWPRkkR7kix56A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zC25uW+FXbwFZYysyIl712NfVeSYtLE6hemHFn9sBsM=;
 b=XBjbPSBUv3zPTKTkcmFwzx0GkPmQYLV+12CbOhgUSqjPpHu0jvfpdEZ+kwmJSHVJsCfAcXL1VHDdz5yvVrdxnpoNjrBCLrt/on5i5ugETQM07PFNTfdt6UA7D4ASo1Eg2QsUii8WBIrrlLpKM6nYO4H5SE0kGqm7ktmy59SeSWR5yCT9sL9UbqJSzhnWoUKUag/KDwUM8Qj5INvK5zFK+Yy/nh3O+7sjQAQAjqJ53vUzD9SUs8xvsVUUC2WpPdQTEBT537Lwat+GxITQXIbR7r5VJ7QXoCKC5g/FKckldS17P+FbxDG1SOOqFNfkrNt6aoHidymiT1yA/j+lRAWgJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zC25uW+FXbwFZYysyIl712NfVeSYtLE6hemHFn9sBsM=;
 b=Xti0OxFwCGr+nf8rN90uDcb2ODB5EwfBhzrQoGF41VQ8Jc4KjnDMnstjxm+nssCelBhoOS4FAFNS7CTAW7Ain5HiDLGMhpevupxYb0mgUzzXqmAk11xyOPqqn4r6hyHLZKcBVj+6/bH7gWMqnkgzk0F2XK+0O2JB5tf8Q1Dmt1ubpon0D/Lwq8jfLj0mMX/fcHv6ugWgkqyjaYnaegi09zZThTrVZxI3Mtj6ravia+tjKjT7EzmvwI7QR/ZMI/IUrlkVb1SmXQCdRxdZ1wly5mLu8OJbCceNOM/ICSNm3nkr6SCIBNEG/FiSIeJJ/DaMZmfj3PFNQj/9PCjHLvHapg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7743.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:46e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 09:16:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 09:16:09 +0000
Message-ID: <bbedfad1-fb7e-4664-a42d-c37f4f6b35be@siemens.com>
Date: Thu, 27 Feb 2025 10:16:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] initramfs-crypt-hook: use real device path in
 luksFormat case
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20250226095921.168962-1-ch@denx.de>
 <20250226095921.168962-4-ch@denx.de>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250226095921.168962-4-ch@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7743:EE_
X-MS-Office365-Filtering-Correlation-Id: 90e53c4e-d56b-4f85-beb6-08dd570f5ee5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VVp2SWJzR1ZYYXJtSWFQMXJURXJnZlkwOUo0bElLdHMwOS9MU1RpNGNBV21v?=
 =?utf-8?B?eE11Ymd5c1ZENGlkbHYwM3VRMGJiT2Jzd2hWU081aHlOSEdOL0dyU1JoKzVY?=
 =?utf-8?B?WFJNNkxKVTZOUWdHRE5zOTY1QkxuSFJod1RWN09SQmJacFQ1TTgyZlV2b2xD?=
 =?utf-8?B?ZUFtcTdqcUM3Zy9jL2tERUNPaGJaSUxOUDJsNUpKTWorMFN2MUlJNmtNZVVI?=
 =?utf-8?B?TXF6K2M2U2ZidCtWSjZVWGttdFdYYUVlbUw3bTdQSWU1MFNscE13ME5YY2hM?=
 =?utf-8?B?V0JFVVFkR3JuMC9aTHpmTWZIZ2pYdDdydVROZlgxSkRCNDNqMVNFOXl3MzdC?=
 =?utf-8?B?MldWUFRSdnc5ZjAwZDNWUzd2aDVTdWlDMTMwK0NuUmRnYWhuSDZ2YlBKNGM3?=
 =?utf-8?B?YzBqTHZSZEhmNFMxYm9TRWhRYlVzVHQ3aDZhNlltcWhWUlFYZENTR0NVOVpU?=
 =?utf-8?B?WkxDMEFvaWZJMkZBbkNHckVGTHRaZm1sb01YemMwS3lsUVNTZXltTHZCVllH?=
 =?utf-8?B?YlRPdER4OFRQb0FHTWF5NEl0RnlnU0dQejZPTUFyeHk4dGVpWEUwVllDc2lu?=
 =?utf-8?B?VUpydFp2YUYyZFpWMzJWTlFLV2FaL2JWU0xVRExoVUR1N0drZ1pIbnVraHpz?=
 =?utf-8?B?QXpkKzk2Rmtha3BLQVJyd2YwZzRpSlZvdU1pcmRabUdYWXh5QzdKS0lXYjBl?=
 =?utf-8?B?TzNQd0J4SnJuNnhFTVozcXk1TncxSmZYTkwrS2FqbGk3TTN1QjJvRXpKamFi?=
 =?utf-8?B?ajgrOFVvUjhDYkR4MDJ5OWtiRXZQeWg4bG9PbEY2ZnlXRUFUUEtWYlRTV0c4?=
 =?utf-8?B?V09BSXRCVy9nRVZ5NURFdmI1T21ibUtFd1FSeENMbUxCVnp3S2RGYW50VUxE?=
 =?utf-8?B?MzdHcXl1U3JkR3hoWGJQMmEwL0pqeHdUcDA5R1k2N25tQytobUR4UUtGWmtL?=
 =?utf-8?B?NHZTczlPZEdQcUY3cWRZUE9EZitDUEQrcFZNVkJidE03ek1CcFE0S05sckZr?=
 =?utf-8?B?TWVBdWRXcFVaR0ZzbmxnYkpPNW40bm40TlU5OGFwdHdhMXdXZjhYSzFmN1Fm?=
 =?utf-8?B?WVlnSnFXUVVGeGFmbnNNOE12Q1Z1T2JoMk91UzgyeGM0WkpMRWNKZzJXcVBl?=
 =?utf-8?B?VS81ZTBqbFdEY3E4c3U1SFoyMVpmemhZTk1mK2d6Q2dvcHBZMTA3c1g3L255?=
 =?utf-8?B?cEZCcFlhVG5BdUxtYllVYjBiSXE3eVlseDNrcHpOamYvc2VUeitZcVQ0U3JK?=
 =?utf-8?B?QUlSYzkrQXVyK0ZBZ3JLSHJXNWFXVDdTNDg3VDVoWlN5ejZlRWtGelZJNXdD?=
 =?utf-8?B?cTFLem9aMjl3cnVQVlpSdUdZWjVGOGorc2NRRklOWE1leER6T0hBZE4rRDVr?=
 =?utf-8?B?dkU1QUZRcXBJOTltd0hvMnFnWEI5cmV2TDRmYjlpKzRSN0pqQ0o2YlpGamlD?=
 =?utf-8?B?LzhnZXNyVUtsaGtOZ0ZCR3ZWc2hiamh0QWg4UHpQbkJ4UVR5TWhVT1hvNkR3?=
 =?utf-8?B?WCt4M0ZBZHZtWW9GSnJ1OHllNStDQUJWYytGYUxrN1I1ampYdVY0VDU3R2Zp?=
 =?utf-8?B?TGVaWUFRa05SeE5jRlRac1JFWlBoTUgwS1NIYlNLaW1GcEEwdUtXdEYrbDhw?=
 =?utf-8?B?eUZVR0JpTlBSTFdZNm54QU0xVkdYbmU4YVlFUllPNzJMSUltOUFEWnNLK1B3?=
 =?utf-8?B?ZVZJcEFocjlDaCtyOG54dVVHdkNyRGxPNXc1M24zOVMvTCt5NUgvVEU4YklO?=
 =?utf-8?B?ZzhJWGxuUkQ1Q1FjQ05rSFdkbityVGQ5bG4yQzFwZTdlWTJnNUZicUZ0ME9Y?=
 =?utf-8?B?dnZDUndsODIyWnc0WWNMcEpsUmZzbTU5NnlOamY3Y3hNWlVnQXR6MzQ4c0N6?=
 =?utf-8?Q?nuPGcqbrT0z22?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZDJ6Q3p1MmczQnNWdkNOcWwxMUhlTUR5Q2hKNFhXZnZwakhDV2lPa1hNYUVJ?=
 =?utf-8?B?QnhXdVI2bTVlRkpWWGF6bFNZMmJ3UmcweUp2eVE4cHkxMTd4eWZ3SEdacit0?=
 =?utf-8?B?R0FuK0pvOFNNemE5YkVpbTJJaStXYitlSGk2OFJraXVGc1BNZnBKVVhBdDZB?=
 =?utf-8?B?eU05aW9lN0U0eFdFQzdZRTJDeU1mVzFEbzJGSlRMMUhXR1ZMMEduaStZa2VI?=
 =?utf-8?B?MXhqS1RRa05mOHhKR0l1V0Y0VGVSS3dGN1QrdEptb1JOTENjR1d4SGMrR0xQ?=
 =?utf-8?B?Zy8vVC9PSnpDNDdsaGdwZ1dtMWFPc3JtT1JSQ3ZwRDJmeTN0OGNsNlBJRDA2?=
 =?utf-8?B?Y2RLZjJnWERUMGxoMng3U1Z3SXIwMGJ2alRHc2NQdGdsOWRSa3MyYjU2M0Q4?=
 =?utf-8?B?VmU5RE5kaVZKWHRkSEppMjVHRm1sT1RqMHloaStXRXVFZWM3emRXMkZrMEpR?=
 =?utf-8?B?Q3d5cjZSWXBlM0N2Y2I3TVhzRnV2aVozbi9NNXc4MUU5N3ltZXVXdElERkQ1?=
 =?utf-8?B?czkyelk2RWFwUEpYVktXN2Y0TkpOQm9GVkFlbUUwNTh1aWsydUc2TmtDWTZ4?=
 =?utf-8?B?WS9EZ2hoTkY1bkFnNlpMV1NpWFRCdk5EaEpsT2QwWHN3dlc4ejN2SjJmU0tp?=
 =?utf-8?B?NlJoKzkvZUo3WFF2enBGQkEwL1NmblFqaUIvdFNMbytEZ1daVGZETDFpQlRv?=
 =?utf-8?B?QXlYMmdpNW5FWnM3YUZOcVkvNWtRNUxhQ3h1a1dRNDFncVRwQmRwNzZick5V?=
 =?utf-8?B?bm5wNWI5bStTcCtDdlVyaEtXV016MmdVd2ZWQ2ZZTG1lRlZCTWU2ak5RRXht?=
 =?utf-8?B?TjZibGl3clFHRUtnRzF6OTVCRUJtL3dzMzZVaEdvdms5WWRYUHFRWEFLWXZa?=
 =?utf-8?B?dDRnTkJyM3hmcno5ZEs3NjBhSUxPTmtvNWRhRTNZUXZjTGJKd2tEWVdFdTJi?=
 =?utf-8?B?QjUzR09MSU43OEFyeEFkTi9EZEhFV3NMZjZpUytYajVzWFZEZkF1N0hnTjhi?=
 =?utf-8?B?OTlnTWkrNHE2TEdrdlVHSHNzckVBQXFaZ3J6clpieXpPYWtTZlB3bnpneDVK?=
 =?utf-8?B?cFk3Y1pvS3FIU05oVXpvRU0yMlJqeElYcU1Senk1bzBVd1Vqdldha0tJT0dX?=
 =?utf-8?B?c0pyblJ4OFNMZEdDNDBBbjc1NVNuNDJ6MUJMcVMxWGVrSFpFQS9aRWtWN2ND?=
 =?utf-8?B?cEpEQU5WNHBUenlqZHBrTERONWd5NkFEYkFlRFlmU3hGcWw4eHRYWmtIWWxm?=
 =?utf-8?B?SVN2NWthc1lUV0g3cUNYT3J6a01CeEZpMk9jZzlTcmovOUNjL2FtU3FRbzNt?=
 =?utf-8?B?RUxpZWUrVERkb09mL0ZuWUdibmdiaEdnQWIwejZXTkNWYmFPakxtRWxFc0ZC?=
 =?utf-8?B?MTRKWGtOdENpRk55K1FnT1lKeUhTSVlwSmRIc1FxN3RZNTkzUDBwTWNTZ1ly?=
 =?utf-8?B?U3lrS3dqSGNWWGM2TzBWVnJYY0tJb1NmZTZDTTloZENDR0tNaWlUSjRkU1h3?=
 =?utf-8?B?d0F5Sk9zWHBJSkNKbUQ3dEM3NkpZa05LeHRhK0NGV28rUDE4WmFoM2hteDZu?=
 =?utf-8?B?M3Z4NG5MRDMza001WGJuVUd5cTZPbzBPWFFJNUNmZHBJbURNc056emFPYU03?=
 =?utf-8?B?NDFZUDhMMHMxS2I1WVYzWHJSam9UWDFoVnJDeks1L0xObDZXc0NRR2F2VnBj?=
 =?utf-8?B?N3M3L0lOcVpYcmFHOGFiQXBmdFVGZXFkRGQxK1JNc00za0xyOE1vK3hjZ2F6?=
 =?utf-8?B?ekx6VVhMQml1UkdYanhYSnFTZGE0MmVqMEZQMkVMZDhlWmNaWnpEbjV2S29H?=
 =?utf-8?B?VHFyMjNXNG1LQlBnL3dPTm1YVkgzU0Y2L2xHcVVaLzJIeWNuOE9jMWZ5aXZM?=
 =?utf-8?B?dEhWNmM3bGErUFN3a3BGRE9RQ0Nob28vUEFzSWtZdGU5ZU1nNjZlcXl0aVNV?=
 =?utf-8?B?a2ZWNUhXR1JJbVpZajFETldubVBFSTY1cnY0RnE0bHNqaUVMVk1CaFpvNjZY?=
 =?utf-8?B?ak9OZ2FzT1crZUFnTnpGNUw5eGF0dlp0M0lwMUhoa3AvYjBTSTV6TVNPM2pR?=
 =?utf-8?B?SEFXUUg5WURSdnF1R0sxUDVSa2dqc1FlZVc5T1hyQ1pkMVlwTXNiOTN6QWpl?=
 =?utf-8?B?dU42SjZLOEVUSVl1N3drMFhJcVBGcEg2WHA2ZmJQS255ajc3NFlBUUIrVUlZ?=
 =?utf-8?B?ZWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e53c4e-d56b-4f85-beb6-08dd570f5ee5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 09:16:09.0333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rB5tWCsZvDhI5DpTb1hxv3RVSsDl1rIBVmj28rzBWgi/WZQRpUTGOgcYrPe5jjwVVdqLVJeZIRa9VMAgEnZ4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7743
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 09:16:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17932

On 26.02.25 10:59, Claudius Heine wrote:
> In the 'format' case the `$partition` variable is used instead of
> `$part_device`, which is likely an error, because all other cases use
> `$part_device`.
> 
> `$part_device` is the real path to the block device, while `$partition`
> is the 'name' of the partition in the `$PARITIONS` variable, as defined
> in the recipe.
> 
> This fixes an inconsistency, it shouldn't be a bug here, but could
> result in bugs when this script is adapted in product layers, etc.
> 
> Signed-off-by: Claudius Heine <ch@denx.de>
> ---
>  recipes-initramfs/initramfs-crypt-hook/files/local-top-complete | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index f1aa0d7..b907ea7 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -254,7 +254,7 @@ for partition_set in $partition_sets; do
>  		"format")
>  			log_begin_msg "Encryption of ${part_device}"
>  			/usr/sbin/cryptsetup luksFormat --batch-mode \
> -				 --type luks2 "$partition" < "$tmp_key"
> +				 --type luks2 "$part_device" < "$tmp_key"
>  			enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_algorithm" "$pcr_bank_hash_type"
>  			open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
>  			eval "${create_file_system_cmd} ${decrypted_part}"

This goes back to commit 98974a68ab9b, and there it is stated:

+       # clevis does not work with links in /dev/disk*
+       part_device=$(readlink -f "$partition")

So this really looks like a pure consistency cleanup (but a valid one).
Right, Quirin?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

