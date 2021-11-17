Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E9EC433F5
	for <webhook@archiver.kernel.org>; Wed, 17 Nov 2021 10:54:29 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.5540.1637146466728968047
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Nov 2021 02:54:27 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158,
 mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 1AHAsNjN002232;
 Wed, 17 Nov 2021 19:54:24 +0900
X-Iguazu-Qid: 2wGrVQwHH5oKcyYzsB
X-Iguazu-QSIG: v=2; s=0; t=1637146463; q=2wGrVQwHH5oKcyYzsB;
 m=u6sFCrAd4EjdmCLV/wOTjXLMMYc8eHVwPPaNsNWWJ2A=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1111) id 1AHAsMks017821
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 17 Nov 2021 19:54:23 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id A56741000F8
	for <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 19:54:22 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 1AHAsMuA008778
	for <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 19:54:22 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 0/3] Security extensions for bullseye image
Date: Wed, 17 Nov 2021 16:24:34 +0530
X-TSB-HOP: ON
Message-Id: <20211117105437.4621-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <16B7FCBA2ADC61EA.22891@lists.cip-project.org>
References: <16B7FCBA2ADC61EA.22891@lists.cip-project.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 17 Nov 2021 10:54:20.0809 (UTC)
 FILETIME=[79A98790:01D7DBA1]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 10:54:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6938

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

This patch series enable security extension for bullseye image.

It fixes the below two problems
- package not found due to dependency package names are changed in
  bullseye version, so remove the dependency packages and allowed
  package manager to install correct package names.
- package not found due to main package name is changed in bullseye
  version, so install the packages based on DISTRO version selected.

venkata pyla (3):
  cip-core-image-security: remove unnecessary dependency package names
  cip-core-image-security: Install packages based on DISTRO version
  Kconfig: Enable Security extensions for bullseye image

 Kconfig                                        |  1 -
 recipes-core/images/cip-core-image-security.bb | 15 ++++++++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

-- 
2.20.1



