Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5034DC25B76
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 11:47:06 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.66])
 by mx.groups.io with SMTP id smtpd.web11.7410.1718106415323213763
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Jun 2024 04:46:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Q5ln8ksU;
 spf=pass (domain: siemens.com, ip: 40.107.21.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgEvD96a9YlfQ/9hzln0zDfWY8MSOCDhPZQBMB51s62dnHNyhWNuhSeJQai5HfsTvpfv5aBwtBNsg7sp0AyPeXqNMDh4D02F33zUMHWdf2S7Q9iY6MkYNMJdp+VnWF34L4NxQGbORTGI/F2dRgGx+rdLXFQfhiR4Rp4BvZwATvS0dGMrdeitrXVsZrLjTSbTZyF2+VHmXHFPhksff2UtzfkBBS1+ty89iHFRWSmNxzN0jEnyRccoX+D+Pd7SFmyCxmyMvyrerarRS+iIqi/KGXqLbzw3aiH+yvsP9Dr+Inqp2whHd3nvlWsKec0l2GiA0IrozdETkPo9jcRJ0Opuuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFAKcGoXIMrP03qAUsXGmEHE+jR7ov3sP59l7Hv5v7M=;
 b=gMjdcRLvrOxvYGiuZUSkg5Qnj75gMyqxFU8bkQGxIK4MZXOAOtDYFmbvw21Iej3AHNiJIdSKTZYvwLMqgkpr8hFwuuVP0aBMaqUzOmdGU/HDsub0ZJeqMIUbNqmy7ur/CfFARDHK1CvqXXV45iGMXskUDLAZkJqIlaZIjJ8JTZ9yy3rrzzlA6KpAr6YG5DhfFfHKs1fCb6XehK3LZoqOcZGOGR9TTNKoZ0abxSIMJY6pr+PvaE4D4EH8C2Tb5N7Bzz/b8UKU5z64X6LLksnp7JGX+B9CxGyMfTXU3jKMJEQwogHlrE+Q1rwcOvcuRaJLQ8p9No27OmbqNDSkCdGvyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFAKcGoXIMrP03qAUsXGmEHE+jR7ov3sP59l7Hv5v7M=;
 b=Q5ln8ksUI7OFqd1EZtv1BtRz1iq9oirCZS/mTJpu6/tsZ2j22EfqoNIL5dJuqkk2bpN+shNLCNhwvEiOWRl3oGGkFVCnmfNbNzOJxCID1yTtn9zGmGLED6m6q+m7CynoeU0A6s5kTOHthuRI/bsNDJrqg/MTe4nbdHk5rV84ldbXwT/zLnPieO9EwBts9ajYwi9dAouV5hA43NbmMkdJvD6v2j4r5pnXzpGW2houTQ8O4vFLktunvsIYWLWGqY5Ec5wHKlA+7rqAQdOAIfXF5617i1vwHoOG4jKUO28g8T7qn009rJ4qOgLfDCrK7WNrDYjz2OWs0atUiWxJ+JuGvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7696.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 11:46:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 11:46:51 +0000
Message-ID: <865d07e2-aba2-4b27-a399-55738128a267@siemens.com>
Date: Tue, 11 Jun 2024 13:46:28 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] ci: Only test stage when build stage ran as
 well
Content-Language: en-US
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: b92a8be7-a4f5-4c2b-1730-08dc8a0c2f00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RHNnaEtNQnQwdURxMDdwOGtmczd0K3V1SmIxUTdvUXlERVVSbmZRWnlEREkr?=
 =?utf-8?B?UXpQMUFPSFBSYWUzRFVyU29Lb3NxRFNGRGJZL1NlTEVnT2dnRGxvdHRZUXhT?=
 =?utf-8?B?bURyTXk5MlpCcU05Q0kzOEpYSnVmUXFERWk4QWZuekJuM3NCMlQyNVE4TkRS?=
 =?utf-8?B?MkFXajY3UFEwYm56RDhrbVJSQzhMeVowYmFHWjAyQXZyKzVoVk9pL0JJSTF3?=
 =?utf-8?B?ZDY4TzJTNTgxTUVDeXlGczdRSnlKdEFKdEdRTU0xQkVoRmhwdFhmYitBTHc3?=
 =?utf-8?B?bEJzRDMzRHp5MHdiamZDWWxVVkJTSTkzM2FCOFdKNmFqSVRGMmsvYWxoZUxS?=
 =?utf-8?B?UVErR2g0cU8rVHZrcmd4a1VnTSs5OXErUm1vZFRCRFAwVVVGWUd6T3haeUFQ?=
 =?utf-8?B?R3VES1hnVVdheWl1S3UyZ1YraWJNU3EzR1Q5dEhnc3A1dlpsWEhYUUJFTDBD?=
 =?utf-8?B?L3krTEJUSi9GTzhwY0k0RS9vdjltSXEzVzRvSkJDM3hIK0tRQTdVbGRuQUo2?=
 =?utf-8?B?V1BaYUJVemdqZlZDWHFHeElONkU0eGRQU0I3Z2RjVm5TYlpsODF1Z2NwSm9n?=
 =?utf-8?B?V0Z2b2tBd2FuNm9CM2ZIS0ZWQzJJVTRmNk53T0RzMXpUcEhZbTJyN0syV0d2?=
 =?utf-8?B?SUJXQVV4VllBM21wcTEyUCt1STVqTDZXekhJOHV0SmtscUYvZTY4M0ViREMv?=
 =?utf-8?B?ZjNZYkZ2c0ZXeVRJZy9iajl3ZklpcE1PT3c3bDAySVVMZWJJU25NLzFkRG1U?=
 =?utf-8?B?clBMU0JQdWs2TEJLZnB3NTBQdHlOZVdQZUlXYUNCTTJiclZJcnVUck1wRHVW?=
 =?utf-8?B?NEtPemxCL0I4b21FZkVPeCtkczFrVEVVR256UTFMVndWZHRpeHFKd2Y2VUh4?=
 =?utf-8?B?bXRpVG05OFZvdFAwV2ExdVFURjJUeE5kU0lBa0lmWVRaVHpOSXdtbTlwbERq?=
 =?utf-8?B?Q1ZyNzRCdXcvMUFnVWVPYmpJaS9weU1WVk5PL1R6S09jbUZodGwwS0NNaFpx?=
 =?utf-8?B?WnBkOFh5SFdwK3RQMlE5ZEVjdGZMdnpLaFlrS2NLR3NxNDBTWjVDL2tmTUFS?=
 =?utf-8?B?dG1hcmZSQm16dyt6ckhQeFZyY1RNVFcwUmcvcjA2VjBIS2ZFRnMyM0p5WVo4?=
 =?utf-8?B?eTJwOHpzc1Exb2EzWjJ3ak0zL1FqL1lTdEQxWjZ2bitTRXFsR05XN1o1TUlK?=
 =?utf-8?B?N0ZIaEFOSFppTm03YUQ4aWVZczY4a2syWUVlZjVYeXp6Y2pWK0hYK0pCVGNy?=
 =?utf-8?B?bXpuMzR1U2RzK2xFcmg2TUdBcWMvVklKZldzTVJPWE12MHNvRjNSOXdxWHQr?=
 =?utf-8?B?MlJ0UVBiMU0xWGp0OVpnQzFCNXdDOTlHS2htd0FJa2hLdHp0Tk1wYnZOWEFV?=
 =?utf-8?B?dUpCaTFtNDVYR3REbk9jMHYzNWh4ZHlzeDZtOVpJcG5kLzQ4TjMvNmI0YVk2?=
 =?utf-8?B?ZC9KYkhPT2ZxYXR3anNta29KU0hTd1Vpd0ZvVUdLbHdyMG1HdkFINXNkUzNG?=
 =?utf-8?B?SVVSTVhCUC9DeEFmY2l3ZVNVL3FpZ0xobjNxanpockNnUGwxanBYa3VNTjlj?=
 =?utf-8?B?VXlsdWluT3NKWVpYWUVkZlh1VjE0QVVSU1dXemxKK3RUNVVjZWEyMnZCWEZR?=
 =?utf-8?B?cHBKKzhmVW5SajNnMzdSQ1p3UXBtd2lCNUZyT200ck4yYkNKbFEwMzBSQWJK?=
 =?utf-8?B?ZmlycFFzQW43QlU5b0tzdkpjU1lXQWZIVHZiaUV0U2VGN3N3UG9wSkRTcDQr?=
 =?utf-8?Q?j6VhuHNcDelkfvPbQkMS6B/oLvAH7QbF/6u0vcS?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aWR0K29qT2hULyt1ekh1WG9wYURMRlRLYkVGNEJIcFN1dGRvOWM4WkJveE50?=
 =?utf-8?B?TXdiUzl3cUM0K0NvZXNwWkl3U2N6ZzlydHJhbU03bnl1UG5CREpkWFZxRlVW?=
 =?utf-8?B?dHhLSjJsUHlUbnZ5SllVQ1ZKYXhEcjBVSlREYm5yNlVZazlHQ0dpWnhZbElt?=
 =?utf-8?B?M1BIV0h6RGZQRDN4enRGTUM5WXl0WnhBR2Q1cTZPYTFjRzQ1Z0c4MkJZTExu?=
 =?utf-8?B?VUViUy93UVRIbmlkWGxJWGJXT21uZWZDeXNpTGY1NXhhNWlMNFFSSjdUSkNN?=
 =?utf-8?B?MS9IdGtHbVNpVmZUa1pDOVh2eEZLbVN4bVBnNlV6ZGZmNmJ3VjZaWVcyNnVn?=
 =?utf-8?B?NkVkd2RXYm0wa3hWV21XcjdIWEppQkFVVTlHbU9IRUxjZGcyc01rcGs0cHVX?=
 =?utf-8?B?b0RsNzJtdDZNY1hNc3BPVGlvWTRzOFJXOFdJaWozTzJOYnBmNW02RUo2bnNK?=
 =?utf-8?B?K3FmeXBWVTVLVVlGOHhLTXJiY2t1TWVOZ3pPanVQQjNUMk9jZ0ZsTmpCMFYy?=
 =?utf-8?B?NGFZbEt4RVExTkV5aU95dSs0Uzl4Z0s4VnBDNGpmL2Y1RXBQMVlXLzJ4NTY0?=
 =?utf-8?B?L21lWGlYZ1lpNVhzNk5xdHJlK0xBYTN4bVVBTkt0eGljc0FqMFlLNFVuUUdO?=
 =?utf-8?B?YWNDejhJdFFXZ08zOUVnbUhScUhXb3ZxaWE2TzNzZUhQYXlSaTdGSEU3bFZW?=
 =?utf-8?B?djRMQUlyVDZ4WUNFMDBBTTh2ajVSUW5jY0c5L29pTkhraHo1d0V2cDI1K2R1?=
 =?utf-8?B?RWJzK3V1VXVDK2FXanlmYzA2RVcxRUoyTFF6U092OWM4b2k0ZjgxcHNMTnFi?=
 =?utf-8?B?cSt0TGJrazBHV3YzTjdFUmtaOHptTnI4NjZRcitpYU9ZRXl0R3hRLzJPYXBO?=
 =?utf-8?B?ZzdwUWtNb1ROOG5GTmFzYi9zNG5ZSTVzb1p4NzBPYjRrUXFlYnl2V1Bnc09V?=
 =?utf-8?B?ZDRRRER4ZkpjQUl1NkhMb1A4R0dPTUNQWlg4TGhlZTJxcEZEaHB2ejdUK04w?=
 =?utf-8?B?emhLSFQ4eEZDeXY1eXd6UmdqVDRIRmhnRndKUThvek1UK091aU1DQ1FqVTZ5?=
 =?utf-8?B?U0VWSyt2RWVwVVJJZjJYdWdrUGtYZDBjZk9PTjQybExreVFhZmxkdjFCMWNz?=
 =?utf-8?B?T3d3RloyZmRUQXl0Y0MzNFdaQmR6aVZyVWZWdy84MDBqd2VtNlN1L3VIV1hN?=
 =?utf-8?B?SE9uSmxDd2pheG55OEp5aGVoMWt1UlhpZkx0MENrN21xbnRIQ2JXdlpGeWNC?=
 =?utf-8?B?MjF4dFpvNVNMTWFRTnh6bSsrZkJuZU9kOHNSOGRGUGVIclBsUGZKVVlwcjFI?=
 =?utf-8?B?WlNkU0F0WXVxc2lRbVQvSVIyT0l0anBldEFjYkxlemsxcUxTd05hZTMwRGJX?=
 =?utf-8?B?c0ZQT1ZEWWJkV1dYKzJzUktmTE1ZMVMzYVdsMHFUQklQWXNHbnlZNVVzN2Z5?=
 =?utf-8?B?K1AySFRuK054NzdlVG45NVJnSC9pMWhQd2V6S1piQzNTWnhMa3FDRWNHQ0V6?=
 =?utf-8?B?cVNKRFhzdzlZTGZrY3ErdHpNeTJycU1JdnpyRGhKV05oT3BnVUI4c09FKzNl?=
 =?utf-8?B?bm14anRqTGJDZG05cVV4OFVzd0xEZU1EbHJlbjBQSWh5MDlwSitmbncxelBy?=
 =?utf-8?B?Vnh2NkFTeGRIWGV2WnR6dGhVM0dNNjlVOEgrNlM0ZE9VYnhTMzlhdXJWMVJ0?=
 =?utf-8?B?RC9KUWxyRWhaTmpxWTArNXEyWkdwWTVFTGpEb1NDdmp1Z0Q5V0d1UXlybEc1?=
 =?utf-8?B?RFpoTmQ4aGJ6Z3RJS3JJMld6Rno3TGdEMisyQlVneFBkc2RYV2JVdFhqU3NT?=
 =?utf-8?B?cmF2TndyL1FOcmNpWkFFZE9iRVhLaWFEZXBORGpRbVpWTkd6c3B1TWN5K21G?=
 =?utf-8?B?cWdQbFZXQUk5WkRMbHNoTDFjU0c1bjQwN2RyaEE3b3lsVE9NU0Y0YTUxOXZN?=
 =?utf-8?B?SXJBYnp2M1kyQWtWV0YrZFgzaTRvNERFUFJWcU54YjJ0WUZkZ204ZTRGVXJQ?=
 =?utf-8?B?MEVGZ05YMHhpV3JZa3F0b0tUcHZ3dkdSdENPN2R3eDV1UG5YUXQxU3VBM2M1?=
 =?utf-8?B?WXJiWXV5a0kydnlXd2s3cWVUaURjajFJNGRWN1FrMGhvL1RwZmh4clIxMVR2?=
 =?utf-8?B?SDYrNnpseG8wV2JHdEZJeTVkMCs5eWRVZnVqUG9xV21ieVEvWTQ2VjVGcitL?=
 =?utf-8?B?OEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b92a8be7-a4f5-4c2b-1730-08dc8a0c2f00
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 11:46:51.3489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWd2NKfXRJyjsX/m2koWEIfyoM7D8CkUNdUn1eRSA74NUKHOKO3Vf+vCvMhCS2VkPYg5Mp6EYejmUoUryZJaJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7696
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jun 2024 11:47:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16188

From: Jan Kiszka <jan.kiszka@siemens.com>

We need to duplicate the conditions of the build stage here to avoid
running the tests in the absence of needed artifacts.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 97270796..b3f1fc6c 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -345,6 +345,12 @@ build:qemu-riscv64:
 
 .test-cip-core:
   stage: test
+  rules:
+    - if: $CI_COMMIT_TAG
+      when: never
+    - if: $CI_PIPELINE_SOURCE == "schedule"
+      when: never
+    - if: $CI_COMMIT_BRANCH != "master"
   needs: ["build:qemu-amd64-base","build:qemu-arm64-base","build:qemu-arm-base"]
   tags:
     - small
-- 
2.43.0

