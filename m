Return-Path: <SRS0=xurB=AT=lists.cip-project.org=bounce+64572+4908+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB668C433DF
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:50 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE45206DF
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="tRQxfUE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE45206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4908+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id nbuPYY4521723xfWWITlmAbn; Wed, 08 Jul 2020 08:46:48 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web10.13566.1594223184843829955
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2020 08:46:25 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id CF9486098A; Wed,  8 Jul 2020 23:46:17 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip 23/23] PM / OPP: Update voltage in case freq == old_freq
Date: Wed,  8 Jul 2020 23:45:54 +0800
Message-Id: <20200708154554.26450-24-wens@csie.org>
In-Reply-To: <20200708154554.26450-1-wens@csie.org>
References: <20200708154554.26450-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: nTN8Bq5XZBG7IX8ZiSlaRECAx4520388AA=
Content-Type: multipart/mixed; boundary="lGMLUifeaeBH7HYjK8Dv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594223208;
 bh=pUXZEYdVMRzshE+bj8B4qbsWZEBHtdva3W7XgASaMCk=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=tRQxfUE1u0gPhI20IAZ9A0XXaU+9HdWggVcNKCsveBP/kX4lC77rJ0uq6BZgxMAHcSv
 iwH8PxHhUMmijL+VvWLGCk096zYqgF4o2GC/vFDPMmV3haLX0zlHpIDiC8OF2PBuKfLdW
 6C914HqxNDacpoHNltoeE80g3l6lqqD+Z7o=

--lGMLUifeaeBH7HYjK8Dv
Content-Transfer-Encoding: quoted-printable

From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>

commit c5c2a97b3ac7d1ec19e7cff9e38caca6afefc3de upstream.

This commit fixes a rare but possible case when the clk rate is updated
without update of the regulator voltage.

At boot up, CPUfreq checks if the system is running at the right freq. Th=
is
is a sanity check in case a bootloader set clk rate that is outside of fr=
eq
table present with cpufreq core. In such cases system can be unstable so
better to change it to a freq that is preset in freq-table.

The CPUfreq takes next freq that is >=3D policy->cur and this is our
target_freq that needs to be set now.

dev_pm_opp_set_rate(dev, target_freq) checks the target_freq and the
old_freq (a current rate). If these are equal it returns early. If not,
it searches for OPP (old_opp) that fits best to old_freq (not listed in
the table) and updates old_freq (!).

Here, we can end up with old_freq =3D old_opp.rate =3D target_freq, which
is not handled in _generic_set_opp_regulator(). It's supposed to update
voltage only when freq > old_freq  || freq > old_freq.

if (freq > old_freq) {
		ret =3D _set_opp_voltage(dev, reg, new_supply);
[...]
if (freq < old_freq) {
		ret =3D _set_opp_voltage(dev, reg, new_supply);
		if (ret)

It results in, no voltage update while clk rate is updated.

Example:
freq-table =3D {
	1000MHz   1.15V
	 666MHZ   1.10V
	 333MHz   1.05V
}
boot-up-freq        =3D 800MHz   # not listed in freq-table
freq =3D target_freq  =3D 1GHz
old_freq            =3D 800Mhz
old_opp =3D _find_freq_ceil(opp_table, &old_freq);  #(old_freq is modifie=
d!)
old_freq            =3D 1GHz

Fixes: 6a0712f6f199 ("PM / OPP: Add dev_pm_opp_set_rate()")
Cc: 4.6+ <stable@vger.kernel.org> # v4.6+
Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/base/power/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.=
c
index c91eacf8d2ed3..e93eba1ade4a0 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -661,7 +661,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned =
long target_freq)
 	rcu_read_unlock();
=20
 	/* Scaling up? Scale voltage before frequency */
-	if (freq > old_freq) {
+	if (freq >=3D old_freq) {
 		ret =3D _set_opp_voltage(dev, reg, u_volt, u_volt_min,
 				       u_volt_max);
 		if (ret)
--=20
2.27.0


--lGMLUifeaeBH7HYjK8Dv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4908): https://lists.cip-project.org/g/cip-dev/message=
/4908
Mute This Topic: https://lists.cip-project.org/mt/75379100/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--lGMLUifeaeBH7HYjK8Dv--
