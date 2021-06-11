Return-Path: <SRS0=Sx4A=LF=lists.cip-project.org=bounce+64572+6502+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88228C48BE8
	for <cip-dev@archiver.kernel.org>; Fri, 11 Jun 2021 14:21:18 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0371B6141C
	for <cip-dev@archiver.kernel.org>; Fri, 11 Jun 2021 14:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0371B6141C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6502+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id GCpbYY4521723xw1gsqwe8cd; Fri, 11 Jun 2021 07:21:17 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web12.8908.1623421276437052474
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Jun 2021 07:21:17 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 15BELD2l010137
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 11 Jun 2021 16:21:14 +0200
X-Received: from md2dvrtc.fritz.box ([167.87.46.52])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 15BELCQa002059;
	Fri, 11 Jun 2021 16:21:13 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
        christian.storm@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-dev][PATCH 0/2] swupdate add new round robin handler
Date: Fri, 11 Jun 2021 16:21:10 +0200
Message-Id: <20210611142112.2453-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ZUZHys51PklHnKI15vLaZEiVx4520388AA=
Content-Type: multipart/mixed; boundary="pXnYa6pQjLz3t4Fc9lNd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623421277;
 bh=Eny6hl4orIzjSDYyeEvoA+0aB8aVdwLKrT4pdqKVncY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=HFCx0jpbEaA0Hadto6S+Kz3r68rKEmmlXEvj1I6gtXUzPgWgtRMr6O70jtXXGD0JQfg
 J4BQY+wd77+d4qjxkHw5I+k7rBOP4lrxxFgbsxNpoPsK9RpbcOiUCFPJ8tZ69SGNpbER8
 0LTyIdMKzJW6ujMxeN4PxO0Ek/K61V4Vfyo=

--pXnYa6pQjLz3t4Fc9lNd
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add the SWUpdate round-robin Lua handler from [1].
Also update swupdate to 2021.04 for dependencies of the lua handler.

[1]: https://gitlab.com/cip-playground/swupdate-handler-roundrobin

Quirin Gylstorff (2):
  swupdate: Update to 2021.04
  swupdate: Add option to use swupdate-handler-roundrobin

 classes/swupdate-config.bbclass               |  14 +-
 kas/opt/ebg-secure-boot-base.yml              |   1 +
 .../files/secure-boot/sw-description.tmpl     |  14 +-
 recipes-core/images/files/sw-description.tmpl |  21 +-
 .../swupdate.handler.efibootguard.ini         |  20 +
 .../files/swupdate.handler.efibootguard.ini   |  26 +
 .../swupdate/files/swupdate_handlers.lua      | 453 ------------------
 recipes-core/swupdate/swupdate.bb             |  18 +-
 8 files changed, 97 insertions(+), 470 deletions(-)
 create mode 100644 recipes-core/swupdate/files/secureboot/swupdate.handler.efibootguard.ini
 create mode 100644 recipes-core/swupdate/files/swupdate.handler.efibootguard.ini
 delete mode 100644 recipes-core/swupdate/files/swupdate_handlers.lua

-- 
2.20.1


--pXnYa6pQjLz3t4Fc9lNd
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6502): https://lists.cip-project.org/g/cip-dev/message=
/6502
Mute This Topic: https://lists.cip-project.org/mt/83469364/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--pXnYa6pQjLz3t4Fc9lNd--
