Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1751C021B8
	for <webhook@archiver.kernel.org>; Tue,  4 Mar 2025 11:45:34 +0000 (UTC)
Received: from AS8PR03CU001.outbound.protection.outlook.com (AS8PR03CU001.outbound.protection.outlook.com [52.101.71.45])
 by mx.groups.io with SMTP id smtpd.web10.19930.1741088725937492360
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Mar 2025 03:45:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Gjpm6Jeq;
 spf=pass (domain: siemens.com, ip: 52.101.71.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSihrsGFavNxxD2k+3DvKSI+f5GApi/nsIPiJZ813bMiO7OnCC5QC6wpV5tMiR2IO+SUJyQISQXDWSUr/8FSQrXZWCgM/84vUIi0mzxAOGq7UuyUKzO0KNmtO9ToEdPsQ2UxJkgadUljw3oh2USBX2VysUQ3Ai/pW5f/1dVleDbs6IX9CM5fOyJTRwCSkHR7V+oYzfUX8qfZvuyjtIfWx6JCjJgyEp+iIIArUSLFI0TTdHpa1qksueE4FmK3UDNXM5wr54RKoujooZ1b8bkxx0dYjXPdDWCUoe3xqgCrn7VtpPF79wceWluOXKu2S20OAkAnMbhVs9NP9idCzFz/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQUbOHXI38L175u3QCQDv6YcdT34H8MnJMCQG1nv68o=;
 b=kMA1sOeSMKdBlPagtI+JFKXdySE8Yf5BPybzyqb9FvueshhbNPO0LYUO1oVP0IiIDeE6M10AZpfHiRU/OX5gl+ZeBCROGygma5T4L5INX2yFrnsI6QD20q+3M7Pf7WEG3kgXP524KJnqmgRVJnS4poCjFr4ZDmEO0/NrhtkEXcwabhvzB0pVULgbn0a75lRqAeKz/H+RTwZRDpWKl/E96a+9oHLR2Ipq6IuQSLt98TNS8D4FByQHXStMNA6PAWCwaUaM9kHS6B82QN7v7h2ku3eVwbASaOJX3R4vbncwfh3pps+IDkllbQF2ABZZYEQUwwZHjag88xsQMlJCI8JkBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQUbOHXI38L175u3QCQDv6YcdT34H8MnJMCQG1nv68o=;
 b=Gjpm6JeqKt5mFf3aGpHTmCn4pnD0bsQLTWC45yR4hn325bgk/uX0OYa5FZGcRWCr/bt3GGzRMidXsWlqIPoJTwZEiOKnVE8b1X5C2PomM8ebUFDTizDgA6RhuOt/ViecyOrerBS9sNpQS/+xXj+5htwO3RWb02fAgTc6zvd7OzRt2e8zyogmY5/Yd3Lv8UUxtEtqWCXfwccngre78isLalUZNGPLQqj0ONgyNa/DWp2mBugraLRPrvopkiu6aGlvT7zOnSK+rAB8sHixkuwpHZOboEi3os89rdNewZq1OC/kz4zvwMnaU5byDcpjwcwyLczxQUELebnaLG4pUzHWAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM9PR10MB4119.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 11:45:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 11:45:23 +0000
Message-ID: <e5b6c72c-15fd-4b9a-93bc-bf5499a9bfa5@siemens.com>
Date: Tue, 4 Mar 2025 12:45:18 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] initramfs-abrootfs/crypt-hook: Ensure that
 cryptroot is always last in local-top
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:610:4e::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM9PR10MB4119:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f240f1-770e-431f-62e7-08dd5b120c21
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aWE4WkxYeGxlQ0VPdVdvbm80NytWVmVqRElTckcwbXJxd244SVlTSldLeTIz?=
 =?utf-8?B?dUc3Wk1uWHl6SExCQlA3NGxGR2FXL1BpV2U0SmJ1cVJTZkpyUWJiaHA4SlpV?=
 =?utf-8?B?WG5hTlYzK3FqYUk5UGhNTzltWkpDVzZPeW94SW9PUGNpcTlOcVZYNjRHVlo4?=
 =?utf-8?B?K3VlTENLYjJHZisvL2h4UFloOXI2Tlp3RnUwQ0lPQW00TDFVcWl1YytySWZx?=
 =?utf-8?B?UXBoNWpzSzFIay9HTlFldVFic1ZxT3FNVHNVVlJPUGc0UXlpOGxUbWN1aVR3?=
 =?utf-8?B?dElVR0lRQ05mZG5VdFFUNXhEdDdHdmFDckRFQm1oNFE2b1dzQ1lDU2hzdU5R?=
 =?utf-8?B?ZFMwWGt1bTlHYWREK0hSVW9nM3d2eXFQZ1BrYmw5ekpXVzFoeGxNWkJId0xQ?=
 =?utf-8?B?UWplMVdZdHh5RXFvZXZPNDhpRDZKVks2N0hEYnB6ZGVvTUVJZTdUdXMxWUZQ?=
 =?utf-8?B?TUFvRmUxQVpCS1R0a0VRS25ZeDNzb0JMcjg1Q2p2WU15WlN5YVc4WkNQbGRt?=
 =?utf-8?B?N3RaRktxSUV6cU94TXVjYjJBZHd5U09BK2hVNzhLSWhaYVRkMXJVSzl6NnNY?=
 =?utf-8?B?UlJiRmNBQ0J4cUo3bHJNQzh1SzB5T0FPVUd1bG82MXQzYTdwKzNPMEtNbVN2?=
 =?utf-8?B?UURHRk5SKzJLL2p3dm0xL1JYaWpIK0pUQWcrVFQ0S0xrMzFoVUxwemVpODZM?=
 =?utf-8?B?T2FPSCtKRTJEaEpxU3F6aEEyTnMzOVdVL2RKTUxYTS9nK2phSEFjbEc0WG5G?=
 =?utf-8?B?Y1lpemk4QU44ZTZING9taE5BWVdDejk0UzFzTEZrc2NscTNzbVpOb0xRUWJ3?=
 =?utf-8?B?aGxzRkxDcGRiVm96TFdndExzOTdKY3FaSGs5NDB4M2ZlUTdxbklpLzRadW1K?=
 =?utf-8?B?OElKaWVLUzFIWis1clU3QjNaTithNGN2U0VHRmhsK3ZHWmtyN1pxUUxRWi9X?=
 =?utf-8?B?a2pKdFRwdzRhRmo2TE1DUkltd0svQ003czVtZEFTY0xpb0d5blBPcEo5RUZ3?=
 =?utf-8?B?bmNSQWdESjBscWpoRXJ4VndVK0g2ZlREWTdpZUdDUWt6c3ZoWTV6Q3BuTDR1?=
 =?utf-8?B?WkhFVVBEWTVLRG8vc3FnYk5FbDhjeGV5bnhpdFF3Q01QSk5WMStVOU1Sbmlq?=
 =?utf-8?B?S2ZmajhJQkZ2eFdJSlZvMHEwbnRqejhpTHIyNVh2RjhNaW03VHN5Zy90Y0FH?=
 =?utf-8?B?T3dpSzVLZDZKdjFVbEJEMkZ6Q0lzNnh6S1NUZVN3QnRNU1E4NnE5UFF5d0NW?=
 =?utf-8?B?ZllvbnIycTZRODRYNFZ0blM0M0RhblBFd1ErZjBKbzVwVG9xamxmSG9ENUVn?=
 =?utf-8?B?MHNLT3YxZm9LODJUZnFJMzJMOERiT2dEamdBVHg0Vkw5UGkzWWFORXBrMW5U?=
 =?utf-8?B?OHd6SzdOZXNCWDFzTzJvMTZrMnlTakxiNEtianRpREdNUDM5WmQ0bG5NR3l2?=
 =?utf-8?B?Q0JjNFBreWNCQlo3ZmYvOXd3S3FmSUZzNHpWcmRNVTVkd0huTVp0V0J2Y1hG?=
 =?utf-8?B?dVp2MTN6dmlobDhFRGtOSlp0U2dVSGF2NUZqTGRKUVhRenBMYU5LbnMvU3g2?=
 =?utf-8?B?WnRNZHRMOE9SaU5TOU5HYXZiSFdUckV6WjB6L01SZmpWc1k1akF3L0J1REYr?=
 =?utf-8?B?cFBBVHZTMHk0cndiOFQ5TVJ5MG5lck5ZcUdGZVlKQjljUDBnVC9IK1ZEYmxB?=
 =?utf-8?B?N3BVRUZCZjVYWGQ2VWIySG1CME1MOStEeWozejhqbVgvZkRGTEJ3NnJ6c0tk?=
 =?utf-8?B?bS9xUy8vTkZrK2VvbDZmOXBoR2NRU0ZPNVZQOUI5TlNTWnNqaUxwMFREMnBz?=
 =?utf-8?B?M0duMmhtMzU4VklsNmdjamdCWEErMjFWWWVGVVpqVy8raWtRRVF2YnZwSXY5?=
 =?utf-8?Q?5Vr0KrTlxaCYf?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K2doZklmdW1rYWNqdVh2d1hTOE9OS1VVNEUzY290Z3hUOUtaQlI2YTRUMXpL?=
 =?utf-8?B?OS9JblhlK3k5OGozTTJlRTBRcDk5K3BiZFpnd2xUdEpsSmE5aU9uNTlMbUgv?=
 =?utf-8?B?dDA0Z1l1TjlYdjlMdHVzaVV4VS9MMThnM0lHNzBJK1dPRDBhNUloYVhxQmp0?=
 =?utf-8?B?TW4wL3dZbU5BM1JlaGMwajU3a24xMVRZNlVBTTliNmFVb0kvZG5aRWZPbzh2?=
 =?utf-8?B?bVU3VzltWWRLTkU5RjFOZmw5Tnd5dytFTEZqOW9lbEh3ZGR6OVUrNDJtWUhv?=
 =?utf-8?B?WHRHeTVxMmNMbExselFoeVJwMmQvbzE3eC9JNmpodkpTYThUWXQyNWgwM2d0?=
 =?utf-8?B?Z2JsT0VoMnBXa2dGZkNVRENGcVRBSkF4dEZadU1zUVVYai9QWG1GZEdDNHpz?=
 =?utf-8?B?UUp3dUptYWNPZndFaUs2NHVybytXNTZjTkh2ZTZleTREYXBRamVqaEdHSVdY?=
 =?utf-8?B?ejIwcDQ5b1AvQ0U1TG1hUXp4RVIrNlFiZmluVnNLMUUrUkVic0VsOWtwN3I1?=
 =?utf-8?B?UjlYaHh3RmpvK2RvWHFxTHdNeEtHSTFrbWo4cE90eUpTbVdVMjdxZ0JpbWUx?=
 =?utf-8?B?TVJxdFpwYmRHRWovMnIybkpyclpaeEpUVGR5VU5VTE5BQXJBY0tmN1VkdlpP?=
 =?utf-8?B?THpCaXVMRnVXZktsWFIwQ24vc2lZVEU5UGwwb0pzbEZHeXNTVWtlbW9Nd1dZ?=
 =?utf-8?B?R0pvZDE3Y2ZHUE9HWmtjZDljZmYxbmlOYndkN2E2VUVQaVhGaUpwM1RQNGsy?=
 =?utf-8?B?bVlsYzUyOC9uSldSTWoxZmVJMzdPMzROak9oWDdjZFFmQmt0MkE0VStCQ0l2?=
 =?utf-8?B?b241TGNLMWYvZFByeG1zVHNUSU14QnNRTVppZ25lRE93eXVqTU1zdThHME85?=
 =?utf-8?B?SW9pRmtuZVRHaktsZU93T0oyWm4ySTVINDk1SERlWlhWSmpYUlhPMndHK0VF?=
 =?utf-8?B?Z0srWUsvMmF3V2VJeWpRRDFzQjlPaC94K0tva1NTc1hIT0Q4QlQ5VWhiNWg4?=
 =?utf-8?B?MC9aRFkxZXVpUlcxTE9YZEpiWFdwaXlPQU1McmVKcGVxaVlhRjhtdHF2OWZM?=
 =?utf-8?B?TXNSeUpsdlRBOUtDZEJob3ovRWxRcGE5WnFRQnVNWHRPMHNQRHF0Um9QakRW?=
 =?utf-8?B?elR1cFo3V24wdjk2UmFlK21xT2o3VUNYektzUUxKdFBYY3FIOVh1c3lsSGpp?=
 =?utf-8?B?ZmtCcjlQcnI3T2p5bjA4SWNOV2wyK1dFQU0ybmNRVkNub2hUdHlPSVRDZzNa?=
 =?utf-8?B?STNyL1lEZ0tQSS8zaFIyd1RTV2Nwb2lXeXRhdHlBakQrK0xLQ0JUV1lUc2k3?=
 =?utf-8?B?b2JiM0wyR1E3WXZmODRYQ1d0SnBvK2pXR3U5Z3RyV2kwWnA3V1oycTFpYllB?=
 =?utf-8?B?SlVQQjFlb3JnYklHUHk1c3phMHdRSVp3Q2V5eXlENUpjYzlsN1lHeGdiUXRO?=
 =?utf-8?B?SGhaOFlFaGRoR0JFVkE5dkFrUUhaeWVuSS9qZkhwQVVqdmgwL3R3THI1K2VD?=
 =?utf-8?B?TFJJcUlnWlBqeTQxd2ljWEVXUUd4dFZyZmx2WVBtSDJDL2hyOWRNWkZWSEN6?=
 =?utf-8?B?b3IydWUyQWlhR0NjU3I4MU93OEJNRmJHRXY4aUlVeDVtUk9yZlBSNThiZmh1?=
 =?utf-8?B?T2h2Y3poOGM1QUdlc0FpYTJaQ3lUeWNSUmdxR0x3MUtZVG1TTDRpZENvck1M?=
 =?utf-8?B?TkR5UlREK2owQmNoN0NiaTlsdm1reUJHZTJONmVsM1ZGczFoNENJd1lkRWZ3?=
 =?utf-8?B?NlVDNUpDRDc1WEM5Szlodm5PWDRlNFlNVmtueUZCOHo2ZDlUUlNYZFZSeW5X?=
 =?utf-8?B?Z1pZY210U0JQY0pSSmRqVEdKeS8rTThmRHFDWEJqeXlKWks1enB6cmk2K2hU?=
 =?utf-8?B?V2Y4a2ZhRG1JS0dhbGFKTURXNHpaSSs2YU5HVDRYUW1GcDRTMjJWNzJKLzlo?=
 =?utf-8?B?N1JxYWpoRGJjOTlzb005RHA3cFU3bzRQc1BTQWVzWncxSVhDcFhWM1ZVUTZ3?=
 =?utf-8?B?R2k3Zk5wRURUZXplcHp4aEUvWXo3MXE2VzhOT2hBK285a1BkVk10Q3Q2enIv?=
 =?utf-8?B?Q3ZHYnJKYlQyYVB2SWhNa1dnYmJNTlhZb0NkM0kwanoyK2xXK1Z5d1pWUGtn?=
 =?utf-8?B?M0VBc21YeHc3ektudDVTSVRsZW1sNFBsWUZ0bXkydURxM2swdFRKU0xjVktu?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f240f1-770e-431f-62e7-08dd5b120c21
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 11:45:23.0802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /28NAJc0FJRlrFJPJ1CLBvvbE+EtpWgt4an8Z+fzSDnN1/DUODQEj2cvq9hUfxzJ6cHstuaLFzaH4s/BAdDhaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4119
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Mar 2025 11:45:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18014

From: Jan Kiszka <jan.kiszka@siemens.com>

This breaks a circular dependency that is otherwise created when
cryptsetup-initramfs is installed. In case of isar-cip-core's initramfs
setup, this hook is unneeded. However, buster dependencies still pull it
in, causing the loop to surface - and the boot with abrootfs to break.
The dm-verity based setup was not affected.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-abrootfs-hook/files/local-top-complete          | 4 +++-
 .../initramfs-crypt-hook/files/local-top-complete             | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/recipes-initramfs/initramfs-abrootfs-hook/files/local-top-complete b/recipes-initramfs/initramfs-abrootfs-hook/files/local-top-complete
index 848e8294..7048ced4 100644
--- a/recipes-initramfs/initramfs-abrootfs-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-abrootfs-hook/files/local-top-complete
@@ -12,10 +12,12 @@
 prereqs()
 {
     # Make sure that this script is run last in local-top
+    # If the script cryptroot is installed this script
+    # should be second to last
     local req
     for req in "${0%/*}"/*; do
         script="${req##*/}"
-        if [ "$script" != "${0##*/}" ]; then
+        if [ "$script" != "${0##*/}" ] && [ "$script" != "cryptroot" ]; then
             printf '%s\n' "$script"
         fi
     done
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 502fcc16..3b3ac069 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -18,7 +18,8 @@ prereqs()
 	for req in "${0%/*}"/*; do
 		script="${req##*/}"
 		if [ "$script" != "${0##*/}" ] &&
-		   [ "$script" != "abrootfs" ] && [ "$script" != "verity" ]; then
+		   [ "$script" != "abrootfs" ] && [ "$script" != "verity" ] &&
+		   [ "$script" != "cryptroot" ]; then
 			printf '%s\n' "$script"
 		fi
 	done
-- 
2.43.0

