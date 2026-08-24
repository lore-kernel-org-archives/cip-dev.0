Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C517FC5DF81
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 16:18:04 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.19])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1400.1787588281920339802
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Aug 2026 09:18:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Katf+YKM;
 spf=pass (domain: siemens.com, ip: 40.107.130.19, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIGPf8evB0XMY3PSCylWAbpANMGm5nQ/rVEZZe1HdavCg9kpspoTL3gVj8SZlSzHtrBV5iZUoOs5wLi6ua8DjuP/n1BAlZYzQo6V0ebFOOwUbQ6+wmZT/R8ZT/ba0KZqjpBMso9reYdIrvs1n0vyUfqJGqRduBXYeEuIVVZOhH74ZK3N3WmFULIhznJvIxD/effWPNSlizUDuZ6bvzX5k/F6XZ/CxoF2oBseYpIDuTS6E8CUDKgXcL9I5qK5FVXeY0gehSSo1kAGc6I7ZTaHqVCCBba21OTlfKFYpdWnbPVkpK7VTKU3+mjlp6oELNZO+ed/6vWKMVykXrcpI+LeUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8mkPNDcWN5dlwBZtmF/Mh2yQ1utzTQ8hW1vqfeCxFc=;
 b=aarmy1gVXBKawZxDN6WBKY2L8AJN3ExE2kYZxCP1KwRfAIgjUjl/vhtfYmKk438GZoQW3rhktjpcdQMwy8Np7TLsTJYPlrRiIsJbnnJ6wQ25nc4pgtHN6fE8cDqqHERaFeRw/51n9U0o3w95Am8wPk54nRTbTx3oyleuefzNrJg0KlsgUFqLQXHs6CaHrCsJTBwYffF5yLCPPS/2kSXlTBxb8JYQW2p/TB3Xoqkr9MBd/cfhQYhLFW8TG/dEsacuJlvkJZUhA4MwTSVr7ZWPwAnj7Qwu7hb6jcqA/nJ2pBY8FzE2yvjaVcKJm9eAWsG7Vgrf1Acg/bHXPkaAKgPu0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8mkPNDcWN5dlwBZtmF/Mh2yQ1utzTQ8hW1vqfeCxFc=;
 b=Katf+YKMpjDudh6L3NoEVLVCdj6OpLg0cgGpdVwPRWm+8JyQ2sbVgPQEdd5Rq2BZNs7MOp+3dcj/tqe1GBenKG4B++eDH4DOdSadWze931CSEEf1fO/u11S8nUtWFfRHNUpNPmTKkinUbyeQ3CROBzsCdApnVrJCtdfLi/thjoC1FV/cBz2ufgbX1wYir3Cj+1g9CBJVI0su5PATo3Osh8ZOb5Tgx95NDg84XvBUzSlUJjger+oQLi59/8uSoZ54+hjr7HnnJAbGY6rkXr5qzvFTNY3XMmzIF+qwKQR51bvwd9LaCFBrwkS1Tz+tJApXCXudzX9gLf9c3CHDM/K/Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7145.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:459::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 16:17:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 16:17:54 +0000
Message-ID: <fb8f6674-7d83-4fb3-891c-4dc6e10a263b@siemens.com>
Date: Mon, 24 Aug 2026 18:17:53 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] initramfs-crypt-hook: Use multi-call tpm2
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: bc831243-651c-4489-507e-08df01fb40ad
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|6133799003|3023799007|18002099003|55112099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	2j2A9YVil8qLrmAjprpUU2P1nlvoTugf0oqcMqaqVooKZLUWnYWJMQZIYQViHo//QPGC0CXi4RbrxITcVymLm7edP31qSMRwt00t7b+WIR9xjYVLC1EK/dFddX1WE7j9mqnFK/kh8/1cjrXoVHaFHlk+B60rN2XF4uVh8clE+ZjyY4Rwo3W+HDtuQJoPQ1uzrqt/sabwXUp08LZ+jGiXRMJ7UBosfCHo1XFcFoND3VXhfAstL8smZxjvNtDCO7aD/sbFsulyP1Ijh8/MdXqfBABKln/UPH84LNOGFnFPiQh8FJ+bWJIdCEwTtX6pXKcqjTqM4LYCuYbl4vrYeinusvRteay2IQtjzz+clP6MMyLMJXqpBzZSTWfBFV/xnbvOwCgtFZfqmOikZSdEXHGO98+ofZ8PQxH3mm+Rcy6DB+aGZr9iAXDAxII2o9yf3rS+NlSPia+8Jhje2pBfyr/Upop1BHNRMyerJVsEQV6jUaMkVEaYHrcGNv4SIvq/WxaWZ7b5aO/A6uKP09IL8KT3tjMvSGQImhlGZ5mI72zDBamLbISMeSMGY0eNNJ748exMHkSS2nZSmnJix/VL1PCymg4GEjqG6l1UrZFcX9oCeRR8DYzKLByKY/1jQcEvqNji5VFMkczSgvD23wlu2QRocXbYnBi+WQYcITlvVyY5Rys=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(6133799003)(3023799007)(18002099003)(55112099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZUdDSlZGT3RSNkhOVTNTUUNGY0lnUk5vakRGMkl1bDlYOHFMSWhFN3lxWUlK?=
 =?utf-8?B?M2o4UTRjbmZZYmRvVS8wQnd1TTUxR09SbFJJeStnRTdUQno3V1lZR2hCeFhS?=
 =?utf-8?B?VnFJSnd2SXYwb1NZdm5YeVd1Mk00VDRpZ0dPdmpveTgvTUMxL3JJdHBlejBM?=
 =?utf-8?B?UHJtTy9KOEFwR2lUMjZVZzBzTUJKR0dlcUsvNmtCWWJDcHNoQ3Robk1SU052?=
 =?utf-8?B?d244c3NsZ0ZYN0JCR04xUEFVeklJUWZURWxtT0E2a3FneUlmWjBNNUdHOHVy?=
 =?utf-8?B?eWluUzBsYmRRT1gvZG9DdUh2a250RlJKWkdGSW5NUWRocWZNVnJTQkxlSHhw?=
 =?utf-8?B?ZHhRZzJCMVRib1VRRzcxZk00M2IrM0hnYmRnaGxZd0I2MXlqbVhtTUZWbWhH?=
 =?utf-8?B?ZzRZdGtCR0V2Wmp4VFZBUkVFNVRtNHNIOG14NzY1eEFQUEErV2FuMUJQaFQv?=
 =?utf-8?B?Uk9EMXJwZDZ4a21zcDlkcDcvYXAyREFYSVhYQ0ZmdmR6aEd5anozVkh6UnhH?=
 =?utf-8?B?Um9Tc0c0V0xGc3E1ZU5FdG1VOXJMLy85WGFoTEZleTFmSnlJbjB0Yys3UEVZ?=
 =?utf-8?B?bFF6V2Vtc1FLTlhKR0dGN2N1aEdmeGd3Tis2R3NrcGdlbmYzdWFtZ0pRbzJp?=
 =?utf-8?B?YU1PUGd6ekRHMFYvU2VKbGJDOHJUVlBkVmV0SGZIeXRpbmxJUHF6SlkxaHFN?=
 =?utf-8?B?bmhoeGVmNkxsbUZ1L2duNHZWMkl1REpGUjFnay9RelNjY3Y5Unl5aXIrMlNM?=
 =?utf-8?B?d2VYWmNRSDNzTkRRQVRLU1NQWHVlbnowTWtHYXVIMWlvYmljVVhvRHd3Uy9S?=
 =?utf-8?B?VHZYQm5XMHd4VGtzdjlPanNUaHpjZE9YOE5TMzEwdmNqSkpYVkMzeGZ4Y2cz?=
 =?utf-8?B?Tkd4U2U5V3ZzaTJkTE9yTmY3bU1HTFdyVVZEZGpmNHZKMGFidWxmMGJyWXNt?=
 =?utf-8?B?UEdlVGRhOW9wdHVaNDd6djJnNE5VQnhIL1owL2poRnAwUE10ZXpYb0hidHFY?=
 =?utf-8?B?VFBWVjBLMVJoTS9Kc2lUMGpDeFdmbXlBQVV1N1J2RjBCUUVrYWhBbWptZC9I?=
 =?utf-8?B?Z0JZWFdCNVEyYUxHVnIzVTkzWGk3aU8wMnR4VkpucXlqR3pWcFgvYTg1UUpQ?=
 =?utf-8?B?RXZxakNIRzNuWHdhU2hTbnFtbzZhSGhnMFBCaDhadkZOeG1oVTMyakRJZ0ov?=
 =?utf-8?B?NzE3UjkwREVsK3hxN284ZmxJLzZNc2NydW9DbHZQbmRvQzNMcE9zUHRQOXV3?=
 =?utf-8?B?MnkvOGlLRVZ4Y3NIQ3VicE9JRitpVlAxYmxBL1lycnRzTHh2ZkdtMUc4S3lw?=
 =?utf-8?B?Uk9ESHJ0R1JydkNzSlpCZFVKV2YwYStKUGZSbDFTU2RsLzVHUXp0M3F6Q0FH?=
 =?utf-8?B?QUlUWWJaSjh1akxqQ0FDNHh0M2tCMy92R3A2MnRCcFhWaTg5TlBHay9STzB0?=
 =?utf-8?B?NU54blV1M1htL2ljb0xiMks1VHoyb0xtSGZkZ1pYdGVXejJ2dEhMbklrK2Vz?=
 =?utf-8?B?WWlXZnVRVlVHbVN2cHpIazVHTXo4QU9qa1ZOQjJyM3lBak4xSWRYcGxyaFpQ?=
 =?utf-8?B?bTdoM1FRZnVsYkVROU40Rlk2TWllSUN3TlF4bFBlTU1ObWk4SHR2S3hYOW53?=
 =?utf-8?B?RUZkalJrUEFSaXJIUWVOclYvc3MxelJ4MzZmOUlPbHdNSTlydHJZeEs3VGZB?=
 =?utf-8?B?Sm84NUZvdDdJSUYwQjVCK2xtYXF6QlAvNVhTcnVlRWY1YmZ0SVRHcm9QRDN1?=
 =?utf-8?B?aGZOaG5UQTF4MEVsbWE2UjhCOUJiQmQ1L3NKeHg3dmJJdjZYWDlhaGE1NEMz?=
 =?utf-8?B?NDhWNUc1NnlXWEI1OE1jZFROK3J0NVJ4WEd2K0NsNWNxYXNaZEVDcWVoL1hi?=
 =?utf-8?B?SjdLeXpkK3RydG10WExUL3pKU1FucGxGVUs0TkZRaExoSVB5OWdKOUVJTTZV?=
 =?utf-8?B?NllJQ2dMeGpmb2IzeWwxN29vZHlVRkdocG9jNWlLa1ZkdElnOEpLQ1pZN25B?=
 =?utf-8?B?dGlZOHZJZlI3OWk2ZS9Ja3VzVkRGTWc4Q0RmM3FUeVhBMlRwdmJKKzVGeVYr?=
 =?utf-8?B?RmtCUmVaZ2UyWG9QdE1aaTlRUUVWZFV6U2hpU2lBYXRNcWFVNkp4UHR5aU53?=
 =?utf-8?B?aGdjLzBVb1VBUTZYVmNxVElxTUMyZGplSXVJdnMrdjg4elBJOUVub3h4VnJu?=
 =?utf-8?B?RHNTU3ZuTG11REFUSDJjZlR5cmVvMlIzZGtOZzhoNzlIdWErTHljZnhQKzR6?=
 =?utf-8?B?K2lTY3Q5M0JFbVdxc01weTdmT2FveENaMUh1Z01XOUdzNmQxb0oramhXb0dQ?=
 =?utf-8?B?M0Y0WUkyU0p5WG5yYWJkbFNXNExFNzMrazdBbEUzWFJITW1OU3RhUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc831243-651c-4489-507e-08df01fb40ad
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 16:17:54.5830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAZUwhDmSamrx/X7zH5z4PyCDnxX1ANU0VuGWZCuhkxUIjyXi7k6B3ReAHIWNLViVdxiYzsjZExtHn0N1MoQqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7145
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Aug 2026 16:18:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23995

From: Jan Kiszka <jan.kiszka@siemens.com>

tpm2 is a multi-call binary, all the subcommands we currently install
are just links to it. Avoid setting up those links and use tpm2 only to
accelerate the installation procedure and simplify the recipe. The only
exception is tpm2_shutdown which we continue to use as availability
marker.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Please double-check that I didn't forget a conversion or otherwise mess 
something up.

 .../files/encrypt_partition.systemd.script    |  4 +--
 .../files/local-top-complete                  |  2 +-
 .../initramfs-crypt-hook/files/tpm2_functions | 30 +++++++++----------
 .../files/tpm2_functions.buster               |  2 +-
 .../initramfs-crypt-hook_0.11.bb              | 12 ++------
 5 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
index 94346a87..e1416946 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
@@ -29,8 +29,8 @@ enroll_tpm2_token() {
 	# systemd-cryptenroll persists its TPM2 SRK at handle 0x81000001
 	# evict any stale handle before enrollment to avoid
 	# "Failed to seal to TPM2: State not recoverable".
-	if tpm2_getcap handles-persistent 2>/dev/null | grep -q "0x81000001"; then
-		if ! tpm2_evictcontrol -C o -c 0x81000001; then
+	if tpm2 getcap handles-persistent 2>/dev/null | grep -q "0x81000001"; then
+		if ! tpm2 evictcontrol -C o -c 0x81000001; then
 			panic "Failed to evict stale TPM2 handle 0x81000001!"
 		fi
 	fi
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 7bc08e55..5aed1c06 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -367,7 +367,7 @@ done
 
 if [ -x /usr/bin/tpm2_shutdown ]; then
 	# shutdown the TPM to avoid DA lockout due to powerfailure
-	tpm2_shutdown -c
+	tpm2 shutdown -c
 fi
 
 if [ -n "$watchdog_pid" ]; then
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
index 1c6bbff8..1ab9ea5d 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
+++ b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
@@ -11,9 +11,9 @@
 # SPDX-License-Identifier: MIT
 
 tpm2_check_device() {
-	tpm2_pcrread -T device:"$1" "$pcr_bank_hash_type":7 2>/dev/null \
+	tpm2 pcrread -T device:"$1" "$pcr_bank_hash_type":7 2>/dev/null \
 		| grep -qv "$pcr_bank_hash_type" &&
-		tpm2_testparms -T device:"$1" "$tpm_key_algorithm" --quiet 2>/dev/null
+		tpm2 testparms -T device:"$1" "$tpm_key_algorithm" --quiet 2>/dev/null
 }
 
 TPM2_HANDLE="0x81080001"
@@ -24,44 +24,44 @@ tpm2_key_get() {
 
 	export TPM2TOOLS_TCTI="device:${tpm_device}"
 
-	if ! tpm2_getcap handles-persistent | grep -q "$TPM2_HANDLE"; then
+	if ! tpm2 getcap handles-persistent | grep -q "$TPM2_HANDLE"; then
 		mkdir -p "${TPM2_WORKDIR}"
 		# Open session:
-		tpm2_startauthsession -S "${TPM2_WORKDIR}/session.ctx"
-		tpm2_policypcr -Q -S "${TPM2_WORKDIR}/session.ctx" \
+		tpm2 startauthsession -S "${TPM2_WORKDIR}/session.ctx"
+		tpm2 policypcr -Q -S "${TPM2_WORKDIR}/session.ctx" \
 			-l "${pcr_bank_hash_type}:7" \
 			-L "${TPM2_WORKDIR}/pcr7.${pcr_bank_hash_type}.policy"
-		tpm2_flushcontext "${TPM2_WORKDIR}/session.ctx"
+		tpm2 flushcontext "${TPM2_WORKDIR}/session.ctx"
 
 		# Add new key to tpm:
-		tpm2_createprimary -Q -C o -c "${TPM2_WORKDIR}/prim.ctx"
-		pwgen -s -1 32 | tpm2_create -Q -g sha256 \
+		tpm2 createprimary -Q -C o -c "${TPM2_WORKDIR}/prim.ctx"
+		pwgen -s -1 32 | tpm2 create -Q -g sha256 \
 			-u "${TPM2_WORKDIR}/pcr_seal_key.pub" \
 			-r "${TPM2_WORKDIR}/pcr_seal_key.priv" \
 			-i - \
 			-C "${TPM2_WORKDIR}/prim.ctx" \
 			-L "${TPM2_WORKDIR}/pcr7.${pcr_bank_hash_type}.policy"
-		tpm2_load -Q \
+		tpm2 load -Q \
 			-C "${TPM2_WORKDIR}/prim.ctx" \
 			-u "${TPM2_WORKDIR}/pcr_seal_key.pub" \
 			-r "${TPM2_WORKDIR}/pcr_seal_key.priv" \
 			-c "${TPM2_WORKDIR}/pcr_seal_key.ctx"
-		tpm2_evictcontrol -c "${TPM2_WORKDIR}/pcr_seal_key.ctx" \
+		tpm2 evictcontrol -c "${TPM2_WORKDIR}/pcr_seal_key.ctx" \
 			"$TPM2_HANDLE" -C o
 
 		rm -rf "${TPM2_WORKDIR}"
 	fi
 
 	mkdir -p "${TPM2_WORKDIR}"
-	tpm2_startauthsession --policy-session -S "${TPM2_WORKDIR}/session.ctx"
-	tpm2_policypcr -Q -S "${TPM2_WORKDIR}/session.ctx" \
+	tpm2 startauthsession --policy-session -S "${TPM2_WORKDIR}/session.ctx"
+	tpm2 policypcr -Q -S "${TPM2_WORKDIR}/session.ctx" \
 		-l "${pcr_bank_hash_type}:7"
-	tpm2_unseal -p "session:${TPM2_WORKDIR}/session.ctx" -c "$TPM2_HANDLE" \
+	tpm2 unseal -p "session:${TPM2_WORKDIR}/session.ctx" -c "$TPM2_HANDLE" \
 		-o "$key_file"
-	tpm2_flushcontext "${TPM2_WORKDIR}/session.ctx"
+	tpm2 flushcontext "${TPM2_WORKDIR}/session.ctx"
 	rm -rf "${TPM2_WORKDIR}"
 }
 
 tpm2_key_del() {
-	tpm2_evictcontrol -C o -c "$TPM2_HANDLE"
+	tpm2 evictcontrol -C o -c "$TPM2_HANDLE"
 }
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions.buster b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions.buster
index 453ba977..37d0787f 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions.buster
+++ b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions.buster
@@ -11,7 +11,7 @@
 
 tpm2_check_device() {
 	export TPM2TOOLS_DEVICE_FILE="$1"
-	tpm2_pcrlist -L "${pcr_bank_hash_type}:7" > /dev/null
+	tpm2 pcrlist -L "${pcr_bank_hash_type}:7" > /dev/null
 }
 
 tpm2_key_get() {
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
index 49ccc076..2312a73c 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
@@ -52,27 +52,21 @@ HOOK_ADD_MODULES = " \
 
 HOOK_COPY_EXECS = " \
     pwgen mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
-    e2fsck resize2fs cryptsetup rm cmp \
-    tpm2_pcrread tpm2_testparms tpm2_flushcontext tpm2_shutdown \
-    tpm2_startauthsession tpm2_policypcr tpm2_createprimary tpm2_create \
-    tpm2_load tpm2_evictcontrol tpm2_unseal tpm2_getcap \
+    e2fsck resize2fs cryptsetup rm cmp tpm2 tpm2_shutdown \
     /usr/lib/*/libgcc_s.so.1"
 
 HOOK_COPY_EXECS:append:clevis = " \
     clevis clevis-decrypt clevis-encrypt-tpm2 clevis-decrypt-tpm2 \
     clevis-luks-bind clevis-luks-unlock \
     clevis-luks-list clevis-luks-common-functions \
-    tpm2_createpolicy \
     bash luksmeta jose sed tail sort rm mktemp pwmake file"
 HOOK_COPY_EXECS:append:systemd = " \
     systemd-cryptenroll /usr/lib/systemd/systemd-cryptsetup \
     /usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so"
 
-HOOK_COPY_EXECS:append:buster = " cryptsetup-reencrypt tpm2_pcrlist"
+HOOK_COPY_EXECS:append:buster = " cryptsetup-reencrypt"
 HOOK_COPY_EXECS:remove:buster = " \
-    tpm2_pcrread tpm2_testparms tpm2_flushcontext tpm2_shutdown \
-    tpm2_startauthsession tpm2_policypcr tpm2_evictcontrol tpm2_getcap \
-    clevis-luks-list clevis-luks-common-functions"
+    tpm2_shutdown clevis-luks-list clevis-luks-common-functions"
 HOOK_COPY_EXECS:append:bullseye = " cryptsetup-reencrypt"
 
 SRC_URI += "file://encrypt_partition.env.tmpl \
-- 
2.47.3

