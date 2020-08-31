Return-Path: <SRS0=o1lo=CJ=lists.cip-project.org=bounce+64572+5336+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D525C433E6
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 09:21:29 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ECA2208DB
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 09:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="V/JiXtaH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECA2208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5336+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 2oPPYY4521723xVLTfWDD1aA; Mon, 31 Aug 2020 02:21:29 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web12.49629.1598865686654339619
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Aug 2020 02:21:27 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 07V9LNk7030070
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2020 11:21:24 +0200
X-Received: from md1f2u6c.ad001.siemens.net ([167.87.39.104])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07V9LMgO030412;
	Mon, 31 Aug 2020 11:21:23 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [isar-cip-core][PATCH 0/3] ci fixes
Date: Mon, 31 Aug 2020 11:21:19 +0200
Message-Id: <cover.1598865682.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 5wb8YsG90lvQtr7QdbbeiLDIx4520388AA=
Content-Type: multipart/mixed; boundary="tCPIh7DbnSkypbZpV4jh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598865689;
 bh=v2LN8WJbJnq5d5pg4Zuo9Ojg7++76smW1F7MR6F+wrw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=V/JiXtaHlDVjDqKqePCB+aD9TS81G5QdTbtrRNQX/BIzu5BmVPtBELjkTAGma8uFTbh
 9JBzK5jZAK3CsxiBvkk0Dyr2hVQY8hq9QUcfAdICcWrSbv/pLKdpxBGiAAtPZIftC4SiU
 tdxLwoxJL3M+pWUlDlquHGYLJMdWBuSXOk0=

--tCPIh7DbnSkypbZpV4jh
Content-Transfer-Encoding: 8bit

This fixes ci, keeping the parallel build.

Obsoletes "ci: Fix hihope-rzg2m deployment".

Jan

Jan Kiszka (3):
  hihope-rzg2m: Align kas filename with machine name
  ci: Do not try to deploy the security image
  linux-cip Switch to gitlab source and update to 4.19.140-cip33

 .gitlab-ci.yml                                            | 8 +++++---
 kas/board/{rzg2m.yml => hihope-rzg2m.yml}                 | 0
 recipes-kernel/linux/linux-cip-common.inc                 | 4 +++-
 recipes-kernel/linux/linux-cip-rt-common.inc              | 2 --
 recipes-kernel/linux/linux-cip-rt_4.19.135-cip31-rt13.bb  | 2 +-
 recipes-kernel/linux/linux-cip-rt_4.4.231-cip47-rt30.bb   | 2 +-
 ...-cip_4.19.138-cip32.bb => linux-cip_4.19.140-cip33.bb} | 2 +-
 recipes-kernel/linux/linux-cip_4.4.230-cip47.bb           | 2 +-
 8 files changed, 12 insertions(+), 10 deletions(-)
 rename kas/board/{rzg2m.yml => hihope-rzg2m.yml} (100%)
 rename recipes-kernel/linux/{linux-cip_4.19.138-cip32.bb => linux-cip_4.19.140-cip33.bb} (67%)

-- 
2.26.2


--tCPIh7DbnSkypbZpV4jh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5336): https://lists.cip-project.org/g/cip-dev/message=
/5336
Mute This Topic: https://lists.cip-project.org/mt/76530562/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--tCPIh7DbnSkypbZpV4jh--
