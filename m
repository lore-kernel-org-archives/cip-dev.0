Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13302.1794490712371485795
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Nov 2026 05:38:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=d0dhkIix;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1330684-202611121338307b3fb61bea0002079d-j9jlwa@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202611121338307b3fb61bea0002079d
        for <cip-dev@lists.cip-project.org>;
        Thu, 12 Nov 2026 14:38:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=VlmLkqUOiVI1EOTVLkUngwbH4qCkskN7PVunWa1iC5U=;
 b=d0dhkIixfbC5tPAeuazvw75L58iayL0sbwylBgwvnJJwEbDy6OxCG1RW9VV2EzbRmoFXOc
 8WARuXV/A0vaPtHdkd8tL0+WilPcmmVhO0/5hUoHzuzUg0jkrHCRyzjbQhGNR7WbqJ+ezVWk
 xL8xSJVNCh9oyNiDF6NGnCPTqFFnBQijvecqzEdwsWqSraqj3fVgh/atb85tmTG1fOz23yNL
 OASegX1w+XUMWSEHDRpwqQIkopxc4Y/XvW1Wk02dW+5gj7nGjMSKmTfAdlfhfDycPSj15NNk
 X9ZaNoDqmb5kU6ih2I8s1KXE/59yYfQ818kcOqVH0j+lCp/tVPP0sgYw==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v3 2/3] swupdate: Add out of tree signing script for swu files.
Date: Thu, 12 Nov 2026 14:38:18 +0100
Message-ID: <20261112133819.251598-3-alexander.heinisch@siemens.com>
In-Reply-To: <20261112133819.251598-1-alexander.heinisch@siemens.com>
References: <20261112133819.251598-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2026 13:38:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24785
Content-Type: text/plain; charset="utf-8"

From: Alexander Heinisch <alexander.heinisch@siemens.com>

Added a helper script that unpacks a pre-existing .swu file signs
the sw-description using a custom signer script and repackages
the swu file including the newly created signed sw-description.sig

The script interface is:
    sign-swu.sh [OPTIONS] SWU_FILE [-- SIGNER_SCRIPT [SIGNER_ARGS...]]

where the SIGNER_SCRIPT interface follows:
    SIGNER_SCRIPT [SIGNER_ARGS...] SIGNEE SIGNED

SIGNEE and SIGNED are provided by sign-swu.sh

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 scripts/sign-swu.sh | 132 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100755 scripts/sign-swu.sh

diff --git a/scripts/sign-swu.sh b/scripts/sign-swu.sh
new file mode 100755
index 00000000..00eb823b
--- /dev/null
+++ b/scripts/sign-swu.sh
@@ -0,0 +1,132 @@
+#!/bin/sh
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Alexander Heinisch <alexander.heinisch@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+set -eu
+
+script_dir=$(dirname "$(readlink -f "$0")")
+default_signer_script="${script_dir}/../recipes-devtools/swupdate-signer/files/sign-swu-cms"
+default_signer_key="${script_dir}/../recipes-devtools/swupdate-certificates/files/trixie/PkKek-1-snakeoil.key"
+default_signer_cert="${script_dir}/../recipes-devtools/swupdate-certificates/files/trixie/PkKek-1-snakeoil.pem"
+
+usage() {
+	cat <<EOF
+Usage: ${0##*/} [OPTIONS] SWU_FILE [-- SIGNER_SCRIPT [SIGNER_ARGS...]]
+
+Sign the sw-description of an SWU image and repack it.
+
+Arguments:
+  SWU_FILE                SWU image to sign.
+  SIGNER_SCRIPT           Signer script to use. It is invoked as
+                            SIGNER_SCRIPT [SIGNER_ARGS...] SIGNEE SIGNED
+                          and has to write the signature of SIGNEE to SIGNED.
+                          Defaults to: "${default_signer_script}"
+  SIGNER_ARGS             Additional arguments passed to SIGNER_SCRIPT.
+                          Defaults to:
+                            -k ${default_signer_key}
+                            -c ${default_signer_cert}
+
+Options:
+  -o, --output FILE       Write the signed image to FILE. Defaults to SWU_FILE
+                          with .swu replaced by .signed.swu.
+  -h, --help              Show this help and exit.
+EOF
+}
+
+bail_out() {
+	echo "error: $1" >&2
+	usage >&2
+	exit 1
+}
+
+swu_file=""
+output_file=""
+
+while [ $# -gt 0 ]; do
+	case "$1" in
+	-h | --help)
+		usage
+		exit 0
+		;;
+	-o | --output)
+		[ $# -ge 2 ] || bail_out "$1 requires an argument"
+		output_file="$2"
+		shift 2
+		;;
+	--)
+		# The remaining arguments form the signer command.
+		shift
+		break
+		;;
+	-*)
+		bail_out "unknown option: $1"
+		;;
+	*)
+		[ -z "${swu_file}" ] || bail_out "only one SWU_FILE may be given"
+		swu_file="$1"
+		shift
+		;;
+	esac
+done
+
+if [ -z "${swu_file}" ]; then
+	bail_out "no SWU file given"
+fi
+
+if [ ! -f "${swu_file}" ]; then
+	bail_out "SWU file not found: ${swu_file}"
+fi
+
+swu_file=$(readlink -f "${swu_file}")
+output_file=$(readlink -m "${output_file:-${swu_file%.swu}.signed.swu}")
+
+if [ $# -eq 0 ]; then
+	set -- "${default_signer_script}" \
+		-k "${default_signer_key}" \
+		-c "${default_signer_cert}"
+fi
+
+# Here the actual work starts
+# 1. extract the $swu_file
+# 2. sign it and
+# 3. repack it to $output_file
+
+workdir=$(mktemp -d)
+trap 'rm -rf "${workdir}"' EXIT
+
+extracted="${workdir}/extracted"
+mkdir "${extracted}"
+(cd "${extracted}" && cpio --extract --quiet --no-absolute-filenames <"${swu_file}")
+
+if [ ! -f "${extracted}/sw-description" ]; then
+	bail_out "no sw-description found in SWU image"
+fi
+
+"$@" "${extracted}/sw-description" "${extracted}/sw-description.sig"
+
+if [ ! -s "${extracted}/sw-description.sig" ]; then
+	bail_out "signer did not produce a signature"
+fi
+
+# Keep the order of the remaining files from the original image. The listing is
+# written to a file first because "set -o pipefail" is not available in POSIX
+# shells, so a failing cpio would go unnoticed inside a pipeline.
+cpio --list --quiet <"${swu_file}" >"${workdir}/filelist"
+
+# Only replace the output file once the image is complete.
+(
+	cd "${extracted}"
+	{
+		echo sw-description
+		echo sw-description.sig
+		grep -vx -e sw-description -e sw-description.sig "${workdir}/filelist"
+	} | cpio --quiet --owner 0:0 --dereference --create --reproducible --format=crc
+) >"${workdir}/signed.swu"
+mv -f "${workdir}/signed.swu" "${output_file}"
+echo "signed image written to ${output_file}"
-- 
2.47.3

