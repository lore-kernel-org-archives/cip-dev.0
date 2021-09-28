Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EAAC4332F
	for <webhook@archiver.kernel.org>; Tue, 28 Sep 2021 18:49:53 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web08.753.1632854991757344521
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Sep 2021 11:49:52 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 18SInnZS010904
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Sep 2021 20:49:49 +0200
Received: from md2dvrtc.fritz.box ([139.22.32.51])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 18SInmgw026555;
	Tue, 28 Sep 2021 20:49:49 +0200
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, dinesh.kumar@toshiba-tsip.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH 0/2] Fix for issue gitlab #14
Date: Tue, 28 Sep 2021 20:49:46 +0200
Message-ID: <20210928184948.737071-1-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Sep 2021 18:49:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6756
Message-ID: <20210928184946.GHmZQFBkA_wEzR1iQiB_04frBV52DnaYGHOSYtAdjok@z>

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This Fixes [1]
.swu file is not getting generated for checking new swupdate handler (#14)

This issue occured due to [1]: If multiple `?=` assignments are used
the first of those assignments ends up getting used.

[1]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/14
[2]: https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manual-metadata.html#setting-a-default-value


Quirin Gylstorff (2):
  kas/opt/swupdate: Change assignment of IMAGE_TYPE and WKS_FILE
  kas/opt/efibootguard: Move setting of IMAGE_TYPE

 kas/opt/efibootguard.yml |  1 -
 kas/opt/swupdate.yml     |  4 ++--
 kas/opt/wic-img.yml      | 19 +++++++++++++++++++
 3 files changed, 21 insertions(+), 3 deletions(-)
 create mode 100644 kas/opt/wic-img.yml

-- 
2.30.2


