Return-Path: <SRS0=/DRZ=7V=lists.cip-project.org=bounce+64572+4760+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF375C433E5
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 12:01:37 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B1B2078C
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 12:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="BEhvI2fG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B1B2078C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4760+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ewyUYY4521723xX5lZrLHtH2; Mon, 08 Jun 2020 05:01:37 -0700
X-Received: from wens.tw (wens.tw [140.112.30.76])
 by mx.groups.io with SMTP id smtpd.web12.26178.1591607691003528656
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2020 02:14:51 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id CB64D5FEF3; Mon,  8 Jun 2020 17:14:43 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip v2 06/15] PM / OPP: Add missing doc comments
Date: Mon,  8 Jun 2020 17:14:23 +0800
Message-Id: <20200608091432.15366-7-wens@csie.org>
In-Reply-To: <20200608091432.15366-1-wens@csie.org>
References: <20200608091432.15366-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: im5E6sOeTJIcO2o78XgIJqltx4520388AA=
Content-Type: multipart/mixed; boundary="WmzRtnw9mTWCP44ZpeVm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591617697;
 bh=IZpFhgI/sXw6yyODDS98balCfMog2anDKDVm9KUoZ+8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=BEhvI2fG42/Pe4Dt/PBWSwJyZ8Fo6sHDKALQdSjATLpaJ2bPOcWYgf6vco4wu/Ec3O4
 o0a5aZtKx2EYG5qEQG5zk1dK9l46f94bBcmF+aSSimvECW2i7oQOakh2eL68NONOHpcIs
 NGrz1WYB3eTG7ZT380VvjCZt3WlRgrMXCbw=

--WmzRtnw9mTWCP44ZpeVm
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit dc4e7b1fa20a840d2317fcfdaa1064fc09d2afcb upstream.

Few doc-style comments were missing, add them. Rearrange another one to
match the sequence within the structure.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/base/power/opp/opp.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index a6bd8d2c2b47f..b8880c7f8be1c 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -51,8 +51,8 @@ extern struct mutex dev_opp_list_lock;
  *		are protected by the dev_opp_list_lock for integrity.
  *		IMPORTANT: the opp nodes should be maintained in increasing
  *		order.
- * @dynamic:	not-created from static DT entries.
  * @available:	true/false - marks if this OPP as available or not
+ * @dynamic:	not-created from static DT entries.
  * @turbo:	true if turbo (boost) OPP
  * @suspend:	true if suspend OPP
  * @rate:	Frequency in hertz
@@ -126,7 +126,9 @@ struct device_list_opp {
  * @dev_list:	list of devices that share these OPPs
  * @opp_list:	list of opps
  * @np:		struct device_node pointer for opp's DT node.
+ * @clock_latency_ns_max: Max clock latency in nanoseconds.
  * @shared_opp: OPP is shared between multiple devices.
+ * @suspend_opp: Pointer to OPP to be used during device suspend.
  * @dentry:	debugfs dentry pointer of the real device directory (not lin=
ks).
  * @dentry_name: Name of the real dentry.
  *
--=20
2.27.0.rc0


--WmzRtnw9mTWCP44ZpeVm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4760): https://lists.cip-project.org/g/cip-dev/message=
/4760
Mute This Topic: https://lists.cip-project.org/mt/74748504/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--WmzRtnw9mTWCP44ZpeVm--
