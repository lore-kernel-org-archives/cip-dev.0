Return-Path: <SRS0=zm8O=KH=lists.cip-project.org=bounce+64572+6450+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC9FC433B4
	for <cip-dev@archiver.kernel.org>; Wed, 12 May 2021 17:01:35 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E26BB611BF
	for <cip-dev@archiver.kernel.org>; Wed, 12 May 2021 17:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26BB611BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6450+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8eb4YY4521723x1Pq0JhEZko; Wed, 12 May 2021 10:01:33 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.555.1620838892307299858
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 May 2021 10:01:32 -0700
X-IronPort-AV: E=Sophos;i="5.82,293,1613401200"; 
   d="scan'208";a="81095263"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 13 May 2021 02:01:29 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8EE8B40AB2F2;
	Thu, 13 May 2021 02:01:28 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 0/2] media: i2c: imx219: Trivial Fixes
Date: Wed, 12 May 2021 18:01:25 +0100
Message-Id: <20210512170127.16390-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: wS4wkeCMqLR3ZJmAKI8UVSanx4520388AA=
Content-Type: multipart/mixed; boundary="jgFVSClJcejydhfpQqWh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620838893;
 bh=8o1vh5a//4I2cdBfVLt63TzqLHacx0ckdEuMs7jny0w=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=WwIVMADwMqHAhpMCbVTv9B4X6lcJFvBalptSRI3lWUJONvwkBnKDUsGIQCdIBZuPQEB
 2bwVFR67lv4aHo5R9ZYxjG1tYoqA7FE6cma62fIwm8oBlH6cWnaR9EvcPk1IS46yjKipm
 UyeYfewxodPg2Q9jBtcjGIpQYzGvLTSR2lo=

--jgFVSClJcejydhfpQqWh

Hi All,

This patch series fixes trivial issues found in imx219 driver.

Both the patches have been cherry-picked from upstream kernel v5.13-rc1.

Cheers,
Prabhakar

Lad Prabhakar (2):
  media: i2c: imx219: Move out locking/unlocking of vflip and hflip
    controls from imx219_set_stream
  media: i2c: imx219: Balance runtime PM use-count

 drivers/media/i2c/imx219.c | 49 ++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 20 deletions(-)

-- 
2.17.1


--jgFVSClJcejydhfpQqWh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6450): https://lists.cip-project.org/g/cip-dev/message=
/6450
Mute This Topic: https://lists.cip-project.org/mt/82777615/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--jgFVSClJcejydhfpQqWh--
