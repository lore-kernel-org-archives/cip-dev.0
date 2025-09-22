Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DB4CAC5AA
	for <webhook@archiver.kernel.org>; Mon, 22 Sep 2025 15:33:30 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.58])
 by mx.groups.io with SMTP id smtpd.web11.55160.1758555203927932454
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Sep 2025 08:33:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=EeAER4gT;
 spf=pass (domain: siemens.com, ip: 52.101.65.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olcJro18rdKGFsiGq2uJKF9Lm+1ACWkmjZHW+Ri+ueWLBxjZZZopLU1qiUu63xINtXdq+t8o3I0PEk5/UbQmBkHBCqjSFtu6ezJRJozm4T+HqDevJtMP0NbqAgsAXNCnZJhOyZb0GgBKjtg+Pk98pfn0WEuEIaKDn55h0txuqXHoNuIrfNmMztvooI7K0QbDGRRsyolggXaPvkTmu109ahIHOvrZnWBQkobQZwDa7BLwWix+fzx3nTe4k2qqcjhhYOGN75kvMhUILo8TM7SXqLbr9uKxZBypHzzNWKL48d9Y/awv3NNyJyCLydTdCFDgdoiXRfr2jFfv4dWS5p+eRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3gQTPmk+g/ElpHFmKHFiSbu7HeEqH5qaV54nZC0TMU=;
 b=LDkL0cVbQVxHs4Vsbkh6IU5i9VXOrcyhg7+3nM6wPJ2ujKldMMFYJtPdA2vEs+3hHd6YjPp0hPYKsmkFaCDM2EHa8XO6BcS+hVKuQO2osORD5x9gAH+zBQy2S3AG8WuVlSXrJhFX4hLFivFZjmCmy3ldOC1rsU+riqmPG5G9iGDGBk9vNL+CG2AjZdtAfRqDZW5dzRKF1PxESRLGArwBGvokD2cmWGBavk8Qjef02Ka/3dDwZS4LGovMKhQedSpEQyvkCTx+jcA/1rR3KbEua+LmI537/geatCarBuEn3tDC/aKshNGxT4H6piEhbxtwUwMwyjnmxGkibVIehuP4Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3gQTPmk+g/ElpHFmKHFiSbu7HeEqH5qaV54nZC0TMU=;
 b=EeAER4gTDmXtW30XyI6lh+DY59f0+LdLtJrPX4UPpjytAI38jB2ZP0EFOVFyXnhoRZ9EBgzcs6mrVbi1ghtW6Dz2KlouAluIQjjOMqI02DUxmZGVMcGllHQkZ6MQe8ftOj8zzMPuYN8Memvz/T7qhPk2r/f+KeXdUyOCCLVDummntO19sxO+RjJOE2FAWAN28vfl/nO9JEt644OgiZRg/9EXfcJ7GhYq8lALxLozq9UXjC+scSh6yAymbYPNXi0a6Xh27pCcn8RG3DUMPh09/cJhNiHQ+1E3JKw12CX0YpRA3nf6l//YLPdP0THjJa/vQ9xM3zZ9iGMH68iJwEUhvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1ce::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Mon, 22 Sep
 2025 15:33:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 15:33:17 +0000
Message-ID: <0c0ea970-e2b2-480c-88b3-268210262b09@siemens.com>
Date: Mon, 22 Sep 2025 17:33:17 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] cip-core-common: Refactor selection of
 self-built dosfstools-native
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8674:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a19aaac-6e7b-4805-c9a4-08ddf9ed5a7e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QzdpQTZ6aU1sd2FXeDhob2JWc01QKzJBQ0o2NGthVFpSVlFJZHVGSUZXOUw2?=
 =?utf-8?B?Nk85dDFpVDBUVkZsQXFYVncrVno4K2xONkdLZVpDcjFyeW1namV5OXZMeFFD?=
 =?utf-8?B?aGE3N1lsOVJLRzdlMG44U1NDclJ2V3JpTnpHMVRLWEtObk1weExBNUtzQ3Jh?=
 =?utf-8?B?TWliZXRRb0RXZTdxeml1d0xpWVNuRmtmS2g1eW5JTjlkeFRCU0FZcEhLeXpN?=
 =?utf-8?B?NVIyamJhSldCVmdmQnZkQ2lQQWRtRDJvcWFoWmZqUTBGOC9BV1VZY05hZktm?=
 =?utf-8?B?OU5ocm52VjNWc2VuRkpvNW9GS3Zjam1RYVNmK1BJTEQwbXdJTHNvWitRU1g4?=
 =?utf-8?B?SzYwOVF1YnM0VUZXNnRkQ1lZWlM1aUFKQVhVaFBNdkVpS0pvUm01YmFMNHM0?=
 =?utf-8?B?cWFQYWxrOW5tMWlPTjZiUXB3UVdRTTlYVGhuZll2T1NxYnBkRkl3M1JpOTZ0?=
 =?utf-8?B?Z05IYXVwc2xLZ2NmckxxbUY3SkpOWW0zamFjeWVlL1NoZHkvNVorNk5XRkdv?=
 =?utf-8?B?anZORFpsZE5BRUl2S3Q3R0JmRHRRRzM4YzRVUTBMckRuOXR4MnZGSGc0Ujkz?=
 =?utf-8?B?bTZRUzZURlMwVkVHREh1cnd3ZVJ2SE5USVdwb25lM2gyVGtwMEEyTW5adTZ4?=
 =?utf-8?B?Z0dYOTRRRGUvTWtUS0lPdzNib0dnd3RINTVyNGxrbnQ5K2hoZ253Z0dWNWZ2?=
 =?utf-8?B?Yzc1QUd3N2lPMUJpM1RXSGpEQjhKMDBISng3Sm1ZQ2xET2dWTENJSlBacWpL?=
 =?utf-8?B?RVZCSkVTaFJWOU44WUo1cW9zaVFWMTFlTUdHTytIZEVHUU9iSGRBallBT0Jw?=
 =?utf-8?B?V29HTDdESGhwTUN5L0xVd3Q2TDBrdXFxbjlwQzdBTW5zUWNzcGlHWVBjbkR6?=
 =?utf-8?B?a2pmS3BlbUVpbXd0VE52cTFLNGN6QVdLRmV6QXdiYU9NT1BuaXJOQ2ZkMHJz?=
 =?utf-8?B?SGhFemhmK1pMSzhZYWF6VzdDQmtIRHB2NTdUNko2bXpCc2JON0VOVExCeUZn?=
 =?utf-8?B?eGFYek1NMWMvVHVvc2NmN1BtM3p0bzRwVmpsMWRsc3dCYnAvemRPVG9yblRK?=
 =?utf-8?B?b2VTclg0RUs5c05Vd0VsQ1NVaW9Nb21DWmhMeGpVVWdFbElVVzQ3LzVBSzhy?=
 =?utf-8?B?UmRWcnNJSHhGdkVZcEZOZER0L2dWR1VlMGpaMjZXenVWTGozOURtb3JyWUFQ?=
 =?utf-8?B?MEV6cmdtZU95RHZJZTQvTGVkdFdiRDM0a2M2SFd2ck9lZktXTGUxRmh3czk4?=
 =?utf-8?B?dlQxK1BSaUZsS0hQZnM0SjlncWU3UWJoUHc4UkxWNzB4ZDQ2RkhnKzN0WnhC?=
 =?utf-8?B?RzJuVVJ5QVY5VVY0bnpjWk1qTXZFaVc3ZUtUQ2xCblNQYlMwNGY5dHBzb1pO?=
 =?utf-8?B?UUVRMnRnOGpUbnFjRHF2WW93amR3ZU51dFpKTmRrRXA1NUt2b05ZbjZXMjJm?=
 =?utf-8?B?M1pNRkdIaVNlWHFQZDNSOWNwb2lFUEdqZ1BKeloyWEMzaXYwb3lhZzZ0RzY4?=
 =?utf-8?B?aDdFajJYekkyVEZpU3NWeWczUDhjcE51MnRTc3AxK3VGaW1vckh0enRPbjRC?=
 =?utf-8?B?T280alhuQ2lxL1BTczhpdWZiVzhtdVFId0RYbGtDZUt1ZSt6VnFSQUNvak9x?=
 =?utf-8?B?ajBNcTFRWjJWM3JHdityZTgwYVFWNHZOOUxnNmV4K2RkejJ6aGdhWGJnRXRo?=
 =?utf-8?B?WGNvYTZHMjF1UjVzcFY4WnF2MmhUMzJYenNhdGcwd2hBY090T1QvQ05QNlRP?=
 =?utf-8?B?dVR4TFk5bi9JUFppM2kzdW5aTVhqODdRenhUd3hBNkEzaFkxRmhxNUEzbkV5?=
 =?utf-8?B?bFlmL3VMZ2NUdVYxM0JTNTQzeFB3R3FtTlFIZlM3YUdYQ3F1bW1zZndzNm9y?=
 =?utf-8?B?WkZ5RHpIcU5rTkNWeHVoZnVFLzVzcG5OZW9tc25UczRLZnAzS0UzeVIzMjkw?=
 =?utf-8?Q?4TmiL50e5ac=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NkUrZWlWYS9JQ29tZ1dLQlhzU0xiREJHbTFJZHk4K1ZkYllwdWRHejBZMk5m?=
 =?utf-8?B?MUVHaXAzZE44SEgxSTk2SmpBeHhNRFhkcmh2aVdYamdBM2kzTzF3VFA2MnJy?=
 =?utf-8?B?dGJPMjd3elRaaERTV3RLVnNlM05pNkdwYVYxSllHVjRoTlZqeFRlNW1kcEE2?=
 =?utf-8?B?QVBNZ0ExMnc5Ynd5dWZPR2piSlpwd2Q1b3VtTEEyNGFVbmsrVFYxMzBrQWMy?=
 =?utf-8?B?TFhZQ0xkay8wOStpMjNkdDNlanFNbjNZTVovUG9sUUJOekluajA5bFpBQXNn?=
 =?utf-8?B?empIa1VkTWxnVG1KMWMxWWxmZzBqT1QxckZaT1JDRE92dnFMZ2RiUWlZWEJm?=
 =?utf-8?B?TklXV282ODNub2NpQlc2QXBPZ2pFUS9KMXNJcW5GNEw0T0MwL0plbG1PUk8z?=
 =?utf-8?B?amk1SE1UVG1FUitVeEo5dFdDaWk2RlZiTlZMZXlUL1hjT25KQjBRcXplM0xs?=
 =?utf-8?B?bjJPOFVxYzg3bXAwUDdJdlNTekMrMUk1Q25MR1diRWxWSTVleWNRWWs3VW1x?=
 =?utf-8?B?ajVSVzB2eE1nYjNQY2Z3R3hIZmRuOTNvUXY3amI2cmNXZHdpcUZrd1dZam5Z?=
 =?utf-8?B?WnRqTW5HTkg4WmxUdEtrYURLVTlhcjVhT2JpSjRGSGkzRTBYTDV3OVozSzM2?=
 =?utf-8?B?ZTRGZ1JleUM4aEhOMXZZc2tNUTFMRHlKM2QvcjVMUkx2bUF4ZkkyZDB2akFK?=
 =?utf-8?B?SG5WNjBqMTRvdWhNQ1FmWEc4c1llQnBXZXRURkM4MFZnYzVOdERnSzR1V3Q0?=
 =?utf-8?B?SE5SRGE2a1ZWK2dEZW5wSzVSeEZwWmJ6YVVjSGNTbmRzKy9HdkQ3bmh0NmJw?=
 =?utf-8?B?dldXOFEzTHEwRTRabUlOQ0FOTTFlYzdwTVByTWlYeS91SEw1T0kvREoxSlc0?=
 =?utf-8?B?QmljZk9FZGJnNXk0cnNpWEFtWEtYcE5hd0xWem1YZHZDUTY0a054TDNYUFIz?=
 =?utf-8?B?RiszaVZUZFkzKzZReXlnMnVSS3RYWnVoL2k4dkdwV3ZhMzl0T1lSSWlsd1pW?=
 =?utf-8?B?c3BJZzl4aHpxRVVNWVlma1EyNWZzNlAzWEFNQlQ2elRCcWxacEdBaDFlVHhG?=
 =?utf-8?B?eWppYWVIeVU5SjlvdlBsbFF2TktlSGhrOEMrV0syUkppRXZ2c2lqVTdGWjZK?=
 =?utf-8?B?N1Avc1BXVXFOd0NIWTN3WEc3dHprY2tISU0vamZaampTV2toTXBoRzJrZ01n?=
 =?utf-8?B?U3JJOThhVHpzUmJkMVdiYTRPc3Y1RFlqZWdQZ0V3cVdRdjlvRFBDakt4cGhI?=
 =?utf-8?B?UERydWVHb0xWV0FHcWZMMW1lZm5FZVpTNS92R0FQdWVXSDJ0OHd5MzgxMm9j?=
 =?utf-8?B?V0VuR0RuSzdYdXI2eHpmeDlzVzQyMGsxNDlDMktVYUpnR1dMdUkrQmh4dk1j?=
 =?utf-8?B?RC85MGk2TmIvSjFILys2bVd0RlB1SmthdXlyV0lQQ0JJRTRFZGtOSk5Va1JG?=
 =?utf-8?B?eURYYXpHSmY3TVR5MHo3SmhQSlY5YXMzOFRDT3c0dVJWaldmbUd4YTczZlVR?=
 =?utf-8?B?QzI4allxdkJWTEkvT3poZE1wZVJTY1J5WVZrMExyQkVTVXVvRXN5a0hPTjhL?=
 =?utf-8?B?MGY5eWY1SVNHbUZTcG1seERGRGFtZnM4WEV2Zm1GOGM0aHRHOTBYQmIvRUlm?=
 =?utf-8?B?VDVQL3JmQS9DS0RLMEZldGZFVmhqdldUSjlhUVZuVFdFbkVNVFNpT3dzZVkx?=
 =?utf-8?B?Mk55N2c3cmJ4WU96TXlCM0pxcXR0bDZNTEpIV2dYUUVVMXFwZGlWWTQ5OFNt?=
 =?utf-8?B?YmVrNGZWOXhJbnJTTDFKYTc0TEQ3SHlSZnlWazlNckNWVkpuVjFqRTZwSGxU?=
 =?utf-8?B?RWVVVW56cUxqZnJYNkVhTGZyNkNzeEFUZlkvbWU4cGx5Z3BINUg1TTdDU1FV?=
 =?utf-8?B?SnZiM3JXWVhGc1BKNnVIb2pmaFRkeXZHK0c5d3k2WllpeFdGSWdRQ2tySUhB?=
 =?utf-8?B?dmJsSzNvYnFuNENTMXJHQ1VTU3daWTd5Z09jeTVYWGlZQjY0SkhlR0RPa3lo?=
 =?utf-8?B?M1MzWndnYXdJeGVhUjdDRGRGTVJMOG5TQ2lwVW9NYmhPdFBHd0djRVYrcy9t?=
 =?utf-8?B?M1FDMi9YZGRubU4zMUx3enNJRlRRcVROU0QxSFhRZ1E4Y1lsbVhiZ2k4bjR0?=
 =?utf-8?Q?jU6pRgpcW1HWVn4f6MpqKvcPB?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a19aaac-6e7b-4805-c9a4-08ddf9ed5a7e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 15:33:17.9549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sw5qLb3bYZyAK6m+pO5XJ/yqPaUqB9FKfhpto0xOcu6U8grTpjkky2I+VGcZ/ayVhNXptkG7aeWHGKjAsJCYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8674
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Sep 2025 15:33:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20089

From: Jan Kiszka <jan.kiszka@siemens.com>

We now know that only bullseye and bookworm needs this and can invert
the implicit list to an explicit one for better maintainability.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/cip-core-common.inc | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.inc
index 0814b082..86f79f0f 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -15,9 +15,8 @@ WKS_FILE ?= "${MACHINE}.wks"
 
 CIP_IMAGE_OPTIONS ?= ""
 
-IMAGER_BUILD_DEPS:append = " dosfstools-native"
-IMAGER_BUILD_DEPS:remove:buster = "dosfstools-native"
-IMAGER_BUILD_DEPS:remove:trixie = "dosfstools-native"
+IMAGER_BUILD_DEPS:append:bullseye = " dosfstools-native"
+IMAGER_BUILD_DEPS:append:bookworm = " dosfstools-native"
 
 PREFERRED_VERSION_linux-cip-native ?= "${PREFERRED_VERSION_linux-cip}"
 PREFERRED_VERSION_linux-cip-kbuildtarget ?= "${PREFERRED_VERSION_linux-cip}"
-- 
2.51.0

