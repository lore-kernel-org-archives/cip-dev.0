Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A8FC54E49
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 11:03:24 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.20091.1709636595988226617
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Mar 2024 03:03:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=P31K0azD;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20240305110312e526a575e72f269590-hr_vtg@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240305110312e526a575e72f269590
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 Mar 2024 12:03:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=PobW7/TOjsSmnAVRB4B34bIqRqG9Ur0ytM39fxRYyrg=;
 b=P31K0azDA0UTV57yEtU9MJ++CVsGGiO9P+euJ2/xrv+PT2ZP/lNifv3HHVMMr86PIauK9E
 x4XibI4NMMP0qNFW9d/3p1+tHHHJW5UJP1VcDEi+ykb5oA+a5Iqa65vmLGhg8aDHNOHguTkp
 GG7RkaCKxgO+g+pH/0XgEf6Elh8Fk=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 1/4] swupdate: check output of sign-swu
Date: Tue,  5 Mar 2024 12:02:43 +0100
Message-ID: <20240305110311.2073425-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240305110311.2073425-1-Quirin.Gylstorff@siemens.com>
References: <20240305110311.2073425-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 11:03:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15217

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Check for signing errors to avoid an unusable swu file.

This also moves the siging out of the loop to generate
the cpio archive *.swu as the Messages from the signing
can lead to errors in the archive generation. The cpio
options are no longer using the short form.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate.bbclass | 43 ++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index aaff072..c62f43f 100644
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
+                --verbose --dereference --create --reproducible --format=crc \
+                > "${PP_DEPLOY}/${SWU_IMAGE_FILE}$swu_file_extension.swu"
 EOIMAGER
     done
 }
-- 
2.43.0


