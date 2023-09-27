Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E589E80A90
	for <webhook@archiver.kernel.org>; Wed, 27 Sep 2023 05:54:46 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.85])
 by mx.groups.io with SMTP id smtpd.web10.11473.1695794077744027147
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Sep 2023 22:54:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=amPqdd3P;
 spf=pass (domain: siemens.com, ip: 40.107.22.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQZ8Hjs85R0QlF0LZ6MTDN1c8TO39lU42rKVAp/8FQJxqTiFIvkrWqTJemYkgrwzCDfECMv8GvS212cJXP+jkvF0rrR8Ydo5ff6RDSAfhTd2HpKdz7amR0ptMW9FCZMjMvc2tnXVqidxTNoQhNRkSacgv0SluQGRdfei73+8uyApTd0+pNVGvaBzxsOtFK92BmCW6iADzfnOrTWtRoZ6Zk6FEjaqIcF2+RcgxwiZueoqNLANFDQDyThygdql0peKcATkNy6n+STTZ8xEn6rd5jT2KOU7HR48mGqaUw3Quzp2LDDCMj0XRNKK1mUgXM+XJQst4KEUZVswNrId2rno9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+i5g8Curts9sHFLD1FBMDmw+uFHYEFnRhk4wzAK0zsY=;
 b=basHHN2VDoqLo/TwtsPfnHqeOhFLnsm9OFcF0mVil3wXqSAUIIoaFoxkftQ/F7Qwu5/sSN70fU3fKxhGWl8ay90y0xn2SVMGfIG3S7mFe1Nk51WDxkM3CMqXw3RVFjvrbXdW5D83vy275E9Kr0uNTfv2D7E065Gq8T42+r7soQ3vlHsnpKuHbdgQONSleIOSjrjaatmOlvgVlzwCykhwNSN2ZKwsiAcDxHL0oRAWJsXxJ7iQ+lnslxdnJwlMiQVaKMNu0qVqO5ec1nrqSN1bOPvn3HTjQ50R5Y7Aj1LVBpCax3B6BJInASDQ9T1vBmbQuvSPCGCtV8yvaKmVYPqXXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+i5g8Curts9sHFLD1FBMDmw+uFHYEFnRhk4wzAK0zsY=;
 b=amPqdd3PNwAI6OvM50lXYuOPljP3TJQuNPUGPIokqBshv1PA6kp+6CTW13pKu3BgrOLmldiGcgGawIfIQVM93JVDzDCANVpMRIzTXvI1eYRvuekJY7jeKn+0JR8sZiSxKLJ4yaIPhjxd7Cm4ekFA2lpSHHg0WqXxHZwJ64trj+Fgw0yKjNLG2jfsU9mt6Q5+l0zcEpFtk89/9RtkZJeOTW4qoTwy9lQWN99wwO0Ievuswt0EvHM0hwRHdOEfFMt2G4shE2JtPwM3aqRXrxYrI6Yu3cLDJbA7ZEe4vLGbUew0knGXQBPm23q/WpCa6T9BJrhdeal4ZVW4uRhy9pP0rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5361.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:340::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 05:54:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 05:54:34 +0000
Message-ID: <5b0e46dd-b2ef-4cca-a612-1c79e5b5998c@siemens.com>
Date: Wed, 27 Sep 2023 07:54:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v3 0/2] Add dosfstools recipe
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <e9aeb66d-91f3-40a3-8b5c-44b75bec3544@siemens.com>
 <20230926164021.30185-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230926164021.30185-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5361:EE_
X-MS-Office365-Filtering-Correlation-Id: 677f2585-2ec6-43de-e525-08dbbf1e39b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pPS6trdDcthPLC5N5eU+8Mxsn9u8mZP2Rpx2ishpBpu4H5MambyJIdftW07Ai/AlN3Nm45XsBpjMeev+POkzHGaQQ1KtYP2/zyi6WcV/mw6u9QjtrGAkXL2fH+z6SInh07Hkj2oVje5MvqXeKKGFDqpzWszD2EfIpqm9HGIpeIePd+NBAxirhaFZ0hfk+Bupdm9aly6UdhIrnvhQbuD61EmZZmZLASKIQ7vNPSXgnrMDi/YxAQ1r0QEYgFtwRagPT4T4mO8mbt8SVR+Hkbt4LQomc4YTg7Gh3Jvjfu+1mx2ZsFSNY0K1aCw44kZ69/I8G5r9oziI7TiNlYtcN4iPvTO4olrLMBrYZq1utODwMcL8Xa0TwqcopZwXAP31vk0Uj3chSyE1GndYuXxjh9cN96s3Ii0EHDqvJmTTRGjiuuDFHa53Q4UE4VMMrA1CrynProTLJLIya+CrchEjt8bdjW4cAgQt7MqXOv/fSB9HXQrVmuZ7I+skRorKNJjWQrtcfUNVsdWn/BQyDtGNNX+sL6SAexj6ueDSTUFKyqarM7RR8nU4r94KacshFYUPkTRxLvK+0Dx2AtIwrD+4XH47mbgmmrB5dVyk+4EWv0c3YRd6vJHhfmYe03h3Vx137aSrqwRA/G2y/CUMI094Hb6Ejw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(396003)(376002)(230922051799003)(1800799009)(186009)(451199024)(44832011)(8676002)(8936002)(5660300002)(4326008)(66476007)(66556008)(6486002)(66946007)(478600001)(6506007)(6666004)(2616005)(26005)(6512007)(41300700001)(316002)(53546011)(2906002)(31696002)(86362001)(38100700002)(82960400001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VTRMS0ZXZkFqUkpYK3hMejZCVWZ3Ny9aeWZld25lNDVJK2RUNld5a1Uycmg2?=
 =?utf-8?B?SzR4UVRuOXNsU253Y1pTbDNuWXlHSHpMRTZodVhhbXoxZ0hXMFhPM09nY25w?=
 =?utf-8?B?TURqRmkwKzVPb2FOOEtOQWJ6dGlJNkkxVGp2Qzh1MVdTOVFLaXBhTE50elBJ?=
 =?utf-8?B?OWpOTUtQTkcrSHFGRlB6Y0RzVm1UVzVyVnpmZkFjVW9EOHd3RGFDalJlZXlL?=
 =?utf-8?B?QThVUlo0WjQ3M3oxa3plR0QwODZnK3U5dFp4dW5IZVdrQ3loTVJFZmpsVWVO?=
 =?utf-8?B?QlJEZmlZMmczN2o0bUc4MkdpaHAvTm1OY2N5dndaMFUrcEx6Z0tyTjB1eHV5?=
 =?utf-8?B?K0Q5anduK3R0L21LeXB2YmFUaVI3djZMbXhlOEk5SjRjeFYyNkpyZTk0S1Ix?=
 =?utf-8?B?ajhZQlFKUlY4cTBCcWpBU2U1M0REYmtQcE9PK0cyQXk4REJvWCtsZnJWRGFS?=
 =?utf-8?B?S1dwdlIrckFtOThzeFRyU0hzZUFSYi85blE2TzFFRGI4SDZ1YlJxK091S2x5?=
 =?utf-8?B?ajM0QnV3RTY2YlFtdUY0bFprZjJvZWxYU2pKNXVrRUM3NHdiQlBtcXBQMkJs?=
 =?utf-8?B?OFhPZWEyZlZKR3RUanpUd1lUZi9zN0J6Yk1kMEkyZjVmbytySmk5ZXlFMmxV?=
 =?utf-8?B?L04yc3dCaTFZTkthSmZwdEloZkcyM1ovT040dDFwc3VRZHB1YzJWcDVlUUtE?=
 =?utf-8?B?YjNmUlFhNGtYTjhramZvWjIvQkl3SnllM080eWVPUUEvU0FmNnRCQWp5cVJ4?=
 =?utf-8?B?Rm1zUjFjemxVTHZFeUJvRVM4Ri9FOUd4UTNyUSt5eHIxMTV0RnByTUNpQ3Q1?=
 =?utf-8?B?ZGtiMDcyanVRUlRHSUU1emZBZTQ5Yk5uT21jdWRyaCtvaFNFU1dFd0ZsWkZ1?=
 =?utf-8?B?YTE4ZHhMUjhzYTNHQXhEMHg4Uzl2Mm5HeWptNE1URm1UajlHSURtK2YraVhJ?=
 =?utf-8?B?VnB6SjFXMkRUcnZhZHlDeVBSUklETHR2L1RCaVE3TzNpOFMrOTFtNEVrZHBU?=
 =?utf-8?B?dVk5eXNJS1UxMk1kTXlkeSsrbmM1SEtLUzMrVXdYYTFmMmlObGVsY0xMN2RX?=
 =?utf-8?B?L2VLMi9XeXFmK1V3Z1VzQUplR3ZMWUR6dzNaZlhoM0lIeUtVcDJKWGJVSFZ4?=
 =?utf-8?B?MHlYMmM1V2hzQ0VoVDN6eDJnVVJ0Q1ZhWDZKY3dKUUFNR3RKK284SGpFbUdV?=
 =?utf-8?B?NStKeUNmR3NuQjhKS0FaS1c2Z2xxWEYxK2RIN1JVRmZFVENPb05FU1A3VEN4?=
 =?utf-8?B?emZ3YnRHa25KWHNkSjZRUGxZaXk1eGV0MHBEOUpBSGNnQUM1L0VOYVlPWlEv?=
 =?utf-8?B?MTZEM1U1dExJOHMxQ21QeVRCMEdsVmZYM0ErMjdrTGt0SkI0TmhnNmZRckRY?=
 =?utf-8?B?aVJXcmFSZy9FVFBwTTBYWmRLRzBONVpNeXNPa1hCNEYzNFJ2a2pYUzBlYXhs?=
 =?utf-8?B?dFkwS2hXb0xMT2d3WHdqUUY1czZQOWdTOGE2VFBBbE1CSnZ2SXBKZVRBVkhZ?=
 =?utf-8?B?dHh1bjg5dUQrYnVZTGdLK0twY0FZd0M2K0k4TnIySHBmSm40STYrYlRDV2FR?=
 =?utf-8?B?ZFBvQW1HSjJGb1dNT3NSZmhsNjIxdXlEcjhud25mOThmdllzLzczaXg5VUo3?=
 =?utf-8?B?V0lHUFdtY2c5ZTFaTlc2SUNLZ3RGRkd1eXVHUVJvR3lrcWJUeEhuYUFQOEUv?=
 =?utf-8?B?R2hXNCtGejV4MVJ0cEJFUlJYOHMvak1TQ1ZFbVhsZXZBZ1k0UGE2Y00zV2lD?=
 =?utf-8?B?aEs5TjYyQkwzaHlSS0lscE5RV1c2STFJQ3RzKzFaVThWM2hLUFRRRTVqSE9K?=
 =?utf-8?B?SUg3emhvRWg3ajRCbHZlUUNkVDc0Zk9DUkpadDdvTmZ6YjJELzZWVmMzUEN3?=
 =?utf-8?B?ZVgyTWtaYUdpMVlaUGFlS2ZzelEwSGdGQ2VxZ0ZVYWQ4Sm1IL3lCc0IwZ0hv?=
 =?utf-8?B?R25BazdQcE80cHVnSXUvNFVNNm5LQUVwOEM4dkhTalhTYlQ4NU0waVZtckZM?=
 =?utf-8?B?ZmxEVHQxaEx0L0k5SllENXlsOWozellyYWJvaFE1UW9tWEg3c1h5NVVDZXVn?=
 =?utf-8?B?akp6V0hQWXRnVWI1M3c4cVB2dDZHdFo3S1ZzWkhMUmZrRTV6SVhuZjdSRkta?=
 =?utf-8?B?cUF6dk5XYUQxRFA3Mll4b2d5aUMwUnlMUkZIdXN6ak9CWVNvdEMwbkdqeUZC?=
 =?utf-8?B?Vmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677f2585-2ec6-43de-e525-08dbbf1e39b6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 05:54:34.2194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aoGsxw5wmB8yKrQ3Ws9BlByMDSO0AFljF6AkWzXgfeAHN3yFV0y42OpdDJe7RUmMWySsJYRYqlkAw+Je3a50ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5361
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Sep 2023 05:54:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13234

On 26.09.23 18:40, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> Hi,
> 
> This patch series add recipe that build custom dosfstools and use it for
> creating reproducible DOS images.
> 
> v3 changes:
>   - dosfstools: Add recipe to build it locally
>      (Remove dosfstools dependency from reproucible option)
>   - distro: Set dosfstools as build dependency
>      (new commit)
> 
> v2 changes:
>   dosfstools: Add recipe to build it locally
>      (modified from `dpkg-gbp` to `apt://`)
>   images: Add dosfstools as DEPENDENCY to all images
>      (new commit)
> 
>  conf/distro/cip-core-common.inc               |   1 +
>  .../dosfstools/dosfstools_latest.bb           |  28 +++
>  ...Honor-the-SOURCE_DATE_EPOCH-variable.patch | 160 ++++++++++++++++++
>  3 files changed, 189 insertions(+)
>  create mode 100644 recipes-devtools/dosfstools/dosfstools_latest.bb
>  create mode 100644 recipes-devtools/dosfstools/files/0001-Honor-the-SOURCE_DATE_EPOCH-variable.patch
> 

Thanks, applied.

BTW, did I ask if you opened a debian bug for this as well? Even if
upstream does not decide that such a patch is stable-worth, it would be
good to track, also for other reproducibility efforts.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


