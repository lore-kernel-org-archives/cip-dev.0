Return-Path: <SRS0=KISx=MN=lists.cip-project.org=bounce+64572+6624+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3387FC6377A
	for <cip-dev@archiver.kernel.org>; Wed, 21 Jul 2021 21:04:18 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF6AC61263
	for <cip-dev@archiver.kernel.org>; Wed, 21 Jul 2021 21:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6AC61263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6624+4520388+10495289@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Kb26YY4521723xNq8tNIKuwQ; Wed, 21 Jul 2021 14:04:17 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web09.439.1626901456400246244
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Jul 2021 14:04:17 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 16LL4D3P014353
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 21 Jul 2021 23:04:14 +0200
X-Received: from [167.87.2.111] ([167.87.2.111])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 16LL4DYP025639
	for <cip-dev@lists.cip-project.org>; Wed, 21 Jul 2021 23:04:13 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Subject: [cip-dev] [isar-cip-core][PATCH] ci: Fix kernel image deployment
To: cip-dev <cip-dev@lists.cip-project.org>
Message-ID: <653ad3c7-9694-3d14-ba85-75c048471aa1@siemens.com>
Date: Wed, 21 Jul 2021 23:04:13 +0200
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
X-Gm-Message-State: 4qTuMXwfjCHii5LFpI01BVMlx4520388AA=
Content-Type: multipart/mixed; boundary="mUpw9azgeYUvieDXxRiQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1626901457;
 bh=bqqxd3dSNdyPV79aFr9fCyVTkNdkiUaHydU22VBAwKA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Y9/kz+ZkKHzZ0d8w2s8pfOd4YOnXczdW9fPrMvaZqV6fcB4wxgCE8O5gSyaN8g3gIaI
 Jomx/0E3vB6Px7WfDY0Droegwsznh18njO5xkyjMYpaQng2ho9YSuYTmVLeBfo0szbHS3
 a1AoDd2uno9IssvFIcUt0UBz54Eheg3fR3Q=

--mUpw9azgeYUvieDXxRiQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

From: Jan Kiszka <jan.kiszka@siemens.com>

Uncompressed kernels are correctly named vmlinux by recent Isar.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/deploy-cip-core.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index 0b8bbe6..47cf5ee 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -43,7 +43,7 @@ if [ -f $BASE_PATH.tar.gz ]; then
 	aws s3 cp --no-progress $BASE_PATH.tar.gz s3://download.cip-project.org/cip-core/$TARGET/
 fi
 
-KERNEL_IMAGE=$BASE_PATH-vmlinuz
+KERNEL_IMAGE="$BASE_PATH-vmlinu[xz]"
 # iwg20m workaround
 if [ -f build/tmp/deploy/images/$TARGET/zImage ]; then
 	KERNEL_IMAGE=build/tmp/deploy/images/$TARGET/zImage
-- 
2.26.2

--mUpw9azgeYUvieDXxRiQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6624): https://lists.cip-project.org/g/cip-dev/message=
/6624
Mute This Topic: https://lists.cip-project.org/mt/84366349/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--mUpw9azgeYUvieDXxRiQ--
