Return-Path: <SRS0=n6Ck=LM=lists.cip-project.org=bounce+64572+6540+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082BBC48BE8
	for <cip-dev@archiver.kernel.org>; Fri, 18 Jun 2021 18:08:42 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A36F6127C
	for <cip-dev@archiver.kernel.org>; Fri, 18 Jun 2021 18:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A36F6127C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6540+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id FdHzYY4521723x1fYySwvevY; Fri, 18 Jun 2021 11:08:41 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web12.11668.1624039720150051475
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Jun 2021 11:08:40 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 15II8b4E011397
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 18 Jun 2021 20:08:38 +0200
X-Received: from md2dvrtc.fritz.box ([139.22.32.20])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 15II8bjJ001260;
	Fri, 18 Jun 2021 20:08:37 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v2 0/1] swupdate add new round robin handler
Date: Fri, 18 Jun 2021 20:08:35 +0200
Message-Id: <20210618180836.3387-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <e36534ba-4ea0-5751-ad5e-d8103deb6549@siemens.com>
References: <e36534ba-4ea0-5751-ad5e-d8103deb6549@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: aW3lUqOmnH2407oON4Xxnehrx4520388AA=
Content-Type: multipart/mixed; boundary="iFUzK9Jo8uwamfwAjmxq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624039721;
 bh=sAmueB81fy3OY7jfXyp3ERp32bpMnC04O6sWUZ4CW6I=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=UMb4vXMjjhJMYkoZUbkgsSZtJW756zz7z1QXtqslJsyt0XYRCZeAeOeofSddXI9SvOw
 eq/qzESxnsI0jdU2xvob5kYVXjTk3MHw/yE5Jh7YvyxSuWdROoyN1mL6vmu0vP3JQVNZT
 dcZ/bXLImWEDk5Gloca0GYzXz0gyCARlfxs=

--iFUzK9Jo8uwamfwAjmxq
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add the SWUpdate round-robin Lua handler from [1].

[1]: https://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin

Changes in V2:
 - fix build
 - removed unnecessary ustate variable
 - adapted repository path

Quirin Gylstorff (1):
  swupdate: Add option to use swupdate-handler-roundrobin

 classes/swupdate-config.bbclass               |  14 +-
 kas/opt/ebg-secure-boot-base.yml              |   1 +
 .../files/secure-boot/sw-description.tmpl     |  14 +-
 recipes-core/images/files/sw-description.tmpl |  21 +-
 .../swupdate.handler.efibootguard.ini         |  16 +
 .../files/swupdate.handler.efibootguard.ini   |  26 +
 .../swupdate/files/swupdate_handlers.lua      | 453 ------------------
 recipes-core/swupdate/swupdate.bb             |  13 +-
 8 files changed, 90 insertions(+), 468 deletions(-)
 create mode 100644 recipes-core/swupdate/files/secureboot/swupdate.handler.efibootguard.ini
 create mode 100644 recipes-core/swupdate/files/swupdate.handler.efibootguard.ini
 delete mode 100644 recipes-core/swupdate/files/swupdate_handlers.lua

-- 
2.20.1


--iFUzK9Jo8uwamfwAjmxq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6540): https://lists.cip-project.org/g/cip-dev/message=
/6540
Mute This Topic: https://lists.cip-project.org/mt/83634483/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--iFUzK9Jo8uwamfwAjmxq--
