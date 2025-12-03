Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10453D1266D
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 06:57:15 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.25])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9198.1764745021891450375
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Dec 2025 22:57:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kpo7P2UZ;
 spf=pass (domain: siemens.com, ip: 52.101.70.25, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0ct/yBTIzg8fcuItb3WcJstdBRgTK7Z+ET6wV+CaJlGr22O1nUf/Q2YhK3sWI+/Of9FjNVvSm8M7ww81SMpHr0+WHQhc/Zpj31/841ub299nfSiaLIPexx12nKYP9/7KVf2h70PouRTquRWHSnjK6rFZcg1R1aYO0zRYrFp2tuv+MwGI87gyu5YeLHCDZp5PnXaJFg+mioTqALWnjusAmmEdgSX28MuySwoMvGIYNfsVzOtGmXAyl4EKKblXoJ+aeiLD/uk/gCN3IOvxjxQMhpTMCBwiP8Nm7QfoEJ+0nfsVOxe1xE0Bx+s3Ws+Xjs3rXzWgRcQsx7EkjTNr2TtOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qb1o/kiwUfPdPpLiQzejp09IbcsqfDd0pvCPKTFqbKE=;
 b=toeq3gqpyDX7DTQty3y158U551UitU7H4COJFMw7Pi51jkI//R3XQbWmlMDBb5nM1+CJtm9HAhIa9iVrwstv1gozHhhTsHbCi8kmDlMZhRyVIGXCeplsIa9FfJZf6vb+FuLcJ6r6kTS8hV28ubeHW58HSKxVhxlKDBq95yJiw470m5KFUGOdC/X0KyutqoAM16/nTrZSAb0hpmMn3/kt5XMgYvQD/GgD3mS79XitpMvcmFrLy+oteoCrIbDU5p3cEYsyM3uTaqEc0Am8z4GMrXgzUE9ztl8n0KQ7f6bljnHbu1nlOkK5AoU60rumix0AcSZUMxXEUwpfqgtK1cmOfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qb1o/kiwUfPdPpLiQzejp09IbcsqfDd0pvCPKTFqbKE=;
 b=kpo7P2UZ6r4waAcWN5tymxwdHGyTHjfXlLo27kaCldkBqemK9/F8PYspMN7yyS1D/sAWleCzVspyUPGGMRmIt9KboK9RL8ksT89a1av9HecaplOtF7MDOFiGYx7OgQtIQbZ5h7wjYM60UzTM3qmAaK0jJe/b8h4UhP/GG5qXXU8JO5qHfOozR8UIkk+2vZk6LLNt53s8hCrUhIX85wyPBGvwPqe2eLddO81SQ9YlfeL0aTInGDUuDTLhjFuxsFZ6FcYxei/vDKV2QvmuvwTysItjk3PcARpD87VkOrUy/cVBqld0POz97MWv1tcXhNk84xDZPIHKIJBEkyM6SZlwyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7201.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Wed, 3 Dec
 2025 06:56:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 06:56:57 +0000
Message-ID: <dd3389e9-ed02-4c26-af6b-7ee37fed58d2@siemens.com>
Date: Wed, 3 Dec 2025 07:56:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] initramfs-vertiy-hook: Fixing log when
 verityroot device was not found initially.
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
References: <20251202154959.784147-1-alexander.heinisch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251202154959.784147-1-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0366.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: eb807a99-dcd2-4860-90a8-08de32392670
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ajV5RDkwU211bTJFV3p5RXRLUGJ6TG53T1c2djlvVmxoRVFncXZhUXFRdnJq?=
 =?utf-8?B?VDFidytzUzVuMnBWWk5FM0orNk5VekcrM2pzRzNmZjB4YW5WRHhZZ25BNjNH?=
 =?utf-8?B?TkI2Wlh2YmQ2SWtBemNPYmhhTzlYVVFJSjVqMmhiUVY0ZStxZTdRNHJsOW5i?=
 =?utf-8?B?ajJuMWRPZ29TK0Z3eWZOOGp3blk4T3FEUENMQWtZcjBtUkVFUHhIdTdXbXJY?=
 =?utf-8?B?VWhnbWNra2xCeXNpN042Vk9PUDJEcjh1TENadnZWYzRTSVpZUXVseFo3UGRL?=
 =?utf-8?B?SGtVckxaNGdNdnMycVM2dmJxNCtySFhpbW5QWlc0eXA0ekdCVmVOWjNPUitR?=
 =?utf-8?B?OTdldDZ6MzNrR25tRW1zV2x4azRzcUxOajZBWC84TGtiRVZQY3RVbU9BdW9j?=
 =?utf-8?B?czBRZEppUTRoZGJwY0t5c2dPRnJpRkdCOVdmWk9nSkZwWkQxYUcrQ3pvQk5J?=
 =?utf-8?B?bkJNRkJkZ0dnOHRFZlExS1ZKNDhBZHlYam9BM0ZXR2JLT0t5eEtndWhrRjJX?=
 =?utf-8?B?TW50OVE5Q0ZTOStzU2JwLzVvSnZGeG1iQWd3RHlzbks5RWJyNHJoYVVtWHB5?=
 =?utf-8?B?NWNoS1o5RDA3L29qdDE1NlJMOVdjV3JCMWpFQnNwRWx0dkpFZ0NTSmFwWnZZ?=
 =?utf-8?B?aWhhWkM0cjB2NlRFdFZnZkFONitzNlBEcGFIQzZDTUJnQys4L3ZiTlhYMUVM?=
 =?utf-8?B?djV5K3oyc2t4NWd1QjJoSWtrdDNIVzlZSWVWaHdYdWlFOU4xdndwaGQyNTVW?=
 =?utf-8?B?Q3lZRnN2aXJDNHA4UVpYT2pTOHRjUE4vTlFkc3dnVFJ5YTVzdDRONVdrQlpJ?=
 =?utf-8?B?U0NDQ2NrQW1wcjNNeW1MRk9iTVpIMHJzNUNSdHJtakJZanB1TzQzNFlIYkVC?=
 =?utf-8?B?eWRacVZqMUptdHBxZytGczJ4dzNpSGVyTHZlbWJDeXREcERJL2JnTGVobXhM?=
 =?utf-8?B?VU5JTWFXT0dKMlpobkFodzVSdFFLVFJ0UzRQT3NJTUVkcDI1RXJrd25sdDBP?=
 =?utf-8?B?M2RpaUt4QXk3bEJWRHVjVDY1dEliMTk5aXh1eVdMaU40VEROZTI4YWxGSFVw?=
 =?utf-8?B?c1p5RFd5NUxWcDZSNVNkK2R1NHpkMS95L1lGNXZEbW1VWHVSbUFuVmV6cis0?=
 =?utf-8?B?N211S2hlWTEvZlJxUzg1ZEtlYjRMNmFsbUFPS2hWd0NXK3VCOXZIVlJ5U3Z0?=
 =?utf-8?B?MCtyYkNLUlVEbThPWHI0U2xudEtOdmd1NmZDenVLUTZVM2RNUStGaWhvODh6?=
 =?utf-8?B?a2xJQktEZTFYdE1MSTJRNlhZYW41YWRHbDYyVTNuRXE2WTdBbElKcWtlY2ht?=
 =?utf-8?B?d2NRQUVJelF5NjlNdkpiUThYTTdnODNIQTZIK0tDTzl0a3RXb2d4NFdkTDZO?=
 =?utf-8?B?M1dsRk0reGlpYWIrKysyakQyUVFxV0FneFRtMk9xZW8wemdRT2ZxOHE3LzhJ?=
 =?utf-8?B?Tyt6M0d1enFxSHkxSC9kRmlEaEt4YWZGUnR0Qjlma0FGTVVSL0FIR20rRzlX?=
 =?utf-8?B?VmNFMm1aQklMazhkTFowc2phTTdLdHFSNFlhSzVneFdKMThBalEyRmNGd04r?=
 =?utf-8?B?RFVtMkpjQnJKMmhDR0c4ZnFPaWNEb2VTdnU0U3JieXlhczltOVVUaTJrZUlp?=
 =?utf-8?B?WjE2QXI2MHRlY3V1VjRnNmVwZVZMc2VITUhad0N1bU40RXIwR2tqVWxmREpU?=
 =?utf-8?B?TEhFVDh4TnZ4d2xqdkxiVm95U3pXcVFhUnJ4Q0R6RHdyK1hZRnZTd2pyaWdZ?=
 =?utf-8?B?NFVBckdGNG9TdE9QYlFQR20rNUg1Nkgwc1d1blF0eXM3aWZaTUxobTd1M1VG?=
 =?utf-8?B?Ync3WFNDZVZnNXB1TTFtdWFGeDVWenhOSzVNdmZSYzd4MjFWekgyVmFjeWpT?=
 =?utf-8?B?QTlNTmtSWnpyWkxEeXFRN0xoUmJJVm4vOC95VzZ5VFlXWEN6Qm9tREJaMVkv?=
 =?utf-8?Q?stOh6XY1u4PJn8Ym7WaXJa2h3HJjlQFw?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ekwybllIZVZxM3FRV3B2MWU2dnEvY2tHUzIrSXpia1FwTTFwNmxWemlNRUxX?=
 =?utf-8?B?YmVSVmphOWExdEtnOERDdVp3MnJXRWNMMXdvK3loZkdPQmxUZHNLZUpRK0Zm?=
 =?utf-8?B?Q1N1THg4bUUxNFVpUU5CRTN2UGc5N1VOZkw2OE1Tak5pM3Z3NEhiaFRJdHpz?=
 =?utf-8?B?dnN3WHJoMzF4V0JKVjVoNjhRVzRsaHVPRnFVS2ZuZEhDUStyZytWbVl3cTBr?=
 =?utf-8?B?N3dncmM4U2cvZnRPLzNQWHJPUW9qZENHNEtqOUpTSnlhRXJFMVoyandscDZB?=
 =?utf-8?B?WjFyK1VSejhHQkk5dk5TRHpLMlNWdEc4REEvT1BRMnJlUWpaWFEvOXNHVldz?=
 =?utf-8?B?WFBoYjhoU2FXLzloZlJJU1VCdjR0UDlaeW1yeEJTNmtaMnZNR3Y2ZUtHRVN5?=
 =?utf-8?B?Q3BTYXI5NzhYV0oyaFRZWlQzMzBjUDdOSEFzeGpSd2hzeVZYcW9sOFhZSE1j?=
 =?utf-8?B?VGJtUk15a3VDeXV1ZHN2M3JNSjJWLzUyc016cWhBZFVmeTdPR1gxVFlReXhS?=
 =?utf-8?B?Y2FWemRqNzNVVEYrWlI4SllDMmtKb1grV1FEcWE0T3JOdEJGTmRPaGcxZGxh?=
 =?utf-8?B?VTE1dmo0Nk13d3JYTXRnQjR5RlV4Q2pZNTc4Ylc3YnA2cUx6U05HcFR2ZGpC?=
 =?utf-8?B?R09WWStEY3NQZGJ6OFF5MmNtZnZwbFhGRFBBU0JXeHphcllPT1MvMWFVTE95?=
 =?utf-8?B?NTVzdy9OMzVqeUNRbEl5QllvNitrRnNjNW1nYzdJNnZhOThud1VUNVUvVXVn?=
 =?utf-8?B?SnRnTVhFOThLbXZ3WmFkb3IwK0JjeXdhQUdBL2s2TDdjdURhMlY5cjJvNE9p?=
 =?utf-8?B?SklMNlgwYWtwR3hUMU12ZTF0L2UzL1BDblBMQ2c1bXg3UWtBTURpdTEzaFlx?=
 =?utf-8?B?MWlMaURmOWNwR01YVWNMVUxFYWJoaGloa3g4RlpwcnIvejlhRm5UZUlGUzRK?=
 =?utf-8?B?MTBCV05MQ1VTOEEwSGdVUzFieEpMMTVPcjN6NVc4RjVjSXd4RmcwZW9va1Bo?=
 =?utf-8?B?cllxSXhJSFNxT2RnVXR3eGptUWtoU21YT2pSUGRKL0Q1UlRVU2ZqRWNyVSsw?=
 =?utf-8?B?bVQycEliWjIyNXoxcFd1RFZmWDU4UnErVG5MQUdOa21MdlgvVHNyYmVzYU5y?=
 =?utf-8?B?aTM3emRpcWNUNVNSMEJMWE1PMFBPUXBiZzIwaHU5K3kxOWNYSFVQbW8rWXBo?=
 =?utf-8?B?aDZ0M0NsVElDUGYrRmZURkdKekdCWGUzUmEwTlRWZXdZQnZ3V0dGMGp2R2JZ?=
 =?utf-8?B?ckZRS3F3UVpNb1d2UDNZeWJkd0lmZDNadS8raHZhVk9BZG9CZFB4Sk1EWnRT?=
 =?utf-8?B?S3RtUEQ5MVZWZ1JlWVc2VXl3YnpiWDNmK3dKU21LRi83MWFEUVhWdlpkQm1q?=
 =?utf-8?B?Q255OE1WUDlRQ1RlVTQ3QXhkL1NWTTMxZStRbHdvUzJaR04zT2RzUnlZZlRG?=
 =?utf-8?B?QXduQkxXOUtsQWxFWmhtNndUb3BzcXd6cGdlMllpbHdsNFNzOUg0RjhsWWxG?=
 =?utf-8?B?eENVSG1UMzZEeFhPTytzRURBQmtqVWVsaHpLNzV5VDRtOXR0VlJiTjVFdVJZ?=
 =?utf-8?B?YlBGT0YrT3JZY2lPVm14Y0xtYy9aMUx0T0l4WTdYZDdCZXhkNDBPVkIrU2pM?=
 =?utf-8?B?dEtNRHM0a1dhYjlSN0VkSjRQQWwxOWNjaDAvZ2NyOE0xdXZJSFRJYy9ZaWVz?=
 =?utf-8?B?azloVm5nWHMrM09KVStLRXBoM2Z4SW9BcW9FY3YzVkxTa2x1N0FDUFhqM1lH?=
 =?utf-8?B?VXFFNHdoRTFURXRCTmp5MnFBWkN6ajNtanBuYTdSSEFUZ2dQZ0UxUlJWVkVL?=
 =?utf-8?B?VEtGRk9CTEUwTXpnaEJ6bU00N0h6U3llT1FTMGNyWTNoT0VvUU11VjQ4bnVa?=
 =?utf-8?B?ZDhLakIzL1l4Z0NTVEhjc0lNYU1aM1hRNlRCZlFLVGNlSnNsc0loTmJLWndp?=
 =?utf-8?B?ZzJFeFg3WnlLNkpLU202ZXpLVS9iZHlCVEZQWnZpZ2RkM3JNb0hKRWNRTGJ0?=
 =?utf-8?B?dDJsQUNOTG9DYndqemhLNCs4T1NrZUlBUUNUYUxWTjBhYlN3VFJIZ0huNjVi?=
 =?utf-8?B?Q3huOTZMV1dCNTMySnA5VkQ2OGUrWDhzZ2xneXNpOWpjSjJZMmtubTFGbkhl?=
 =?utf-8?Q?82kTtPO8J7mCh1hB4NtgvPY34?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb807a99-dcd2-4860-90a8-08de32392670
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 06:56:57.4284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JcvREdj99BXoTq9vVuISplqJsqMPU/d4jo74skiYiAycRPTBH6pZFBvXdDMGagAnyx1j2FEu60i3u4pF81v23g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7201
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Dec 2025 06:57:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20812

On 02.12.25 16:49, alexander.heinisch@siemens.com wrote:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
> This seems to be a copy/paste error from abrootfs-hook introduced in 27f88e9a
> 
> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
> ---
>  .../initramfs-verity-hook/files/local-top-complete.tmpl         | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-verity-hook/files/local-top-complete.tmpl b/recipes-initramfs/initramfs-verity-hook/files/local-top-complete.tmpl
> index db805c0..ba7bb7f 100644
> --- a/recipes-initramfs/initramfs-verity-hook/files/local-top-complete.tmpl
> +++ b/recipes-initramfs/initramfs-verity-hook/files/local-top-complete.tmpl
> @@ -122,7 +122,7 @@ case "$ROOT" in
>          partitions="$(blkid -o device)"
>          find_root_via_image_uuid "$partitions"
>          if [ -z "${found_root}" ]; then
> -            log_begin_msg "Waiting for IMAGE_UUID=${TARGET_IMAGE_UUID}"
> +            log_begin_msg "Waiting for disk with verity header UUID=${UUID}"
>              scanned_partitions="${partitions}"
>              wait_30sec_for_condition scan_for_partitions
>          fi

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

