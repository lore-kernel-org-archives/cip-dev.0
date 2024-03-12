Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A981FC54E58
	for <webhook@archiver.kernel.org>; Tue, 12 Mar 2024 10:00:27 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.66])
 by mx.groups.io with SMTP id smtpd.web10.5018.1710237622789186475
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Mar 2024 03:00:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=IYvzX976;
 spf=pass (domain: siemens.com, ip: 40.107.6.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVUL2zRGwdDjfIBLlaOvtX/FmfARW5O63aqedStKk9N6hB6l7DHsy1kjfH3Yuvfl9his/yFSxmdEDOpeYqqLBRIiLslvgQXlx2XYLV4bABLQ/hpZU6XSblrjNK71jEBTrnLBmWQGjN5581gTKsa3Sn5K3tmB/kdtnFTghihmT0aSbvmPZ7zWW3nGek7FAoYV9BSPwA9TMERut4eaMAGAuSwyjc+j8SIFWCvTlpQgS3f5hDlE3dcURzLnqipu3EPqN2vGQ7t0WH893g/V+diISw+JGGe1U4ocO+E1vALF19lilt6xVixod4TzeJ0vmw+/GaP8zLw3+ybt0tywWBvsPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7YWZ6HxLiRhoNATQqUZooO6uyOm07EY/dF7r92XqE0=;
 b=m+oHBWdd55md3Mp9SBYxu2+IJFdlnCJX7VuUOdW6rgB79MBhxGPtI7+DWobF6L3Uis4rJEShSn2on+ARIybVzU2V5/mH6rNmNCag9D78c6vFBDYnTRY5H/EZ2PIQYGJI3T1MdTvbtj8UyMcibQrRElyUCXyGoTJeypXSjyKdIC6raYkRqC4FPv/lhAvliOeoWe/2+07Mnfiy+U85ifwxGRIR5iPhSqxl8LnQMZOqLskKL4D0c66Y3fnP1iZm5bzOp5XymFPxH1BFtctdvCxJRy4PvLvarr4eFszFL3u0cRz8vgZsrIeuTKR5ijC5SKzqnWK+zHYQ8I+nurF5l+/oZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7YWZ6HxLiRhoNATQqUZooO6uyOm07EY/dF7r92XqE0=;
 b=IYvzX976+8CDiibvRkHw5yjGdlnILR9wOThjqPMnAEjU7JdBUDHmDU1/gow/uK+/rmt3KRq25S6fdvlQNZcbXw2/JadSFJcHxL7ygnJ9wVi67gtb1SmHHDMW/Vp8FFAz+V29zh6RjgXhMyZ1bjHcKLemtsfBNnIjcmO90eTNVeGRZ/kek/kFuIntaGLTBpoLRGKGngs3R2p1eka6/wRLesi4UwZsqY0bThRP2K/REPfAsPtTVygD62qKW3E9ewTEO2OYsCq2Kq0GmbhvOQO9CMhLAbaQ9fIEXz0QhHa1Jk+cWlZFpabKqFOEIxzW+Wd0vs1ebnw83k7JVa0Nkl5/zA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3585.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:154::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 10:00:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 10:00:19 +0000
Message-ID: <a2ade114-6b49-46d6-a9da-b314b26e0086@siemens.com>
Date: Tue, 12 Mar 2024 11:00:17 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Update to kas 4.3
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3585:EE_
X-MS-Office365-Filtering-Correlation-Id: 565a635e-80ff-4933-c94c-08dc427b3976
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	N15Td4VoOO15l1CnGfn22iokiEsZQouunnmKRWa/fNIOwzAZrzpEhY5O3/bdRdVMQGJ++Zncae/9A7ig7MqYbzzgdoDZUmd4ch7zMTO7kutTZCe8Aqc+lR2GCsBQzUGfdHVwKNDf1xAxdLsewvU4sj4CwsJRsVz0AZlFJUBc3pu0jX+sSGa2iQ7dU5wwfy7Yt+JsoEDLkXwKAkpUFZ9yR5dHHDek4Xmki8hxh+ThU1fHUOEFYVRRyL/PZmBVaHtL4Rzzzpuv07UYtRD64DNEw8sDxH6QWp4odCtT7dd2J8cldwUnwgHLDbbjqY4IsqsNY9V8DOofA3yQ0a9T6VkTmW6nZLHkDNQVHpQ/RKyOdLh+C38Gs5e0S/7gsGPHJf57hcNBYScnCgxHtAMJWOG8v2NkviwXHfkHoub0RuyQzZVrZLfTea2zxtULYPErvTiryyyUzdkxc+SPWYx+Fd/v426DGtMXHB6YadJzgmFMi6bZHGeYhsxa5KuMjYKqXdI5c6wAIZ1Wr92nEnfQ1rHYaVvALsvXC40w5YxPbsctXepL2H1ioQUzP3/JTGL5fvmJagzPwTSHT2d0Uffl4nbcEBo0s3eiVNbIq9QhtHu0/z0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ajBSc25aeGdyTTRMQkh6RWlSTXRGdW9wdS8rYTExcGp2N3dFNnBNQnF1T2hH?=
 =?utf-8?B?bHA4czFwKzVXZmx3QVhmdlhKN0FEaXZKK2ZLTjFxQUpnZ0x3L1ZmQll4aC81?=
 =?utf-8?B?ZDcyNUpWR3MwVUwwWXBoR05NNk9ZMEZDZCtvTW9JcGFDZm5DYzkrSlZlbVZU?=
 =?utf-8?B?NTljZllxMXZZNkFBMjN1bExxc2RkamJjMnJuV282UUVHdUNITUNqUUZ2T2Ur?=
 =?utf-8?B?Q09IZFpIS0FIYnhEc3lsSm83aENHNU4zVDNzY1N6ZFZjeUx1alpzMzJFOTlt?=
 =?utf-8?B?N0JyWnpldTBZNDRta2xPT2dtbDRXMWNPYWhxNDVCaWNGUENDNUIyTGJnUjBV?=
 =?utf-8?B?Qlc2aXpXUHRmY2hWMTBzQ0dzMnkwY21DcGdaNXBlNnN5UlRIU01udk1HMVQ4?=
 =?utf-8?B?L25yZWVvZEVQVWxCU1RGYnA4NjhNVjRyR0lkWXpURTRsM21jYkZ2clZGSSts?=
 =?utf-8?B?QTVwbFNxM3F0L3IyVHRucUduaUZJTU1rNTRDNk0wWlczTTRGcGFJSWd0Zk5V?=
 =?utf-8?B?YWFFM2hacnFRMVJkdUxobXVFRkl1OEdBN3FFd1VDSFBmemIxWXJjUkV0c2x4?=
 =?utf-8?B?c3NuZCtvS1dzbTI0UTRpcTNFZ0RGNEE5UDRQazQ4UEthMGh4SGRheWxaa1VM?=
 =?utf-8?B?Rkl3WjlkVHM2My9zRlZKZ2tUTS9iSWo2ZkkyKzBZcmRNMFc4cndES3p5ZXFz?=
 =?utf-8?B?c21jV2Fya1NoQWZkc2FxQ1NBcFZQN0VyMkl4UTkrOVdiNE03VHczV1RVME8x?=
 =?utf-8?B?V2VGYnp5d0xFNCswQ1VFWjNSbC9sK3pacGNndmR2U2l3VlUzZEhVOEpWcEVI?=
 =?utf-8?B?Y09aNjJCdGtUTjdXM09tRE5pQkk1OW1oVGhtYjFtL2hubTJMcEI0VnR0VGtw?=
 =?utf-8?B?bmpkdEExVWJVRzJOM283dHZsTUtoSS9sRGdvVy9mTnhPOWVrblNUNy9ZL1Bv?=
 =?utf-8?B?NEF0cVI5ZURySVBnbGJSY2kxakRYWVRaKzBOdnF0RW1yb2FZczlwVHNXYzBK?=
 =?utf-8?B?SXNqMUlxUkZJRUxudEYxWWp0dytILzEvUmZJTkdQUXY5VEtJTVVlNUtYMi9K?=
 =?utf-8?B?dUxMTkdFM0Exbjl4aUwweDRnMWxibDFFUytJOTM2blBjT3BicXdVMzJpS1ZP?=
 =?utf-8?B?M1REL1FTdXY1RkFTU3dqVjZvRXJ4U3pFc05iOE5uSjAxZGw5SVdsMzkvcDFo?=
 =?utf-8?B?SFVQTHRLOHZrRVQ3UGdEV1A4ck1GRGRzdVU5YXZsaWhIK2ZKWjEwWUx5N0Zy?=
 =?utf-8?B?cHRqbm01azdDWFIrNnoyQ3NaSE04dWlBb2ttb3d1Y1B3TlNrSWh4RWpPTGRW?=
 =?utf-8?B?ZkRsbmFWWnFIQXhRazI5djVma3AwQStKVHgyVFZKNkJ2NWk0Tk4yVnRtYklH?=
 =?utf-8?B?ZXk4b3FLeCthSjM1QTd0VlhKdFJxaFJnaW8wMm56V0xENXI4VlZlc05zc1Iz?=
 =?utf-8?B?NFl5akljZFF1Z3lQZSszNEJkMEdCbXJ2TXZmbERvRWEyd0d6cExST1ptWUQ2?=
 =?utf-8?B?WjlqbVB5c0hJZUlBbC9XQys1L0VpVlJiNVY3a0hwS0k2RitmbWRiNWt5aHBG?=
 =?utf-8?B?M3gwdEsxVEhPY1JQcHlZRXFzVkxkRlpkTk02Rm03eW1KZFJGVVVMeDFRWTNW?=
 =?utf-8?B?YUh3VUtNV252cG9xOFBUdmVUSlRQZWtNSzdIa1UwaEExSVB4dG82a21CU0VQ?=
 =?utf-8?B?MDFWbUVha0JoZTlZODJyZUQxVmV2amJLY2F2UXN3OE1iT2xDMER6alU0UWdu?=
 =?utf-8?B?dkkzSW5qRzhubjhyc2dIQi9yaWFYZStHdC9vZWRNeHVOQWdIYzJ0Ni9hRnRS?=
 =?utf-8?B?SU1MakZld1dlRnpxUnNJanNNOUtVaUtOTVlmQ295QjRmb3BSMnllVld4UUQx?=
 =?utf-8?B?dTY5eitQOGlBVmM0ZHZ6bi9GTmpUQjlSbEVqU1hmRVpFMVlYL0lNQ1phelcy?=
 =?utf-8?B?T0NGUThsMkJEcTFPY1pYcHJSUkxMSlJBV0xqeFdOdlh1QmN1amJNT2RnMTha?=
 =?utf-8?B?RGJjTXIyekV3VHA3Zy90QXQ4MWhQREdzSWRiYzcvTWRXOUdyTDZwVzVaMk1P?=
 =?utf-8?B?WU4xWUxTODV4OTExb2I0RDY1dlIrK2dkQjdBUWlMaWJKb2tIZHNTUDVTQllF?=
 =?utf-8?B?bEtCZ2RyaUd5WWZaZWZhRXRjMW1PcUlLcDBoTTdHY0txbFJsZ290VDFzdE9i?=
 =?utf-8?B?aWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565a635e-80ff-4933-c94c-08dc427b3976
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 10:00:19.3241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQ5KSjcv04w4u8VItLLmrNSu+OIfAb1mcOwGdRmmYQPutUosYsU1YfIWpbvUFx/LHdYeB/nSdXaQzk5e5tCuYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3585
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Mar 2024 10:00:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15275

From: Jan Kiszka <jan.kiszka@siemens.com>

Less noise outputs of kas, reproducible build container and more.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml |   2 +-
 kas-container  | 110 +++++++++++++++++++++++++++++++------------------
 2 files changed, 70 insertions(+), 42 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 67e341e1..4dae1d80 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -12,7 +12,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-image: ghcr.io/siemens/kas/kas-isar:4.0
+image: ghcr.io/siemens/kas/kas-isar:4.3
 
 variables:
   GIT_STRATEGY: clone
diff --git a/kas-container b/kas-container
index 8fa2d16e..85412383 100755
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
+KAS_IMAGE_VERSION_DEFAULT="4.3"
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

