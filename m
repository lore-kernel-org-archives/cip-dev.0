Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28AAC54791
	for <webhook@archiver.kernel.org>; Wed, 13 Mar 2024 09:10:30 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.54])
 by mx.groups.io with SMTP id smtpd.web10.11985.1710321028720463953
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Mar 2024 02:10:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sKt60fc5;
 spf=pass (domain: siemens.com, ip: 40.107.22.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/GuED7kMWyWxsPkWu73vINb2tcMTm8Tkpyq/mD4m2DK/CYe30cs2feRnURf14WBTs8fiSuZlcj2k3yTZ+zFdsc3jeiWJBhTRuXJM9Q5qoJwzitqmg3sBtBd6aiht6+lChMj3EXnBYtPgjPoT7GvF34ZH4umMpac0seQV58Vsy9ztLq5ejafHE9rjlpUjydzl72VY3hBgMaZqiXNJutwyuxa0rN250MZSyuanCCT8BTkGZn829iKFBX8DYCXYqS4lTnAESvNxy1quxx9/KWTvokuCX5yJFhnQB2wLWccZhd4ZhiAYCYXHU+gN1pIyJHp6FiIMGSEDa9ei5F84L006g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHY+FvL/92fyvZ0/JWCRKW9STN+/6szalcIQ8q5ol+Y=;
 b=VvOOBG+/FJHWYQKUU9pQai1FzY0L4meWEkz3MftbD4Vq7LVK7VKzFNUxuIjLqDrEiErzosd0bANKmsERLYWDLDDkabrIHQSzPASHCEsdIMynkpXD9TBcCWFMmbFCJhqcMcIIInkUCMQRJ33kADpkMpCr0Wn66e6h7TR0Ss08bLl4sBAlK2Sd3HX75UCy84xCSba6UMUHfUPE30Pi4XR1+w3UeWB+9o8MXokXvhvYVDJKFgOYL/15MihCfDvnk4C7aotb5IfLuEGpuxOjMIjZ2qdbpe3PKweS+eXGXO80IHn4uoN09qj8BDB5pg2cm+hycK60cDec7XIh+jyoaVDk+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHY+FvL/92fyvZ0/JWCRKW9STN+/6szalcIQ8q5ol+Y=;
 b=sKt60fc59VrJN3mqqqBYHiWafkLvQa6OoB5npY0/zY0wF9NHNkYluZCOMcNOoryzL53lDyOzwHSa+StZG15BV09+UZDafYh/ZNy2hcE22vsAdcUkJB3a9FVoWt0O8hWdvjCm4efldec3zO6Dvj7JA2pfrsi9/Qmy5WZq95WwQ2mFMHVd1LN3sVt+OPOJongWiezVU5syC+sI+FFioSGr8EqoNBWNBJdAoQDdZtF3DhqpPKe9cwtxK0dBApnHZq95W1WSX4jugUPtg6kXckiS+Eo1bMlSe5QdErN6CX9gHBQ5LZCIjP6Elmwby8hF6Ievv8Ik0ofeOYeVwWzSYJFPsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6511.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:405::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.39; Wed, 13 Mar
 2024 09:10:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 09:10:22 +0000
Message-ID: <c772f038-7f72-4b3c-9826-b547b02a753d@siemens.com>
Date: Wed, 13 Mar 2024 10:10:22 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH v2] Update to kas 4.3.1
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0272.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6511:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c998ac-3814-4241-a584-08dc433d69bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	S9TbHQnOWs4FqGhx6gZPxVoocNf5wVgRa1zmG0v1597ynh/lEYOdhnd077CV+AGxjS4CQZkkYZ+v9TFhjcN1yTBLePOPR8vNCBb+/QxxO3J1yDol8Gdt1AzPllX7CjZdhpbvgUkCvLKRrep1oUBVLKAjqaLxMUZcGw7TY4bu+wgxFdsvxnGdtbSevHva57nPGhfE2wlxuXjjvCe4ciVynnOF56Na4HbcIuxXU4PB4d+LuwbdUqXyNznUuUgL3prxIBRxbVqczj9VQ0D/GtglR2FGILxl66oQFpX3Ck/0uIvEx5p++4n7Y5VxCnlpfZKDb37DChPcjlyFbK5XBPNvPRqrE6/Zxs5kSf54thTC4iDHcuqtXaOI/a2H1ivSM+ty4q384c+i2zAy6k9GYEt4Nb1/zVEL1gVJoXtBGCu36uQwbmxi8nddJaI2P/G5/HbvKvQu8yrXUPuC1GSA0vTKo71xkDNlDo51aXCTSEpdlWRR0hBiwcDjKcliDd/TAV7IW9W9t6mORX6RtktoPh8k+Vg0cIlIjzc75fe2PtkxTf7xjRd461I2SkqZWeKTHRyBa+hrqGe+PJH1cMkNj3c9Ne7sbpRb9UmltDtFpk5P73Q=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UkM4eFRwczZ4TDFlZTRrV0VYbk5udkJ6SXpSM3VOMFNrMzl5TVVXYll1VmtQ?=
 =?utf-8?B?K3hqemp5RUszNC9iMGlWTFZSV3ZuT0tuMFMrNUk4Mm15ckRJYjFBekhTaFQ2?=
 =?utf-8?B?UTVvbVdGckRJVStVRTIva2VYczJyUE5Kbll5c055dVU2bmQrSHhSTFdEa055?=
 =?utf-8?B?RWhRTERjcm1tbWxGRkJEQnFwOXRZeTNYMmlNY3FKRDRoWFJHYy9rdGFRWlQ5?=
 =?utf-8?B?TFgrODNkVEIyclVlTGNBbjhqcm9pcCtON0xNRk1RWEUydVJjbmJUQzJyclQ4?=
 =?utf-8?B?T0p5ZDBpZDZZVmh2VlRDc25Deit4VHBBenZQM044UXlnbUQzRWhCMHdnTnIw?=
 =?utf-8?B?R0NLMWRGcjRkNXhtUWFjb3ptUTNwWGZzdUFsMjhhV251Vm9PY2VDamNMdWU2?=
 =?utf-8?B?T2hGclFYVDBDTVE2VzZnSkxpVUpTK2pmMTBiajFGMDNmSTFSY3N1SGJoQVd2?=
 =?utf-8?B?S052ck9QNWZvNWcybzBVcHloNEdVOXdIa1Z1MXJNWlJvUmZ5NkNWVzlpWk1p?=
 =?utf-8?B?RHFkcU9BTEdkVnlMVDg3aTFMVjFVVTE4KzJ2eXNzWjZPa1BJeFplRm42TDRU?=
 =?utf-8?B?TkM3b1dQYS9VMnBQRFhLYVl5OVMxR29sZHFhTE40eWFRU1NaZXFJOU1YcVU0?=
 =?utf-8?B?VG5jL3p5czBVcS9yTEFLSFZ3VllDVjdRcVdrWlAyaUNBSXdvN25ULzV5UDBo?=
 =?utf-8?B?YW5RTXIwSFBJTEV4QnJjVDIyRGlncnE5cVI5RExVRW1kcW5ONVVCcTMwek8y?=
 =?utf-8?B?bm56TWwzOGdsc1lXSnpIajhtc3ZFSHNZZDI5a3A5KzZlT1VvTlIwckdIQi9k?=
 =?utf-8?B?clloNk9DU2FpcSt6MURCVWhJY0txTDhLa0Z0ajJWUUw0eHRaZW5ZR3NqTVNT?=
 =?utf-8?B?dGh1c1pWRXJSRHJsQTc3anVTeXBqVlZrenIzZTI2aGhqSFBuV0g4UXNxSEZh?=
 =?utf-8?B?RnJCYjRKQ0R4MktrOVRJR2NFUHF2bzhnTVlwU0E4U3NZcHdwZnhzcUs1Rmpz?=
 =?utf-8?B?dk54bEpDckVlRVRBd1JaOSs0L1gvQ213enE4eXNkYkRzdW81MzJRVmxHVlVZ?=
 =?utf-8?B?d092SWVsTmhNTkNHWFR6Z1RhNU90dXcyTGE2bDVWTVFROG40VW9DN0ZMZGhM?=
 =?utf-8?B?MEJ3TE1yeTQwbS91VzBySEFJdHh1Z2trcURmd3NacGIxYWRxMjRndzNzZit0?=
 =?utf-8?B?c1JDT20yNnlsa3RISndZQzlLRUdhaDZlUnNNTVFxNktmZ1ZURGEweFYrQmY5?=
 =?utf-8?B?WC9ZN3Y5MzBoOXludUpWZjhid2k5WElFeHI0amM1dGVoYXcxZWFFSFBVVnFU?=
 =?utf-8?B?TkRDRTY4TVF2UHFYRmtnZjJqN2JyUXRMb0dZK1pMaXAwcnRwSG5CWUZzOGlZ?=
 =?utf-8?B?U0J3TTFLWVRoL1NkY05WaWlUSWI2WWZBbHNWaVlvZGFkcTU5Zmt1eTBzcklm?=
 =?utf-8?B?Qk8vVzdXQ1ZBbm1LSmZUZEhtOGhxWTZKemo2TDRha2ZENW5INGgxUXBieW13?=
 =?utf-8?B?YmkwSHIrZldSR212VWUwK08zMFFSS1U2dWdldjlPMDBRcHVFL2dEZFJ4bXJr?=
 =?utf-8?B?aGpMNUE4eVdqVGdVVjdvY09NODVFblY5QXZqTG1zd1JZRkllOEZDOHhzS2V6?=
 =?utf-8?B?S1lLMzlUZVFWeGJqM2JFNitqWG4yeHh2SHVKbUFTUnhHUGExUnV0VWtiV0d1?=
 =?utf-8?B?ckk4b0NxSlpONEl4Q1lEeFhwNVR4QTdJQXErUm0rOXY4cGxjbzh0eDY1aXdG?=
 =?utf-8?B?ZG50a0IweTQwa3hiai8wOHVESzJkZ1l6bWhIc1ZrQUI3R3NaRzc1S0pRV2Vk?=
 =?utf-8?B?b0tDL2JiRkcvRUlaNFdXSzExYXN3YmNvYmVvNFAzSEowcHJJMTltT2xZTGxQ?=
 =?utf-8?B?SGlOOGp5V05VTjBEWEM0Y3ZpNm1lQ2Fva254THE0T0hZLzBUZ3I4SVdoVEVv?=
 =?utf-8?B?RFAweVlYV0JyN3Z4SHNCM2t1OGZ2T0xWRTF6YUhUak5qQ29pZ1RKb2JlTWZx?=
 =?utf-8?B?WVJFV09DSWx6akxjNzh2RklGV3RxS0pGcUh0aUtoWGxyb1J5ajZnaDQxK3ZX?=
 =?utf-8?B?VUFhZ1JTNTFoenNTK1FKcFFHYnJ1WG5DWDJYK2dkUFU2Mncxa3ovSjcxMTIr?=
 =?utf-8?Q?4rRyRuPnG1Y30DmAo3eH1XQCB?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c998ac-3814-4241-a584-08dc433d69bd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 09:10:22.6631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +o2st6DUrCxE/9UwjpBkZ3uMqt7kSw9kZkq7DxCei7VPVV6ZmT1If25GSXY3BXGwvyWq2UYsugYwp7CpKFPWEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6511
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Mar 2024 09:10:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15286

From: Jan Kiszka <jan.kiszka@siemens.com>

Less noise outputs of kas, reproducible build container and more.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml |   2 +-
 kas-container  | 110 +++++++++++++++++++++++++++++++------------------
 2 files changed, 70 insertions(+), 42 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 67e341e1..bd34c823 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -12,7 +12,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-image: ghcr.io/siemens/kas/kas-isar:4.0
+image: ghcr.io/siemens/kas/kas-isar:4.3.1
 
 variables:
   GIT_STRATEGY: clone
diff --git a/kas-container b/kas-container
index 8fa2d16e..af938285 100755
--- a/kas-container
+++ b/kas-container
@@ -29,11 +29,12 @@ set -e
 
 usage()
 {
-	printf "%b" "Usage: $0 [OPTIONS] { build | shell } [KASOPTIONS] [KASFILE]\n"
-	printf "%b" "       $0 [OPTIONS] { checkout | dump } [KASOPTIONS] [KASFILE]\n"
-	printf "%b" "       $0 [OPTIONS] for-all-repos [KASOPTIONS] [KASFILE] COMMAND\n"
-	printf "%b" "       $0 [OPTIONS] { clean | cleansstate | cleanall}\n"
-	printf "%b" "       $0 [OPTIONS] menu [KCONFIG]\n"
+	SELF="${KAS_CONTAINER_SELF_NAME}"
+	printf "%b" "Usage: ${SELF} [OPTIONS] { build | shell } [KASOPTIONS] [KASFILE]\n"
+	printf "%b" "       ${SELF} [OPTIONS] { checkout | dump } [KASOPTIONS] [KASFILE]\n"
+	printf "%b" "       ${SELF} [OPTIONS] for-all-repos [KASOPTIONS] [KASFILE] COMMAND\n"
+	printf "%b" "       ${SELF} [OPTIONS] { clean | cleansstate | cleanall} [KASFILE]\n"
+	printf "%b" "       ${SELF} [OPTIONS] menu [KCONFIG]\n"
 	printf "%b" "\nPositional arguments:\n"
 	printf "%b" "build\t\t\tCheck out repositories and build target.\n"
 	printf "%b" "checkout\t\tCheck out repositories but do not build.\n"
@@ -80,6 +81,15 @@ usage()
 	exit 1
 }
 
+fatal_error(){
+	echo "${KAS_CONTAINER_SELF_NAME}: Error: $*" >&2
+	exit 1
+}
+
+warning(){
+	echo "${KAS_CONTAINER_SELF_NAME}: Warning: $*" >&2
+}
+
 trace()
 {
 	[ -n "${KAS_VERBOSE}" ] && echo "+ $*" >&2
@@ -113,7 +123,6 @@ enable_oe_mode() {
 
 run_clean() {
 	if [ -n "${KAS_ISAR_ARGS}" ]; then
-		set_container_image_var
 		# SC2086: Double quote to prevent globbing and word splitting.
 		# shellcheck disable=2086
 		trace ${KAS_CONTAINER_COMMAND} run -v "${KAS_BUILD_DIR}":/build:rw \
@@ -135,9 +144,10 @@ run_clean() {
 	fi
 }
 
-KAS_IMAGE_VERSION_DEFAULT="4.0"
+KAS_IMAGE_VERSION_DEFAULT="4.3.1"
 KAS_CONTAINER_IMAGE_PATH_DEFAULT="ghcr.io/siemens/kas"
 KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas"
+KAS_CONTAINER_SELF_NAME="$(basename "$0")"
 
 set_container_image_var() {
 	KAS_IMAGE_VERSION="${KAS_IMAGE_VERSION:-${KAS_IMAGE_VERSION_DEFAULT}}"
@@ -168,14 +178,12 @@ if [ -z "${KAS_CONTAINER_ENGINE}" ]; then
 			;;
 		*)
 			# The docker command is an unknown engine
-			echo "$0: docker command found, but unknown engine detected" >&2
-			exit 1
+			fatal_error "docker command found, but unknown engine detected"
 		esac
 	elif command -v podman >/dev/null; then
 		KAS_CONTAINER_ENGINE=podman
 	else
-		echo "$0: no container engine found, need docker or podman" >&2
-		exit 1
+		fatal_error "no container engine found, need docker or podman"
 	fi
 fi
 
@@ -190,8 +198,7 @@ podman)
 	KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} --security-opt label=disable"
 	;;
 *)
-	echo "$0: unknown container engine '${KAS_CONTAINER_ENGINE}'" >&2
-	exit 1
+	fatal_error "unknown container engine '${KAS_CONTAINER_ENGINE}'"
 	;;
 esac
 
@@ -205,8 +212,7 @@ while [ $# -gt 0 ]; do
 	--with-loop-dev)
 		if ! KAS_LOOP_DEV=$(/sbin/losetup -f 2>/dev/null); then
 			if [ "$(id -u)" -eq 0 ]; then
-				echo "Error: loop device not available!"
-				exit 1
+				fatal_error "loop device not available!"
 			fi
 			sudo_command="/sbin/losetup -f"
 			sudo_message="[sudo] enter password to setup loop"
@@ -216,10 +222,9 @@ while [ $# -gt 0 ]; do
 			# shellcheck disable=2086
 			if ! KAS_LOOP_DEV=$(sudo -p "$sudo_message" $sudo_command \
 				2>/dev/null); then
-				echo "Error: loop device setup unsuccessful!"
-				echo "try calling '$sudo_command' with root" \
-					"permissions manually."
-				exit 1
+				fatal_error "loop device setup unsuccessful!" \
+				            "try calling '$sudo_command' with root" \
+				            "permissions manually."
 			fi
 		fi
 		KAS_WITH_LOOP_DEV="--device ${KAS_LOOP_DEV}"
@@ -236,6 +241,9 @@ while [ $# -gt 0 ]; do
 		shift 2
 		;;
 	--ssh-agent)
+		if [ -z "${SSH_AUTH_SOCK}" ]; then
+			fatal_error "no SSH agent running"
+		fi
 		KAS_SSH_AUTH_SOCK=$(readlink -fv "$SSH_AUTH_SOCK")
 		shift 1
 		;;
@@ -274,16 +282,16 @@ while [ $# -gt 0 ]; do
 		shift 2
 		;;
 	--version)
-		echo "$(basename "$0") $KAS_IMAGE_VERSION_DEFAULT"
+		echo "${KAS_CONTAINER_SELF_NAME} $KAS_IMAGE_VERSION_DEFAULT"
 		exit 0
 		;;
 	--*)
 		usage
 		;;
 	clean|cleansstate|cleanall)
-		[ $# -eq 1 ] || usage
-		run_clean "$1"
-		exit 0
+		KAS_CMD=$1
+		shift 1
+		break
 		;;
 	shell)
 		KAS_REPO_MOUNT_OPT_DEFAULT="rw"
@@ -329,8 +337,7 @@ while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
 		shift 2
 		;;
 	-E|--preserve-env)
-		echo "$1 is not supported with kas-container"
-		exit 1
+		fatal_error "$1 is not supported with ${KAS_CONTAINER_SELF_NAME}"
 		;;
 	--)
 		KAS_EXTRA_BITBAKE_ARGS=$#
@@ -345,8 +352,7 @@ while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
 		# shellcheck disable=2086
 		for FILE in $(IFS=':'; echo $1); do
 			if ! KAS_REAL_FILE="$(realpath -qe "$FILE")"; then
-				echo "Error: configuration file '${FILE}' not found"
-				exit 1
+				fatal_error "configuration file '${FILE}' not found"
 			fi
 			if [ -z "${KAS_FILES}" ]; then
 				KAS_FIRST_FILE="${KAS_REAL_FILE}"
@@ -416,15 +422,21 @@ fi
 
 set_container_image_var
 
+# short circuit for clean* commands. We just need
+# the build-system information, but no repo mounts, etc...
+if echo "${KAS_CMD}" | grep -qe "^clean"; then
+	run_clean "${KAS_CMD}"
+	exit 0
+fi
+
 KAS_REPO_MOUNT_OPT="${KAS_REPO_MOUNT_OPT:-${KAS_REPO_MOUNT_OPT_DEFAULT}}"
 
 KAS_FILES="$(echo "${KAS_FILES}" | sed 's|'"${KAS_REPO_DIR}"'/|/repo/|g')"
 
 if [ "$(id -u)" -eq 0 ] && [ "${KAS_ALLOW_ROOT}" != "yes" ] ; then
-	echo "Error: Running as root - may break certain recipes."
-	echo "Better give a regular user docker access. Set" \
-	     "KAS_ALLOW_ROOT=yes to override."
-	exit 1
+	fatal_error "Running as root - may break certain recipes." \
+	            "Better give a regular user docker access. Set" \
+	            "KAS_ALLOW_ROOT=yes to override."
 fi
 
 set -- "$@" -v "${KAS_REPO_DIR}":/repo:${KAS_REPO_MOUNT_OPT} \
@@ -436,16 +448,14 @@ set -- "$@" -v "${KAS_REPO_DIR}":/repo:${KAS_REPO_MOUNT_OPT} \
 
 if [ -n "${KAS_SSH_DIR}" ] ; then
 	if [ ! -d "${KAS_SSH_DIR}" ]; then
-		echo "Passed KAS_SSH_DIR '${KAS_SSH_DIR}' is not a directory"
-		exit 1
+		fatal_error "passed KAS_SSH_DIR '${KAS_SSH_DIR}' is not a directory"
 	fi
 	set -- "$@" -v "$(readlink -fv "${KAS_SSH_DIR}")":/var/kas/userdata/.ssh:ro
 fi
 
 if [ -n "${KAS_SSH_AUTH_SOCK}" ]; then
 	if [ ! -S "${KAS_SSH_AUTH_SOCK}" ]; then
-		echo "Passed SSH_AUTH_SOCK '${KAS_SSH_AUTH_SOCK}' is not a socket"
-		exit 1
+		fatal_error "passed SSH_AUTH_SOCK '${KAS_SSH_AUTH_SOCK}' is not a socket"
 	fi
 	set -- "$@" -v "${KAS_SSH_AUTH_SOCK}":/ssh-agent/ssh-auth-sock \
 		-e SSH_AUTH_SOCK=/ssh-agent/ssh-auth-sock
@@ -453,20 +463,27 @@ fi
 
 if [ -n "${KAS_AWS_DIR}" ] ; then
 	if [ ! -d "${KAS_AWS_DIR}" ]; then
-		echo "Passed KAS_AWS_DIR '${KAS_AWS_DIR}' is not a directory"
-		exit 1
+		fatal_error "passed KAS_AWS_DIR '${KAS_AWS_DIR}' is not a directory"
 	fi
 	set -- "$@" -v "$(readlink -fv "${KAS_AWS_DIR}")":/var/kas/userdata/.aws:ro \
 		-e AWS_CONFIG_FILE="${AWS_CONFIG_FILE:-/var/kas/userdata/.aws/config}" \
 		-e AWS_SHARED_CREDENTIALS_FILE="${AWS_SHARED_CREDENTIALS_FILE:-/var/kas/userdata/.aws/credentials}"
 fi
+if [ -n "${AWS_WEB_IDENTITY_TOKEN_FILE}" ] ; then
+	if [ ! -f "${AWS_WEB_IDENTITY_TOKEN_FILE}" ]; then
+		echo "Passed AWS_WEB_IDENTITY_TOKEN_FILE '${AWS_WEB_IDENTITY_TOKEN_FILE}' is not a directory"
+		exit 1
+	fi
+	set -- "$@" -v "$(readlink -fv "${AWS_WEB_IDENTITY_TOKEN_FILE}")":/var/kas/userdata/.aws/web_identity_token:ro \
+		-e AWS_WEB_IDENTITY_TOKEN_FILE="${AWS_CONFIG_FILE:-/var/kas/userdata/.aws/web_identity_token}" \
+		-e AWS_ROLE_ARN="${AWS_ROLE_ARN}"
+fi
 
 KAS_GIT_CREDENTIAL_HELPER_DEFAULT=""
 
 if [ -n "${KAS_GIT_CREDENTIAL_STORE}" ] ; then
 	if [ ! -f "${KAS_GIT_CREDENTIAL_STORE}" ]; then
-		echo "Passed KAS_GIT_CREDENTIAL_STORE '${KAS_GIT_CREDENTIAL_STORE}' is not a file"
-		exit 1
+		fatal_error "passed KAS_GIT_CREDENTIAL_STORE '${KAS_GIT_CREDENTIAL_STORE}' is not a file"
 	fi
 	KAS_GIT_CREDENTIAL_HELPER_DEFAULT="store --file=/var/kas/userdata/.git-credentials"
 	set -- "$@" -v "$(readlink -fv "${KAS_GIT_CREDENTIAL_STORE}")":/var/kas/userdata/.git-credentials:ro
@@ -483,6 +500,11 @@ if [ -f "${NETRC_FILE}" ]; then
 		-e NETRC_FILE="/var/kas/userdata/.netrc"
 fi
 
+if [ -f "${GITCONFIG_FILE}" ]; then
+	set -- "$@" -v "$(readlink -fv "${GITCONFIG_FILE}")":/var/kas/userdata/.gitconfig:ro \
+		-e GITCONFIG_FILE="/var/kas/userdata/.gitconfig"
+fi
+
 if [ -t 1 ]; then
 	set -- "$@" -t -i
 fi
@@ -500,11 +522,17 @@ if [ -n "${SSTATE_DIR}" ]; then
 		-v "$(readlink -fv "${SSTATE_DIR}")":/sstate:rw \
 		-e SSTATE_DIR=/sstate
 fi
+if [ -n "${SSTATE_MIRRORS}" ]; then
+	if echo "${SSTATE_MIRRORS}" | grep -q "file:///"; then
+		warning "SSTATE_MIRRORS contains a local path." \
+		        "Make sure to make this path available inside the container."
+	fi
+	set -- "$@" -e "SSTATE_MIRRORS=${SSTATE_MIRRORS}"
+fi
 
 if [ -n "${KAS_REPO_REF_DIR}" ]; then
 	if [ ! -d "${KAS_REPO_REF_DIR}" ]; then
-		echo "Passed KAS_REPO_REF_DIR '${KAS_REPO_REF_DIR}' is not a directory"
-		exit 1
+		fatal_error "Passed KAS_REPO_REF_DIR '${KAS_REPO_REF_DIR}' is not a directory"
 	fi
 	set -- "$@" \
 		-v "$(readlink -fv "${KAS_REPO_REF_DIR}")":/repo-ref:rw \
-- 
2.35.3

