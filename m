Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59EFC02198
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 11:00:18 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.42])
 by mx.groups.io with SMTP id smtpd.web10.18467.1739530809026436442
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Feb 2025 03:00:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=v2DJhvZ1;
 spf=pass (domain: siemens.com, ip: 40.107.20.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjjRdOx3kIyT7Y1qEpI0swkbgC+p1pRcHykzOxy5zdhYRAYYnVuiba2CfRWKy5fg5TWBnorrZeYGbBNFWH80yFau0rUtDSfrT0sDs45B9oQpCuNzqOUWi+fo2ySWIZlVEADlcmdCcNxU91D24l+E66c/vApWDJODnfT2a1vAIYowBm+/qk7Az/G1U9iBTDJcWaYQEuLosBPpoosSJ5L0Qir1NGwjAmowO24+PTc3rQPMYbCbIcQ03osl6o4xs4lr3hxrpDEaRRV+vyo1wNNeV6eLirNYqGuYq1K3fGzqqeYR7SVEqpE4FuIS6BTh93b3vIgfwkAM3H9Rs5kWK1i/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFeViKKwguDDJ0PfAatuhpDcsrR4BQnWzh4Q7ioruYQ=;
 b=u91sTO51vHGGjWWjbw1XPMVfTJ58uMneVdw2MRKMQDLTZ4hG5AguNiE3lvlq2IgQh4wlPC5N50uoI9dG2KBInMKDR2z4VM370I47c9qi1qBt2lE8fndhjgRc0wM+wj2yUoKexJyPTYBABWUzbmFv4OvusS6EzjdbZl2kJb7CFo8ibu6aAVIgwSMx+RkkCq1jQcsjNnDILcNk0qQaB8YTnxt4vP8WusIDtdkCG4gWFWf1dIVhgGnLcPyZAaMPdXOMMHpS6ypMA8PXMhPyrh6Gy9E/lj2RLRGSBgqQD39+KgOvZtEjIhZWWcv6FOzHFOfDwC8Lrd4OuIiVsI/ShCVhTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFeViKKwguDDJ0PfAatuhpDcsrR4BQnWzh4Q7ioruYQ=;
 b=v2DJhvZ1St4bocaNUHJq/5oUtMHHF+MUVbNZuNMb5GKmefaylBLUdldarM+WCvrLUM2n3eauNAZqXrzxhdQfFjUpucinCoPnXeau9Kq1wbBSv52Ty9Pvp5so/F+Ohx1WeiMkXUgiZN1lUEHhHU6nzzGAdINJlgXfGQVlZBTcvnGJJ+YNGQ/Wch/4vddbtbxwzNCJFuoOePKXjr3hf9knaIQ6uQ/l3D5xGyBUswTFYm4wYVqkk1eHxvndyZWCz7JCdG+BhSeguck1H+5AV61qcsR4DklTBVuTUVfinXzp1w6Diur2VzatAdHH7AqHUD6mqRpedZpYqYZ+TcawZzuIWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5931.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.10; Fri, 14 Feb
 2025 11:00:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 11:00:06 +0000
Message-ID: <929fd4d3-447b-40e7-8ecf-cc1a90255d90@siemens.com>
Date: Fri, 14 Feb 2025 12:00:05 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip96,
 4.19.325-cip117
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d7d5e4-ceab-422c-8bc2-08dd4ce6bd63
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?b2xCM28vQnU3VTVSMnBPamljMml1VVFHUFB4UDJXSkJoU1FUYnN4TXdnMFk0?=
 =?utf-8?B?dUVCL2RaZTFXSTFXbFIwVlFzR0QzL2d5cFVsYmdoUW5nMXFUa3p0a1VwZW1G?=
 =?utf-8?B?L3BKWnlqenFGU3oreU5WTzV5MGlwVnk0M3lqL3dUY3JwWjY3TSt3ZHhHQ2Jm?=
 =?utf-8?B?aTJlcEZzYS81cG40K3E0NmpOQjRtR1NLMnhCbVlFcTBwbTRLSTdTdmZFc3dK?=
 =?utf-8?B?aFlyU01JREFhWGZlOFk1c0hhaXdvaVhLMDdoWExMeURYdU1RNHVSazR4clI2?=
 =?utf-8?B?cnpXOGM1OStXUHhmYm9INXRLWk1JUDNlRmxnbkp0YmwyYnA4WGZ5Y0dkK0RC?=
 =?utf-8?B?VFhRMWNpL2l3bDRVdmxsZTNhbU0zRlpQeTZlQkxDY1dEOXVZdnJzZXpBZ0FY?=
 =?utf-8?B?ZUhGZ1pMVmNOZTBjckRhemFEYTM2R095Z1BMV3hGWEU0bUk3blFHTlFDbHV5?=
 =?utf-8?B?NG8vN1psQ0YwVDlOYnM5RG4zU0o2Y2YzdDU0OXF4VFYybVVWdStuVEdyT3FD?=
 =?utf-8?B?eE55ZXlIaFdwdW5PRlUzMVpYS2NtZ0QvMFBIU1NSQ0QzWEp3ZmxsQmRVYWdh?=
 =?utf-8?B?SUpBcmNUS2Y1VStaQWgvTWI4My9ndENXRm8zR2xUZXhLYWl4ZkVNZUQ1bllr?=
 =?utf-8?B?Tjg2bTFJZGhraXY1cjhPajh2eGJVMjVWckNOd2JFZ3dUNFpsUHkvV2MvdU5s?=
 =?utf-8?B?bTMxaTFLMXJCdzd1OUFYK0hmVCt0RmdOZGdDM0lheG80ZkU4Q2pyZ2FWVXBF?=
 =?utf-8?B?bXE0Tm44YUx1cS94RjN0ZmZ6WFp4dmdSSS9rdTdhazErc3NKMm1ZcGsvWmth?=
 =?utf-8?B?eTNZdS9SLzBkZTY4VzFLclJRSkFlRU1tb0wyeDBYWGF5Z0R0bHkvcnlmRGs3?=
 =?utf-8?B?UHk0eGlBVldzNXZwUzh2Unp5UkZOdC9SUEt6TVByRUR2c29GS0dLYVVIaHRK?=
 =?utf-8?B?ZVdNS1NUNGNSUlVaWUZGelV4YSt3dGp1aFlvTUVjbEF2ekR1bXhQeG0yRms3?=
 =?utf-8?B?VUwzbnEzNnFrYTI0YS9KQlVHS1VHR2VOT2twNU5jWGJINmhBMHRMU3ZNa2hs?=
 =?utf-8?B?R0RXTjFtSTA1L0Y1NDg4VGtETDZVcUlDS3Z4NGhXTVRTTXNvTDdjWjRHUGFk?=
 =?utf-8?B?NnpEVVptVVZQcjI3WnV1YUU0YlE5UG51L29ET3R6cXBMelBaRFdjRUJZdGh1?=
 =?utf-8?B?Y3htcmF3ZXF6K3Y3TElES0MxaS83eitjNjc2MDlxK3cvUjdCZkk2K3NqZGxF?=
 =?utf-8?B?eitLVncxc0s4VmFRRXZEQk54WjhMdS92a29PTC9UWTRjc0g3RUtubkNqU0Ev?=
 =?utf-8?B?bGRtS1FhL09uK1JQWFo3M0RiQW51bVJqVkVrKzVWSy83U05PUm1EVzVHTi8x?=
 =?utf-8?B?TjdHc1hJQUJVelA3dGhHZklDMU9ZcXF2aHlpMnVEZmFvQWlVek9BU3ZkMG5n?=
 =?utf-8?B?ZzVPTDg5cmY1WklPcDJJWXYxV2NVWEJ2UzUwKzh1UmxEYUhHSXpWTVc3Z0Np?=
 =?utf-8?B?Q2o2bWNNSEpWWGpnU1h2RDhrWWNHSlU0M290U1BEUFJFWWNXLzlzVmI4NjdQ?=
 =?utf-8?B?ZHQwWVFTY3lYRFpKQkhtZ0s1dlpHd2dBQUNNeTFsSThuREx1SXg4RGVla0pk?=
 =?utf-8?B?a3hEeCtuYlRLOVBrL0o1UGJydWZ0dVRSM0lGd2FNQzB2VWNDRENLNm5vT0lI?=
 =?utf-8?B?OStldlViQzVCVW5YbEdHR2FzRjhSMUVYUVRtMzh3ZjcrSlJvUTJPbStLYzdI?=
 =?utf-8?B?UGdnNkZ5eDA3SmxLeXR0L3M3SU9qSUM5WnV0Z0xFUXlPUlR6VWtRT0R0L0I5?=
 =?utf-8?B?RERzUGRjSWFscElNam9maXhrRzdXNUJNR1QvVWZMT095eVJWd0tyd1R1MXIz?=
 =?utf-8?Q?RfS+HqZ+D2lOK?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QUxVRDhWcW5EZS9sbm5sNURRVUVVK3lzODJRT2xBay8zdzNTVkptUUpJNUhU?=
 =?utf-8?B?Q3lnRFBXKzBkcmt6dStndVgrRWFpNENzRjhOWVU1ZGIrK243REJrSEo2UWEr?=
 =?utf-8?B?QVJVZXNTUVBnemp6SUJ1NEt4ZkkzTWljK3JEdEZwenNOa24zekg4V2pJdWJZ?=
 =?utf-8?B?OGExZXduRTFWaFVab1NSRGdGeUhrbjNFVGt1Yld0WHF4UjgzMG5VTEswVXpp?=
 =?utf-8?B?TDBDTHd1YUxEcFB1YjFpQjg3MkVrUXk2aXhVYk5LNUlXbzR3N1RsNktUcDZD?=
 =?utf-8?B?eUtsRzJwQ0ZJblZ2UUdENXFDREQyeWFIUkVVYmFTVmwrQ3ZsWlJNbXlISnIw?=
 =?utf-8?B?WjRFL3MrZXpSeU5HTldVdUloUFRRUU1SMWNZaHg5aGxmZXM4cVZLbWJFWlJ4?=
 =?utf-8?B?VXowbWZPZVEvWTBjRVVrWVRiMTlaMkRDeEM0eEVDUFlmTnRwdUlXSXY0a1Yr?=
 =?utf-8?B?T2l6VG9MNDE3ck4yZlRHQ1ZUMGYrWEVYWWs2RmNIQVZrTkxYLzExcXJ3eXhT?=
 =?utf-8?B?Nk9CYkMyQVAwR01lNlY0YTNqdG5zbWV4SVlYR2VUNit5M1p2YzlZZDlMaGha?=
 =?utf-8?B?ek5Pbjl3ODBqeVJNdXZNYnhBUmcyb2M1N1JybDRiV1l2VlJsR3ZEV1dIRmpX?=
 =?utf-8?B?SXNGb2gyU3RFU3AzT29IeE4rMm1JSS9BdFF3bDR1QVI5TE56ZEM1aW9UU1Rm?=
 =?utf-8?B?ZG5uSS9oSEVLTFkwVlVma1I1MDlvWTBDWGZzelJodkdUMkhxcFVoWW5LbnNR?=
 =?utf-8?B?V2VrYUxmZ0tLUlJ4L1BObFZ0QTdtT3FNNFV3SXRJSGxLR3ZpS3VMQkE1bElX?=
 =?utf-8?B?aW82Y1cxaWN6eGJ3bWwycWlWY2kxcTVpSmJiVzJ0SExiWG1RYjZMTWlweDJH?=
 =?utf-8?B?TFhrM1UvT0hZL3VIQlZyOHB1NE40czF2MHFHc2UyV082QWNwQ01oaHBoMThH?=
 =?utf-8?B?TFFmZnc5MEJEVEZjVGZjZnY5YXNSUnBDYkxlSmh0TGVVZUxKSm1EMVBpSEJp?=
 =?utf-8?B?NkVlUlNKS1lOc1ZLekhVeFVTVHFma0wwcEhTZ2Nmd1p6WDJRamlnRW0zcHN5?=
 =?utf-8?B?NWo2RDFmVUYrVmFmQ0l2L1VtOXZoTnRQK3BuaWhyNitnVWpVaGhSZ2F4VUR3?=
 =?utf-8?B?cU5ON3g0R3FDVVBBSXFpanllK25hL0Z1Wm5nbUNZemljVG41Y2RQNWErd3Y0?=
 =?utf-8?B?QUNDSzJCbUhmMzFKNXB0eC9jd3JkUTVSRkZjVS9TV0s3OVIxV3hlQlhoTjRP?=
 =?utf-8?B?aFFZLzJIZW5vV3lHV0QwRzZaOW1zT2F1QkRtSTBUZzk0NDA2bnlIMVlKZHZJ?=
 =?utf-8?B?RDRKLzFNZnUyN0NYd0lwWmtRZ0VzaEhSZTBQUzZ1TEZWcEdJWXhxSUMxZ2x6?=
 =?utf-8?B?MExHQzJWZHEzVFk2NmxEVURVNGdOZzlQVzQ2cDBQMHd0Mm9ycmlxTXRLZWdT?=
 =?utf-8?B?UDlIN1h6NFAwVTZlWElOSUFVSlF1ZFFhYVFhVWFFcVRoMzArTVBqQ1NINTNG?=
 =?utf-8?B?bDBiU2NmU0R1V0MxdjFCcU42T2Juc21jdERXZERtWTFqQlNkT2FsVFQ3YVRX?=
 =?utf-8?B?SWZaNnVTT0xueVpTcGNDSUU4ZDUyak9mdCtEUFVTeUFSc2I1OTBsSStRTys0?=
 =?utf-8?B?VVA5MmFEb3BOeVI1S01TYlJiWEFFNHlWNGJteVNxUk1pZjRlR1VWTXd0MjRP?=
 =?utf-8?B?M0NBZ3hsMm4yaW5ENTZQdVdsOWg0MXVHN1k1UDM5NnZCMDZ0MGVWbkJCSXIy?=
 =?utf-8?B?QWxnNVhsMWF6QUZYNlZQQUtueGRQRlJGTUtKd0N5dENRVWtLcUVJV0RlSlNh?=
 =?utf-8?B?RnE4cEl5a2JvKzNkWFg0dnZQSGhVVEhqckZGbXJVWEZpZFlXWnZCOWRhUDQ5?=
 =?utf-8?B?Nk5PQkJFc3VqUSswWFBGNlNXaTFvMy85NmRpRFExRFJwRmtxREgrUUkyT2Zs?=
 =?utf-8?B?TjBoVnRReXoxTElHNmVENjVNbTdaOUQ3dDBXQ0tUVzZVOFg3SFVDNVlNZDlF?=
 =?utf-8?B?SWlaRGhCNko3cTZtQTBDOGhrbDRXQStDa0EzWGZobHAzYlhaVDFMWExob05q?=
 =?utf-8?B?bmpQTkJWa3BFVGluUS9BMHFUUVcrZ3I4b2l3c0V5UXk2eUxTL1FCdDYrU21I?=
 =?utf-8?B?elY5MFlSMHR6WmJHZ21aY3pNM0xMSTJHWDhoRkh2Mk5aNUhMWDhzeWFMY2du?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d7d5e4-ceab-422c-8bc2-08dd4ce6bd63
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 11:00:06.1348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PG5qnH7V7DI/V6h5WK6BlDIm5ILI17P0bIOTgnOj61MwobS6CfCh+qsthXJJKSDIjYL5bGhNNLJ+PleN84DfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5931
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Feb 2025 11:00:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17840

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...inux-cip_4.19.325-cip116.bb => linux-cip_4.19.325-cip117.bb} | 2 +-
 .../{linux-cip_4.4.302-cip95.bb => linux-cip_4.4.302-cip96.bb}  | 2 +-
 ...{linux-cip_5.10.233-cip56.bb => linux-cip_5.10.234-cip57.bb} | 2 +-
 .../{linux-cip_6.1.127-cip36.bb => linux-cip_6.1.128-cip37.bb}  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-kernel/linux/{linux-cip_4.19.325-cip116.bb => linux-cip_4.19.325-cip117.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip95.bb => linux-cip_4.4.302-cip96.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.233-cip56.bb => linux-cip_5.10.234-cip57.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.127-cip36.bb => linux-cip_6.1.128-cip37.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip_4.19.325-cip116.bb b/recipes-kernel/linux/linux-cip_4.19.325-cip117.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.325-cip116.bb
rename to recipes-kernel/linux/linux-cip_4.19.325-cip117.bb
index db76ae0b..171c7bf7 100644
--- a/recipes-kernel/linux/linux-cip_4.19.325-cip116.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.325-cip117.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "d6088d5a4dc3bdc7b35fb2bd068ab8dd787100cc7993f9cf4a2d753cb5156ef1"
+SRC_URI[sha256sum] = "fa75887990a5bc0fc71da618dec4e3c07dd47ed70eb776bb8f0b06aa1ff4aa9b"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip95.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip96.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip95.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip96.bb
index 103e1a15..c12075c1 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip95.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip96.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "8df934b0880537edd458acf555f91632d972c00fa85075cc4e7a23a772646865"
+SRC_URI[sha256sum] = "d3e5cbbcb4c462fa8218efda7ba8f70bc7e3002ba5fe913d4a1418eff33ba14d"
diff --git a/recipes-kernel/linux/linux-cip_5.10.233-cip56.bb b/recipes-kernel/linux/linux-cip_5.10.234-cip57.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.233-cip56.bb
rename to recipes-kernel/linux/linux-cip_5.10.234-cip57.bb
index fdcb2c2c..9dfd96ed 100644
--- a/recipes-kernel/linux/linux-cip_5.10.233-cip56.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.234-cip57.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "5eaa1219d388ecdf57c4aa929337e50643692501b22ab12e054aa005051edd4f"
+SRC_URI[sha256sum] = "4127b9d2acedeaadcb6e8c205adbbac06fc2018aef132de9fc7b295298980858"
diff --git a/recipes-kernel/linux/linux-cip_6.1.127-cip36.bb b/recipes-kernel/linux/linux-cip_6.1.128-cip37.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.127-cip36.bb
rename to recipes-kernel/linux/linux-cip_6.1.128-cip37.bb
index a4f57e32..a94375f2 100644
--- a/recipes-kernel/linux/linux-cip_6.1.127-cip36.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.128-cip37.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "38598076cb7cc5e5574ad2def352145bcbb1cf454b20ed0f11a9916c77d5fd43"
+SRC_URI[sha256sum] = "e004ea3c448529639af4062ca25d519cdd543bfa56b031a58e9074861a9ac2c7"
-- 
2.43.0

