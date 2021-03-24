Return-Path: <SRS0=xRQQ=IW=lists.cip-project.org=bounce+64572+6323+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0821BC433DB
	for <cip-dev@archiver.kernel.org>; Wed, 24 Mar 2021 05:42:19 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ACC8619CD
	for <cip-dev@archiver.kernel.org>; Wed, 24 Mar 2021 05:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACC8619CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6323+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rrKiYY4521723xdKb6qBE120; Tue, 23 Mar 2021 22:42:17 -0700
X-Received: from peak.toshiba-tesi.com (peak.toshiba-tesi.com [202.56.254.199])
 by mx.groups.io with SMTP id smtpd.web11.1931.1616564536235436934
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Mar 2021 22:42:16 -0700
IronPort-SDR: oz3wdzvrvhde7EenjiUJqwN1K2XiYGkevexP5LqzuB5S8U/fkOCldoRBjbkIOrhK+ROCdY3I/l
 u+6OyDbt7NPA==
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ACAy9TarVGG02/2Tv9atzoMwaV5voL9V00z?=
 =?us-ascii?q?AX/kB9WHVpW+SFisbrpugR0R/olTodMUtQ6+yoEq+GXH/a6NpJ+oEXJ7ivR0?=
 =?us-ascii?q?3Lv2GvIYFk4+LZskXdMgf58fNQ0rolTrhmBLTLfCFHpOvz/QXQKadC/PCp66?=
 =?us-ascii?q?at7N2urUtFaAFxduVB4m5Ce3OmO2l7XhNPC5Z8NLf03LsjmxOFeXAaKvu2HW?=
 =?us-ascii?q?MEWe+rnaysqLvcbRQLBwEq5WC15FvCgtOXfHb4vis2aD9Bzawv9mLIiWXCl8?=
 =?us-ascii?q?GemsumwRzR3XK71eUwpPLRjvNeGcrJscQOMzPqkArtXph5QqaPpipdmpDd1H?=
 =?us-ascii?q?8a1P3FoxItJK1Img3sV1Dwmhfh3wnm3HIO7WX+oGXo8EfLkIjDSD8/C81Mwa?=
 =?us-ascii?q?JCaAfUr2I7ptFz165Gtljpy6Z/PFf6kCn459/FEzFxjFa55VI/jO8UlBVkIP?=
 =?us-ascii?q?YjQY4UloAT+ENTHNMhBjjn5MQGHYBVfbvhzccTSl+Wa3Dfsi1X29quUn4vdy?=
 =?us-ascii?q?32OXQqi4iv3zVTnHd0i3EVw8EShR47he0AYqgB3OjINqRumPV1TtIbBJgNdN?=
 =?us-ascii?q?s8fQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.81,272,1610389800"; 
   d="scan'208";a="13864325"
X-Received: from unknown (HELO TOSBLRMBX0419.TOSHIBA-TSIP.COM) ([10.116.85.28])
  by peak.toshiba-tesi.com with ESMTP; 24 Mar 2021 11:12:11 +0530
X-Received: from TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) by
 TOSBLRMBX0419.TOSHIBA-TSIP.COM (10.116.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 24 Mar 2021 11:12:09 +0530
X-Received: from pvenkat.TOSHIBA-TSIP.COM (172.28.80.121) by
 TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 24 Mar 2021 11:12:11 +0530
From: "Venkata Pyla" <venkata.pyla@toshiba-tsip.com>
To: <daniel.sangorrin@toshiba.co.jp>
CC: venkata pyla <venkata.pyla@toshiba-tsip.com>,
	<cip-dev@lists.cip-project.org>
Subject: [cip-dev] [cip-core:deby] security-layer: add bro package to the security layer
Date: Wed, 24 Mar 2021 11:14:58 +0530
Message-ID: <20210324054458.1753-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ujxOZTZES1FqlVc3JfkcGYIPx4520388AA=
Content-Type: multipart/mixed; boundary="ch8Wi4cQYZYPvqvH4l7A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616564537;
 bh=RIgo8DJ19RmdluylMSQSj2SuOOZ3+g+HRwrFgogwnJA=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=BwRSS5fWls7aEFYQSYXAukSyshb2Pba+cL6limcqF6U1SsuUwD0sfjIOMdNRX7KtEYW
 9OB8cjcFinvWToKe+Hj2JkyCXllxLR8kT+zUebW1RIoTQQonv2KmS47yZBZtP8mf57lJ/
 Gi6EV2qTn+EvJxwyBMB7tbMH7tss/1KCB9I=

--ch8Wi4cQYZYPvqvH4l7A
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 kas/board/kas.yml    | 2 +-
 kas/opt/security.yml | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kas/board/kas.yml b/kas/board/kas.yml
index 51c7a84..f1ff202 100644
--- a/kas/board/kas.yml
+++ b/kas/board/kas.yml
@@ -20,7 +20,7 @@ repos:
 
   meta-debian:
     url: https://github.com/meta-debian/meta-debian.git
-    refspec: 8dc5105b7e36e253093f8103b1f812535bac24a9
+    refspec: 1d746eff6256a16809e47c846dd9514ab43a28fb
 
   meta-cip-core:
     layers:
diff --git a/kas/opt/security.yml b/kas/opt/security.yml
index e68d2e0..02db4c9 100644
--- a/kas/opt/security.yml
+++ b/kas/opt/security.yml
@@ -28,4 +28,5 @@ local_conf_header:
                                  acl \
                                  sudo \
                                  auditd \
+                                 bro \
                                  "
-- 
2.20.1

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


--ch8Wi4cQYZYPvqvH4l7A
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6323): https://lists.cip-project.org/g/cip-dev/message=
/6323
Mute This Topic: https://lists.cip-project.org/mt/81570399/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ch8Wi4cQYZYPvqvH4l7A--
