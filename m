Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C138CAC592
	for <webhook@archiver.kernel.org>; Mon, 22 Sep 2025 06:16:27 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.53])
 by mx.groups.io with SMTP id smtpd.web11.45159.1758521781311937766
 for <cip-dev@lists.cip-project.org>;
 Sun, 21 Sep 2025 23:16:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xv+7Pnlu;
 spf=pass (domain: siemens.com, ip: 52.101.83.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjFY6SgJiWvpFoOLFPULtuT9+UldSG9Azws8jROa+EFdLQboKR6dVuYRX3CT6og3/E6A+M9rkJKYFZNtbgpkmMEmWq4hN1LL6cDgkr5C8nUYnVUjnehzG5fN+Ickp/jzd4eQK+a3TSifEDnk/Br0xzUNiPEzLnISkQ/0V2dItEObA6fpjSu6x9gzle3UTI43LMNdLqcQ6oT4wyOMnRNJwCsQ8u7ugC/hypPlXeLbAS/TjcnerG33ceUzyWOBKX4kKXtdj5knHPOFM5+WnPuw9gdu54LS6WNd9Q6bINut034pdV7Iigk+77VoJp2LRsNqpuy9fEe6L/iMJlWC49NZwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5U0a3h+V+RsWlkzvGl/hNzcuETfPDHHbE5enhtIQuc=;
 b=UCp1h/7FwWZb4oSJXzf7BKybryaS0u7PzMdn3IRV7e188fk3AXXj5vdOo2JvI0ArSbgjVQu0CFPFSoBdMxLK1nC1sd/zeoY/9ljNVAIpMptT4Lhmfp1ke+QZv83fWiwja5LxqyBelbRaHMSHcHVbIO4lxKH5j/Xrv3/uSt0kJh86vBhT5MHtMF1s/WvIYux45vzH0VaBiK6NWRKXN3H3Acv1Qm7rn97hsykzpWN/lvyaR7Ezzly9/yCQdydD6p+6hF+0iF9WOTiUox5PoK1GRKNGcu/F4wBcr/AyDGW2IYsz6+tphOmL6y7r++EKMqQGLnTEzVrCjS5M/4L0uWPMaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5U0a3h+V+RsWlkzvGl/hNzcuETfPDHHbE5enhtIQuc=;
 b=xv+7Pnlu+N2eb2urePcW71N9cplCCku1pmiTGcqG0jKEd1nHBaw5hUPjCT9nMBlR8VmFAvUKeoX1HO4ckd9vCI17ZUKKM5Bg2IvLmj8eecAwaqdHJNouO6AkTOCXgEJFajYcspozsMRMZC9wZNTq0fcduxfkB1CY5qwRz22facf2st4iIpte5dBN6QohDQLBivzIBVNPirIiEd8cFze48JnK43Fqs/hQHY6ec+G5rox0mlNgswECFQJrT5ix6ebhBZBIFuzmAj5EQupdp6FksSXWLfvnJh8BSXPeTRDalz/Ic1dDkhezAUiVsC1z8bIDqavu0HbQUh5bvDzQebJqxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8419.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 06:16:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 06:16:17 +0000
Message-ID: <6f4eb6c0-68ca-4aed-971c-e39c518f5efa@siemens.com>
Date: Mon, 22 Sep 2025 08:16:15 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] ci: Fix reproducible build jobs
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bb3c63e-9e6a-4f5c-718b-08ddf99f8a07
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RFhDT0ExMUpFaXdrdlQ4UThPQVVRNHZRNUlUdnJOR21xM1J4S0laajY2eGlC?=
 =?utf-8?B?QTdDWTFVbXluMXB5ZXRWUkVXa0xLbHZzb3JvWDVuTFNuY1VjM1hiZkozaG16?=
 =?utf-8?B?My9WV3o0cjAyMGJSQ2U1dVplUWJNdmplNS9jRTJBRkZNOUVOWXFOM2RuQnRh?=
 =?utf-8?B?RnJuT0tYUFkyZXhPUS92NkxvbVM4UFdmK2JPOTBXdUZHSTZVNzIwREw4SXlv?=
 =?utf-8?B?MUx4S3RrSkhvY1RNamRXbWYxUXltUEJXTDBIVFB1bDVwcjZRMTdvL21UK1NM?=
 =?utf-8?B?NlI2L2JQS04yNHZZWUM1VWFiTEdKWm45cGwyelhqc2RnSCs1K2dNME1CaktC?=
 =?utf-8?B?NWNCNVR5dk1BS2tHTnRiL05FYm1UT3hKUmRLa2o2SnR2M1dFZjdHZWJrS05V?=
 =?utf-8?B?SjRnaWt2QXIxQTBiYWFmQno3cmI4dFhWd3Y5RWVRTkl1Ykt1byt1YVdOd3o1?=
 =?utf-8?B?TXpMR0R2THo2bnJvUXA5MWZ4UGVydnlIOElSUW5vemcwUDBjTXh5TE56QmU5?=
 =?utf-8?B?aHluQ1RxRExpb0NUeVIzVFp4bDZ0SUYvTEtLMEpOU2FxVitSSjZmYnEzay9I?=
 =?utf-8?B?RW1KQXQwSFhHbGFPeVcyU3l3NkVsZE1PbjhaYVZCMGh4TmUrcnpxTTFvWG43?=
 =?utf-8?B?TlhyMmFJUDE2RnFKSkZOVnYvUlk4YmpHTHhHZmlENTl4WnZDMnpQQVc4Nmhr?=
 =?utf-8?B?R0Vzd1VGOWdyYkUrQlV4MGluWGtXZHFybTBEWHIxUEpGL0x1T2NYR1NqTHdy?=
 =?utf-8?B?T2NMR3Y2WUpINVhHWlJEOFpLeFFLOXJEZlViUXdseFB4YzlXeWdlMllSVTIv?=
 =?utf-8?B?M1Vtc1J1b2I1Z1MwT0o2L00zOE1FbG5JOG91clh1QjlLZnZJZ0E3NW9Bd1Ny?=
 =?utf-8?B?MDliSTk3dThIcllBeU95djBvY0hnMHZlMnAvL245cFhjb2hCTGdrVXB2M3J3?=
 =?utf-8?B?SEZuQWphYW9HWHJWSitHV3hyUFVOV1FycjNJYjY1TUh1anMrZ0VqN1RnM096?=
 =?utf-8?B?YWV5RStNbmc3L0dTT3hwOGkxKzkvOThDTFU2bGF2Nm5XM004WXN3eUp0NFZ0?=
 =?utf-8?B?VkN4dXFYN0ZkQWFrWUlobk5KN1RZdVdqWTJKSlJpRUQ4dmM4cURIUUVxV3g2?=
 =?utf-8?B?ck1QVkpsR1pnbUlTTkliMzh2d2lMWUtPdXRyRHVaTGNHRU9aRDZQNUpVUlI5?=
 =?utf-8?B?NkUzN1RqbFpDNHdidGM4Y3hQMmwzZFBBTDdwVFJvUkN4VnFKZ3JtZmlSOFI5?=
 =?utf-8?B?K2dJTktjblVPSXh5Qnh2azlYeVExMHkrZHhLa0JDbEpiZGJ1OW1rOWNmTHlH?=
 =?utf-8?B?bzVHdDYwaFhybVN0VURQaGtKRHBZTHNnRlNZL0N4Sm5CWHYwZHViekYwZ3VI?=
 =?utf-8?B?QWRlenk1ZVNBYloxMXoySkxtWlBkM1ZmWTNWb1M1R1BYRGJVaE1nSHNJWk1H?=
 =?utf-8?B?Nm13MjNXSlZ6RHk0cktxUWwvVmVLVzRIZmZZTjlDMUU5UlF1aDVOYjFZTGU1?=
 =?utf-8?B?eWQxZ3owci9BVFg3N2JObnBsQnc3MUUrMXRKOW53Y1J6SDFxeXpScUVGVkNP?=
 =?utf-8?B?bnF0TGdqb0RKR28rUFJ2NlBaQThDeEU3elhvRTJRZVRQa05WTG1wZ1J1bFc0?=
 =?utf-8?B?T2x2OW8xcjdHbHFYR1MweGZHK3Y5Nk53cS9vdm5RMlJocmtDSXRGR1BoVjFl?=
 =?utf-8?B?cDBoazRYVXdMUFZsVk8vMHRJS1VhdlNSMEtCYjJ6SzNFRTJ2NlJPOUxkV1Zo?=
 =?utf-8?B?Q2ZlSjRERnlIZWlEUjI1RkNJV2dhVDl1MmQ3Qm5DcUNFa0xuSjV1L1Zsbk1H?=
 =?utf-8?Q?rbfKo8BQfUB73ExlWa/Zg4oC966YMfmvaBM04=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M2RIbE84elNEMmFJeFhQcnZENGlyM21WSTJCUW5WNGh0NXY0NlZsWEc2cnVm?=
 =?utf-8?B?Vmc4NHgrRDV2S1FWK1AzRDIxVS9jeGl2WDBkYjczaHMydkVKeGpoTCtjTXBr?=
 =?utf-8?B?VTNXUFdiblJtMTJieXUxS1UrbWdCZXdlZlVDQTlXamRLWVhWU0FlMzlUVHhk?=
 =?utf-8?B?Q3FRV1ZVdHNYR0ZyMWZla2d5R0h4b3oxY3JLQkZyRks0WlBhYlhKQ3UvakhJ?=
 =?utf-8?B?bnI0anNsK1F6MHZkZk14ZEJjUTVZNDJET3BOUnJNWU5WR3gwOHZLaXRwQlUy?=
 =?utf-8?B?YXhyd1JrUGxNUlBWNnd5WjNKNEh1QmYxUEtGeERDV3NJRVplSEkrVCtiUnl1?=
 =?utf-8?B?cnJacnNVRnZIeVNpWkpqZ055MGFPamJKVGdsV2E3MGt2VGZyL1RIZXNsVmY1?=
 =?utf-8?B?SFdlaXZJNTl2N0VaMnhnU2lnbmhxcTVhTWt0dXNmMElzOU1qSUtJT0FtYWNa?=
 =?utf-8?B?UnFlRXZSdHV2SWV1TURVYWsvZFZoV1VEWjdCcWdjaDdpZXVhb2lwWlNQcnZE?=
 =?utf-8?B?bnA4T3VpM01oaTlaOU1iUTdranplRHdYbno3RlJiWlJVblVrRis4dTVYZ2d0?=
 =?utf-8?B?cGJDeW8rUk5RWktWM21IazYvWGxicVhNZ3JUdTFSUXNTZzE2eE5xcGxsTGZ2?=
 =?utf-8?B?aXZEd0V6NTJFOXdEUkpRYklxTjBBdkhPRjcwOWp1Y0I1VTcrWTg3akRrSXNi?=
 =?utf-8?B?V00rc2VsWnV4c3pUWFloS2dvUTh5MzVPNEcwL2prcG5rSEtBZTMzQnlQY2Rr?=
 =?utf-8?B?N2ZSL2FTZm4xVkJTTkNjYmt1SlA1Q1dQem9IYjZXK3V6NlhvdGFiRGl4ekc5?=
 =?utf-8?B?Q3VVYlovQ0pDbHRCNVRIK1pCNWVRUDViRE80VUo2MkZ2cmNiM3RUWlAxZzdG?=
 =?utf-8?B?aFZ3a29VbnpDYVhiOUY4ZnlmVDBnRDk3YkliUmp1T2VMblkwdk8xS096V1Ew?=
 =?utf-8?B?WWRWN1JvaHBWdXJ0amFmbmp1bXdyYmo3UW95dDhzRGFIUkVtTXpONjFsNHR4?=
 =?utf-8?B?OHNpN004Q2lNTTJHeE5uQS8xTEI5MVZBRHR2ZXh4RHVHbXRySlUvQk9odmV3?=
 =?utf-8?B?VEF4VythZnlBVTU5RWJJTDlKcnVaTnAwUzZUY25jcmZSZzAzemJCdTZEV3li?=
 =?utf-8?B?U3JsWWVRaE4vdy9YZHpaNHNEL2VJaHJ2V1UvWUoxcXNxcGEwSGpLbE1zUnBr?=
 =?utf-8?B?WTRwb3lNbExROEU1cmJGeGxTQjZ0TDgvTTd1WXZjNlFzdDFxcXBBd0loQkp3?=
 =?utf-8?B?WGFSM1hVejZuYzNGU0FLK3FiR1JHSGxiY2d5akNRSzd4azhDRTFnOTU3cjFt?=
 =?utf-8?B?TEJWQTU0OXZVK3FpaGdTb1orNnBwei9qdy8vb2lUaUxQMVcyTHI2MktiOHFn?=
 =?utf-8?B?UjZBRExkYTJsWVlhV2VHSWxad29UQW9EZFNVNnBQaUgzakVwMHlWd3A4Q3c0?=
 =?utf-8?B?KzlHWU1McVJRZG9BWEZyMkErcklwMklSOUtITEpWR0UvbnArdjFKcDZ3Y0lD?=
 =?utf-8?B?NTFtdFlKK1NnKzRmYnJmYmo4Qm1hTGxKS0JYU0loU1hSVjdrTzZub1dueHBF?=
 =?utf-8?B?TXg2ckpITFdIZjlNUnZyd0NHczVKRjBvWjR2b3QwbWhybzJ3SENBYk5saXhM?=
 =?utf-8?B?KzVubnB6L1pTK0NnWEJWTnJlUVBsMk1zWmIvaWt2MGZGdW5FQ3p0MVlkaTNI?=
 =?utf-8?B?RTk4MnVBVlQzR1dlQithNmlOZnFQU2pqQk1nMFFQa3pvRnRRN25ObDlrbmNN?=
 =?utf-8?B?b0kxQUNUL1FNaEdYS1VpSkVCWUJMQjZNTm9oVWRLWXZ1em5ndm5ObzNJdlRS?=
 =?utf-8?B?N1VGM0ZkV2RGVjhBdHE3VmpRSzNCeDNWNjg4TDN3bGtoWWtnajlkaW1IR1RH?=
 =?utf-8?B?MmwzRXh0UnJqYks2VjVNT3kyeGh6THhmL1V6Mk1vKy9UeDdzRjR2K1dqZS9X?=
 =?utf-8?B?THQvcTZOSTZDT0tRN1gxN0NRUHAweHREN1BoMU5FL2NnejY3dzhyMXJ5KzFi?=
 =?utf-8?B?dGdDS1cyMGZtVCtnU2Y5cEZLM2hKYXdWUFBvRUhLUHBQV0MwNEdRQTZOcEZK?=
 =?utf-8?B?eEdMZFFucTlwSzJWNVRjRTRXQ2UvQVZ4R2JML0VrT0U5TEoweFZWZWRLVkZo?=
 =?utf-8?Q?O8kGwfm8B7fosbTkRPttbkEqN?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb3c63e-9e6a-4f5c-718b-08ddf99f8a07
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 06:16:17.0211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHdBYG/nJJt91r8tln8fnhj5KtAEHuGgdmMUku8K6wlm84m8XVaW/5b9MqFuMhHRjguMUxQmPjRdNFamctMOiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8419
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Sep 2025 06:16:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20087

From: Jan Kiszka <jan.kiszka@siemens.com>

Define the kas-isar image via default to avoid missing a build job while
keeping version maintenance at one place.

Fixes: 640238410510 ("ci: Switch test jobs to self-built lavacli container")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 99c8013b..7ddb97c8 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -34,6 +34,7 @@ stages:
   - cve-check
 
 default:
+  image: ghcr.io/siemens/kas/kas-isar:4.8.1
   before_script:
     - export http_proxy=$HTTP_PROXY
     - export https_proxy=$HTTPS_PROXY
@@ -45,7 +46,6 @@ default:
 
 .build_base:
   stage: build
-  image: ghcr.io/siemens/kas/kas-isar:4.8.1
   rules:
     - if: $CI_COMMIT_TAG
       when: never
-- 
2.51.0

