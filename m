Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F770C79F8C
	for <webhook@archiver.kernel.org>; Wed,  9 Sep 2026 10:05:05 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.28])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8159.1788948296231598405
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Sep 2026 03:04:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=eTutBz11;
 spf=pass (domain: siemens.com, ip: 52.101.84.28, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2M0ivuG83dQEtHlCebrwKUH8a+n0mupXEg04gwXfvYL5kPFrk7RoIr21TkIRwC0JCHyPmqqTsmaaU/9xLFiTf55DA/CPRr/3NF6IwPY0tcC2+FZNS/uedxPvsjmquAxeg2CWYnoB0eola8Dws3GmWkKycLrBQGEGRR8I7ZGIlChQF/sYo94zUkbQrdLY/bfUfiCTB0bxlmbpwn8g0U4UtauIw+O2DF2VZC2En2hZF6Gj8PyMb/EZKM6xttWj2i3Aelev7LT/vfrc1gkMhJM2CF4EeRvGrWaFQwhLs1K5q971bGuw3lH/UKu2Pk2hAHZvE815Bny+Jl9+dyNuj/2SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXscynHOYI6DxOYQyMRiIDIo9C+pknGV0SFhlVz0KwI=;
 b=hUIky2Caf4vErI6AeNtD1KHCzN3UEnb0GLoj6KpUsoHAPsbBqWLl9Ha6YPBQYZzZhQhzYHsj3rjqJNCBaIzcAHXzk91WygTvh7iBhS7EHkYwXw9lsTymJgLwkSd1srvJWlS9vBwz/PewgVy5yL3d3uL1Wg0O/Feikz+OXwfbw8hN5ZQP5vYsVovWUcIJvoRGd9G4fgBICADzfxFh0G6Q1jCyz9FE1s6Js2j4VB3JyZoIWuwIDIwxgv3OICdMVYpOEL1GN143ka+obMdQG4x8EGCZoOnUozsw0By0KvMiPNXv0uGSA5Q2I7X1JkHwatMWcempdp9CQAw0KxCHKpKBvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXscynHOYI6DxOYQyMRiIDIo9C+pknGV0SFhlVz0KwI=;
 b=eTutBz11VPfJ2BWcdsyf3uKQ0gPI9aXQd8QL+TCEY+bQG1Dw5yXqljYwGzYRvGvqged2ZFRE0A4TUzwBn/VD4yVEpfcwNpwvIAJVY8wSQWaF+AMruzIWhJhfx4V2BLpLbE1cp2tj69bndOk6Frqg9NX/kKHPyK0T3L2//p1K+u9TDw450jjGabMg0dx2dTlI+ydhZptaYxhSyYPTtLcIFab7uAuPhuRcmwpf2uX1u31gOz0J4uUdnjxod9J0cTZ9LLUMg/s/qV9PtaXQzVhTRDihE5S3JFMCtHk0w0jab60g/9jwOnuk36OuKMRCoqtQFXgBCZx3b5VPVob/yyGpHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB9915.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:601::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 10:04:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 10:04:51 +0000
Message-ID: <5e44f53f-cfef-41f7-a943-25494c319978@siemens.com>
Date: Wed, 9 Sep 2026 12:04:50 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] initramfs-crypt-hook: Also set watchdog when
 using u-boot-based firmware
Content-Language: en-US
Cc: Enes Colpan <enes.colpan@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB9915:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ddc3eb2-d1b9-44e0-48d1-08df0e59ca3c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10067099003|3023799007|18002099003|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	TrxjoCkeQ6BI7SBeFc/bCjMDAX/esbrCC1RTnLyT2EwDfwgAc2IS0n0bDimlttOnXiXbBM6tcZPpCP3kply6e0hvBm8PHfq50mn6ebTQ0Eneqa/9/boqGLwMNFfW0cF5lJKgGDjh49WUg5Pgt3aU02pU1jwyxI5mrPShk8HQRAH6KhYRmdntmbHjtrrSX7dWyCK7zq0mGJfrJSo3ScEnF7XF9mtcdiLPvrAjwGfPfaLXa0WIZlB3V+2WMWv9xAhi8Rx/TDhmOjlfiSmI108ta2YlpmrDZbKLzG70YFLW6fN5UZhCp77rIQ3u2g9rlHD8EqCFLe9u3NtlaB0odGq3J0AkAdPHbYpEvFVeD7UzHB/aQB+SgrrGc1ycszqkFoR4oIzcczC5Z6PtJiDkzRQMBEUyyLI0+AlUBxaJUeTRBq0UgqdLBeSFO5YGmNXOuuQ7ixaTfpAbxTiIFf04onTkJk7ncswifCD2c9JkGGroi1LFfXx8GYazgL8BQHmJXqeRdUCEuxXwzuEzQRTMuA05HFdw55FIPFF7XkmQ+7FxtB8zjp3z7tptW9Mqq95hTsjhrOYTCL7vsyFruLbg2LPn56R3rZ/TGt6/5SRw3+jOxNIPI3xyt7SqjdzHfE/62xMH9yyLWqqlBBU5i076T8wrSSFOi/jLJinseAmZo+X0dJ0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(3023799007)(18002099003)(55112099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZUd3LzhKQ2Y3cGpPQTRnekVLbkZkdWZuNm84QUwvOFc5cFZUcnlRRE5WTGFR?=
 =?utf-8?B?QTJiZjVLTnNRclhoMXozaVZYRzMzUjVHMFd1dllKb0F2OXA3bzVXZStOZG5P?=
 =?utf-8?B?dTQrNmpwL2dJQk1RMEVackhyRnNwTEd0RmxPa0U5MS8wTmRqQlJjQnBQcDJ6?=
 =?utf-8?B?U2hLbzNmN2tEVG5tN3dFOHlieWhpLzBnZDBuZzhFRHYzQVQ1NG9taDlQRE55?=
 =?utf-8?B?b3FwdmFIV3ExR00rYXJvWVg5SVRpejB2MEs2UVlrbjBEVDRWMjFlMkNrREtp?=
 =?utf-8?B?NGlwM2ZLSmpSRTVpMFkySzkwQzFmdHBkcFhkSnFuSTVFbU5PQlhBejlPN2RL?=
 =?utf-8?B?KzhndE4wSmhvUWZyc2docldXN0lRNGNKV2tUbXlNc0kwYzJDRkEySU5XSnIy?=
 =?utf-8?B?SHhxK0UxNDJXRG1jL0xsZDdUOVpRWE5wb0FEQXZRbCtqUzdzY2JWMWE2SmR1?=
 =?utf-8?B?eTROSTlBS00wWDkvWnhJRlRUcGYyaFI2Z2lYU01wckpoYmw3RktFVlVKRVpx?=
 =?utf-8?B?T0VYaTlUUmtma3BYZzdEZlpYM0ZCbG50enAwUnRuZmN5WnlFcUY4eU9Dc3k5?=
 =?utf-8?B?OUYwbFRZWmUvVHBXK0ZucDdJbVRHTHBLZTNndUpsYnUzYXhrLzlzeXJxVEVh?=
 =?utf-8?B?L1ZjY0NKeTgrdnl2UVA2QTJIU1Eyd25yVjluMGVFcC9GNlpPeEtUTktNbDNO?=
 =?utf-8?B?VFkvOGJldmszcjdZSEJjK2tQNE1sVXJZckR4b3NPU3ZycVhhVVVRVHdEUGJa?=
 =?utf-8?B?VmswVVQ3bXpvcHJsZ3Z3UkJFTXEzTEh3OTZNenJIeUwybGc3cXNoNko0dzlT?=
 =?utf-8?B?ejhwTWQ1cUpFa0M0R2tJbzVGS2Y2NU92WkZSaENqMUsxWFc2WkFoV2tEZlZm?=
 =?utf-8?B?eXJWT0NGcjhvSGkvTWRQQmM0WVN0d3c2SzM5Si9BdTVaVStKdDdTMkUwaFhD?=
 =?utf-8?B?NG13alY2TGwzQXJtOXp4aTVORzJkdlZmYTNKSEV1UTdYcDlMRk40QmtpajN0?=
 =?utf-8?B?aXo2c2ptQWpzOHg4RzJZekVQc1A2YjhoSE1oN3lBbkVZRG1ubEE0VE83ZjlE?=
 =?utf-8?B?OVZhMlRLVjhySzc2U0dOYzIwRzVqSlliMXI4REQ2ZjIrWVo5WGRYTGVSNW50?=
 =?utf-8?B?SlQ0S0J5NFdyVjNoQkdjUW52N3M0Z1N3RFVVbDhSUWF2clBCZ20xdnZiZkg4?=
 =?utf-8?B?ZnhEZFg3R2hWT0NIb3BQenNjeU1PZ3dUbXppRiszcFVQTVFJUE1NbStHZTRW?=
 =?utf-8?B?QUtMR1VPZ3ZyVG41MmpDVUFGS04rS2l0QmE5QkFPeVFXQTN2cnVEREdINEto?=
 =?utf-8?B?NGpOVDhULzJDWXQvUWlTcDF3c3FaRWpmNSt0b1JvcTZjL3J3eVNSbVNJTXNt?=
 =?utf-8?B?L2N5OExSeGQ2MFBFa3VTREZaWEswNHhmS29STTM1TEJFQUhpb1dtZ1EwV1c4?=
 =?utf-8?B?WWMyZCsydmY4UkZJTDV5QUtQbzJoRU40bXpnN0VqVHFiK25XbC9qMkNhKytF?=
 =?utf-8?B?eExRYU11Zk5MRzBFd3lZdHlmQWRqRytlbkJKSzJZT0FLVjFZbDFBRGxXbllT?=
 =?utf-8?B?Y2lSa3hhM2M4c0c1RlhWZVlNYzM0YktIckhIbTdNOTBuQWNMSHJFb2MwQXBY?=
 =?utf-8?B?WjN5SXRQV2hDQTRSMjZSai83ZE1yeFd3WmhZYkV6Mmw3Z1lzV0V2azhFN1dZ?=
 =?utf-8?B?K3JNVXVZdkpMSmRyL2FYMGxYRzBQTERyeE9qYXdveDNUQVZmeDlrbmQrR0N5?=
 =?utf-8?B?UHk5S1p6SS9JL08rajlTL084ZngrM3hUYWNFdU5qbGREc3FmWXppaXgzV3Bz?=
 =?utf-8?B?aGdlM3pBNTdFRDFHRUpEdW9peU5aenNIWWtMN2xqRVRVRTZSU2R5WGw4Q2dV?=
 =?utf-8?B?MUQ3N0ttQldjTEk2RnBpTGdaWHQ2QWV1TlA4UnhsWnViQzNEbGxFSFpaVVRW?=
 =?utf-8?B?YUhLc3FmUHYxVWFGQVFnTmxVRjYvaTNIcG5pRW9WTmpxWFBtL2ZhZmRySzlP?=
 =?utf-8?B?aEFaUXFPQnpTbmxEU2ZiSlQvR0Uya3pmMHdxUStiS09ScUdVRkFxQW5xNkx4?=
 =?utf-8?B?QVJsV1p0SGlOQ0Q2SVl2dGVWS3BZTzZSQkVNT1A2cEw5T2htWlYxREtJNk9y?=
 =?utf-8?B?bE5tZkdscFpQQmQ5V2svazVzeEN4NUJJTDJZY09YK0VvNk5Lb0Y1MnFZQ1Rz?=
 =?utf-8?B?VytaZnZlWm1wSVllRUlWR2htT2FHZXBFMWxpQTNKV1pMdFpWZ0xuU3g1eEtV?=
 =?utf-8?B?Q2g1YjVoNnFVa2NLZTNSaXRMU2xRYytwR3ZwQTh3VWJ1THM2MFJ5N0NYK0lT?=
 =?utf-8?B?S1BkanQyakdZcHZqMDNNQS90R042Uzl2UVJNSlBnaW1oUW1RVno3Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddc3eb2-d1b9-44e0-48d1-08df0e59ca3c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:04:51.8611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9YjGuaULNbdyV/fM2NCvi8f5OiLZRIbbOPDXdQHbOmER795jPMWuq7c6ZOB+b82Jbl0sZDMQCnS66IU287mVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB9915
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Sep 2026 10:05:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24108

From: Jan Kiszka <jan.kiszka@siemens.com>

In our integration, enabling fTPM/StMM implies the usage of a
U-Boot-based firmware which may enable a watchdog early. Make sure we
are feeding it while encrypting partitions.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Enes, you noticed this downstream already. We have the same issue here 
as well, just not stressed yet.

 .../initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb         | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
index 49ccc076..7d198582 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
@@ -91,7 +91,9 @@ CRYPT_CREATE_FILE_SYSTEM_CMD ??= "/usr/sbin/mke2fs -t ext4"
 # Timeout for creating / re-encrypting partitions on first boot
 CRYPT_SETUP_TIMEOUT ??= "600"
 # Watchdog to service during the initial setup of the crypto partitions
-INITRAMFS_WATCHDOG_DEVICE ??= "${@'/dev/watchdog' if int(d.getVar('WDOG_TIMEOUT') or 0) > 0 else ''}"
+INITRAMFS_WATCHDOG_DEVICE ??= "${@'/dev/watchdog' \
+    if int(d.getVar('WDOG_TIMEOUT') or 0) > 0 \
+        or 'ftpm-stmm' in d.getVar('OVERRIDES').split(':') else ''}"
 # clevis needs tpm hash algorithm type
 CRYPT_HASH_TYPE ??= "sha256"
 CRYPT_KEY_ALGORITHM ??= "ecc"
-- 
2.47.3

