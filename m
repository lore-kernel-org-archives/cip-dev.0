Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2432C282C1
	for <webhook@archiver.kernel.org>; Fri, 28 Feb 2025 15:40:29 +0000 (UTC)
Received: from AS8PR03CU001.outbound.protection.outlook.com (AS8PR03CU001.outbound.protection.outlook.com [52.101.71.21])
 by mx.groups.io with SMTP id smtpd.web11.18756.1740757225415598494
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Feb 2025 07:40:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zHVowriC;
 spf=pass (domain: siemens.com, ip: 52.101.71.21, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3P4nXjL/xAort6See3S4dsO65R4ikl/A/keFGs7e9lPf+PQfIqJGyq1q/tuZJ8G38mghkqeblOXSlYoQGUO2Da2zphf2ZX4RRJucQgbrW211K6UAlqw1MPqWhJoSObD/+/H23+sP9iEhF95W8uIfQZ1n2FLOyyTs0J+2PPXSwhu9aXt+N1xGN020UVBk5SI7pvRhqqhqywZgUFUFzmQ5s7ZPwFv2oa4ElJNNrT1nF9GTyvIcShw+tU89P6AZ8Vu1CwarHFCTJkNjQjVlo4qdLU0MBO12yemhNoL+T05Hy+wjvNaQjZuu1ko5KW/tmGzrtLzw3EJN7HSeFHLLjbhAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HA2ldzuhyCb9ihJI7ssSebbe/HwVE/ymfZHzV4Phg8Q=;
 b=FG+keaWG3sBN4UbfGIf/Qc02cjhQZnx4I0ivMmV5F3La5ZQdh8MMVpfEFAqbPEREfEU2nkCwoRUWnCOR3rKXunqLqBaFxyFihkZPCDIDFo9soPhZVuLNEwo39yvo5RcPg4GWqgx+uUY9pCu080NlZT9mvj7HC2I54aC8JFLXaYnX1cH3qBYOkhBmcjfaLh+kSRjhbvT+6U5z91lSh4fu3mGeUpwuXfQF3u9RklVcskGtkxTWD9Do+GacBpI3o91Q57p3LsVdPZ2HibkZtvgOhiw1Mmpa2kR+4esBOt2YONDwvN/OvuOMC8mYxr5v5VZcR3f4f69DEErgunE3GQtuAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HA2ldzuhyCb9ihJI7ssSebbe/HwVE/ymfZHzV4Phg8Q=;
 b=zHVowriCmnhNGjC3N13RZYcDz07kb9vf9x69F93j+wCUiZ6u2hXoKDzs6ZebMErzkB4BYQkS7KJgE4IfnA4wK2UfjhT4FmJ39q9AnzGLH6+p7r3VMZG9Up0Lz9RhpaMCOrKogYQ+DvzEE0PgY42cFMNuONbOO1c+gBK2RC4PGa5iWF+lRwcTeydZI+sbOzfMvxO/ULRN6mOotw0jHe+4Xh+hFGOaGjPFdx2IrjDuXI9NYY/wjDQ66+haPtjq1r22t9OLip+qG0D5Lg+3b7BItDndUavApLlPVCUE/GCPo/JpmyJlXIEh0swbjYER5iPamY54Cy2mJ5fZisLCVlJL1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7841.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Fri, 28 Feb
 2025 15:40:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Fri, 28 Feb 2025
 15:40:21 +0000
Message-ID: <95dd9e49-59bf-44e4-bc62-6e0195d11300@siemens.com>
Date: Fri, 28 Feb 2025 16:40:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/2] kas/opt: Add option for not install
 kernel
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 cip-dev@lists.cip-project.org
References: <1740746806-6557-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1740746806-6557-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ad4e29-1e25-4088-fcbe-08dd580e35b5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eHlhN1QrRGRyMXk0YVQwd1UvQzFDVzR1cEFWeGwwSlRWNVV2VWhva2s2OTM1?=
 =?utf-8?B?djBrOFUyWis4UUptMncrS0lxWjY0cHZaSy83Yy9MRGVWUjQ4eG0rWG1DWmFj?=
 =?utf-8?B?QUpyTGVYUzdOdU13cGxLVkZvaWtLN0xZZTNseDZMZjgvNUNrWFhqY2NkeGp2?=
 =?utf-8?B?Y0RIcFpqWHNpODhZS0FyaEpsMFR4NUtHWWp3Nld4QmJxUHVIL2xKbEtvS1ZD?=
 =?utf-8?B?ZWpZdTlIbEpTQkwzT0svYkExMVRLVlRzZXJmZUt1YUFPM0MrOVFHaUNEQVR1?=
 =?utf-8?B?N3hINUE1c3lXd0s2U09hakNjQlc1N1JpSTd1ZVpUY0FjMldUM010QjAzZGRL?=
 =?utf-8?B?UkkvTURjSWloMUZnSkg0VFphTlVUNkNPOVFTdlc2eUQwdmgzRGtqYVJ0b1FY?=
 =?utf-8?B?T09SejdGcnZ3YzZtOFQxMFZVSkVjVG9GOHVoV201K2FtdGg0UFRGQnVrWmhV?=
 =?utf-8?B?ZHVBM2VVQzFQaUdKWUFhMk5neDhuMG5PQlNJT25WKzJ6anlTNTI0VkNFL0xi?=
 =?utf-8?B?dDJVaWlxRm1vdUhLRjlTRW9lZmhRQ2RMTmFOMzRzWXZzWU5KanhiclRFcWtz?=
 =?utf-8?B?OFl3YnA1MDRmVVpqSTVhU21rWTcvVkE0VzlWQlM1TjZxMjZCMDkrWnhGck9D?=
 =?utf-8?B?bElQWjN6djhvNlYzVUNDbHZxNHFMTUlyRWlrWVJTSHVEQnBpYkdsU3YyZTl1?=
 =?utf-8?B?Q3ZNZi9TQit0aFk5a1JmakJaci9kb0ZhOGlaUzM3dlZ2NjVQQm9jOU1maVR6?=
 =?utf-8?B?a0JMYWtmUGpva0l6RG9PVjdITDd2REdBaTFVOXNhejV2ekcwTmhpazVkVS9r?=
 =?utf-8?B?dVFSbFRiMFMyZTMxU0F2cDFiM25VRE1Ya05HbzlaZm9vN3VJNXlZNDhUSkRy?=
 =?utf-8?B?bFN5aG1rWGtjVHg4L1k4ZmQzNFFFSmFCdXN6b1FLNnZIem0rK0FMODR0NFFp?=
 =?utf-8?B?d1pZUUlMRmlHRWZmdEc4T3Z6SDdzNlQ2SEU4YkNXdVVxVkZ5ZGhTMnc4cW5K?=
 =?utf-8?B?SlM2TXZjUUUwSG5KcGcrcGQ0c1hVRTJaOGwyYW1jalJUUTRCTU4vSEhrdEFL?=
 =?utf-8?B?VU9qT0YyMllZMFFoYXdXMWdUaFluWjgvbUdmdUwzSnJ2SWU0Z1d2M0ZxOWth?=
 =?utf-8?B?dEtZS2EzTnpkbUg4NG5oU3NEVm1UZDhpQ3FWS1o2N0hEQkg2SHJBaEtyTHox?=
 =?utf-8?B?Y2xORGZPZ0tEbGdORU8vUjJnV3N6d2dJS01LZ3QxZkN2NjNKaGVybXIrYTNy?=
 =?utf-8?B?VWdza3FFaUNjdkRDWkRSMS9nMzgxYVNUaCt3dVVSb2tIMXY3aytDVlk0dlhZ?=
 =?utf-8?B?ZFhhcWNEei8xUWFSRkpZNjJ2bTRPSTQ3cnFhNXAvQjhvUmhzOWgydnNZMHBh?=
 =?utf-8?B?M09jUE5hK0RHWU1jWGV2MCs5RGd0VmVpa1V4OHppMEIrNzlvSTBMWlZHVlV2?=
 =?utf-8?B?RVFnQzBjVXhsVzFQdVBqUjJZcjNnYytlcEc3MlZuK0ZuQ3AycDVPTUxsL3pN?=
 =?utf-8?B?OW9oTnJLRmlsQzFNc0JneVRoSC9hNmpZeWRNWVgxdk0vYkZNc2h2NVoxd3Rr?=
 =?utf-8?B?LzBPdjREM3BtOVp6d3RhVFZhelhtUU8zSmtMRzdEK2ZhKzh3UGx2dlQxcUor?=
 =?utf-8?B?WEt2cFNhRFl6RHpnVWJBdlBwa2NWa1ZSVmgrb054ZkExaVF4elNKUDRaSDVF?=
 =?utf-8?B?Y2Vqb1JGNVpZdUJFSCtNQnNNd3dpekNGOG1NTys4TkxJNnNjSTJYWExlQUlT?=
 =?utf-8?B?YXdSQkdMOGZVT3Q5cjFQOS9HS1BGQVl1d0N3a3ZZUGRMeWdFR3I5elFKN1pZ?=
 =?utf-8?B?NXNsWFcxUFhGVXpaOXBubE9KY3E1SUlUd0E3Q2JRcDA4ejFFT2huYXVGSmdV?=
 =?utf-8?Q?5um3iDAg8tt6H?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bC9uZG1KK0JHRjg0UGNsTCtuSkluc3VNaE8vcDVQZUw1UjdSdWNnaktlOUJQ?=
 =?utf-8?B?WDd4Y24yVmpTLzExZk1WcHI0ZlpRSGF1d2VydHlQQkZuOUlQWm5kdm84OFNV?=
 =?utf-8?B?YU1BWmkraUJLSE1GcW5GUUZsNDQ5d0pzSzRXUDg3K0ZqZkZucEJRSE9rL2FB?=
 =?utf-8?B?THdZMXl0eUxaOG83T1RMZGRQSmhQUXZkOFo5bU53RUZXNS8yQUJNWTV0UjM4?=
 =?utf-8?B?RmVnTkd6WFYrL1NOTTF1UElhQk5OQVRXTkhMNUZkNmFjcjNQSm1aWURZSGNI?=
 =?utf-8?B?M2R3NE9MUllOdXNTRWRJQmtlT0dSQk1nczVmbHQ3a2Nld0VrMHpQYmhIb1JO?=
 =?utf-8?B?OXhCcjQwR0V1WXlpbDMwY2pMSVFiMExydnBnZ1ZFU3VsNnF0RTMrRmJDQUZa?=
 =?utf-8?B?WFdLcENMcGVRdm1PVjdrRkpwWjhjRmlmeFFZOWVzRk5NdXBIcWgrREhocDV2?=
 =?utf-8?B?em9DOTMyL0h0bzlTNGU1MG5udWxzZVdpSW1uWVAvajUrd21idVU0R20vV0t0?=
 =?utf-8?B?TXhUZVQxMFl5U1hyVkZsVG02WmtpQlp6cnhBNWg5QWYvcGs1VTNUZHJWVFlp?=
 =?utf-8?B?K3pmaVpGbzBGa2pxL3M1TXZuN292NXNEMnoxdWVqSEExL3hyV3QwbGx4V1VH?=
 =?utf-8?B?R1hDazR2OG9ROW5ZRnZ0ZjhJcXpZMEtWRjVmbkVJeG5lejRaOWJYdHhPWkJN?=
 =?utf-8?B?NEdCbzU5N0ErYlZSY2psK0gxOVNORDZhK2JLVDlrYVllQ1BXZDJCMUh0Rm91?=
 =?utf-8?B?NXdYT24rR0xDWkZqYXVnZStyVW4wQjBIMGVjWHk2bGVkMFBWWURseEJoQnpC?=
 =?utf-8?B?OVZLT200bGxPQUI3RXBtVmJyOGFKNGd0eGlFU0FkZnFLaFpDQWh2V1lpMEQr?=
 =?utf-8?B?VnJzclA2UGZoUHJGQUdpdDhVOElyUS9NVHJaYk1kaHFhazE4aXFiOHN2VGVv?=
 =?utf-8?B?b0JzdURDQnV1a0drbkFocXRIcHkxV0pvWDRheTRoc01HaWlBa1VkbFQycEdy?=
 =?utf-8?B?MHlyUWFCK3JZa0VUTlRDR2FybUhxSVFWaCtUWnNkZGpnMVRvN0V3ZU90SmZW?=
 =?utf-8?B?V0NoVFgvQ2E5WVhHa1M2VkphMTM5RzdTeWZWKzAwaGRzNjdXMWV4MFhzMU4y?=
 =?utf-8?B?MTkremYyZlFrenoydFRGb3lWWmh1MVFEalB1dDN0TExQaXZDRGNoRmhjMHQ4?=
 =?utf-8?B?T0pmT1Zva2tJSnpxN3g5bHAwQ1o2MTRFUTZwdnZUeHRiM1I5Y0pZSnFIVnNk?=
 =?utf-8?B?dFlLWHBGdVVHem0zS1Z1T1BTeHVrdVRmWGVFZmZDa2FFa2cwK0Q1NmZSY1Qz?=
 =?utf-8?B?UE5MRXpOMGwxdVBGRHFIOTNDSHZ2Q1JheDFidmJKTzlEd3kzeFhGZHQ3TnRE?=
 =?utf-8?B?akhPWktFUE9oWlkxWFFGU0k5QnhBODNkVmxzSzFpcVBSUFp2bkptUUh3bWNB?=
 =?utf-8?B?NlR0bVRzTXJIV0NzNlh6MjhwbmtkR0pOZzMyQWIyYVpjMnlCVHNVRVZzOWJm?=
 =?utf-8?B?WnRkYi9sRC9VWDJaM0pKcHJ6c3ZzZ2pJY2w5dnJqVG9VS3BOQVZZRTZhWGFS?=
 =?utf-8?B?ZVRBZEhNWkxOTDd4c0FPTW9OVkdNVCtFTlVSa1hEUmVOSTQ0Q3E5QUhlUHM0?=
 =?utf-8?B?K1M4WWJTT2RNMVh0VGQwVXJLRjE1M1I3aXdqN2hib01LUVlaMEdjaDZ6Rk50?=
 =?utf-8?B?UmR4SXhjRjV2RFNVbGozdGRGUENQUHNUbUVJQjJ3aVU4WHBQeGY2WXNjRERr?=
 =?utf-8?B?b1gvYmNZdXVSNHNzU3lmQkQ1MHZhVkxIVGRjVnVOWlFES0hGeVJWWnpoZDhy?=
 =?utf-8?B?dCtKaFBxcm9QVm0xTkNOb3A4b1daazkyd1BKNnhrbktTelp6clhUbWltSHZm?=
 =?utf-8?B?N3NUVzBuMTBaQTcwZkF3NU15Z3VuV2xaOHpBYTk3Q29RQXVuT2VkVktYR2xx?=
 =?utf-8?B?Y1RncTIrNWRveHF0TUFIM3FMRWJ5NGZrZitZVU1SN1JnMjJEK0JWMFlpQ2tK?=
 =?utf-8?B?WURxTjJzYzkxWnlTN0lHZ3ZPdSs2MXIwZTdLWktoZHE0UGVBUmpqUGZpSERu?=
 =?utf-8?B?TzliekJCcEE3U09Zei91TU1ESGRCcHJ4NzJxR2VGY0MyRTkxUEIrTmVBM0Vv?=
 =?utf-8?B?ZjJuTFBTbzJTWDBnMkY0ek1hTDVpUjBzWnB4UXBzLzl1UzdUMTNCMm5JS1E3?=
 =?utf-8?B?ZlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ad4e29-1e25-4088-fcbe-08dd580e35b5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:40:21.2706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIont6Ew34Hjq7FrWdXlnuE8N8p3pNPOWlNXLsBvwg4aaPldWkdJSjZeUO+3PvXkBg91co2jz+lHk+Rn5k10rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7841
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Feb 2025 15:40:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17989

On 28.02.25 13:46, Nobuhiro Iwamatsu wrote:
> This adds an option to create an image that does not contain the kernel.
> 

What is the use case? How does this relate to kas/opt/kernelci.yml?

> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  .gitlab-ci.yml             | 28 ++++++++++++++++++++++-
>  kas/opt/no_kernel.yml      | 17 ++++++++++++++
>  scripts/deploy-cip-core.sh | 47 +++++++++++++++++++++++++++-----------
>  3 files changed, 78 insertions(+), 14 deletions(-)
>  create mode 100644 kas/opt/no_kernel.yml
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 4df521b..a09eedd 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -27,6 +27,7 @@ variables:
>    build_swu_v2: disable
>    swupdate_version: default
>    test_function: swupdate
> +  no_kernel: disable
>  
>  stages:
>    - build
> @@ -67,9 +68,10 @@ default:
>      - if [ "${watchdog}" = "disable" ]; then base_yaml="${base_yaml}:kas/opt/disable-watchdog.yml"; fi
>      - if [ "${security_test}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/security_test.yml"; fi
>      - if [ "${swupdate_version}" = "2022.12" ]; then base_yaml="${base_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
> +    - if [ "${no_kernel}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/no_kernel.yml"; fi
>      - echo "Building ${base_yaml}"
>      - kas build ${base_yaml}
> -    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} wic; fi
> +    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} wic; fi
>      - if [ "${build_swu_v2}" = "enable" ]; then
>            mkdir build/previous-image;
>            if [ "${extension}" = "security" ] || [ "${extension}" = "ebg-secure-boot-snakeoil" ]; then
> @@ -221,6 +223,30 @@ build:qemu-arm-test:
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

Do we always need to build and deploy those extra images?

>  build:x86-uefi-secure-boot:
>    extends:
>      - .build_base
> diff --git a/kas/opt/no_kernel.yml b/kas/opt/no_kernel.yml
> new file mode 100644
> index 0000000..2338177
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
> +    IMAGE_INSTALL:remove = "linux-image-cip linux-image-cip-rt"

KERNEL_NAME = "", that will also disable the now pointless build of the
kernel.

> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
> index 6e4dfd7..6cb4968 100755
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
> @@ -48,17 +66,20 @@ else
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
> +	if [ "$NO_KERNEL" = "false" ]; then
> +		KERNEL_IMAGE="$BASE_PATH-vmlinu[xz]"
> +		# iwg20m workaround
> +		if [ -f "build/tmp/deploy/images/$TARGET/zImage" ]; then
> +			KERNEL_IMAGE=build/tmp/deploy/images/$TARGET/zImage
> +		fi
>  
> -	if [ "$DTB" != "none" ]; then
> -		aws s3 cp --no-progress --acl public-read build/tmp/deploy/images/*/"$DTB" "${S3_TARGET}"
> +		# shellcheck disable=SC2086
> +		aws s3 cp --no-progress --acl public-read $KERNEL_IMAGE "${S3_TARGET}"
> +		aws s3 cp --no-progress --acl public-read "${BASE_PATH}-initrd.img" "${S3_TARGET}"
> +
> +		if [ "$DTB" != "none" ]; then
> +			aws s3 cp --no-progress --acl public-read build/tmp/deploy/images/*/"$DTB" "${S3_TARGET}"
> +		fi
>  	fi
>  fi
>  

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

