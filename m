Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F60DC6379F
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 08:42:05 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.88])
 by mx.groups.io with SMTP id smtpd.web10.4216.1677055317543339414
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Feb 2023 00:41:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TbZ6xvRn;
 spf=pass (domain: siemens.com, ip: 40.107.247.88, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+MOZYP5Qufgd5++UMdRkuGbJPtlqERK3ZO7yd29ozALCx5rTCTNhfIfCnFWXb4/5azg91KbQ80UY95Qhn0L68eNyROaVR3c1w+vUFXi5cXC/Mq9rqvF6Eln/rrCsVwwIPbjsxkCXxxQGzr87NbzLecQDDB1FvD3jGBmRqwzLAxx9/Qgw76Jwrp3Q9vMrhJn2zXNmdU6ztIymCLnhT/0WfaKeyjW5WPcxLhjEE11+XHuMFNyX4BL+Snedz+K+Ts0I3hkBz/AnE3we5JFcsf4L5wM5izrg2uTlKLkUiGc0WvzR2sZhegFJlj/TUl61E81v1a0s9+zwFHdFmFHJeS8kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKByOrSSf2XvxZZI040zbrAaR58KsJPvBprAqxAkBLc=;
 b=Z+OrM+c+aRVcIAGqc1njMczK3/xkCQ5EKm254g2Lt7Wneeq806tTphFSN8bZfDOUZAhXQbarNXKoaJ+Cwxp0aocfA7VRrNhGqNN1ieLly2a3KDqrRh0P8RzoEOtdtgjfr9SUdBv6VF9rlieW2Syug4Td0cZ7bf5VrQZGjmZV+WSjKqiuEO2IsAo/1JeYs2nsmmChXRNX6OtSayVRaj0MWoWNU77e86D9+EoiMLqPkgJW+pEbb6kECemOs4o/GWt8HVEp9Ij0cKMMp6Vdm0R0BHwFKFunEt9/O2KaroY+LwSPQn/KcFEGiEcavJokHlH5UOxtM9JtsaifvasSb6QQyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKByOrSSf2XvxZZI040zbrAaR58KsJPvBprAqxAkBLc=;
 b=TbZ6xvRnB7basgyg4j4NAawHVhEffLmaW+vKshcJennuUHfd08fL68MbOqVo2bFYApDpUT32cPNPIEUF+Otq0OCheHzsfUM0FZp/04u6TjoE25zYT85SOK0jstl3UFiHZ3xyfieYLnHmfKoJkv+KY2lehKvrQCKLOIbjX2qrMs9r9j3byDzqG00bCpT+GsSWOhZG7HO+Mbhzx8vOeqSEn5mRAgLNVu/jYYtW8CsxfhGO+NwCNmaVPeZy97d/ikEBmjA4h/6EnCnSaZTVBXMw3yT05l1pu0UV80b6zR0jxiHUHe/gegDJrROnk73j3z5dvJLbeB9JTWZGmUT406/XBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5544.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:242::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Wed, 22 Feb
 2023 08:41:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 08:41:54 +0000
Message-ID: <508d9c06-3dcb-5b7c-659f-8c5c788d4e5a@siemens.com>
Date: Wed, 22 Feb 2023 09:41:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] Update to kas 3.2.2, embedded kas-container
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5544:EE_
X-MS-Office365-Filtering-Correlation-Id: 146d354d-5e6c-4928-cc79-08db14b0a660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dYiSCouRPjuDx8tJGJmQqO7wLKN7jPpeyb9pyXNG0aJJrwBuTXysvxA6OGXqWX1OO+vLZqpZc3EHPdeG0bVucm0vb5ckoXITHrQC7bSos6fv6T9Qu3KeZudmY00rG1PgYxED6oomOzxJn7TssBPO1Fc8LRqD7X/qHY98/rovJMe/rqhPLsKGPGXVlP+cT30sE2ZSESfoyk9LC5mXtFy9pxua++8qAzsyl8S2SBdAOPaMI/KgQVi7Goct2TLVD/rCnzlNLwCSdUAgF0qQ6RSz8qfKNQg9RYeeJ94ZA92YrumuM5JzexJPOHiNkEJDYPlNJ0uf7Tcb6HhRLlyvRLrDZR+1H71BgUzJpZog7ODpC/0c+gAl9MSAOtTGGsX9giekzW0RuZvm1ZIDCXP9cH4i6vo3hw7JGfGAcWrC50+Rh6fgSFfVSV0yIGxHEIplQv2o8fMeT16H7NF7uxq6NbsO7ukzIonMtfuu13IC6SR3jycA7H7n8ROJaA3fCNddLiupxV66bRQXvzTo/Z1owCZlrLviU+p4hcflXIsg5nlM/X1QV3pOP5jkmqmPvkNy++mTPYihSYWCBhQy4AIQRajP0BTwGh1NGV/ZEgRl2ers/4fDIh5rwNww8Gu6HQw2f4jtpTe7+0WT6RNnvzYex1uOwMm+q26G7hXeyxWgVFVlInDlqb3dCxF4Mwv9WtuLx+t22WtVxuucmKxfFqyfU6io6LYo37YXk3Kwtc/siM7S854p4Ie+jgbSoESf4tF3zpdv
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199018)(84970400001)(31686004)(86362001)(36756003)(31696002)(966005)(26005)(2906002)(6486002)(15650500001)(186003)(6512007)(38100700002)(82960400001)(66899018)(83380400001)(66946007)(8936002)(6506007)(66476007)(41300700001)(8676002)(478600001)(30864003)(44832011)(6916009)(66556008)(2616005)(6666004)(5660300002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V1VFdjRhZFNNOC9rdU9jQXFQTnBXWS9aQXlBOXArQ3ZOY0FGMlc5Z1NsR0NW?=
 =?utf-8?B?Kysvc0gyakFCdm1OOGN0c0RYMExGeHBMdzZuNTRFSWFiRFJnNUkxeTNScXZ0?=
 =?utf-8?B?VEhrbU1pakxBMEF3UkIveDMrakpHeGczN2tEUm5SQ09xeU52Y0sxTEp4RWQ5?=
 =?utf-8?B?Vk5IdktaTWN6VERQaUFydmoxOUorSmpuYUxnellzd3l1Q21IcmFrTjlDZzMx?=
 =?utf-8?B?eXU5UUk5d20vakt6VWFjT3h2M2NTZmtidG1KYkRXRFd1UzV6WWoxZ0ZVa3FG?=
 =?utf-8?B?TDBSaElRZ3VQeVNtVFJVZXBqdWwreUJqMUhFalpYWk5GVE9neHRRMGJPVzVu?=
 =?utf-8?B?dHcrRThMOW1BYUNUaUdBbzdnNVFWMENZUXVycE5JVHlqY0dhSitydW0zcnBz?=
 =?utf-8?B?M0hpcTdEdFJBRGszUjNiV2dMMTBmV0g2eDNQZDBjM0lBTUpZVXNaWEplYmpP?=
 =?utf-8?B?OGxNWHV3SmNnVjRJWlRock01T1BReUNKTUI0V0FVbGNTSTRDRmVQN0kvT1ZC?=
 =?utf-8?B?UE02ZHFlbHdOQU0yVkhZZ1VaRVRFUlZRREFLOURiZ0JncDk4bDBtZnJYb0hL?=
 =?utf-8?B?d0hUcFJMZWVCeU5vSlduanNwME5vYUNqMmlKZkd6amV3eEkwRzd3c3Z1dm0z?=
 =?utf-8?B?M3pqQnA0VGgrUy9qVFFiKzl3NkZKZVZXTGlBMm5uVlBaa0NZOW04QmxRZ2F0?=
 =?utf-8?B?YVJGTmxIL0ZNYm5WSkxWMGxvZjhEaURTYzZqa1ZoeDVmSFVJYVNockdQZE1V?=
 =?utf-8?B?bGNZdmdGUHNNMnRpZjV0ZkllUzg2UWpLeGxTazEvUjdpa1hLQW81SEZMT2pP?=
 =?utf-8?B?MXJzL3V1UlpyUy91b0V2NWViZ1JtcnI0TnpDcjFtK0JWa05QOGwyMjBzdENU?=
 =?utf-8?B?K2NGVjJRYXM1R1AxU0ZwWEMvMzBaelNTL2NlL0RYMDhiRWJuQTlxRlEwVUxD?=
 =?utf-8?B?ay94ek1rVDFqV0lvc2U2MzNnMGd5UC96ZnZtQ3pKN0VQM1c4bmQxRzZ5Mkcr?=
 =?utf-8?B?R3JOUGZUM2dJTnZBVE4yWHBSNHFLRHVyaVJDMGEzcnExWjNWZzlJa1J6OFpa?=
 =?utf-8?B?dzd3Y0NTKzNCdkE3bVFId0xKTHQ1dUpidHR0eHBHb0t6bzhoYkc3S1VTMGdx?=
 =?utf-8?B?UTlnRXp3WXFVT3YwOEwwMVVLVDdZRFRRelVCeFo4MmdTeVRPaFpPV0FEMEtn?=
 =?utf-8?B?U1dEMHlNc0MrdE1rUDExQzBJY2NyUnNUa3ZvbDN3c3hhWDA3aVdKd2tmcUt2?=
 =?utf-8?B?dXZ6MUNocEdCalh2MHVxU2hVdmhZN0l5Y2VmbGlIVFJzRlI3ZUxmdTJrbG1n?=
 =?utf-8?B?Lys3Nk5iWDd5V2JYSDdKc1ErTm9mQWRyYU9TczhUMnR4SnRmTEsyazRFRG1Z?=
 =?utf-8?B?bHhzTmFXYVVKNmtJb3hsWnZaS2ROM1BVRTJWUlRJVnV2d2QwcStmenppTk5J?=
 =?utf-8?B?cWpkcmJab3pMdXkzUkNRa2ZhSTg4QXNFSUUyd01FWDEycWQzcm1VZHpUQjZq?=
 =?utf-8?B?blltbHZJVWlPVVNYTDZtRUs2L051bjg3YW5qUWRUWXZiK2NBOHk2aDdrQ1pl?=
 =?utf-8?B?RHpQUzNVSGNOVk80SnBmOUFrMEVTTGxuOUpaTnJCUzQzVVZTN0w4OGZzazlT?=
 =?utf-8?B?M2dJM0RiSTRyRkl0ZFcxLzBiU1NZWVFER0JHakN1Yzl5M0RTZGkveTYzN3lQ?=
 =?utf-8?B?cnhoTkc5K1FOMDMyYkszQVJCak9XcjJFOUJWMEcramtLdjVzeTVOcHhqY01k?=
 =?utf-8?B?djlqZ2d5eStXb3JweHE5N0FEcFVVS1M1em5uYkpOZGhNK05BQkkwRW5vMU5Q?=
 =?utf-8?B?TXN3NUtBeEIwdVdhTEtMWnZ0RmladzZ1cXBpNnpXRFRsVGc3NWk3MTBPbUZN?=
 =?utf-8?B?aHcxcmhrbVZnRmRkbE9kREtCVFgzZmgyaHdHaGcwQ2dwamN4aDJIL1BCMjRC?=
 =?utf-8?B?QWhvV1RzNDJweWpBYUdyVmVjUnprMGZldnFFN00rbEdaUmhjanFaSlZVZ1ZO?=
 =?utf-8?B?QjNvTFFwWFRJQ29hVjdrMUFKVVJ2NmFuQjc3TmhuL05nc1JhRjZCZ3dnYm1h?=
 =?utf-8?B?UFNNSjBweUJqN2FWc3lhTnN1a2pqS3hyNFR0U25xTFRVVUdtQkZQblY2b0lt?=
 =?utf-8?B?V1VCY2RSVUxSV2RHRmZjL01UYm1ZZUhMc3BXNDVJbnFLYVRkK2hiaDhscFJX?=
 =?utf-8?B?clE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146d354d-5e6c-4928-cc79-08db14b0a660
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 08:41:54.2311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1/7r54rInGKjWFnyxSflmxkDZ3SWXSY65bTmPSkxEB520nCHS3ZvHaBsCpjjKedTAFRrlLTl0lS9y1Tl35KCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5544
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Feb 2023 08:42:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10772

From: Jan Kiszka <jan.kiszka@siemens.com>

This changes to the installation procedure for kas-container from
"download first" (which lacked validation) to "already embedded", like
done now in many other layers. The README is updated, also now
explaining the required configuration steps.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitignore     |   2 -
 .gitlab-ci.yml |   2 +-
 README.md      |  11 +-
 kas-container  | 533 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 538 insertions(+), 10 deletions(-)
 create mode 100755 kas-container

diff --git a/.gitignore b/.gitignore
index 949a7104..c657e77b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,6 +1,4 @@
 build/
 isar/
-kas-docker
-kas-container
 __pycache__
 .config.yaml*
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index f7c8c889..777840b6 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,4 +1,4 @@
-image: ghcr.io/siemens/kas/kas-isar:3.1
+image: ghcr.io/siemens/kas/kas-isar:3.2.2
 
 variables:
   GIT_STRATEGY: clone
diff --git a/README.md b/README.md
index e30ff3a6..4ded924a 100644
--- a/README.md
+++ b/README.md
@@ -10,13 +10,10 @@ from scratch.
 
 ## Building Target Images
 
-Install `kas-container` from the [kas project](https://github.com/siemens/kas):
-
-    wget https://raw.githubusercontent.com/siemens/kas/3.1/kas-container
-    chmod a+x kas-container
-
-Furthermore, install docker and make sure you have required permissions to
-start containers.
+Install docker or podman and make sure you have required permissions to start
+privileged containers. For docker, you need to be part of respective docker
+group (`sudo usermod -aG docker <USER>`). Privileged podman requires sudo
+rights for the caller (`<USER> ALL=(root) SETENV: /usr/bin/podman` in sudoers).
 
 Open up the image configuration menu and select the desired target and its
 options:
diff --git a/kas-container b/kas-container
new file mode 100755
index 00000000..cad4290f
--- /dev/null
+++ b/kas-container
@@ -0,0 +1,533 @@
+#!/bin/sh
+#
+# kas - setup tool for bitbake based projects
+#
+# Copyright (c) Siemens AG, 2018-2022
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# Permission is hereby granted, free of charge, to any person obtaining a copy
+# of this software and associated documentation files (the "Software"), to deal
+# in the Software without restriction, including without limitation the rights
+# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+# copies of the Software, and to permit persons to whom the Software is
+# furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be
+# included in all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+# SOFTWARE.
+
+set -e
+
+usage()
+{
+	printf "%b" "Usage: $0 [OPTIONS] { build | shell } [KASOPTIONS] [KASFILE]\n"
+	printf "%b" "       $0 [OPTIONS] { checkout | dump } [KASOPTIONS] [KASFILE]\n"
+	printf "%b" "       $0 [OPTIONS] for-all-repos [KASOPTIONS] [KASFILE] COMMAND\n"
+	printf "%b" "       $0 [OPTIONS] { clean | cleansstate | cleanall}\n"
+	printf "%b" "       $0 [OPTIONS] menu [KCONFIG]\n"
+	printf "%b" "\nPositional arguments:\n"
+	printf "%b" "build\t\t\tCheck out repositories and build target.\n"
+	printf "%b" "checkout\t\tCheck out repositories but do not build.\n"
+	printf "%b" "dump\t\t\tCheck out repositories and write flat version\n"
+	printf "%b" "    \t\t\tof config to stdout.\n"
+	printf "%b" "shell\t\t\tRun a shell in the build environment.\n"
+	printf "%b" "for-all-repos\t\tRun specified command in each repository.\n"
+	printf "%b" "clean\t\t\tClean build artifacts, keep sstate cache and " \
+		    "downloads.\n"
+	printf "%b" "cleansstate\t\tClean build artifacts and sstate cache, " \
+		    "keep downloads.\n"
+	printf "%b" "cleanall\t\tClean build artifacts, sstate cache and " \
+		    "downloads.\n"
+	printf "%b" "menu\t\t\tProvide configuration menu and trigger " \
+		    "configured build.\n"
+	printf "%b" "\nOptional arguments:\n"
+	printf "%b" "--isar\t\t\tUse kas-isar container to build Isar image.\n"
+	printf "%b" "--with-loop-dev		Pass a loop device to the " \
+		    "container. Only required if\n"
+	printf "%b" "\t\t\tloop-mounting is used by recipes.\n"
+	printf "%b" "--runtime-args\t\tAdditional arguments to pass to the " \
+			"container runtime\n"
+	printf "%b" "\t\t\tfor running the build.\n"
+	printf "%b" "-d\t\t\tPrint debug output.\n"
+	printf "%b" "-v\t\t\tSame as -d (deprecated).\n"
+	printf "%b" "--version\t\tprint program version.\n"
+	printf "%b" "--ssh-dir\t\tDirectory containing SSH configurations.\n"
+	printf "%b" "\t\t\tAvoid \$HOME/.ssh unless you fully trust the " \
+		    "container.\n"
+	printf "%b" "--ssh-agent\t\tForward ssh-agent socket to the container.\n"
+	printf "%b" "--aws-dir\t\tDirectory containing AWScli configuration.\n"
+	printf "%b" "--git-credential-store\tFile path to the git credential " \
+		    "store\n"
+	printf "%b" "--no-proxy-from-env\tDo not inherit proxy settings from " \
+		    "environment.\n"
+	printf "%b" "--repo-ro\t\tMount current repository read-only\n" \
+		    "\t\t\t(default for build command)\n"
+	printf "%b" "--repo-rw\t\tMount current repository writeable\n" \
+		    "\t\t\t(default for shell command)\n"
+	printf "%b" "\n"
+	printf "%b" "You can force the use of podman over docker using " \
+		    "KAS_CONTAINER_ENGINE=podman.\n"
+	exit 1
+}
+
+trace()
+{
+	[ -n "${KAS_VERBOSE}" ] && echo "+ $*" >&2
+	"$@"
+}
+
+enable_isar_mode() {
+	if [ -n "${ISAR_MODE}" ]; then
+		return
+	fi
+	ISAR_MODE=1
+
+	KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas-isar"
+	KAS_ISAR_ARGS="--privileged"
+
+	if [ "${KAS_CONTAINER_ENGINE}" = "podman" ]; then
+		# sudo is needed for a privileged podman container
+		KAS_CONTAINER_COMMAND="sudo --preserve-env ${KAS_CONTAINER_COMMAND}"
+		# preserved user PATH may lack sbin needed by privileged podman
+		export PATH="${PATH}:/usr/sbin"
+	fi
+}
+
+enable_oe_mode() {
+	if [ "${KAS_CONTAINER_ENGINE}" = "podman" ]; then
+		# The container entry point expects that the current userid
+		# calling "podman run" has a 1:1 mapping
+		KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} --userns=keep-id"
+	fi
+}
+
+run_clean() {
+	if [ -n "${KAS_ISAR_ARGS}" ]; then
+		set_container_image_var
+		# SC2086: Double quote to prevent globbing and word splitting.
+		# shellcheck disable=2086
+		trace ${KAS_CONTAINER_COMMAND} run -v "${KAS_BUILD_DIR}":/build:rw \
+				--workdir=/build --rm ${KAS_ISAR_ARGS} \
+				${KAS_CONTAINER_IMAGE} \
+				sudo rm -rf tmp
+	else
+		trace rm -rf "${KAS_BUILD_DIR}/tmp"
+	fi
+
+	if [ "$1" != "clean" ]; then
+		SSTATE_DIR=${SSTATE_DIR:-${KAS_BUILD_DIR}/sstate-cache}
+		trace rm -rf "${SSTATE_DIR}"
+
+		if [ "$1" = "cleanall" ]; then
+			DL_DIR=${DL_DIR:-${KAS_BUILD_DIR}/downloads}
+			trace rm -rf "${DL_DIR}"
+		fi
+	fi
+}
+
+KAS_IMAGE_VERSION_DEFAULT="3.2.2"
+KAS_CONTAINER_IMAGE_PATH_DEFAULT="ghcr.io/siemens/kas"
+KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas"
+
+set_container_image_var() {
+	KAS_IMAGE_VERSION="${KAS_IMAGE_VERSION:-${KAS_IMAGE_VERSION_DEFAULT}}"
+	KAS_CONTAINER_IMAGE_NAME="${KAS_CONTAINER_IMAGE_NAME:-${KAS_CONTAINER_IMAGE_NAME_DEFAULT}}"
+	KAS_CONTAINER_IMAGE_PATH="${KAS_CONTAINER_IMAGE_PATH:-${KAS_CONTAINER_IMAGE_PATH_DEFAULT}}"
+	KAS_CONTAINER_IMAGE_DEFAULT="${KAS_CONTAINER_IMAGE_PATH}/${KAS_CONTAINER_IMAGE_NAME}:${KAS_IMAGE_VERSION}"
+	KAS_CONTAINER_IMAGE="${KAS_CONTAINER_IMAGE:-${KAS_CONTAINER_IMAGE_DEFAULT}}"
+}
+
+KAS_WORK_DIR=$(readlink -f "${KAS_WORK_DIR:-$(pwd)}")
+# KAS_WORK_DIR needs to exist for the subsequent code
+trace mkdir -p "${KAS_WORK_DIR}"
+KAS_BUILD_DIR=$(readlink -f "${KAS_BUILD_DIR:-${KAS_WORK_DIR}/build}")
+trace mkdir -p "${KAS_BUILD_DIR}"
+
+KAS_CONTAINER_ENGINE="${KAS_CONTAINER_ENGINE:-${KAS_DOCKER_ENGINE}}"
+if [ -z "${KAS_CONTAINER_ENGINE}" ]; then
+	# Try to auto-detect a container engine
+	if command -v docker >/dev/null; then
+		case $(docker -v 2>/dev/null) in
+		podman*)
+			# The docker command is an alias for podman
+			KAS_CONTAINER_ENGINE=podman
+			;;
+		Docker*)
+			# The docker command is the real docker
+			KAS_CONTAINER_ENGINE=docker
+			;;
+		*)
+			# The docker command is an unknown engine
+			echo "$0: docker command found, but unknown engine detected" >&2
+			exit 1
+		esac
+	elif command -v podman >/dev/null; then
+		KAS_CONTAINER_ENGINE=podman
+	else
+		echo "$0: no container engine found, need docker or podman" >&2
+		exit 1
+	fi
+fi
+
+KAS_RUNTIME_ARGS="--log-driver=none --user=root"
+
+case "${KAS_CONTAINER_ENGINE}" in
+docker)
+	KAS_CONTAINER_COMMAND="docker"
+	;;
+podman)
+	KAS_CONTAINER_COMMAND="podman"
+	KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} --security-opt label=disable"
+	;;
+*)
+	echo "$0: unknown container engine '${KAS_CONTAINER_ENGINE}'" >&2
+	exit 1
+	;;
+esac
+
+# parse kas-container options
+while [ $# -gt 0 ]; do
+	case "$1" in
+	--isar)
+		enable_isar_mode
+		shift 1
+		;;
+	--with-loop-dev)
+		if ! KAS_LOOP_DEV=$(/sbin/losetup -f 2>/dev/null); then
+			if [ "$(id -u)" -eq 0 ]; then
+				echo "Error: loop device not available!"
+				exit 1
+			fi
+			sudo_command="/sbin/losetup -f"
+			sudo_message="[sudo] enter password to setup loop"
+			sudo_message="$sudo_message devices by calling"
+			sudo_message="$sudo_message '$sudo_command': "
+			# SC2086: Double quote to prevent globbing and word splitting.
+			# shellcheck disable=2086
+			if ! KAS_LOOP_DEV=$(sudo -p "$sudo_message" $sudo_command \
+				2>/dev/null); then
+				echo "Error: loop device setup unsuccessful!"
+				echo "try calling '$sudo_command' with root" \
+					"permissions manually."
+				exit 1
+			fi
+		fi
+		KAS_WITH_LOOP_DEV="--device ${KAS_LOOP_DEV}"
+		shift 1
+		;;
+	--runtime-args|--docker-args)
+		[ $# -gt 0 ] || usage
+		KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} $2"
+		shift 2
+		;;
+	--ssh-dir)
+		[ $# -gt 2 ] || usage
+		KAS_SSH_DIR="$2"
+		shift 2
+		;;
+	--ssh-agent)
+		KAS_SSH_AUTH_SOCK=$(readlink -f "$SSH_AUTH_SOCK")
+		shift 1
+		;;
+	--aws-dir)
+		[ $# -gt 2 ] || usage
+		KAS_AWS_DIR="$2"
+		shift 2
+		;;
+	--git-credential-store)
+		[ $# -gt 2 ] || usage
+		KAS_GIT_CREDENTIAL_STORE="$2"
+		shift 2
+		;;
+	--no-proxy-from-env)
+		KAS_NO_PROXY_FROM_ENV=1
+		shift 1
+		;;
+	--repo-ro)
+		KAS_REPO_MOUNT_OPT="ro"
+		shift 1
+		;;
+	--repo-rw)
+		KAS_REPO_MOUNT_OPT="rw"
+		shift 1
+		;;
+	-v | -d)
+		KAS_VERBOSE=1
+		KAS_OPTIONS_DIRECT="${KAS_OPTIONS_DIRECT} -d"
+		shift 1
+		;;
+	--version)
+		echo "$(basename "$0") $KAS_IMAGE_VERSION_DEFAULT"
+		exit 0
+		;;
+	--*)
+		usage
+		;;
+	clean|cleansstate|cleanall)
+		[ $# -eq 1 ] || usage
+		run_clean "$1"
+		exit 0
+		;;
+	shell)
+		KAS_REPO_MOUNT_OPT_DEFAULT="rw"
+		KAS_CMD=$1
+		shift 1
+		break
+		;;
+	build|checkout|dump|for-all-repos|menu)
+		KAS_REPO_MOUNT_OPT_DEFAULT="ro"
+		KAS_CMD=$1
+		shift 1
+		break
+		;;
+	*)
+		usage
+		;;
+	esac
+done
+
+[ -n "${KAS_CMD}" ] || usage
+
+KAS_EXTRA_BITBAKE_ARGS=0
+
+# parse kas sub-command options
+while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
+	case "$1" in
+	-h|--help)
+		set_container_image_var
+		# SC2086: Double quote to prevent globbing and word splitting.
+		# shellcheck disable=2086
+		trace ${KAS_CONTAINER_COMMAND} run ${KAS_CONTAINER_IMAGE} ${KAS_CMD} --help
+		exit 0
+		;;
+	--skip|--target|--task)
+		KAS_OPTIONS="${KAS_OPTIONS} $1 $2"
+		shift 2
+		;;
+	-c|--cmd|--command)
+		KAS_BITBAKE_C_OPTION_ARGS="$2"
+		shift 2
+		;;
+	-E|--preserve-env)
+		echo "$1 is not supported with kas-container"
+		exit 1
+		;;
+	--)
+		KAS_EXTRA_BITBAKE_ARGS=$#
+		;;
+	-*)
+		KAS_OPTIONS="${KAS_OPTIONS} $1"
+		shift 1
+		;;
+	*)
+		KAS_FILES=
+		# SC2086: Double quote to prevent globbing and word splitting.
+		# shellcheck disable=2086
+		for FILE in $(IFS=':'; echo $1); do
+			if ! KAS_REAL_FILE="$(realpath -qe "$FILE")"; then
+				echo "Error: configuration file '${FILE}' not found"
+				exit 1
+			fi
+			if [ -z "${KAS_FILES}" ]; then
+				KAS_FIRST_FILE="${KAS_REAL_FILE}"
+				KAS_FILES="${KAS_REAL_FILE}"
+			else
+				KAS_FILES="${KAS_FILES}:${KAS_REAL_FILE}"
+			fi
+		done
+		shift 1
+		if [ "$KAS_CMD" = "for-all-repos" ]; then
+			KAS_REPO_CMD="$1"
+			shift 1
+		fi
+		;;
+	esac
+done
+
+if [ -n "${KAS_FIRST_FILE}" ]; then
+	KAS_FILE_DIR="$(dirname "${KAS_FIRST_FILE}")"
+	KAS_REPO_DIR=$(git -C "${KAS_FILE_DIR}" rev-parse --show-toplevel 2>/dev/null) \
+		|| KAS_REPO_DIR=$(hg --cwd "${KAS_FILE_DIR}" root 2>/dev/null) \
+		|| KAS_REPO_DIR=${KAS_FILE_DIR}
+else
+	KAS_REPO_DIR=$(pwd)
+fi
+
+if [ "${KAS_CMD}" = "menu" ]; then
+	if [ -z "${KAS_FIRST_FILE}" ]; then
+		KAS_FIRST_FILE="Kconfig"
+	fi
+
+	BUILD_SYSTEM=$(tr '\n' '\f' 2>/dev/null < ${KAS_FIRST_FILE} | \
+		sed -e 's/\(.*\fconfig KAS_BUILD_SYSTEM\f\(.*\)\|.*\)/\2/' \
+		    -e 's/\f\([[:alpha:]].*\|$\)//' \
+		    -e 's/.*default \"\(.*\)\".*/\1/')
+else
+	if [ -z "${KAS_FIRST_FILE}" ]; then
+		KAS_FIRST_FILE="${KAS_WORK_DIR}/.config.yaml"
+	fi
+
+	BUILD_SYSTEM=$(grep -e "^build_system: " "${KAS_FIRST_FILE}" 2>/dev/null | \
+		sed 's/build_system:[ ]\+//')
+fi
+
+if [ "${BUILD_SYSTEM}" = "isar" ]; then
+	enable_isar_mode
+else
+	enable_oe_mode
+fi
+
+set_container_image_var
+
+KAS_REPO_MOUNT_OPT="${KAS_REPO_MOUNT_OPT:-${KAS_REPO_MOUNT_OPT_DEFAULT}}"
+
+KAS_FILES="$(echo "${KAS_FILES}" | sed 's|'"${KAS_REPO_DIR}"'/|/repo/|g')"
+
+if [ "$(id -u)" -eq 0 ] && [ "${KAS_ALLOW_ROOT}" != "yes" ] ; then
+	echo "Error: Running as root - may break certain recipes."
+	echo "Better give a regular user docker access. Set" \
+	     "KAS_ALLOW_ROOT=yes to override."
+	exit 1
+fi
+
+set -- "$@" -v "${KAS_REPO_DIR}":/repo:${KAS_REPO_MOUNT_OPT} \
+	-v "${KAS_WORK_DIR}":/work:rw -e KAS_WORK_DIR=/work \
+	-v "${KAS_BUILD_DIR}":/build:rw \
+	--workdir=/repo \
+	-e KAS_BUILD_DIR=/build \
+	-e USER_ID="$(id -u)" -e GROUP_ID="$(id -g)" --rm --init
+
+if [ -n "${KAS_SSH_DIR}" ] ; then
+	if [ ! -d "${KAS_SSH_DIR}" ]; then
+		echo "Passed KAS_SSH_DIR '${KAS_SSH_DIR}' is not a directory"
+		exit 1
+	fi
+	set -- "$@" -v "$(readlink -f "${KAS_SSH_DIR}")":/etc/skel/.ssh:ro
+fi
+
+if [ -n "${KAS_SSH_AUTH_SOCK}" ]; then
+	if [ ! -S "${KAS_SSH_AUTH_SOCK}" ]; then
+		echo "Passed SSH_AUTH_SOCK '${KAS_SSH_AUTH_SOCK}' is not a socket"
+		exit 1
+	fi
+	set -- "$@" -v "${KAS_SSH_AUTH_SOCK}":/ssh-agent/ssh-auth-sock \
+		-e SSH_AUTH_SOCK=/ssh-agent/ssh-auth-sock
+fi
+
+if [ -n "${KAS_AWS_DIR}" ] ; then
+	if [ ! -d "${KAS_AWS_DIR}" ]; then
+		echo "Passed KAS_AWS_DIR '${KAS_AWS_DIR}' is not a directory"
+		exit 1
+	fi
+	set -- "$@" -v "$(readlink -f "${KAS_AWS_DIR}")":/etc/skel/.aws:ro \
+		-e AWS_CONFIG_FILE="${AWS_CONFIG_FILE:-/etc/skel/.aws/config}" \
+		-e AWS_SHARED_CREDENTIALS_FILE="${AWS_SHARED_CREDENTIALS_FILE:-/etc/skel/.aws/credentials}"
+fi
+
+KAS_GIT_CREDENTIAL_HELPER_DEFAULT=""
+
+if [ -n "${KAS_GIT_CREDENTIAL_STORE}" ] ; then
+	if [ ! -f "${KAS_GIT_CREDENTIAL_STORE}" ]; then
+		echo "Passed KAS_GIT_CREDENTIAL_STORE '${KAS_GIT_CREDENTIAL_STORE}' is not a file"
+		exit 1
+	fi
+	KAS_GIT_CREDENTIAL_HELPER_DEFAULT="store --file=/etc/skel/.git-credentials"
+	set -- "$@" -v "$(readlink -f "${KAS_GIT_CREDENTIAL_STORE}")":/etc/skel/.git-credentials:ro
+fi
+
+GIT_CREDENTIAL_HELPER="${GIT_CREDENTIAL_HELPER:-${KAS_GIT_CREDENTIAL_HELPER_DEFAULT}}"
+
+if [ -n "${GIT_CREDENTIAL_HELPER}" ] ; then
+	set -- "$@" -e GIT_CREDENTIAL_HELPER="${GIT_CREDENTIAL_HELPER}"
+fi
+
+if [ -f "${NETRC_FILE}" ]; then
+	set -- "$@" -v "$(readlink -f "${NETRC_FILE}")":/etc/skel/.netrc:ro \
+		-e NETRC_FILE="/etc/skel/.netrc"
+fi
+
+if [ -t 1 ]; then
+	set -- "$@" -t -i
+fi
+
+if [ -n "${DL_DIR}" ]; then
+	trace mkdir -p "${DL_DIR}"
+	set -- "$@" \
+		-v "$(readlink -f "${DL_DIR}")":/downloads:rw \
+		-e DL_DIR=/downloads
+fi
+
+if [ -n "${SSTATE_DIR}" ]; then
+	trace mkdir -p "${SSTATE_DIR}"
+	set -- "$@" \
+		-v "$(readlink -f "${SSTATE_DIR}")":/sstate:rw \
+		-e SSTATE_DIR=/sstate
+fi
+
+if [ -n "${KAS_REPO_REF_DIR}" ]; then
+	if [ ! -d "${KAS_REPO_REF_DIR}" ]; then
+		echo "Passed KAS_REPO_REF_DIR '${KAS_REPO_REF_DIR}' is not a directory"
+		exit 1
+	fi
+	set -- "$@" \
+		-v "$(readlink -f "${KAS_REPO_REF_DIR}")":/repo-ref:ro \
+		-e KAS_REPO_REF_DIR=/repo-ref
+fi
+
+for var in TERM KAS_DISTRO KAS_MACHINE KAS_TARGET KAS_TASK \
+           KAS_PREMIRRORS DISTRO_APT_PREMIRRORS BB_NUMBER_THREADS PARALLEL_MAKE; do
+	if [ -n "$(eval echo \$${var})" ]; then
+		set -- "$@" -e "${var}=$(eval echo \"\$${var}\")"
+	fi
+done
+
+# propagate only supported SHELL settings
+case "$SHELL" in
+/bin/sh|/bin/bash|/bin/dash)
+	set -- "$@" -e "SHELL=$SHELL"
+	;;
+*)
+	set -- "$@" -e "SHELL=/bin/bash"
+	;;
+esac
+
+if [ -z "${KAS_NO_PROXY_FROM_ENV+x}" ]; then
+	for var in http_proxy https_proxy ftp_proxy no_proxy NO_PROXY; do
+		if [ -n "$(eval echo \$${var})" ]; then
+			set -- "$@" -e "${var}=$(eval echo \$${var})"
+		fi
+	done
+fi
+
+# SC2086: Double quote to prevent globbing and word splitting.
+# shellcheck disable=2086
+set -- "$@" ${KAS_ISAR_ARGS} ${KAS_WITH_LOOP_DEV} ${KAS_RUNTIME_ARGS} \
+    ${KAS_CONTAINER_IMAGE} ${KAS_OPTIONS_DIRECT} ${KAS_CMD} ${KAS_OPTIONS}
+if [ -n "${KAS_BITBAKE_C_OPTION_ARGS}" ]; then
+	set -- "$@" -c "${KAS_BITBAKE_C_OPTION_ARGS}"
+fi
+# SC2086: Double quote to prevent globbing and word splitting.
+# shellcheck disable=2086
+set -- "$@" ${KAS_FILES}
+if [ "$KAS_CMD" = "for-all-repos" ]; then
+	set -- "$@" "${KAS_REPO_CMD}"
+fi
+
+# rotate any extra bitbake args from the front to the end of the argument list
+while [ $KAS_EXTRA_BITBAKE_ARGS -gt 0 ]; do
+	arg="$1"
+	shift 1
+	set -- "$@" "$arg"
+	KAS_EXTRA_BITBAKE_ARGS=$((KAS_EXTRA_BITBAKE_ARGS - 1))
+done
+
+trace ${KAS_CONTAINER_COMMAND} run "$@"
-- 
2.35.3

