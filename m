Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BECEB64DC
	for <webhook@archiver.kernel.org>; Mon,  3 Jul 2023 10:50:41 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.73])
 by mx.groups.io with SMTP id smtpd.web11.29785.1688381438951648234
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jul 2023 03:50:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ybO7zVNU;
 spf=pass (domain: siemens.com, ip: 40.107.7.73, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1xFbBim0N0YfDoYPOujhjQVU8Qsnt5iRpR6nMgW2M+Nrhqnf9brz5iHyXYrGU1sWAXWn7oCA84bWvOUGEdgjHElLBnGgiIQCDZFuoiL0dVMfyjnUekq71jLYsfX7g5b/mp5DU/aGLRaeCBsq6/I5KyCS8wTCOINxEGPgKlASALYVL2U8l2ZKKjGNPKiu0rZJe8x17Hc5a5kD7ZhYaYe+Qk7QaSpj/75NMESjpjJ99K7aNWSxCMt9aIYR+kqJc+lEfSt1+brkgvos64ttzS/LfSvSbZoB4SWz5MSZCgJma3z9/vESPVq0ADhlaZUv2+2XT9rGlnSC/MoM4k2mwZQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoCd28sV3OAesF950Dg1Bm96PN7Lan7mzUshv1UT9P8=;
 b=GhDM446GWlu+//PH30bixX+T7SKsBPcCr91u0eIMc+VkzeQIS76ZiY3q6iUkGxRmRWZ+eWjEQH2CHZp7OjCw2zDmM9RSdBuVdAFovVriLrZt/LMIlBckCb2wZ+it+7ptbpqgKAXwx0fpny3SL9u91bQZs88u5F9CKimKAUsno1/d88Jfc5bvbIWYWiaX3oRSvANbpzZAuPXBOpx3AL7k7T1CkiotccV/nMiK1B5nTN5XeB19msKLvupwY8GfiYS6Dlz7sc9nXOWoGaycDuaQ+ZDz2FCz0rPaBFJl7IpYUGjAZZ5UPEEl1ReonhCglk7FUcyS+lOjQgJx+JRtpqGbNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoCd28sV3OAesF950Dg1Bm96PN7Lan7mzUshv1UT9P8=;
 b=ybO7zVNUagG6UDi+W6vQWNhjr1adWvZTNAju2QQnYm0NKqN8LxOCGq3G+0WM/a5sb/W7KTldDGMaZjUkopglwq63rmsoGsmBIhtVxiKrGzNN5gk5PjAQQowvluMMzE3F/ZCQoJOEaSgwVK8khc0zIS7thXw0E78021bP0g47FtLiPo2ZZIOg3WiHQ6PwFg9lLvH55DkWoIodaA2k1LfXJivPwPQeZGBz18IoJP4RufIPNKeDqeGZWZlcRb1r0a+klIYcxAqAWJs3n2dTNiAofOAm8UjYFWqSPWQZJS7WFlTECbWqq8YLHFbogEBB8iPFgsUsBH+PLGWzaRsPMFLmFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7480.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:590::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 10:50:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 10:50:35 +0000
Message-ID: <0fa5e801-d15e-91e8-32a3-7aef2d1a987e@siemens.com>
Date: Mon, 3 Jul 2023 12:50:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [isar-cip-core v2 5/6] squashfs.bbclass: Fix file timestamps are
 not reproducible in squashfs image
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <176C1D7D866704FB.6977@lists.cip-project.org>
 <20230703062231.18183-6-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230703062231.18183-6-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: d9da43cf-d18d-4938-b2cb-08db7bb354e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	R2Y1tx79Z9tp7mFH90AgAD3BHWx2L9Jpw5JHF97IDqQMLXSymYmZYF82lAUTT2YUSK2hLpZNvPsVdUAeHJOMe50FwizH5vdxO+Il2XMHjpFFx5V7LMLYNOQ73NW+aBg6F5lj2Xf4+AFgUVEtFhP2A5ke/kE61zkzJs3eprjQoWz+EcPpyxxmU/uGzhBt5MOkDSzcVw/1ChVquhGC3qZm9jYdqMAPG7TwUMuLn2zKfD+qQC65Cg6r6f62GT6b2Vm6FeNTzZC6azdEE8uW/A8z2EiRjWnmlV0OhJXPLJbN0nhP2+C+3UKgGA2szEHT1JBsqp8mLw37q0YiUYQME0e4r9rInn0kXhfthd5IpMLt3naNZ8u6agMz7KAd5XLLYq9NLstpl4AvE6THAXiDM6C7qGjmtCJ3PKJgGj9smcjNA6ml2vRQwkYncTG1/zr13lai5ltvVGaq8R+gxtXkIwcDIdE8jsxAVIIOXHIj7I1spO3kkbxlp9I6Um+Ds098nyxyJsYCOHBYYMTBlWcmROlwbAEKqkCh9NEhOXflZv+HIHM0aJsCcBUm1OmA288KdaKqTPiuoUGRs9tsVbtxc/YbOoMrh4701BwyviTR/2b3MivhSMMMkAGNPG09l6tn9bIN8CFus62paFT1Nz5E210Q6w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(478600001)(82960400001)(5660300002)(8676002)(8936002)(2906002)(36756003)(31696002)(86362001)(44832011)(38100700002)(66556008)(66476007)(66946007)(4326008)(316002)(41300700001)(31686004)(83380400001)(53546011)(6506007)(26005)(186003)(2616005)(6512007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bk4xNm5jdlJxWnNPZVliRU5VbzlFSHlJMUlYZWhnL1VaN05LWjUyMnBnK2gy?=
 =?utf-8?B?c0pWT1RFcHAyZjZhRkpTQzMxQi9GQVJxMjBzY2VHdjBTemlRMURxUDhmT2Nn?=
 =?utf-8?B?c2hZQUduaS8wTU0wQzBBVUk2SzFobDNJbVdoTmJtVzgyRnp5NnkvL21jSEU2?=
 =?utf-8?B?TXNLSjhOU1BueDZWWWJOODVHeWNSekpsVGkwbXlVVDlaZXBjYk8xUm1DR2RX?=
 =?utf-8?B?bUN1SDBiRmVUa0szNHI5UWVIZnpzRmMxSXhKbkpCZE1Edm9rSExYWlo1eGxH?=
 =?utf-8?B?QzdaS2Q5MlNJVUthb3d1L3pwdUFBVkN5ZUhRNnJsWWNXeVpucDY0cHBMU3JS?=
 =?utf-8?B?THFRSEluZWNaampNUzdWalFVdWRYMGFXMktIMFpvaVIwQ1N1QUkyUCsyTURs?=
 =?utf-8?B?S0ZPTVZLeTByRUhmRUZJYkFUbnk0K3cwMm9xb0tQK1AzTFdGQlE3NDNmUExU?=
 =?utf-8?B?RGJVNS9DSGtQSUtlS0pHUXFYVU1QeUJWQk14SDdTUmM4MEI4VVZ6a05XL3hq?=
 =?utf-8?B?RFVZYzV0WmUyZkZwVUtLeHVFQ2oweHpoNmU1NVZuVEx4WVVnZjlEL0tZc2lv?=
 =?utf-8?B?MEYzNkpzbnZwVHNNeS9XMHlqcEJ4VG1wMlE0Y2VUSVhocG1MenM5ZmNTdDdq?=
 =?utf-8?B?ZFNjRC9pNzFnQ0pLcGxIcGxGUFlSN05TaEdVK010SHh6b1RqMEU4bXVuR01t?=
 =?utf-8?B?bE82QWpPU3lONURydTh6cVJPUzcxcUJkekpRM2M0WUxmaUZIYmtuREdUQUlh?=
 =?utf-8?B?TzFPNXNkZ1V0MGljQnM3T1hJd3RCcFdWMmpMQ1NUaHgrMnUybGJEMGk0dW5Q?=
 =?utf-8?B?V1E2RkpRUVJQWDdXcGtGZFNacWg0ZExYbzQ5L1dzRTArMjFYOFlUVmVYZHhh?=
 =?utf-8?B?VTFWOWk3YXpJWkQzVUVQS25JSURWSEFjSEtranpsSkhUeW12ZDFnZVczUGd5?=
 =?utf-8?B?TTlQK2M2U2ViUTZQWndFc21OY0pUU2loMVdCa1NQRS9OME9EV2d2YWVBOVFJ?=
 =?utf-8?B?ZDBSQnZ5dGY0QUpQekZuWmpjYzNvVHdob0xRbTdMU1ZVQmNCbGo4aS9MWDYy?=
 =?utf-8?B?amxSbGtDL3BpMVlzYytKc0dyRkxaR0wyQ00vc1ZrT08rTFNTV0IxRFEwYTBQ?=
 =?utf-8?B?QkFMV2FBb1dkVW5CQzdrTDVRcWYvMlRKdFFOelVOcWFqdXdjUnlweGxYQ1dS?=
 =?utf-8?B?M1poZ3ErWWZ4MzJURFRHdFlPRDZnckhFOEdETEdsMUM2SE5LejlQSENHNFFh?=
 =?utf-8?B?dWpXN2ZVTDhjNFd1a3pNWnZHRDZMSmJnQlJFc1VsRkcrbmpLRXRmTnZiOWkw?=
 =?utf-8?B?Z1NteUV0bG1sMkJWZ1hsWjY4ZGtVMjlTQ3lDNDdQZDJXWTBFRks3eXExODNu?=
 =?utf-8?B?cUxLOHVRb1E2WWpaVUJFcVhMcnQvc2VkN2ZuWVF6a1c1czArcUYycGZONkFh?=
 =?utf-8?B?bkFwOGxFZ3lKVTJGSXI2V3Z5M0d6dzNEM1l0WTIrV1RQWTFVRjg3K0VqbGxy?=
 =?utf-8?B?bG8wZG41OGlCZlJXSEtUZFh3WXV5Z0dLODltQVl4QzZZUVpFQVliNTdWbFl1?=
 =?utf-8?B?Nzg4NnpDYmxBUFF4VzFEY1RndHZNajRqbUJ2cVVOS0FMd3hmN3o2Vzc0cFpB?=
 =?utf-8?B?VEYwdWJ0ZjgvTVU0UmtsRVFLYWlhd1FUUUxBdEVxNUl1dmhwT0VTd29mWVg3?=
 =?utf-8?B?blo2YXB0SVdsR1Roay9CcTdrVWlBY1psSnJLQXVRNjhIM2djSENnbHFlNE5y?=
 =?utf-8?B?T3FuTXNmM0lwamYzdHR3VnFidHN2cUNDdm81Q2NJZ3A5NU1Zblh2eTdHR1FK?=
 =?utf-8?B?NE9SenYvdWZQZWZRQXFuV2p1c1JpVy9FY2xnSXJRWkJ3cWxLSmF2QXo5WnpG?=
 =?utf-8?B?Y1VUZFlIeGJCcEJ5Qk9OOW82SXNia21DeVIxVzlvMGZUTnFHNVNST3hkWkJH?=
 =?utf-8?B?RHF1SFNzMWEzaDRVQXI1V1J4TmlBVGt1M082RUliVFZhMXRTaXJ3dm1vQ2ZP?=
 =?utf-8?B?ZUdnT3hCRXM1SmVWTkVyTXd1NmZjMGEzUWpGclRpWS85YXJONCtwa25pQWY4?=
 =?utf-8?B?Vm9McDk4QVRFTXVEZGxPSS9vR3YzV3l3ZFdSU2hsaldjMk9nQmp1QXZMcWh0?=
 =?utf-8?B?dDFQZHBhZWdOa1ViQ0ZrSTBWUm5Bb2RRZmJFV0kxeFNyKzRhd3I5VndEUUR2?=
 =?utf-8?B?WEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9da43cf-d18d-4938-b2cb-08db7bb354e5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 10:50:35.7879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpS1gyhdWSyfck/Au6p4JQzmFTk+wATU7MqBixSp3pT+ABop2WZEznNKKjdm2n6vzGam+XdRCzIHXzcDjOhhjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7480
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jul 2023 10:50:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12179

On 03.07.23 08:22, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> The generated squashfs image contains non-reproducible file timestamps,
> so set with value in SOURCE_DATE_EPOCH variable if it is set.
> 
> Closes: #68
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  classes/squashfs.bbclass | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
> index b39be0c..469cdc5 100644
> --- a/classes/squashfs.bbclass
> +++ b/classes/squashfs.bbclass
> @@ -31,6 +31,12 @@ SQUASHFS_MEMLIMIT ?= "${@int(get_free_mem() * 3/4)}"
>  SQUASHFS_CREATION_LIMITS = "-mem ${SQUASHFS_MEMLIMIT} -processors ${SQUASHFS_THREADS}"
>  
>  python __anonymous() {
> +    # Set file timestamps for reproducible builds
> +    source_date_epoch = d.getVar('SOURCE_DATE_EPOCH')
> +    if source_date_epoch:
> +       args = " -fstime {time}".format(time=source_date_epoch)
> +    d.appendVar('SQUASHFS_CREATION_ARGS', args)

Wrong indention of this line - args is undefined if source_date_epoch is
None.

> +
>      exclude_directories = d.getVar('SQUASHFS_EXCLUDE_DIRS').split()
>      if len(exclude_directories) == 0:
>          return

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


