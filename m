Return-Path: <SRS0=c/C8=BG=lists.cip-project.org=bounce+64572+5020+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848C5C433E1
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 11:40:46 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 536442075A
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 11:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="KapBljlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536442075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5020+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id dZIPYY4521723xDx0YR8XFrR; Mon, 27 Jul 2020 04:40:46 -0700
X-Received: from peak.toshiba-tesi.com (peak.toshiba-tesi.com [202.56.254.199])
 by mx.groups.io with SMTP id smtpd.web11.53493.1595850044332209491
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2020 04:40:44 -0700
IronPort-SDR: rOKL+tV5KcF73DLff8hl/5TueooiPZoTZThdddRzbLFTLaYLY7eK+43KDwxgeo+fbMMjdsSFzA
 Vk0zF86IiFNA==
X-IronPort-AV: E=Sophos;i="5.75,402,1589221800"; 
   d="scan'208";a="5175743"
X-Received: from unknown (HELO TOSBLRMBX0419.TOSHIBA-TSIP.COM) ([10.116.85.28])
  by peak.toshiba-tesi.com with ESMTP; 27 Jul 2020 17:45:14 +0530
X-Received: from TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) by
 TOSBLRMBX0419.TOSHIBA-TSIP.COM (10.116.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 27 Jul 2020 17:10:41 +0530
X-Received: from pvenkat.TOSHIBA-TSIP.COM (172.28.80.121) by
 TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) with Microsoft SMTP Server id
 15.1.1847.3 via Frontend Transport; Mon, 27 Jul 2020 17:10:40 +0530
From: "Venkata Pyla" <venkata.pyla@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>
CC: Venkata Pyla <venkata.pyla@toshiba-tsip.com>,
	<cip-dev@lists.cip-project.org>
Subject: [cip-dev] [isar-cip-core 0/3] Security Branch patches
Date: Mon, 27 Jul 2020 17:11:32 +0530
Message-ID: <20200727114135.368-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Wh1Wek4wvtJXLomwLfAJE1eVx4520388AA=
Content-Type: multipart/mixed; boundary="CnbxGUW0xME77vNKzjfL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595850046;
 bh=EOP/YaX418CDAgMux3ZkWaq5MmrrsUUsxIs0YPqSBGY=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=KapBljlqqYRT8tBzhWU+yZ0aff1M7tHEuDcng35ZihY8l6g0kxLBfl5F30wSBPJCy/+
 1kympw15pRGx5nKY3xsOa4ukOf6VaDb2STPW/bywPj1QVwzYs+3+b50mJJ+tn/8lp51Oz
 JF7Mn2IE647CB1lEDXoZxlwkndNfzmR0yVE=

--CnbxGUW0xME77vNKzjfL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Venkata Pyla <venkata.pyla@toshiba-tsip.com>

Patch series for Security changes for IEC-62443-4-2 evaluation

Kazuhiro Hayashi (1):
  cip-security: Add packages for IEC-62443-4-2 evaluation

Venkata Pyla (2):
  start-qemu.sh: Use 'TARGET_IMAGE' to pick respective image file
  README: Add steps to build cip-security image

 README.md                                     | 10 ++++++
 .../images/cip-core-image-security.bb         | 36 +++++++++++++++++++
 start-qemu.sh                                 |  6 +++-
 3 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 recipes-core/images/cip-core-image-security.bb

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


--CnbxGUW0xME77vNKzjfL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5020): https://lists.cip-project.org/g/cip-dev/message=
/5020
Mute This Topic: https://lists.cip-project.org/mt/75820360/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--CnbxGUW0xME77vNKzjfL--
