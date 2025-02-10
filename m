Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C39EC02198
	for <webhook@archiver.kernel.org>; Mon, 10 Feb 2025 06:59:06 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.71])
 by mx.groups.io with SMTP id smtpd.web11.45245.1739170744623424572
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Feb 2025 22:59:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TNaStCXM;
 spf=pass (domain: siemens.com, ip: 40.107.249.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQLIUXXAXkQcJ9tskQzDPWgepHyVV2kjCyOUbolp9W55ENZQfPv+paeNRu9PP9q7C8Zn2mFxk0KWteJVvdRMMplD/SOtYHzG2TH2Me7SCNrTQ/m0T9FKN+M5wnQefvJb0D/0dMpHsXtKe2ukGKc87Jr9T1FhfBn6CGWIFUlNWnp1v6jQmcS2NoWEnnlc4MhAoJqbJ6+HTC9TY+1vxhVaM6dgnJb6sLpU03NqROLvYHyJ0Y7gg0P0sVwMgtFKYl2Z1ArHhLmkdE6cp5k7DyufL4/TTbAYZEL43cHZesmaLVaK2623I4q/QwrIPZWmjAcUCdr0aZnbz2SFIahne3QBfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Y+pS9FRwjSDW/2A7soBG5WBraoHJ8AdBguZcCSgXGg=;
 b=xYLIbmTgpLzvdMiOYdg2YXgxqWrMszISNNEgnxn3YVHZ2RcQelq/5TnxxFA63NQifz99IRhp53PTRKyb5Wst+EUPM0UK9t0J5AfFjSW/rivU6jEUKmypsjrqe8zXPwMCGQKgqgnyPpBTBIv1FZr5O1XRUxFC1n94IJxPFC4mWMQPbo8ntEFgEaxL6s87IwGqLdjuV/KhtY8Y1+O+iaPCjYDbPc/3M6NY8o5LRIx4/da30InTnEyPIFVVf0cKQzb0NRFmuqVoXg7t7ao064Z1Hjj83TWqdNiHViv+XQUk8oogciUlo0iZcYAOuGEe4lf6mxthq3T/xBd/fEM8tWMN6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Y+pS9FRwjSDW/2A7soBG5WBraoHJ8AdBguZcCSgXGg=;
 b=TNaStCXMWRkPG00E5JcCzF62cBMrcpRWaPo6B4QsAlfTCI2kNOOoH3B87H4rXflLBUdF7BgxqZJi+h52NFjKYvLn9cH84hgQ3bepZZFYR5UcGFdbXG+PatWlh74uA76o8uZ8aEP08yoTXlxW1B0774oHc1pnBy2LhqTXJZg/EfjOuN3V6qd5y92bjEhXV/NBzala3WvXFKzhJeXOyeepLr5L0QcEzcf2bdlgnzX/2qJES/fgLBSKNcba6rLDUlyJNfL6xuybWPyO92LOXwVZ4tyM/7thasm1vryey56Dhmzx64qEE1yp+IvxU6nE7YlQUM1hMsDcRHVjoCaAgb1jjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7033.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.10; Mon, 10 Feb
 2025 06:59:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8445.008; Mon, 10 Feb 2025
 06:59:01 +0000
Message-ID: <866f2f1b-0180-4a9b-beac-c89a205313f8@siemens.com>
Date: Mon, 10 Feb 2025 07:59:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v1 4/5] .gitlab-ci.yml: Enable building v2
 x86-uefi target to deploy its swupdate artifact
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250207150439.392479-1-Sai.Sathujoda@toshiba-tsip.com>
 <20250207150439.392479-5-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250207150439.392479-5-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eed4d3d-3c72-42bf-9fe6-08dd49a06645
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?d3J6RE45NmN4bnlLbWJoTlh2OURQRUs2UEtWM1ppUjN4blNBSzA0TEhxZ2VK?=
 =?utf-8?B?dVFUUDhYK0crU01aaUJhRWU0VklzS2M1YlNjVHMraFVPaDZPb2RXdW10MUl1?=
 =?utf-8?B?bkY4REM5eEpJbm8xL1BoaEtaRGE2a2hKOGtYUnNkRjAxU0tIamlKekFDQVRk?=
 =?utf-8?B?Z1FIQVdlVFhQZHlFcC9vakxMcmdFRnE4eVdBLzNnbEJoNWUrZUdiTkxDTnhT?=
 =?utf-8?B?YlJnSDY0UVRVbkJacDZJWGc1STV6QjlGYk5wTURUUWlnQXRzRVFndGh1VVZW?=
 =?utf-8?B?K01nQmpZWHZzUFhQSllURzdJekJOQlp3TVhxRzR2UmtiRHBkVGpTaDg4RHlH?=
 =?utf-8?B?UzRlanhHUzJhK3hPallNREgySUY0Z213RXFCcS90VjluSngvWGxXTVhPSUs1?=
 =?utf-8?B?SXVEanF2b1Rvdk9UUWVHcElKdzZlWHpCb21YQVhMcFYrNk0rTWxYaW92RzlM?=
 =?utf-8?B?UlZpWVJyVzRnL01WaDJ5K1VTT2U1SU04VFFBVUZNKy9rNXVRVHZxWFVHaWtK?=
 =?utf-8?B?cGl0bndYYlFIYmxpQ2tqK3FhOXlCU0NxUjJoVkdJUUtOeG5oMlB3QUEzZDd4?=
 =?utf-8?B?cGhtR0lLa3dVWC9MUjlJdk9RckFuMkZQWm01eHJPc1dkcnlaS3NUWGdSUDdT?=
 =?utf-8?B?TC9ZUWpJcDI2aU5sSkhNRCs2Nm9ONGl0bU9PVURkZWVHQkhvSnFka3lxOUFQ?=
 =?utf-8?B?SDBqbVNGblZBTHdYUVA0bThrQ0JiTXMxZWQxcHd4MkFSR1dBWEZybW5NRjFD?=
 =?utf-8?B?eThwUVRlY3dZMmdsbWk3RnVDWGJTd1ZJQVlxRlFMNDZzUVdOV29rQzRKTUVR?=
 =?utf-8?B?emswMEt2dzdCanVoNzhBQjFqK2ZDUkpsb2t3dGgycUMzZHgvYTY1S2Jtd01t?=
 =?utf-8?B?VTlTSkJpUTAzaEVFUUhoV21Cd1ZseVEzWTFUcTcwQmFocHlPN1JYZmVtSGZ5?=
 =?utf-8?B?NS9ETUZjSGhuN01Nd1NQcUt2UkVHYVNUbEd4YTQ5RjBqVVhnWDlBY1ZZdncw?=
 =?utf-8?B?RzYxeitJQ1dNUnBSUExIdGo1VlBIOVVySFg5RDRmMU0xZVpYN0tpYzRrQjll?=
 =?utf-8?B?amVOK2JaK0JlcG94d2h6NVJEOEMrMTJLWVZjQUNhWGx4VHpGNWpKeGUzemVS?=
 =?utf-8?B?ZHY0ZXUzVzM1UTQ5RmM1VkRWWlIya1l3WDZmYjFmNlpxWXZWZnREMm15UDNi?=
 =?utf-8?B?SHdKd3ozRGJOUUVnTGdGdTQyVnBETDBIdjVKQlNrcjVwU1ZTYklrSUJHR0pu?=
 =?utf-8?B?eWwzWDBRYWJOL0FCcW9uUG5qY0tiRW5hekcxMTc1d0prUk9XS1c3Q2RyZlRJ?=
 =?utf-8?B?ZXZPRDNwRTdvd3M4d2Y2eXZ4aDJvSlI2WXlQVlN2QTA2WktGNEc0Z1MwekVE?=
 =?utf-8?B?UDVRUFFlbkxQTHpiK1NONEtQeStzU1lPSDJqSEF6U01pVlFpSnZkNFpnUE9Q?=
 =?utf-8?B?c2ROUGE5Z295N1JrZkZQSENiTlRSY1R5eG4yOUJLVmp2bUNMcFlCYXJiL0Zj?=
 =?utf-8?B?UXZLV0c5bTRkcFQ3Y2VaR2tTeHFWTUR0WDdyWHVuaEJqbjVvSFRKbXFIUFBy?=
 =?utf-8?B?bzRiWlV4RDhuekdoZnlKTFJhelVZTmRWOVpESnFZOWY2cFFWQVNhUVQzQTZ0?=
 =?utf-8?B?ckRsaHkyQVMvbmVDUHBTK0tZWmFMSWd4NGw4aCtScUl5QkFRN01yb1ptTU5X?=
 =?utf-8?B?WllaaVhoN2tYc281V0MzQ284bHIraE1hdW5DczFvS0FYS3lSYlhTWjc3RVpG?=
 =?utf-8?B?Q1NGNFBLbGlqdzk4SjBsMngrcUNSSjJQZWt4TjFINS9LUWl1aDZ1Tzg0bDRs?=
 =?utf-8?B?dGtqaCtoNlpoYUl2U2RFQndRaGpObHUwQkwyekhldjQ2U3Z1UjhnVDdnL20v?=
 =?utf-8?Q?E8YBGzCLp9OG0?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SFJDU1Q5cmZqd2d3em5EbFVKSld6VXc3WWd4UmN1RlQrdllTWlcrRmE2WEJF?=
 =?utf-8?B?MVg1TXQ4K2VjRisvRkZzQXRQUy9qUWVSbzViR2ZGQm42WXU0TDFnd3lQNEdz?=
 =?utf-8?B?K1h6SEJzajM2ZTIvMlVvQzlOSk5JdmNCVG4rNGcvNGdRTVhaT2Vtak5NVDhK?=
 =?utf-8?B?KzRGQTFuWVd2RnQ4bkhqcEVGM3Y4MzFmbXlYdVJLWHd5VlNwUHJURkEwQ09J?=
 =?utf-8?B?ZnFrZElRNDh6QXZ0RjBQa3dNS3Nybm1adUk1VVVwTlRCaTd2SXFzbVRNbFdj?=
 =?utf-8?B?aEVlRlJhQ3p3NDFnbWR1ci9URXB1aGtvRG55M1MrOFhScDgybmFiUmNFYXRZ?=
 =?utf-8?B?Vk01VW02MDhzQ0xFZmt6TUwyQWxqeGZvbVVOc0hOTG1LbUN5NXZ6M3FkRjZm?=
 =?utf-8?B?TXM5eWV0ZHk1NFFFQktqaTc2Sys3aUMvNjBjeW9STGFINFlGUng1Wml0QUtz?=
 =?utf-8?B?Y2pWejJMdGFIcGduZk5WOU1OWjNGa1oyR0dETytMeVZjdVlXanJ2MG1vekNK?=
 =?utf-8?B?YnZWYkJ6VzRFYnRBSlZPVTRxaWlENXZzU2xFL1ZFQVJnR1dlOWVpanhKV3Er?=
 =?utf-8?B?Q1h4eWU1a3pXaGFyRGdjdjJhdk1DK1Bic3prM1MvZEF1eXdJSW1LMlA0cjYz?=
 =?utf-8?B?dzg4QURxMVB5U0tDZW5Kb1BrWFhUUzYwTk95aENmbkhkTWNYcTVEc2lRRHVl?=
 =?utf-8?B?WlN2SkxRS1BXVzNzT1hCSzUvK1dna0pDZGhtY0FZdllGQkxmaFo0WTJkOTVG?=
 =?utf-8?B?RVRzRlEvNjM5WFF2bUxXYjBrcDE3b0ZVYjBVYnFRWmlOdE8rdmlNRmFlbkNo?=
 =?utf-8?B?SGp2UldtTWlOVVZXaG5kZjFyeHoyRWJpQmZ4ZFBkeEhQM2gvUjRpaDVFNE51?=
 =?utf-8?B?ZlZ4eEkxS1JwbG11clNuSVhydW1ZWkpIeFcwbWJMWkloajh4UCtwWGZIazAr?=
 =?utf-8?B?amlzbzNPUGx3Vlg3QURKa1VneVZlaGZCc1IvTVdkZXNvVWNCeFJnMXZrU3M2?=
 =?utf-8?B?TnNhNVZMMW1jTFUvaGZNUEN3WFdPb0RZb0Qxalk0YSszVkVoSkNva0NTeUF2?=
 =?utf-8?B?T0dPYjJzSEZVV2ZvR1Z5YXdwdnY4Rkx2RWdMWHdQWTF6ZWJVZGVoQkZrenF6?=
 =?utf-8?B?Z1NRZXNidk1LbVZjR01xOCtLbDBZeURtVkxtYkFtNThyakVMRlFXSHFIWk9o?=
 =?utf-8?B?ZklSTHlERUQ1akUzYVR6QlZ3UUdzcXBlSEk0V01ESEpFbmlyMkJhbjloTEJZ?=
 =?utf-8?B?Zm1QMjZuMnpFMmdoVHRrNGk3Q1VXdFFwZjkvRk9TcHY1azhxQjRzVXBZbEdh?=
 =?utf-8?B?QndtaDNMbEhWc0xkVnpwTS9UVzAyUHBDV24yVnpmVWlmVTgvMUV0dU1pRWRF?=
 =?utf-8?B?K09OOTlzdmFpUkY4NFhmMUtURVZ5cmo0dHJtOW84RXJFK2hHRkw4dTlIOHVu?=
 =?utf-8?B?czhQbmIweW1VWnI3VGFvd0k5ckRvd0h0NEx5NzN4R1huS1BMLyt6SVU1VDlR?=
 =?utf-8?B?RUFiZk5scU9BODFteHpGdjNpTHd4b0ZoMm5qNXJFRXRYTExlK2ZSV0hUaGVX?=
 =?utf-8?B?bTUwc0VHZWhqYSs5dkdqeWJPV2VnTzJhYU8rYkU1Y3I3akw4NFdpYWJvaHFi?=
 =?utf-8?B?NTRXckIxdzhHYUZ3MW5IbGdBU0ViYWtlVFl5VE56RDg2dW9USDB0QytjRnpp?=
 =?utf-8?B?REQvMFlKZGVsbXUwa1VBWmFuOVRxektJMS9jOFEyMUpjZmhuVWh6bmhxZVE5?=
 =?utf-8?B?UVpmTWFDb3RkYUZCRHl1dmpHdEFJbTlDQWFiSm5rekQzWVRLWTBUL29EMGpl?=
 =?utf-8?B?dHhFaHg2ajRtU1BDbm5jdzAzUTNDaEp5M0xBVVdJK0FId2xROFE0dElGQXRB?=
 =?utf-8?B?YlRpc0I4TDFqUThqb1J5NGc4a0ZBMDNtOWtTcVJGSmdUbk5DazBlcElqbUFW?=
 =?utf-8?B?RnVSOXpyUkVzeWlkRVZUUnpvV3JVdWNJQ2x5dmpDbTA5U21ZNk02eFpkY3pi?=
 =?utf-8?B?aU1ETElmQkkxZDNYTDRxc2s0ZnlRR1A1dkNrSEdmbjZrQjhFRXZYbGdiTzVr?=
 =?utf-8?B?dEU1eG1DdmJKVmcxd3pka2hXelNGMkNPNFk4d1lGSUJVdlh6YkM5MU5FVmxR?=
 =?utf-8?Q?AZLnQTTCzSp5rFCJ3jVvRp7yv?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eed4d3d-3c72-42bf-9fe6-08dd49a06645
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 06:59:01.7333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKJ3bu2ly0Em04eiyQAiOPDFyDqNi0EyIrRiyi84op0f5KmfEfRUodmhsGYHT3+cyAlER4fcy+tvySgFg0DyXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7033
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Feb 2025 06:59:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17796

On 07.02.25 16:04, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> 
> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> ---
>  .gitlab-ci.yml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 0459604..2e3054c 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -231,6 +231,7 @@ build:x86-uefi-secure-boot:
>      targz: disable
>      watchdog: disable
>      security_test: enable
> +    build_swu_v2: enable
>  
>  build:qemu-amd64-swupdate:
>    extends:

While we are onboarding the MCOM, we can do this both for the physical
and the virtual amd64 target. However, I would like to revisit later on
if we actually need both in the end. We should always try to keep our
pipelines lean.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

