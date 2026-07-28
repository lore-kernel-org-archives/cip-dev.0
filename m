Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FECC54F55
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 13:13:01 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11067.1785244370667933537
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2026 06:12:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ALDq7J7z;
 spf=pass (domain: siemens.com, ip: 40.107.130.47, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2E9CKGMPmdyWMESjm/G/9N4Uu55PV4WjG1tkvBkhwy6dDmb84RrX9QYENcQd8Otrqd9U3w3gLbGm/WwRGmv3dkYEVS8FvEYURe52R5cEbUnJGpHhCyzMdl9hZqtbMaz/kO/4AarQQ5X/yJ+ng7uuKt47zBYgVYLl8KsvD4j25s7PuJYD+q3B8cohN9Z69e7110cOEC3Y1+v9PDi65ydXt33bi6ixrq4FA50FYNn1JEbFRhrEDMyp3RgsYlgPwotyVqrnCRposTOBQdRL3IyVXkb77yrhEuxWL8jttMFSdmHK8zN8sPCrZzdftsLcvylWA3x6Yd1RmbZ1uk/JTrJIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WnZozbcS1expF1gs4Fl5dM29rCAGTdyb+w6Cy8al10=;
 b=U/RstiXr2NkW4q8LEtolcjlFr92Ad6lwB7DmvWOpsfNxrm5MlEAckplZU4ZDIUWhXO+daIYqKtJp8Qn42GVLfbTuwhxovJf1fsyjgTYkZe66i1fS+b4vYXWTUlejFyTfGvkaanVKZHYMLogXoMXZEAyFZopkuBB4PCo0nmzs/kHyGttEar3HqovtsfDwrW1Nlgo3iI11DR2Xpaj0MoRyra1KT2SNZW9PM0btsXepta4OMPTwn1nm7/1pyzlyQ4hrLwmfMGUYPtK4iMw9Q46SGsFQDZUVKSu1ObNs7ri1viWJt+3NnJIWbxcXl6qgu5Jz6+lFDkmX7/EObkrIPucZPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WnZozbcS1expF1gs4Fl5dM29rCAGTdyb+w6Cy8al10=;
 b=ALDq7J7zN8Mf/tae+WWRa0T04da33SNdWIUI6VUXzW9h9Z17/qTsOsCBwVV/Vhqh+1sBU7z5kTq6Rnc09RuMilI0+Fpx1F579BbmYRpU6u+qLaVr+3XrQs3RFpAeypN9oELcO/YePjm9JfQzV5/RDpgS4/OpHfdkRUdFfpPeyQxtuAd1cuS95fuc6Zrg5VWSE1tt56l3Yb3NT332h4MDTmAD2v+Bj2AgaBp+lZWrE12mEhuA5alrDXdIzhov3ergqn35pqMMt1Wnj7hapNZ08uD/M0hTV+/bvGxdr3iBB9bL5EXPyrbEey3P4EmxirCTzT/T4yEOr+G3W9gceGu5hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DU0PR10MB6083.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 13:12:47 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 13:12:47 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 1/5] update to kas 5.4
Date: Tue, 28 Jul 2026 15:12:15 +0200
Message-ID: <20260728131231.117214-2-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728131231.117214-1-quirin.gylstorff@siemens.com>
References: <20260728131231.117214-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::9) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DU0PR10MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c44f67-640a-4c1f-58fd-08deeca9eb2d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|6133799003|11063799006|56012099006|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	wiTND2WV+KvEBBQpCG/DJPTcS6jeb64iZi+J5HyUrk25zMuYlAm71Gd7eBiSDGwv7ONdBWD9quFlPBLGOxRtdValfEsaKkVG4jQaImCnYyCVnVTYNUimpJlTbo1nmaPG5BmY1MFPpRaYNtWldBFH/qr1DXkWcFfTJNJQ238injFOjYVfwHNqo9U4r0d1EMixWQsdzL1wd+f0OdIKCHUhBMQ58NoEsIlEhNvEkOEsoOt/rFVkVc4H/Xy1Vq+Yw41wHdp5dQYjqMuRSqhwosOh1/1cRIHNNCf+r1+o9PpMsV3POjtTeSP2Ky49AKcVXbQ0YYonuh5l24p+P2R9DOcq7JKNzNs0gQYoA3CKeh/xdPoajVFG7l7bqyRTEoI/tRkIYe+I+f9sMLbntY11fqB4hGy4TZpWy/OJ5ZPZz4QJCse6cvBrSN51lt9DyXK/xMLND0iAaHrTvGgC3TKFVIjCHi7CBRZAKwadR44KLy7FD/l8XAyLHYXAeeyzmRqVhyl8n3fOBJm92riYasQajQxdznJlnTGqFmtn5aE3xd8/4W/cTaU1ptkRV14X/JzTsrxX32Rg6He4TBY/y2eUQspzQbRKd/xXC43CI/dT0SY1WTk8S2Su2GXdZrdRinHdnMaj
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(6133799003)(11063799006)(56012099006)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BvpPHXZd/JbhCkM5WhqLV6XZIx9PNfwR3pwgWSwCoCWrfUCyLgX6f+l7OHi9?=
 =?us-ascii?Q?avzYsca4uetKDID4hd67kiaj/XoTuss8itrGBXo8QxKkXy+/xkU15oM3SJyL?=
 =?us-ascii?Q?4RpQXD1UNvcxvp9bxAkAMSvK7VQ1NXHIIXJBAn6UnevPcYLPNn7LUS2pyvmb?=
 =?us-ascii?Q?NvrAaU6fLByyd5pN23dXxLG75lNcj82MN78vRW/nwNSRusMtBf/WI9TjEmO+?=
 =?us-ascii?Q?5QMmHCGMSMfl4F/Gartdp5jfIpdv2Vw0lvOq2LWZvv62R7l3KF5NMokCCWvx?=
 =?us-ascii?Q?ZnvgH0Y/d/vwlcR21GhJul2UVjG3tc9hj488kdIFwl/WPw1CHPGszsKT6tfA?=
 =?us-ascii?Q?XRaPcvLWY9tlyWAjw58iVI6B5Njk8WJBXLplHzvEXgaBUgCQ9j4OhOozIHgT?=
 =?us-ascii?Q?VUTtRTrv0PEL83hb2lI8OZrWU6mloN0oEDy5Qba8wzERxfBlCxdujhbQAsro?=
 =?us-ascii?Q?lxY4UgEe2rJJ4PiKoc5L8fvKPTRqGvGgMFC6Zha/4UCk6xv3X+Q2UoWansDY?=
 =?us-ascii?Q?a4lNM9sK1nnlLDiltE3/uLa0pEpYbF720+HU8ft2jjWVl+zBzgqvF2zvJpAS?=
 =?us-ascii?Q?/LcvTGSZyFh00JJKQgsrn2IIfGfvd/RgKucsmqX/bi9mXPmokxwpiNtMNXYH?=
 =?us-ascii?Q?J0aUJ2yNo5LgOo4Wd66OFZZr7fL8xybAFTlI18owJ77Enwd4M5Dao+ebv1lC?=
 =?us-ascii?Q?cA3WGo/oTDRjjHvoe88V8r39cjG7Njj+AlLX9DMotRwZWSsVblp96CwbcH/X?=
 =?us-ascii?Q?gAAFnIA2GBU9h5JrcyAgSDgvZPnhK3nu35x8caZzm0nJ5skJRJ8HH/SSyyQf?=
 =?us-ascii?Q?oMOJJoRmN+cH9ffpBW/K/Rxd4xbWCD8C9clG+D6J6W73ihlvAaXszwZFUnFR?=
 =?us-ascii?Q?BaNMx4vlmydyJyolLkw/on/3FcXMSVWEb7wDK/BmAIP+uzX6wO/PXF5ZLAqJ?=
 =?us-ascii?Q?//EFkZsaWAbUFlXkvfvpZJKggpjmMAxb1yBN96oPoYRRBqMEcsYx6+LG5APr?=
 =?us-ascii?Q?YvonO9X/0x58DMiWTp0fczY8SIg46SgaPVEcsQ1ZDiWlzvDCbWbD072XYnsQ?=
 =?us-ascii?Q?tBlq8TmGIpRtZaYH/8OTiDB13feMcpTtyhHgWKM+G/BfW/0rxblvIzs4Bsy6?=
 =?us-ascii?Q?yNYJFO2GWKIIhtb8Ds85ckUdn/Zn2c2yJ1yM7ziDM+yN4b77Vsnxj4APqTUp?=
 =?us-ascii?Q?/UKO8nb7Td3SZ71pFyMf1UqudL3w6ZPbed+j+cd0pEu6AOnfp9785OyoQOHG?=
 =?us-ascii?Q?vlfyaxJwuzvERQRn2cF+8Ymh6to/oO9IPH07f5pB5Q1I6YlUyS7xz6tsoHDM?=
 =?us-ascii?Q?WjVhniooWfYbPEJCYbYXCe2QtIVvHJoKrXw0wt2RD6gQVmMkddRT2/0Rtm6p?=
 =?us-ascii?Q?up4G0/GU8oHEOalInJJq7I7T1PkdFKnEhSNOcWuKmKUsiiaekJj7AIi4LKte?=
 =?us-ascii?Q?TISG9P/itTaJpfNIlruowBbq+o+QA98whEXEMkfLuzjHmK9wmFZGt0j4RuDd?=
 =?us-ascii?Q?WVblCcvjEbeULiG0jxcJl8NkYPj2sBH5fsFvawQnIYpS829bwJRva1F9j2cT?=
 =?us-ascii?Q?j9aCbuVNnaGLl7YpdnurOiaR2aUOl4u4bmETza1PIwHdZgLpwn0OM75D0WNt?=
 =?us-ascii?Q?uRdXKCaqeR308mxNtJzrgpn8u8Cksmn8wJ4CZ0RfHl9CeHqhGWso6o6MOX6t?=
 =?us-ascii?Q?9edD+N1HirM/+wvBtQY29QDxRz+O4d+hKbdrJf2njGCQJs5t1kMxdp5qpBOL?=
 =?us-ascii?Q?pEmlx7LsUhfqwlSXNGeiG3UUwXrAIz4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c44f67-640a-4c1f-58fd-08deeca9eb2d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 13:12:47.4398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIyQW1Fu/1au5xCymb8A1qvBTe7gY3lFV3pXlcoAsloHEIZoYC+24MyM8lD9G69RDN0M35WMQ9MKs3bWLuctylO14LGQBwNbbtLN7g27vL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6083
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jul 2026 13:13:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23798

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml |   2 +-
 Kconfig        |   2 +-
 kas-cip.yml    |   2 +-
 kas-container  | 300 ++++++++++++++++++++++++++-----------------------
 4 files changed, 164 insertions(+), 142 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b53def4..1e61cb0 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -33,7 +33,7 @@ stages:
   - cve-check
=20
 default:
-  image: ghcr.io/siemens/kas/kas-isar:5.2
+  image: ghcr.io/siemens/kas/kas-isar:5.4
   before_script:
     - export http_proxy=3D$HTTP_PROXY
     - export https_proxy=3D$HTTPS_PROXY
diff --git a/Kconfig b/Kconfig
index 438234c..5003bed 100644
--- a/Kconfig
+++ b/Kconfig
@@ -17,7 +17,7 @@ config KAS_INCLUDE_MAIN
=20
 config KAS_BUILD_SYSTEM
 	string
-	default "isar"
+	default "isar-privileged"
=20
 config ARCH_AMD64
 	bool
diff --git a/kas-cip.yml b/kas-cip.yml
index 23bbba4..6badc7d 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -15,7 +15,7 @@ header:
 distro: cip-core-trixie
 target: cip-core-image
=20
-build_system: isar
+build_system: isar-privileged
=20
 repos:
   cip-core:
diff --git a/kas-container b/kas-container
index 993f0bb..631e40c 100755
--- a/kas-container
+++ b/kas-container
@@ -27,7 +27,7 @@
=20
 set -e
=20
-KAS_CONTAINER_SCRIPT_VERSION=3D"5.2"
+KAS_CONTAINER_SCRIPT_VERSION=3D"5.4"
 KAS_IMAGE_VERSION_DEFAULT=3D"${KAS_CONTAINER_SCRIPT_VERSION}"
 KAS_CONTAINER_IMAGE_DISTRO_DEFAULT=3D""
 KAS_CONTAINER_IMAGE_PATH_DEFAULT=3D"ghcr.io/siemens/kas"
@@ -49,9 +49,10 @@ usage()
 	printf "%b" "\nPositional arguments:\n"
 	printf "%b" "build\t\t\tCheck out repositories and build target.\n"
 	printf "%b" "checkout\t\tCheck out repositories but do not build.\n"
+	printf "%b" "diff\t\t\tCompare two kas configurations.\n"
 	printf "%b" "dump\t\t\tCheck out repositories and write flat version\n"
 	printf "%b" "    \t\t\tof config to stdout.\n"
-	printf "%b" "lock\t\t\tCreate and update kas project lockfiles\n"
+	printf "%b" "lock\t\t\tCreate and update kas project lockfiles.\n"
 	printf "%b" "shell\t\t\tRun a shell in the build environment.\n"
 	printf "%b" "for-all-repos\t\tRun specified command in each repository.\n=
"
 	printf "%b" "clean\t\t\tClean build artifacts, keep sstate cache and " \
@@ -61,20 +62,19 @@ usage()
 	printf "%b" "cleanall\t\tClean build artifacts, sstate cache and " \
 		    "downloads.\n"
 	printf "%b" "purge\t\t\tRemove all data managed by kas. Run with '--dry-r=
un'\n"
-	printf "%b" "     \t\t\tto check what would be removed\n"
+	printf "%b" "     \t\t\tto check what would be removed.\n"
 	printf "%b" "menu\t\t\tProvide configuration menu and trigger " \
 		    "configured build.\n"
 	printf "%b" "\nOptional arguments:\n"
-	printf "%b" "--isar\t\t\tUse kas-isar container to build Isar image. To f=
orce\n"
-	printf "%b" "      \t\t\tthe use of run0 over sudo, set KAS_SUDO_CMD=3Dru=
n0.\n"
-	printf "%b" "--with-loop-dev		Pass a loop device to the " \
-		    "container. Only required if\n"
-	printf "%b" "\t\t\tloop-mounting is used by recipes.\n"
+	printf "%b" "--isar-privileged\tRun an Isar build in privileged mode. " \
+	            "To force the use\n"
+	printf "%b" "\t\t\tof run0 over sudo, set KAS_SUDO_CMD=3Drun0.\n"
+	printf "%b" "--isar-rootless\t\tRun an Isar build in rootless mode.\n"
 	printf "%b" "--runtime-args\t\tAdditional arguments to pass to the " \
-			"container runtime\n"
+			"container runtime.\n"
 	printf "%b" "\t\t\tfor running the build.\n"
 	printf "%b" "-l, --log-level\t\tSet log level (default=3Dinfo).\n"
-	printf "%b" "--version\t\tprint program version.\n"
+	printf "%b" "--version\t\tPrint program version.\n"
 	printf "%b" "--ssh-dir\t\tDirectory containing SSH configurations.\n"
 	printf "%b" "\t\t\tAvoid \$HOME/.ssh unless you fully trust the " \
 		    "container.\n"
@@ -83,13 +83,15 @@ usage()
 	printf "%b" "\t\t\tAvoid \$HOME/.aws unless you fully trust the " \
 		    "container.\n"
 	printf "%b" "--git-credential-store\tFile path to the git credential " \
-		    "store\n"
+		    "store.\n"
+	printf "%b" "--git-credential-socket\tPath to the git credential cache " =
\
+	       "socket.\n"
 	printf "%b" "--no-proxy-from-env\tDo not inherit proxy settings from " \
 		    "environment.\n"
 	printf "%b" "--repo-ro\t\tMount current repository read-only\n" \
-		    "\t\t\t(default for build command)\n"
+		    "\t\t\t(default for build command).\n"
 	printf "%b" "--repo-rw\t\tMount current repository writable\n" \
-		    "\t\t\t(default for shell command)\n"
+		    "\t\t\t(default for shell command).\n"
 	printf "%b" "-h, --help\t\tShow this help message and exit.\n"
 	printf "%b" "\n"
 	printf "%b" "You can force the use of podman over docker using " \
@@ -143,11 +145,6 @@ prepare_sudo_cmd()
=20
 enable_isar_mode()
 {
-	if [ -n "${ISAR_MODE}" ]; then
-		return
-	fi
-	ISAR_MODE=3D1
-
 	KAS_CONTAINER_IMAGE_NAME_DEFAULT=3D"kas-isar"
 	KAS_ISAR_ARGS=3D"--privileged"
=20
@@ -159,14 +156,38 @@ enable_isar_mode()
 		export PATH=3D"${PATH}:/usr/sbin"
 	elif [ "${KAS_DOCKER_ROOTLESS}" =3D "1" ]; then
 		prepare_sudo_cmd
-		export DOCKER_HOST=3D"${DOCKER_HOST:-unix:///var/run/docker.sock}"
-		debug "kas-isar does not support rootless docker. Using system docker"
+		DOCKER_HOST_DEFAULT=3D"$(docker context inspect default --format '{{.End=
points.docker.Host}}')"
+		export DOCKER_HOST=3D"${DOCKER_HOST:-$DOCKER_HOST_DEFAULT}"
+		debug "kas-isar does not support rootless docker. Using system docker in=
 $DOCKER_HOST"
 		# force use of well-known system docker socket
 		KAS_CONTAINER_COMMAND=3D"${_KAS_SUDO_CMD} ${KAS_CONTAINER_COMMAND}"
 		KAS_DOCKER_ROOTLESS=3D0
 	fi
 }
=20
+enable_isar_rootless_mode()
+{
+	KAS_CONTAINER_IMAGE_NAME_DEFAULT=3D"kas-isar"
+
+	# Use --privileged to pass the ambient capabilities into the container.
+	# When calling from the user session (podman or docker-rootless), this
+	# is fundamentally different from the system docker run --privileged
+	if [ "${KAS_CONTAINER_ENGINE}" =3D "podman" ]; then
+		KAS_RUNTIME_ARGS=3D"${KAS_RUNTIME_ARGS} --userns=3Dkeep-id --privileged"
+	elif [ "${KAS_DOCKER_ROOTLESS}" =3D "1" ]; then
+		KAS_ISAR_ARGS=3D"--privileged"
+	else
+		# we don't need --privileged, but we need to run with SYS_ADMIN
+		# to be able to unshare.
+		KAS_ISAR_ARGS=3D" \
+			--security-opt seccomp=3Dunconfined \
+			--security-opt apparmor=3Dunconfined \
+			--security-opt systempaths=3Dunconfined \
+			--cap-add=3DSYS_ADMIN \
+		"
+	fi
+}
+
 enable_oe_mode()
 {
 	if [ "${KAS_CONTAINER_ENGINE}" =3D "podman" ]; then
@@ -174,6 +195,7 @@ enable_oe_mode()
 		# calling "podman run" has a 1:1 mapping
 		KAS_RUNTIME_ARGS=3D"${KAS_RUNTIME_ARGS} --userns=3Dkeep-id"
 	fi
+	BUILD_SYSTEM=3D"openembedded"
 }
=20
 enable_unpriv_userns_docker()
@@ -210,6 +232,19 @@ check_and_expand()
 	realpath -e "$_varval"
 }
=20
+# SC2034: DIR appears unused (ignore, as they are used inside eval)
+# shellcheck disable=3D2034
+setup_kas_dirs()
+{
+	KAS_WORK_DIR=3D"${KAS_WORK_DIR:-$(pwd)}"
+	KAS_WORK_DIR=3D"$(check_and_expand KAS_WORK_DIR required)"
+	KAS_BUILD_DIR=3D"$(check_and_expand KAS_BUILD_DIR create)"
+	KAS_REPO_REF_DIR=3D"$(check_and_expand KAS_REPO_REF_DIR required)"
+	DL_DIR=3D"$(check_and_expand DL_DIR createrec)"
+	SSTATE_DIR=3D"$(check_and_expand SSTATE_DIR createrec)"
+	KAS_BUILDTOOLS_DIR=3D"$(check_and_expand KAS_BUILDTOOLS_DIR createrec)"
+}
+
 # Params: FILE
 # Returns: root repo dir of file
 repo_path_of_file()
@@ -260,14 +295,6 @@ forward_dir()
 	fi
 }
=20
-check_docker_rootless()
-{
-	KAS_DOCKER_ROOTLESS=3D0
-	if [ "$(docker context show)" =3D "rootless" ]; then
-		KAS_DOCKER_ROOTLESS=3D1
-	fi
-}
-
 enable_docker_rootless()
 {
 	warning "Rootless docker used, only limited functionality available."
@@ -281,118 +308,44 @@ enable_docker_rootless()
 	KAS_RUNTIME_ARGS=3D"${KAS_RUNTIME_ARGS} -e KAS_DOCKER_ROOTLESS=3D1"
 }
=20
-KAS_GIT_OVERLAY_FILE=3D""
-kas_container_cleanup()
-{
-	if [ -f "${KAS_GIT_OVERLAY_FILE}" ]; then
-		trace rm -f "${KAS_GIT_OVERLAY_FILE}"
-	fi
-}
-trap kas_container_cleanup EXIT INT TERM
-
 set_container_image_var()
 {
+	# if the image is explicitly set, use that
+	if [ -n "${KAS_CONTAINER_IMAGE}" ]; then
+		return
+	fi
 	KAS_IMAGE_VERSION=3D"${KAS_IMAGE_VERSION:-${KAS_IMAGE_VERSION_DEFAULT}}"
 	KAS_CONTAINER_IMAGE_DISTRO=3D"${KAS_CONTAINER_IMAGE_DISTRO:-${KAS_CONTAIN=
ER_IMAGE_DISTRO_DEFAULT}}"
 	KAS_CONTAINER_IMAGE_NAME=3D"${KAS_CONTAINER_IMAGE_NAME:-${KAS_CONTAINER_I=
MAGE_NAME_DEFAULT}}"
 	KAS_CONTAINER_IMAGE_PATH=3D"${KAS_CONTAINER_IMAGE_PATH:-${KAS_CONTAINER_I=
MAGE_PATH_DEFAULT}}"
-	KAS_CONTAINER_IMAGE_DEFAULT=3D"${KAS_CONTAINER_IMAGE_PATH}/${KAS_CONTAINE=
R_IMAGE_NAME}:${KAS_IMAGE_VERSION}"
-	KAS_CONTAINER_IMAGE=3D"${KAS_CONTAINER_IMAGE:-${KAS_CONTAINER_IMAGE_DEFAU=
LT}}"
+	KAS_CONTAINER_IMAGE=3D"${KAS_CONTAINER_IMAGE_PATH}/${KAS_CONTAINER_IMAGE_=
NAME}:${KAS_IMAGE_VERSION}"
 	if [ -n "${KAS_CONTAINER_IMAGE_DISTRO}" ]; then
 		KAS_CONTAINER_IMAGE=3D"${KAS_CONTAINER_IMAGE}-${KAS_CONTAINER_IMAGE_DIST=
RO}"
 	fi
 }
=20
-# SC2034: DIR appears unused (ignore, as they are used inside eval)
-# shellcheck disable=3D2034
-setup_kas_dirs()
-{
-	KAS_WORK_DIR=3D"${KAS_WORK_DIR:-$(pwd)}"
-	KAS_WORK_DIR=3D"$(check_and_expand KAS_WORK_DIR required)"
-	KAS_BUILD_DIR=3D"$(check_and_expand KAS_BUILD_DIR create)"
-	KAS_REPO_REF_DIR=3D"$(check_and_expand KAS_REPO_REF_DIR required)"
-	DL_DIR=3D"$(check_and_expand DL_DIR createrec)"
-	SSTATE_DIR=3D"$(check_and_expand SSTATE_DIR createrec)"
-	KAS_BUILDTOOLS_DIR=3D"$(check_and_expand KAS_BUILDTOOLS_DIR createrec)"
-}
-setup_kas_dirs
-
-KAS_CONTAINER_ENGINE=3D"${KAS_CONTAINER_ENGINE:-${KAS_DOCKER_ENGINE}}"
-if [ -z "${KAS_CONTAINER_ENGINE}" ]; then
-	# Try to auto-detect a container engine
-	if command -v docker >/dev/null; then
-		case $(docker -v 2>/dev/null) in
-		podman*)
-			# The docker command is an alias for podman
-			KAS_CONTAINER_ENGINE=3Dpodman
-			;;
-		Docker*)
-			# The docker command is the real docker
-			KAS_CONTAINER_ENGINE=3Ddocker
-			;;
-		*)
-			# The docker command is an unknown engine
-			fatal_error "docker command found, but unknown engine detected"
-		esac
-	elif command -v podman >/dev/null; then
-		KAS_CONTAINER_ENGINE=3Dpodman
-	else
-		fatal_error "no container engine found, need docker or podman"
-	fi
-fi
-
-KAS_RUNTIME_ARGS=3D"--log-driver=3Dnone --user=3Droot"
-
-case "${KAS_CONTAINER_ENGINE}" in
-docker)
-	KAS_CONTAINER_COMMAND=3D"docker"
-	enable_unpriv_userns_docker
-	check_docker_rootless
-	;;
-podman)
-	KAS_CONTAINER_COMMAND=3D"podman"
-	KAS_RUNTIME_ARGS=3D"${KAS_RUNTIME_ARGS} --security-opt label=3Ddisable"
-	;;
-*)
-	fatal_error "unknown container engine '${KAS_CONTAINER_ENGINE}'"
-	;;
-esac
-
-# parse kas-container options
+# parse kas-container options, leave build system empty to distinguish bet=
ween
+# explicitly set via flag and implicitly via config.
+BUILD_SYSTEM=3D""
+KAS_OPTIONS_DIRECT=3D""
+KAS_EXTRA_RUNTIME_ARGS=3D""
 while [ $# -gt 0 ]; do
 	case "$1" in
-	--isar)
-		enable_isar_mode
+	--isar | --isar-privileged)
+		if [ "$1" =3D "--isar" ]; then
+			warning "The semantic of '--isar' might change in the" \
+				"future. Please use '--isar-privileged' instead."
+		fi
+		BUILD_SYSTEM=3D"isar-privileged"
 		shift 1
 		;;
-	--with-loop-dev)
-		if ! KAS_LOOP_DEV=3D$(/sbin/losetup -f 2>/dev/null); then
-			if [ "$(id -u)" -eq 0 ]; then
-				fatal_error "loop device not available!"
-			fi
-			prepare_sudo_cmd
-			if ! [ "$KAS_SUDO_CMD" =3D "sudo" ]; then
-				fatal_error '--with-loop-dev requires sudo for device setup.'
-			fi
-			sudo_command=3D"/sbin/losetup -f"
-			sudo_message=3D"[sudo] enter password to setup loop"
-			sudo_message=3D"$sudo_message devices by calling"
-			sudo_message=3D"$sudo_message '$sudo_command': "
-			# SC2086: Double quote to prevent globbing and word splitting.
-			# shellcheck disable=3D2086
-			if ! KAS_LOOP_DEV=3D$(sudo -p "$sudo_message" $sudo_command \
-				2>/dev/null); then
-				fatal_error "loop device setup unsuccessful!" \
-				            "try calling '$sudo_command' with root" \
-				            "permissions manually."
-			fi
-		fi
-		KAS_WITH_LOOP_DEV=3D"--device ${KAS_LOOP_DEV}"
+	--isar-rootless)
+		BUILD_SYSTEM=3D"isar-rootless"
 		shift 1
 		;;
-	--runtime-args|--docker-args)
+	--runtime-args | --docker-args)
 		[ $# -gt 0 ] || usage
-		KAS_RUNTIME_ARGS=3D"${KAS_RUNTIME_ARGS} $2"
+		KAS_EXTRA_RUNTIME_ARGS=3D" $2"
 		shift 2
 		;;
 	--ssh-dir)
@@ -417,6 +370,13 @@ while [ $# -gt 0 ]; do
 		KAS_GIT_CREDENTIAL_STORE=3D"$2"
 		shift 2
 		;;
+
+	--git-credential-socket)
+		[ $# -gt 2 ] || usage
+		KAS_GIT_CREDENTIAL_SOCKET=3D"$2"
+		shift 2
+		;;
+
 	--no-proxy-from-env)
 		KAS_NO_PROXY_FROM_ENV=3D1
 		shift 1
@@ -446,19 +406,19 @@ while [ $# -gt 0 ]; do
 	--*)
 		usage
 		;;
-	clean|cleansstate|cleanall|purge)
+	clean | cleansstate | cleanall | purge)
 		KAS_REPO_MOUNT_OPT_DEFAULT=3D"ro"
 		KAS_CMD=3D$1
 		shift 1
 		break
 		;;
-	shell|lock)
+	shell | lock)
 		KAS_REPO_MOUNT_OPT_DEFAULT=3D"rw"
 		KAS_CMD=3D$1
 		shift 1
 		break
 		;;
-	build|checkout|for-all-repos|menu)
+	build | checkout | for-all-repos | menu)
 		KAS_REPO_MOUNT_OPT_DEFAULT=3D"ro"
 		KAS_CMD=3D$1
 		shift 1
@@ -486,6 +446,10 @@ while [ $# -gt 0 ]; do
 	esac
 done
=20
+KAS_RUNTIME_ARGS=3D"--log-driver=3Dnone --user=3Droot"
+
+setup_kas_dirs
+
 [ -n "${KAS_CMD}" ] || usage
=20
 KAS_EXTRA_BITBAKE_ARGS=3D0
@@ -494,17 +458,17 @@ KAS_FILES=3D
 # parse kas sub-command options
 while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
 	case "$1" in
-	--format|--indent|--provenance|--skip|--target|--task)
+	--format | --indent | --provenance | --skip | --target | --task)
 		KAS_OPTIONS=3D"${KAS_OPTIONS} $1 $2"
 		shift 1
 		shift 1 || KAS_OPTIONS=3D"--help"
 		;;
-	-c|--cmd|--command)
+	-c | --cmd | --command)
 		KAS_BITBAKE_C_OPTION_ARGS=3D"$2"
 		shift 1
 		shift 1 || KAS_OPTIONS=3D"--help"
 		;;
-	-E|--preserve-env)
+	-E | --preserve-env)
 		fatal_error "$1 is not supported with ${KAS_CONTAINER_SELF_NAME}"
 		;;
 	--)
@@ -563,10 +527,10 @@ if [ "${KAS_CMD}" =3D "menu" ]; then
 	if [ "$(echo "${KAS_FIRST_FILES}" | wc -w)" -ne "1" ]; then
 		fatal_error "menu plugin only supports a single Kconfig file"
 	fi
-	BUILD_SYSTEM=3D$(tr '\n' '\f' 2>/dev/null < "${KAS_FIRST_FILES}" | \
+	BUILD_SYSTEM=3D${BUILD_SYSTEM:-$(tr '\n' '\f' 2>/dev/null < "${KAS_FIRST_=
FILES}" |
 		sed -e 's/\(.*\fconfig KAS_BUILD_SYSTEM\f\(.*\)\|.*\)/\2/' \
 		    -e 's/\f\([[:alpha:]].*\|$\)//' \
-		    -e 's/.*default \"\(.*\)\".*/\1/')
+		    -e 's/.*default \"\(.*\)\".*/\1/')}
 else
 	if [ -z "${KAS_FIRST_FILES}" ]; then
 		KAS_FIRST_FILES=3D"${KAS_WORK_DIR}/.config.yaml"
@@ -574,20 +538,60 @@ else
=20
 	# We only get the first build system and let kas check if mixed
 	_KAS_FIRST_FILE=3D$(echo "${KAS_FIRST_FILES}" | awk '{print $1}')
-	BUILD_SYSTEM=3D$(grep -e "^build_system: " "${_KAS_FIRST_FILE}" 2>/dev/nu=
ll | \
-		sed 's/build_system:[ ]\+//')
+	BUILD_SYSTEM=3D${BUILD_SYSTEM:-$(grep -e "^build_system: " "${_KAS_FIRST_=
FILE}" 2>/dev/null |
+		sed 's/build_system:[ ]\+//')}
+fi
+
+KAS_CONTAINER_ENGINE=3D"${KAS_CONTAINER_ENGINE:-${KAS_DOCKER_ENGINE}}"
+if [ -z "${KAS_CONTAINER_ENGINE}" ]; then
+	# Try to auto-detect a container engine
+	# Defaults if there are multiple options:
+	# podman if build system is isar-rootless, docker otherwise
+	if [ "${BUILD_SYSTEM}" =3D "isar-rootless" ] && command -v podman >/dev/n=
ull 2>&1; then
+		KAS_CONTAINER_ENGINE=3Dpodman
+	elif command -v docker >/dev/null 2>&1 && docker -v 2>/dev/null | grep -q=
 '^Docker'; then
+		KAS_CONTAINER_ENGINE=3Ddocker
+	elif command -v podman >/dev/null 2>&1; then
+		KAS_CONTAINER_ENGINE=3Dpodman
+	else
+		fatal_error "no container engine found, need docker or podman"
+	fi
 fi
=20
-if [ "${BUILD_SYSTEM}" =3D "isar" ]; then
+KAS_DOCKER_ROOTLESS=3D0
+case "${KAS_CONTAINER_ENGINE}" in
+docker)
+	KAS_CONTAINER_COMMAND=3D"docker"
+	enable_unpriv_userns_docker
+	if [ "$(docker context show)" =3D "rootless" ]; then
+		KAS_DOCKER_ROOTLESS=3D1
+	fi
+	;;
+podman)
+	KAS_CONTAINER_COMMAND=3D"podman"
+	KAS_RUNTIME_ARGS=3D"${KAS_RUNTIME_ARGS} --security-opt label=3Ddisable"
+	;;
+*)
+	fatal_error "unknown container engine '${KAS_CONTAINER_ENGINE}'"
+	;;
+esac
+
+if [ "${BUILD_SYSTEM}" =3D "isar" ] || [ "${BUILD_SYSTEM}" =3D "isar-privi=
leged" ]; then
 	enable_isar_mode
-elif [ -z "${ISAR_MODE}" ]; then
+elif [ "${BUILD_SYSTEM}" =3D "isar-rootless" ]; then
+	enable_isar_rootless_mode
+else
 	enable_oe_mode
 fi
=20
 # clean can be executed without config, hence manually forward the build s=
ystem
-if [ "${ISAR_MODE}" =3D "1" ] && echo "${KAS_CMD}" | grep -qe "^clean\|pur=
ge"; then
-	KAS_OPTIONS=3D"${KAS_OPTIONS} --isar"
-fi
+case "${BUILD_SYSTEM}" in
+isar*)
+	if echo "${KAS_CMD}" | grep -qe "^clean\|purge"; then
+		KAS_OPTIONS=3D"${KAS_OPTIONS} --${BUILD_SYSTEM}"
+	fi
+	;;
+esac
=20
 set_container_image_var
=20
@@ -632,6 +636,16 @@ forward_dir KAS_BUILDTOOLS_DIR "/buildtools" "rw"
=20
 if git_com_dir=3D$(git -C "${KAS_REPO_DIR}" rev-parse --git-common-dir 2>/=
dev/null) \
 	&& [ "$git_com_dir" !=3D "$(git -C "${KAS_REPO_DIR}" rev-parse --git-dir)=
" ]; then
+
+	KAS_GIT_OVERLAY_FILE=3D""
+	kas_container_cleanup()
+	{
+		if [ -f "${KAS_GIT_OVERLAY_FILE}" ]; then
+			trace rm -f "${KAS_GIT_OVERLAY_FILE}"
+		fi
+	}
+	trap kas_container_cleanup EXIT INT TERM
+
 	# If (it's a git repo) and the common dir isn't the git-dir, it is shared=
 worktree and
 	# we have to mount the common dir in the container to make git work
 	# The mount path inside the container is different from the host path. He=
nce, we over-mount
@@ -685,6 +699,14 @@ if [ -n "${KAS_GIT_CREDENTIAL_STORE}" ] ; then
 	set -- "$@" -v "$(realpath -e "${KAS_GIT_CREDENTIAL_STORE}")":/var/kas/us=
erdata/.git-credentials:ro
 fi
=20
+if [ -n "${KAS_GIT_CREDENTIAL_SOCKET}" ] ; then
+	if [ ! -S "${KAS_GIT_CREDENTIAL_SOCKET}" ]; then
+		fatal_error "passed KAS_GIT_CREDENTIAL_SOCKET '${KAS_GIT_CREDENTIAL_SOCK=
ET}' is not a socket"
+	fi
+	KAS_GIT_CREDENTIAL_HELPER_DEFAULT=3D"cache --socket=3D/var/kas/userdata/.=
git-cache-socket"
+	set -- "$@" -v "$(realpath -e "${KAS_GIT_CREDENTIAL_SOCKET}")":/var/kas/u=
serdata/.git-cache-socket
+fi
+
 GIT_CREDENTIAL_HELPER=3D"${GIT_CREDENTIAL_HELPER:-${KAS_GIT_CREDENTIAL_HEL=
PER_DEFAULT}}"
=20
 if [ -n "${GIT_CREDENTIAL_HELPER}" ] ; then
@@ -739,7 +761,7 @@ done
=20
 # propagate only supported SHELL settings
 case "$SHELL" in
-/bin/sh|/bin/bash|/bin/dash)
+/bin/sh | /bin/bash | /bin/dash)
 	set -- "$@" -e "SHELL=3D$SHELL"
 	;;
 *)
@@ -757,7 +779,7 @@ fi
=20
 # SC2086: Double quote to prevent globbing and word splitting.
 # shellcheck disable=3D2086
-set -- "$@" ${KAS_ISAR_ARGS} ${KAS_WITH_LOOP_DEV} ${KAS_RUNTIME_ARGS} \
+set -- "$@" ${KAS_ISAR_ARGS} ${KAS_RUNTIME_ARGS} ${KAS_EXTRA_RUNTIME_ARGS}=
 \
     ${KAS_CONTAINER_IMAGE} ${KAS_OPTIONS_DIRECT} ${KAS_CMD} ${KAS_OPTIONS}
 if [ -n "${KAS_BITBAKE_C_OPTION_ARGS}" ]; then
 	set -- "$@" -c "${KAS_BITBAKE_C_OPTION_ARGS}"
--=20
2.53.0


