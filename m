Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE64BC5DF86
	for <webhook@archiver.kernel.org>; Wed, 19 Aug 2026 12:16:07 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.38])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5595.1787141766552225588
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Aug 2026 05:16:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zOtytNmh;
 spf=pass (domain: siemens.com, ip: 52.101.70.38, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QcAKxO3hYnAWrKbte2xuCXsd25/SWrWTJpPzZ+li15E9wltEGpY3G3kzO2fw+kZzpSuX/JqFf0qZ9A1Gk4vSwgvmYj3Ing0MZOOWIP4XJ8+jgvVN992WdVyNOzQUXpBRfiwWsnGAv4GQZyfojQ+lgUMVz0LNSEgSAB/rsyNOO15aKDj+r3GdlmrizpSAQYoAHzMSSkKGO0c/6ZkFTMKN9XMq5jynds8aml69jlOn8pGowPVrdF70Mmt8XQxhzt1Pet3/WywmYBh2Mtu+2Up665dp0ZKy5VguBg9Mb4uXrkyYg75edxpuw/uhb7LksIjrugENoMlDb+fp4Y7nwjobOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xXjUrZ/Ixft3qQA/csp7Gn8nWhm2R0h0HjUnAQIasg=;
 b=rEsmBr/TTmjAj7RtXjYIRtXKzrQvmp98o3bzI03Usf0muEukb/+Rxg3rs+fRRZmpUapSsT0ClCUbFMufp4jOj4OQiVU+l+DAGBxGQNnVPjqrVpQp6+3LhXchXPpZW1LzS+8vYI+cG4Lv7WfYXMVU1iXub2ZEPU0JDy9UoPGh5Pq0f08MxKT7YpdOpW3kIM/QU7mfRKh4S3RT3MChRcvwzpveF1dxdzJlIZhE1lw+2fn5pRjkiFFms6MHdkdYBgpZVBWV4qPrkUlh1afVDDTG362HEmG2FizamJQ1bu/DsFAYKGOGwMmS4Kyjy4PSsL6IY6YhS8uUNaAMPqXNfk3f2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xXjUrZ/Ixft3qQA/csp7Gn8nWhm2R0h0HjUnAQIasg=;
 b=zOtytNmh3aBCRHYvOhStasAjPj9ZJF+sDRyYzZcd1kB2bzIg/MbBe899lAXbXm+2GTaQNo5QtCqPz2nhWIXZ8sUqAjQqxILZK/LdAlV2f7egJSHpwzUVXPQUEFW2TJJhlxTy1CjUtwEi5IdjcazZq6FaMBt+ppheo1XiL5PNv0r3JMrAlOazs0XHpumgoDYNFMHn2L33k2EZIcXr4wW53xP6u//ClNsjiCifS8VXkXTj7xA9x6M+STA429MTiagy+xBHlkmJ7ALT4FucSFbHBoLBEriwsLoWeeEpA2NAKqaH2v/KZi/TcVd+6OzHTT3bg9NOOCzaVLQ0h+MFPWJCOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by BR0PR10MB386158.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:2c8:5c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Wed, 19 Aug
 2026 12:16:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 12:16:03 +0000
Message-ID: <4193f496-a0d9-44be-b90c-0930e0bd78b4@siemens.com>
Date: Wed, 19 Aug 2026 14:15:59 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] README: Document the QEMU version requirement
 for fTPM/UEFI key storage
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:408:ee::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|BR0PR10MB386158:EE_
X-MS-Office365-Filtering-Correlation-Id: b6a37d9d-76d3-46ff-444b-08defdeba31e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|11063799006|10067099003|56012099006|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	MTZGnZEtELaZPIOY8Lp5V98K/Z+BCsJAzCMXJIqK6QviNN+C3qcOExN2xskThCfPRFdbtQFnbuG9Ap0kXUl3n0WjRVD9DUKuT0NTBYjnEl9+mSwO4ptVebLyQQi8aBg3nRI2k5aqzujil1frIaqNJz8ZsY5n+uR+M95kaMMi4zFRSLzXwjDvKymNJ8LwYes8sQL0RwBLsBZdNVB5g6XKyXH58oW0ScH/s8oyy7PMqjXgyxysn17p8UEa4LlPyQCdHHHG2JUSUeGUldCB567pPurKT2/lQLJ9z83e8AG+yhczZDGPpcdXIyWLVD+RxQYJhlLMak3XXJYuNL+RtPTxoARaCIkp5EvYSZhfoqMD+bn19mObK6rwltLBHezaR21frX1HOFoZ7ZChSQaoBVz2np+yAbeoHhScpcmQgIW1rPOJn/lHy7meDkTtlSWVUunbwpvEFDVhCRfSzWKEHlC68tM7CV3asclnwsp5HKJeWi7qGXEvHkSTZQfTxaex0lKCs4HEH+IGI+tljZXLiF8hqmApJ3SetiqWhC6K19tsTtMHTLbibUxQMuXIgEV3cQvkTPu3PbHBbawQaNVT5R5a8AOQm+QBUAW9s/J+pIwSgqcO9STCz1A9DytF+wAgiGFnFB18ysD5t6QjmdCA/LvT8ff25VfbgD5NhzPS5bAW7Xc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(11063799006)(10067099003)(56012099006)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NmJmQm1JTjFSRTcybG5rS2x0Nm1TZi9KNXJqT1Y2RCttRjcvZTU3LzJPN2FN?=
 =?utf-8?B?eVo5TDZIWVQzTTFram9wYkJ5SkZuNExLSnBTbkFBdlJpeUVLREg3cEd5ek5U?=
 =?utf-8?B?c0lXQmVpcklETzdWcXBCMmp5U3BjZFljNXMrMFFxRGdUcCtUMFJQWmU5c0pS?=
 =?utf-8?B?Sk5CbFZYZU9HMG82L0xidWRpUG9kejF4ZFV1RnptTUxkWGtncXI3dTVER3FK?=
 =?utf-8?B?YUNDS05PM2U0ZnVnZFEwaHcwVUFrVk9OOUp4Yi9hUldSNEUyeFFJZ3lnM2xK?=
 =?utf-8?B?QXVNV2lqUXZ6c3U0OW9OUDZwdkkrWVVuNVdFdWM5c3FZK2RpSXJTemRHY2pX?=
 =?utf-8?B?K3BaNHlRWlpkcUhQbkVkMTUzdzhCSk8yNGdOUDVKVkRhNHB5a0JwbzNTT3Ev?=
 =?utf-8?B?cllrYXY1Ui80Ty8xeE1SeDR2c2h0Ri8wNGpteGZPUHJKKyszcmNIaXlRM2o4?=
 =?utf-8?B?Y09YNE9kcGVNY0VwTUpjYW1IOHd5TkFSdEdqTnowVnVBY0c1eW9xbW44bHE1?=
 =?utf-8?B?WnpaYXE3UTBPYzRGSENURU1QdFZCRURFYWV0NThKbE10YVltVGFxQzlnL3ll?=
 =?utf-8?B?aXNMOHQ0MFNWdFNicWczclZkSjFwcGFqT3ArcVhUeE0ybEZTd0hlWnk5dnpT?=
 =?utf-8?B?c2FwRzJscjZJdzhwQ1I1aHJlR3htRjJqd2kvamo1V0VTdktPekhudWNkQjY4?=
 =?utf-8?B?WEtkTzdBZTBEbkMwZnVabW92dVYxaVMwMzY5SEdiREdSNlI5SlpBMkk1Z3JR?=
 =?utf-8?B?YUxJKytLbllwYm5BZldCT2sxRVc3L0NPT3hzRDlPMmVrSnJiN2NJNlNnb0kr?=
 =?utf-8?B?eklDMDJxL2NFT0ZXeVlwVUtxdmQ2S3VQaFVkYjhlYXY1d2F5emt0Q1p0WTR1?=
 =?utf-8?B?VVZJa1dFSHROTXhWSDZSVExqbnl6UkVPWm9xNkF2L3BvMEliVWFlWGQ0RU5Q?=
 =?utf-8?B?eUptbWtvVFRVNGhZdVdNMUk3MVc5eU5SMzNQYVd2Umx2THRoY0RnQXlPQjVk?=
 =?utf-8?B?NEEybTB6a3FCTzF4b0tvQjJVT3pIcmZXdlpudm1aUDMrQjlqUEduTklvV29q?=
 =?utf-8?B?YmtKMG9UbzhHb3I0RmVDSXlUYWl5SUFaREN5THphZlJxSmx4WkhUQTgwVThl?=
 =?utf-8?B?M2tWbnVXYTNWdmxDV2Z5UFA1Q1R6VVpKWXFwMXdkWmxRSlBOMnQzalVudEw4?=
 =?utf-8?B?TWxXMHowZ0VkcmxyUXlsN3FiUEJwUFhYU0lEVkR5eUE5MzVQd09YKzk1UHN4?=
 =?utf-8?B?SmczL2duY2xvcE1jb0ZIQkNZMloyYWlBRnFva21jQytBMzVkTWhNNmluMWpQ?=
 =?utf-8?B?ejJ6cUx2UkRjZFdhbWRLN1RHSGVGLzYwaUFCNWtidkEydndxa1NXVk4xd3hs?=
 =?utf-8?B?a21Eb0pIbWhPM1VLYnRFS1VIN2huREMvOTVBVmRwcW9nU0xlT01OL1ljNm5v?=
 =?utf-8?B?YWd1ejk4YXNTSzNxNzRtZkxVL3lIbE55V1FiNVJtTExkWnFOVm1lOGFXK2lF?=
 =?utf-8?B?R1Q3Y2doOWwrZFVGcktXbTc2TVErTWxpZTk3Q2FDNjNsQnQrbDdWZFVuUm5k?=
 =?utf-8?B?T3V4QVc1WFU0NTdRWkVCcmJUbi9QWGRGdml4T2ppbGVqUXQ5cWtJUnlzSFN0?=
 =?utf-8?B?STNvem1jdnRpNzNkR0U3ZnYxUm10NW5Lb25IZERTS0drRkZOMmZYUDBTWnNB?=
 =?utf-8?B?dlFlZXhDUHFMbWJnYnRnRk83UnFlOEFWeDRUVEFxT3ZTRUhlQnRPWDdHNXp6?=
 =?utf-8?B?YTZNWnJ3dXpnVVM5T3BGUWxrcmQ5Yzh1VTlsZkczdU5yWFR4TXVySVArd2Nh?=
 =?utf-8?B?Y1ozQVF2N01ZOUpEbklhaVhyNWZTTE90d0hzdTdJNlBvekQ1M05TZGd3WkZ4?=
 =?utf-8?B?SVpnR1ZnM1FiOUUrU1Fva0VMRlB1RUcwbnRKNEhNZ2xOVmN0ZTNWV1JhbW90?=
 =?utf-8?B?Z2JWaS9kYzNrTHNaWWMxZFFGaFhtNUlIZTdiWXpDMmUxc2hTaDQrVXRwaGdq?=
 =?utf-8?B?OHJ1elNabGc5blpSRFlQZFk2YTdqZVUvbUFqbk5veThHdGt4Wk5zTFZUU25P?=
 =?utf-8?B?elRlUmJ6RWpCckthVGp5T0ttL1I1alp6U3dJNThzU2ptem1mYTUxTCtWZi9y?=
 =?utf-8?B?MUlNcVBuNDQ2dUNiVHhDYzgvSFA2RGFqbWljRjJoRFFNNENyUmt0dzUzSDd1?=
 =?utf-8?B?NHRPblZEaXhCR3JSQmR1OHo2bUI4aFJ5TVJLMmdNU3EyL2V0RU5TNFY1TUpL?=
 =?utf-8?B?a1pyTDVxT2RJSEo1citBdnNvclFYZFlsUW85eEpmamRmYlFvekNERjQyVmIv?=
 =?utf-8?B?VnpKTnRkcHNYYkxMbkdYeW9RaHhua0EydHFiVjdZVjdCa0tIeU1Sdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a37d9d-76d3-46ff-444b-08defdeba31e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 12:16:03.1111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /iqOGDo5Qf6gV3vn6KGj3newDzavITlXxBeO/rQ4zrn3dTMXFIKQ1Obz4Qt9bYs9AQkl667dz08/RFYrXF/HKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR10MB386158
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Aug 2026 12:16:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23950

From: Jan Kiszka <jan.kiszka@siemens.com>

The is related to the RPMB emulation which was only introduced with the
v10.2.0 release.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 README.md | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/README.md b/README.md
index 435d0370..05291744 100644
--- a/README.md
+++ b/README.md
@@ -41,6 +41,9 @@ security image for QEMU can be started like this:
 
     TARGET_IMAGE=cip-core-image-security ./start-qemu.sh x86
 
+For using the Firmware TPM / UEFI key storage option with a virtual target
+(`kas/opt/ftpm-stmm.yml`), QEMU v10.2.0 or newer is required.
+
 Physical targets will generate ready-to-boot images under
 `build/tmp/deploy/images/`. To flash, e.g., the BeagleBone Black image to an SD
 card, run
-- 
2.47.3

