Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010ACC04A6A
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 14:09:54 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.49])
 by mx.groups.io with SMTP id smtpd.web11.108253.1692022187065555669
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Aug 2023 07:09:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Z8d6zOMn;
 spf=pass (domain: siemens.com, ip: 40.107.20.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYaBLlTSmU09Oi417LmsRxDv1BwSj1NTyp85z8akXynxCo4GaOOgGT8Kc5aj3KVDBl5Y1WT0TQb79YGJuFidCkiT0ALGASo3hcfWb3PT6jc0/RPAyF8wkDEPHP1FNSRW74/T6DCZ3SQoYNvoQy7C0PlE94VpFeTLYz7skPkjg3YLUEvAUaZ6lr2iByATD54CZsUWcbeGOZFoHEkHehgEahwrLRPTDWp8TZY7C1Vz1DGvxmvpfJMeBNl7wMA1hoeba0A5lWsz5rXZij05g5TXo9ZEu3w7NlK70OOAuuSWcDKZ+cpU9yBvRrOvH9O/FZjknODtrjHl5Mvv/yGKcV8AfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyGtb8kiD/60TgCutQJauU1mfsvUG4a+OgeJvqLE01Q=;
 b=hJ9qgeHilsyDIXGy/0A6AhTdPp6i+MiaNu5pP+rmFSqMtsAUSxB+cU/DG216jU2BMFxRId0TlmsCPUvO+nHsiYMPDcuXFfxfKqdvWYW1e5REERg0wAT/0j8JsT444u7eq+P7l21+Y1tZKUE/g1P5HP0TKK27t2FtzMP857ottBqF6c+JJRNZC5KzTv4+ZKEN66rzZdvUhsxRtweRtO894+UHRUPZzJD+1UEPHMKWeKVnf40vPDDRcFbRIBv35F+E8R1wqbn5Qaz5XjbWOPdqNncGsrEE1iaZjkyjCeXIW2OxaVUIlE0zrayF7X3oyREpyCo/9u113WO79ylArkXwYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyGtb8kiD/60TgCutQJauU1mfsvUG4a+OgeJvqLE01Q=;
 b=Z8d6zOMnKt3X7DmiexgZkSk9bgcKKqRe/F1Bkj/xlHCSVMNObLJYp2QDRqTMhGYVX9Eat5o3Ru+t49GToL6pL1vSFf0A2uQRxFigJe52ssWvjbP1fLrkuH3sdYgs3Z+jrYmZe83UUVu08XKNQbx/s2gg5m3emr2VvTd9llT9yhi24xXyJM1Dewde8y+DqFf2w7LhCTneS4wxkhjKN8vXOH2bJPlp+yUr2bWoYua9qE8vHAtgbEoj0GwpdcSkFdMWThmDODZUcC5K+96OKRr5PU1AXtEiUT66fpNOU1Gw5+bhrv6+yDXMa3Ya06njqXOIKstxR69YyRW3cHIAq979iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3121.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 14:09:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 14:09:44 +0000
Message-ID: <ff885bba-3eb9-482f-9689-4679c23391bb@siemens.com>
Date: Mon, 14 Aug 2023 16:09:41 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] Update to kas 4.0
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0227.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3121:EE_
X-MS-Office365-Filtering-Correlation-Id: 4915da74-4a51-46e5-8c60-08db9cd01ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	q/cKqIbAUfLP6120uqu+zrXjy7j8oQfHKq050ya4XvF57d69geU7hxf3AzpuHe3GWKrz22BmlOv55n3LQjPMvO68mWKb6mXauCZF5OkIN04ma+yofNHZDpOVP81pOB4tSygtDzBs+CQvFY1BJupJ9L8+1HY3mcBM4se+CiYABPAhsxVCTZvENrixlaAVBKAOWUdOeSTkoiD4ycPCV4Pd66d6PkEv/9wmsSIAmnwEOcvHhjlJLFGhuP5/FjBPm3CvRJlIc3yyl5CnW37jIi/AzlHhq/n3H3SebdJOQmH2JqWJsj9fG2h4w46cP38VVw78juExhqs1SaqQ7p9LH0LL7oJTS08PsdrKDtwji08ohNmqpiBX31kpp4rRK/JfgBTarkVnsOyQNRdcwCdFmQ2Ry08mbIuFqc+WxmPtWh9XmhU6S2JmqLyHOtts0CifwqHA/jE6v6rp/A9MSnyYDEzR58p01h00wMhnSxEz5ak7tVk5VlkXAbirb+cakRr/fdIIeVuaLITbwhXNH4ey5+9DBYgXl1WaCF5gfxURTuheCjJmLbGaa7uLN0G7WB7LkXhpn8I8L5gK7sK7gDC6uJKLDrcnqfyVmXUc/U64W7GMC2WE1/RXKzFxDk9GaBJyzgPBxBY1XSaZXDT5mW4AeX37Og==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(136003)(39860400002)(376002)(1800799006)(186006)(451199021)(82960400001)(38100700002)(36756003)(86362001)(31696002)(6512007)(6506007)(6486002)(6666004)(478600001)(44832011)(966005)(2906002)(31686004)(2616005)(26005)(83380400001)(316002)(41300700001)(66946007)(66556008)(66476007)(6916009)(5660300002)(8676002)(8936002)(84970400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T3cwWk9wT1JNeTBFaG11R2dYeFJpYXBFbXVBaitQemQ5ZGZRVWFEbER0VGFw?=
 =?utf-8?B?TGltRGx5d3pSakEveFpJOWY2M3liOTJTMjZjVVFUWlc5ZDRLMktPcXNPYUx1?=
 =?utf-8?B?eWVkSGtiZ053S0lDNGwxMDYxaUNWUWEzbm15U0R2NHVvbEhMcUNSK0d2czI1?=
 =?utf-8?B?eFVuV05YWVp6ak91bVpXWjVweXpmOGpMOTl0Lzc4ZEpwb0daZ05yWmRKZ1p5?=
 =?utf-8?B?WUEzeGhqNFVMTDFEZ0tnajQvZFQ2MkZiTGtJY0N2SVYvdCtaYWsya0dBYTl5?=
 =?utf-8?B?ektFWk1JZE5PYmpPYXRndTF3ZUF5anpyYzQ4L2xvUnJNaG5KQXZ4b0lQckpS?=
 =?utf-8?B?VGJrLytuQmZHVVB0WVJzTy81cmFDU2Z2bW5SNFhwbjA5MExKSEhvVTdJU0hy?=
 =?utf-8?B?MjNkR3hjNFRodTh3Y05JbGNYRFNZcFJxTExYK0pPRTZOSjRxY1J4bVh6cDZV?=
 =?utf-8?B?ZWRtMlMrMVRWaEFna0ZLUnY5aGxTcG9BZVVZL0pRNGc2NGttRThuSXpOTWxX?=
 =?utf-8?B?aDM3TS9HQi82VzdPdzZuOE1SM1VoRlRpdXBxdnJPeWtHTGZpcVpSTXNEV3NU?=
 =?utf-8?B?M3Ewenhpdk9BemJCSXVRRVU0U29YbnFPS3lqS0hQMDlZVHZFS2NpT1VMWW9K?=
 =?utf-8?B?dDh1K1NtN3FxOUhTRVNSRGoxamlmOGQ4WGt6SkhwUUhPdkU3eXlDeDVQTGxL?=
 =?utf-8?B?K0ZhT2NIM3dhQUJ0N0gwaGtJdVFnU0Z4UG5Vd043bitTUWtxSlVzMGZFMGk5?=
 =?utf-8?B?MnRmV2VackxvWTlOSkRFcXZZTFhnM3ZSdnY0NUx0c0s5bXM1dVpob0wwaTla?=
 =?utf-8?B?Q3JiZkVCSUs1dHFBdDJjZUh6UXZTekNyNE4zc1FQV3AvLzNqQWhaR2NFQXN4?=
 =?utf-8?B?OGFQSittOHN2dTdYYVpEZ2E1SXZuTmtlOU1UcW42RCtoQVVBMjNETVZldnR3?=
 =?utf-8?B?VjF2M1FrSDB3bjU0WDdNdXBjdFd6SGVQRjFnMWJMeDdoejRvVWg3c2dkNFQ1?=
 =?utf-8?B?VVdrcUY4WkxxWmZCc0w1SFlDd3FtNHpBWm0vWnFQVW90bnVDSEg2a0RpbkVJ?=
 =?utf-8?B?L2wwTGp0WXRDY1U5YWQwc3dYUmpBeGsvb0FlM3U3VjNlNUNJWll0akNCMkNS?=
 =?utf-8?B?UlNpNmlTdTJYaFRxbCtuMUdKOStBajJxbXEzTXZtMFpCMFFxa2UxYmMwRDFT?=
 =?utf-8?B?T1lQYzliMzBJT3RzeU8wRVlITDBKeFZPVDhnYjZmVUk1U3lUelpjTlVmQ0FN?=
 =?utf-8?B?OWphSUdYY2sveE9LZkRtNWJlNjhJSFVqcVlaSkIvUUp5Wkh3dCtXT1l1Ujhh?=
 =?utf-8?B?SW1hTFlkZURYU3RhcG9MWjZDRFcxeW4vd3pLVlhmNG1EeEx2WWZuNTNtQlRB?=
 =?utf-8?B?SmRVSWlmeWhoMGxkMURWZWZvT2p5SUxZODdDZ0luTjRiUGoxVWErNUwzNTVx?=
 =?utf-8?B?M0JZL1dacGJzMTZwa3d0VWZ4UGpmVjNYT0YvZEdlLzRyL3p4Z2FqdmJ0dEVC?=
 =?utf-8?B?dWs2WlhDUHl4c010TW5maFlvaFNWVWxBditFZ1dvZi9ma0cxSVJoeDhvNDJl?=
 =?utf-8?B?cHJteFJoS1FxdWJVNFVlcm5YTUM4ZUJSbGs4VUQ3T2NoSE1kU3dZVTBkT3hT?=
 =?utf-8?B?SXBpd2N0NU9xc09qVXRGTHZUbHh5bHNVbllPNngyTnpkUnEvMUNJdWlmWXcz?=
 =?utf-8?B?NW9CNWpVbFd0QXVBV3J3MitHTlQwdURSbzVyaEd2Z01XMCthVVlrZzlGS1Vu?=
 =?utf-8?B?eGMxSXVoOFpvOE90ejhUY014UHplYXJ4cWJqeGZ0SUlQSmE0dlIrR2dTaGFH?=
 =?utf-8?B?RVJLQTBxUElpN2xrcG8yankwNVYvakVsWFlpZVdKVW1oRUdkTjUwaERZQmtY?=
 =?utf-8?B?d3RwbGVHb0xNOERSbnVXeUFXVzZhbWJ0K2gwdjcydExKeXNUNm9OcFZJVTdq?=
 =?utf-8?B?S3hLL2NlNXRsSVozeFlPS1RBcWtqN1RtbTc4dERyeGR3RDI4bTBmU3BvMlBN?=
 =?utf-8?B?MzM4K2x3L2VrcnVLSi9HZ2gxNkx1dUt5ZVRjSlBsZUR2L294LzdtNmllRk55?=
 =?utf-8?B?anZETG1qM0lxUk5mYmNNMlI3ZWVJYTk0Yitab0t0R0ljelhla1cwOUpwOGp6?=
 =?utf-8?B?a1kwTEgzNTBQamNQejg5NWY0V1hHRVVUbURsRFFaMTdQSm5mcVpiQ0lLZEo0?=
 =?utf-8?B?N0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4915da74-4a51-46e5-8c60-08db9cd01ba6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:09:44.1391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+tmK/oSnWmW1Kd5wfRMg4H5lRVdXR877GnH19bap8vLMAfPMu692VCBymMy7wsMSVumh/LunO9M7hFsNQCrew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3121
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 14:09:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12653

From: Jan Kiszka <jan.kiszka@siemens.com>

Switch from old 'refspec' to 'commit' in the kas file as this chance.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml |  2 +-
 kas-cip.yml    |  2 +-
 kas-container  | 75 ++++++++++++++++++++++++++++++++++----------------
 3 files changed, 54 insertions(+), 25 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 892ba92f..8ccd6171 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -12,7 +12,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-image: ghcr.io/siemens/kas/kas-isar:3.2.3
+image: ghcr.io/siemens/kas/kas-isar:4.0
 
 variables:
   GIT_STRATEGY: clone
diff --git a/kas-cip.yml b/kas-cip.yml
index ffaf04a9..c213439a 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: 478f3c324f50eca0d082cd1c8f23ef50e28071fb
+    commit: 478f3c324f50eca0d082cd1c8f23ef50e28071fb
     layers:
       meta:
 
diff --git a/kas-container b/kas-container
index 123198c3..8fa2d16e 100755
--- a/kas-container
+++ b/kas-container
@@ -57,7 +57,8 @@ usage()
 	printf "%b" "--runtime-args\t\tAdditional arguments to pass to the " \
 			"container runtime\n"
 	printf "%b" "\t\t\tfor running the build.\n"
-	printf "%b" "-d\t\t\tPrint debug output.\n"
+	printf "%b" "-d\t\t\tPrint debug output (deprecated, use -l debug).\n"
+	printf "%b" "-l, --log-level\t\tSet log level (default=info).\n"
 	printf "%b" "-v\t\t\tSame as -d (deprecated).\n"
 	printf "%b" "--version\t\tprint program version.\n"
 	printf "%b" "--ssh-dir\t\tDirectory containing SSH configurations.\n"
@@ -120,7 +121,7 @@ run_clean() {
 				${KAS_CONTAINER_IMAGE} \
 				sudo rm -rf tmp
 	else
-		trace rm -rf "${KAS_BUILD_DIR}/tmp"
+		trace rm -rf "${KAS_BUILD_DIR}"/tmp*
 	fi
 
 	if [ "$1" != "clean" ]; then
@@ -134,7 +135,7 @@ run_clean() {
 	fi
 }
 
-KAS_IMAGE_VERSION_DEFAULT="3.2.3"
+KAS_IMAGE_VERSION_DEFAULT="4.0"
 KAS_CONTAINER_IMAGE_PATH_DEFAULT="ghcr.io/siemens/kas"
 KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas"
 
@@ -146,10 +147,10 @@ set_container_image_var() {
 	KAS_CONTAINER_IMAGE="${KAS_CONTAINER_IMAGE:-${KAS_CONTAINER_IMAGE_DEFAULT}}"
 }
 
-KAS_WORK_DIR=$(readlink -f "${KAS_WORK_DIR:-$(pwd)}")
+KAS_WORK_DIR=$(readlink -fv "${KAS_WORK_DIR:-$(pwd)}")
 # KAS_WORK_DIR needs to exist for the subsequent code
 trace mkdir -p "${KAS_WORK_DIR}"
-KAS_BUILD_DIR=$(readlink -f "${KAS_BUILD_DIR:-${KAS_WORK_DIR}/build}")
+KAS_BUILD_DIR=$(readlink -fv "${KAS_BUILD_DIR:-${KAS_WORK_DIR}/build}")
 trace mkdir -p "${KAS_BUILD_DIR}"
 
 KAS_CONTAINER_ENGINE="${KAS_CONTAINER_ENGINE:-${KAS_DOCKER_ENGINE}}"
@@ -235,7 +236,7 @@ while [ $# -gt 0 ]; do
 		shift 2
 		;;
 	--ssh-agent)
-		KAS_SSH_AUTH_SOCK=$(readlink -f "$SSH_AUTH_SOCK")
+		KAS_SSH_AUTH_SOCK=$(readlink -fv "$SSH_AUTH_SOCK")
 		shift 1
 		;;
 	--aws-dir)
@@ -265,6 +266,13 @@ while [ $# -gt 0 ]; do
 		KAS_OPTIONS_DIRECT="${KAS_OPTIONS_DIRECT} -d"
 		shift 1
 		;;
+	-l | --log-level)
+		if [ "$2" = "debug" ]; then
+			KAS_VERBOSE=1
+		fi
+		KAS_OPTIONS_DIRECT="${KAS_OPTIONS_DIRECT} -l $2"
+		shift 2
+		;;
 	--version)
 		echo "$(basename "$0") $KAS_IMAGE_VERSION_DEFAULT"
 		exit 0
@@ -283,12 +291,22 @@ while [ $# -gt 0 ]; do
 		shift 1
 		break
 		;;
-	build|checkout|dump|for-all-repos|menu)
+	build|checkout|for-all-repos|menu)
 		KAS_REPO_MOUNT_OPT_DEFAULT="ro"
 		KAS_CMD=$1
 		shift 1
 		break
 		;;
+	dump)
+		if printf '%s\0' "$@" | grep -xqz -- '--inplace\|-i'; then
+			KAS_REPO_MOUNT_OPT_DEFAULT="rw"
+		else
+			KAS_REPO_MOUNT_OPT_DEFAULT="ro"
+		fi
+		KAS_CMD=$1
+		shift 1
+		break
+		;;
 	*)
 		usage
 		;;
@@ -302,13 +320,6 @@ KAS_EXTRA_BITBAKE_ARGS=0
 # parse kas sub-command options
 while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
 	case "$1" in
-	-h|--help)
-		set_container_image_var
-		# SC2086: Double quote to prevent globbing and word splitting.
-		# shellcheck disable=2086
-		trace ${KAS_CONTAINER_COMMAND} run ${KAS_CONTAINER_IMAGE} ${KAS_CMD} --help
-		exit 0
-		;;
 	--skip|--target|--task)
 		KAS_OPTIONS="${KAS_OPTIONS} $1 $2"
 		shift 2
@@ -362,11 +373,28 @@ else
 	KAS_REPO_DIR=$(pwd)
 fi
 
+SOURCE_DIR_HOST=$(
+	grep -e "^_source_dir_host: " "${KAS_WORK_DIR}/.config.yaml" 2>/dev/null | \
+	sed 's/_source_dir_host:[ ]\+//')
+if [ -n "${SOURCE_DIR_HOST}" ]; then
+	KAS_REPO_DIR="${SOURCE_DIR_HOST}"
+fi
+
 if [ "${KAS_CMD}" = "menu" ]; then
 	if [ -z "${KAS_FIRST_FILE}" ]; then
 		KAS_FIRST_FILE="Kconfig"
 	fi
 
+	# When using the menu plugin, we need to track the KAS_REPO_DIR outside
+	# of the container to later allow a simple `kas-container build`. For
+	# that, we tell the kas menu plugin via an env-var about the location
+	# on the host. This data is then added to the .config.yaml where it can
+	# be evaluated by the next invocation of kas-container.
+
+	if ! [ "$(realpath -qe "${KAS_REPO_DIR}")" = "$(realpath -qe "${KAS_WORK_DIR}")" ]; then
+		set -- "$@" -e _KAS_REPO_DIR_HOST="$(readlink -fv "${KAS_REPO_DIR}")"
+	fi
+
 	BUILD_SYSTEM=$(tr '\n' '\f' 2>/dev/null < ${KAS_FIRST_FILE} | \
 		sed -e 's/\(.*\fconfig KAS_BUILD_SYSTEM\f\(.*\)\|.*\)/\2/' \
 		    -e 's/\f\([[:alpha:]].*\|$\)//' \
@@ -382,7 +410,7 @@ fi
 
 if [ "${BUILD_SYSTEM}" = "isar" ]; then
 	enable_isar_mode
-else
+elif [ -z "${ISAR_MODE}" ]; then
 	enable_oe_mode
 fi
 
@@ -411,7 +439,7 @@ if [ -n "${KAS_SSH_DIR}" ] ; then
 		echo "Passed KAS_SSH_DIR '${KAS_SSH_DIR}' is not a directory"
 		exit 1
 	fi
-	set -- "$@" -v "$(readlink -f "${KAS_SSH_DIR}")":/var/kas/userdata/.ssh:ro
+	set -- "$@" -v "$(readlink -fv "${KAS_SSH_DIR}")":/var/kas/userdata/.ssh:ro
 fi
 
 if [ -n "${KAS_SSH_AUTH_SOCK}" ]; then
@@ -428,7 +456,7 @@ if [ -n "${KAS_AWS_DIR}" ] ; then
 		echo "Passed KAS_AWS_DIR '${KAS_AWS_DIR}' is not a directory"
 		exit 1
 	fi
-	set -- "$@" -v "$(readlink -f "${KAS_AWS_DIR}")":/var/kas/userdata/.aws:ro \
+	set -- "$@" -v "$(readlink -fv "${KAS_AWS_DIR}")":/var/kas/userdata/.aws:ro \
 		-e AWS_CONFIG_FILE="${AWS_CONFIG_FILE:-/var/kas/userdata/.aws/config}" \
 		-e AWS_SHARED_CREDENTIALS_FILE="${AWS_SHARED_CREDENTIALS_FILE:-/var/kas/userdata/.aws/credentials}"
 fi
@@ -441,7 +469,7 @@ if [ -n "${KAS_GIT_CREDENTIAL_STORE}" ] ; then
 		exit 1
 	fi
 	KAS_GIT_CREDENTIAL_HELPER_DEFAULT="store --file=/var/kas/userdata/.git-credentials"
-	set -- "$@" -v "$(readlink -f "${KAS_GIT_CREDENTIAL_STORE}")":/var/kas/userdata/.git-credentials:ro
+	set -- "$@" -v "$(readlink -fv "${KAS_GIT_CREDENTIAL_STORE}")":/var/kas/userdata/.git-credentials:ro
 fi
 
 GIT_CREDENTIAL_HELPER="${GIT_CREDENTIAL_HELPER:-${KAS_GIT_CREDENTIAL_HELPER_DEFAULT}}"
@@ -451,7 +479,7 @@ if [ -n "${GIT_CREDENTIAL_HELPER}" ] ; then
 fi
 
 if [ -f "${NETRC_FILE}" ]; then
-	set -- "$@" -v "$(readlink -f "${NETRC_FILE}")":/var/kas/userdata/.netrc:ro \
+	set -- "$@" -v "$(readlink -fv "${NETRC_FILE}")":/var/kas/userdata/.netrc:ro \
 		-e NETRC_FILE="/var/kas/userdata/.netrc"
 fi
 
@@ -462,14 +490,14 @@ fi
 if [ -n "${DL_DIR}" ]; then
 	trace mkdir -p "${DL_DIR}"
 	set -- "$@" \
-		-v "$(readlink -f "${DL_DIR}")":/downloads:rw \
+		-v "$(readlink -fv "${DL_DIR}")":/downloads:rw \
 		-e DL_DIR=/downloads
 fi
 
 if [ -n "${SSTATE_DIR}" ]; then
 	trace mkdir -p "${SSTATE_DIR}"
 	set -- "$@" \
-		-v "$(readlink -f "${SSTATE_DIR}")":/sstate:rw \
+		-v "$(readlink -fv "${SSTATE_DIR}")":/sstate:rw \
 		-e SSTATE_DIR=/sstate
 fi
 
@@ -479,12 +507,13 @@ if [ -n "${KAS_REPO_REF_DIR}" ]; then
 		exit 1
 	fi
 	set -- "$@" \
-		-v "$(readlink -f "${KAS_REPO_REF_DIR}")":/repo-ref:rw \
+		-v "$(readlink -fv "${KAS_REPO_REF_DIR}")":/repo-ref:rw \
 		-e KAS_REPO_REF_DIR=/repo-ref
 fi
 
 for var in TERM KAS_DISTRO KAS_MACHINE KAS_TARGET KAS_TASK \
-           KAS_PREMIRRORS DISTRO_APT_PREMIRRORS BB_NUMBER_THREADS PARALLEL_MAKE; do
+           KAS_PREMIRRORS DISTRO_APT_PREMIRRORS BB_NUMBER_THREADS PARALLEL_MAKE \
+           GIT_CREDENTIAL_USEHTTPPATH; do
 	if [ -n "$(eval echo \$${var})" ]; then
 		set -- "$@" -e "${var}=$(eval echo \"\$${var}\")"
 	fi
-- 
2.35.3

