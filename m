Return-Path: <SRS0=nGHH=CY=lists.cip-project.org=bounce+64572+5455+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE3AC43461
	for <cip-dev@archiver.kernel.org>; Tue, 15 Sep 2020 14:23:08 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8AA922B51
	for <cip-dev@archiver.kernel.org>; Tue, 15 Sep 2020 14:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="wwE9Kp1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8AA922B51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5455+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id UExvYY4521723x6BKCFfaMof; Tue, 15 Sep 2020 07:23:07 -0700
X-Received: from peak.toshiba-tesi.com (peak.toshiba-tesi.com [202.56.254.199])
 by mx.groups.io with SMTP id smtpd.web12.14728.1600179786660820138
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Sep 2020 07:23:07 -0700
IronPort-SDR: z8wya7gPqewqlOynOdSMsW8+YaX8jV1IgGF1A9r6bf9yHM62f976w34Q8UPZ7hYqUi6qExvsDH
 S7YgWrmIwlLw==
X-IronPort-AV: E=Sophos;i="5.76,430,1592850600"; 
   d="scan'208";a="6248131"
X-Received: from unknown (HELO TOSBLRMBX0519.TOSHIBA-TSIP.COM) ([10.116.85.29])
  by peak.toshiba-tesi.com with ESMTP; 15 Sep 2020 20:33:56 +0530
X-Received: from TOSBLRMBX0319.TOSHIBA-TSIP.COM (172.28.80.120) by
 TOSBLRMBX0519.TOSHIBA-TSIP.COM (10.116.85.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 15 Sep 2020 19:53:03 +0530
X-Received: from pvenkat.TOSHIBA-TSIP.COM (172.28.80.121) by
 TOSBLRMBX0319.TOSHIBA-TSIP.COM (172.28.80.120) with Microsoft SMTP Server id
 15.1.1847.3 via Frontend Transport; Tue, 15 Sep 2020 19:52:58 +0530
From: "Venkata Pyla" <venkata.pyla@toshiba-tsip.com>
To: <daniel.sangorrin@toshiba.co.jp>
CC: venkata pyla <venkata.pyla@toshiba-tsip.com>,
	<cip-dev@lists.cip-project.org>
Subject: [cip-dev] [cip-core:deby 3/3] aide-static: enable aide to build statically
Date: Tue, 15 Sep 2020 19:53:44 +0530
Message-ID: <20200915142345.179-4-venkata.pyla@toshiba-tsip.com>
In-Reply-To: <20200915142345.179-1-venkata.pyla@toshiba-tsip.com>
References: <20200915142345.179-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Qa9K5NUFK1i8wfib7ZwFqpKhx4520388AA=
Content-Type: multipart/mixed; boundary="pG2A3bd74N2SECNlEAVe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1600179787;
 bh=z7OfPggVtbJPA9fHxytgZAbLPBOvO57Sf9EjjWLPCsk=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=wwE9Kp1R1DNYjjEyZd5iVkJvTGx2QEnM6TWJSsmG7twro2vNIixdPdH0hRmAVQ3MCYt
 wBazfZ4J7ZU0Dleg7gS/SUrZCyq9QANHAbsO41CS1LUXrLnYzr9LskDrROZmtvDZmozAb
 CCXUB/CYlpcgSBx4sgsGAMW24y+PcYKFoZU=

--pG2A3bd74N2SECNlEAVe
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

To build aide statically, its dependencies also compile staticalliy,
so all aide dependent library packages enabled static compiling in
an include file and added to the layer configuration.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 meta-cip-security/conf/include/aide-static-libs.inc | 10 ++++++++++
 meta-cip-security/conf/layer.conf                   |  2 ++
 2 files changed, 12 insertions(+)
 create mode 100644 meta-cip-security/conf/include/aide-static-libs.inc

diff --git a/meta-cip-security/conf/include/aide-static-libs.inc b/meta-cip-security/conf/include/aide-static-libs.inc
new file mode 100644
index 0000000..1dc4374
--- /dev/null
+++ b/meta-cip-security/conf/include/aide-static-libs.inc
@@ -0,0 +1,10 @@
+DISABLE_STATIC ?= " --disable-static"
+
+# aide dependencies to build statically
+DISABLE_STATIC_pn-aide = " " 
+DISABLE_STATIC_pn-libgpg-error = " " 
+DISABLE_STATIC_pn-libmhash = " " 
+DISABLE_STATIC_pn-attr = " " 
+DISABLE_STATIC_pn-acl = " " 
+DISABLE_STATIC_pn-libpcre = " " 
+EXTRA_OECONF_append_pn-aide = " --without-audit"
diff --git a/meta-cip-security/conf/layer.conf b/meta-cip-security/conf/layer.conf
index b015436..158d75c 100644
--- a/meta-cip-security/conf/layer.conf
+++ b/meta-cip-security/conf/layer.conf
@@ -16,3 +16,5 @@ LAYERVERSION_cip-security = "1"
 LAYERDEPENDS_cip-security = "debian"
 
 LAYERSERIES_COMPAT_cip-security = "warrior"
+
+require conf/include/aide-static-libs.inc
-- 
2.27.0.windows.1

The information contained in this e-mail message and in any
attachments/annexure/appendices is confidential to the 
recipient and may contain privileged information. 
If you are not the intended recipient, please notify the
sender and delete the message along with any 
attachments/annexure/appendices. You should not disclose,
copy or otherwise use the information contained in the
message or any annexure. Any views expressed in this e-mail 
are those of the individual sender except where the sender 
specifically states them to be the views of 
Toshiba Software India Pvt. Ltd. (TSIP),Bangalore.

Although this transmission and any attachments are believed to be
free of any virus or other defect that might affect any computer 
system into which it is received and opened, it is the responsibility
of the recipient to ensure that it is virus free and no responsibility 
is accepted by Toshiba Embedded Software India Pvt. Ltd, for any loss or
damage arising in any way from its use.


--pG2A3bd74N2SECNlEAVe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5455): https://lists.cip-project.org/g/cip-dev/message=
/5455
Mute This Topic: https://lists.cip-project.org/mt/76865934/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--pG2A3bd74N2SECNlEAVe--
