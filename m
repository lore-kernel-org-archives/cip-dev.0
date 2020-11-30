Return-Path: <SRS0=X0cJ=FE=lists.cip-project.org=bounce+64572+5908+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8BBC63777
	for <cip-dev@archiver.kernel.org>; Mon, 30 Nov 2020 19:32:25 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A882076E
	for <cip-dev@archiver.kernel.org>; Mon, 30 Nov 2020 19:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="VAX8AWKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A882076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5908+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 1XkYYY4521723xh6gYWk1I4p; Mon, 30 Nov 2020 11:32:22 -0800
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web10.2089.1606764739985203981
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Nov 2020 11:32:21 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 0AUJWHx6019708
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 30 Nov 2020 20:32:18 +0100
X-Received: from md1f2u6c.ad001.siemens.net ([167.87.39.132])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0AUJWGdh001649
	for <cip-dev@lists.cip-project.org>; Mon, 30 Nov 2020 20:32:17 +0100
From: "Jan Kiszka" <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] [isar-cip-core][PATCH 1/3] README: Add some community resources
Date: Mon, 30 Nov 2020 20:32:14 +0100
Message-Id: <074bf4e93e22230c39c814309fc62d9d56d073fb.1606764736.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1606764736.git.jan.kiszka@siemens.com>
References: <cover.1606764736.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: MVVUbxp01WRIKfomm8no7vxmx4520388AA=
Content-Type: multipart/mixed; boundary="LC4PosIJbOUb1EwNXQ4u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606764742;
 bh=IS8LtDqo/3zEFIyRRt+GhYg2lx8bLnCQlUqrI24vAEE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=VAX8AWKR6+W/RXKmbeb1/w9d2RNO9AZXbrDlSlv2UuckUECOh9Wz9DNJtWVF9las3UG
 zTqF1Xsn7toyYySDkTFQA4KvsMh/VuBHTUPcRduLia0MutA9C1X+TE3n21StQ6HsDD++Q
 xvKgev9RACKfcHZ5pFj2p13BIM5mMH2Rsrg=

--LC4PosIJbOUb1EwNXQ4u
Content-Transfer-Encoding: 8bit

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 README.md | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 4f74af7..0d2374f 100644
--- a/README.md
+++ b/README.md
@@ -48,8 +48,23 @@ Run the generated securiy images on QEMU (x86-64bit)
 
 ## Community Resources
 
-TBD
+Mailing list:
 
+ - cip-dev@lists.cip-project.org
+
+ - Subscription:
+   - cip-dev+subscribe@lists.cip-project.org
+   - https://lists.cip-project.org/g/cip-dev
+
+ - Archives:
+   - https://lore.kernel.org/cip-dev/
+   - https://lists.cip-project.org/g/cip-dev
+
+Continuous integration:
+
+  - https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines
+
+ 
 ## License
 
 Unless otherwise stated in the respective file, files in this layer are
-- 
2.26.2


--LC4PosIJbOUb1EwNXQ4u
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5908): https://lists.cip-project.org/g/cip-dev/message=
/5908
Mute This Topic: https://lists.cip-project.org/mt/78616512/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--LC4PosIJbOUb1EwNXQ4u--
