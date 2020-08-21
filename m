Return-Path: <SRS0=5Ikb=B7=lists.cip-project.org=bounce+64572+5224+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF08C433E1
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 15:12:37 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 567FA207DE
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 15:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Krc5HlL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567FA207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5224+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id DbUOYY4521723x2rV11DqtgX; Fri, 21 Aug 2020 08:12:37 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web11.135909.1598022753366043494
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 08:12:34 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 07LFCUvU002186
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 21 Aug 2020 17:12:31 +0200
X-Received: from [139.22.122.86] ([139.22.122.86])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07LFCUTr022411;
	Fri, 21 Aug 2020 17:12:30 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Subject: [cip-dev] [PATCH][isar-cip-core] swupdate: Add missing build dependency
To: cip-dev <cip-dev@lists.cip-project.org>,
        Quirin Gylstorff <quirin.gylstorff@siemens.com>
Message-ID: <86cc968b-1dbb-ac71-fd80-d29397ce4073@siemens.com>
Date: Fri, 21 Aug 2020 17:12:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 8Qtec1IeOUzoZmA3LEXu6KZnx4520388AA=
Content-Type: multipart/mixed; boundary="ZWKWB3nfSlJf9mvcnRqK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598022757;
 bh=0HVKBml3DL5k1LmHLfIBXJAOOTWUrICZziq/fR9gmCE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Krc5HlL1rc8EBYMYhDhYEuTIKIgTUpXX5bp1zKF4jTrKxF+A+hejFCqeYLg1mS2E4++
 dPDuZBpsqW/a+rqmC9nKPp7SdiYZAxzqnMuYqAI6QVPq1UGpahtoPtmjSyCQo1PcW5Da0
 hB9H8jlsxBe43QuV6dZvCnv8JKbt8eiwakM=

--ZWKWB3nfSlJf9mvcnRqK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Quirin, please check if this is actually an unconditional dep!

 classes/swupdate-config.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/swupdate-config.bbclass b/classes/swupdate-config.bbclass
index 7ce51c5..42f0654 100644
--- a/classes/swupdate-config.bbclass
+++ b/classes/swupdate-config.bbclass
@@ -15,7 +15,7 @@ inherit kconfig-snippets
 
 BUILD_DEB_DEPENDS = " \
     zlib1g-dev, debhelper, libconfig-dev, libarchive-dev, \
-    python-sphinx:native, dh-systemd, libsystemd-dev"
+    python-sphinx:native, dh-systemd, libsystemd-dev, libssl-dev"
 
 KFEATURE_lua = ""
 KFEATURE_lua[BUILD_DEB_DEPENDS] = "liblua5.3-dev"
-- 
2.26.2

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--ZWKWB3nfSlJf9mvcnRqK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5224): https://lists.cip-project.org/g/cip-dev/message=
/5224
Mute This Topic: https://lists.cip-project.org/mt/76330796/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--ZWKWB3nfSlJf9mvcnRqK--
