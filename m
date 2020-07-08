Return-Path: <SRS0=iVFk=AT=lists.cip-project.org=bounce+64572+4902+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEF6C433E0
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:46 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1A0D206DF
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="u1IbFfLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A0D206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4902+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ewAGYY4521723xwrPFGktmvX; Wed, 08 Jul 2020 08:46:43 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web12.13610.1594223184599031560
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2020 08:46:24 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 9AE726045E; Wed,  8 Jul 2020 23:46:17 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip 17/23] PM / OPP: Fix NULL pointer dereference crash when disabling OPPs
Date: Wed,  8 Jul 2020 23:45:48 +0800
Message-Id: <20200708154554.26450-18-wens@csie.org>
In-Reply-To: <20200708154554.26450-1-wens@csie.org>
References: <20200708154554.26450-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: EIIvjqnpKoh3lrcjGqBfy4vCx4520388AA=
Content-Type: multipart/mixed; boundary="W3yrsB5auc8zHB9mr2Hr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594223203;
 bh=A6rKSe9AUtrobWxxbCAitr/Xr0ngeK7uFZvRRQDZynk=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=u1IbFfLKm1cuQN6dYW1buN9yWQm3yLmCbXk2HngkOKKgjqpsov2qdjZZ5IFyLCN1vKB
 igoTTKMuNPMLlwBHYosPGa6vJiMPpkjhuJyKfCQw64g+nDTRRbSJoXEg5z8a5fnx+kWVQ
 oJIkcL8jXFLukWA0f+HLehfKr4eUbc6hkV4=

--W3yrsB5auc8zHB9mr2Hr
Content-Transfer-Encoding: quoted-printable

From: Jon Hunter <jonathanh@nvidia.com>

commit 78ecc56247f0ec2bc0cf6f2f2af69e98d99767bc upstream.

Commit 7d34d56ef334 (PM / OPP: Disable OPPs that aren't supported by
the regulator) causes a crash to happen on Tegra124 Jetson TK1 when
using the DFLL clock source for the CPU.  The DFLL manages the voltage
itself and so there is no regulator specified for the OPPs and so we
get a crash when we try to dereference the regulator pointer.  Fix
this by checking to see if the regulator IS_ERR_OR_NULL before
dereferencing it.

Fixes: 7d34d56ef334 (PM / OPP: Disable OPPs that aren't supported by the =
regulator)
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Reported-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
[ rjw: Changelog ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/base/power/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.=
c
index 91b4cc261d84a..067379f931662 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -975,7 +975,7 @@ static bool _opp_supported_by_regulators(struct dev_p=
m_opp *opp,
 {
 	struct regulator *reg =3D dev_opp->regulator;
=20
-	if (!IS_ERR(reg) &&
+	if (!IS_ERR_OR_NULL(reg) &&
 	    !regulator_is_supported_voltage(reg, opp->u_volt_min,
 					    opp->u_volt_max)) {
 		pr_warn("%s: OPP minuV: %lu maxuV: %lu, not supported by regulator\n",
--=20
2.27.0


--W3yrsB5auc8zHB9mr2Hr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4902): https://lists.cip-project.org/g/cip-dev/message=
/4902
Mute This Topic: https://lists.cip-project.org/mt/75379094/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--W3yrsB5auc8zHB9mr2Hr--
