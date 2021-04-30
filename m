Return-Path: <SRS0=rOqU=J3=lists.cip-project.org=bounce+64572+6403+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98389C43461
	for <cip-dev@archiver.kernel.org>; Fri, 30 Apr 2021 12:23:48 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9E8B61420
	for <cip-dev@archiver.kernel.org>; Fri, 30 Apr 2021 12:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E8B61420
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6403+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id zjGqYY4521723xGbXenC4vVA; Fri, 30 Apr 2021 05:23:47 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web12.10570.1619785421203500305
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Apr 2021 05:23:41 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 13UCNd16032729
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Apr 2021 14:23:39 +0200
X-Received: from md2dvrtc.fritz.box ([167.87.11.215])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 13UCJvEw026486;
	Fri, 30 Apr 2021 14:19:57 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: dinesh.kumar@toshiba-tsip.com, jan.kiszka@siemens.com,
        cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH] README.secureboot: Corrections
Date: Fri, 30 Apr 2021 14:19:57 +0200
Message-Id: <20210430121957.13306-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: MpN2HrrXgb0qtOUPoUqbjs87x4520388AA=
Content-Type: multipart/mixed; boundary="gtFq6EC9iYldwrlOmivP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1619785427;
 bh=zsPNxJRjbBX0rErJT0yiLwoNZJgpGEmyAuVd+Q+h/to=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=NdAhUIa4qQeS3intiCyopa0ntkMeKf7KTfn3AvH2qTqii/v3WAHEfELsrALZA40/BmR
 HR1DkZCLPInUdsBxchYZM8NQi3CpEqB8Ylaupj3WrBz4ci2/Yob/jXJaHKI3pUNAktUaA
 Gi5xXe8wiTN45Era8o0igw/UH6waoo4JEuk=

--gtFq6EC9iYldwrlOmivP
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

- Add code block for key insertion for better visibility
- Correct the template for user-generated keys
- Add information where to store the keys

Add build command for user generated keys

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.secureboot.md | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 84131bb..12787cf 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -119,6 +119,7 @@ to the current directory. OVMF_VARS_4M.fd contains no keys can be instrumented f
 scripts/start-efishell.sh secureboot-tools
 ```
 4. Start the KeyTool.efi FS0:\KeyTool.efi and execute the the following steps:
+```
           -> "Edit Keys"
              -> "The Allowed Signatures Database (db)"
                 -> "Add New Key"
@@ -132,35 +133,47 @@ scripts/start-efishell.sh secureboot-tools
                 -> "Replace Key(s)"
                 -> Change/Confirm device
                 -> Select "PK.auth" file
+```
 5. quit QEMU
 
 ### Build image
 
+
+
 Build the image with a signed efibootguard and unified kernel image
 with the snakeoil keys by executing:
+
 ```
 kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/ebg-secure-boot-snakeoil.yml
 ```
 
-For user-generated keys, create a new option file. This option file could look like this:
+For user-generated keys, create a new option file in the repository. This option file could look like this:
 ```
 header:
   version: 10
   includes:
-   - opt/ebg-swu.yml
-   - opt/ebg-secure-boot-initramfs.yml
+   - kas/opt/ebg-swu.yml
+   - kas/opt/ebg-secure-boot-base.yml
 
 local_conf_header:
   secure-boot: |
     IMAGER_BUILD_DEPS += "ebg-secure-boot-secrets"
     IMAGER_INSTALL += "ebg-secure-boot-secrets"
-  user-keys:
+  user-keys: |
     SB_CERTDB = "democertdb"
     SB_VERIFY_CERT = "demo.crt"
     SB_KEY_NAME = "demo"
 ```
 
-Replace `demo` with the name of the user-generated certificates.
+Replace `demo` with the name of the user-generated certificates. The user-generated certificates
+need to stored in the folder `recipes-devtools/ebg-secure-boot-secrets/files`.
+
+Build the image with user-generated keys by executing the command:
+
+```
+kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:<path to the new option>.yml
+```
+
 
 ### Start the image
 
-- 
2.20.1


--gtFq6EC9iYldwrlOmivP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6403): https://lists.cip-project.org/g/cip-dev/message=
/6403
Mute This Topic: https://lists.cip-project.org/mt/82479716/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--gtFq6EC9iYldwrlOmivP--
