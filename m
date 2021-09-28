Return-Path: <SRS0=1jaV=OS=lists.cip-project.org=bounce+64572+6757+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F859C43219
	for <cip-dev@archiver.kernel.org>; Tue, 28 Sep 2021 18:49:54 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D672960F9D
	for <cip-dev@archiver.kernel.org>; Tue, 28 Sep 2021 18:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D672960F9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id CV4tYY4521723xyaWRB6GhMl; Tue, 28 Sep 2021 11:49:53 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web08.754.1632854992362917609
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Sep 2021 11:49:53 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 18SInnQK007496
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Sep 2021 20:49:50 +0200
X-Received: from md2dvrtc.fritz.box ([139.22.32.51])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 18SInmgx026555;
	Tue, 28 Sep 2021 20:49:49 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, dinesh.kumar@toshiba-tsip.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH 1/2] kas/opt/swupdate: Change assignment of IMAGE_TYPE and WKS_FILE
Date: Tue, 28 Sep 2021 20:49:47 +0200
Message-ID: <20210928184948.737071-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210928184948.737071-1-Quirin.Gylstorff@siemens.com>
References: <20210928184948.737071-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: zBknAzt5xpmE8eScAJZOzNFYx4520388AA=
Content-Type: multipart/mixed; boundary="oI1OoyEjW1JK7qhJuRUl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1632854993;
 bh=VXDjmdhIfEp7sZEQ9/snxc0FtURuLER5KMNus2nWG30=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=u28HNQiu2uuA6nqzR0b/Mgojz28uMptqyT7lX0n0aszWPeea+QN3d7PMvsyGD02X0tE
 iEb1g1Cfg5HFHpQ0ettIuwd5GF+HrUg6izTNmsA79foWwewbn1aFZuZX+3rzxH0gk7qlc
 bcXRT1cCTbrOAamhFbHABxqgCaeic7hoSZ4=
Message-ID: <20210928184947.AYjduU9bTolWO5fGM5sHK1KwOFt_xWwyNQv5uQOgPvk@z>

--oI1OoyEjW1JK7qhJuRUl
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Replace the default assignment to ensure the generation of the
swu file. As stated in [1]: If multiple `?=` assignments are used
the first of those assignments ends up getting used.

This fixes [2].

[1]: https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manual-metadata.html#setting-a-default-value
[2]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/14

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/swupdate.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index 7d86ad5..3cc02a3 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -19,5 +19,5 @@ local_conf_header:
     IMAGE_INSTALL_append = " swupdate"
 
   wic-swu: |
-    IMAGE_TYPE ?= "wic-swu-img"
-    WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
+    IMAGE_TYPE = "wic-swu-img"
+    WKS_FILE = "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
-- 
2.30.2


--oI1OoyEjW1JK7qhJuRUl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6757): https://lists.cip-project.org/g/cip-dev/message/=
6757
Mute This Topic: https://lists.cip-project.org/mt/85931980/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--oI1OoyEjW1JK7qhJuRUl--
