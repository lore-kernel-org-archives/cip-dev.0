Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D138E6FE3B
	for <webhook@archiver.kernel.org>; Fri, 22 Sep 2023 14:27:07 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.50])
 by mx.groups.io with SMTP id smtpd.web10.22620.1695392821091706653
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Sep 2023 07:27:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Jq9VTpRn;
 spf=pass (domain: siemens.com, ip: 40.107.247.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvkE368lIRTaIn4nUK6i+u57wqIuzZVvhs27RR56cVZcESojjJnF8cakve9sxvCQ7J1oXppmelGMECwpODTsRYOzvkL6YNsGyONmG5k4jutkuxBO9RE/0clNf1R5OxgI749+ue32x353R2i2BZIFY1C6VtxGAaiWdmMiynloZgH1CNrYQoCeTUC9nGabSIfnG1gxipHWRIvU8JqIdvUGnyIntZ5pwe8rKN7Wnd8l8NQ9ZwaEZL5rpN8NmY7W+coDTq6q1ty07CJbD6IMPlIxJoowDfmq4En36lGwjtrFweeb4hfVG2GvL6lWTS3re4sazCZg+rsIh1PUCnFSW4zh4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwC8852g1JgBPE36ZaP5dLIFc8PSErKbYygM9scWdwQ=;
 b=cas264RvSzI2RChy5CYKhw6MqwF+eu8R08vx/X1ZtBf0ai1SmAU4phT4vFKsI3UTaitqtHdjFa0pHHZAqLUD6rbwMlNFt5hhp0y/RwcqnfU5JjKyQuWUvfH7uZQoxBKBjoFnj3P0fwHRkCvlohWItB96tFwOifl/CI/Ov1zfAStV43UX4erNViSc31mPsVuGj0seu3irZsTU8ZKjpF7U9wyDlAEpEU7mrOVJgajiYUmx67GEIFxno/mGMcogwBYAavktwG/+kJQPVbHawkZNLShjjGLK4EDWoU1xNOWV9LCpCqfE0MK5kwYWOKiYLekcnrRxRzjxpv4TglwSWfU/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwC8852g1JgBPE36ZaP5dLIFc8PSErKbYygM9scWdwQ=;
 b=Jq9VTpRnX8dIvRgOA0WArAMZPnqxhsMuUBWJpJAVSRlM3sCVeoKgGQKvANbFHtyZHWzTJtjFnQaCtv6Ld3nBfffSmF50l31cj582IC4I7auVekoVMGd2QPgPurly5R9L9eHQWaey73PZNzE1s7jM0gAzjq5gCUe6UtJPV5sZOhhxVpuris/7F4DUI5iOFwTkTJwgRELvAmaRlnTi0Jrga1PPe8Gq0QPWtvTi4fC6IpdD5gGZ3IsgsGw+vtyuf/zeCkfcUHgRYpAG5tCtxM+6eXy/36fV3qjf6OgaJ+t+h6rmoKGsU6paOgiNRlms2gsNaRj3Z9GrEo0NaU4bxIhn/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6179.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 14:26:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 14:26:58 +0000
Message-ID: <d2a3eade-bf08-4a7c-9d61-797c8946e46c@siemens.com>
Date: Fri, 22 Sep 2023 16:26:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] kas-cip.yml: Update Isar revision
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230922122322.3657-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230922122322.3657-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0018.namprd18.prod.outlook.com
 (2603:10b6:610:4f::28) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d4f51bd-576d-4992-234a-08dbbb77fa8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	B7e4V5QRw7LU69Hcp9TSCNAQ5DpLChHe2KzROUqfuLKgAdl9H8vWY1pWCANVQlB7GTWPR2Tw7cg+BxsuqAUt+zOCQ4P145pWDumMr8GS5fEsq9d527u5wV7qt2hXwODWxBiYpoE3XVtqFgmXRZHV0JuaPz89KUSNQ/dKr40eHR/SJe6Ip406OO7HZ5fg4cP91SplgQmuMcC/NX1VU79aDtBstLtU3oiFx0/dpEOeEFpAqg6wUjunVhuJkmGvCAdIlwvCTVT0mPtagRVbOyq7xe4i2ATxGpojf+TiPbvwZaGspGosRs5c/BiwcQ8+lU3bgR78URZHBlbxcY13KhCdJaUdI5vm33CoG+3RfYJSG7NrZBd1FjI3fsbIcSoEBIwt5kJL9z3YYlFbokbKGu7opPnqLQiLHq9Ico82WCt7zqZl4y4FBc9KgzurKOh3Pa4smQ39plgE7sPYTinF4tf1sEeHrfl45Btv2OoHFDP51fYkOH7m7maP+LtVtRQnd7tMLfRgtsLv5QcUG9Ra1IIptv8x7ULjfrLGvWkKClhp0AbtyUX9psv3WUblAQr5Tafdru1Gfm3m6n+GDwRnDfLKKyvE7YEcpYEVIlMaqwQhLYIJEb7CMuWXijKknqWlygvMSYLWE7Bq8DPQtm4+FgRZQYAMcAeM7R3AVvxsTlB/Jd1DDWWgf0WVwX/d2XRBe/oT
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199024)(186009)(1800799009)(31686004)(6506007)(6486002)(53546011)(38100700002)(36756003)(86362001)(31696002)(82960400001)(26005)(2906002)(4744005)(8676002)(478600001)(6512007)(966005)(83380400001)(2616005)(8936002)(5660300002)(41300700001)(44832011)(66556008)(4326008)(66476007)(66946007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VG1HZngvbXBxNEd3eXpjR1ZBTkFMN28zMiswYjJTRERjKy9hdXFwVVpjbnNX?=
 =?utf-8?B?MjQwbWVWbzQ0SkVnazlBckhacWRQa0xRWk5hcmltOW4wb0h1TktqZFV1QU4r?=
 =?utf-8?B?M2lZQTc4eDEvUFN6OGYvNFZNZllUa2FvakI5N1lBUjZoQnB4UnJkcCtKcW9G?=
 =?utf-8?B?UnhZenI2WTlybExGS3RMVWZwM24xZDQzeTUzcFRpS1pjd0QrN1N5SlBuNlhi?=
 =?utf-8?B?WlpPNGFnRjFtRzZxaHAxdzl5K243VEc0RWNlYm01TFN2TTAzRzZqOHoybkxZ?=
 =?utf-8?B?L1VzZnp5UTgvN2pIK05IQ29jQnl1TCt4NFdHR3lSL0Z2Nm45U0Z2bVliRmt0?=
 =?utf-8?B?MnlNNXZPc1UvVVJlVk1TalV4ZWZjeWJLeW5pRFhuSnpqTVFrK1FQU2dwaHA0?=
 =?utf-8?B?Y1F2bC9hQWhIQ3l2cmdUdGtBVi9wbTdJZHIrSzVUZXFYa2NRc1Bxb3BLcXcr?=
 =?utf-8?B?S2k1ZnJFU3IxZ3cwQU44WGo4SFR1QVdKSEZZRVdLeEZNaVprZzFCeFJZMHAv?=
 =?utf-8?B?ZzkzTDlacDFKMVNLTzUya0JOVituUDRNRzA0WjI4bk1scUxyYUEzN1pIamdW?=
 =?utf-8?B?bFhkZEZXS3I4S0V4SGFWcFJGM21HaVhQMTliQm42WWN4TWxJbnFSM1hIdnNw?=
 =?utf-8?B?eHhrcjI1aEJ6VkFpWUJnMGkxYUlJMk5NV3Jsb04xNzV6WFIwR1pXZGhkU0dk?=
 =?utf-8?B?ZEZ4emFOSHp3RDBqaU1mZC9PT20xY3dGdHFPTElQcGl3V051OXRtbmRGT2lS?=
 =?utf-8?B?M0dFR1dXYTdpZmtVOVpadmxJZGlKWExzVlYyZG5KdVhqY1g1dTJOYlA1ODhE?=
 =?utf-8?B?U1JGcUVmWlAxSWw3U0IzQ1pZREhOLzgxd0p5R3JrYVlWdXdOcE45a0t6QXVr?=
 =?utf-8?B?bGM5ZVBscU5QRmRaeENtVFBwcHVVRjFVR1NLSW9qc2k1ekNMRjg0L29CYU5l?=
 =?utf-8?B?aHBlWHlCMEg0UDNhM21IejQ2aUEyd3N2bm5PMXJtTUx1MFpNcWlpTmRlSVNv?=
 =?utf-8?B?Rzk1TkhuRHBaaUtvZWI5QWZUS2ExbDBQZlByVmRQREZ3OFA3eFUreTE2MUFn?=
 =?utf-8?B?NnVjU1lJZWQ3S2VkMmZqdnA2U1BZZTJCem9XQmtSM2Y3blU3UXd3SXY0L2F5?=
 =?utf-8?B?Slg5R3NSRnRPNlVqV3lPSzFMSzdiN1BxVlVEb2ZORjl3c3BVUUpuanRpbURx?=
 =?utf-8?B?NDFMd3VRcVpKV0NLSEZ4cTF5VU1wMkJUbXYwWHZGZ09MMzQ5UkQvYzJsc2Zt?=
 =?utf-8?B?RlBzUWZMVU50MXd6N3ZiMU1QaE96dzB5ZlM0ZkVzUHBDSFlkRUY2SmJkbmtK?=
 =?utf-8?B?emRScGFSR2JBY0hGMFk5N3AyZlpVdVBGZ3pQa0tmRHg2TUcweXFoSGU4Y21Y?=
 =?utf-8?B?MHRZR1Z2NWdaWU5rZzBsUkczOSt3Z1VyVFgrUUVmcVU2RkwxTGFia29YSU8w?=
 =?utf-8?B?em1IandKb2tLUGtTdDZ1WTVheUJpQk1vQ2t2N2dTdzFDemp5MnZyTkEvRThv?=
 =?utf-8?B?SVZzbFhWRnJqL2o4bXZIeWQ1dXVqRWVYSWgvcVVWdm9oSnlhbjg5czFTZ051?=
 =?utf-8?B?UU0yR0NJVk8vYVN4c3J2UzNucXVJaXZSdUh3aGFHcUprcWhUZkhlVG1LcTZj?=
 =?utf-8?B?VEwwWXFWanA5eHVJa2x0L1VQYmJIaUhuc2MrVm0vYWtPcjJVUDB0eW1GNjNt?=
 =?utf-8?B?SlhTRWRGVUx4NDNDelNEZXZPOUhRTkx1a1d0ZnBhcE9rK04xaVFDdWFId0pa?=
 =?utf-8?B?OHZvaEZKc24rM245ckV6bUk2RC9RV1BQNmVaQXpMVVNDU3p6RzN1Mnd3MFhh?=
 =?utf-8?B?b2xLME1EYVNWa0o4cDVPam9yTUk4dlg0YkhWa3BIUGlyOG1RbTZDRWFWeEE0?=
 =?utf-8?B?NjBGSDJWRVI1RVJFa3p6NXUrLzRWK1dwUkZaK29JZlZ2VEVpZm9hMVAwbWhn?=
 =?utf-8?B?dEZMNzlhczBudGQzN3JKYWpMOG93dlg5Y1lMUEJsNUVzWjRKRE55TnU5ejlO?=
 =?utf-8?B?UGlEZjVVMDJoT1o0aTl6VVpXbFhYbGxtODkzbUxBRG9RMHdheDBFNTBQSVdK?=
 =?utf-8?B?REU4K1RTUlVGTCtFejBlMVRsaGFob1FBNWVpRDl4Z3diSmNnMnljZDdwZG5s?=
 =?utf-8?B?QTRGNW9kRjNJRTZQTnVaQjdyWENSRlRKK2VWV0tnMUxpamhtSnBmelpuNDhv?=
 =?utf-8?B?M2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4f51bd-576d-4992-234a-08dbbb77fa8d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 14:26:58.4192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+vEocHDlRaDK2owfNearWsGOH1yPPe6HHU9YDXeD/mhT/UhycJB2C5Tj5ZQC6SmxJg6ToAoS/Vk2Om3XD+vuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6179
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Sep 2023 14:27:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13212

On 22.09.23 14:23, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> Brings following reproducible fixes
>  - Remove core files generated in rootfs
>  - clean blkid cache files
> 
> and some minor fixes.
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  kas-cip.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kas-cip.yml b/kas-cip.yml
> index 59d7ac2..a9f3897 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -22,7 +22,7 @@ repos:
>  
>    isar:
>      url: https://github.com/ilbers/isar.git
> -    commit: 478f3c324f50eca0d082cd1c8f23ef50e28071fb
> +    commit: bf9c9fdd99bf26dca25fdf9e63b7eb5b053d962f
>      layers:
>        meta:
>  

Thanks, applied.

Jan
-- 
Siemens AG, Technology
Linux Expert Center


