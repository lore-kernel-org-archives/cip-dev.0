Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5DFCA0FE6
	for <webhook@archiver.kernel.org>; Fri,  1 Sep 2023 10:39:38 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.72])
 by mx.groups.io with SMTP id smtpd.web11.3433.1693564776637852610
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Sep 2023 03:39:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NjsP/tPQ;
 spf=pass (domain: siemens.com, ip: 40.107.15.72, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9fI/ZNFao6Hi2uucbv/np0Wdr/lqOGX6SYqIYpj0HYvEYTrdXnJT28HYZc6DewrfP2xgzN06kcv8zKvlCSOE4ggQ5mxLtKjLbipV0gwKLPODLRa83NPs5sSkPdPMyDJBL5UVk7sXBWPz20Rj1+WG+OnYfUy7aUUNaAOSEDChGGl/u8W5uM20G6Mih/4A076YPSAcUQY+i9ObPIl3yMfEJ8L00mNeHcRVTdWp0AMCMzS19E7Vr0bD6+5QhVkY7pFQjgvw9I2BBICbueJMWBIzQT3kRyw3+1vXqiZAiZb/Lf0a2zt7dorKFx0MfSwbamsyiB196FC/seEAnkkVfDsnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9gvpDAS9qPYigAYnIIELgMm8eEzlLBmDU7++nmf1AQ=;
 b=c1lBPuP3logt/l9Rjch3YL/z5PlPKVSqFTWZ2XwuNeVw7gRAf5nbtNzyWR3+O5fBUGEHezNJW4wUmd88OijXyFyCxXXt9MJsUvMxQejALl6xNKzH7QLqiJwixkwjsLw577G2aIFVl9wb4meZMEaNaqThYYRJ+9w/vR/HIeJX04zcUH+roQUOiv1OjaYuon6e0HpDf4ETYpGi5uGLp64qG0qFfgkeEd1bYfAsjE2j6UyZu2FqpzIbDs3zgR5/UaFqNgsqVxfdGpemj/J37h8kerDOB8RfZedB6ZaIVrIOZWiQxflg6p7uEsBhY7ypVr50A95BisRV4P/oJKrTlyvpGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9gvpDAS9qPYigAYnIIELgMm8eEzlLBmDU7++nmf1AQ=;
 b=NjsP/tPQT/p6xC0wl2ah4pPVofNX3kHbyy+x1NQCdfgn3SYx1Lb/yiNY5U/h0/w7XcSa1x1K0pCztIVFbQ7M2b7tVti6PoTMyzkfpaK4GsP0GUo+w6OaY4XfWyuToORQH5ICoeWjA1tYKA6GvpR5niQuF5WUemi9WKNO1jjoh0l/3gZNBIaHtvfQ/PDr8u1+UsAKyfu9b5xeY4TT/3qeEHWZbjtdojbS5wKFdnVAdBMwdVyiA7B2q1x83luxbPnNMi9/jvQBtacDRWMoMJJ4d3TQdbkmLA/MN0mYICEiuKJ5P4nDDnCPcGC991SjNRTndhk5/R0lP0Ia8ZUoLz5A5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Fri, 1 Sep
 2023 10:39:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 10:39:33 +0000
Message-ID: <03e48c84-2497-49fe-a61e-2e1fe6b95251@siemens.com>
Date: Fri, 1 Sep 2023 12:39:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core 2/2] README_version-release-policy.md: Add product
 description details
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230901081943.1816811-1-Sai.Sathujoda@toshiba-tsip.com>
 <20230901081943.1816811-2-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230901081943.1816811-2-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3835:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d7d1aa5-77a9-48da-af42-08dbaad7bb17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iURiCWWVCrXCeWEHROVvS6zxbiqJPMgnpIe1t0dVpOQBgRlsEWleGFEmsOPVdv0bEKEedvArT+rvKEHBrM/LfP03TabNIa0iZIdU7pz6PA6IWLtaVkLOW0pMwsQgpz40LbkwCQOkT+B6yFZRhbshZ6SZ8y3kycYOKNt7rmWv3pSOJWludX88Xv/XvyOcB2k3dw4a7Rlb5YknT4NwWaixEE7hjg/E1Se7tRyzM8QXocqoNm0nuT48g7utzZCYHlmj6VINlw+mo8ye9RgfAFqVswpJDtst2mIhTM/qZ/bawUve3eDVc90Aq2ObGWwqn6CVyh1XzvMAqy9yq8UVBZAMqFPbrDZ3psKdUXtAe7J4qeK5TPImct7hkRH2Tk60ccHlDti8CSVNsLRpRw/zYumtnd2zzFgCBgeeSbAV8cubypgaLEQxBR8Ysln9naWjmVsP8VCazwX71+comZa75Zu6F2fz1dzaoF8wY6vbq7TBtXd37r9zCNaDKQPILsHt3YtOgJI72XN2hBvpbRI1hHH8aMXXyw159XQUZXOrtm3ZTwixd3tiHfCij3/f4xDjmWzRXL9ICDIuCuh277nv+O/hckaV4Z9g1VWyV95z2jy5TO21GwYegOOYUXfX6mJBOPXllDJ2CSE0GUwMpdu7AX1csiy2b9wcQofbj5o4JSjJ4Q0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199024)(186009)(1800799009)(478600001)(31686004)(2616005)(38100700002)(66556008)(66476007)(53546011)(83380400001)(26005)(66946007)(6512007)(82960400001)(6506007)(6486002)(2906002)(44832011)(5660300002)(8676002)(41300700001)(316002)(36756003)(86362001)(31696002)(8936002)(4326008)(319154004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K3dVa2VIdFBKb0EycmFVTUE4czZtQ1VKemRKNEpYQTZZTW5nUGJZVTQ2MGUz?=
 =?utf-8?B?KzJXYmdBazVNY3pYdzlzalk0ODBCYSt0MHR1VllJZGVDUXhSSnNlS3NlMGtu?=
 =?utf-8?B?UlcrQ0FRT0wyblVhRGFrZnorZW1JNW96TWNhQ2xNZXhJaVByVGY4T2krekx5?=
 =?utf-8?B?WVhYaVloZE9tNVI3a1d1WnVrQkplcVp5L281Wmtyb2RyMVV2OVZRdUk5azg3?=
 =?utf-8?B?K1p0Z05GejN5aWZjZVQ4anRZaUdoSWt1cGNWOS9nUUN2aGp4dUdPZ3Z4b3oy?=
 =?utf-8?B?NitrU2M2Uko4TkVUdW1HenQyK1A0M21lb21HcnMzTGFQaUpWMWV1RjlLRTVm?=
 =?utf-8?B?aVY4ZWkwWGF4cmpuT2xyRDlFMGEzV3BFOGorek9nRlBVRUJ6d1ZjbkUvcFhH?=
 =?utf-8?B?MnN0MGVEOHJGMHYyWEFrZVhCWnZPOEsxQWp3S01IeExjUkc3K1J4RDgrYVpq?=
 =?utf-8?B?cEY3ZTVqWWcwZU0rQWF2eUFLOUVXMlAzRmlHNzkydHd1TW1FdkRTTGlLbzAx?=
 =?utf-8?B?NllEUktYcEJFa2RXQVhINUhjRWpuaFZMd1V0T1E0cUhoWjZWM0o1MkVKdWxH?=
 =?utf-8?B?VERucWJwNHJJaHZGcFFqaWE2NzY3eHovLzFUVGh1YngxbnhsY2VCQmlRR1kw?=
 =?utf-8?B?UFBmTmtNN0E2d21MYXlZY0hvSXd2Qyt6QlluQkl1L3lqS3lGQVZqd1d5T29Z?=
 =?utf-8?B?bm9CY09zVEl0WnB2RWtIYWJCV0lDU0Y1TnJVZGJCWmNEVkNOdit0a1I2RGxJ?=
 =?utf-8?B?d1p4eUIya0wvM25RL05wQU9KemxvTUpYaVlDZEFabjJiUGlON25GYklEdzBJ?=
 =?utf-8?B?L1phaVZPenpTenVzWWJOT1dDbUhaZ0l2Wmtqek4wQ3B1MUwxbWwrTUpmcXcx?=
 =?utf-8?B?aUtTMk9IU29aeWRiRW5mVDhtR2NqVkxuc2ZrVmRNbERBRGphUWZVUTFUcGZW?=
 =?utf-8?B?Z2V1ZGp2bTlGV0I5YzhLcHBmSFRUQitKNzA0dzNQK2xWcU93TTRZdGJTVlUx?=
 =?utf-8?B?dW82bHVJbXdzNTVuNVRDV3JQWE5PRUk0d2M1M2I2U2hMK2gxR0QxYjMzOGxG?=
 =?utf-8?B?TGNVWnM3MmhGMUpKQVRyNjlCM0hmdk50U1g4ZGRPa2VmL0h1Mkk4WG5ZRmdj?=
 =?utf-8?B?RFVQdlU1T0wwUHVwdXpXZUlxd0dvSXNuWjAyRVY0K1VTendZVzRzcVErbmxl?=
 =?utf-8?B?TDVzblAwMTBzdXFYUUVLK0VWd3E4T1ZNWUo4dndORGprK2JqNDZvYlFTOXRn?=
 =?utf-8?B?VzlIZVlLaUwrVm1yV1NVaDJOdW5ZVG5PNVZ4bU91SVJIbXlwcXBPRXJoZWU1?=
 =?utf-8?B?dW42VzhlR1RpZVQ0VlJJKzRTM3A4dlpRbE8wUEtHdU5HQk8rRGcyWk1sZmdF?=
 =?utf-8?B?dXJMOVBLU2UrU2tacHlPVngweUxBQzFkZE5PUEF5aWtXVUs1ZldTVmdYbFl4?=
 =?utf-8?B?MDJxZWozcTJuVFkrdi9qblIwUUhGdlNQcGFodndGVkQ4TnBBQ2NaNG51Tk5T?=
 =?utf-8?B?czhGdTJJeWRPTW4rczhmeENzNGdDQjV4OTRHeCtjWG4waFpwb1UyZEFrR1dR?=
 =?utf-8?B?TGFnOXg3VFU0aThWazRqT1BkNkZwL1VpMjFuRHhFb3kyWllqK1g1RCt5aGJB?=
 =?utf-8?B?WnNDTVd5aXhLbkNZV3JDNE9LQjR0RW9oam1QcmEvbXBsTWJHWjJSajZBMk96?=
 =?utf-8?B?Q094MC9UakJhQlo0YTRqQytBclBQTDJ5WmpWQ3BXc2pkcW9VUWZiSnFoT01I?=
 =?utf-8?B?ZnVHRmJVT1VOdG1ldE01M3NOZmF5ZGdnNkRvQkZkN2xKWkZSTWl6ZWRkdXZi?=
 =?utf-8?B?S1FSN3RISE1pUk40NiswU3FpT3NjbXo5TFFIRDhibDVpcjNrdnNyNTI3b3FE?=
 =?utf-8?B?NThIUDcyUVRDeHNRVXR6RWtKMFcrbnI4b3JqeURLckxNZEF4ZmFWRmpnejZK?=
 =?utf-8?B?YkJuZE44a2ZwMzVzbDhqcGRoM0JLRWx2TXZESkNxRzgxamRkWER3Q0wvbWh3?=
 =?utf-8?B?VUc5czlQNDEwa0tCcitZcEVKU1o2WFhUKzl4MWMrQ3VZOHVDditheVc3S0wx?=
 =?utf-8?B?Vm9UWUVKNDJmTTdiTU9HMkxHeHprN2kzWGN6WGZKcDl4d0FxMmR1akhtZGl1?=
 =?utf-8?B?TEgwanhJMWMvUkZiU1VVVTBUd2Y4NHVpQWpLTFhIalhYUXZzSnA3Y1Z3SWY0?=
 =?utf-8?B?N0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7d1aa5-77a9-48da-af42-08dbaad7bb17
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 10:39:33.8449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGbFlLgk+JmQ1fjcAqNkzZS3OpQuIKQVQnHyZO4bFdeG2hhKMkQh4WkEREvH6Q+MVEXtfD/bEI6TxUZMKIBokg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3835
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Sep 2023 10:39:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12934

On 01.09.23 10:19, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
> 
> The Debian releases, Kernel versions and image features supported
> for repsective isar-cip-core release information is added.

respective

> 
> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  doc/README_version-release-policy.md | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/doc/README_version-release-policy.md b/doc/README_version-release-policy.md
> index 918e77a..f8dde38 100644
> --- a/doc/README_version-release-policy.md
> +++ b/doc/README_version-release-policy.md
> @@ -4,6 +4,7 @@
>  1. [Objective](#objective)
>  2. [Versioning system](#versioningsystem)
>  3. [Release policy](#releasepolicy)
> +4. [Product Description for metadata release](#productdescription)

We are not building products in the CIP project.

>  
>  ## Objective <a name="objective"></a>
>  
> @@ -28,3 +29,10 @@ The isar-cip-core metadata follows semantic versioning system i.e **x.y.z** form
>  An approximate time gap of 3 months is taken between consecutive regular releases. During every release, CIP-Core plans to give out recipes (isar-cip-core metadata) using which the user can build the flavor of their choice.
>  
>  All the releases can be found [here](https://gitlab.com/cip-project/cip-core/isar-cip-core/-/tags).
> +
> +## Product Description for metadata release <a name="productdescription></a>"
> +
> +| **Metadata version** | **Supported Debian versions**   | **Supported Kernel versions**                | **Features**                      |
> +| -------------------- | --------------------------------| ---------------------------------------------| --------------------------------- |
> +| v1.0                 |  Buster <br> Bullseye               |   4.4.x-cip <br> 4.19.x-cip <br> 5.10.x-cip <br> 6.1.x-mainline  | Flashable image <br> Security extensions <br> Testing extensions <br> SWupdate support for root partition <br> Secure boot <br> Encryption of data partitions  |
> +| v1.1                 |  Buster <br> Bullseye <br> Bookworm | 4.4.x-cip <br> 4.19.x-cip <br> 5.10.x-cip <br> 6.1.x-cip | Flashable image <br> Security extensions <br> Testing extensions <br> SWupdate support for root partition <br> Secure boot <br> Encryption of data partitions  |

This is like a mini changelog, in addition to the full changelog (git
history) and the release summaries. What is the purpose if this table,
who is expected to read that?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


