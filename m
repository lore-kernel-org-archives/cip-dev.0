Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD65AC9830B
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 15:44:58 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.14])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.880.1790178292496210805
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Sep 2026 08:44:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tSVo+zZ7;
 spf=pass (domain: siemens.com, ip: 52.101.69.14, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXLPn5qUG7eq3VcHyJ6JHQ7XeqgdZMIg33hW7UrVHlwS8Nd+3s03+37mfly6djKpAr9Cq1GrEdrJWZi9Mqi+GfpCtEIZ/ebWfP2+okiP7OG5OxXQpCGsEa4JA79KKKsqYz4TQMNdYq8zEJd43Cwesmeni3uyCR6LZ7LWH9yw/scTbqXkjEmckOC3p8KfLDJNtJBw+9Q6XBlejmXhzCVlCAxztfiiJrbwULAyZI3oCcJy7qzp7Gyfh+if1VkCRfFCZXmN14WMEHyUEw75GvwkavfbXyU5urrsdA8IDExBzMpJPIT1YyDNxjc8s1iNQcNkjrK5+sRyTmgGsZpwk4CtJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqIgzEmOPAUoA+Vysx/oswU96c4sDUqGXOZ2HNAqx3A=;
 b=er6WU+n/ldm1P1D9iY5Qo2/UU4kzr/ZW0KmdJPrOF83/WsTe8cBM1WRC0pl9V6cDp4DznszYV/tdGBWSnQ0MVyRSKFVG1BSfdidThH26E8DMuDhVSJDXoxmtca25i6uh0TQLPj66mRlwKpIUgVYXmSifMvhfht76LTzP83GW1UNRhQ1BAnnQLzBuzMXDejNOJOPH6WDqFGcIn+d7VoW/igM9yK+YXSqdnjFXSwXAaUnJHuge+8jxGPSbmv5ArU/+1Qp8YDQ8Hr3LdG/nFux6RThsfAeJLD3zQ2ac4gRZ1H7ZL4yflp07EZ0x6gNOlTkpXVmA3OoE39E0Tthji6u6bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqIgzEmOPAUoA+Vysx/oswU96c4sDUqGXOZ2HNAqx3A=;
 b=tSVo+zZ7mQjVslndB8hiWCno+llYaYGLGcGbMb8Tbhy21RuIMQ46GBLVNsSmgv6G0BxGkXMkIuB61VfROFUjRmHuoZqrtUgYDcRkCmoEI7gqFKN9vjG5Sq27AanutCbbI+h7PViJ3z40h0jXkblYcMdWxJNzYZBi3Sjs2otGT6ORTn5Kxy8XuR2cea9qCQsZsklGXx6bMqBDs6V5ScZDlyzZZ7I8vkftrXCvDoMmJy/4SRTHHu4TLNleZEIvSj40y4iMRnSiNuNIuIFih86dAwHRvtmGQFeJIQfpR7d65XegTEdb1IWHRkxNNDRdYNmzhJNJT6jBkc6oOae6ml8YcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PA3PR10MB9310.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 15:44:47 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 15:44:47 +0000
Message-ID: <1f1cf2b0-f3d7-4f2a-9a78-b30765b42ef9@siemens.com>
Date: Wed, 23 Sep 2026 17:44:46 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] secure-boot-secrets: Strip passphrase from
 forky key
Content-Language: en-US
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::19) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PA3PR10MB9310:EE_
X-MS-Office365-Filtering-Correlation-Id: f762a63e-51d9-4083-5ce5-08df198998c8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|10067099003|4133799003|6133799003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	S8gauN4lwOn2b2SXfO/cgqGAGvDdmcehAy5JLWhVeJoXhBdapqOQP0yD7DbOVPso66lOrnlPIL3m36oyqpz1UPlwkDEl7koaL4hBugg5yHlXm09oMdBtdWOreMG4Sb072yn7h7T2vtL7XLCBJciLz28FB5VoVMoCDXPhRx7JWGJ43zDcFDZl8K0O3knDUt/xwxFy6xipWcF5MknRnSxTaliTTxNMbP0R9iHzCgdzTXwV3jhwcz0miquMForSo1CUEv5dIJx9E5YHKDk0AZnjNkO2cNUeT9MgnyOAYi0Qe7y+XwuxhjfxctRVa3CN//elWsLLJ4rxui4+S1l8zj9hxYA8rsuzBZD984XUmt4XW189pDL6XpZToui/dwmp3cSXKANnbEOlqlQN0q9na1308yAi95AkuEB7Nz0I2GNmI9JbtVWKS+cDUD/IumBqtQpUtyzJ5RpYQXEsSwNUseCVunG2QYIYbbPk29/bBqivL1NnSng8iopQXi9D1POPUvxlRICQbMHmOc7WdO6BE3n3VDXKauNEW0H/adPQXT2EA3uLcQX4g97U3XB0LvwFh9LeCnYD1x5I1qLV6s+UKSHra3IrBkxo6Z/xlRSUtDaLIjEWPqxCLI0xOXLNOT6tYWyFDvFzT8lufcj11uMJ6Q8v+X71mIRqjzhpAj8Jjlp8crg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(4133799003)(6133799003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WU9TOGxIL29VQkVQamRwb3dZb0tBcTdjaitLZ3hRQXNtNDdvQlVGaFZFaEd6?=
 =?utf-8?B?TjVkbnZHYnJRUURsWmpFejg5M1hwMmNWbkF4eFZEaXhpM3RFWVVJR0MrNG1P?=
 =?utf-8?B?UVpyNG1BS2RkRXJrU3Jzd1g5R0xIWk5ZQXVsS08vOXlyWGloMU52NEw0ZlZ3?=
 =?utf-8?B?Mmt6Q0VGSmZ5SkUrbzVIcS9ibUpkc3hRV3hKSVMyYUhEaTVQekt3dUp4RVd6?=
 =?utf-8?B?bzhYMFRwSVNQSVFvN0txenR2YUl3NTg0UVlsRUgzWDJlTXN1dFhQSzN2UXRW?=
 =?utf-8?B?OFZjZFVpQlVCc2RJL2NFci9aVG5Ca1JkbGI1SFpTOTJrL1lUR0pEejFyekJ1?=
 =?utf-8?B?T2NndWtWL3B2bUI1SEcwRlR3bXBFSEhEVHNpckkvMWk5K2oycTBuSTFwMlZH?=
 =?utf-8?B?dGtYSnJwdTk3ZXJ3cTlPY2htb3lLZGpkeXhlK2Z6WmpUODgrT29Sb254djhz?=
 =?utf-8?B?Nm1MQnpXTnh1RkZkc2pNeGJXejdCZFNpZ3dnNmhpQzR5Ulk5dnlONG1nTWZD?=
 =?utf-8?B?SmU1Q3loL3NYb2gwcFBNZnBET092am5PcFljZ0VBQnFVUVY1S0JvenhHNU02?=
 =?utf-8?B?b0VZZUc1bFdmRjZiUDM3L0RWNXhyUGFGL2phQWJ1RHMrTVBaWWVuNmhlTnN5?=
 =?utf-8?B?d2pFV0dxeit3NVlNWjJhVXRCanZ1akFhLzh4dkVtU2hyVGtRNVZkQVZLbVNy?=
 =?utf-8?B?azRVc2tadDRKWi9zWEhEVXV2SU5tNnJKZi82Y28yZUd2eXVaa293NmJHU0Ja?=
 =?utf-8?B?eVduc2YrMHEwUnNUNm5nQW56aG5LMnA1aDlvYUJIdUhpeFRyaWdYRmNlVEpK?=
 =?utf-8?B?Z3lPdTdnb3E4SUtvbDJEZVVQek1UVmZCZkF1ZlNBS3pCMzN0ZXZzc09zSlQw?=
 =?utf-8?B?czAvaHRuQlBnZk9wL2pqMHRVMkdNOXZXdTN6dUo2MEFERFJxQVhyM0NETndC?=
 =?utf-8?B?WXZyamVvMThRcTRlQ1cwN1VJQTIrZUtRdWwxYkZFNUswT0FWakJJQnYxNnNN?=
 =?utf-8?B?RkYzVFRqNjhPZTBoZjRyS3hQK2VFWVB6R0lPaSsyWXhiemZYbk45YlpLd1Ft?=
 =?utf-8?B?cVNFVTJkVlJKRi8raitaN0FaUWdBdUY2SWdKcjBRUDcvUjh1eFoyY0k2Sk52?=
 =?utf-8?B?amlwTzBNRWEzMzU2Mzc5eVpqV3dHNnIrR0FwVGhJQ05tNXo3ZThCWVpyMWhE?=
 =?utf-8?B?WXpITjhldkVtMEpQTFNiNDk3SEVIUFB6M0lzdGJveE1lNmJWTzNzcmdGY0I2?=
 =?utf-8?B?NTVIRTIxaEI3TmJlakZQR3IweXVIeVNrYmN0UEhlWmp6M0JXWXc5a0p3eitj?=
 =?utf-8?B?Vk9vL3VtS2dVNVVvT2hmUjluVFRVME0vVWV0QWg4SUZmNGZpT1gzVmJIdlZ5?=
 =?utf-8?B?NE9tOGMvdXdFekZjOGIzQ1FjUThrTEhTZUMyNlRkZVNqRFJtNS94V1RVS0R3?=
 =?utf-8?B?WCs4MGpOdlFIdjFoSkEyd0Y4Snhmdkk5SWRhSTZ4cUN2bjdaTlhTUno3YzFG?=
 =?utf-8?B?bUoyTjVGUVV6eVNTMDFDUDV3L2Q2R3NYUHNKWnpjRWhqYThOTG1aMEd0ME8x?=
 =?utf-8?B?NWFReTBGRm43eTRWSk9Xb01YbCt4YUNsdU5XNjNmeDczNXhseDlEa1FpTFBI?=
 =?utf-8?B?US9Cc2pkb2UyOWc4enJqd3BLNmlkUE05NGdRRHhzVkJRY3FMR04wNStiRjc0?=
 =?utf-8?B?ekcxcytKem9RbnJBVi9hVTM3TE11Uko0aG1iNWp6UzZ4N0Z1aExYR1BxT2h1?=
 =?utf-8?B?YWtsUjJQRSthQ3h6RWlYMjVLdzF5RkdYYlZwenBaczFWOW5OWnNtODF2b3R5?=
 =?utf-8?B?N2ZteFRTU3NTVzIxNlhzNXJSWThxRUoyNlEyZlYrTEVMRkVVeXhLendIM1RI?=
 =?utf-8?B?Q1J6TEtJaVZacllUOUJ0RURCRU4zVDZ4OE52MHZrSC83WG9TWHhpQU43c2dL?=
 =?utf-8?B?bS9DcGhmeVZUZVRkUS83elRJVGZiTlA3ZHY5a1JvMmZ0ZGIrRFc5emlQSjFY?=
 =?utf-8?B?R0loSTVRYXl0OUZvUzZXYzNCaDErTy84RTJqUzM2MUNpVjhTUWU3L3RLZ09M?=
 =?utf-8?B?RE4wSEpCUDRQNnMvSjFBVGFqbVRaR3ZCSWtBblVsVTRpY3hURzNFTWdhWTRY?=
 =?utf-8?B?clpZVlhpbnB1RVNaSTRkenhCMWYrTjZ4V3YyK0FuNk1TS3hHSE1LOUlxbGpC?=
 =?utf-8?B?MXpURllPY3NFUmZwaVdGOVFnWjlPblVydG1scVpiT1pUVXFJQml1eUpuNVVn?=
 =?utf-8?B?NHRWelZ5QStraS82VENleVFuUmxkOUc2cGdEcWg2ZTVQcmlxenQvd3o5cjYv?=
 =?utf-8?B?VDZPUUhqcEJtL0VoSjE3SktHQmpRYVhjTlA1Rm9tSDJmNW9JeDROUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f762a63e-51d9-4083-5ce5-08df198998c8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:44:47.5966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 866R3R9PVaaBpqeRYCqpDgfSwJsirY2b5dDfPv0yW95NYEckK28+v/Zia9Rv7npbw/qLbTEuQx2flxDoOKJc0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9310
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Sep 2026 15:44:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24277

From: Jan Kiszka <jan.kiszka@siemens.com>

Breaks our recipes and CI.

Fixes: 9848be3257e5 ("Enable the support of Debian forky based builds")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../files/forky/PkKek-1-snakeoil.key          | 58 +++++++++----------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.key b/recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.key
index dd7f492c..24a5837a 100644
--- a/recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.key
+++ b/recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.key
@@ -1,30 +1,28 @@
------BEGIN ENCRYPTED PRIVATE KEY-----
-MIIFHDBOBgkqhkiG9w0BBQ0wQTApBgkqhkiG9w0BBQwwHAQIs4RXCLmGLJgCAggA
-MAwGCCqGSIb3DQIJBQAwFAYIKoZIhvcNAwcECHer6014IEhGBIIEyO8O2zL8CJwV
-auQpWLJsMMWxu2aSh1WadX9+rg+O61mukuS4rQSH5shMQ2krZZKzyXx0q8+2AySD
-EtDXwhLvep60gUxOoNqK1+l3AxSFfIGOY8NC6yW67VX+G09ajWpgHj3ox63VRW8v
-6mA8TFWYbOIwB8J7ScF4NszVwyiUnW13oKi7svoBM3LYYG2IMvre+gOvyMGfM8uv
-X3txcYqAjhRV6n7vGo9LRLIIRSPKzaJbm/W7nT38LRUJP8JMSQUOPKgeEwQvOTVZ
-+1kd7WeaGZrjagTDM4yhBjpOmB3D8aeT6xkjBlUwuddPzbdi0N7GrU520RcJMjxt
-JMyOgabHKUKmPTX4m0ZCKi2jSILi7/6fBF+TZDxpakLwAwpTzm6kXArXb6AYtTEX
-GPihB4O69ZgEc90jp3EnZt7HtKZn1HTbPNQAlWgvESgJ7hWHnTlM5Obqnyb78tj5
-VdcOfTSQRYmw4Rh/lSUX0vQLhdmYSVLiMFFvT4IepXZgQ6McIdcvqoVrPgr0HoVz
-5YILZdmbs80VcgYL853lMfQ84kRwUcw8jNyz7mBK7V7rE5QhaF5lunZ/R41ZRXRy
-1ys1rNvLPvtOq/K51+A9U+h5lLM9LjeoOR+IUk2Vg4aIap+Z+lxbImH0gcJTrpem
-ctA/2sBjLN7w811EjB/Tlu2awzbsKLpIDFVGHiGBI2zb41gtPd2RkijmiZab6nuM
-ETg4ad3GscMoa++01oX/lrnVe386ECSjurmThb7I01eTNZrBlNsLyBeFzlEIEoBR
-TqUXHLiDACxzL6U4vWzdnvVrCOW9fwvJJqChj7Wy822w2LXxVhOryNujBmZCmOht
-mgDaJ15QiF+DACcX6VoBbm/462z+9Skxa0DqGwGzMOD5HldwvQSyZSykk/BzGFWP
-rXfLYoMjN+dgA/yNfem64ayGsmoPUAjnsE4YasD58UVO0XwwtdMGJSOVmkdyWMcM
-t+lN74kX/gmIvciK06N6prBfowgBEIJ6ev2dzlydSN8rGORmQ+OFzjP14rT0O+1Q
-O48yR2ZZ9jl4YPUKSFJ3EUc/Qt9vO+chNiNYSy6TABGXur0WWiDvGURG9K5fWTqq
-U2KydSRoYD5iF0caOgMZecNhZV+4CX927j3XuuKKx49qTAt3WMtmJ/UQFHMtQ833
-XDFWHpEKDImfHfyiB1f8bOmqYmPuE6Shup0UMJsMFel4QVJM0Jn9+wHw/0qqPiS3
-a769S/u9U2dfyZY5PfymY8UjFRMDtLaUoJSRaGp6RNc6LynuMMKdzho0GwvL3+m9
-xKLDbbks8hVdmtcxxDKiio+F0hp3yc/2PyA/VGAlARiGp7876WTCZox9Bwnf6lkS
-k9eYLSabe/r3Ag1SbWEGpFk3VO37qCyfp2xTfrHXK1ZJlvFwj3FFSprUaMrV+81K
-FCEcSozXpVsQ7e7d11A7S8rTbtp09Q/J2oxyR0A9lk/ia5Qd/xwbPl4QJcWK2Jar
-K3yFK8VrUNib7CjI1kdB479KIllD8oK6druBkzwGzFxDtcl47RlfkqW96XSQT7x/
-h/YKSLcpMx9x9TJd2GDKj2t4oE9eGTBC0YbdH+HJNSrjEsWkjgY6Uw++S6VzKvQZ
-DDsMJfxwcChc2zKRou+BFA==
------END ENCRYPTED PRIVATE KEY-----
+-----BEGIN PRIVATE KEY-----
+MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDIi65d6LmojD5S
+9q8vE/LI2HHQboiO5/1KrFVc6kpxD6XdkJwpBoItYIfSls9CPnzvNWOAxR3hIeBd
+1U/prAPPxvQ1wuDLMXfWkcGaYHfPnme/YluAjnpuLH1MQcumgOzj5xYBvZZk+Rby
+tX/phH7FW4Tx+L1oBYnsfh3BSE/NTtEEHV1nXAXpa/dvyefWMlrlbwjfM5362lZz
+M6yrJGcOcWEyI66UYCIVO2Yhe/ZVF5B/tPGtd2oACz11xLeqLPM1WBjlekAG2Zi7
+UCPIvDCpdn5uVna2ZRQmJyDDdh0Ja2VMC19dkMd/5nOAI21O+FvYPOkBWYX8f4Dz
+DyVQlmIFAgMBAAECggEAERP8FFk2Pkk7IXuKbZroSPxNrO9Mx8avxkUou9Hj5v7r
+JBQliETanxyiVGetXLnPj9tfDt86bSqiXbtFo+OXK4GI2G8xD3y19NrSvt/KNC8M
+LLsmiasYd/tn7C+KNTKzebD7KcjIXu7ral3Ud8Flvk7N4oFJN+uI1E/lHsmWqigO
+X470lWWe+UkhoV7WtfaxDFnsXyBUg0ogkO+ftlnSjfnW4gyMourCaWJQs9ONnZl5
+4mqeQHSkVxZnMR/bACeuuCVhF2efXSg3OEHpxcwcl64Q551cQItm2bKdHDV1Zkr3
+5eS7WMQCpNYCgjQ4iOt9hjOe3B7+RpvzD9FPuiMUYQKBgQD2saG2ZJCKKbaH7eIb
+Jc1MRCIQ4UUvsTz/WJt9aLe/MOGgsBGucfWnjkM+CcvrrjEsdchSXr/C2jv0iP/a
+oD2anTnidUnhfgBCCrfEJP/nucvRAd9AtppV3M0ijPiMlPdw7SBhwEArgGD50YZD
+plStFG3pWQcb9bp9bQPV7s+cSQKBgQDQHGMmvhKE1dvsnhgNDbi5LCZzYTUiBfkW
+Me78kwoKLIgNZCSvG1V0gv2/r6SZh5zLEUlLdDKvdmo4erA3Wy9i4H8IfIqDp0ev
+MnJkVOPxyvyHRkosO7bFk0XF8EiOfm+K1Jdb2rfjvugUb/fQTDXZh57g2ENCRoS4
+H8hz37K/3QKBgHbLTSsuvCe8NIi6deJKztTGDn2AbTetKslvmtjGP42S9WPSxYDy
+obABIsJSJ1+jr0xQn5mCxOcI/kwgWMyn02KMCd7SSjSK34bt8FZE1vJ4lvxb4W0h
+QarNO/9CUUIpTgqUNb68vGn2VTyXuAcFpsr+BnuTAohlSVuyzmELse/5AoGBAKxA
+EsEqaWGRMSqz3+xOAyshI+Iz/ypeD0ETq19axOCO4z1SOhrFYQHCugxCcNayrFBX
+ynatgpZASMLeqaPn0Vzhu8Nmca9ucaLM+mmY6eJjxIii4RmjgzAdKY8fxq5KcEBU
+ncLlUXcruCPSWScLLTcTTamE1oawn4FWrS9bZDPxAoGAQHlEqLAmGAZADaj40kop
+RQIMz2IGw7VjLdDC0NaKgopx0CTF1ODfFH5e0l1eroyQIxYzl6be/oYc9x57GfzU
+VlPEYFsgwFg2nRKniqz/eUrriWfyblC23F7vQdW2un0eEbmgUnd9S4s9xikTYYyA
+8z18hsBaH0ZngalMu49G1aA=
+-----END PRIVATE KEY-----
-- 
2.47.3

