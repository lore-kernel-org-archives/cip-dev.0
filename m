Return-Path: <SRS0=nabS=CS=lists.cip-project.org=bounce+64572+5420+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405B3C43461
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 04:44:45 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF75B21D43
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 04:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="G5rs2uqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF75B21D43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5420+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Mwy7YY4521723xj51tdEtXW2; Tue, 08 Sep 2020 21:44:44 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web10.6632.1599626681622662730
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Sep 2020 21:44:42 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id B94085FA80; Wed,  9 Sep 2020 12:44:32 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com,
	victor.yu@moxa.com,
	wens@csie.org
Subject: [cip-dev] [PATCH 4.4.y-cip 02/11] PM / OPP: Expose _of_get_opp_desc_node as dev_pm_opp API
Date: Wed,  9 Sep 2020 12:42:24 +0800
Message-Id: <20200909044233.4115-3-wens@csie.org>
In-Reply-To: <20200909044233.4115-1-wens@csie.org>
References: <20200909044233.4115-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: K1FP7ZmPdiDLHvrWTAKwms5Ix4520388AA=
Content-Type: multipart/mixed; boundary="oMsON1xxzYRUdBXxWrjk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599626684;
 bh=fXTOsf+at71gORDtvABy/QQAfJRdkJLPALVTqYAR92k=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=G5rs2uqzVn0ttJfhojp8KK2IJ5Zak+jAU8YSq1Tm6j7HItj2uFHlvFJ9ii5JlV7LgHq
 wNTWyKVGBEIcIHhEcuO9ry1xckJLBbnV/tTpqoZt30r+03Llngu/EI0dcQGxVT/k9tkqO
 oEvVa/Tfv0oxyNL6plLbI6AFO/E0szsQS50=

--oMsON1xxzYRUdBXxWrjk
Content-Transfer-Encoding: quoted-printable

From: Dave Gerlach <d-gerlach@ti.com>

commit 0764c604c8128f17fd740ff8b1701d0a1301eb7e upstream.

Rename _of_get_opp_desc_node to dev_pm_opp_of_get_opp_desc_node and add i=
t
to include/linux/pm_opp.h to allow other drivers, such as platform OPP
and cpufreq drivers, to make use of it.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[wens@csie.org: backported to pre-OF-move files]
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/base/power/opp/core.c | 5 +++--
 drivers/base/power/opp/cpu.c  | 4 ++--
 include/linux/pm_opp.h        | 6 ++++++
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.=
c
index f983d5d30fa94..c41bf5f1a038d 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -1488,7 +1488,7 @@ unlock:
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
=20
 /* Returns opp descriptor node for a device, caller must do of_node_put(=
) */
-struct device_node *_of_get_opp_desc_node(struct device *dev)
+struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
 {
 	/*
 	 * TODO: Support for multiple OPP tables.
@@ -1499,6 +1499,7 @@ struct device_node *_of_get_opp_desc_node(struct de=
vice *dev)
=20
 	return of_parse_phandle(dev->of_node, "operating-points-v2", 0);
 }
+EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_opp_desc_node);
=20
 /* Initializes OPP tables based on new bindings */
 static int _of_add_opp_table_v2(struct device *dev, struct device_node *=
opp_np)
@@ -1627,7 +1628,7 @@ int dev_pm_opp_of_add_table(struct device *dev)
 	 * OPPs have two version of bindings now. The older one is deprecated,
 	 * try for the new binding first.
 	 */
-	opp_np =3D _of_get_opp_desc_node(dev);
+	opp_np =3D dev_pm_opp_of_get_opp_desc_node(dev);
 	if (!opp_np) {
 		/*
 		 * Try old-deprecated bindings for backward compatibility with
diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index a0db8b3575f38..29c5b42eff346 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -227,7 +227,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu=
_dev, cpumask_var_t cpumask
 	int cpu, ret =3D 0;
=20
 	/* Get OPP descriptor node */
-	np =3D _of_get_opp_desc_node(cpu_dev);
+	np =3D dev_pm_opp_of_get_opp_desc_node(cpu_dev);
 	if (!np) {
 		dev_dbg(cpu_dev, "%s: Couldn't find cpu_dev node.\n", __func__);
 		return -ENOENT;
@@ -252,7 +252,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu=
_dev, cpumask_var_t cpumask
 		}
=20
 		/* Get OPP descriptor node */
-		tmp_np =3D _of_get_opp_desc_node(tcpu_dev);
+		tmp_np =3D dev_pm_opp_of_get_opp_desc_node(tcpu_dev);
 		if (!tmp_np) {
 			dev_err(tcpu_dev, "%s: Couldn't find tcpu_dev node.\n",
 				__func__);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 95403d2ccaf56..4a8f5b33d7023 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -160,6 +160,7 @@ int dev_pm_opp_of_cpumask_add_table(cpumask_var_t cpu=
mask);
 void dev_pm_opp_of_cpumask_remove_table(cpumask_var_t cpumask);
 int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t=
 cpumask);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cp=
umask);
+struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
 #else
 static inline int dev_pm_opp_of_add_table(struct device *dev)
 {
@@ -188,6 +189,11 @@ static inline int dev_pm_opp_set_sharing_cpus(struct=
 device *cpu_dev, cpumask_va
 {
 	return -ENOSYS;
 }
+
+static inline struct device_node *dev_pm_opp_of_get_opp_desc_node(struct=
 device *dev)
+{
+	return NULL;
+}
 #endif
=20
 #endif		/* __LINUX_OPP_H__ */
--=20
2.28.0


--oMsON1xxzYRUdBXxWrjk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5420): https://lists.cip-project.org/g/cip-dev/message=
/5420
Mute This Topic: https://lists.cip-project.org/mt/76726424/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--oMsON1xxzYRUdBXxWrjk--
