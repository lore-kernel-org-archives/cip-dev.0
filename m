Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2457C47BF2
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 14:08:40 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.70])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.90541.1767708516698771494
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 06:08:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kqwb6YTZ;
 spf=pass (domain: siemens.com, ip: 52.101.69.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NP3ksCIAFD2Wm/8b4Nr77N9/9QLjvLIdHBeqEhK4jhPRdhiWDUn9dOnPxB+fCHrTYdWXQY5jRc7zGeqEib9zORQ6JkpSoNbsDVwnUotNyx3zPwdG7Fy5NAeE8QteIj01wOcJxuCPzZojY5waX7pGRP13L9OqKpiYjgiXH/4JlRDwv31LNZsZbF5vTihdN44VbqEkGNRCJ/89LudaAzirr2hR9h8217p5I6v5eCcIUp36Q7uxQuGsKUcl9VBMKzaeA92xbBpEp5VSDLk0BsOIWjNoOHZax/G4rnB4aDDgWM6GF0qQFtNTc6BygQEHpx07VhgeZ28sAmMyJ4f52IOLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ym9AK2d1/Y9LWkqbebQ9VS+lKUqjdEPv2/srpYKx0LE=;
 b=Or1xtTxoPOetBBMAPY/L1d/Vu6NZH1IT+GsDXGRdteNofhD68L1yn3od0+NNt9VyBNgCH/oMSSqSPigTWOrhGUENP5s37z1+a3OjuWRxqHqkJRt9a8D5QfMf9QfO9HSCIiI82sLAPQbWnsfRWzY5FplNAI1v6l4YIHKgOi1dyeZx6jeyLE7QcLxbvh97wiVcxWxttLNAFl0jAjdGUc879Nw8HDl3gK6g1xp1KG4//tDFURmm/zTxpqcQujA2/4bkKX8/DQIQpdF5Ty/Tw8d3BqZHWb0AOWr5zdxJd+gpMFqVOVrS9433U15V+UVsKx1tM9J6rdCPj3L/0kOgn01Exg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ym9AK2d1/Y9LWkqbebQ9VS+lKUqjdEPv2/srpYKx0LE=;
 b=kqwb6YTZJjj0glbvdwHg4rNixvEACiR6G5K/WCzayJ2Gg2YTz5/oglskj/x/NdSiVuseMocCBNkq3F1LtB3wBxhx1UCvuAWSBB7Bzm4m1Zt4zYs7N9t/ZpCg3GpHW+vud9iOkuyYuY8D43zeTJCGoPU9HF5fzr+K+QGQ0JjUiRGoSfXSSOx7nwST8e7xpWFUQ7wxWHLY5rbFOi1ZUZsidnnJ82Qtckeunqn1xGAAaiHGqEku1UGbe6SvSuAm204ZEBt5ZiGOHZgpDVKjMz7xzDI/5x5GZe7U8zUApXo0NaEaDo3xzHRs7oBnOM9W9jKgHxgm3TPMwkn5hpJnoMzJyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7974.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:406::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 14:08:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 14:08:33 +0000
Message-ID: <bebb47e0-230f-4ef0-8439-a576cda865d2@siemens.com>
Date: Tue, 6 Jan 2026 15:08:32 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] u-boot arm: Disable problematic GRUB
 workaround
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 80828190-3892-4ece-bc26-08de4d2d13ac
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SWVaWGpIMkMwTzlKdFVjQUVnK0licU5VZWRRc2tueFJqbXl3MFNjbisxeThk?=
 =?utf-8?B?ZHVwVTJOblRab2pBN1ZyeTB5eDdOWnBSUUkxVXU1Mm1SbndGQ2VTQ2o3VC9B?=
 =?utf-8?B?REpZZ1plV0YwUklNM3dSK0psZWhvWTY0YlFVMVNIQ2cvaWIvODZMOFRTdFhL?=
 =?utf-8?B?WFk3dDJ1ekFUcWI1RmMrbXJnSmtDWUljM1VqUDlpYVg0ajRhUU1TbldpUDJr?=
 =?utf-8?B?TTFYT2d6YWZxZksySXFtVC9iM2V6bjB2bG9wckNRRTNYbC9seTVLVEptQkJu?=
 =?utf-8?B?V1dtK0taV3E3ZUF1c3I1VmJnak1ZL3JQekJvMHdVRmNiNHhyZFJDNFdUYlBo?=
 =?utf-8?B?R1BBMzdOVXM5STcxYmd5bllXMk9kc1pCSTNFWmo4MVNaTXJJWFNjVWFlWi9k?=
 =?utf-8?B?UzB5WmQwd3RKOEFudm1LNVgzT2J3WXI4SXp2QW1LY1hOTCt2eW9yRldQamFK?=
 =?utf-8?B?YVk2MTZoUytRQnR6VkRRbUc2eDFnSTNvT1FHT2VzNWVUQlkxcFVLWnNTQWhh?=
 =?utf-8?B?MWg5Y1JQMEdDeE9uMWhvZ3BsRkxZZ2xHYVR3aDRBc3ExNHNaTlNKcFhBbjYx?=
 =?utf-8?B?VVJ5NDFSSUdVNXkxVDh4ZER3THhVN1JaS2tmUWNUdE1ndXdvRWcrNXpMaTRy?=
 =?utf-8?B?aDRoYUZKSzRVNk5UYUxXYUZmUEpsZUZJRVpkVGpRekk0OTVNOTBkTEc1a2Vi?=
 =?utf-8?B?VVRiTHVuWVNKemh0MmdZV0p3SS9FNjYvRUttd2ZvbCtpd0V0SDRPK09zcGtP?=
 =?utf-8?B?V2dIWmVIeG00L0p5WnRjWFNJUVBNUFVKR0srMi91OVpWR1hveUF6N2pzUlZ0?=
 =?utf-8?B?SW5kNUZxSWxhZERmcGZVQ0NzZ3N2aU1RMmJTME8yaFpTUzdlK3E0YXp2YnlS?=
 =?utf-8?B?NEY5YmcwUVlLa2VEZnF6S0lsVUttUmhXZ1Q5R3FpbnY0RkZzamI0Y3RBZHpp?=
 =?utf-8?B?TlRGVWZRZ0lCQUhjYWs4ejAySGZCR3dZSVBmNDFuWjl4TTIwUmFhaE95Zm1Y?=
 =?utf-8?B?bDlZZEczbFVEWVdxWHVUQncvbTlIZkZmZ0FKT0M0NDRCalFhdDRnMFBrNkxY?=
 =?utf-8?B?YVJyK0xDUXNSemYvdmU4TnNSMnh4eFNWTHgwb2tyMk13UElZM09GU1VKZDM5?=
 =?utf-8?B?UVlSV2U0VnBxbjZ1Y21VdTM3T3pNaTdvcHdLN0w0Skp1NnA5VmIyK1NpLzRP?=
 =?utf-8?B?OHh1UFBjN2NUSlljZjIzTlZMMjJacjJUVW5ReFV3bjVvRElCcGdDNUFiRTBn?=
 =?utf-8?B?OWhRdnN4bFZSMW5xYlozR1M2MmU4dWZJQWZ3dHhtRjVBR28wQVVuMzB6S2hr?=
 =?utf-8?B?dlVDbWtmQ0hNM05zUy9UajNvcGxaTzFWeXlOaXlob2VRS0ZFTGhCeFptRlJZ?=
 =?utf-8?B?enlzMU0rVmpxVDc3YzZNbXIrRGZ6TGpiQXdZSkZHbFdvTjZCRWYwcTJ1NXQv?=
 =?utf-8?B?akxkR1B6SkwrdVlWZk5jZXlJcGZ6YVRLOHZqV2NBVW9qNW90RVNXNlYvQkV0?=
 =?utf-8?B?Sk9yV2FOaExhd3AxZnQwTnFuano4S1d4MVlVUlJtSU1pdzlIeHkwYkwxOHFC?=
 =?utf-8?B?UlZHaC9NSkFvanNaM1JmdlFxZ1hwVkNDeEpqc3NiQTZTRm9CZ0lNWlE5a3ZK?=
 =?utf-8?B?REdUdTNRYUhCV2ZEbmJiK0hxOVVvVXFTZkx5S09reGMwRDlJMFV2S3d6RGR4?=
 =?utf-8?B?cm9PRWdJdEdhd09EZXpZaHhYYmx6NHdac01BMUZuS2V2N1BjVU5ZR1hNbWY5?=
 =?utf-8?B?aGRhN3J4MllOcG5SYnFJMzJqaktveE85V2cwMVJtbSs3SzNETnR0V01JWlAz?=
 =?utf-8?B?OSs5Vno0WVVURVBRMlRIOUowcGZRdkZlczNiblFBaC9NeWFET2pDV1Z2VndR?=
 =?utf-8?B?TEpIQUhHRU5HbkJkbHlCOGo3cXBEbWgyNXZ0K1E4aEZFWmNJN3JjeEl3REhK?=
 =?utf-8?Q?BPZQ2tbUe6p94fV3zHxzzcXV2vB7lJTD?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QUk2MXJGWlBCbjBMU1AxcTRrYitwdmdXdklGSjhpaUMzS1hGWmN6K2VOVXl3?=
 =?utf-8?B?VXNUcktjMXI3UnI4MGV2c1lheHN1R2lRMjFBbEM1dzNDSStrOEZnZTUwZ2k4?=
 =?utf-8?B?QVRoV3dDd21ocnFOVmRSMThkTVVqWjVrYitidWh2NFRzaDExYURldGkxOVB3?=
 =?utf-8?B?MmowZnBTN0tnRWJ5dkxlK2YwdDFPbnFYWmRmS2ptRnFTRjZPS09kQWtWWDJD?=
 =?utf-8?B?OXhZNjRvZFA5QXc5WDF3dHNVZG5JdkZ0bnQ3QTF1bG9PenVFU0pIeFpOaUIr?=
 =?utf-8?B?Wkpma1E5NUU0K0YyRnAyd3puZWoxVHJteFljRWdTc2pkVEN0ZjBxL1lOaEJa?=
 =?utf-8?B?d21zcnpwbmgwcjA0L01ST1YwWjhkM1B4enQ4eFV6TnVTOXdvVUxENG1CNUI5?=
 =?utf-8?B?U1JHVHBuNk8wOTQ4SEkrYXYraERyOHhBQUYrR3lyeGRIOXpVMzRlcklBM2J3?=
 =?utf-8?B?ZGxaZVkya1g0NWJtOXZRbUc1cHlBVnY1MVdBV1NjME44NGo4Y2FSc2RlWC9Q?=
 =?utf-8?B?aWZtODQyVUV0QWRkNm9YMEdqVDU5MEtpaEFKZng1QUFtcDZYVXlHOUR1aCto?=
 =?utf-8?B?U1o1ZS9yUXBCNVpwbklpQVZKM3FxcWtBekRmVllRVDBQbUs1RDNVb3FkSHBo?=
 =?utf-8?B?dEhRZ2Q0OUxYVWNDczgyTzA5cXFUVDdKcXNGVDVzNlhYN2FtWU9mdk94cGRv?=
 =?utf-8?B?SGhkWDhkSXlzNHdtampoR0JoNFVVVXVUT0lhdDQ3bnR4Z1V1YUc3L2J5ZWtG?=
 =?utf-8?B?ZXNQdk5pMnNzbTZFbW1yVkwyT3hyVEJ6Z3RCQ0Rvc0xxeTA5MklSUzBuOTNk?=
 =?utf-8?B?TWNNN0RnMVY0TzFQcDhzNVE0UjMrbU1IbVdUL1hvUFFQRFpCQ1lYUmRGR1VB?=
 =?utf-8?B?VEdKTFoyWmlzUkhRdDFYZWdSYWhzN296MVRlaXJHQ0N5OGNnaDB6djBtbkhX?=
 =?utf-8?B?VkpwY2hwTkkrU2RtUW5ZMVNwS0RqbGEwOFQxdEk0aWhyT21KZ3JVUHlYeFpx?=
 =?utf-8?B?VDd3cmd6NDlscENhaEJBSGh0Vit0S1prblhydVpQWjdYVWxUVFhyUXVFUDkw?=
 =?utf-8?B?eVNVUFFVUWN4ajFPUGlEVDA2WXVvMytEM3pNOEhZU3lhM1pGMnJoVDZjVDVS?=
 =?utf-8?B?YjBoZ0VrWkdTOEtUd3ZrRnJDRzlvbUUwRWNVVWVCRGZySnp3RmxJWHUwMkpk?=
 =?utf-8?B?VDVVWUZFT2dGODkwWjNPUExpb1hVckRZQnVLQ0ZkUDZDOHZLdkhVNHRHMTZ4?=
 =?utf-8?B?QXFZVGpHZzJ2Nk9CYUVhd3puU3BPaGZ2RHFEOGp3ZGd6WFo4M04zRXhFdk9U?=
 =?utf-8?B?N3NOU3VlYXo0VDJhK3BNSE9BYTlna0phTk93MDgwU2NZazJoUEVQdENlNDM4?=
 =?utf-8?B?OFNkWTU1dmN5QlVKQk1xRWZsUEJxd1RTN05OYUFPNDdjQldQQjdMQVRPVHl2?=
 =?utf-8?B?MktuaWQvNkNkbHV3YWFqWlFPM1ErV3lGVzNuMENYc09mdWQxQUtKc3JtL203?=
 =?utf-8?B?N1kzeHErYTZrUFRtd09FSU80NllWU0NEd0hPTWVTb1R6am1XSzJvTXYzOGpi?=
 =?utf-8?B?N3hNaFJUdE9rVjl5WjFuK2Z1c1FJRmV4ZEk2R2JLMU43NVh1bk55MHVIaWJo?=
 =?utf-8?B?TkhDTnZiQzlLaXhRZXVHR3hNcXdib0RJZnUyaDV2Smc4YU92THpGZ1hxRWlv?=
 =?utf-8?B?ekhpY0l1OEJIRHNIbmp6R2JQWWtkTzZOdHNHTHJ2Y3BPbWdIb3I0UEFwSFNN?=
 =?utf-8?B?L1c5QzVCZzdna2lhVG1jbW9zclRDa2FGeVNZQy8reDBzeEZ1ZHZWaTJjTm5w?=
 =?utf-8?B?WmRteW04YnFyZ29QY3RiSS9PbUwxT3psOUFDYUw0RTFVV3RQUkJoRHVvR1Jy?=
 =?utf-8?B?MW5mZ2xCbXBDSW56YjNKZm8xdnRjZ2RvRURqV1IveERrODRMcnU2dGNWVEcx?=
 =?utf-8?B?eVpJcHRFeEllbzRTT25Cb2Joc0l4UnpYL2d4V1JqWms5RTh5Y0xzVks1M0Fa?=
 =?utf-8?B?WG5vWCtyRitYSzVRM1R4dmNLWGpXak9UWkZySlVETGs2VVFNM01uQ3hYcE5K?=
 =?utf-8?B?Z2cvd0JNQjYwT1hxQzlaNDZGQi9IRDZCWnBsRjU0cElFZi96UzZPK05nNWEy?=
 =?utf-8?B?Y1VoYURHZk5vT3Z6RlNveTNDWmU3cWxMeUZ5SHQvemtVNUoxbFFyUUdtU0lT?=
 =?utf-8?B?emlkNkxhSVNOQ215SS9sSDBBOW1qaTFreUtWY0ZrTjR0ald2bkZkK2lEdHJO?=
 =?utf-8?B?cktWRmMwcFRaWUsxYWhLVitVcnBhM1A4d0ZrRDF0cVhjaVNsRnBCVkRnakY1?=
 =?utf-8?B?Z2prL0RpTHZlSnFKQXhrVmkxU1BtN1ZkT0x0MmhqQUVXcDlJVUFGQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80828190-3892-4ece-bc26-08de4d2d13ac
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 14:08:33.3206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dC36lgqdybOVqQDIDF6A0PmW0y8MgtuRIwrwC2rgqoEMSF+xqEL04wpsLJ1STrhQZaRn4HGZ8ciIHL1Wy2eDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7974
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 14:08:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21386

From: Jan Kiszka <jan.kiszka@siemens.com>

This is on by default in U-Boot when building for arm32. We are not
using GRUB, we should never use it, the workaround delays the boot by
several seconds, and it even started to break the boot of the BBB with
kernel 6.1 and older since we switched to the merged defconfig. So, get
rid of it.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This still needs validation on the DE0-Nano-SoC.

 recipes-bsp/u-boot/files/no-grub-workaround.cfg | 2 ++
 recipes-bsp/u-boot/u-boot-common-2025.07.inc    | 8 ++++++++
 2 files changed, 10 insertions(+)
 create mode 100644 recipes-bsp/u-boot/files/no-grub-workaround.cfg

diff --git a/recipes-bsp/u-boot/files/no-grub-workaround.cfg b/recipes-bsp/u-boot/files/no-grub-workaround.cfg
new file mode 100644
index 00000000..dc09edd6
--- /dev/null
+++ b/recipes-bsp/u-boot/files/no-grub-workaround.cfg
@@ -0,0 +1,2 @@
+### Disable grub workaround
+# CONFIG_EFI_GRUB_ARM32_WORKAROUND is not set
diff --git a/recipes-bsp/u-boot/u-boot-common-2025.07.inc b/recipes-bsp/u-boot/u-boot-common-2025.07.inc
index ed44bad0..2318e033 100644
--- a/recipes-bsp/u-boot/u-boot-common-2025.07.inc
+++ b/recipes-bsp/u-boot/u-boot-common-2025.07.inc
@@ -28,6 +28,9 @@ SRC_URI += " \
     file://rules.tmpl;subdir=debian"
 SRC_URI[sha256sum] = "0f933f6c5a426895bf306e93e6ac53c60870e4b54cda56d95211bec99e63bec7"
 
+SRC_URI:append:armhf = " \
+    file://no-grub-workaround.cfg"
+
 SRC_URI:append:ftpm-stmm = " \
     file://ftpm-stmm.cfg"
 
@@ -54,6 +57,11 @@ SECURE_BOOT_DEPENDS:ftpm-stmm = ""
 DEBIAN_BUILD_DEPENDS:append:secureboot = "${SECURE_BOOT_BUILD_DEPENDS}"
 DEPENDS:append:secureboot = "${SECURE_BOOT_DEPENDS}"
 
+do_prepare_build:append:armhf() {
+    sed -ni '/### Disable grub workaround/q;p' ${S}/configs/${U_BOOT_CONFIG}
+    cat ${WORKDIR}/no-grub-workaround.cfg >> ${S}/configs/${U_BOOT_CONFIG}
+}
+
 do_prepare_build:append:ftpm-stmm() {
     sed -ni '/### Enable OPTEE, fTPM and StMM/q;p' ${S}/configs/${U_BOOT_CONFIG}
     cat ${WORKDIR}/ftpm-stmm.cfg >> ${S}/configs/${U_BOOT_CONFIG}
-- 
2.51.0

