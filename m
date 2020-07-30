Return-Path: <SRS0=DcGa=BJ=lists.cip-project.org=bounce+64572+5065+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05106C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 09:10:27 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DD1D2082E
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 09:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="CDxpBz9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD1D2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5065+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0QLZYY4521723xf5zUvr77dW; Thu, 30 Jul 2020 02:10:26 -0700
X-Received: from peak.toshiba-tesi.com (peak.toshiba-tesi.com [202.56.254.199])
 by mx.groups.io with SMTP id smtpd.web10.4509.1596100225082234785
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jul 2020 02:10:25 -0700
IronPort-SDR: jtnorwn5R1cdZH6djqCQBuAvQwDF6T06Van5d0NUB4Mw+y3BWQ8u3TODVW5r8BABpAD/REBpwO
 2v45S2Unap8g==
X-IronPort-AV: E=Sophos;i="5.75,413,1589221800"; 
   d="scan'208";a="5250288"
X-Received: from unknown (HELO TOSBLRMBX0519.TOSHIBA-TSIP.COM) ([10.116.85.29])
  by peak.toshiba-tesi.com with ESMTP; 30 Jul 2020 15:15:02 +0530
X-Received: from TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) by
 TOSBLRMBX0519.TOSHIBA-TSIP.COM (10.116.85.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 30 Jul 2020 14:39:26 +0530
X-Received: from pvenkat.TOSHIBA-TSIP.COM (172.28.80.121) by
 TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) with Microsoft SMTP Server id
 15.1.1847.3 via Frontend Transport; Thu, 30 Jul 2020 14:39:26 +0530
From: "Venkata Pyla" <venkata.pyla@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>
CC: venkata pyla <venkata.pyla@toshiba-tsip.com>,
	<cip-dev@lists.cip-project.org>
Subject: [cip-dev] [isar-cip-core 0/2] add security image to ci
Date: Thu, 30 Jul 2020 14:40:20 +0530
Message-ID: <20200730091022.602-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: crMgxOFbb7rtqGJqAPCqxUH4x4520388AA=
Content-Type: multipart/mixed; boundary="V7BUsll8uPx7mMz0Fxvm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596100226;
 bh=1Kkhuy6m6Vy7pb1qVY7jCQo5HuRtxyfYYct0PPnkNOA=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=CDxpBz9Hhgm3GtsxMBldlVQzYv40MqvDb1FwNgdu320P9ngpwfVz5PV0JU/QY1zaOCZ
 y6lwWMPY6lErfliF+YHyROuqo5V+NJJAGCrz8fjKSUXMyVhjtpNo0DvBjHrtOapnx+vWb
 hFXKZEvbEj6j73sO9b8bV/3FB2QQ18HWeak=

--V7BUsll8uPx7mMz0Fxvm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Add kas option file for security image
Add security image to ci

venkata pyla (2):
  opt: Add kas option file for security image
  ci: Add security image

 .gitlab-ci.yml       |  3 +++
 README.md            |  2 +-
 kas/opt/security.yml | 14 ++++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)
 create mode 100644 kas/opt/security.yml

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


--V7BUsll8uPx7mMz0Fxvm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5065): https://lists.cip-project.org/g/cip-dev/message=
/5065
Mute This Topic: https://lists.cip-project.org/mt/75882937/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--V7BUsll8uPx7mMz0Fxvm--
