Return-Path: <SRS0=Y5Y9=GX=lists.cip-project.org=bounce+64572+6113+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4A8C433E0
	for <cip-dev@archiver.kernel.org>; Wed, 20 Jan 2021 08:34:50 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 068A322202
	for <cip-dev@archiver.kernel.org>; Wed, 20 Jan 2021 08:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068A322202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6113+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id VYCGYY4521723xCda3AGL9gi; Wed, 20 Jan 2021 00:34:48 -0800
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web11.25184.1611131686572521600
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Jan 2021 00:34:47 -0800
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 10K8YiAs004555
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 20 Jan 2021 09:34:44 +0100
X-Received: from md2dvrtc.ad001.siemens.net ([139.22.114.182])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 10K8YhY5009837;
	Wed, 20 Jan 2021 09:34:44 +0100
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v3 0/4] Updates & Fixes
Date: Wed, 20 Jan 2021 09:34:39 +0100
Message-Id: <20210120083443.8105-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 8GuCeZ4gkZwmEZCKUe7LyjGHx4520388AA=
Content-Type: multipart/mixed; boundary="Tqpik3g5g0khP7WEEwZC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611131688;
 bh=Ru/t1koZiVKB6EmHUqf90TsmhrxyT3jHrE8y9ubIni0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=hAkWYCYrB0G0LuTRNqhFj0AbxTs2W2ABAqFsDGMOjyTYIWJxp5nEhuDFTA17Pem96QD
 xT4t2M3bdi9/9uq9B7phtTRIilhWwpurRBUCXAa2e09FneiiuYKYTxHfQC1lyPzmCnebG
 P8cu5MRjDLiHPDYKB/7i3/wKx5rjCkoOXOs=

--Tqpik3g5g0khP7WEEwZC
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>


- Update Kernel releases
- Update ISAR to current HEAD of next

- fix swupdate cross-compile
- use libubootenv for swupdate & u-boot this works only with upstream u-boot-tools
  newer than 2019.10. The isar build is fixed with commit e77d030ed0ac5b122aa7b798131062946cb36699.

Changes V2:
- fix recipe name,  add missing rt
Changes V3:
- fix recipe name,  replace . with -

Quirin Gylstorff (4):
  swupdate: enable cross-compile by setting PKG_CONFIG_PATH
  swupdate: use libubootenv
  update linux kernels
  kas: update ISAR

 classes/swupdate-config.bbclass                             | 6 +++---
 kas-cip.yml                                                 | 2 +-
 recipes-core/swupdate/files/debian/rules.tmpl               | 1 +
 recipes-core/swupdate/swupdate.bb                           | 2 +-
 ...35-cip31-rt13.bb => linux-cip-rt_4.19.160-cip39-rt17.bb} | 4 ++--
 ...231-cip47-rt30.bb => linux-cip-rt_4.4.244-cip51-rt32.bb} | 4 ++--
 ...ux-cip_4.19.140-cip33.bb => linux-cip_4.19.165-cip41.bb} | 4 ++--
 ...inux-cip_4.4.230-cip47.bb => linux-cip_4.4.249-cip53.bb} | 4 ++--
 8 files changed, 14 insertions(+), 13 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.135-cip31-rt13.bb => linux-cip-rt_4.19.160-cip39-rt17.bb} (54%)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.231-cip47-rt30.bb => linux-cip-rt_4.4.244-cip51-rt32.bb} (54%)
 rename recipes-kernel/linux/{linux-cip_4.19.140-cip33.bb => linux-cip_4.19.165-cip41.bb} (53%)
 rename recipes-kernel/linux/{linux-cip_4.4.230-cip47.bb => linux-cip_4.4.249-cip53.bb} (53%)

-- 
2.20.1


--Tqpik3g5g0khP7WEEwZC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6113): https://lists.cip-project.org/g/cip-dev/message=
/6113
Mute This Topic: https://lists.cip-project.org/mt/79974651/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Tqpik3g5g0khP7WEEwZC--
