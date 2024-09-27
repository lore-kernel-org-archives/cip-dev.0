Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D54FCEBF9E
	for <webhook@archiver.kernel.org>; Fri, 27 Sep 2024 12:02:44 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.57])
 by mx.groups.io with SMTP id smtpd.web11.67453.1727438562007763986
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Sep 2024 05:02:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZoMtTQma;
 spf=pass (domain: siemens.com, ip: 40.107.105.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uk0zUPCjSTqZdBRvtER8WEFi5hiwfbqigM22e1yz2knXV6cp560fHHbkKn8s9e4F3l6ATySd+TQvvVv1QZ1V/yqBbICpgtnTMgcZ4II7onvY7tbtrh/klrr8od4hypXjdFgtW06MGfDSjuOTWfNTPWrKodRFURRQrBKa3F1DlEtC3pKQ9c9gItGNJhFYz7Am1yQgAG+JXIOBVyuzWUgGfrLbZu4inccFQUudqoflu5QMegoZZjj3b3J01CtscUlnLpN2hG+MXCLvOcpf8CwYXCdEufmBFn6i/CReG2HkExGik9toAm+B2B08jjLf+lmbEz7yXC4RuFD0ZlWuI2X8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQeRHoC/AOtodxLEqKyrwAj7Oyp4c1fnQ+8+sOwwpd0=;
 b=b5mPhU4KJSPpMBzDPFGcxpKnTgt0zPnv6hOIfjJolWeoFLzpkc0ziF86F/WjjB3s2DysaTs4c1MtsobVh9zI1enJaRu+wZ1/AIMw9CauleXHMkCqQ9JlCPGbmxpYz2j+1SEz/uUcHL3VwIyM4MQvFN+wm4X1Pz/dC1QCWQYFF/5XcVzvor+EJQU5fXVPxNDhucIInLvjDmDf3IGNtONmpcyNuOhIPzgtc8QeYFnT0+9tvGfQjiPLEtwfpu+0ad4oXtCwmTlzATNlajRcA5qisBnlbpnV6ZFK+1XV7xFQ3uxR9PxrrQZhX5Vhmy9I8FGlQ+Xxn/zQ9Q8Ry7DVKhT0BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQeRHoC/AOtodxLEqKyrwAj7Oyp4c1fnQ+8+sOwwpd0=;
 b=ZoMtTQmaPT3aStS3kB8D3ilDdWw3zwSHiawq3U1vwvulgaUbuxfl4AjvV8zJmhC0BNz+pnN6FZHFKbcOqR2uo0FK+DG7IePoT+5E/3HL1DzEGq4gqSyJrFff7+k/4o0CJp8ZTDYyumVijR+j2SroqU0Pk7hM8vgbDM3SIZ1J724TM1GP0/cPx3h78IEC7NTgqWm/qa9D166wgu2sZsHRcjeuBCqd9vwjIZZ5mdHnBmPVDej5IwzxHfCo+bnm1qQjGmKRUMaUQjCEaI006dSKayX4QqAwbk9RDskLaHlERxKFpYBKQaRPWVdpLKMs2ztSFRjJ6fZEc/NHtyuKvdFPGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8731.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:443::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.30; Fri, 27 Sep
 2024 12:02:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 12:02:39 +0000
Message-ID: <261ec54a-c56b-4280-b803-395a83fd16c0@siemens.com>
Date: Fri, 27 Sep 2024 14:02:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] Add missing paragraph for
 ABROOTFS_PART_UUIDs in production
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240918102509.1526632-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240918102509.1526632-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8731:EE_
X-MS-Office365-Filtering-Correlation-Id: 020c4da7-8b38-4de4-eb7a-08dcdeec4892
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?b2F5YUUzUjNjTmhxVjRnT3pkL0RSb0Vid2c0Yk5ibnBYYkNmanJkQitCWEZo?=
 =?utf-8?B?NGhUOGpHVEhJZWgvbUJRMkpSVTJ0OUwwSHNzUDJJTkdza3FyQk9XckJWS1FE?=
 =?utf-8?B?dUdRaGpNUFNaOGRZdll1dGZSUXIxM3F5NERzME9NWGh1YkpibHhlbEY3bis2?=
 =?utf-8?B?MGs0VHROVzV2UDI3bzRtSnZsZWRsQnBRRVBkQnlXL3J0Q3BWd0F3K2ZlcW1z?=
 =?utf-8?B?eEc1SjZXRGNuNk5UYVR5eDVzR1k5MkNETVJqeUdzQ0pYbWhDcTRUZGpYRVlk?=
 =?utf-8?B?WFZzVTFTeEpwYW9XOEpPYlNubEFqcWgzbEtFRXdKRmE0czZtbnFrbEhaRkx1?=
 =?utf-8?B?aHVmVTRvTnlCT2I5L0NhUldkOWxyUThLMm9XU2d0bm1YKzhvVTVPVDhVMmZr?=
 =?utf-8?B?RWtnbTR5OU9RSjZHMi9jMlNQK2lFbFZpUVZKb2NLTkJCVWtJTUtNczJjTmVF?=
 =?utf-8?B?Q2l0OWk0UjliUHFZTENkd2swT2Q4MlRnQ1llbUZnTDlJMWhKdnExb05LNnFo?=
 =?utf-8?B?MXM0U014VGVMWVR3aDF0b1hYcFF2QWFveTBwdERXVUJjVDdRM2NpMlZKQkN3?=
 =?utf-8?B?WnhvUWtXU0tUWjNndnVFMGNqRDhNSDBTcHJScThTdjhOVkFrT1BYdk9rRnJo?=
 =?utf-8?B?UTQzc2MyU0RwODhHSVFzMkw0aHZuMExxUzYyYnlLQklHMTgxdVJZMFo1REtS?=
 =?utf-8?B?V3pKQjJPUWhMV1hIa3RNM2JVS2pWQldJM0xtNlh1V3pBcXNrODBTR0tJaTFX?=
 =?utf-8?B?YWZ2VjhPVEFsR2pTM0hqY3dOdXMrdHJMMWQ1bE05WHBnQVF5RWMrczYyQWtk?=
 =?utf-8?B?c0l0bjN2VGVwRGd5V0xORGtSMEpPZFB5bEpCd1hqWno5TGVOSmdDbnVjbTI3?=
 =?utf-8?B?dGRGU3NyZ3NzZG1UcG1JcmVlbFZsdVBSNkRCeEhDWkVlMW1heDhPZDJ4dTdj?=
 =?utf-8?B?TUxMMTNtMCsxUjVsb1BjMkYxYXpiYXg0bWtTYU5Zc0xUYjBoaGZQOTNJK2sx?=
 =?utf-8?B?Y2hpOTVvUUVZNjd4YnIwNFFwVUFzWXltUWUxelJDdWhTMU4vQ1NBY0JrU1U5?=
 =?utf-8?B?ck1kSlVqckdyZG04OEdqU3IxdE5RYzlmM0FadzJPQ0xVNXNCZTd1SUt4L2xN?=
 =?utf-8?B?eEdEcFRmbWVBQnRRUTVHYlEvVm02QjQrejhvNTFiRHg0cnYvM0tNaml6allj?=
 =?utf-8?B?cHRPQldBblU5aHhGYmFpNVhxdUIyVjRpbkhBT0FiTE10Qk9sakZ1TWNyOWFN?=
 =?utf-8?B?YjBIREdZQjFac0tjNEgxd3JCNngrSTBmb2VzcjRvZGNmTWdod291eGEwY2No?=
 =?utf-8?B?V3dMZXZGVG1XZVdYMURUTDJBY3RFYmp3TXJFZjg4Q3hDOE9uSk8ycFpUY3ZI?=
 =?utf-8?B?ODRRVlFnbUZvWGxuVE1wdk9kRUtZcFRkc1Z5NVFSbk02b0FDejlqdWRsNFEw?=
 =?utf-8?B?SFRVcVRrM3c4UGtMZGRBcEE1bzRCYjA0NTVOYW1uaUpUVWtDR0FqNWY2K2t3?=
 =?utf-8?B?YktueFNEb0dBQjk2YWtIUWVxWUZwZmRSU2JDWGpoUFhRSy8vSDNidmZCR25w?=
 =?utf-8?B?MGVlcGtVU2FNdVZ2ZzlPYlhaTlFjYXNMVFAxZW9QRk9aMVNtWE4reWdVaFoy?=
 =?utf-8?B?cVhPSVdYb0V4aHNtYVEzMThwN0FCRExLZTlYNDFyUjZHYkZVWTByNlFkVlhr?=
 =?utf-8?B?djQxSVZKNTVnbzBWaXBTdVZZTkhBTUxKSlY5YVdRRE92ZmxwbitaczJBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VHJDSTNGcFpVTUpOYmtkKzd5Wm9IUldTSk1veW9hWm9wZFljNkxTQXNsWmdp?=
 =?utf-8?B?UGhMczBlTVQwQU0wNXZKODIwVC91YlRnOTNwSko5TDRqMjNEc1hBRWRJNWp4?=
 =?utf-8?B?OWp0dmZ2Uk5WbTIyYWx3SjJFKzY2eHRDTDdxZ3Z0bWovZldjemQzQS9uQVpW?=
 =?utf-8?B?ckw4RUZmRGpLV3drQ0FlSWtQT2lVejkvdEQvVStzeGlwT2pmSEhjWlZMd0hR?=
 =?utf-8?B?ZnA0T0pZNzRtcW9wbUsvSzhuMjlNVmVNcm1zS01rS2c2MEdZa3pnaWVPbmg5?=
 =?utf-8?B?bVRta1l6TVFvMVBUbUJJKzBMb3BYZk5wNERHNjdYR0xIMDNDckswaGU2enNr?=
 =?utf-8?B?ZmwxeE5mdmFDaTY5STlZaWMwaWxVdHhOUXZTN3lLRnNmcE5TWmhQTkhqSGdt?=
 =?utf-8?B?NkFDUTlWa3RPZC93K3lVYXRSL3FjRXozVjB5UUtUbFRTbm40WUVjVGtLVlhm?=
 =?utf-8?B?d1ZHZGhKQW13ZXVvMVlaREpVaVZ6cC9NTXc0enc1c2lpc2tIaC9XRk5nTm12?=
 =?utf-8?B?dnJ2MnBWMk9mL3N0eHNwVmt5VlVQSmZzRUNaY3VJMmdGcjd5N0Y1TWxKZDQy?=
 =?utf-8?B?WXBRWDlCeTFKTlpKaVM1UzA1aDlYeko1UWFFWXhnS3pQTUo1SEVUb3l2OVpu?=
 =?utf-8?B?UVltcTVYRHUrTUdqRG5Cc0Fielo2dkY1UlFpN3pSQUUxR00rN1Njb0NiS1lP?=
 =?utf-8?B?M3RhalZ5NlppMlFnMkg5RFJCcmtsb1dwQ2J0M3dTdCszdmplc3dFamQyYkk4?=
 =?utf-8?B?Z3BGNTJTY3RURzQ5NEoveVY1K2xUZElCZVQ1cVh3Z3grRlVHSlJrdVZoQmRw?=
 =?utf-8?B?NmRmNkhrOHp4S2tpejJEOS9FMlI3NzFiUlNBdlhMdnZFSEpyR1FMUm5sZWN5?=
 =?utf-8?B?SHg5bEg3ZnVwSUZVZndlK3RQa1dBVkwrcHhhM2luUzZGUUc3UEdOclN1eDBH?=
 =?utf-8?B?c1lWempQQ1Jzd2RlSytJcW90Y0NlZ1NRcTN5dlNlNXlPNk9KSkYrQTFDNkFv?=
 =?utf-8?B?RE12MEs1WTh2VmswZDdmWkFScTlub3dhOXMrdHVMQXppbmtRTTlBYWcrNTlP?=
 =?utf-8?B?dkhHRm9qdVZkT0JsRDM5UWl4YlRWalI1NDdxcHBNUDRnU0VxY3FYbDloaEdB?=
 =?utf-8?B?cUJPSTdaQVJrRkh5VDZDYVdPeWVPczd4TDJOTXhseTBoOWRPZGhoYW9vbWFh?=
 =?utf-8?B?SkRmMFg0d2N5Z25MWGJva3hjM1V0OTZNMTdlOEVBTzl6OFFtL2hiWldYd3Na?=
 =?utf-8?B?QmlwSmpraDdDNG8wNHV0WUkzMWVNMXBESXJqaWNmM1ZYMmhaMEYvSFUzaEdr?=
 =?utf-8?B?cEhSYmxGSDlYZEVGR1VqaXI4SjJndnBnRmJZS2ZrVTU5RE1qelFEUmcxeURK?=
 =?utf-8?B?aXRLQlQ2VGRVcDVudHBFWSs0MzJlZ1ZqNCtmVjhWZEpXZ2tDamtyNHFrdGhQ?=
 =?utf-8?B?aERvU0I1ZEp5Z3QyOTVyVGMwdDh5VWk0dTFpNGx1dFVRNlVVU3BmWWRtVDVy?=
 =?utf-8?B?RHZLMFpqaXFrOTBKWWNQM2htbnBodUpIUXNtcjIrRTFqc1BaSDRCQjZIZVhC?=
 =?utf-8?B?ZnJhWGlJMkloWnphNCtpWEhZb3ZuYUpMTXpTMXpOTUpUM3JlMkdXa0tPa2Mv?=
 =?utf-8?B?YkU3VFI1d2lHVGtYV2dxSGdWWXIwV3lreFgvQldoRlNaZTBEWVIvVXBwZDU3?=
 =?utf-8?B?SDd4VEUvWDYzYUV5aitDdHFsMm96eVBGWllBOGNTRDBadTRTdlorMlc1c0Mv?=
 =?utf-8?B?dlJJVi9OWm1CSTFmK1ltcGJqbldQOTd0ZGgwVHRSZUtOa2d6VWg3R0VsRU9H?=
 =?utf-8?B?L2Q4ZzFoNzBobmZSL0pucTRUSEpVd0xOZzcrWlJmTUJ2YW1kNVFYSWprQkta?=
 =?utf-8?B?ZVRrdlNvWm9IUE83NG1rUzZOQW55UEJnWktYS2RSby9Ka0tqdVBzN0wrRUFh?=
 =?utf-8?B?cCs1MjZoOThaZ0VDcU1jZzRnMk5SaGtHWWZ1bnJMTnZhUzUwTE1UUGRqaFBy?=
 =?utf-8?B?cUZHQnF5VjNJVmJsd3F5ZjFJY01lY0tnMkpUMERPVUZScEJ0R1phVHg2Mjl5?=
 =?utf-8?B?SUJvMGRXRE1kalVGNmg3Q3BzWFZiVlF5REZkYWJHMEpERi9VS0N3eWFTMXBQ?=
 =?utf-8?B?NGY1eHN0NEZUK1JoVEZZc3dxWFVoamJrVnZRdFRONWZKbHowQ2hzekVLcXgy?=
 =?utf-8?B?WVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020c4da7-8b38-4de4-eb7a-08dcdeec4892
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 12:02:39.1837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ki4cJqRYr9IeVtAuMR0bqSfnQmPKKFF01ZJg4jrmof0sKVT5pO5qlXfqxjChDLuBERVKidaPWfKITbC66sz6pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8731
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Sep 2024 12:02:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16926

On 18.09.24 12:24, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  doc/README.swupdate.md | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
> index 99df9ba..027a8fd 100644
> --- a/doc/README.swupdate.md
> +++ b/doc/README.swupdate.md
> @@ -23,6 +23,10 @@ device = "C:BOOT0:linux.efi->${ABROOTFS_PART_UUID_A},C:BOOT1:linux.efi->${ABROOT
>  The variables `ABROOTFS_PART_UUID_A` and `ABROOTFS_PART_UUID_B` contain partition uuids. The handler searches
>  for the matching device and SWUpdate writes the image to the selected device.
>  
> +> :exclamation: For production image the content of the variable
> +`ABROOTFS_PART_UUID_A` and `ABROOTFS_PART_UUID_B` must contain project specific
> +values.
> +
>  ## SWUpdate Efibootguard update
>  
>  :warning: **If the efibootguard binary is corrupted the system can no longer boot**

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


