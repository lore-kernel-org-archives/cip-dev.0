Return-Path: <SRS0=B//U=LI=lists.cip-project.org=bounce+64572+6507+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30B9C48BE6
	for <cip-dev@archiver.kernel.org>; Mon, 14 Jun 2021 07:15:04 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AB3D61153
	for <cip-dev@archiver.kernel.org>; Mon, 14 Jun 2021 07:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB3D61153
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6507+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Akh7YY4521723xOD0087xieo; Mon, 14 Jun 2021 00:15:03 -0700
X-Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web10.26709.1623654902724375973
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jun 2021 00:15:03 -0700
IronPort-SDR: d6muIUEQVfwwoYGgUi56oY8UDukWlj2ho1LaoOBIgGoEO/Grp12ndQZsHi14Uks/uLABiWzcad
 4o9I6IRnvCjqdRLBOzyOZpxxoda9t3b7pX041knMn8247nIGUR99Vg3vkkyqZeCgfSr/7vist0
 76KK+KI+BJxyiYYnrarXYnYnIXXVsc+USFtR0EC8ilPlAHfsUYOLqjmfQexlm1bhFgXaR7/6Uk
 r5cz6jR4dcw55kEWC49YJXd+PiQ9Xx+S7YvduX4ba4LMSn7DZ5UkTIvj2QII/+7Kxk8QJfj6hs
 nSw=
X-IronPort-AV: E=Sophos;i="5.83,272,1616486400"; 
   d="scan'208";a="62328471"
X-Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 13 Jun 2021 23:15:01 -0800
IronPort-SDR: 0gwTLLskmdpuGvVD6htzd9MpiVAL0wHZx9FCKUGO/6nemYu1XWcSN/vRrlBAFwJJXLrW7uuGEr
 E1vtPnP7BedaONWkH5MMJwb15O7ifZlrV8NOdmXCyfXnbNg2t52TX/C692ocC+cQa/Q2Ku0pEo
 rD5TrGvY8Ga51W6KWqMgFoibKSYACeVeQnh5qJ0qwtO3ZrepYfNiHjkpUCMH0sBQiaX0XiKEJx
 53wfAgIvVMzmtAHl/ymy7AdH5Kw6qs/Rp4EMAYlLHr5TJ0iaVAKKtk0bA0AlH+GN0znpNnOwpa
 9uc=
From: "Srinuvasan A" <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: Srinuvasan A <srinuvasan_a@mentor.com>
Subject: [cip-dev] [isar-cip-dev][PATCH] efibootguard: Update to latest release 0.8
Date: Mon, 14 Jun 2021 12:44:31 +0530
Message-ID: <20210614071431.1192712-1-Srinuvasan_A@mentor.com>
MIME-Version: 1.0
X-ClientProxiedBy: svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KMZViwXTsqvqTppXfpgo0ayPx4520388AA=
Content-Type: multipart/mixed; boundary="WFnKV0WMHXbUs8kS3XVZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623654903;
 bh=HwtoHVFFU+oGS9iAiTG3ULO3B9LLi2BMeSbRil6C7CA=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=YPK0iYxbhdhbKRDZjEcSFUCNHMaAuyRHoAFQ13gT1HdzRT+1Rkl9q06p1kU+EH0yIVJ
 enx/siBhbfV+EE3Aanhlh/38SXtku2U3Mvzp0HRa3FKZMDtHKT4sGaR7cUIxbsj34XRRi
 9oIpXLhR7s6jS4fTFVjhzKuck1EWjeydEL4=

--WFnKV0WMHXbUs8kS3XVZ
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Srinuvasan A <srinuvasan_a@mentor.com>

Uprevision the latest revision and tag.

Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
---
 ...fibootguard_0.7-git+isar.bb => efibootguard_0.8-git+isar.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-bsp/efibootguard/{efibootguard_0.7-git+isar.bb => efibootguard_0.8-git+isar.bb} (95%)

diff --git a/recipes-bsp/efibootguard/efibootguard_0.7-git+isar.bb b/recipes-bsp/efibootguard/efibootguard_0.8-git+isar.bb
similarity index 95%
rename from recipes-bsp/efibootguard/efibootguard_0.7-git+isar.bb
rename to recipes-bsp/efibootguard/efibootguard_0.8-git+isar.bb
index 4bdf76a..ebd848d 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.7-git+isar.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.8-git+isar.bb
@@ -22,7 +22,7 @@ SRC_URI = "git://github.com/siemens/efibootguard.git;branch=master;protocol=http
 
 S = "${WORKDIR}/git"
 
-SRCREV = "442e87bafb480ada2b9074f02350a30408d4cf9c"
+SRCREV = "ac1685aea75fb3e3d16c0c0e4f8261a2edb63536"
 
 PROVIDES = "${PN}"
 PROVIDES += "${PN}-dev"
-- 
2.25.1


--WFnKV0WMHXbUs8kS3XVZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6507): https://lists.cip-project.org/g/cip-dev/message=
/6507
Mute This Topic: https://lists.cip-project.org/mt/83525241/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--WFnKV0WMHXbUs8kS3XVZ--
