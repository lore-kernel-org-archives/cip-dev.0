Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9586DCD3427
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 10:15:17 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.13])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8407.1778148914457673352
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 May 2026 03:15:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YEroV41X;
 spf=pass (domain: siemens.com, ip: 52.101.70.13, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F84oKHqtTtyQczpClSTs3ZhKVzAId+4THIiOKHqfry+EMgBU0Sin85ojKJNZmaXfXNN+BvuROM+kLSJKx4JoJDMY/igcMQUctEvaP6zuADxyMgGjk1BFHxhwORJLbrvdvg81xVKnxzs1aCe8mMO25L7PBsG6iICtAgqC2E790Sl7eHdJOvrmlZ0dX/MFm45aNYgz08CdU6GEgcyV2ohSf/VdnY6sCR2MYLTRfmvjVGSQGKpuokV82x1uDUJ0hxHMk6F8teNN8a4+2hPE7oBcwfQ7vEh/6qpjMGsSyQvO6VHFMBbPCEDy45113wbe5hSynVuoM20bWqQjX8NnFqnGbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QVqLKr/lSHGnPjsmgS7xefioESt94P44WhQeFRg1fY=;
 b=ChMpcb1YtJxHF1tZXsPmMUM18GjpIEzlFYP19VlOiennqhRKJQSUg8pFZQECzVhJaLKcRImXS0sj6cQulp0pVcOV1aB7A1L2sqkY0826t3rOIKTK1L/RjM4aYn/0qc1L7Pw0dXWUPlmqX1jXPL+G78OwWWSKxLyRwPMB5RF2zfb7fvgBb8NXJe+Lsgl3NB+IGcgwBHDHjEytEYtDheGy9+qrmAmKT/SCqTPz3uphHclBzrcG2P9XkCUz7/nD5JDn6ZjcCBcij/2DF7A+VuGx/3NcvHfsATS5eOXLd2LDpcvTu8Xnamjcaxzma5wa/FAyP6MKu9ePGdkGuSC3zPJTqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QVqLKr/lSHGnPjsmgS7xefioESt94P44WhQeFRg1fY=;
 b=YEroV41XTn1R5KI06vU9T9pPHveNUVEAreDg4NAl66A1N3uRj7uatMIQMQNZTvABWgI2ZKWc4HhDqYuUX+YzVZo4vZCY5UfidXKKEsFH0Ll+XzbE364KBHzAnNdk1AjnppNRzrpZjwRGEkjiO+ak04BS1cgbPy7LxgWiHlX3UGI2LcujWOqyVgF4iXAPPJSA4wXRZ4KI+gtUsECvDSK32LJrDAQ/okiVE1KC2xtGBh/l+WzunxjtfHPLSw12u+POkf8g6odLHc2PCPcr/P0GCDwVt/sCZmcNsrQurRGYipKwJ5raafkA6bLvG2pvlAawVdGmRooZ6XXh98tHu0SrnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB9737.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:651::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 10:15:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Thu, 7 May 2026
 10:15:09 +0000
Message-ID: <25396579-ef9c-49bd-92b6-2a8957b94ace@siemens.com>
Date: Thu, 7 May 2026 12:15:08 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH v2] ci: Remove SQUAD support
Content-Language: en-US
Cc: Chris Paterson <Chris.Paterson2@renesas.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB9737:EE_
X-MS-Office365-Filtering-Correlation-Id: 26948a34-6baf-4f50-55d2-08deac2184af
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	07cSMhhlmXPw/Qrr/j27nlGJI5JWZFJszBSMciiYlFPWmBDm9w6/fAXuJlYiqlKzSc1L3B26GqZp5dxNMqIGyWhclVTZUqNzHLsCGUZ/+0KjTeUu5T7CFQ6FteCrOCF8mzJRCkAyvIqaZAt3D4iIV//HG18ldVjfUOFKZzuP349JWsfRng6IIN8d9izHW+L5nBNJWzanCidJ2LQFtMBLXUnKmsqeokq803hsrh5CIIHXMVh5MQgU8osTGb4vGasBJSmK1uNsLXO8RWEccR40BIzpcdPkMEJqLc+P1qaf8DV1gOiVj3FfIOdqGP6fq74RpLz3Pipvix8qZ8GQ0NPZloIGsvgVWIYgB62qukfAmTjFSTCa4CgJ/Z3H7j/kP9LASZWmgbDt6vA6fSD9N5w6GbNhmG9KhWOwgq+jrZxqjVFHDoF2k+62adcpUKHRV5b0GpldD7k0sqJdA/4se1VmdpVmczqJKTIlnoaWerX1vtoAjaAYS2R1Y5hZlwquH6FTywr9gQhT/ZQln8x0NwPfEalQHOqPfvrMZ6rY4DD81G+5hUDbdq/bXh+l72t0KzwdLpJu0b+HpFQ2b82j9HOTuhei3YXdzuXo0B7CSsIc4VIsGs1l72oYj1ICtkj+TYH/dVMNqpwgVyc+HNzYbfubNg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SGZva3FZQzFVNzh3QndBSWNxTmwwYjdnd05SSE8vcS9pcEU0dDZha2dJMnFq?=
 =?utf-8?B?c0lydS9Qb3BWZ284dmxrZ1ljUXlRQ2dYNjNmdVAzMGNDL1gxQ3NlYmhoelVB?=
 =?utf-8?B?WmdpUkt5MWkxcUNMYTV1SnNBUkp5MWRRay9HRjdWa0xCQlpSSjE0aFZZMTBh?=
 =?utf-8?B?em1wZ1R1dStRS0lJNlRpV3VvbU1BRTh0bElReHFuN3pvQm1ReGpOTlFCSWF6?=
 =?utf-8?B?OU5lK2xoTHlOaEJKS3VWU3lRUkpJc0FlajlHQ2RZZVNFL0NmMFc5RGoyU01z?=
 =?utf-8?B?dEhsREFHeWJHZ0FZSmdGVnFiSHdUTlpMdHRBZmJzdnhUbjIwMVVqb3RWUUhP?=
 =?utf-8?B?K0VjUDg3N2Z1UUlXL3JpUFkwdW5yVGhrN083QWhnZlhPb0l5eDlKQmZob2I2?=
 =?utf-8?B?ZjdsSTlnR1k2UHpueVpqZGhmUnkwNk9pWXp1ek45K09Hemd3ekdRSUhxTXhk?=
 =?utf-8?B?bzJmQklaSUtsRTlQZ29NWW10ZzRtN3lZZUZLL2ExaGkrcURNaUllK0lyY0pE?=
 =?utf-8?B?ZnBxN0ZKMkpMMHhFOFRkZEJ0cG9ETGxDOUJvbzYzUHBEaXlRYVUyRXQvT3ls?=
 =?utf-8?B?dnJJdHBzSzdLUGFCOTBiN1lxOHFYeWVXdHRlZW1taURydTFqcFE5Qk5MMFp6?=
 =?utf-8?B?N0JmeUZCQ3hGN1ppQ1ZNTkJ5MzdzalhkRTlCdG1abXlzcTVrOUtLYWhtWms2?=
 =?utf-8?B?SFJlUjl1SWl4QUdCN2RvNjBmb1ZtbGdOZDdrL3VaMFp5TjA5Q0tTZEY5ZVdF?=
 =?utf-8?B?UHhuS0Y3emdQUXZNRHJXdDBhaDE0MThaTXl5SFNoYWtERDdoNGFwNkpWRkhQ?=
 =?utf-8?B?aVJpb0Nmd3pjS0xnOGVmUXRGOEI5em5CMFJlRmpIUEl2czRJcC85SXlhK3Z1?=
 =?utf-8?B?aEtEdHZtSEgrVzA1TVBuUDhmaHl6bUE5dVh6SnlBbHVIbDFKSnRISzkzbmRS?=
 =?utf-8?B?OFpyUmVWYXBRTkV1WStGbkhENzZPcHVLQVdXWEhpYU41VnR1cFB0aGEvNTdB?=
 =?utf-8?B?SVV1aWlobEdZOVovcUIzT0lnZnFIbG1RZ0xQRXEreS9yTU9DZDVVak9jL0w1?=
 =?utf-8?B?YURaZU1qb0VteTBZd1VYSjNpZ3VJM0V1TlB6eTlxT3JaNVVHd2JIZERJM0Vk?=
 =?utf-8?B?R0FYalRYQTVBMHV0ZVVKdFRtVjJXOU95Vnk4ZXp4NW0rbURmSS9BVFUyejRO?=
 =?utf-8?B?cEVmWkZpNWx2VEJ3ZEp6QTNkelN1c0NpN1Y3UVNLei8vTDR5ZlFPSXg0ZXRD?=
 =?utf-8?B?cmFadkE5T2lQUk1RQTVKbzdHV3RvRVUyb1hycnhUMzFOeEZadmdUYXdJVFdy?=
 =?utf-8?B?YjArU0ZmMHRYSzRiOGkvRW5qa203eWNvRG90NlZQUk9TZzJtZGpFUjBnYmc0?=
 =?utf-8?B?eDBRVUNtb0RMZzNTTGI1U2pEUDFSamEwazlTaDRXMG1La3JNYS9ncElhZ1RL?=
 =?utf-8?B?OGtJZEwrdDVXMU5lNmxSR0M0b011bVRlOW1aRXFyZkdJNjB4dVBTRi9Mc2hF?=
 =?utf-8?B?VzBJemtsRUlBRGNSME1JUFgvcVRqdmdoWGo3cngydkQ1dUVYR3hYMmVFL29n?=
 =?utf-8?B?azhBcXlWVG9vWFliMWNnd3F6d2ZJZFBZNEx2RGdseDdET0Z2aTBNbHV6WWRz?=
 =?utf-8?B?YThUOHVmSjFTR1lSMzlBaHVudHRTUWVPQ1BoSEVFTmlFZ1hJWnBjRG5mOXdV?=
 =?utf-8?B?NnJYZW1ERjBWL2h4bXlZRXgvRWpWcDE5enYvV1FOZkFGK0VRYkxwTHhxUXlO?=
 =?utf-8?B?UVpPVnNIOEsyNUdMYVV3R21JajRuakVkbVN0VDFJMyt3WjM2bDE0dE5laUZ2?=
 =?utf-8?B?NmNuWVNIajhISnRrOWpDV3ZZZE12Z2psQ1VIeUJKUmdqaVFORjBDMzl1clQv?=
 =?utf-8?B?MlpoWFUyc3ZDNGtreFNINThPZWVmTms5YkZCUG91akM5eDZ2VGFhb2JmT3pz?=
 =?utf-8?B?eGdURHM0eDVTY21PbHJtTStzbXk4bzlmclFKallJdXZwV3p3WGVxSjhTZVcr?=
 =?utf-8?B?RC9YUUJ2ZXZHalh1dXY3djNoenpXVmwrakFxSzM1TFJhNkhrZk8vVjNqOXFs?=
 =?utf-8?B?SlgvOWl5azlRc3J1UTV5R1hUaUpYM1JvYlZyb3RxV3FYc3JYNUpZZkRPSEZC?=
 =?utf-8?B?VkxEaUpFK2Y1NzJqL1I4T1hZMHA5T1VLM2RHZ0pyU1E2ZzlsNGtkQU5XSGFC?=
 =?utf-8?B?VGlDVjJEVFlybk9iVXg2Y0plQlY0aDlBQmFadnBVd3VNRVcxSE9JK0hieG9P?=
 =?utf-8?B?M1d6UXVmYjQ2MzhhRy9Xd2grQ3lydEVGSVZGTXAxdkF2enhWOTdRY2sydDhp?=
 =?utf-8?B?NWRYRHBnVVZGWU1uaWZSWlRQU1lmQWR6NXE2b1F1bFRrMkFvNGZkdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26948a34-6baf-4f50-55d2-08deac2184af
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 10:15:09.5741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZ9sYcsQlgjqUuwyO8uVbBnVmgLiqaxOzsdCVF/nwtS9Uaeo9ReKuCwpBqGXf9zHK/shhhE+hAHLW0BWaiHgiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB9737
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 May 2026 10:15:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22900

From: Jan Kiszka <jan.kiszka@siemens.com>

This was apparently broken for much longer than we recently noticed -
and no one missed it. Time to retire it.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - remove unintended changes to kernel recipe

 doc/README.lava-testing.md |  2 +-
 scripts/submit_lava.sh     | 47 --------------------------------------
 2 files changed, 1 insertion(+), 48 deletions(-)

diff --git a/doc/README.lava-testing.md b/doc/README.lava-testing.md
index 04da723c..c8c606e7 100644
--- a/doc/README.lava-testing.md
+++ b/doc/README.lava-testing.md
@@ -1,6 +1,6 @@
 # CIP Core functionality testing with LAVA
 
-This document explains how SWUpdate, Secure boot and IEC layer are being tested using LAVA. The tests/templates directory contains functionality based templates which are extended to LAVA job definitions which tests the respective functionality on QEMU amd64, arm64 and arm architectures. CI jobs run until the final health of all the submitted jobs is reported. Test results are also pushed to [CIP SQUAD platform](https://squad.ciplatform.org/cip-core/).
+This document explains how SWUpdate, Secure boot and IEC layer are being tested using LAVA. The tests/templates directory contains functionality based templates which are extended to LAVA job definitions which tests the respective functionality on QEMU amd64, arm64 and arm architectures. CI jobs run until the final health of all the submitted jobs is reported.
 
 ## Templates
 
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

