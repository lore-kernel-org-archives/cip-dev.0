Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9675.1793361357243604052
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Oct 2026 04:55:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm2 header.b=fNTSTI/T;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1330684-20261030115555f214271a6300020786-7gwuob@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20261030115555f214271a6300020786
        for <cip-dev@lists.cip-project.org>;
        Fri, 30 Oct 2026 12:55:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=rUvbh6NIfPxH2k66/voKj4jArxf42L2woAw7JdkCjtQ=;
 b=fNTSTI/TpMNzvoWK7FzbtAGlKbFjh7Pz77vfuk+uT2C27k1897JjDg4kwqWiL+1OineG9k
 jlbbKHukXFcV6FY4gWlhf7RHa04rPqVW3GeEx4IgA7i82cT5M2TMPZnoowxvY73gkDBJU3lu
 LCk/Rt9rOuPa46qGdLssx+jAhaFCtw5tXyuwsslYhMrTCqQLBSnI04dhgJriDF7VM/p7qeGx
 xB5HPFz3xEjabV8t7FnqPBQMpudZ5hXnhPTwxEfCnQTwORrvOU4LaHpB4QROv50nJj8tSfyQ
 DImCXbXtB7YyM0H0lwO0yNpVrukTu+NE/3/NC4N1M10Po+GmOE4jl46Q==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v2 2/4] swupdate: Add out of tree signing script for swu files.
Date: Fri, 30 Oct 2026 12:55:41 +0100
Message-ID: <20261030115543.111644-3-alexander.heinisch@siemens.com>
In-Reply-To: <20261030115543.111644-1-alexander.heinisch@siemens.com>
References: <20261030115543.111644-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 30 Oct 2026 11:56:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24588
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
 scripts/sign-swu.sh | 128 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100755 scripts/sign-swu.sh

diff --git a/scripts/sign-swu.sh b/scripts/sign-swu.sh
new file mode 100755
index 00000000..cdc38139
--- /dev/null
+++ b/scripts/sign-swu.sh
@@ -0,0 +1,128 @@
+#!/bin/bash
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Alexander Heinisch <alexander.heinisch@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+set -euo pipefail
+
+script_dir=$(dirname "$(readlink -f "$0")")
+default_signer_script="${script_dir}/../recipes-devtools/swupdate-signer/files/sign-swu-cms"
+default_signer_args=(
+	-k "${script_dir}/../recipes-devtools/swupdate-certificates/files/trixie/PkKek-1-snakeoil.key"
+	-c "${script_dir}/../recipes-devtools/swupdate-certificates/files/trixie/PkKek-1-snakeoil.pem"
+)
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
+                          Defaults to: "${default_signer_args[*]}"
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
+signer_cmd=()
+
+while [[ $# -gt 0 ]]; do
+	case "$1" in
+	-h | --help)
+		usage
+		exit 0
+		;;
+	-o | --output)
+		[[ $# -ge 2 ]] || bail_out "$1 requires an argument"
+		output_file="$2"
+		shift 2
+		;;
+	--)
+		shift
+		signer_cmd=("$@")
+		break
+		;;
+	-*)
+		bail_out "unknown option: $1"
+		;;
+	*)
+		[[ -z "${swu_file}" ]] || bail_out "only one SWU_FILE may be given"
+		swu_file="$1"
+		shift
+		;;
+	esac
+done
+
+if [[ -z "${swu_file}" ]]; then
+	bail_out "no SWU file given"
+fi
+
+if [[ ! -f "${swu_file}" ]]; then
+	bail_out "SWU file not found: ${swu_file}"
+fi
+
+swu_file=$(readlink -f "${swu_file}")
+output_file=$(readlink -m "${output_file:-${swu_file%.swu}.signed.swu}")
+
+if [[ ${#signer_cmd[@]} -eq 0 ]]; then
+	signer_cmd=("${default_signer_script}" "${default_signer_args[@]}")
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
+if [[ ! -f "${extracted}/sw-description" ]]; then
+	bail_out "no sw-description found in SWU image"
+fi
+
+"${signer_cmd[@]}" "${extracted}/sw-description" "${extracted}/sw-description.sig"
+
+if [[ ! -s "${extracted}/sw-description.sig" ]]; then
+	bail_out "signer did not produce a signature"
+fi
+
+# Only replace the output file once the image is complete.
+(
+	cd "${extracted}"
+	{
+		echo sw-description
+		echo sw-description.sig
+		# Keep the order of the remaining files from the original image.
+		cpio --list --quiet <"${swu_file}" |
+			grep -vx -e sw-description -e sw-description.sig
+	} | cpio --quiet --owner 0:0 --dereference --create --reproducible --format=crc
+) >"${workdir}/signed.swu"
+mv -f "${workdir}/signed.swu" "${output_file}"
+echo "signed image written to ${output_file}"
-- 
2.47.3

