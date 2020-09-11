Return-Path: <SRS0=e/aK=CU=lists.cip-project.org=bounce+64572+5446+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E24C433E2
	for <cip-dev@archiver.kernel.org>; Fri, 11 Sep 2020 12:40:09 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C302E22204
	for <cip-dev@archiver.kernel.org>; Fri, 11 Sep 2020 12:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="PWuMwUBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C302E22204
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5446+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id dMB7YY4521723x2nQHglZF6v; Fri, 11 Sep 2020 05:40:08 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web10.7059.1599828006730111092
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2020 05:40:08 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 08BCe42s018482
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2020 14:40:04 +0200
X-Received: from [167.87.49.221] ([167.87.49.221])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 08BCe38j007626;
	Fri, 11 Sep 2020 14:40:03 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Subject: [cip-dev] [isar-cip-core][PATCH] swupdate: Clean up do_prepare_build
To: cip-dev <cip-dev@lists.cip-project.org>,
        Quirin Gylstorff <quirin.gylstorff@siemens.com>
Message-ID: <d3844e60-71a0-c3a8-4eba-57389b30c8d7@siemens.com>
Date: Fri, 11 Sep 2020 14:40:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: OBzIwjZJwoDHFxZEgLvbCoj4x4520388AA=
Content-Type: multipart/mixed; boundary="owcJCxU3oOibGMO2hiDa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599828008;
 bh=vdsSe8wp9AApKYoRyrBeQB21WUc1JFOtnIdx7f5fpbc=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=PWuMwUBcW6q1XpmllOVf62WuNm5AHMKBZQXHtTosiNv+41rd+zU82ChGctkZUSx9WTt
 Wed3uUdo3YfHSUPbBtHdXNVMNFItswXZa3r5P6XOL7ImtiIQQLq+TNtsybS15qvc2/9vD
 WbG1Ya1XBynmEVuVu62Zu28CCf3xYpMa4Qk=

--owcJCxU3oOibGMO2hiDa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

From: Jan Kiszka <jan.kiszka@siemens.com>

Reformat and drop the unused DEBDIR var (which wouldn't work anyway due
to DEBDIR definition in Isar's bitbake.conf)

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/swupdate/swupdate.bb | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/recipes-core/swupdate/swupdate.bb b/recipes-core/swupdate/swupdate.bb
index 95cf73a..dd02cc2 100644
--- a/recipes-core/swupdate/swupdate.bb
+++ b/recipes-core/swupdate/swupdate.bb
@@ -39,16 +39,14 @@ TEMPLATE_FILES = "debian/changelog.tmpl debian/control.tmpl debian/rules.tmpl"
 TEMPLATE_VARS += "BUILD_DEB_DEPENDS DEFCONFIG DEBIAN_DEPENDS"
 
 do_prepare_build() {
-        DEBDIR=${S}/debian
-        cp -R ${WORKDIR}/debian ${S}
-
-        install -m 0644 ${WORKDIR}/${PN}.cfg ${S}/swupdate.cfg
-        install -m 0644 ${WORKDIR}/${DEFCONFIG}.gen ${S}/configs/${DEFCONFIG}
-
-        if ! grep -q "configs/${DEFCONFIG}" ${S}/.gitignore
-        then
-                echo "configs/${DEFCONFIG}" >> ${S}/.gitignore
-        fi
-        # luahandler
-        install -m 0644 ${WORKDIR}/${SWUPDATE_LUASCRIPT} ${S}
+    cp -R ${WORKDIR}/debian ${S}
+
+    install -m 0644 ${WORKDIR}/${PN}.cfg ${S}/swupdate.cfg
+    install -m 0644 ${WORKDIR}/${DEFCONFIG}.gen ${S}/configs/${DEFCONFIG}
+
+    if ! grep -q "configs/${DEFCONFIG}" ${S}/.gitignore; then
+        echo "configs/${DEFCONFIG}" >> ${S}/.gitignore
+    fi
+    # luahandler
+    install -m 0644 ${WORKDIR}/${SWUPDATE_LUASCRIPT} ${S}
 }
-- 
2.26.2

--owcJCxU3oOibGMO2hiDa
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5446): https://lists.cip-project.org/g/cip-dev/message=
/5446
Mute This Topic: https://lists.cip-project.org/mt/76778363/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--owcJCxU3oOibGMO2hiDa--
