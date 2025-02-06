Return-Path: <michael.adler@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C7BC02194
	for <webhook@archiver.kernel.org>; Thu,  6 Feb 2025 13:26:25 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.83])
 by mx.groups.io with SMTP id smtpd.web10.40696.1738848382465137519
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Feb 2025 05:26:23 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=TOMmFC5A;
 spf=pass (domain: siemens.com, ip: 40.107.249.83, mailfrom: michael.adler@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slpUEli0xQwPAfdx+fsNvzGmoHzEy2Qm5I/Uw2Mk8rgn1Vy/zOg3z2rxDJDgi9PFeRM0etAscBu0ZrormGyMyJe4dJplm0+W88vretjPIWPgZXW3O0iPhpzAYtxTnGx7GEpXwFsRalcRLhP/XQyrYwLOyhPGUcdGlCWZB+KWuWtAWXaz6uQNuSiorPJmIFBLX7yY449go9Y4MVwW8IKiYnwBtRhpLZgeXUTPLuEpTBrtoFV7vVOuMsepMeI9PzzmRYRUrif8+tjot7BrgdYc3SPr7dPbwwMKxsxvBMd1vftN2ajpHmLn2V4KCHIY3S8dWUqkbCtW9TClvhsfEfYR4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1u1bHyu9S8GlZl1xGNjA70wzWR3N8KML8W4IC+/4caM=;
 b=UP521zRMU2bsxYi9WRginp0YT+VfklZA7Ee/xSZTD3qYAukMKwl7iR7CbXVFZPW6yTda4KGwpfRRo26wVnvUU8LH4SkpLhEroW98fSSC7ODrvaDQPy0p+uyyDU8544Ht8oRyRweRb4L+F+Dh2/RYC0ekaNuDlem09/QYfryjjiEeU57sz66n0vZPbl/W3vq/qnv3NcxS5sC5i4IPCrgpYkM82kM0ZUALqkY3HI9eRJacbQ/g/4bBvX2x/GccbN6VrErxDNO/xUT0bZolt5gkBbhRg3ybioiM2pZS1J4d2uCsTotYdlqBaXEyC3d2smKvDksG+UPjJlJdPbQ/rnUq0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1u1bHyu9S8GlZl1xGNjA70wzWR3N8KML8W4IC+/4caM=;
 b=TOMmFC5ACIk3zSBS4qqBkH0FLzMxK/XyLPRYdyofSGJGyOiLZpp0r3x75L9pMH3O6VFwMSajYQR9SgWqNhciKQK1IAjHNergXNzk25sDk99+pHvV3sB3pTGpcpP4YrEzNVrGljwNTEFyOMFRknku3HFs0IItmeocB+l29aihRtSoiAsyDenBtJj8FlqgObZlqD2mmDXFxJeAvOiRFhwiOWn9GHLlEsXPgAtkQZuhUNwm8zm6PvBZtGA32PyQvv65suJ5YgBgrCQHlNkIMQI3hnarXyK5QQQH9qCByQINuPpM0tk3G+cxpYjwXbssidKXGnxh/XSVArT5QrWJzj2lqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by AM7PR10MB3811.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:175::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 13:26:20 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7499:8576:c129:4b89]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7499:8576:c129:4b89%5]) with mapi id 15.20.8422.011; Thu, 6 Feb 2025
 13:26:19 +0000
From: Michael Adler <michael.adler@siemens.com>
To: cip-dev@lists.cip-project.org
CC: Michael Adler <michael.adler@siemens.com>
Subject: [PATCH v2 2/2] kas: Update to release 4.7
Date: Thu,  6 Feb 2025 14:25:46 +0100
Message-ID: <20250206132546.177943-2-michael.adler@siemens.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206132546.177943-1-michael.adler@siemens.com>
References: <20250206132546.177943-1-michael.adler@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::12) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4734:EE_|AM7PR10MB3811:EE_
X-MS-Office365-Filtering-Correlation-Id: d15f5713-8f70-4617-db25-08dd46b1d784
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?P3at3UwsZN2EG7BO1QDj6G8pejuanqb411qMzybeHls3KHETtQHNdXckD8Yd?=
 =?us-ascii?Q?fT4bxHhhyqJEiL27pMt9pNuE4CYeCOJTBKluQnQ+I4/PUreNhboiI5oUQf26?=
 =?us-ascii?Q?X+KULtbkX9/gPsDWMpGKtsYiZuij9UKwQWUn70rfrDQxcbo050/H59riCf9K?=
 =?us-ascii?Q?kA+61Oy3/6VXsXKmoFSCMtKSxtNnFOuKkr6OQ+CJgan5QBlPt+hpActrBaQ4?=
 =?us-ascii?Q?vCveAtWq/CV3zRdYFT8AiztmveW+GeZs6HQOAIafJDQlA2AJYCtI0qov7lMj?=
 =?us-ascii?Q?nTf+acU9BPCaM9kM1ko06+6Byrco5xHh/j32G3SA+BKCN3lOycBo1zr1JOoX?=
 =?us-ascii?Q?BPjQkr+HurtqCdAet4+1vnlybAKYcuQkGxqQmTLo67ZshapM1B+lmG4TVzNT?=
 =?us-ascii?Q?UXd4m6+LRdDrL9Sn8YVYrxlBnIEZi9nsqJyJsiwb38FjW7/qSIFWjjWaoWwm?=
 =?us-ascii?Q?s3YF8aFs1fNTqTR9+GyzL4m9mnscH/a6a1SZEVR4j/F69chFolOMYz/YoiN8?=
 =?us-ascii?Q?bTBpXK5Dk9xPt7jqOeIzXmOUvH5azMYY6YRQJg8GYbRg52Hv768T9lqC9sn5?=
 =?us-ascii?Q?jh6GmKJImTCYvnXMAP2EnPN+nvIcE4WzV7AqQcreaF4jQHbWVouWzRutnmjK?=
 =?us-ascii?Q?fss66Vq8QCvZVzlcpJ7TKEUZ/iHBcyhRM+no2QJF3QVp8miIrgsObWUU1Ih/?=
 =?us-ascii?Q?Z+vGHoxQJrxZR8A62J/Zukw+J7T546WOA/ACsHrmNRC4Q1F7oNVN0tq4iroH?=
 =?us-ascii?Q?EtK0fNjzS7N2SCI+I/a5pGkFvfH69DE91Yu5mu2NUB3Dcc+eVkFKZHEpjFJ6?=
 =?us-ascii?Q?pqJW+y1BZs3m7t9oYKQspmLXFlqn7T+oBDZPxNgV/cLlciWIsMrnUxPwXETo?=
 =?us-ascii?Q?dw5vHo4+zc0/FtKY1oAvWHICTIhSI/uyEUSLaMIjvhyC9I+fr//+f8qtCdV1?=
 =?us-ascii?Q?gWnTucxAJ0ZbbvRGRSvLqIBDiGcEgdXNFO6PPVS4kg3HoQH1KJ+fUx7luBVx?=
 =?us-ascii?Q?qaDcHKS9N7IxM0WvuPTtPVRPyRcsIfv8GrdFfXG7VNLuzHMbApPaxeJzcd8D?=
 =?us-ascii?Q?0E9MI/RMkeo1bokP7HGIN3rf4P++gXTrz7OHGF/QHnHc8nkxcr61VB4Ewo9u?=
 =?us-ascii?Q?pXtDIvxr0Z54u+d7qc7ermWlv1L76OhSKLTpYC0nQ/Rqq7UDoIDnqv6lzL1O?=
 =?us-ascii?Q?ahsYizVQp3us9S0yXR3VDI16VAPfzFaDZbqOblC+ypc3moXoVedPbxzSw8ZF?=
 =?us-ascii?Q?jinkLHSIQXo2hdOpKmofxT5TNU55VLntVYqNWonA/eGMtBrmC1iug/harkes?=
 =?us-ascii?Q?b9RYoSCtWPqX6C+9mx5/jbKWOPL+GSLQc0rD2d7XypqEhg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eo7gYeZY/ijqh2mB598k/mSQ5z/JimyqhlhtpB8FwHfBjze6NBw+EStiz9Jb?=
 =?us-ascii?Q?AXiafV0cUGSBgRYOqt/hFxzqTF77TSYrZVUOFq7YQ4lhi7doTlSysq/QjANb?=
 =?us-ascii?Q?3OcGW9d9PvbHXfnQFbM0dYGYL5n8wAVlpqi03oZhR9NvoRF6f0kOgviFVTSB?=
 =?us-ascii?Q?K46afbK/1uu7gGZB3VbKPVHdjZ904pWvcegNZIIvpgwyotsZ5p1EobnPDIMh?=
 =?us-ascii?Q?Cc9KGS070j/10RQcOoIUAd+Ed1dI6nq0w4XNcHIKsNtOKUwHP4b3bYxastp9?=
 =?us-ascii?Q?vx1UxTeezcFva9Ly8gB40FGuRm4ixlsi1X2RhaCw69VtL5OtEVF4cX1rPMVJ?=
 =?us-ascii?Q?vPCKLozWCTq3ukcQakpyYa7V6tAZ4lGa+S0URD7AJ6tGWdQQnVyZxlBRjw6o?=
 =?us-ascii?Q?YnN2xazoUjhHKj3m65+6kP8sFcnf0thLz+Z2/7//02m6sQAt7bCAkyqtwz5H?=
 =?us-ascii?Q?WMgGrbLM17Vlm5E58vOFarLK5z5MdJD2HFv6jlojZs6XKEXJJ9o1gTLIbfqy?=
 =?us-ascii?Q?de2E7SrbeWVlrDB9KEyQwRzQehA2uiNnseyULFQYlTzFe0uoUcO+0n5z0Z8c?=
 =?us-ascii?Q?JqGQOukYbJNwrmMO6hbCajWRedwF/pliA5UJxzsJbeawe5s+LaREk9VGE3++?=
 =?us-ascii?Q?YT7degTyP0MkfH/SXyUhEmovbR0EbPRzWLfcYqgR1NapZ75a0yvWZD9jIfco?=
 =?us-ascii?Q?vwwTg41mYwLxm1NIMthzONC+dMlK0QafWd4qrgmhkOJdq//1jKaeuAmrW0Fr?=
 =?us-ascii?Q?WEQDZ0GS8aqzW/iCufDaqxlM0P3pFMPPVoFIHKRwY4qCeJ5LPfO2PDAFjOq2?=
 =?us-ascii?Q?qgUPiwkFDjnIYeTGT9vpDuvqW1CavNuQF1fuIMSzzdCsmSWBN/yunDbxK07V?=
 =?us-ascii?Q?bn7Gjg5VPLD+M5jUpzlUEsJPd6ybiPabOh8+Orva/SF1jd8UIqvx+GkE+0zn?=
 =?us-ascii?Q?ReFMlifAeGgrQpw/J7TePjSLfKBQeb76iW1nDVxSMF11sgNhYDJYP+fGBFqZ?=
 =?us-ascii?Q?SQgS8gIyy1AzBe+NohhHtDlbO6fXTHLZng8biv1fO5gNWMkBpxqiDMb/pPuU?=
 =?us-ascii?Q?Gc/Fq2aE0zj7t2S5APBCJUXZ4Sg0jJPBAQoXhMnLBJNa2fWakadOwd6rdn6P?=
 =?us-ascii?Q?XtragcJISxthlGq8w2+8GyUUmDr94fkdTeDj3tB0dvuo0WSURdTG2CquhA26?=
 =?us-ascii?Q?X3q10DiUp0k6YgCtKKSkc9aglgsGz0S992rkz0XRPqIxdwgw5D1v6OQHmZ2U?=
 =?us-ascii?Q?l0reH4aj3KlpI9vcGV/hLNBxn3UAjPvBFhBtuukcBnFPgwuLUAy9slP9Q5WR?=
 =?us-ascii?Q?BzzPnk89pcZDAcBqSgg7sZVDxjQIoy8CqC2mru/tM+Zgjny4CxR0Cb90Y4GV?=
 =?us-ascii?Q?90mPqbz2Lf66s2B8vVHZiIhZr0oTKmZypj34HBjzFtqVwysFqY2vK3Ign2S0?=
 =?us-ascii?Q?HXEgYxC3+HNtW/TZ7OuZ62pjAs+plmr4QXPzaUEH8diFWrOSZUKdTmd00e8S?=
 =?us-ascii?Q?WHwYoCh5JIrClbh8j90uDLvEPYMswmevpRJ6dD4SUmTde7qILLqts3Xqlddl?=
 =?us-ascii?Q?/kGgjpFVxW1b1FywekFfpZKWILSv36ZLGORhjXt6pDgMfb+qby5cRKWgGKkT?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d15f5713-8f70-4617-db25-08dd46b1d784
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 13:26:19.8703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBVx4qgxLbVpAyUfIF1k4pj5yEfWN+UtkRQ7EbgrDRV2oUnCUqi83C+GWewihAQZaIhViZ2cYkdAzVcDHmZqg4KuZy8mmX/7M8ufAwLBcfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3811
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Feb 2025 13:26:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17764

Signed-off-by: Michael Adler <michael.adler@siemens.com>
---
 kas-container | 99 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 78 insertions(+), 21 deletions(-)

diff --git a/kas-container b/kas-container
index 6b2131c..d6118b9 100755
--- a/kas-container
+++ b/kas-container
@@ -27,24 +27,28 @@
=20
 set -e
=20
-KAS_IMAGE_VERSION_DEFAULT=3D"4.5"
+KAS_IMAGE_VERSION_DEFAULT=3D"4.7"
 KAS_CONTAINER_IMAGE_PATH_DEFAULT=3D"ghcr.io/siemens/kas"
 KAS_CONTAINER_IMAGE_NAME_DEFAULT=3D"kas"
 KAS_CONTAINER_SELF_NAME=3D"$(basename "$0")"
=20
+# usage [exit_code]
 usage()
 {
+	EXIT_CODE=3D"$1"
 	SELF=3D"${KAS_CONTAINER_SELF_NAME}"
+
 	printf "%b" "Usage: ${SELF} [OPTIONS] { build | shell } [KASOPTIONS] [KAS=
FILE]\n"
-	printf "%b" "       ${SELF} [OPTIONS] { checkout | dump } [KASOPTIONS] [K=
ASFILE]\n"
+	printf "%b" "       ${SELF} [OPTIONS] { checkout | dump | lock } [KASOPTI=
ONS] [KASFILE]\n"
 	printf "%b" "       ${SELF} [OPTIONS] for-all-repos [KASOPTIONS] [KASFILE=
] COMMAND\n"
-	printf "%b" "       ${SELF} [OPTIONS] { clean | cleansstate | cleanall} [=
KASFILE]\n"
+	printf "%b" "       ${SELF} [OPTIONS] { clean | cleansstate | cleanall } =
[KASFILE]\n"
 	printf "%b" "       ${SELF} [OPTIONS] menu [KCONFIG]\n"
 	printf "%b" "\nPositional arguments:\n"
 	printf "%b" "build\t\t\tCheck out repositories and build target.\n"
 	printf "%b" "checkout\t\tCheck out repositories but do not build.\n"
 	printf "%b" "dump\t\t\tCheck out repositories and write flat version\n"
 	printf "%b" "    \t\t\tof config to stdout.\n"
+	printf "%b" "lock\t\t\tCreate and update kas project lockfiles\n"
 	printf "%b" "shell\t\t\tRun a shell in the build environment.\n"
 	printf "%b" "for-all-repos\t\tRun specified command in each repository.\n=
"
 	printf "%b" "clean\t\t\tClean build artifacts, keep sstate cache and " \
@@ -63,9 +67,7 @@ usage()
 	printf "%b" "--runtime-args\t\tAdditional arguments to pass to the " \
 			"container runtime\n"
 	printf "%b" "\t\t\tfor running the build.\n"
-	printf "%b" "-d\t\t\tPrint debug output (deprecated, use -l debug).\n"
 	printf "%b" "-l, --log-level\t\tSet log level (default=3Dinfo).\n"
-	printf "%b" "-v\t\t\tSame as -d (deprecated).\n"
 	printf "%b" "--version\t\tprint program version.\n"
 	printf "%b" "--ssh-dir\t\tDirectory containing SSH configurations.\n"
 	printf "%b" "\t\t\tAvoid \$HOME/.ssh unless you fully trust the " \
@@ -80,28 +82,39 @@ usage()
 		    "\t\t\t(default for build command)\n"
 	printf "%b" "--repo-rw\t\tMount current repository writeable\n" \
 		    "\t\t\t(default for shell command)\n"
+	printf "%b" "-h, --help\t\tShow this help message and exit.\n"
 	printf "%b" "\n"
 	printf "%b" "You can force the use of podman over docker using " \
 		    "KAS_CONTAINER_ENGINE=3Dpodman.\n"
-	exit 1
+
+	exit "${EXIT_CODE:-1}"
 }
=20
-fatal_error(){
+fatal_error()
+{
 	echo "${KAS_CONTAINER_SELF_NAME}: Error: $*" >&2
 	exit 1
 }
=20
-warning(){
+warning()
+{
 	echo "${KAS_CONTAINER_SELF_NAME}: Warning: $*" >&2
 }
=20
+debug(){
+	if [ -n "${KAS_VERBOSE}" ]; then
+		echo "${KAS_CONTAINER_SELF_NAME}: Debug: $*" >&2
+	fi
+}
+
 trace()
 {
 	[ -n "${KAS_VERBOSE}" ] && echo "+ $*" >&2
 	"$@"
 }
=20
-enable_isar_mode() {
+enable_isar_mode()
+{
 	if [ -n "${ISAR_MODE}" ]; then
 		return
 	fi
@@ -118,7 +131,8 @@ enable_isar_mode() {
 	fi
 }
=20
-enable_oe_mode() {
+enable_oe_mode()
+{
 	if [ "${KAS_CONTAINER_ENGINE}" =3D "podman" ]; then
 		# The container entry point expects that the current userid
 		# calling "podman run" has a 1:1 mapping
@@ -126,7 +140,23 @@ enable_oe_mode() {
 	fi
 }
=20
-run_clean() {
+enable_unpriv_userns_docker()
+{
+	if [ -f /etc/os-release ] && grep -q 'NAME=3D"Ubuntu"' /etc/os-release &&
+	   [ -f /proc/sys/kernel/apparmor_restrict_unprivileged_userns ] &&
+	   [ "$(cat /proc/sys/kernel/apparmor_restrict_unprivileged_userns)" =3D =
"1" ]; then
+		if [ -f /etc/apparmor.d/rootlesskit ]; then
+			debug "AppArmor restricts unprivileged userns, using \"rootlesskit\" pr=
ofile"
+			KAS_RUNTIME_ARGS=3D"${KAS_RUNTIME_ARGS} --security-opt apparmor=3Drootl=
esskit"
+		else
+			warning "AppArmor restricts unprivileged userns but no suitable apparmo=
r " \
+			        "profile found. Consider setting apparmor_restrict_unprivileged=
_userns=3D0"
+		fi
+	fi
+}
+
+run_clean()
+{
 	if [ -n "${KAS_ISAR_ARGS}" ]; then
 		# SC2086: Double quote to prevent globbing and word splitting.
 		# shellcheck disable=3D2086
@@ -149,7 +179,17 @@ run_clean() {
 	fi
 }
=20
-set_container_image_var() {
+KAS_GIT_OVERLAY_FILE=3D""
+kas_container_cleanup()
+{
+	if [ -f "${KAS_GIT_OVERLAY_FILE}" ]; then
+		trace rm -f "${KAS_GIT_OVERLAY_FILE}"
+	fi
+}
+trap kas_container_cleanup EXIT INT TERM
+
+set_container_image_var()
+{
 	KAS_IMAGE_VERSION=3D"${KAS_IMAGE_VERSION:-${KAS_IMAGE_VERSION_DEFAULT}}"
 	KAS_CONTAINER_IMAGE_NAME=3D"${KAS_CONTAINER_IMAGE_NAME:-${KAS_CONTAINER_I=
MAGE_NAME_DEFAULT}}"
 	KAS_CONTAINER_IMAGE_PATH=3D"${KAS_CONTAINER_IMAGE_PATH:-${KAS_CONTAINER_I=
MAGE_PATH_DEFAULT}}"
@@ -158,8 +198,10 @@ set_container_image_var() {
 }
=20
 KAS_WORK_DIR=3D$(readlink -fv "${KAS_WORK_DIR:-$(pwd)}")
-# KAS_WORK_DIR needs to exist for the subsequent code
-trace mkdir -p "${KAS_WORK_DIR}"
+if ! [ -d "${KAS_WORK_DIR}" ]; then
+	fatal_error "KAS_WORK_DIR '${KAS_WORK_DIR}' is not a directory"
+fi
+
 KAS_BUILD_DIR=3D$(readlink -fv "${KAS_BUILD_DIR:-${KAS_WORK_DIR}/build}")
 trace mkdir -p "${KAS_BUILD_DIR}"
=20
@@ -192,6 +234,7 @@ KAS_RUNTIME_ARGS=3D"--log-driver=3Dnone --user=3Droot"
 case "${KAS_CONTAINER_ENGINE}" in
 docker)
 	KAS_CONTAINER_COMMAND=3D"docker"
+	enable_unpriv_userns_docker
 	;;
 podman)
 	KAS_CONTAINER_COMMAND=3D"podman"
@@ -269,11 +312,6 @@ while [ $# -gt 0 ]; do
 		KAS_REPO_MOUNT_OPT=3D"rw"
 		shift 1
 		;;
-	-v | -d)
-		KAS_VERBOSE=3D1
-		KAS_OPTIONS_DIRECT=3D"${KAS_OPTIONS_DIRECT} -d"
-		shift 1
-		;;
 	-l | --log-level)
 		if [ "$2" =3D "debug" ]; then
 			KAS_VERBOSE=3D1
@@ -285,6 +323,9 @@ while [ $# -gt 0 ]; do
 		echo "${KAS_CONTAINER_SELF_NAME} $KAS_IMAGE_VERSION_DEFAULT"
 		exit 0
 		;;
+	-h | --help)
+		usage 0
+		;;
 	--*)
 		usage
 		;;
@@ -293,7 +334,7 @@ while [ $# -gt 0 ]; do
 		shift 1
 		break
 		;;
-	shell)
+	shell|lock)
 		KAS_REPO_MOUNT_OPT_DEFAULT=3D"rw"
 		KAS_CMD=3D$1
 		shift 1
@@ -459,6 +500,22 @@ set -- "$@" -v "${KAS_REPO_DIR}:/repo:${KAS_REPO_MOUNT=
_OPT}" \
 	-e KAS_BUILD_DIR=3D/build \
 	-e USER_ID=3D"$(id -u)" -e GROUP_ID=3D"$(id -g)" --rm --init
=20
+if git_com_dir=3D$(git -C "${KAS_REPO_DIR}" rev-parse --git-common-dir 2>/=
dev/null) \
+	&& [ "$git_com_dir" !=3D "$(git -C "${KAS_REPO_DIR}" rev-parse --git-dir)=
" ]; then
+	# If (it's a git repo) and the common dir isn't the git-dir, it is shared=
 worktree and
+	# we have to mount the common dir in the container to make git work
+	# The mount path inside the container is different from the host path. He=
nce, we over-mount
+	# the .git file to point to the correct path.
+	KAS_GIT_OVERLAY_FILE=3D$(mktemp)
+	sed "s|gitdir: ${git_com_dir}/|gitdir: /repo-common/|" "${KAS_REPO_DIR}/.=
git" > "${KAS_GIT_OVERLAY_FILE}"
+	set -- "$@" -v "${git_com_dir}:/repo-common:${KAS_REPO_MOUNT_OPT}" \
+		-v "${KAS_GIT_OVERLAY_FILE}:/repo/.git:ro"
+	# if the workdir is the same as the repo dir, it is the same shared workt=
ree
+	if [ "${KAS_WORK_DIR}" =3D "${KAS_REPO_DIR}" ]; then
+		set -- "$@" -v "${KAS_GIT_OVERLAY_FILE}:/work/.git:ro"
+	fi
+fi
+
 if [ -n "${KAS_SSH_DIR}" ] ; then
 	if [ ! -d "${KAS_SSH_DIR}" ]; then
 		fatal_error "passed KAS_SSH_DIR '${KAS_SSH_DIR}' is not a directory"
@@ -484,7 +541,7 @@ if [ -n "${KAS_AWS_DIR}" ] ; then
 fi
 if [ -n "${AWS_WEB_IDENTITY_TOKEN_FILE}" ] ; then
 	if [ ! -f "${AWS_WEB_IDENTITY_TOKEN_FILE}" ]; then
-		echo "Passed AWS_WEB_IDENTITY_TOKEN_FILE '${AWS_WEB_IDENTITY_TOKEN_FILE}=
' is not a directory"
+		echo "Passed AWS_WEB_IDENTITY_TOKEN_FILE '${AWS_WEB_IDENTITY_TOKEN_FILE}=
' is not a file"
 		exit 1
 	fi
 	set -- "$@" -v "$(readlink -fv "${AWS_WEB_IDENTITY_TOKEN_FILE}")":/var/ka=
s/userdata/.aws/web_identity_token:ro \
--=20
2.48.1


