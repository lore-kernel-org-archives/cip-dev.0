Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13329.1794490704734396099
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Nov 2026 05:38:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=heN8ADFP;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1330684-20261112133827bf7b091ce7000207c9-i29_tx@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20261112133827bf7b091ce7000207c9
        for <cip-dev@lists.cip-project.org>;
        Thu, 12 Nov 2026 14:38:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=7I3BSduDqaeWUL3vZze9tpJsTW5WQkyMYk/6vZk4tMY=;
 b=heN8ADFPcWZV6nc62HGCSqYj/JoqmOl67f6wyMmp4ku5maDLls8qmyxJVAXA1y8MEkS+iB
 0FJHcGoaSNoEcEclxdzUYL28LIJSdo1c9453DEOKkho8mbLxVa7GTnK9u5KZAf+J2nBlDdWc
 O0L9JNLps4TmKfMKbfyYr2AH1is5IZZFV3YCX3h0jeIhhP5AoVhqBg1Uyc5BxT5a7P5g9+gU
 vFeK8n4nx21ivfyL6zif67xTkMoKmbYufWDHPqlPnQGzErK4deKIkitFsR3iPbPuJm9niBYH
 UBBoNAwrmS08ZWN5uVlG4OxN3qfTmJ5TwjNms1K3BJcPuNk0WiDMNyJA==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v3 1/3] sign-swu-cms: Refactor signing script to be reusable for out of build signing.
Date: Thu, 12 Nov 2026 14:38:17 +0100
Message-ID: <20261112133819.251598-2-alexander.heinisch@siemens.com>
In-Reply-To: <20261112133819.251598-1-alexander.heinisch@siemens.com>
References: <20261112133819.251598-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2026 13:38:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24784
Content-Type: text/plain; charset="utf-8"

From: Alexander Heinisch <alexander.heinisch@siemens.com>

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 .../swupdate-signer/files/sign-swu-cms        | 84 ++++++++++++++++---
 1 file changed, 74 insertions(+), 10 deletions(-)
 mode change 100644 => 100755 recipes-devtools/swupdate-signer/files/sign-swu-cms

diff --git a/recipes-devtools/swupdate-signer/files/sign-swu-cms b/recipes-devtools/swupdate-signer/files/sign-swu-cms
old mode 100644
new mode 100755
index bc1ec130..1c67fd25
--- a/recipes-devtools/swupdate-signer/files/sign-swu-cms
+++ b/recipes-devtools/swupdate-signer/files/sign-swu-cms
@@ -1,34 +1,98 @@
 #!/bin/sh
 #
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#  Alexander Heinisch <alexander.heinisch@siemens.com>
+#
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
 
+while [ $# -gt 0 ]; do
+	case "$1" in
+	-h | --help)
+		usage
+		exit 0
+		;;
+	-k | --key)
+		[ $# -ge 2 ] || bail_out "error: $1 requires an argument"
+		inkey="$2"
+		shift 2
+		;;
+	-c | --cert)
+		[ $# -ge 2 ] || bail_out "error: $1 requires an argument"
+		cert="$2"
+		shift 2
+		;;
+	-*)
+		bail_out "error: unknown option: $1"
+		;;
+	*)
+		if [ $# -eq 2 ]; then
+			signee="$1"
+			signed="$2"
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

