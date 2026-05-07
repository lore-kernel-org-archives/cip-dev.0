Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B038CD3427
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 09:08:54 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.32])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7650.1778144925810874373
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 May 2026 02:08:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LzgQYQoh;
 spf=pass (domain: siemens.com, ip: 52.101.70.32, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bF0MPGwfIGceENY4JrU5gAN5ZrLsxWPXo3CHDC8za2PEgTD0kzXH9w4fDzVJq9gRA/CDiNRusPHiXzXgGXypi/1nHcNePj5Qcsb+IB1bfyM/tROjK96QcpIkyOntAPn5qMXa/CZj9uGuganRuBkUmMcLN/n+gesdOv0td5HcDRYWTi87YUT6TIJjRdCJwgtx+PQ7pwZYMVyEcQodqap/oWgN+iD4YDNY64v9Xr41ueB1n36I6aO5arehMEmYmD9hcsIhAvo4y8vAq5OGxnc+vMXGZrd+QN8FG3DS1kiyILfdI5Q9qW6YcZCRL533XOfI3XNsggj4eYRjZvJyK2Lljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixV4Xfd6QD+cNHOqOC7CMR4eaFZFC0TQCrL8W2Wr4ME=;
 b=p/G1iSPTU9wiyYWJXNLC5dSgW+t6NNaorr8rGursORPlx3Ez3sHM4X0O9/yK4S5WpYS4eazX4UK3sWE7hyLpjWd55t3zUkenkcoh9yKffUeAk1rQqVKplqZZPo/TVC1ATDtojx0J4rKErRuyjuHznFwuMnZ2ikPD9k64+3DbDfEKQtFJhIRwHZwTJV66vQywe4B+nzj9zCXOJRihs1ePMa7e4bGAu5CjPP4iGwkmu8kelW/w/FPNtPbEfMqurgk2QcqJZ8lteEWpapHEAeoCAGhrx437za7sMvyjafeY6/HGKKXYw5SWwu038/kVFyfXxN1Q1Ou9nu0EeWwGpiPt/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixV4Xfd6QD+cNHOqOC7CMR4eaFZFC0TQCrL8W2Wr4ME=;
 b=LzgQYQohzOMvWLd+TG2db9W22vJRmLx2736krQxnaCqK5tOGMG8YYscgL2Dmpts3k98tBdhbf9KRbmWg8a7tqjUc+cI06NxaR+x1zdF/U/K+88yVL0fNtnPuZscQRuhU8rDBZScoHkq8NmGsekBJtXMlwaFiZN91/YMp+8w63BYiIrwg+TLgmE+l/cWiZkcu46vsbHndveaNtknMiW82UUjzyZDCtYolsJSL8JsAHu9Z5izdraKIMTg9bTRsN1ejZawKI74wRk5bcIHEZ2075ADEqzVak15e4RQfHWMjywtofiwb0+zOeJrb3fO64mTAdrMTOREOGudquhPM7GV03Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5252.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:292::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 09:08:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Thu, 7 May 2026
 09:08:40 +0000
Message-ID: <1f472e98-7716-4a58-9a3e-dacef81056dd@siemens.com>
Date: Thu, 7 May 2026 11:08:39 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] ci: Remove SQUAD support
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Chris Paterson <Chris.Paterson2@renesas.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5252:EE_
X-MS-Office365-Filtering-Correlation-Id: d738993e-9ded-4f9b-c345-08deac183ac6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	eBxOw/yxrL0NgR4EmNItyOtti0ctFaYMLCLVA1ec+6udKFt/fvw3ypYeVIU9T3B3oaQtpp35B3adkqbCD/FRyBqvF1WkA7VV8SSVBO9jA6Y2fpFyCcqQaRcBVaMF5qDUj1RQAw1JMh/Pp8Cwva2ns1VtKQn7wBL6FVVpcPoEbafm25yiLxq5ZXJPhUCgX8i+epTpQvkdT5IO7kFKZqRNzkCOe4Y59T8h6wZ+X51KziCR3qMn419tsOqi5OMVKCBkd5HL3t8jA/sQKGV9QhvT4/T+ibC1U5NdSlPC/VgGyYOvJE1poR/lAKxinr1nOT5hmD9Z9SqQFoSct1f2C/fA/TM/qSIkhLx8uend5yqeJM84iRNIwzr9bZ4UvYLWIejUtVj167i2ERh3m+xzm9oDccdfURno0VtOONV8ZwWVpol8KLjvatDJl4ptp418nvFatBIZ1PO3juGhXRoGBBAg78YIc3R6XbXwyEIpIP0GZDwm6z98OPO7J0UY19Ft3f4i6AXYqj/H7OvouCTWcavlDyVkNcb2BFRdwxW7VuNMsx45Fhu8HuAtVte9Tlbh2pBTg2ybwGAdx1ifTWxnnD8/uzpTxrO5MXAPjUpj/9IcLd8DWhRBrLk0ESUfwlEoVFSrXLn7mSsJZ3F5iSpe2QmIDQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dW0zbmtSTnhSVE42TEtiQVNMYzg4RE9nUGpvZGNJVVN6ekRzQWdoSWVnVlFn?=
 =?utf-8?B?T1ZTdzU5eTdvUGd5bnZKVWdRdHJrOUZNeStGK0QzYkhQWEc4L2pwVkR0YVYv?=
 =?utf-8?B?N2RWNTZSTlhwclJVNnJ5TTdlTm5sK3dGT3JiNGNzWmgzdGJENFY3RG16TEtP?=
 =?utf-8?B?RFhQRG90ZmtEclpzeHloaEZISlh5cjJZNHRZRk5XVjdPcldKb0RiYXRKaTF5?=
 =?utf-8?B?WnM5YlhqWkp2cWR0ZnhaTWoxT3k4c0cyRmlZNmlPUWI4ekgvZFpEaGlUcXkv?=
 =?utf-8?B?V242OWhYbktGeWw1K2dzazRRK2I4Nzhydzk3bkpDQ3NzRnBHNEQwMHFXMmcr?=
 =?utf-8?B?NHZ0SHgrSFVqUm5zSTRSU0hNYkFNSk0xZWFPRXY2N00vTXM4NVpxWEpuTjdN?=
 =?utf-8?B?WG9RWDRKOFFrWDIyZ0tZQjlURWVqT2JycldXUVlVNjNnSEU4YktoVytzNUlw?=
 =?utf-8?B?bzMxOVFjOGtlMlN0b0xVS28zWXhydlpqZHJkb3RRY3dYQ2RZYXNsNGJkZnA4?=
 =?utf-8?B?Z0FxM2VBd2EzNEdUWlpnaCtCUG0zZDZSYUp4ZkxwL3pmakJyVmlySkpsa1dM?=
 =?utf-8?B?SVdCaU9EcjU1WDBHWGJ2cVB2R05YblFMWEUwbHo3cHRia3NINWJnTzloNWgr?=
 =?utf-8?B?T0xvanhrblN3czhxM3g5OVhlcks3WFVWenAreVZVWTJuUWl1NjZuSFBLUkJI?=
 =?utf-8?B?MG43bERiVGZuUkZvcTBGR2Z3RlVzcWN2c1VRSytFZjgvN3ZDTEU0OEoxSkpv?=
 =?utf-8?B?S1hzd2d3YUkzVkRodW0zeC82RERmTFB6cURFQWZBNFcyZVVPNzV5bk93VTJp?=
 =?utf-8?B?bnMrMDdmMUYzWWhiNVJ3RVg0bHpubVRsZVJQcVcrOFpNWE9YVTQ4WExnTkJ5?=
 =?utf-8?B?ekhyUUhJbmJ0Z09jWDFWanRxQ0VXMURhRWlObloxZ3VCcU5zRUhRUlhQR2VL?=
 =?utf-8?B?V1FSVUVXNnFuZjhidW1yNm82b280MVJKOWFZdzRUOUhLUDFxWExRcU9TREhJ?=
 =?utf-8?B?U3huTGVCZ3FpWHIvNzZJVzdPZEZDOWxqUHgrSHBqVk1ldFZUaUM0L1NDY1d6?=
 =?utf-8?B?d2tmV290YTg0Ylh1ejRpWU52T1VnSE1ndmtkaFdvaUt2dzM0R0NNanBMYk4y?=
 =?utf-8?B?UXMrQ05WUTNVcmVWN2lUblhZOFovcE53ZkhqODJHVVNEOUMyK1dDVmhXaHVG?=
 =?utf-8?B?YWZDeVYySlRaYmpXR0pnT0NsSnJpRWFpYXM1M245ZWxqVWxYVGFCdFlQWURv?=
 =?utf-8?B?aDc2M0NRNktidE5zUlRBN3dNU094YmNhQ282SG0rcmE0KzFxanUyOWwvT1RG?=
 =?utf-8?B?bG10ZUY4RlduVXlKWEFsSjFtUkhRNngveDBOTGt1cUVKdVZUK3FUU2dQTlBL?=
 =?utf-8?B?b1pDUGRuWDdwWW9hQlNiSGhCYmVNUm1LN0RhN3VHb3RqRlpCWE82YmkyYXc5?=
 =?utf-8?B?UXZQcWtJS2xxeURUaFdkaHJRaVo3R0VuTGVCOUlTQTE4bEZwYnk4NWdab0RS?=
 =?utf-8?B?dUExMUZKQmhISG1CSCsvdlA4SUJvSkFFc3NScnBUUG1JTGlRc0V5dnhZMUhR?=
 =?utf-8?B?YlN5YXV4VkkrUUpGeWhFWmtFZytKaEdUODFpS3c5ZFAxeVpmdHB2UHpzK25r?=
 =?utf-8?B?TDVmVG5EV203NExJY2ttdUhxTXcyeVFRbktLb3BNUjJGeUpUc2pXbGJWYkdu?=
 =?utf-8?B?R1NBVFZ3cmRkUk5HTFBsZGNjS3BXalc4OGFTbHhTemxzblRLczY5MmphcnZU?=
 =?utf-8?B?RDVNSDEvQ1hEN2thTllCay9sQjlZVTNpanB4dEs1cERaaG1IcE45SnVpbk5n?=
 =?utf-8?B?d2pzS0crci9oSHFyMVFLWm1Xa3NoblZ0OHFrVVZnUlk5Vm5tMWdTM0pRYW1C?=
 =?utf-8?B?c2h6UGUwc1FISjJ4WkxibENTaEVnVUhoOWQ2ODQzMi8zRk5uRldVRDBJQlBT?=
 =?utf-8?B?cVk3R2V2dDZlL1psa3JCMkFUQ1p4OWFQT0FpbVkxRnVqcC9jS0NRWXJmTWRS?=
 =?utf-8?B?UkVQNE0rSG5QVDFXMXBmT2d1YkNCT3FwUnhHUDFnT2MralRwdVVrUThnZDJE?=
 =?utf-8?B?R0EweDBlcFNadENSV3RjVDlsTHJJNzhiR3RzbDhlTVVNMlkzUG9PMHdwMFRy?=
 =?utf-8?B?Z2FEdithcktFaTFOMVhtMk5DbnVQRU02ejhJRG8vVjd0V1B0Z2RJeDFJRVJz?=
 =?utf-8?B?TGdjWm1nZEg4U3E4L1FSdnY5WU5DQVFTN21MNkIrQ3IzZ2YwNEtsK0xUSXVs?=
 =?utf-8?B?ekFadTBKd0NiZUIvZzV0aFBqN3MwVEc0VmNTQWdtL2ZKMzNJa3d6L1A2U2hI?=
 =?utf-8?B?L2d4dXB4VHNudUIzeVFYNnJvc3BkcHBYaC9URi9OQm5yckNSQnlLdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d738993e-9ded-4f9b-c345-08deac183ac6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 09:08:40.0075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6JRHd2veMWmi5ZqFo18bgBM1+u5H5L+vyHkKz4K8b1iQDEjfkpEFjaW7ZEPPzrOiRZFaEVYQtknIbwR+xRzkMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5252
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 May 2026 09:08:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22897

From: Jan Kiszka <jan.kiszka@siemens.com>

This was apparently broken for much longer than we recently noticed -
and no one missed it. Time to retire it.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 doc/README.lava-testing.md                    |  2 +-
 .../linux/linux-cip_6.12.85-cip22.bb          | 14 ++++++
 scripts/submit_lava.sh                        | 47 -------------------
 3 files changed, 15 insertions(+), 48 deletions(-)

diff --git a/doc/README.lava-testing.md b/doc/README.lava-testing.md
index 04da723c..c8c606e7 100644
--- a/doc/README.lava-testing.md
+++ b/doc/README.lava-testing.md
@@ -1,6 +1,6 @@
 # CIP Core functionality testing with LAVA
 
-This document explains how SWUpdate, Secure boot and IEC layer are being tested using LAVA. The tests/templates directory contains functionality based templates which are extended to LAVA job definitions which tests the respective functionality on QEMU amd64, arm64 and arm architectures. CI jobs run until the final health of all the submitted jobs is reported. Test results are also pushed to [CIP SQUAD platform](https://squad.ciplatform.org/cip-core/).
+This document explains how SWUpdate, Secure boot and IEC layer are being tested using LAVA. The tests/templates directory contains functionality based templates which are extended to LAVA job definitions which tests the respective functionality on QEMU amd64, arm64 and arm architectures. CI jobs run until the final health of all the submitted jobs is reported.
 
 ## Templates
 
diff --git a/recipes-kernel/linux/linux-cip_6.12.85-cip22.bb b/recipes-kernel/linux/linux-cip_6.12.85-cip22.bb
index fecdba28..ce8d514f 100644
--- a/recipes-kernel/linux/linux-cip_6.12.85-cip22.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.85-cip22.bb
@@ -8,3 +8,17 @@
 require linux-cip-release.inc
 
 SRC_URI[sha256sum] = "b99c97c032e3516475e90853a3075274cdc64000699fb5425fcff39c3b998b93"
+
+SRC_URI += " \
+    file://0001-ARM-group-is_permission_fault-with-is_translation_fa.patch \
+    file://0002-ARM-allow-__do_kernel_fault-to-report-execution-of-m.patch \
+    file://0003-ARM-fix-hash_name-fault.patch \
+    file://0004-ARM-fix-branch-predictor-hardening.patch \
+    file://0005-ARM-9459-1-Disable-jump-label-on-PREEMPT_RT.patch \
+    file://0006-ARM-ensure-interrupts-are-enabled-in-__do_user_fault.patch \
+    file://0007-ARM-move-vmalloc-lazy-page-table-population.patch \
+    file://0008-ARM-move-is_permission_fault-and-is_translation_faul.patch \
+    file://0009-ARM-use-BIT-and-GENMASK-for-fault-status-register-fi.patch \
+    file://0010-ARM-move-FSR-fault-status-definitions-before-fsr_fs.patch \
+    file://0011-ARM-provide-individual-is_translation_fault-and-is_p.patch \
+    file://0012-ARM-9463-1-Allow-to-enable-RT.patch"
diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index 958a4e98..11f3a5c7 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -14,9 +14,6 @@ LAVA_TEMPLATES="tests/templates"
 LAVA_JOBS_URL="https://${CIP_LAVA_LAB_SERVER:-lava.ciplatform.org}/scheduler/job"
 LAVA_API_URL="https://$CIP_LAVA_LAB_USER:$CIP_LAVA_LAB_TOKEN@${CIP_LAVA_LAB_SERVER:-lava.ciplatform.org}/api/v0.2"
 LAVACLI_ARGS="--uri https://$CIP_LAVA_LAB_USER:$CIP_LAVA_LAB_TOKEN@${CIP_LAVA_LAB_SERVER:-lava.ciplatform.org}/RPC2"
-SQUAD_GROUP="cip-core"
-SQUAD_WATCH_JOBS_URL="${CIP_SQUAD_URL}/api/watchjob"
-SQUAD_LAVA_BACKEND="${CIP_SQUAD_LAVA_BACKEND:-cip}"
 PROJECT_URL="https://s3.eu-central-1.amazonaws.com/download2.cip-project.org/cip-core"
 
 WORK_DIR=$(pwd)
@@ -235,48 +232,6 @@ create_job_mcom () {
 	    -i "${job_dir}/${1}_${2}.yml"
 }
 
-# This method attaches SQUAD watch job to the submitted LAVA job
-# $1: LAVA Job ID
-submit_squad_watch_job(){
-# SQUAD watch job submission
-	local ret
-	if [ -z ${CIP_SQUAD_LAB_TOKEN+x} ]; then
-		echo "SQUAD_LAB_TOKEN not found, omitting SQUAD results reporting!"
-		return 0
-	fi
-
-	if [ "$TEST" = "swupdate" ] || [ "$TEST" = "kernel-panic" ] || [ "$TEST" = "initramfs-crash" ]; then
-		SQUAD_PROJECT="swupdate-testing"
-	elif [ "$TEST" = "secure-boot" ]; then
-		SQUAD_PROJECT="secure-boot-testing"
-	elif [ "$TEST" = "IEC" ]; then
-		SQUAD_PROJECT="iec-layer-testing"
-	else
-		echo "Unable to host results in available CIP Core SQUAD projects"
-		return 1
-	fi
-
-	local ENV="${SQUAD_PROJECT}_${TARGET}"
-	local squad_url="$SQUAD_WATCH_JOBS_URL/${SQUAD_GROUP}/${SQUAD_PROJECT}/${COMMIT_REF}/${ENV}"
-	ret=$(curl --max-time 10 --silent \
-		--header "Authorization: token $CIP_SQUAD_LAB_TOKEN" \
-		--form backend="$SQUAD_LAVA_BACKEND" \
-		--form testjob_id="$1" \
-		--form metadata='{"device": "'"${DEVICE}"'", "CI pipeline": "'"${CI_PIPELINE_URL}"'", "CI job": "'"${CI_JOB_URL}"'"}' \
-		"$squad_url")
-
-	if [[ $ret != [0-9]* ]]
-	then
-		echo "Something went wrong with SQUAD watch job submission. SQUAD returned:"
-		echo "${ret}"
-		echo "SQUAD URL: ${squad_url}"
-		echo "SQUAD Backend: ${SQUAD_LAVA_BACKEND}"
-		echo "LAVA Job Id: $1"
-	else
-		echo "SQUAD watch job submitted successfully as #${ret}."
-	fi
-}
-
 # $1: Job definition file
 submit_job() {
         # First check if respective device is online
@@ -306,8 +261,6 @@ submit_job() {
 				| cut -d ":" -f 2 \
 				| awk '{$1=$1};1')
 
-			submit_squad_watch_job "${ret}"
-
 			# shellcheck disable=2086
 			lavacli $LAVACLI_ARGS jobs logs "${ret}"
 			# shellcheck disable=2086
-- 
2.47.3

