Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AFEC98304
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 16:17:46 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1723.1790180257720428172
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Sep 2026 09:17:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=p/JORBvy;
 spf=pass (domain: siemens.com, ip: 52.101.69.9, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnAWbqTav+zGbxnyujAoMdtxeFPeLef6ReZHbNww3M63P5zxZBSLvlAHyaTfRSOoP5aL/Zv8MHDTwaqUlK2nlF3nUWSs6gBAXkMjH2fHjPD5z6HpNYtarlPjtVfKza7R4xPsKicRcw5MiSgrkVsRhDrjDtJkrT/QviEv674GNnHgJJxcK6UbQPjqMMCHK/5qDntW0XQc3VlwEi6yDY3X+BNPNPUWaXQ9pVScO9v3cpVGsn7ZmzrO33KM87fKcWQ7vYyXcdTg90FHMJDtM+7LRB+LsWJ4S2avVwNlAYY1Wnarb1eUao2h/1WbI7THzuAet9RuXq7jNvBgIVui5CnseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hORcxmSceVEgCXD1ZJR7iFwaAIYnsHaUNn2m91EdNZ8=;
 b=rMHR0SmSHzyryY8CJsC4sEMZ8v4+lc9g2ObKszV6qig4YWN+OcJobdTu2+pbqUXGOBsPV8VxbQAEMap7Z7Y9Tz7M97+PNBA8++XbLiCHqZu+9uZBmX6I+XPxYa61TiuwRe3VNup6UDUrAFhErI6n4VuYlZyms1+5DihXR6oyaxqLuTI2C+b1tibsH6q80R3Re5FHi40OQyPdm1JlE3A7B4TmA8inVHDDgwMn5ZpM95r6ubvU9xHwY7V3B3phG8Kcq+pIZ/bmXFx/MZZ3pCJP/BWNGAXRGWptfObtSXyx9PuzyOEpc1znmWprAWnSR8M+qvB3fBZ7xPWjk5HcTwY5bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hORcxmSceVEgCXD1ZJR7iFwaAIYnsHaUNn2m91EdNZ8=;
 b=p/JORBvyo7S6qcQLYEOxE8f6pxZMoh7MZk3Dw7RlQiq/YZZIJqq8thG3oSjp2QyLQrIaO+r2F2v6HXDd0Wwsi2yJqAY4v+OdB0OTymFzEgf5JafOmrriStuq7kJ5/UARAhEcDZSi3BBD4aQmJGVMIziiGLGaTaMebH1QC3Eb/Fi/xa0s5NPdSBRcgTk9Bql3Jd743OAKN2z9vOX/4cYC8GLD/yfmVPU0B6lzqOBtxZBWZi6G0C8JXqHfoeUAVnAu55byXnX1oxqWUPxY7D+be/wBzLv4BFxFeVWzB1FZomdlmXA3+lSFFVfqELu2kAN6ZYZYaDlLxMLduFBZKA8PIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS8PR10MB7373.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:617::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 16:17:33 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:17:33 +0000
Message-ID: <b28adf65-a0af-4af1-a927-f387c6a19cc8@siemens.com>
Date: Wed, 23 Sep 2026 18:17:32 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] edk2-standalonemm-rpmb: Update to 202608
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0217.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::9) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS8PR10MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: e684d6a5-9e15-409f-8fa2-08df198e2ca1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|11063799006|56012099006|3023799007|6133799003|12006099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	Rv+g1Lmr8VP5gSZFqVBLlnvPauviJmVKziGMbVlEt/LXe/wqfs4pLkJAXwD6u48nOf4jRV7WotnhOaEoMaOWXNEIYpy6JujVhDZiT6DbGorwFqQVLbeXLl8CFTekxgOsY1h8aLUkXZpS86fyjLw/iHSJ3G6XxajKB8lRwLWOQQ2+y5F9SbhGK2Tfjja7GyBC7a1EitiD3xe2tKPKxVw+pRlcBPON6J0x29YVYjMaiTRZscdagZgEbSyWSj52xHg2KIe2+gIiaHFGIDd93f2wL0wipiKiX7nJiZsQYfMOwVtLsx/sTDfRDGxjs9Wj0qlzaMzAuN33Lu5u1yfDhAZ+biJhw8LKtB8PEM77Z6va0TD9Z2nPeqEN4Dr3qEDhP2WwkMuGU6/VE9vifBl1zpB431s7lGQzEc84LYBRXaVtezX2jnztFiGdanoc6kfPWF3F7OA3VhfTLZM6Vk+8fPbCxzCHDqhamYbbcdyv1uL3HF6LKGVJFMzr3EpZSnSbYzh9CvaZ0o3dMYHPMYeDwrc3Xcd4eW6MTXNGm5YaXqcqp33qvPqIF5rZC+ndUDAFBHsURO6i69PvithTHldLu2RvCbN6wp4IX5vWF0xHQGWAx8fiA9CROXZmZIumgIcF3Zp/CTpI5aZdrc7Dn/QBvBUxBbsasqNGwSjuwbtXBNFQnaw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(11063799006)(56012099006)(3023799007)(6133799003)(12006099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ak5wMjRhVlQ1d2NPK0ZUczR3dzhYVEYwM1VndlZqYnV4cGsvbHN1YlllSGd6?=
 =?utf-8?B?R0gwZmhybmZzT0FaYlpKbFFoQktkQmkzbVVwMjY0eWRKTk5wMDF0Vk5iTERy?=
 =?utf-8?B?TGswZy9LMkVUeC9IWHMyYmN3RGFoV1FSYlc2aFlSWkl1QkJtbk96STI4cWVq?=
 =?utf-8?B?bWlQeE5ReUF0Qm9OR0VqeUxJdHdrSEd6SXdmWlRFZWxUbE83UUd6R1JsSmtw?=
 =?utf-8?B?L1VNL2FvbGFpWWxWNnlNZGZhL2xvbXZsWWJ2V1VUeW1QMVhQMEhnTmEvNWVC?=
 =?utf-8?B?WWFJZEx3VHA5RUZHWHcyNDF1bmVHWlRIUUpXSkppZkJqQ05qZHhTV3BKU1ps?=
 =?utf-8?B?TGk4VFl3cHRYZ2pWNkZQeDZNQ1B6ZEhtQTVyZ0pYVFlPY01veU41U2h3TFc1?=
 =?utf-8?B?L2JSL295UndEZm9jWWYyd1RmelM1eCswY0hjblhTWEo5OE1aUUwzNHk1R3hs?=
 =?utf-8?B?UlB6a1ZxV0djNExzcDZXb1dSSlZYK0dlNG5HbDZNZzBiSnIydFlMT0RDWVZM?=
 =?utf-8?B?RlVmRzJLc3Ribm5wSXEydzYreHF0cStaQmpWYTR4ZFpBWUNPb2VRQjNKYnRN?=
 =?utf-8?B?Y0l3anJiRklQbUpoUlJVQVgrMGIyTmt5amxDQnJzTzVUUWFGQlFGcGdKbEJi?=
 =?utf-8?B?YjBBQTRLN2RwMW0zRGpXSzlLNlR4WWNib3JpUXBPbThKdUxkbnV0RHNraDBo?=
 =?utf-8?B?bzZaZjFBMFBOTmFsbHJ6ektkSHhITXpWeGVFcnVQb3NaY3VDVjVtWUYrKzZM?=
 =?utf-8?B?VlRjN1FrNGdHQUhkWXRJdHZna2QvY0d5MXpYZHUwZmNUVVpyelF5WUo3N0ZK?=
 =?utf-8?B?OGUxY0RjYmpQcGEvT3lqaFhZWmRBcU85U05tNDBSS240bktkNWU0ZExXK3pq?=
 =?utf-8?B?NXRpY1MxZnRFTUZkSDYxYlNlYTdsMGE1TnN3SXJ6R21mbFB2eWp1OXBvN09p?=
 =?utf-8?B?VnF5TUs3Vkh1OHlXK3gybkNjWGlNejNPVFhoUm9vbnVYelRMQlR4V3JoSkNS?=
 =?utf-8?B?L2FpWkhzaXBsZnVmdjFvejV5VWxmTktPc3VyQlp4UURYbmtyUHdQZHVuZXl4?=
 =?utf-8?B?aEN6Mk9ET3lsRWMwYWlYbGtWQ09JVlpqbE94OHFqOWd5ZFJ3TWthMUFQN21x?=
 =?utf-8?B?bW5aZW9lRzJhZHVXUWM5bHpneWNsTnU1MzB6ZVpQQ21ad1RMZXQwZXVhMkRZ?=
 =?utf-8?B?cHpBNTc0eVA2ejhwYUc2YTYrS1hmeG1wcHMyTC9kV29YelBVVHFZYUtib3Za?=
 =?utf-8?B?c1ZPeUR6bDlxM1huaFM5Y3h0eWlES1hKWDVUVVErWHpDTHF4ZjI0Y3NBeUts?=
 =?utf-8?B?ZzcvUzQ3VUJLZWxuZFdnSEpsTFZtTmVUanJ6TU1DSFdkbDdRVzdad2s5azBP?=
 =?utf-8?B?emRYaEZ5ajM5bGZuWlZyTThKV0Z2YWJKL3dYRFE1a2ZjSVNNK0VCT2E5WFFw?=
 =?utf-8?B?OWpBd0RTY2RRL3lKTVppcU50Y01FTHBNbkl1aGh2UDJGL2JYd0t5bGJWZTBY?=
 =?utf-8?B?SVBrZVZSUlZYMDZGdGxieXk4L0RzTUIzME0zSGZ2ZFdUMEluUFJwM0Q0NXZE?=
 =?utf-8?B?K0w0SVhKd0F4eXFBeFI2eVF1ZGRnOXI3aWZCUGNVOHJUYkVhdk54SkVJZk55?=
 =?utf-8?B?aG9rZXNBd0xldEdWc3dKWWVUU05ENVZ6RWIrYk9PWGdjWUFhQjZadjA4ME1J?=
 =?utf-8?B?eGhUd2Z1eHU2aThKYkdaUGd0ZzlGYS9GSW5Eb2JOZXFqd3RGRHJhUGtEeVhJ?=
 =?utf-8?B?NHRwVlVkcHhzVHVRYmJ3dnUvUnVVUzFBMmRhL3p2UnNTNVY4Z0RFR3l2ODFh?=
 =?utf-8?B?VFJCNUg0S0F5RzY0dVhtVVNQTG5EVkwxTkhwYStpZFZOK09ZbWtRY1E4SjFJ?=
 =?utf-8?B?dm1CdTZjb2tOeXdXYzFCbEc3RURITVZOWk9uY0Y1RS90Y3d6ejlYcEdvK3FH?=
 =?utf-8?B?RFVvVTNJZ2traDZ4NmlScktYVkR2SkcvcHYwU3ltUnM2cXcyWUdTRTJsM1lL?=
 =?utf-8?B?NUtwNC8rTGpHMUFjT3U3cE5HcVF3ZE9QVEpoYko2ZTVlVVZRTE1ZQ0tCU0da?=
 =?utf-8?B?TDA3TmpzckMxMElpVHBPTFhCb21EeUFPRFBIVW5VK0E0UkJqbU5RQWV2cWxw?=
 =?utf-8?B?aXg5aUpkT2tqSEZsMGlxRHg2cUVHdkNlam5jckJpOFg2dmZQWWVLTlRoWVBL?=
 =?utf-8?B?Z0h1ZzdUbzdWQWU5VTAwOEE0YktSVzNmWHh6b1FLOWoyK3R1VVd3bllXMXkz?=
 =?utf-8?B?SVhlbkdwUFRPMTcvVm5ONE82UDJOWkJPaGFFT2V2azFIZWVwM1hhSW96UlpB?=
 =?utf-8?B?aDlKZkRuL25mTkN6T1V5Y2daTHgvRU9xMFBLOU5mS00vMHQyc08rQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e684d6a5-9e15-409f-8fa2-08df198e2ca1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:17:33.6306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AR5I3xLQ31xAhzTXPzSfbcjY1uFgzF4FOASkGCJFGYuK91sq8kyOah3ci7aydTmujMVjgkeaQ1+p2PG3TjcyyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7373
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Sep 2026 16:17:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24278

From: Jan Kiszka <jan.kiszka@siemens.com>

This allows compiling against latest gcc-16 from forky and may have even
more benefits. We just need a small patch against the also updated
mbedtls version to make the compiler fully happy.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...01-Limit-pointer-constraint-to-clang.patch | 33 +++++++++++++++++++
 recipes-bsp/edk2/edk2-standalonemm-rpmb/rules | 12 +++----
 ...05.bb => edk2-standalonemm-rpmb_202608.bb} | 32 +++++++++---------
 3 files changed, 55 insertions(+), 22 deletions(-)
 create mode 100644 recipes-bsp/edk2/edk2-standalonemm-rpmb/0001-Limit-pointer-constraint-to-clang.patch
 rename recipes-bsp/edk2/{edk2-standalonemm-rpmb_202505.bb => edk2-standalonemm-rpmb_202608.bb} (68%)

diff --git a/recipes-bsp/edk2/edk2-standalonemm-rpmb/0001-Limit-pointer-constraint-to-clang.patch b/recipes-bsp/edk2/edk2-standalonemm-rpmb/0001-Limit-pointer-constraint-to-clang.patch
new file mode 100644
index 00000000..2c954a9c
--- /dev/null
+++ b/recipes-bsp/edk2/edk2-standalonemm-rpmb/0001-Limit-pointer-constraint-to-clang.patch
@@ -0,0 +1,33 @@
+From 80f4bf6c80dadb1c5322e91097829993e62cb0fd Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Wed, 23 Sep 2026 17:27:58 +0200
+Subject: [PATCH] Limit pointer constraint to clang
+
+Using "p" does not work with gcc-16 / binutils 2.47 as found in Debian
+forky right now.
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ library/common.h | 4 ++--
+ 1 file changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/library/common.h b/library/common.h
+index 1f59b32426..3cede9cab4 100644
+--- a/library/common.h
++++ b/library/common.h
+@@ -380,10 +380,10 @@ static inline void mbedtls_xor_no_simd(unsigned char *r,
+  * Note that the "x" in "%x0" is neccessary; writing "%0" will cause warnings.
+  */
+ #if defined(__aarch64__) && defined(MBEDTLS_HAVE_ASM)
+-#if UINTPTR_MAX == 0xfffffffful
++#if UINTPTR_MAX == 0xfffffffful && defined(__clang__)
+ /* ILP32: Specify the pointer operand slightly differently, as per #7787. */
+ #define MBEDTLS_ASM_AARCH64_PTR_CONSTRAINT "p"
+-#elif UINTPTR_MAX == 0xfffffffffffffffful
++#elif UINTPTR_MAX == 0xfffffffffffffffful || !defined(__clang__)
+ /* Normal case (64-bit pointers): use "r" as the constraint for pointer operands to asm */
+ #define MBEDTLS_ASM_AARCH64_PTR_CONSTRAINT "r"
+ #else
+-- 
+2.47.3
+
diff --git a/recipes-bsp/edk2/edk2-standalonemm-rpmb/rules b/recipes-bsp/edk2/edk2-standalonemm-rpmb/rules
index 9a6e1b32..71dfe2b9 100755
--- a/recipes-bsp/edk2/edk2-standalonemm-rpmb/rules
+++ b/recipes-bsp/edk2/edk2-standalonemm-rpmb/rules
@@ -41,20 +41,20 @@ export PATH=$(WORKSPACE)/edk2/BaseTools/Bin/Linux-$(TARGET_ARCH):$(WORKSPACE)/ed
 # the default `gcc`, we additionally need to inform the
 # build command which toolchain to use. We do this by setting the environment
 # variable `{TOOL_CHAIN_TAG}_{TARGET_ARCH}_PREFIX` - in the case above,
-# **GCC5_AARCH64_PREFIX**.
-# export GCC5_AARCH64_PREFIX=aarch64-linux-gnu-
+# **GCC_AARCH64_PREFIX**.
+# export GCC_AARCH64_PREFIX=aarch64-linux-gnu-
 # using export here at TOP Level does not work, because
-# GCC5_$(TARGET_ARCH)_PREFIX gets deleted again for what reason ever
+# GCC_$(TARGET_ARCH)_PREFIX gets deleted again for what reason ever
 # Therefore it is set right before the build command
-# export GCC5_$(TARGET_ARCH)_PREFIX=$(DEB_HOST_GNU_TYPE)-
+# export GCC_$(TARGET_ARCH)_PREFIX=$(DEB_HOST_GNU_TYPE)-
 
 override_dh_auto_build:
 	source edk2/edksetup.sh --reconfig
 
 	CFLAGS= LDFLAGS= $(MAKE) $(PARALLEL_MAKE) -C edk2/BaseTools
 
-	(export GCC5_$(TARGET_ARCH)_PREFIX=$(DEB_HOST_GNU_TYPE)- && \
-		build -p $(ACTIVE_PLATFORM) -b RELEASE -a $(TARGET_ARCH) -t GCC5 -n $(shell nproc))
+	(export GCC_$(TARGET_ARCH)_PREFIX=$(DEB_HOST_GNU_TYPE)- && \
+		build -p $(ACTIVE_PLATFORM) -b RELEASE -a $(TARGET_ARCH) -t GCC -n $(shell nproc))
 
 override_dh_auto_install:
 
diff --git a/recipes-bsp/edk2/edk2-standalonemm-rpmb_202505.bb b/recipes-bsp/edk2/edk2-standalonemm-rpmb_202608.bb
similarity index 68%
rename from recipes-bsp/edk2/edk2-standalonemm-rpmb_202505.bb
rename to recipes-bsp/edk2/edk2-standalonemm-rpmb_202608.bb
index 8cffdcad..cd8af5f8 100644
--- a/recipes-bsp/edk2/edk2-standalonemm-rpmb_202505.bb
+++ b/recipes-bsp/edk2/edk2-standalonemm-rpmb_202608.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022-2025
+# Copyright (c) Siemens AG, 2022-2026
 #
 # Authors:
 #  Sven Schultschik <sven.schultschik@siemens.com>
@@ -25,28 +25,28 @@ SRC_URI = " \
     https://github.com/MIPI-Alliance/public-mipi-sys-t/archive/${SRCREV-mipisyst}.tar.gz;name=mipisyst;downloadfilename=mipisyst-${SRCREV-mipisyst}.tar.gz;subdir=${S} \
     https://github.com/openssl/openssl/archive/refs/tags/${PV-openssl}.tar.gz;name=openssl;subdir=${S} \
     https://github.com/Mbed-TLS/mbedtls/archive/${PV-mbedtls}.tar.gz;name=mbedtls;subdir=${S} \
-    https://github.com/DMTF/libspdm/archive/refs/tags/${PV-libspdm}.tar.gz;name=libspdm;downloadfilename=libspdm-${PV-libspdm}.tar.gz;subdir=${S} \
+    https://github.com/DMTF/libspdm/archive/${SRCREV-libspdm}.tar.gz;name=libspdm;downloadfilename=libspdm-${SRCREV-libspdm}.tar.gz;subdir=${S} \
+    file://0001-Limit-pointer-constraint-to-clang.patch;patchdir=${S}/mbedtls-${PV-mbedtls} \
     file://rules \
     "
-SRC_URI[sha256sum] = "5f2b5e3a267230f82e4566592fd0bfac5e205ad90520b2c9bf80f575293b7015"
-SRC_URI[edk2-platforms.sha256sum] = "0a266a61732d8dbb95bd2a4c0bf64a91965728b9fcd567af6af0894f23da0f97"
-SRC_URI[brotli.sha256sum] = "aaa739962a45b508b2e783b915e6b2b57ed3b12bd4b0feac73acfb144dffa54f"
+SRC_URI[sha256sum] = "bac40812213576c3025cf780c33d882f9e087a44201b1cd28a07f6d1eb54b76a"
+SRC_URI[edk2-platforms.sha256sum] = "c58167ae3f2c1787c781b74777d2084276b982ea8ad0f517a46a05f31925ccf7"
+SRC_URI[brotli.sha256sum] = "a9ba3940267de5dd73581a47c2e81b3eb1e1df6a704138c599020d66f3677a92"
 SRC_URI[mipisyst.sha256sum] = "9fda3b9a78343ab2be6f06ce6396536e7e065abac29b47c8eb2e42cbb4c4f00b"
-SRC_URI[openssl.sha256sum] = "d4b22527a645acf76b53e44487a8db687c6eed621d7246891d025e38ba8c9651"
-SRC_URI[mbedtls.sha256sum] = "a22ff38512697b9cd8472faa2ea2d35e320657f6d268def3a64765548b81c3ec"
-SRC_URI[libspdm.sha256sum] = "dfadf501d23c26041c921974971953a1d4a250ed6cd2679facb781471a5f944c"
+SRC_URI[openssl.sha256sum] = "d71a811bfbd9153d7b30cbe476263302ee4b04a9a47ffea6e6a782326805c93f"
+SRC_URI[mbedtls.sha256sum] = "de654c64688d0f6c71caf7336010e1fb54070e6e3d1df3999ee432ab59d0dbde"
+SRC_URI[libspdm.sha256sum] = "a815aa38874d2c82255f379a7ee1eb07cccbb439a7788ff14316fce52d61a516"
 
 # according to edk2 submodules
-SRCREV-brotli = "ed738e842d2fbdf2d6459e39267a633c4a9b2f5d"
+SRCREV-brotli = "e230f474b87134e8c6c85b630084c612057f253e"
 SRCREV-mipisyst = "370b5944c046bab043dd8b133727b2135af7747a"
+SRCREV-libspdm = "f55cf6d48ec69b4ac60a63903e9c6a2cb0fd155d"
 
 # revision closest to edk2 release
-SRCREV-edk2-platforms = "cf63a7257a0a12044b4530904835427813855f4f"
-
-PV-openssl = "openssl-3.4.1"
-PV-mbedtls = "mbedtls-3.3.0"
-PV-libspdm = "3.6.0"
+SRCREV-edk2-platforms = "f8dbb5c603302dc661f572b560bdb34f7db6edb5"
 
+PV-openssl = "openssl-3.5.7"
+PV-mbedtls = "mbedtls-3.6.6"
 
 DEBIAN_BUILD_DEPENDS = "bash, python3:native, dh-python, uuid-dev:native"
 
@@ -75,8 +75,8 @@ do_prepare_build() {
     ln -s ../../../../mbedtls-${PV-mbedtls} ${S}/edk2/CryptoPkg/Library/MbedTlsLib/mbedtls
 
     rm -rf ${S}/edk2/SecurityPkg/DeviceSecurity/SpdmLib/libspdm
-    ln -s ../../../../libspdm-${PV-libspdm} ${S}/edk2/SecurityPkg/DeviceSecurity/SpdmLib/libspdm
+    ln -s ../../../../libspdm-${SRCREV-libspdm} ${S}/edk2/SecurityPkg/DeviceSecurity/SpdmLib/libspdm
 
-    echo "Build/MmStandaloneRpmb/RELEASE_GCC5/FV/BL32_AP_MM.fd /usr/lib/edk2/" > \
+    echo "Build/MmStandaloneRpmb/RELEASE_GCC/FV/BL32_AP_MM.fd /usr/lib/edk2/" > \
         ${S}/debian/edk2-standalonemm-rpmb.install
 }
-- 
2.47.3

