Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700D9C54E55
	for <webhook@archiver.kernel.org>; Mon,  4 Mar 2024 10:11:08 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.94821.1709547059151314789
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Mar 2024 02:11:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=EDzSp4c1;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-202403041010559ba8168e4512696a32-p1lpsb@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202403041010559ba8168e4512696a32
        for <cip-dev@lists.cip-project.org>;
        Mon, 04 Mar 2024 11:10:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=EpQZzrQOzpJI3ZAUYY6yNI8k4i9jGhcixmuLH3n6U3I=;
 b=EDzSp4c1aLOEgl/Vwdhrmj8XsnUCod63KwH9mfK1Uhd/BqZPcfab12tvE6WnTJmYTJS2tE
 8YhWZt9oftrVbZqUoPKdZ7sYK+2AGrWmQNZAVrN6am7l7KPIqks9IbpB02GIYXiEybRo2YLg
 9D6DrR/BIr/AkPw/B1BKUnTINADn4=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 1/4] swupdate: check output of sign-swu
Date: Mon,  4 Mar 2024 11:08:41 +0100
Message-ID: <20240304101054.864948-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240304101054.864948-1-Quirin.Gylstorff@siemens.com>
References: <20240304101054.864948-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Mar 2024 10:11:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15187

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Check for signing errors to avoid an unusable swu file.

This also moves the siging out of the loop to generate
the cpio archive *.swu as the Messages from the signing
can lead to errors in the archive generation.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate.bbclass | 43 ++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 2c69892..be6a07f 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -191,24 +191,41 @@ IMAGE_CMD:swu() {
                     "${PP_WORK}/$swu_file_base/${SWU_DESCRIPTION_FILE}"
             done
             cd "${PP_WORK}/$swu_file_base"
-            for file in "${SWU_DESCRIPTION_FILE}" ${SWU_ADDITIONAL_FILES}; do
-                if [ "$file" = "${SWU_DESCRIPTION_FILE}" ] || \
-                    grep -q "$file" "${PP_WORK}/$swu_file_base/${SWU_DESCRIPTION_FILE}"; then
+            cpio_files="${SWU_DESCRIPTION_FILE}"
+
+            if [ -n "$sign" ]; then
+                if ! /usr/bin/sign-swu \
+                    "${SWU_DESCRIPTION_FILE}" "${SWU_DESCRIPTION_FILE}.${SWU_SIGNATURE_EXT}" \
+                    > /dev/null 2>&1 || \
+                    [ ! -f "${SWU_DESCRIPTION_FILE}.${SWU_SIGNATURE_EXT}" ]; then
+                    echo "Could not create swupdate signature file '${SWU_DESCRIPTION_FILE}.${SWU_SIGNATURE_EXT}'" 1>&2
+                    exit 1
+                fi
+                cpio_files="$cpio_files ${SWU_DESCRIPTION_FILE}.${SWU_SIGNATURE_EXT}"
+            fi
+
+            # sw-description must be first file in *.swu
+            for cpio_file in $cpio_files ${SWU_ADDITIONAL_FILES}; do
+                if [ -f "$cpio_file" ]; then
                     # Set file timestamps for reproducible builds
                     if [ -n "${SOURCE_DATE_EPOCH}" ]; then
                         touch -d@"${SOURCE_DATE_EPOCH}" "$file"
                     fi
-                    echo "$file"
-                    if [ -n "$sign" -a "${SWU_DESCRIPTION_FILE}" = "$file" ]; then
-                        sign-swu "$file" "$file.${SWU_SIGNATURE_EXT}"
-                        # Set file timestamps for reproducible builds
-                        if [ -n "${SOURCE_DATE_EPOCH}" ]; then
-                            touch -d@"${SOURCE_DATE_EPOCH}" "$file.${SWU_SIGNATURE_EXT}"
-                        fi
-                        echo "$file.${SWU_SIGNATURE_EXT}"
-                    fi
+                    case "$cpio_file" in
+                        sw-description*)
+                            echo "$cpio_file"
+                            ;;
+                        *)
+                            if grep -q "$cpio_file" \
+                                "${WORKDIR}/$swu_file_base/${SWU_DESCRIPTION_FILE}"; then
+                                echo "$cpio_file"
+                            fi
+                            ;;
+                    esac
                 fi
-            done | cpio -ovL --reproducible -H crc > "${PP_DEPLOY}/${SWU_IMAGE_FILE}$swu_file_extension.swu"
+            done | cpio \
+                --verbose --dereference --create --reproducible -H crc \
+                > "${PP_DEPLOY}/${SWU_IMAGE_FILE}$swu_file_extension.swu"
 EOIMAGER
     done
 }
-- 
2.43.0


