Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4274ECE8359
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 14:56:52 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.56])
 by mx.groups.io with SMTP id smtpd.web10.56601.1727708204924297595
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Sep 2024 07:56:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tKrqRpwz;
 spf=pass (domain: siemens.com, ip: 40.107.21.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eo6AydGmxR9aW6pH/qyCav4mCnvIXRHJI9Q0Yju/wvB+ASngtcharEXuR8Jkni00sJNH01Ype/ULxEhUQzn9j/r0HoYpsAeEdPmmEwFhc4gCNN+iVh/oOYY5/5ozQ4/O59nvke+D/C2zsRnB5+nVvudQZO48Qgn9AGv6I3LFSau20rudbCHI8sRusY1rbajImbtSjHRH5j4UiJQ/G8j4PaY8VLBdYa30uDB09Z/hQ56h+VEdsjFfibJAUymjhlT8RFoO1gyB85dhxHPec+YpFD7WUlvWFeDGxagZJKKL6s1zeIKKBVFBZOj7xXBhetgP2wBcrxNdOhVadfuGaA0IqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MG/RTKrbH/dO3zxALpDHd9RqT8yWu51qbvX8+V4rpfw=;
 b=MidN0y6DAa6JE9Fnoq+KscDvNTQNljEDx6d7ROSG8h3a/gru/HjTEHn2Xuy9zdz9La7TL9bpowpt0Y3XtWEmz5zGi63p+zeQdFfmypfHnzZK0ECyqFQ3gOJN9wWw+BMqWm84lGVYW3JLpDdUWf3pSyfnpFPeTY7kGwD/ZPMJQurVQnSNcwsTDK+s86VW1VPHnqe9ApaAWEA2rdN9ejXAbwwk81zaEX3S/ZjEqjv5+4eg3uvnF8ka8gXZ835nBbN5k5o+8Fb2rHiFJccqqK+DSH5xwLKPbTWueLj0PlvyvGHbtrVx4+eU5uw8gFMWApyr8sDYQIfUw8UeRvaWSh3Hww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MG/RTKrbH/dO3zxALpDHd9RqT8yWu51qbvX8+V4rpfw=;
 b=tKrqRpwzoUamfATFJXNHsSYD2iQqRaawkJEphJT9HUumqXFrclE1xAqM0I4ZYgCIUpjl5ncn0ZqD8BjofcCOA95l8pGpwamURy91YNcoUSdvdyjUm+zXlImFjZ1suW+FhOUhhk9U9IbKPOLf/D5SFNPEkSzsmiUkjKyehczcyxqAQNFi2L8oLe8bPJ4Z9zqC6JrvDMawD2N+wGGosqwUgD8c1R5F+tMtZB/CX3JWqgzqiwWVPChO3HFvJTqoMcw7nFL/bq4Jyce83GCrkhuUzRkcM2Lkd+SIUmsWRF641thFUd706FY0kvvrnYeLvHTO04fais3zots2ufZn86H2Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PAXPR10MB7927.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:24d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Mon, 30 Sep
 2024 14:56:38 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%5]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 14:56:38 +0000
Message-ID: <a9512b87-16a1-4808-a0b3-b5007fa2ab7e@siemens.com>
Date: Mon, 30 Sep 2024 16:56:36 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip91-rt51
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::16) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PAXPR10MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f33ff94-0d4e-4858-ec69-08dce16015ec
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?T3FGYllOVXVLVHEzM25XVkZWQjdsUHFRS243YnA4cHhLYks4ZjZRdGFPMFUv?=
 =?utf-8?B?R05Va1VZMEQwWk5ZVWNaRERld3ZGY3REaGI0R0I0M3hKc2NaOHhVdUlPWHQv?=
 =?utf-8?B?cmI3Y1JQVHBOR1RMTm5RSGZqMW1ma0xBSjdYNkIxZ1JZM0hnaHV2WnFlZlVr?=
 =?utf-8?B?OW94M0lBKzU0dXZ1RXhVbHVYRldLVlJsYk5XbXNhdWFNVDh0OHNnWG1EL3lR?=
 =?utf-8?B?elFjM1FNcVVOdGhzWWl4SUpFUURFcWhtaWw4YVAxSk5yVVVuejN6VElZNVB3?=
 =?utf-8?B?QW5hVlNzL2FSK2dHclFYZUpHVnB5ODdXaEI1Qk52cTZYNlBuZnQ4SDdZYjVK?=
 =?utf-8?B?K3pQVHRQYnphUDNVSWhCeXlEZzJVQkZUeEZleFozaFk3cEZHdVdtNGdmeVdM?=
 =?utf-8?B?aXViL1V3ZW9jM3M3RkE1MVJrL1IzRUZ5R2xsRXpFY1hhNGNxZXRoWHk2dkJ3?=
 =?utf-8?B?UERtcElvdXM5WUJiMWpCYy9wY013L1R0MjV4bTdoenlMeHhseXpVSVQxTDAr?=
 =?utf-8?B?b1VDYVl4Y2FtZDN5S3kzbDk1QWdZb1pYZ1gyeGFJSmJObStXRWJlbXB3VVVr?=
 =?utf-8?B?VlRmZGh1L2xld0xHbGg1NjlMZGRJUmRYS2NXSUVaM2JwNGNJUnlvRm1lWTRm?=
 =?utf-8?B?Q2w1Q1A4TEo4MmtMa1RhanNheDBmeDRaeGtTaWhFTnpYVTRaOEY3Q3l5RlJL?=
 =?utf-8?B?SURQeW9aaWZCWWd6ME5FSTgvdWtyT080T3lIMklNdWMzbGFTQnBLSXNjdlV4?=
 =?utf-8?B?NmJVYWcvSDROWEM4NDN2U041NHRRM1BGNE1LSDNFYjNwTHhxR1dBamJyODFq?=
 =?utf-8?B?aXBXYjYyT2hINENiRkZiMGJydFBqc1dKRHYwV21sUHhVNzhlaXRnWmY1Wk9h?=
 =?utf-8?B?dUlMRVhkZkxOdS9KeUVKRTV2c1Z1bTYwUXAxVW9UM25NUHRrTlFwT3Q4TGtS?=
 =?utf-8?B?bXVIOFB2MHVjNlB4OFFOZmZPQ0ZUWHFJYmh1eVEzWFNtMkZvRkNESXpPUjds?=
 =?utf-8?B?aFRWRG56QkxGVXkyUkJENXRxMFI2VndVQVcyRVNPMGx5b3BzV0s5VFp1Ry9h?=
 =?utf-8?B?ZU5COUI5blpGOFN4eUFmMjZnd1hPU2NSS1l5VTdLSmlVYTR6N0dCa3RtZUFD?=
 =?utf-8?B?N1pXT2VISVYza083bVJHUjBiYm5remNYVVRPNVFwSi9tV2RDM0UvdkRKZTUy?=
 =?utf-8?B?djR1bklLcEgrWmlDWU93bDJ4UG50eERtRlBIWEFrNGhuQlBlL1FWMGhIMFVP?=
 =?utf-8?B?US9mcERFNTRkWitXaktHdlZFYU1GUE93MHErcy9TYTFMTlRzdGVEemt6bER4?=
 =?utf-8?B?RVpYOU1vTkZ6bUMwSTRONC9HeklYQWhnUjVIdXhDaGgwZjBhRzdLUjZody9C?=
 =?utf-8?B?NnlvSGZ6RXBEWjBqbU9jOEg2dWJuUlRjdWhXaldTU1VKa3pIdWFvTjdZL1lS?=
 =?utf-8?B?SU9OUnVzUjVpSTBJclcwRnUyaU96UXNnTGcxbGdsSzY3R0hzUzZSNWplemVK?=
 =?utf-8?B?MVJEOGR1eHFra3NrSWdVYUZ3d3lWK2VkY3hVZCtwWElhVHJMbEpSRGNucjRG?=
 =?utf-8?B?RERPUXRYUkQ3aEx6ZVYyb2hJWjFQN3dTb2M1NG80TGt3Q3dOZmtBaFZ6MSts?=
 =?utf-8?B?NkI1MVN3L2ozaGJyVWJjTkNlSjJtWTUrUXk1ZUY5ZlBveWJIenlockRBazRZ?=
 =?utf-8?B?Uzg3eERyeGJnQUFqb2FaMEpqZTdEcVJ5a1RHeHhDSXF3R2JYSUV3Z1NRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a2thUHJ0MitnVmxxalNiQldkU3JvQUUzWmNzWXBqV3BobTcrL0daSVFPMmJD?=
 =?utf-8?B?THlnYWFWWlVyd1NuaEdQYTM5UXE2bHJTS0kzbEFMa1FUR3RHSlVaTGYxUERL?=
 =?utf-8?B?dzBLaFl0Q0pXMGJHdWRZMmNtMGZBaUxKa1g1Ti9xYm9YRFFDVnVLNFdHMjJt?=
 =?utf-8?B?cC9oZDhhb3A3VGhpUVRTNDA1Z0NNb1QyekZHMEtEZkVsaXhWaFBaUGZpSG9x?=
 =?utf-8?B?VGlpeEU5YS9pQXM3MmhQenZqUjZSTmRGUS9CMmZGTjlIcmpZQUZlOUMreVZj?=
 =?utf-8?B?WjQydllBTXU1aE9pVzcraEdZU3NxK24zd1ZUeU9tWEwzVFBmekQ0Zm56MXRJ?=
 =?utf-8?B?c3grMWNTamh1T3E5My9OVGErUVUrSW14ODgxdjhUbUl3K2ZpbHE3di9NU3N2?=
 =?utf-8?B?UzVBYTk0eUlOc0lLTW0yVWE2U2s2ekZpeEs5S1U4N2lQTk9Nb3NJVnlKYVJt?=
 =?utf-8?B?RHY3S3JteTRDTUJuMCtsUnVNSVJ6aVg3ZjBsZjBka3FJVE94QjloSHRZbnlm?=
 =?utf-8?B?d21zN0F6Q3NLV29ianRHK04zL3pOM3Y4NkQxbTM5TDF6b25LaUoyMXdyMUx5?=
 =?utf-8?B?aDcxWkcwVng2ZjB2ZTFZandTQkVuT1NPaXdURWdsbEFtL3R1eW9lT1FFTTN5?=
 =?utf-8?B?RVd0SmxxTUZmTmVjQVBQQ0hHQWJscERVVnB0WnJtT3FCb3FOaUtBUjFDYnA2?=
 =?utf-8?B?dkdZS2VLd3IvcitkUzZSMUd0cU1TamVBZWQzTHZtSi9Ga3NxZ1FRTy9NZm9n?=
 =?utf-8?B?YWdMellWNUx1cU1mbG95NGxsNTFjMW90L1AvNW9LVjV5V2RGM2lPdkYreXBN?=
 =?utf-8?B?c0dZMWZvazBJSHAxSE5xR1cvRUxIdU9IdmZ5cmNjTjdPQkFaeW1Bc1FMTUdF?=
 =?utf-8?B?b0VNQ0ovRlJGc0hIMGljN1BOM3A5dkZKNDU2R1ZQSXNENG1vNGEwMVpSckI5?=
 =?utf-8?B?TEIwSE9sSWUzK2JHRGxvQkE1cmE5aFJjWUNHb3dtZmxTTlRrU2dZRmdXVXJT?=
 =?utf-8?B?eDRhQnhQVk9OVkN3VE5oRDdmNExzY2M1ZU1sYmJtTUp6bHJ6ZEFFVnRpVGJ2?=
 =?utf-8?B?NFo5QnZIVGVFMm8vczFmcFlvVUJENmp6UzVDUDRDeEZwb3NaK0JWUEhHQ0Fl?=
 =?utf-8?B?QkVXWjlhNVFlUjdZTXduRWJGVmhSNnErYzBoTm5Nd3FaKy9GQTlEN3NKazlM?=
 =?utf-8?B?ekdPVUNjWlJ3a0FFREZrZStyMURsRkJ2OE9ObzVxbG9tQXZSVkhnMTR1KzFY?=
 =?utf-8?B?UjFQd0ZySGVvVjJveWpRSkNGSmt3MmZFVXA0QVlXU3dtKzhoemgwdkNxeEgx?=
 =?utf-8?B?WkhOQUpETjVIdkV1ejFCUmRkeWJNdm4zc3dHZW0zWGZ5RFJCVHdhOGFQTGYw?=
 =?utf-8?B?eUpobjBlLzl0b1NtK1AzQm9EcGR4djNJSGlrbUJjWDhlcjRhOHhOZlVpdk96?=
 =?utf-8?B?b1dNSG1aT0pRcEVtSExoQ0p2aktUeEhpejByUUhrQ240V21TVGNacXYxVlZQ?=
 =?utf-8?B?M0s4cVBQM2hpSkpLY2g4MVJ2cUFxTGVZR25tNHdueTEyRklKNXd6cDdLOXJr?=
 =?utf-8?B?WEltVGZUa3B6Um95aGZlbjRNMlN2dDhsa21QekVralhlUjlITTJiK0Fkdk8y?=
 =?utf-8?B?SlpHNnVZQkkrRmttTzhVUlk3M1h4ZUM3NWk5ampTT3RLeHBuL3lWdUhMUTZk?=
 =?utf-8?B?VjlYRTJZSjk3TEU5ZjlCcUhnam9kWlBqc3BFR0hLbWFKbkk5a1RhK2NTMGV2?=
 =?utf-8?B?TGNocHVPbzRxUVNUbS9ITmpZY2xObjNzencycHpueDFsSkFOQnRqTWJXUSt1?=
 =?utf-8?B?ekVXdm83djVtSk13QTRlQUtsTHViN0l1VE5oVENKWVpVNUdISzVrUG9NOTNF?=
 =?utf-8?B?QklrYjQvSHQ1WGpxN3Bhc2tEcW1VSHhDTEhTVTQ0NFRVdnowMGpmVFdxcnpS?=
 =?utf-8?B?WHhRaENYdjJpWTJlV2Ezc3pxaWRBMUppTmQ1S2ZlNHhwOWFsdjhwZkk3cHlI?=
 =?utf-8?B?cG1rUTlDWCtVeUtNM0RhZGNBOHZGbWlPM1JGdGFSM0VMODlWbkVDSE13S2hQ?=
 =?utf-8?B?REVMWTZlYXFlQ2pZNUVzWnVyMnduZkk5YjFuQUZlNmFPQkF4cktZUG1oZ1Zt?=
 =?utf-8?B?czJheHJUempqUWJZa0hPNUpCNWJ6Y21nYllDZzgxcDlzMEppbkVnaDc1eU9k?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f33ff94-0d4e-4858-ec69-08dce16015ec
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 14:56:38.1923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMNtRCMTNkLyH/UjvwJAVNikbR2QaFJd3O9zvvcPmsPhu8zCftpJCxlh9c+kSTZMMYh7Ph1vIFRfKHI041Xk6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB7927
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Sep 2024 14:56:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16939

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...4.4.302-cip89-rt50.bb => linux-cip-rt_4.4.302-cip91-rt51.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip89-rt50.bb => linux-cip-rt_4.4.302-cip91-rt51.bb} (68%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip89-rt50.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip91-rt51.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip89-rt50.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip91-rt51.bb
index 8b0df6a7..5265ee16 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip89-rt50.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip91-rt51.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "ee387b5e7b71cceeb8a53af17d45b58c2334b451400d3a7f12ecec9be06c1cf4"
+SRC_URI[sha256sum] = "648850184297c57ff4951d04ecfdef870848faa5d83ac70372818355da357685"
-- 
2.43.0

