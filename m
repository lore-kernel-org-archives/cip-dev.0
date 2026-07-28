Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182BFC54F54
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 18:22:42 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2924.1785262950746326761
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2026 11:22:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wC5we926;
 spf=pass (domain: siemens.com, ip: 40.107.162.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogBTdw8pZ/znCmJWTznne6bGvRhd87Jot03DVSJNRweaV4RKZAihgVRF/b1BveDEQKRSzbK9WhLOEjPE9Y5XaMDdAROuaV8H0wHVqGatYDl286xdacnyIeO0VxWbZOw1j6pKDBQ2UJc6HpC8poc1donfMDRYT8q/iYLDig6bx7GEdL2c8c639NE1QkA829BsOcCM2N2R0KEC7SUoxBblqLhtGeZIDDaNKX91TkzApyN/r9uBGNsG2rA3lnTDekPrrTS+Vc5lDA6FRhHCq5oekSrKaR+EFVTE9cqZHNvSSkRVuXq7xCzQAxNt453mt6wJlP5WwI/g8v6FFFH6M1OOKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlUj6eoY7YhO10g8a2aNOfjf3528lcsk+UbXhK9Bzxs=;
 b=paxkW+53uCCIBxjON5nPgRg3sSxtRlSSAyVeOLrPdGYpFavd5HFqou+H/FJdwxrHz7PlfmMEFCxUZ+wi+p/cDMLtazGesflkJO6pxoUX+LK6VbvClX5klPwM2IIQg+D/l33vUHash+pTCABWNdC1k8rUIFX2dXZI6mWCjUEjHz/2KTnEP0eruPJdXJ/t9cDy1LySY3BbqcyrRdE0GWsP7+bS1v7lEGb8f0VsCXL13+hHyjxzl2PE9Bw8IKxKMy3ERla/Qhqp4krP7/BDSTPdNFQ98OpUWNiqAK0Kde7eGZee1ae8mbNA6RZ3kDol05RCSxrmOh3NlVP/3Ztr7+2KkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlUj6eoY7YhO10g8a2aNOfjf3528lcsk+UbXhK9Bzxs=;
 b=wC5we926E5eOQqlLaCGy74t/GDDDr0UeEwGivROK4zNHC22lvR3sLc/rR1Gr/q2jrI26UztxIxm/pO4GuLsb2TzWlSp+Aq4DCWtZTq7QdRd4qdgsJ+tiK+aiF0C1/ZtSsRVFczhVrxTzC9XmGE7gYEjAON98Du12YYtgkFTKk2zcUtvs3OJPUSbwG7EqiaFe1sFT3B1RvA21VhbN5GJoKG6UYHcBVqPq//2VyW0nrTBup76Xv02HeE91rzQvD2Av2Ts6opX0cRbpx7x5o8pHIA0wo+k0KXy+LUcer8KZ2Egr/tUT25MYKkm2AbLde/c3jMVLB6cryPr8V6CTqdNUhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6876.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:465::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 18:22:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 18:22:29 +0000
Message-ID: <76becb0a-e055-4b1c-ae13-a0aa0034ecd0@siemens.com>
Date: Tue, 28 Jul 2026 20:22:27 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Update Isar revision
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:408:ff::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: d4438c08-f01d-43ce-666c-08deecd52e75
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|55112099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	kBooO8B2Wpj3KbIwCRKIsAdjnkwWkrmhGXwqbWlt8KzvXxCrGhPUmCoG5a3fPawsRT8GTPZE49ZXi3W8gGIssRj8GRaH1yxL/vPTzNeU4Fj2BLFWyt7JsutiGtcwoniuNvUV+SgX3XbSVmJcapZuIlmCgc6uRV61v6zTb11AQwBW2ICcKPOFpdzfg9X+8T+dqklJTSyyQzvFc1W/OuXwFPaCtToXXXAh5kKFOMcoFG5HKDL6JlqmFBVCY0crZVHVIfO2+mHIz6M8Zz7ljXxnFry8UjfTw1oX0tIVMsS+pVikC7q1RBhjPlKdlvnfxpplaHX6I+cQsnluCjkBOMgBNfLptk/GiY0cHviOOcMtY/fOKO6z3zoM0bN7ubusExpbVlhDCH7weC2fbdWbRWfFJ1wMakgsf9UieamMQXP2RPUwaS91YgD4vIquYZ7iTqeIWEuB5qLAJCIvQII7YJzCpvL+rhCjXFgvJHKg/D6PF6ai0qD5KuaqqGYlJe9SZs37Gvu4Ei6gP74UhzTHvjoEb6NrQzrmbPFWmO32tKiSRBwhkf5rAYPEcvTosen8wM1OB94swgcS2zJWSRGmUvERGbmaBMFexJpi1iNcznexgrOl+bCDGKK+NkZxnejmMa63An/mblpaDw3ks4vjhuDPFlJKXbPgkhgvje2RhyOAHPU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(55112099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bVNJeGVzMGlhSXhjK0N6aVQrQ3ZrRTN0VHRuQlVHK2FldlBScDdmQU9HdVdL?=
 =?utf-8?B?ODRQNFI2WVo0WU4vazl0ditML0xNNXhtd0NsOFFVN2lCNnlJL1M2OEoxR0hK?=
 =?utf-8?B?Zm5RMnRNM0lDRFdLYXJ6Rnh2bjZPbG1yNEJBT3BKcno0cEFjRnpnUVJDdFVo?=
 =?utf-8?B?bWp2d2lNdzdsYU1adlppMWRQeVhMNG5IQlZTeVFJeHN1RTFPZENhYWJPRjEv?=
 =?utf-8?B?eFRDSHRYNGhlZ1VveFRxWkl2QUFsMWcrbk1EVEZoYjNqZzJoUVI2V3ZLUytS?=
 =?utf-8?B?M1Zzd1ZCeG9xMGRsb0tLZWEweUMvc0RPcTJZYk5rY04xNlhlVXgzU2I2K1BU?=
 =?utf-8?B?MTdraWpNZktFVHpzZWxsTVBqRk55dlRtbUg4TzdGcGlGTFFHZTlvaWIyZFJW?=
 =?utf-8?B?R1NEaWVGankxdUNQQldxbWhRY3A3RkVMcXBLaWNmWGpiSEtkMG1VeG0zREZz?=
 =?utf-8?B?d1RCSE5IK3R6MHcxYVRFQ3dSVlNvcHk5citmeHBMZi9qWVVZWURzZmRJTjNO?=
 =?utf-8?B?endWWHArUFR0NWl6NGRLME9JNmJ6STVxZ2NRcXE0MGhaZnBJeEhDNW9SUDUw?=
 =?utf-8?B?TlB1WnFRaEZzWXFiclN3VlZ5WXhzWk5TK29mQXFHZmFDV3hGWHpadTFZaGc5?=
 =?utf-8?B?R1Iwd0tac3R6dWJJTTFZRU12V1luVW1mL0VZQS9wSC9KUFNrL3E2S2VhUFRH?=
 =?utf-8?B?Q1JSK2d6VER3RjAxNHVVdnVJdjNJMEpQRXBXaTdOcDJqbkljY2NwYnNla2dV?=
 =?utf-8?B?RVgxRDhzRExydERwYlBUWTk3OVNOZVYvSGVzWHV5djBGMVp5clNMSW5WOGln?=
 =?utf-8?B?dDdMNDluNEc0OGhBd1RvNHIycjJ4c3Bud1ExNUxDU0VkWGx2S3hVQmR3anFx?=
 =?utf-8?B?UUtXWTJVeGJhRnRKdGUyUkZoWFpibExIU2RhamY2RzJpeGVlS1M5UXEzLzJz?=
 =?utf-8?B?aUk2UlJCZlhNZ0w3TXFCcFRNWStURWZYSVp5TEpyaThIbmxwMk53VTRTNlBP?=
 =?utf-8?B?SExIOWRteG9JVVJWOUdKb042YVdzNzNvRldCb0EzSXhBV0NYZEFMdzJqeG5V?=
 =?utf-8?B?dGN1U2dOd1lYOVo2SDBwMmVBa29LekthZmd5T3F3YlltSHJWZC9pVmFOellH?=
 =?utf-8?B?WU40bk1RQ3ZPNGVwMVBTVFpjcXhaMVF6QldYR1ozS3VMNGM4V1g4UEhhM2NG?=
 =?utf-8?B?OXAveDBKV1lwbGNLQ3duTWE1NnV2WFFwVlhGcFYvQnJnYW5qZ3JTOXFvOHB3?=
 =?utf-8?B?ZDlCOVZIMldUdktQQ29LUTlmd3QxTmVIR1VqSkd1SVkwT1pmSWcwVTFEcTIy?=
 =?utf-8?B?RkxqVkJEZTFNNXFIdXVDVnRSTFdXQXZvL0JiZlZmMmRxSThTWUVKU05vWWdC?=
 =?utf-8?B?Z2FDZytsM3ZGaFF1WVVmMUVHMjNxUmdiQlc0ekdHTlNLK0pJSmJVODU1Z3Yw?=
 =?utf-8?B?V09ZOFRrNXp3djBHVVhNTkpSRVZSK0hSd0xFVVpoWVlhVmNhb0VWSGdYRzBT?=
 =?utf-8?B?Z3FnVFNuTzJteEtld1BQOG1yOG51NVhBQXI3bE5ySGl6SkdtVGRkS3ZWazQw?=
 =?utf-8?B?R2hkeHdKMjBjcG15eEt2WC9mR3huUVlqVThrNkxjQ3lkYTNRUlBHQ2dzNUsw?=
 =?utf-8?B?NUY0NUt0dmQ2S2psaTN0MGliNVhhSnprT09IenFGbWc1V2VSM0wzM1BxMzVM?=
 =?utf-8?B?emQvQ1RqRGc3V1lNMjZTWEpYU0JJTG1Vd1dIVDZNNW0zd2plOTgzRENaSktM?=
 =?utf-8?B?M0QrcXhtLzF1SlB4RXlZczloMHUzUHFUV3JDYjY4bW1va2hyYTREYWFlQ0xI?=
 =?utf-8?B?U1oxSmxtV0lmOGF2eFgrY1lOOXU3aThjTXltMmxYOTBrQmk1Ny9JQnNITzBh?=
 =?utf-8?B?ZHhUSzhRMTdSSjNBSlVuUEd0UzhYTGdUdW56L0Y4RkZwblhGVVVEM2VMUEMw?=
 =?utf-8?B?bW5ZakxSdjNkdjJVNWtaeHdvMUNOR2lBdStlNkdwakIrc1hHNytJblQ2NUll?=
 =?utf-8?B?YVJ4Y2UxMGlVcDkwMGlpWk8yZE1KTCtpSXB3UTRxa2JTYWRvMFREWUVlMENM?=
 =?utf-8?B?Z0dSWkRMUmFmSVFhaUxTMFVXUEhPWGtnclRFTFVhakRjd0pyeGl0VEwrRWNu?=
 =?utf-8?B?UW5ENzhrTWpiRkt3REkxZ3Q5bC9WSUJtR0ZlUURvZ3d2SnBmVURaVEVscGoy?=
 =?utf-8?B?aGh6MFAvdEZkcDZjMXQ1OE9hSnpaNWNudzNTOGVYQTBLQThyRmppWTczQ2Rn?=
 =?utf-8?B?dDR1cXhsZGR5SzJoSWJibVRNbGdnUGlyQkZrODZQWTFUeHdGcUhHMHEzZllP?=
 =?utf-8?B?Uks1NXZVaWhFSzBxbzUwdUlFYldzaE03T0ZFeDV0V0VPRjZhbGc1UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4438c08-f01d-43ce-666c-08deecd52e75
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 18:22:29.0927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gpcp7ZVjrzoJfd59h/b+aDOcgb7ZBh/rEi4fEh3VrBjEGqdR8PT2hntJKJf1jiuX0RrwFiaeel+dND0lz/UAHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6876
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jul 2026 18:22:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23810

From: Jan Kiszka <jan.kiszka@siemens.com>

Brings a couple of fixes for the new rootless mode.

This requires adjustments of the deploy_firmware tasks because .deb
files are deployed differently now.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas-cip.yml                                                   | 2 +-
 recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb               | 2 +-
 .../trusted-firmware-a-qemu-arm64_2.13.0.bb                   | 4 ++--
 recipes-bsp/u-boot/u-boot-qemu-common.inc                     | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index eb267165..f43da61f 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: ea319eb835aea545f23266ba15358bad029a56a0
+    commit: 8ae7612dbc72607825e3efce6c3f8eef66200f2d
     layers:
       meta:
 
diff --git a/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb b/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb
index 6e3f2497..9c2becec 100644
--- a/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb
+++ b/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb
@@ -14,7 +14,7 @@ OPENSBI_BIN = "fw_payload.bin"
 OPENSBI_EXTRA_BUILDARGS = "FW_PAYLOAD_PATH=/usr/lib/u-boot/qemu-riscv64/u-boot.bin"
 
 do_deploy_firmware() {
-    dpkg --fsys-tarfile "${WORKDIR}/${PN}_${PV}_${DISTRO_ARCH}.deb" | \
+    dpkg --fsys-tarfile "${DEPLOYDIR}/${PN}_${PV}_${DISTRO_ARCH}.deb" | \
         tar xOf - "./usr/lib/opensbi/${MACHINE}/${OPENSBI_BIN}" \
         > "${DEPLOYDIR_FIRMWARE}/${OPENSBI_BIN}"
 }
diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb
index 4786f349..7fcd1440 100644
--- a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb
+++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb
@@ -32,10 +32,10 @@ TF_A_EXTRA_BUILDARGS = " \
 TF_A_BINARIES = "release/bl1.bin release/fip.bin"
 
 do_deploy_firmware() {
-    dpkg --fsys-tarfile "${WORKDIR}/trusted-firmware-a-${TF_A_NAME}_${PV}_${DISTRO_ARCH}.deb" | \
+    dpkg --fsys-tarfile "${DEPLOYDIR}/trusted-firmware-a-${TF_A_NAME}_${PV}_${DISTRO_ARCH}.deb" | \
         tar xOf - "./usr/lib/trusted-firmware-a/${TF_A_NAME}/bl1.bin" \
         > "${DEPLOYDIR_FIRMWARE}/firmware.bin"
-    dpkg --fsys-tarfile "${WORKDIR}/trusted-firmware-a-${TF_A_NAME}_${PV}_${DISTRO_ARCH}.deb" | \
+    dpkg --fsys-tarfile "${DEPLOYDIR}/trusted-firmware-a-${TF_A_NAME}_${PV}_${DISTRO_ARCH}.deb" | \
         tar xOf - "./usr/lib/trusted-firmware-a/${TF_A_NAME}/fip.bin" | \
         dd of="${DEPLOYDIR_FIRMWARE}/firmware.bin" seek=64 bs=4096 conv=notrunc
 }
diff --git a/recipes-bsp/u-boot/u-boot-qemu-common.inc b/recipes-bsp/u-boot/u-boot-qemu-common.inc
index b63e878c..18f871b2 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-common.inc
+++ b/recipes-bsp/u-boot/u-boot-qemu-common.inc
@@ -26,7 +26,7 @@ python() {
 }
 
 do_deploy_firmware() {
-    dpkg --fsys-tarfile "${WORKDIR}/u-boot-${MACHINE}_${PV}_${DISTRO_ARCH}.deb" | \
+    dpkg --fsys-tarfile "${DEPLOYDIR}/u-boot-${MACHINE}_${PV}_${DISTRO_ARCH}.deb" | \
         tar xOf - "./usr/lib/u-boot/${MACHINE}/${U_BOOT_BIN}" \
         > "${DEPLOYDIR_FIRMWARE}/firmware.bin"
 }
-- 
2.47.3

