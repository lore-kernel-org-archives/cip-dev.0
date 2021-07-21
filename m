Return-Path: <SRS0=HGur=MN=lists.cip-project.org=bounce+64572+6625+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4460C6377C
	for <cip-dev@archiver.kernel.org>; Wed, 21 Jul 2021 21:04:24 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F10F61285
	for <cip-dev@archiver.kernel.org>; Wed, 21 Jul 2021 21:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F10F61285
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6625+4520388+10495289@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id zOX9YY4521723xPTww6Qs26n; Wed, 21 Jul 2021 14:04:24 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web12.476.1626901463182335382
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Jul 2021 14:04:23 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 16LL4GCH022617
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 21 Jul 2021 23:04:16 +0200
X-Received: from [167.87.2.111] ([167.87.2.111])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 16LL4FQQ025643
	for <cip-dev@lists.cip-project.org>; Wed, 21 Jul 2021 23:04:16 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Subject: [cip-dev] [isar-cip-core][PATCH] ci: Print built kas configuration files
To: cip-dev <cip-dev@lists.cip-project.org>
Message-ID: <a3be5f26-1991-8b78-c502-6ed377c92859@siemens.com>
Date: Wed, 21 Jul 2021 23:04:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: bHw0DUZXfv61UghQH1AH69jhx4520388AA=
Content-Type: multipart/mixed; boundary="kRoGiQORzC95xsGavOTx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1626901464;
 bh=x5546o7YqWD7d/eIxgayQhXPWILblE3u2gPZh0d1K+4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=D47bRurWt5iGPIjVKh0dt5Tzq5C7V6TojUVqIPJJHXYWlEJdW0DGkJ0M2kKRHUJvMI+
 MdlepWue7tk2n0XwHY6ZFyiczQRM77F5JBaJLBFM6qXEEQQ/UTBEBpvI0OYTZpAc7qJg8
 0+EJ+R+EK3BWqHJbmQkmx71LvplUwx8fSGI=

--kRoGiQORzC95xsGavOTx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

From: Jan Kiszka <jan.kiszka@siemens.com>

Makes reproducing locally simpler.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3e98f79..40bf7f5 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -35,6 +35,7 @@ default:
     - if [ "${wic_targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/wic-targz-img.yml"; fi;
     - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi;
     - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi;
+    - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
     - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extention} ${dtb}; fi
 
-- 
2.26.2

--kRoGiQORzC95xsGavOTx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6625): https://lists.cip-project.org/g/cip-dev/message=
/6625
Mute This Topic: https://lists.cip-project.org/mt/84366352/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--kRoGiQORzC95xsGavOTx--
