Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9605.1793361356720237951
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Oct 2026 04:55:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm2 header.b=KlP9SP8p;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-1330684-20261030115554ad35c4c853000207f0-pvmjed@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20261030115554ad35c4c853000207f0
        for <cip-dev@lists.cip-project.org>;
        Fri, 30 Oct 2026 12:55:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=3V6mXWqQgnlyZJ1B9MACeZcorQJp/Xl6/OQptNKYQ3U=;
 b=KlP9SP8pEmY/36rkZAI5V6HaDHapIgSttTm29oyE1JCpWBEpxEiXsl4K4826sTGidvyzLc
 4Tgk/gT65soJ2vbHSMLEp3P+GsrVPL3zAO2pJgeZYX8j2cTrZCucIq67+Nj8sF7L3pDps+60
 880gHrSwVbegqGgOtSGMmjLxKch5k6EArtubPl9icJK3YIw1/2uBUSBe6bDVwzeLZxWXaNwK
 7dXvBhH7FO/W/ZliaMyl0IQVwoYNRCdN3TGvO91Ol2iHBZ8cJ0Oc93jF5ZLXcx4HCqW8eunI
 lobYDxntEXLJCE09zahw8gDPZbfFgxsZyfn+jFSFgJ9lbItemUWgdTEQ==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v2 1/4] sign-swu-cms: Refactor signing script to be reusable for out of build signing.
Date: Fri, 30 Oct 2026 12:55:40 +0100
Message-ID: <20261030115543.111644-2-alexander.heinisch@siemens.com>
In-Reply-To: <20261030115543.111644-1-alexander.heinisch@siemens.com>
References: <20261030115543.111644-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 30 Oct 2026 11:56:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24589
Content-Type: text/plain; charset="utf-8"

From: Alexander Heinisch <alexander.heinisch@siemens.com>

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 .../swupdate-signer/files/sign-swu-cms        | 86 ++++++++++++++++---
 1 file changed, 75 insertions(+), 11 deletions(-)
 mode change 100644 => 100755 recipes-devtools/swupdate-signer/files/sign-swu-cms

diff --git a/recipes-devtools/swupdate-signer/files/sign-swu-cms b/recipes-devtools/swupdate-signer/files/sign-swu-cms
old mode 100644
new mode 100755
index bc1ec130..686c959c
--- a/recipes-devtools/swupdate-signer/files/sign-swu-cms
+++ b/recipes-devtools/swupdate-signer/files/sign-swu-cms
@@ -1,34 +1,98 @@
-#!/bin/sh
+#!/bin/bash
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#  Alexander Heinisch <alexander.heinisch@siemens.com>
 #
 # SPDX-License-Identifier: MIT
 #
-in_file=$1
-out_file=$2
-inkey="/usr/share/swupdate-signing/swupdate-sign.key"
-cert="/usr/share/swupdate-signing/swupdate-sign.crt"
 
-error_msg() {
+set -eu
+
+default_inkey="/usr/share/swupdate-signing/swupdate-sign.key"
+default_cert="/usr/share/swupdate-signing/swupdate-sign.crt"
+
+usage() {
+	cat <<EOF
+Usage: ${0##*/} [OPTIONS] SIGNEE SIGNED
+
+Sign SIGNEE using the specified key and certificate, and write the signed output to SIGNED.
+
+Arguments:
+  SIGNEE                  Path to read the file to be signed
+  SIGNED                  Path to write the signed file
+
+Options:
+  -k, --key FILE          Private key to use for signing.
+                          Defaults to ${default_inkey}
+  -c, --cert FILE         CA certificate (chain) used to verify the produced
+                          signature before repacking.
+                          Defaults to ${default_cert}
+  -h, --help              Show this help and exit.
+EOF
+}
+
+signee=""
+signed=""
+inkey="$default_inkey"
+cert="$default_cert"
+
+bail_out() {
 	echo "$1" 1>&2
+	usage >&2
 	exit 1
 }
 
+while [[ $# -gt 0 ]]; do
+	case "$1" in
+	-h | --help)
+		usage
+		exit 0
+		;;
+	-k | --key)
+		[[ $# -ge 2 ]] || bail_out "error: $1 requires an argument"
+		inkey="$2"
+		shift 2
+		;;
+	-c | --cert)
+		[[ $# -ge 2 ]] || bail_out "error: $1 requires an argument"
+		cert="$2"
+		shift 2
+		;;
+	-*)
+		bail_out "error: unknown option: $1"
+		;;
+	*)
+		if [[ $# -eq 2 ]]; then
+			signee="${1-}"
+			signed="${2-}"
+		else
+			bail_out "error: incorrect number of arguments. Expected SIGNEE and SIGNED."
+		fi
+		break
+		;;
+	esac
+done
+
 if ! openssl rsa -check -noout -in "$inkey"; then
-	error_msg "key '$inkey' is not a rsa key"
+	bail_out "key '$inkey' is not a rsa key"
 fi
 
 if ! openssl x509 -noout -in "$cert"; then
-	error_msg  "certificate '$cert' is not a certificate"
+	bail_out "certificate '$cert' is not a certificate"
 fi
 
 key_md5=$(openssl rsa -modulus -noout -in "$inkey" | openssl md5)
 cert_md5=$(openssl x509 -modulus -noout -in "$cert" | openssl md5)
 if [ "$key_md5" != "$cert_md5" ]; then
-	error_msg "key '$inkey' does not match certificate '$cert' "
+	bail_out "key '$inkey' does not match certificate '$cert' "
 fi
 
 openssl cms \
-	-sign -in "$in_file" \
-	-out "$out_file" \
+	-sign -in "$signee" \
+	-out "$signed" \
 	-signer "$cert" \
 	-inkey "$inkey" \
 	-outform DER -noattr -binary
-- 
2.47.3

