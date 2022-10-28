Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F1AC38A02
	for <webhook@archiver.kernel.org>; Fri, 28 Oct 2022 19:10:43 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.76])
 by mx.groups.io with SMTP id smtpd.web12.744.1666984242184743085
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Oct 2022 12:10:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Nqolu4m7;
 spf=pass (domain: siemens.com, ip: 40.107.21.76, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJYub1GXARActiUBKy1itWOMeB6Lk0DW3U/mj/S5npcCjUpXB/qOFmMdJKTtUbo9AYXBW6wl5DaJtfODgJGIFDJGgLKYTjw0+xgSZ00gv2f2eTmdTNEOfkhtcRV/8aVvDEAvcrRWfPlj9PUrs50hKefnh6yd4zcp3ib8RzVA51hm++Dj8a5LRivF3/NJsyVayXydHiZf3bg9uTglDEE/OH0B+6M1t3YM5W4Gi6vXSBqhIgfM8J3Bcs6r5GA8rk1kpkvk3JrWxEcGtFMgucQA0eVmy8d1IiyiszJn6Oso/xhZ3xOu6avCi4XDS3OIh0FOSeVgRH/aeH8xKDuLm+U7ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7pCXiwnogRnqQfwPtjqBtHSckjndsytB52Ma2WyCSc=;
 b=SvrGYgnz3XJgHz9CqJuKG+foER91IEm7iowvVsOw5Pu1apQKv8vCBM3nVcf8LJtvPCw/k1f+aTxhA0g/qnzUoJaU7wOGH56cBRpw25SUoBP7vIGUzhZ2mjszd5or/c7W66qqMhhtz8V9p2eiQY4314CU03qyEIW639TDyMPwBbqrKus40Hk8tmH2X2OikKfpkDMNfhMCBToYOFM8irA2rBSJp9b6L7l6AWQRJ9gXpSqzW+mKyFJZJ7FBorwQLnjb/aPny8xS6M6O0BbGPNjIig4Z/35i2RBo3AbXHVKRLOvmWXcvf5CA2rPXlAGAPE1CHye132S7RMRLT2y7O43fow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7pCXiwnogRnqQfwPtjqBtHSckjndsytB52Ma2WyCSc=;
 b=Nqolu4m7nV/4bDYgwgPT2mY3rEsLJUWTGdvCI0QqzSz3IwJljQomztuskgD63bgcLLvfP2tCH2oy/Zinc+mNWidKNzP2JrG/034R3YMIBs7R7M1xM7ScUUJaRIQpChvPGaymsneUm2g9yLATO1plfANANCxSrcLD/m2YkCMXFCY+YxXTzowTVTSBsf6xfVJzsy0xpy8X+6uQNGLbwizKJ3ftBIw3Qic7WdMgABZbbLrAFJaAv7qVBKJTgApbKdSpYXlstAfvBV5QJyMw4zmbaeMXnrk+zg/cIACExJllUjh1HnIk7la243iJsac9/xcDoA/IaxuYub7upaoNFbEH3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3538.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:158::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 19:10:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4f98:4e25:cba5:cf58]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4f98:4e25:cba5:cf58%7]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 19:10:33 +0000
Message-ID: <cb3d8633-851f-0601-3d02-bfcdfc80307c@siemens.com>
Date: Fri, 28 Oct 2022 21:10:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [isar-cip-core][PATCH 5/8] add recipe for trusted firmware a qemu
 arm64
Content-Language: en-US
To: "Schultschik, Sven (DI PA DCP R&D 2)" <sven.schultschik@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20221024122725.383791-1-sven.schultschik@siemens.com>
 <20221024122725.383791-6-sven.schultschik@siemens.com>
 <22a6890a-c594-77a6-13b8-a74abe668186@siemens.com>
 <PAXPR10MB50373F30697CFEDFA3CD5C0290329@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <PAXPR10MB50373F30697CFEDFA3CD5C0290329@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3538:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ebc4c0a-ec24-4627-04b3-08dab9181673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	g6FHagLsMwzh2T+GVpCyClQGavM35PCxqWK+17yuRevs1oJHBTI2myBQ2z80X6uauaeeJdHryANlNuiTHFaRsdsn90dlvzFg8UfYGhhXuCUgJ6p8dIuq/lLgsn3Sge2eNyXcnmVOVhqfehPBVQw+EjbaoV7IejRUcOudygrKIizfm40R7A3XEzE8lKFgCed24DtA0BEVv/coIqm31pIEBBtc4WUD4JT4vgYU2yWYCDFcNwLidwhQVetsIHvKEKjIXMYEDZElXq7mLvu7Kpt6jbr488vu3MyFVW9jD+tP2RfIosqfeW9HrJNevsAO9WKRLofmvEUosWl+79oCWQQ/8ZVyqnzijuh9GKWmctMr6jfWqDtCMmidgCewlI4RWFDn7td98NDnBOEMcoIKkxOKg3dWG57xKkHedj+KNoGMI78mcYcyILk/3PYKYnMqB5pcBQ+VDi0Ukf8ZxuP+2yQW1/fgA3PO+/HxF7CooWxq1HgsIgjGXuzxrVcf0nSeK3CwHKT1ukMk+erpnQZw/39oY5aKoMJXQHMuVU9vMkH5sq4ug8Igca+0+sRgZc0H4TUFpHxbPgOTbB2JJtFyTzqQJ0IP1j7ZvDhRNUAEZbucIa24B7WjmnMXt78XHPZnuRv+ikTUgGuZXgtmO7WgEF5BO+7/bsY0ZOKHJtuIgWZH2YmUQntfcbXDA2ys3l4gVDQcmc0jyhdhOOazWH4JZaGt7+YZ0sgWClPFCp+F12GTReBKcxVPH8grOBQmtmdPQ17gerb+LWXxCqKgXWS7vGRh36qAuRB36ho9jUeeNX5i9vO2LwN8qr8hYyYdNz7uRGRFt2XG90x4oup4aeXEcHhdTA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199015)(86362001)(31696002)(36756003)(31686004)(82960400001)(38100700002)(2906002)(186003)(44832011)(478600001)(6506007)(26005)(2616005)(6512007)(53546011)(110136005)(966005)(6486002)(66946007)(4744005)(66476007)(316002)(8676002)(5660300002)(41300700001)(8936002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d2d0K3BNTXpma3NkK0pkbXEvQVVXeWRmWmJhRGVQSVNqUWMvMVljYk54YTVK?=
 =?utf-8?B?eC9JRnFodTZDZFdlWDE1MStRUE1yVElNMnpmeXlzZUJZbWR4M3YxK2RPa1Mx?=
 =?utf-8?B?WVpxcEhPWXkrQ3B3cENSb1N4WkNzOWVSVENudnF2VnJQdUwzb2k4Y1FoMFZP?=
 =?utf-8?B?QUJLL3RCM1NQcVdhS2pGOEJ6Qy90QjNnUXMyQ1FkRFJ0OVgvbHF2RUlYMUFq?=
 =?utf-8?B?VVd3VFdwejFYa2J1Rk5MNWpaRTJQbGEwcVVDRWtqMmNBSXovbkxLYmRqT0x4?=
 =?utf-8?B?OTNTTnlvcFZDckR2cktLWFBqYkc0RFhpUXIzRjRWWTViRzFrbHlFRzEyeW1P?=
 =?utf-8?B?WTNuYXdGT0RISFE5eGhRbk55RDlkenp0dmVnTlhSaVg3R3Y5YnUyZXB3YWJw?=
 =?utf-8?B?Tlk4QzJ2bUdlVmdFUWFrRkZQeG9OWFhOMHF6bG9JV3EwZVdQUzBQeUZvdEMz?=
 =?utf-8?B?Ny80aVZaN0F0Z05JdHRselJGVTEvMHFvazRiQi9aRUMyUS9nZ3M2UDVvVUp2?=
 =?utf-8?B?RHVYbkx4S1R4L2wyNjVES0VvSE5YYy81VjZ4ejhQL09JbW0zVjFDSmNocEN5?=
 =?utf-8?B?MGExVVdUaXpCNTJrdGJzVHhBMHJrbXVxVkwyWGxsV0U0bUJHaEpnZXp1UkU4?=
 =?utf-8?B?dmQvbnVaSXZpNGNkWnpEbVQ0ZU4vRjA5cFJHVHNBZGVrK2dGNHhsTWx5K1h5?=
 =?utf-8?B?UVlma3JuRXlCR2lXN0ZKSHh4TGgrVkFRYnlNVWtvNS9jcnhLNUNyMkpnN3lZ?=
 =?utf-8?B?VlVGbnVoUHpJU2hLUFl0T2czRG5oZnlmWm5HRnVpZUt0MTZ6amhFaWlUTzhY?=
 =?utf-8?B?aS9aTExrcGswcW1RTEdrSjZibjdQalhGQ2RpZEsrTFE3ZVlRY0FhK0srWmo1?=
 =?utf-8?B?cGtaTVFhdERtclduWWpadnJ1RHY2VkI4bjJzTG5sMW03L2JDZGJoZVR5Q1Z6?=
 =?utf-8?B?TjFudUwzVEdVZHluQXNNbmt1ak1tVEU1UitFb1V6UFN6ZmorSWEwZlN0aUY1?=
 =?utf-8?B?ZUNWT2FDTlF0OVk2NjlaRUszcyt6aXBObFhaa3lYYmppSngyYUh5V29uYWhD?=
 =?utf-8?B?WThUWlk4Y0NLa01MdHM5MFN4K291ZnZDNU5lbUxYTTAwYi9FbGhzRUNTMjB2?=
 =?utf-8?B?VjE3V1lpbHRYSlpNZkVlVTQzQ011UHFSbGdPaGxtOWZkQkdZdjBWVXVUNDFL?=
 =?utf-8?B?cjZhaHFCdTdtMWdaR0VGUTNwOC9VNUw2ODJ3VjlwUTlHUVFVU3poczk3NFBQ?=
 =?utf-8?B?bG5yZ09nazJKVnRiWVZpQVMvWndMY1JpeTl5Y1dDdDZUQmpQbEZrbk5lWjVB?=
 =?utf-8?B?Z252b0YvTUpUQ3BmMTd4NHBxNmh6MEdtUyt1TzBNT2wyTWxLQ2lVZ0VzcnQr?=
 =?utf-8?B?MEZNMEJpVTFYOTVuZVlCYS95aE0wd2RnVmM2dVlrbFY2NFdrT2VmRlcyNmRZ?=
 =?utf-8?B?SjNtcmxMNEoray9wSEVIUmRpdWcvN2ZJSHZiRlE1M3VlNWhpa2dBVmIxMEEx?=
 =?utf-8?B?b2ZYQ0FKOFBPUjJUVm56ODF4MXdlOHZRS1VESXBBVHZNeXBuUmh2MDJaSytC?=
 =?utf-8?B?amdnbzk0OThKR3l1cHkwZkdrQ09uLzZCN0VRbWpGaU82R3ZqaEtPKzkrQzls?=
 =?utf-8?B?NGhEbXNUNGcxdU1LNmtsTlIrcmk3Qi9DYWdIMVN6OENwQjlHVWFKc1MyejhI?=
 =?utf-8?B?VU54TVNCOGRkOGRsUFN4cm1YQzJ0SS9RNnlmSzFCeW83bXpRb1QvbGtHRGcz?=
 =?utf-8?B?ZzBjRHFDNVVIeHdwUUFhQnNCdGRzTEhSOGpMMVlqaXVERnNCUEFOWjRDMVlx?=
 =?utf-8?B?dnpSV251KzJHb2wxTENBYXZsaEVWMG1RMi9IWnRkZ2ZNOHgvbWsrRkNRZWpz?=
 =?utf-8?B?U09SUUNYSkZCNkJPWktMOTJONzZpbFRENDNKWVZmZ2pwV2ZWVVpxQ3NKdDdN?=
 =?utf-8?B?aHJNM1c2Wk9NV05pVi9scWhiT0JUdnFnR05oQnNDb1kzMWw0RTJidDh6eWxQ?=
 =?utf-8?B?Y1lkV1dld0FIVVBwUWpSZlhpL1NVVlhlWmlkSndFYVlLWXpNblVQZGdVZ3pq?=
 =?utf-8?B?WitoUnNRWE01ZGFzdERXeE11VnpxWjRzTVZTb1ZHUnBHZEZIL1RaalVlUnpx?=
 =?utf-8?B?cWU3VlpaS3dvRkM5T05vZ2M0amRVNGh2OEx0bFFoUm4xL3gwSXo0NDUyUWJ2?=
 =?utf-8?B?WVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebc4c0a-ec24-4627-04b3-08dab9181673
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 19:10:33.4586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwjfiPLautIGp0IHEBAno7gJXy6qkbAgcN5W0BDDMrpsH2HiR1gb7puvS+Pz08p3TOOpG4x4JRgJaht46Hww8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3538
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Oct 2022 19:10:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9893

On 28.10.22 17:46, Schultschik, Sven (DI PA DCP R&D 2) wrote:
> 
> 
>>> +SRC_URI += " \
>>> +            git://review.trustedfirmware.org/TF-A/trusted-firmware-
>> a;branch=master;protocol=https;destsuffix=git;rev=v${PV} "
>>
>> Better pull the release tarball, see e.g.
>>
> 
> Pulling now from
> https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/snapshot/trusted
> -firmware-a-${PV}.tar.gz
> 
>>
>> BTW, why 2.7.0? Latest is 3.19.
> 
> Where do you see a 3.19? All I can find is a 2.7
> 

Oh, sorry, I confused optee and tf-a.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


