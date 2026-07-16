Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB59C43458
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 05:42:33 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.66])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6320.1784180551248412052
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jul 2026 22:42:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YYSnXHGQ;
 spf=pass (domain: siemens.com, ip: 52.101.66.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6vOAk3BeuZo9rwIpdt+exV7rTMbAhK7NHs9Vhg2mmQHQodn01fs3XuccGNUwUn6W0yWBHnhM/5TNFLWfXIOt9NxgOpZ7ZAIq58LIR3NFqoXC9XsYKHfMfy9LhovumfNU258eFyuREQRJFPvEZR8TI5qw5Y1uDq3BtC95+vQzOgaHAP+xaZSuQ4xZp+JP5bQEAdq7T0OdpNfDkRggPP0gg3OSiLuwz7otW4Om0ViHcSGT3wXgWUJVMp2JAi38OQU7U9JG1ILMhuJme17VGXnRD8UXQe18Z0b+pUl/82VYb/452NCPsyBKpJ+x2UBz29387xW4EuzTeBV2WjcxoZUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHckgCVqb+GSmGNeeZw2AZcD5Rs2GXrvxY89zVwGpdk=;
 b=EkCXxRLOnorC1SRcsC6RLM0/GTpW8C4NFqj9rXrDl5mKO7BKuZRJnHLZeFxSyaT6wQ9BdpcDwaNCN8vGnMyfiDFBPt2yzDfptmHOzW1xQVfEQNpW14ZilbWP4Q4PeVWl6hNfotOH0FaUxSt7Xh5hTXG7H9vyMdp+JoejdMP4L7gs5DO9JqzNRcaMrvRud+kElxrjSroPlBRh3M6ubrKSALi8abGbrGaVvPWSbUWDIWkKLKGUeQNxOX4u86zyKwdTo3YdVv4tRIPgHaKB2idk63gv1mo+LMuojudETUOgVZK3X/ETUxCHd3eRqO9cpo//QU/V/bejjb+AGkskIIzgeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHckgCVqb+GSmGNeeZw2AZcD5Rs2GXrvxY89zVwGpdk=;
 b=YYSnXHGQ0JcyXBfjDCXEAIulkfGUG4n8epUwZtzpYMwmaPfQlvQ4bOWp2yu88gwpzMjiwDK8FrFxmeqv4dY5pncQUzEea9eX5e/hVWho9kjOqXTeKy3tp0pC6Dr+iqzEOpf4+r+EhOiE5XMYP2nB4rd4eeoqNYHz8GYsvOZtSB8HVpwxEeEifM9OaVnMr0/xI5PqNvglv1pjLxBEdEXU39vEHHGUYzYer8Foc3a2RqPvt5rFw52YlkpLTIfgKhoNGg5bXa4p2lGCh3o3rQoJpN5YJXemgrh4TYK/9+Rik2EwxPxyh4UFonHCWyPyniadwZ4yROEvEz09bm4FaLOUxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5834.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:391::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Thu, 16 Jul
 2026 05:42:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 05:42:27 +0000
Message-ID: <91a1e27e-27b9-430c-a32c-504548d2b21d@siemens.com>
Date: Thu, 16 Jul 2026 07:42:26 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] docs: Relocate iwg20m README to doc/boards
 folder
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5834:EE_
X-MS-Office365-Filtering-Correlation-Id: fc343d3f-03ba-472e-a430-08dee2fd0520
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|55112099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	pnha0mlsNguiMNclsrY8nnJOqvsMbvZwf97VcTUwHCVI/7CIO5dBx+J+N87YYveVuLmJXKB0bCfY6pUGv4CZSX02VIqNm9s9xYhFRgwfsbfLuvXbd3ph8rgSLrALUaFzwBZ+/Qvtyv3bo41k2Mo0N8M1i2FkjjNIOLh68dV6jJzbXjVvbzenZTuNS6En1jBGZLvn+yK2vuJq5QOdSdSa7Fau53QAbjpPpb3qtK21XiQbQ8h+ZHfmSyyz2hxC3Arlmq8BrDse3CwS/TwR3ktPf98tOfItWpgHmdm3SZ5RR/1Id4e1H9O4Ps03jQWrWDRnuBg3dHxaGFawT9xXHG4L4jdLZu7reM4pkh5/TedQVgtNutLOz0p8hSE3Vupn0HRjnIA/gPJehrB66867LQlE4T6bJxt2TCLj0lMsan7KtAlL7xBfPmtSEILJOCS5f2njQ6ZM6dg9lyYW+420HjDx2FD6/eSS3jjtOMw4DrR+21O6c9rB5y1xW31ZbqBgj/wm+6igXv53ZGYQFc+HrHuq7Muzyun84qG0RaBbSIUILJROiQYLyC4XckEDHZIstX1JUaCXuzMZ1ilNbVwL12dDTqOFodajc93/tmXW616qKyx8O2xkStp51wfk4ZN0PFd7iUs4eGWeJM024tMsThVfS6S0Wzs6+EEhBuM7shdfD8g=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(55112099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QUpMWjM0ck45aWNuRHYraWdQY01LRHMxWjd6eDZTRmd4YStWaUVyaEN1Y0t4?=
 =?utf-8?B?VnI2bnZnOWU1LzVQbTE3NEhCY0x5M2VWNlZkRTdmUWdvVUVJVll3dnBZZGdT?=
 =?utf-8?B?aDNBZG9WbWEzc1NQMDBWbEgwVEFIWHY4bXNQdjNXZHlKV2FWRDVwNmpZeFVk?=
 =?utf-8?B?MlJKSG1VRkNyM3V1QmsrNjRCUXVkcFdRUi9NQnc0VXdMSENFYmRzdndHYmxH?=
 =?utf-8?B?MmNPT1FqZnc5M3NlekRjUmJUM2dYM2NGeEQzY1c3MjdibXE1aHBNUVRVcVdQ?=
 =?utf-8?B?RVFRS25zZG1HVkMzZWlXUFRPRmVCWGFXU2Q3cHo0a25sUXFsdXh5UGw1dmZM?=
 =?utf-8?B?L3preFB1NldzZEN6MnNrREJzTk1xS1dDTlZ2MVB6dmx2eEtlZDRLOGxyYm92?=
 =?utf-8?B?cWdqMENSMUh3dnF5VjA1VWdpZ1FtNjc0OXRtWnNnQ3IydWdTUllrZkdHaUFT?=
 =?utf-8?B?Tm5Tc25sN1JZZzNuU0FoWGQ0Uno1eEhIYkt5VnFEVmdWVnZ6UDdBaHMwb3dY?=
 =?utf-8?B?eU1VRWZCcTRyVUtuY3RJS2FTTEl6SnhoWisxbVF5ZUJ2YTJYdHF0VzRZL3NE?=
 =?utf-8?B?TVBuN3BETVNqTXpCb1RGeGdCSFdRWG1Wa1E1azZoRjlCZDJpbVFqKzJINGRu?=
 =?utf-8?B?QklEMWV0enN4R00rZE9xUG4wbjlZL2crYXlWb1lnU3BoMUNZMitEVjJ5RnpL?=
 =?utf-8?B?c3RnazVnY2R4VTBlL1NNbFZ4b2N5Y1JpQ3VBYlJOUDlrZFNCWGhkZmlyL0hT?=
 =?utf-8?B?NzlYQ2lYblE2VSs2WG1sRThIZ2I0Zk9jUFpDNEhjQ3BXaWdvQXc4TzVLdjQ3?=
 =?utf-8?B?MlYxTCtCRlhteXBhendvZWl3OEdSREoxbUVHZFpVS2RraGtpYzh3REc1enY1?=
 =?utf-8?B?UUIweHhTZ3dZcUdFZHR2MktwNUVNTmZpNEFJY2tYMGdBanJoMmRMSUp0enhD?=
 =?utf-8?B?S0pKcGJscVlOYVU0ZENoQ3hlS3BGT1hSTko5V2ROSnhUTXFiOUdRdExjZTRi?=
 =?utf-8?B?WkVlYTI2bW50MjlCYzRWbmpYdmxodDUzeGdzWldCRzJuZGJRZ3p6R0RWbmRU?=
 =?utf-8?B?T2hna1YrUUIzK3YrdnNJVkdmU3NqeHNpRkk2d0l4K2JpQ2MyeVZQU0tFdFFa?=
 =?utf-8?B?WC80ekxsQVNBazRNN0g4QnUxcXZmTU1mbGZST2Z5WFE2OHAvVGgxa1NIYzVN?=
 =?utf-8?B?QlR6MTEvb3daTThlMnU4a0t4OFFLalk5SFhRRkw3UUJCZmVFVDZVNHVQOGlh?=
 =?utf-8?B?QzhPUGppdXJzSFl5L2NUa0JsQUlXRHRWS3NFdU93aG4yZDh2V0RsMnBjWXhF?=
 =?utf-8?B?V0dOTndMVDgzdXRZRGxFclMvVHUvcllLVzRHaUYyTTlIbHVEaGplMEdSbkJO?=
 =?utf-8?B?bDA1TmpMZVYydExjSVBvRytaU1BRaldDNFJnT05FTk5BeUdvQjNmMEpXVUd4?=
 =?utf-8?B?VG1BSWJGUjhjVE4wT0dKblNSMUhWWVQzVGRmOGlsa0lFem45K0VYUkRsSFh4?=
 =?utf-8?B?dHd2ZlAwZGxqMzRsTys4Tm1KWW1ieTNjTmwvcWM3RG16bHBESVdFUmFhMUo5?=
 =?utf-8?B?Q0dvMDRzL0dOUVdYZkxZK29MMDlmYTNqbnFtaXRTMTA0MVNIK09HRUxFL3or?=
 =?utf-8?B?UkhZTkxsdmIyTnQwc1RLK093a3Rsck5mRUd4aS84bFUyajNmdTEzVkZWV3Iz?=
 =?utf-8?B?M3NsanlwUmx4OHF6UzA4a2k4MTA0NjRCSEpOdFpZanpOc200TFVERTlteTVW?=
 =?utf-8?B?MC84UkMxOGd0UlNYMit3Y09DcHROM1B1a0RHZG9UcmNGVytieDhxQzlVSStk?=
 =?utf-8?B?ZllubU55Vjg5WXRvVytsNm1vZHdXS200cVA2QVdDcWF5TmtFQ3ZnSmxkMURS?=
 =?utf-8?B?V2NFdVFBaDY2M21hKzhMRHd3SEwzM1ZmaGdsUmFHNktCT0VVano1NXZyNGNl?=
 =?utf-8?B?L3FZRE5FQUV3Sm92aWF5eSsvUjVlQ1AxYjNNZllHNXRZeUNlQVJrZHVFc2tl?=
 =?utf-8?B?QnlIbzdLUlJMYUV5a0dtSUN1VUtSYUk4Mk1ZK29aTnA5bHVJTFM3NkRleEgy?=
 =?utf-8?B?UGNMVHlLcExaZjhvKytNdUsvd1g1WkxNbTNvRWdyeDNNcFJQcDRlSzVwL0dZ?=
 =?utf-8?B?ZldjSTA1RmcvSTVNd2MzOUxmYTFhb2MydjN5cGtYQmQ5UUZkS242Z3Z5WWR2?=
 =?utf-8?B?SWczcHdLU3ZVcFV0N2QvWDhCd0pic2l2V0hqOXNvbzc0UnhiM2VZWUthWnd2?=
 =?utf-8?B?enBrOXgyRVRxRXRleGVFUHdGMWdHcGpoNzFEM2s4UW9LQk9LeVFHSitvenpW?=
 =?utf-8?B?QTNiLzNnbVNSUEMwM2NJRHIxS29EMWVwY1ZNVGZGMHVKR3lnek9CQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc343d3f-03ba-472e-a430-08dee2fd0520
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 05:42:27.5256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ppb8WYiTCX8BgHczDGROFrpMFwXXRYX2Bb/EAL9ezpYRWHOWqYRhUlV3LSKLvLt5ZkH9e96KTEaOUVAuaWSdKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5834
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jul 2026 05:42:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23605

From: Jan Kiszka <jan.kiszka@siemens.com>

We already have this structure, use it consistently.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 doc/{README_iwg20m.md => boards/README.iwg20m.md} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename doc/{README_iwg20m.md => boards/README.iwg20m.md} (100%)

diff --git a/doc/README_iwg20m.md b/doc/boards/README.iwg20m.md
similarity index 100%
rename from doc/README_iwg20m.md
rename to doc/boards/README.iwg20m.md
-- 
2.47.3

