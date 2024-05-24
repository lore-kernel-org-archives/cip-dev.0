Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B411C25B74
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 10:51:20 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.86])
 by mx.groups.io with SMTP id smtpd.web10.12987.1716547879155040221
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 May 2024 03:51:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tQPp1CvG;
 spf=pass (domain: siemens.com, ip: 40.107.20.86, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lU3nTM5936PS1EZavQZugtL6fxO+Rcn4K4BeMfQ16O+HrEikFOeu4LRO5LuSZg24dyNhEflSAIi5L+rt3Y+DYH2A94gFyPbeLi0PqR6cTzubuTrG72NBF/NxiZ5MHnJasyyaBRNFh4ZYtkp3/jAmJQzCjQ7lLrjRvE47Q7qV/sDVrYHEjZWUSk7OW7hteEUp7HPjJcpjmsJYWI/AamFt/rRRBmhbCJS2dIL0+SKOCtMfVMo1zAVE7mlOhgqlumWAhwdi9VqzyzthXhtUpRbX++auz25izbZWc63+hIwiBC6TjlZ6HArssy9uA8sN7N/qiEgHDP1P0vN83wlzZLVC3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlwDEAUtIOMcO7jOdI496mMWMCG7pKDu6ruqcIm/tk0=;
 b=IwRsM9dm5Igy3wm2yOXMUdzRTU2uJkumabWtM/e3KKsZyyQGzn2e0+ykV9TXVjb8d/S1XjORW3Mw6VO6w0j+081ACE4ZdOhDxizH0WvI2m8fA8RWrlPmq5h2Jr1FztIWz+tGD9xqLH+1BkEQn4W3dcDwwGmgpN9/yIOjx/9dy4Z9SgVo32GgFPSD24acuD8CjkOwapiaY9dR0Bb5TN2QKR408yclZSjTAOEvtsIV8Dcdy3mi7f1aRlRSh9OVmfdGvrcB/uBMasqBwfO6RFNNUTY1RsdEbjudXrhcsalKIvJL2n5rIDSIUf3iekf4BkXPtiw3TRYOQaPdv+D2kWo60A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlwDEAUtIOMcO7jOdI496mMWMCG7pKDu6ruqcIm/tk0=;
 b=tQPp1CvGIZ9ZnCDblMp4bKvGSYiBY94/yZeJd2vVLSUjRV1//dmwvuB/9GEmyTk9ueC2G3NqpAC9atQgeha9z8/X4i/cR/kZdGEzjg7sYJDeo0QyXULhoHLyuvTNFUuAue912ls6M5EyaYxWD+wz59KQ509hnFfaxG5p+eqvA+V8bU0X4eUuTfJmRY0pPTPxAUm5Vc9eKAonSgxPGepc9sayYDHfWiCWh7WLEwoCkJUMncd+RALyfgNRBmZAXCDFGVR/6FdRYwP1vD4K0FKZbZ4KfIb5C93sjBs6Lex89L/yc4uUgycF49JA8Ujps66NNS6xT6FXPYsdONicsDDBfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5621.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4cf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 10:51:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 10:51:16 +0000
Message-ID: <ecae148c-1e87-4ba4-9e36-fbcd2d9e9ee8@siemens.com>
Date: Fri, 24 May 2024 12:51:12 +0200
User-Agent: Mozilla Thunderbird
Subject: [isar-cip-core][PATCH 2/2] Generalize SIMATIC IPC227E configuration
 to a common x86 UEFI target
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
References: <be7c406d-ee6c-4270-b9d7-52b6f24078c2@siemens.com>
Content-Language: en-US
In-Reply-To: <be7c406d-ee6c-4270-b9d7-52b6f24078c2@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:610:b2::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5621:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f1d9d7-acc4-496b-ca76-08dc7bdf6fb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dkFYWjFDUXhMeEJzVlBNN2puQUU2RTlxTDZoTU9Td2c5N3I1Qy9jK01oSmxm?=
 =?utf-8?B?K1JCK3M2Vnk4UzNNRUtvbWgvdHl3WmI1czR1bkZsZHAxNCtoRHowM3IyYjlh?=
 =?utf-8?B?QmNzL2lTQnlJYTJEMzAydnF0LzhtRHkrT1VBZVVkbW9KWmZsUUdaaFV5QmFm?=
 =?utf-8?B?Tm14bXEvZlQ3WUFrUkgrWVZnTGRuNExZNERuYWNzQ1lBQjFNTDhrcURJNkRo?=
 =?utf-8?B?NitVTEhvYWtXblhRYTlIblVmbEtvVTR6N2xaeEpIN1NwcS9hMVU0TExVSHI4?=
 =?utf-8?B?Q1F5bEYzUEdvTXZPKytVT1BIdGNydWpoUkZvd2hCZ3QxemxBWmo0M3lMUlY2?=
 =?utf-8?B?ajZyWC83ZHNVSDhNT2hSRks5ZWh2Mnk5WVRWOS9FZG8zMDlZY2F2TW13aVNZ?=
 =?utf-8?B?dUtlMDV1ckhwbWkyWDlYWnFoY2JuaHdjVXdHUXJHZTU4ZzM1dXVBZ1NaME5Q?=
 =?utf-8?B?ZkhwQ0wxOXZ3UC9UYi9BNFZBVC85M1R1ZFloejJTYTYwYUE5TkF1dmdNWGo2?=
 =?utf-8?B?NUNtYWZyNEE5RG5yNzhTSG0vUjVBaDI2VkVqRSs2aFU4Qm45S21RZGN3dFJl?=
 =?utf-8?B?SzNNaE1GYXYwT0xLc0pWNUhqa1N6SGtMWithTnY3U2RVZjZMRDZTUUVKZjRH?=
 =?utf-8?B?WUdGMy8zYjhMY2FEUEZkd29hUkx1QUVaT3NKNnpGVklLM2NnOEhZdFYrZDlr?=
 =?utf-8?B?bk9wN3JYVUk1clcrZVR6UHRnWnlmYS81OG43L0RLSDBuNkI0SEhQVGFyUXdp?=
 =?utf-8?B?VmNIVnlLUzFXeEJXeWZJS3ZFakFRbG5ZclIreHdMVGNvK3BkczlEMnNhREVr?=
 =?utf-8?B?RDByYVlPU3c5RFA5Zkh6M2l4bUhDUytsQXRlN0h2QitRTXQ4M3p0MEpmWkQ1?=
 =?utf-8?B?R3ZIWlhFVnErb2N1Z2JPenM4OHg5NmJNcUlYOXNDQ1kzRnhtNWFTMzY0T2dy?=
 =?utf-8?B?ZjdJaFp2VnhFbTdKUjlYUHVKcHVyVzliK0k3UGRSZDF3UlBWd0E1cnUzd05l?=
 =?utf-8?B?S1VpNWpmTTRRQnlUak5jWkNyWm1EOE8vRUtSZEYwcHJPQVZCcFNjSWxaUk43?=
 =?utf-8?B?RG5MMVhUbGc4eDlXNmtWakpCckpZSE9lS3NkdHRKWmYxeWswRUFtZDMvbzJE?=
 =?utf-8?B?bmVaaWFiZ3grQjhId0xWRmhIUWp0cEtzTm1wWjZlRE55d0g1YXBidVc2ZHhR?=
 =?utf-8?B?a2t5Sm14Z0VZaDRrbVdnWGpjUUpZUytIbWtkYkhOTzRtTm04MHBIY2s4UjN4?=
 =?utf-8?B?Q0tYOHhFSHR2MURLaXhDT1kwUFhQOWttb01TUEdvenJmb080anArRkVIcElt?=
 =?utf-8?B?TFFQR0xORVppQTRGV1pOZFVhVEtya1hTTDZvZHJCbC80eG9mYjZJWUZ2K1E2?=
 =?utf-8?B?ZGlxU09RZGFEQ1Vtc3EvU0dKTExQZFI2TUV2WjBkZXpwdGtDUEUvbmdzRTBx?=
 =?utf-8?B?aWhmUERhZjRKOW12TFQ5WVBVVmdEMjdXdjg1cGZtR2VZZm9qK1VJMVdpSVMz?=
 =?utf-8?B?bjZyOG5mNjBNc0hSZC9UM0V6Y0o4R3JHb3FGeGRDODB2Vll3K0hVM2J1cTFk?=
 =?utf-8?B?NEx5Z0poVDVjWmRaYk5mRDV2MXpRbXQ3ekYzbFUrbzliZ3RleG02NVJYSFdY?=
 =?utf-8?B?OHJHWFRzSDVIenpZVlB1akovRnFuYUx1VGZqRXI4Sm1YelQ5MStLN1Q4QjNG?=
 =?utf-8?B?Y2NMMDNsUCtvSno2T1oyemVEQ3Y3aVp2U1hHT1JKY2RISUpiaHd3QTRBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SVViZWxCOThXaUtZWitqV2MxVldMa0d3b3Bzb0dwVnFTUEkrWEJGNnhvTHA3?=
 =?utf-8?B?QUxsNlFTU29DcHJMREozWEdzWitwN2M4RGs1RlJvSlI0V1hicHZnTngySENJ?=
 =?utf-8?B?a0dES0x2K1AwTWpXUUphV1dCWmZLaEFrUUxrTERxeFp1eVBFZkJYU1ZnQzdt?=
 =?utf-8?B?Tkt1NURSbUFJS3RBRE94ZlR0WHB1QjY0NTYrK09MdTMrSnpkVnV5MnhYdHRF?=
 =?utf-8?B?bjJGWWF3Vko1ZVE5dGVrU0FhSzlDMHJNWllPSm9taTlzNXVqN3ZxQlpQWHN1?=
 =?utf-8?B?YU9qaWQ1cmNPNHhLSHNobngyUXh4VndQSjNxU2Nackd4L0ozcHIrR2liV3Z0?=
 =?utf-8?B?UXh3OGovMHZjVElIak5Mc0lYYUtrSWNRaWdtR0hySmQxL3lZd1BzNWxQekty?=
 =?utf-8?B?cjd1TStUdFVwSldub28raTNMVmNia0FQbmlRUUloSEM0Q2NJbS9tVlZNK09Q?=
 =?utf-8?B?dU52TjR1NVpMZFd3cEF1YktPSjh3YjdnVEZ6MlBKZVowSFFmK0ZDWENYdGdV?=
 =?utf-8?B?bWNQTlZaL0hCM1lQa1dROHh5L0lSNmgwVnJKTEdMNndBMWp2ZHQ2VW5iRGNY?=
 =?utf-8?B?dGhLNEY2eTZQMzJRUXpYN2FIRGpHMEQ4ZHkvbUxXaURHeWxDSnFSUGZCOXNI?=
 =?utf-8?B?LzBkQjBydkhQc2dsYjhsLy9LWndMREtpd0d5cE1QY0lxVE13V0pCMWE0aC96?=
 =?utf-8?B?QXVlSlY3K2FWR0dwU0tod0t0TitTMUlhekp5a1Y5U0t1WTV1MVI1TVdiNnBo?=
 =?utf-8?B?Yk54WDRkcWJtS0R1dThwYVJ2K0JlYUxvVFN0U09CN2ZuSFAva210UGVhaTI1?=
 =?utf-8?B?ZlgxdFFHWE9DZk5XYTdjZzQ4V0VHaHgzVExZQ1NtaHpnTXlqTTJGRnMyY0NW?=
 =?utf-8?B?cEQ5Z3A0RzdlVlJpMGVHVGFUVFhyMHBab3JCNWlFZHV0V3I5dDB1WUI0cUs2?=
 =?utf-8?B?UC9SUmdHcng3bjh6aUtMWlNiZFI3VStMUnVmTEhlTk1tYkhxMnhyZHV4QU93?=
 =?utf-8?B?aVEyOTdSS2JveGh4d1NZak5xYTBTZ2duWFVpZmxQYW5DVUtsYWwxUGpjQ0hI?=
 =?utf-8?B?NkhZK0RUREhKYWNoWFlremN2bjZINzRnTS9xS3N5S3lCRGs3SVJIQjhnVHRx?=
 =?utf-8?B?Tzl6MGNOV2JWMGZmQmh5Rk40NVVHY3lWSkR6SjY1QjZuZlRmS2ZML1ZUaDJP?=
 =?utf-8?B?eTFxMU92ZnZZSVhmbWtUaGFIbENRSDlncUx2dVJtRlBEYVN5aXBLY3gwb3k3?=
 =?utf-8?B?YStFeFlyTWQrMHluUGRvT1h0bW1GTjhWODBWU21BQzI5N0MrUFdEaG9MNjR2?=
 =?utf-8?B?R3FpVzcwRUNOR29vNUFWSml1SzdpdFFBdFBJNE1pYVd1ZG1sWTc3bDZucFFu?=
 =?utf-8?B?UitGNXNTdFgxQmV3SVh1TzdZcWlMOG1rS0p1eXdHY1daT1d6K2RkbXRnWVZn?=
 =?utf-8?B?bklZYSt5cFV1UHdOaThmSUNpZDFDekU0MHNuNmpFeUQ5SFU5V096RmN6aWcv?=
 =?utf-8?B?cERpMSs5QytkL0xBcW5FdnEwMEZvZVN4VEhQVSsva3pRK0pibTc4UFdBSTN0?=
 =?utf-8?B?K25Xam1ZZEwxUWJHUWNGbnJ6a1pCdmFKVTloNG5EdUpmMGhidFJ0T3FjZjV5?=
 =?utf-8?B?b3lBcmlFZDJOeXZUZW41MkZFWGtVL1gxYlpacmxxbUJqWldKOHVwT01UT1hX?=
 =?utf-8?B?Rk1VdHhjWFcxTnpkV1JmVDlsVWxnVUFsYUxoZk9zMldHS1J0OTQrdUxUS253?=
 =?utf-8?B?WDVxa1BjMEdJNnhjSFF3aTV1VklQV2IrV29Yd2VlbDMvQzR0a1U5ZXh5SVJX?=
 =?utf-8?B?N2N0UTBvR21CT1RHNHNhL0I5cVRSK3ZoRk9kZmx6aDBGYlM3dTRZODZOSXBn?=
 =?utf-8?B?VzVhdFRCS3pLK1ZFbCtDQU9QZWNzT3JoQVp2RVN6R1gzazJocFUwM3F1RFZn?=
 =?utf-8?B?cHBQN2ZKSSt2SEFYSDk2YnpCaENNVlZwdVhhelJmVE9FQU9vWHRJaHcrdEpU?=
 =?utf-8?B?Q0QxY3RzajU4Zkpoa2wyYWh5aTNneThESjZxZVdvVFdGMllOQWxRSisvY3d4?=
 =?utf-8?B?WW9CZ1F6MkxQVVpkdDV0clhsa01SbStIbFRkR2kxTEZUbmdsVFBiMklWdnRa?=
 =?utf-8?B?ak91T0VMM1BDRS9xemNtQTAvUVFyeHZ4UW5qSy9nalhJYzZYOTZSUmZ5b2Js?=
 =?utf-8?B?K3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f1d9d7-acc4-496b-ca76-08dc7bdf6fb2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 10:51:16.3521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTyZvA97KTsuxmDdXXOs3/X2OYUtulxzD08q8LqHYKBR7us2faeoxPV6KN1tXCUFyHmkrFjQoPnLUqX1rTa7xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5621
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 May 2024 10:51:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15943

From: Jan Kiszka <jan.kiszka@siemens.com>

Officially signals that this image is supposed to be usable on all our
physical x86 targets. QEMU remains special, even when using a UEFI disk
image as well, due to extra needs for the host.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml                                       | 8 ++++----
 Kconfig                                              | 8 ++++----
 conf/machine/{simatic-ipc227e.conf => x86-uefi.conf} | 0
 kas/board/{simatic-ipc227e.yml => x86-uefi.yml}      | 4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)
 rename conf/machine/{simatic-ipc227e.conf => x86-uefi.conf} (100%)
 rename kas/board/{simatic-ipc227e.yml => x86-uefi.yml} (71%)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 4a397121..f3d05525 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -81,11 +81,11 @@ default:
     - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
 
 # base image
-build:simatic-ipc227e-base:
+build:x86-uefi-base:
   extends:
     - .build_base
   variables:
-    target: simatic-ipc227e
+    target: x86-uefi
 
 build:bbb-base:
   extends:
@@ -166,11 +166,11 @@ build:qemu-arm-base-kernelci:
     deploy_kernelci: enable
 
 # test
-build:simatic-ipc227e-test:
+build:x86-uefi-test:
   extends:
     - .build_base
   variables:
-    target: simatic-ipc227e
+    target: x86-uefi
     extension: test
 
 build:bbb-test:
diff --git a/Kconfig b/Kconfig
index 6e3ad3ea..334b5c66 100644
--- a/Kconfig
+++ b/Kconfig
@@ -39,8 +39,8 @@ config TARGET_QEMU_AMD64
 	bool "QEMU AMD64 (x86-64)"
 	select ARCH_AMD64
 
-config TARGET_SIMATIC_IPC227E
-	bool "Siemens SIMATIC IPC227E"
+config TARGET_X86_UEFI
+	bool "Generic x86 machine booting via UEFI"
 	select ARCH_AMD64
 
 config TARGET_QEMU_ARM64
@@ -72,7 +72,7 @@ endchoice
 config KAS_INCLUDE_BOARD
 	string
 	default "kas/board/qemu-amd64.yml" if TARGET_QEMU_AMD64
-	default "kas/board/simatic-ipc227e.yml" if TARGET_SIMATIC_IPC227E
+	default "kas/board/x86-uefi.yml" if TARGET_X86_UEFI
 	default "kas/board/qemu-arm64.yml" if TARGET_QEMU_ARM64
 	default "kas/board/hihope-rzg2m.yml" if TARGET_HIHOPE_RZG2M
 	default "kas/board/qemu-arm.yml" if TARGET_QEMU_ARM
@@ -173,7 +173,7 @@ if !KERNEL_4_4 && !KERNEL_4_19
 
 config IMAGE_SWUPDATE
 	bool "SWUpdate support for root partition"
-	depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB || ( TARGET_QEMU_RISCV64 && KERNEL_6_1 ) || TARGET_HIHOPE_RZG2M
+	depends on TARGET_QEMU_AMD64 || TARGET_X86_UEFI || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB || ( TARGET_QEMU_RISCV64 && KERNEL_6_1 ) || TARGET_HIHOPE_RZG2M
 
 if IMAGE_SWUPDATE
 
diff --git a/conf/machine/simatic-ipc227e.conf b/conf/machine/x86-uefi.conf
similarity index 100%
rename from conf/machine/simatic-ipc227e.conf
rename to conf/machine/x86-uefi.conf
diff --git a/kas/board/simatic-ipc227e.yml b/kas/board/x86-uefi.yml
similarity index 71%
rename from kas/board/simatic-ipc227e.yml
rename to kas/board/x86-uefi.yml
index cf27058f..056ca322 100644
--- a/kas/board/simatic-ipc227e.yml
+++ b/kas/board/x86-uefi.yml
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -12,4 +12,4 @@
 header:
   version: 14
 
-machine: simatic-ipc227e
+machine: x86-uefi
-- 
2.43.0

