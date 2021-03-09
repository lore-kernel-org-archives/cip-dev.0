Return-Path: <SRS0=gMhn=IH=lists.cip-project.org=bounce+64572+6239+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDACC433E0
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:31 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D0264FF3
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D0264FF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6239+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id DhgLYY4521723xptwPn7FC3J; Tue, 09 Mar 2021 08:37:31 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11726.1615307822860198874
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:30 -0800
X-IronPort-AV: E=Sophos;i="5.81,236,1610377200"; 
   d="scan'208";a="74591029"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:29 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E782940A2DC7;
	Wed, 10 Mar 2021 01:37:28 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 23/40] media: rcar-vin: Enable support for r8a774a1
Date: Tue,  9 Mar 2021 16:36:39 +0000
Message-Id: <20210309163656.20944-24-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: d9n2rOXAXHmGZVFnvsekWblxx4520388AA=
Content-Type: multipart/mixed; boundary="ZCTriWcOd9e4ZJNBhe7F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307851;
 bh=QMfXIy2m0YVNZgyS1+S8H2evIMfVtPGiS+s/RZaGySY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=LLbSckKanHXdBwuQVo1TwMdvP/sbfJF7KKkQH00ScjXvCKTW7CPe2ErPaC4laF4KRLq
 Zoou6sAwO5tZ0N2utvVRNpP+rPKJty6hMv2HOZhXY0QCyW2hpa0nysdeg38LRHdLSsr3I
 q9HQdqOS5SzWE2W5tBDIKRf6vPTMfwhXgkg=

--ZCTriWcOd9e4ZJNBhe7F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das@bp.renesas.com>

commit f29a317b9c33be536ab516a89a921719f907137e upstream.

Add the SoC specific information for RZ/G2M(r8a774a1) SoC.
The VIN module of RZ/G2M is similar to R-Car M3-W.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Acked-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/platform/rcar-vin/rcar-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/rcar-vin/rcar-core.c b/drivers/media/platform/rcar-vin/rcar-core.c
index 79d1a8a730ad..c8856fed737f 100644
--- a/drivers/media/platform/rcar-vin/rcar-core.c
+++ b/drivers/media/platform/rcar-vin/rcar-core.c
@@ -1118,6 +1118,10 @@ static const struct rvin_info rcar_info_r8a77995 = {
 };
 
 static const struct of_device_id rvin_of_id_table[] = {
+	{
+		.compatible = "renesas,vin-r8a774a1",
+		.data = &rcar_info_r8a7796,
+	},
 	{
 		.compatible = "renesas,vin-r8a774c0",
 		.data = &rcar_info_r8a77990,
-- 
2.17.1


--ZCTriWcOd9e4ZJNBhe7F
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6239): https://lists.cip-project.org/g/cip-dev/message=
/6239
Mute This Topic: https://lists.cip-project.org/mt/81205371/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ZCTriWcOd9e4ZJNBhe7F--
