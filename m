Return-Path: <SRS0=5l9T=7R=lists.cip-project.org=bounce+64572+4706+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC913C433E2
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 11:55:34 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B01DA2075B
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 11:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="w4qD40Wf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01DA2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4706+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id jjw5YY4521723xicBHDrO9mV; Thu, 04 Jun 2020 04:55:34 -0700
X-Received: from wens.tw (wens.tw [140.112.30.76])
 by mx.groups.io with SMTP id smtpd.web12.6392.1591240765980901380
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2020 20:19:26 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id E28795FE3B; Thu,  4 Jun 2020 11:19:19 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com,
	Pavel Machek <pavel@ucw.cz>,
	Stephen Boyd <sboyd@codeaurora.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Chen-Yu Tsai <wens@csie.org>
Subject: [cip-dev] [4.4.y-cip 06/15] PM / OPP: Add missing doc comments
Date: Thu,  4 Jun 2020 11:18:20 +0800
Message-Id: <20200604031829.3254-7-wens@csie.org>
In-Reply-To: <20200604031829.3254-1-wens@csie.org>
References: <20200604031829.3254-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: tFrW8u19apRcoDrXjd2fpx8ux4520388AA=
Content-Type: multipart/mixed; boundary="fICDitGL3fxKjy4VQIbo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591271734;
 bh=f6rq9mRWZ4owjTuPBpP7nuA7sxGo5g/xGOo06NsOK2I=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=w4qD40Wfto9+EXKP3MuxuOEjrSX9N0yh48+m2ps2mYJPapeS8Bdn0cCqN5JsCdMEOtw
 wtZCYdm50HDsOusQ8jDq2WS//Vtyxb+/xwo0urOIbVDZWzYOoCzaVCz00PRlCR7FznddW
 DiQo566S4PhzEKYc1iDft1XI/pbZ0+dSNxE=

--fICDitGL3fxKjy4VQIbo
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


--fICDitGL3fxKjy4VQIbo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4706): https://lists.cip-project.org/g/cip-dev/message=
/4706
Mute This Topic: https://lists.cip-project.org/mt/74669304/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--fICDitGL3fxKjy4VQIbo--
