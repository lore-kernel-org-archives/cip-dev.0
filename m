Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D4BC3ABC0
	for <webhook@archiver.kernel.org>; Thu,  8 May 2025 12:53:23 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.62])
 by mx.groups.io with SMTP id smtpd.web10.14607.1746708795495202369
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 May 2025 05:53:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ITh8MMad;
 spf=pass (domain: siemens.com, ip: 40.107.249.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSJmDdcJxo24aAHw69nYgNvbpZ5Xn4XG0H5s5yK9BkogyfgyYfZbQCJ/dNnkQJF40XkyLTVibzoq3/sZL56c4IMF/FFMLfBoH0Un4oJBEhgKGnYFyBp/1armmIz1Q6m7qxWAWEh8ZQhsqfiq1cWZJpy550vyvQQpWIjO55/QvOjDpuKo8HGBxk8N2tlaPHWFIChtX4Z9UTqv7nI+N8Z3gD4YWl5/bNPZaAVGl9QP4yUbAmT48myzjGHeX5fZXIfHGaXPob06Qt3lg4p8caH1pzWAR8PCmHTh8a2QHqkBRt06lKHqlaYIlSPnaJm6jnybOqQHLb6TjI2L8Pm4DmYbyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpAAMn3+VEqkvFRlnZl4805hF3RN7eI3UKEmKoqt3IE=;
 b=vAMXdFupMPjMUlIA8Hz+kxXnaaiM1EjXk0IglRPvwJqjV77KEhI6+LQKgYKhBFnuWor3cvQ4sxcuNodV9TxD++NjN4Ey/frrKTeaRLPb9wcJWlgLGJa/UfsUKXXuYT7TwzMlBxCA0ig8pFCV6YJ7pgn2CuX9CqP5Xt6hF/lHqP2n6yJG0GAqcq/SOBWsGZY0IznnBkUWmkKr6+iM0y+kRHREZhoeuly6MQkHRnlGGZV+HnCrkbxjfG1B0Ofrs0k43fvjyautzlzZeTlE7/JiQWxegEZ6ePa79GzrlyhImby+dGa9Mm6sg5JRQJRmawlecGT5XWn6MK2Vl0FN5N0OLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpAAMn3+VEqkvFRlnZl4805hF3RN7eI3UKEmKoqt3IE=;
 b=ITh8MMadrTw803RUvATsypDU5VD0VasESPnTgrGJ+9TfostEODl2oHF7ErQsvnr4E8X0YaaG3xNxQQmCn/aILzDikmBJ420bbxnQyo3UyGSU1rwags3mpqGrTkZJPRyuXgY2G043RfuRzYomSj1cz1vYbqadyi/UoMdxl4zzP/yelzySyRf2YtKNMQCJ3UheTG1MDPTNErCjq0XtuCXf8Wa2ZYkOY4TZSeUyvYrvimltpqY+gVrjFm1+iwiWIwZzCQ5C2U9gUKBjoALtW1BSrEnxyDi5t2oLhSDxvtUc1VKyzyC058huxfONHlKBjoVReXof9YuVPVoXJemxoIvLWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7574.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:545::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 12:53:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8699.026; Thu, 8 May 2025
 12:53:12 +0000
Message-ID: <fbd38d82-8a05-4fd0-afd0-e67847731f87@siemens.com>
Date: Thu, 8 May 2025 14:53:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC v2 3/6] encrypt-data.yml: Add
 factory-reset information to encrypt-data
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250506120807.255675-1-Quirin.Gylstorff@siemens.com>
 <20250506120807.255675-4-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250506120807.255675-4-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0210.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: c40dff1a-2662-4707-8589-08dd8e2f4ae9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WUQ0T3A2cHFTeXFTR0pDT1p6bDNUUktWeFQ1L1cyQStXeUZ3b2dybWFNcmVO?=
 =?utf-8?B?VTNoY0orUmpzNTJrRWFVSUR6Y2pMU2pXL3JzNnlKTnl6cjNSTkhkakFPamdX?=
 =?utf-8?B?bkVuUld4Qll4WTdWYU1MRDFWZ1kwS3dpdXVlYU9meWsvbWhsSHJ5dDh6RHho?=
 =?utf-8?B?cTRFNkxSNlBIekFYTnRNa0lRb3BTeFNyYUVHdld0cnltVU1IS3Y5aE5IT1hv?=
 =?utf-8?B?UEhHalIvTWE1ZDhYMC9jeXRXcTh0U2tqSGMzMFN2VU5STDNOeExtaU44WUVo?=
 =?utf-8?B?TzJtSHN4a293ejdNWHFrOUZjVlRER016Z3JqV3ZrT2ZaakRSNU5KaWxTVHBp?=
 =?utf-8?B?TDkvOUl1ZEYzWDRxN1Z3ckVwSlYyVktyL2Q2emQwNXFNLzNKK01SMjhISTVY?=
 =?utf-8?B?MUo1aUdBdXpIa0NKdWYzSlJWUTZ6ZWN5cFZlSFk2OE5NYWJGUU9QTTVJR3dj?=
 =?utf-8?B?ZTR3b1JFWW1xWXMvZmVYVXlJSVVLZjg5R1VJZVJsdDJKK2h3TFVTNXdXTnFB?=
 =?utf-8?B?a1RRTTM2M0RGeHRWeHM0YkUyaEFiZWh3QlcyU1dub2pwUitCZGMyTFlTaFJV?=
 =?utf-8?B?WGFlSFdxQlRxUWszZDlhVG9ML0NpWnBwTlBFc3QrS0RQQWhiYVVvaFp6UU9P?=
 =?utf-8?B?YXBoZDVwM3hPQnNhTHg4QTlONTJybm0rcHY4N3luelhsdmtObjlOZnNpbmtq?=
 =?utf-8?B?NjlqVTdtQnlTTUxmSUtXcUh2bUt4bE5LZ1kzSWJhTnVNOEZLcng3MHg3VFpn?=
 =?utf-8?B?akt4WVF6bDlFR3NNUGhSdERxcUFjajhZZittc3JaWmU4a2RSVStUSEVMWTVS?=
 =?utf-8?B?KzBMQzlVUzVMcHBKL0krOGFneHovSzlVYnYzYUhmYjVJcEhvSkJ3Q1hlRXFT?=
 =?utf-8?B?Um41RjE2dlZvVCtocnc1d2g5VHZ2SVZNdldRYnN1SVA4KzdjOVF5SDhPWXFM?=
 =?utf-8?B?bTRQNDN0bXUyU2ZHVHVwTmh2WUN4TWtiZ0V4bHgwcC8zZUtQa3hSMDlmQzhB?=
 =?utf-8?B?ZWZIUCtNRWNZL1JkcDFDbS8yQ1NmZUFBQlpXUERjdGIyNlh1MXJTMzdQV2RB?=
 =?utf-8?B?U1NpR0pCc01zR01ObHpvL0R5SS9Zc0FUL2VxUGZjdWNWa3hIZGRLWHJIK3Yw?=
 =?utf-8?B?NG13cFgzYWdMenZqellIb3lZQ0dhUFp3NFhYS2JHVytpV3pZeTc3Wkk1Mk9S?=
 =?utf-8?B?SHNuUHh4blVZQllocXBYbE4wb3FJeVF3dlRvYnRUS0dISDhRekttbkxQZ0Fk?=
 =?utf-8?B?dFF3dmh1S1IzK0FPdFhYSzZRempBR0VEMXBkeUZ1N1dYYUxEVXJ3RS9QWmV0?=
 =?utf-8?B?cU9aSEJyZDU0SFVFSjNPSjNmdG1WNkhFVEh5by9JNHN1SWEwSUk3U1RySnhO?=
 =?utf-8?B?RG5ZSURDS3hkVXEwR2IwblpmZUFSaFhId1NObGhRdjd4RHVKbkhDVERGZkZI?=
 =?utf-8?B?K2wxOXE1aWZ6WGM4WEFIWUtVcWJtYXBLYlY1eW9iWXp4L25YdmFldElDSy9w?=
 =?utf-8?B?UVZDYzZGNjgzUEtROFFGR1VMQXZ1MUxNMHhQMXBaY016OUtWL3FsYWdVZk5u?=
 =?utf-8?B?NDdIckRUTTZvUXBiN1BiRG1BVHNqeWFUSFdMWnRyRVpaOXNjdTVTTVoxdVFk?=
 =?utf-8?B?RERxV3NKSUl4cGg0Y0FwSDRvUko0OU1acFdZVWN5a2FxR0FtTFJlRjdXYVFl?=
 =?utf-8?B?ZzFTY0hEcWxyY0F4aUJEOTJPd2lQWDF6bS8wVFNITGtCSWk2SXZBckNiVDBv?=
 =?utf-8?B?LzRtNmN2VkRrK1pYcGxqSVVZL3RvUndYVUxLY2l6T0hwRWlUaDBkbWF6SDZy?=
 =?utf-8?B?SGRrRzBDalNsOS9OaElZYkVZR284N2NkbWswM1Y1TC91N1BOaXNaV1ZBSFBw?=
 =?utf-8?B?RVl2bVhMeWx1dnNQellBL215a3ZiYjU0NWU5ZUNTNjB1ZlQyUjkvZVBxb3ZE?=
 =?utf-8?Q?RWCzQ47sX5c=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RGllbzJJWXZCSVRxL2VHdTRLeTJWUmpuVzJmd1hYSWtndXlRSi9TZ3FvTURw?=
 =?utf-8?B?cHR3ZUFYeWhLVzM3cUVPMHdwYVZ4WE4wMkpDZWk5RmNuSiszazBISURlaFBO?=
 =?utf-8?B?QmdMVDJNYmk0Z1R5QWNDOStQeTNMWVh5bTdUZjdYM0J6RDM3Tzdha0pzdVJq?=
 =?utf-8?B?R2hlREkrQ2d3S0txaHh3VVNzY1RGVDNtSVMzbjk0dENJNFFqUGJtTkZaVjJ5?=
 =?utf-8?B?NDBEZS8rY0VlZFpWdmlvOUYxb2FSVGE5Q3l3b2YrcVc4ZnNVeWxVSmJiVTRp?=
 =?utf-8?B?YnZlRXd5WFlPTUM1aWVhVEgySnJGbUVUL0I2c2c1UldML2ZkUmMwZTl4RXJr?=
 =?utf-8?B?cC9NWGgzdUZsSFlYcnhpMjdYZVkzMEppazJKU0RSK2ZnSUxVWm5HOUorQWl0?=
 =?utf-8?B?Uzh0VGI4R0svcy9lM2xWWFdhTisxMjhPN3BqMS9IcmdWL0xaQXMyM0VGa1dL?=
 =?utf-8?B?WkxRekRwdks4SHJSTnV4WkhRblBIblUycEl4Z1loalN5Q0w3OW92S293UDh2?=
 =?utf-8?B?UkhVUGcvRzVFdnNFMGxyU3o5V085SWpwdXZIMlY0NHQxNGNwbEtFNkJ5TUFM?=
 =?utf-8?B?ZUpaTUdlQk9qU0lkSGJuTXdOcTUvWldYRlhudkFxUVVVMWlMbG9OSnZLdnJC?=
 =?utf-8?B?ZDN5QytmYWpiZnA4WGZFS0hsVFF3TGN5ZExNUTRDS2ltbzFaaTVlOTZONjRz?=
 =?utf-8?B?Y1duaWhRY2tzZ1kydmZ5NnFMUFBwb3NKeFRoL3JoOG93SGdZOG5BU09QUGhT?=
 =?utf-8?B?eWhtZk11UjNuS2wxZTJ1RG4yUU1mN0tGaUZDMmQzanZTNWlIZUVsNGIxeXNJ?=
 =?utf-8?B?NHdvWEVFSG9Pa1pqUHJhWTd4UnZzbm9rLzJ6anB2T050NUcvVmZkUlI1ZGxN?=
 =?utf-8?B?c0JEdHFweHVDSWRBWFFOR1ppeEkvYmViMGEzeUJEMU5ZRHFadDFKc0h6aWZk?=
 =?utf-8?B?dlM5dHBTRmkxdkUxeGQ4cC9wQVRXT0p2NWRKNGM5YWpLbnJ3SHNuc2JrVGZM?=
 =?utf-8?B?ZkU2Q1k2SFJwamdoNHBzK1lvaktDS3NFVGhPUzdSTEhDOStMM2FUNFBNZGFC?=
 =?utf-8?B?bEJRME5mWEZVWUFINWhUWGxZeFM2bTNEYVBJcEhKbGFVRGFCbXlLUkc3blB5?=
 =?utf-8?B?RE1KZEsxU3I1MmRzTUg0aXgyaWRDd28rZ3VkTC9VUUM5RTFTVHF4amYreVNv?=
 =?utf-8?B?S1N1REJMZ281RGRzUFZuTU4zMDFaY3ZEOEwxaHFESjc4Nm5DQm5XNVI5UVFF?=
 =?utf-8?B?OEJRUGd3aFlwVGRSRFFPUWtFcHk5RjdNcFE5MHQvSkE4QldRU2NWYWZTem1T?=
 =?utf-8?B?MXoyN1RWamlKUTkybWVOVlg5QXBNdzMvd3p5V1BORWhMS3dTMUFIM2VHVHNn?=
 =?utf-8?B?eExVbWUyN3VZcWVPOXBLUTJqcXBtZ2FtQUdxeWpjMTNvZUNrMWpUTGNVdXFY?=
 =?utf-8?B?ZkZJNWZkMkpOcFlQVWVEL0VDSU0yNmpPRUVHa0VVMHFxSEJETEdDeFF1WnVV?=
 =?utf-8?B?WDRlcTdCdDJqcFNLN0REa1lZdFo5elJpU1FNS2JrS2NRY09BQnhWTldGVmhn?=
 =?utf-8?B?MFRBNVJFamtnYjhLVjVqL2s4bi9DV3Jlc3htZHRBMEcvd1ovYkhlbUtHNlVH?=
 =?utf-8?B?VEN3SEtDQ1Z2MVZNMHVJNEQ3Wk8zM0EzeVNzWkxXZm1WQ1lYcEhscGJFbVZk?=
 =?utf-8?B?VXh6QmVWSURuS0thT1lQdnBzeW1XcHc3M2c0blhMTGY5cG5tNlIvck9mS0hi?=
 =?utf-8?B?RkZYZjhSS0VHaVZ1WEFnbnBlcjVkbVQycTh2VVQzTjZvcU9pYm5LRFZWMHc3?=
 =?utf-8?B?dk5iSlVmUEQvYzZwRWluTDdLdGovQ2k5cGV1SmgrKyticVNhVTNKWmdUekpN?=
 =?utf-8?B?Uk1paXpsZnQrYkZRTkRaSDE3MW1wNzIzQUZ6Qm9taGJsZ3M3S1J3VkRSOTlS?=
 =?utf-8?B?TUhXaWdybE5ldUZFczhaUWxSb2ZpbE9JVjBQREtLeExoVUF2UUJ5RG5lSjJk?=
 =?utf-8?B?T1VkeG1Ic1dxSnZYaFdTZloyMklEUmo3OW50YnhmNjZsZzBJT2Y2amI3dGdq?=
 =?utf-8?B?TE43TjN6V1NmVnEyVTVQRjV4Y1liQkdLVTBFVzZlOVlaeWNwWTBUM2ZLYUY5?=
 =?utf-8?B?b3lXbTYzcTZ3UnV1djhaT0JjeGk1RE9lNHIzc0lEaHp2YTY3aHk0NlhEa29p?=
 =?utf-8?B?TFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40dff1a-2662-4707-8589-08dd8e2f4ae9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 12:53:12.9344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7HNjgk1XeFlBeNufckKf7cnULQUCo/OypATcB+hLXfoAuGkAu0X+ErzDt8N1jXJ9wOORaNMjW+rAWHqfy+skIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7574
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 May 2025 12:53:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18783

On 06.05.25 14:07, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  kas/opt/encrypt-data.yml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kas/opt/encrypt-data.yml b/kas/opt/encrypt-data.yml
> index 3de76ab..4292d4c 100644
> --- a/kas/opt/encrypt-data.yml
> +++ b/kas/opt/encrypt-data.yml
> @@ -15,3 +15,6 @@ header:
>  local_conf_header:
>    initramfs-option-encrypt-partitions: |
>      OVERRIDES .= ":encrypt-partitions"
> +  initramfs-factory-reset: |
> +    INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE = "/dev/disk/by-partlabel/BOOT0"
> +

Hmm, can't we probe for a reset script on all overlay devices? Then this
would be one variable less to maintain.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

