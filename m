Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCF6C77B7A
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 06:34:22 +0000 (UTC)
Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 by mx.groups.io with SMTP id smtpd.web11.44246.1685342058383695354
 for <cip-dev@lists.cip-project.org>;
 Sun, 28 May 2023 23:34:18 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.141.98, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="6.00,200,1681200000"; 
   d="scan'208";a="7760134"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 28 May 2023 22:34:17 -0800
IronPort-SDR: wUiEgDO4INBC0Uw8/sRqwSeL25+m+IOOaUaEEc7VTCxM51lrfWg9EgVPFdzVnSG53VyYkt4DCT
 Mirl0JDbQR1wznev3AP8+/Y3uTn8Ch2TV9Xaud8iRtdf21/eaVEMimZi8oiZoFcInfqI57/br/
 hw0E2mwNzQi9z+i8qho3t3jBSDubxSWX3lVsLK3yf870Jutywv9IPiZgyayYJOMPXtvuoriNFH
 cp3evmAJjE2RM+RdFqNHb/uXPp5DIZNtXJFlEpftsVD3B3iuRety3DKiPvuAIpY3+KDHBrAEBg
 byY=
From: Srinuvasan Arjunan <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] kas-container: update kas to 3.2.3
Date: Mon, 29 May 2023 12:03:56 +0530
Message-ID: <20230529063356.2292070-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 May 2023 06:34:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11682

From: Srinuvasan A <srinuvasan.a@siemens.com>

Update kas-container to latest one.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 .gitlab-ci.yml |  2 +-
 kas-container  | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 6c82bb7..892ba92 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -12,7 +12,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-image: ghcr.io/siemens/kas/kas-isar:3.2.2
+image: ghcr.io/siemens/kas/kas-isar:3.2.3
 
 variables:
   GIT_STRATEGY: clone
diff --git a/kas-container b/kas-container
index cad4290..123198c 100755
--- a/kas-container
+++ b/kas-container
@@ -134,7 +134,7 @@ run_clean() {
 	fi
 }
 
-KAS_IMAGE_VERSION_DEFAULT="3.2.2"
+KAS_IMAGE_VERSION_DEFAULT="3.2.3"
 KAS_CONTAINER_IMAGE_PATH_DEFAULT="ghcr.io/siemens/kas"
 KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas"
 
@@ -411,7 +411,7 @@ if [ -n "${KAS_SSH_DIR}" ] ; then
 		echo "Passed KAS_SSH_DIR '${KAS_SSH_DIR}' is not a directory"
 		exit 1
 	fi
-	set -- "$@" -v "$(readlink -f "${KAS_SSH_DIR}")":/etc/skel/.ssh:ro
+	set -- "$@" -v "$(readlink -f "${KAS_SSH_DIR}")":/var/kas/userdata/.ssh:ro
 fi
 
 if [ -n "${KAS_SSH_AUTH_SOCK}" ]; then
@@ -428,9 +428,9 @@ if [ -n "${KAS_AWS_DIR}" ] ; then
 		echo "Passed KAS_AWS_DIR '${KAS_AWS_DIR}' is not a directory"
 		exit 1
 	fi
-	set -- "$@" -v "$(readlink -f "${KAS_AWS_DIR}")":/etc/skel/.aws:ro \
-		-e AWS_CONFIG_FILE="${AWS_CONFIG_FILE:-/etc/skel/.aws/config}" \
-		-e AWS_SHARED_CREDENTIALS_FILE="${AWS_SHARED_CREDENTIALS_FILE:-/etc/skel/.aws/credentials}"
+	set -- "$@" -v "$(readlink -f "${KAS_AWS_DIR}")":/var/kas/userdata/.aws:ro \
+		-e AWS_CONFIG_FILE="${AWS_CONFIG_FILE:-/var/kas/userdata/.aws/config}" \
+		-e AWS_SHARED_CREDENTIALS_FILE="${AWS_SHARED_CREDENTIALS_FILE:-/var/kas/userdata/.aws/credentials}"
 fi
 
 KAS_GIT_CREDENTIAL_HELPER_DEFAULT=""
@@ -440,8 +440,8 @@ if [ -n "${KAS_GIT_CREDENTIAL_STORE}" ] ; then
 		echo "Passed KAS_GIT_CREDENTIAL_STORE '${KAS_GIT_CREDENTIAL_STORE}' is not a file"
 		exit 1
 	fi
-	KAS_GIT_CREDENTIAL_HELPER_DEFAULT="store --file=/etc/skel/.git-credentials"
-	set -- "$@" -v "$(readlink -f "${KAS_GIT_CREDENTIAL_STORE}")":/etc/skel/.git-credentials:ro
+	KAS_GIT_CREDENTIAL_HELPER_DEFAULT="store --file=/var/kas/userdata/.git-credentials"
+	set -- "$@" -v "$(readlink -f "${KAS_GIT_CREDENTIAL_STORE}")":/var/kas/userdata/.git-credentials:ro
 fi
 
 GIT_CREDENTIAL_HELPER="${GIT_CREDENTIAL_HELPER:-${KAS_GIT_CREDENTIAL_HELPER_DEFAULT}}"
@@ -451,8 +451,8 @@ if [ -n "${GIT_CREDENTIAL_HELPER}" ] ; then
 fi
 
 if [ -f "${NETRC_FILE}" ]; then
-	set -- "$@" -v "$(readlink -f "${NETRC_FILE}")":/etc/skel/.netrc:ro \
-		-e NETRC_FILE="/etc/skel/.netrc"
+	set -- "$@" -v "$(readlink -f "${NETRC_FILE}")":/var/kas/userdata/.netrc:ro \
+		-e NETRC_FILE="/var/kas/userdata/.netrc"
 fi
 
 if [ -t 1 ]; then
@@ -479,7 +479,7 @@ if [ -n "${KAS_REPO_REF_DIR}" ]; then
 		exit 1
 	fi
 	set -- "$@" \
-		-v "$(readlink -f "${KAS_REPO_REF_DIR}")":/repo-ref:ro \
+		-v "$(readlink -f "${KAS_REPO_REF_DIR}")":/repo-ref:rw \
 		-e KAS_REPO_REF_DIR=/repo-ref
 fi
 
-- 
2.34.1


