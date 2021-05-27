Return-Path: <SRS0=+g5P=KW=lists.cip-project.org=bounce+64572+6473+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F8BC47089
	for <cip-dev@archiver.kernel.org>; Thu, 27 May 2021 13:17:49 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E36C610FC
	for <cip-dev@archiver.kernel.org>; Thu, 27 May 2021 13:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E36C610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6473+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 7HoXYY4521723xPYWKA8xbpD; Thu, 27 May 2021 06:17:49 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web12.6626.1622121468124910616
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 May 2021 06:17:48 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 14RDHgfB014564
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 27 May 2021 15:17:43 +0200
X-Received: from md2dvrtc.fritz.box ([167.87.10.167])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 14RDHgav007209;
	Thu, 27 May 2021 15:17:42 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH 0/5] Add ci for secure-boot and swupdate
Date: Thu, 27 May 2021 15:17:36 +0200
Message-Id: <20210527131741.8828-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: FueT8vCRA2Np2rXGsLIr9diex4520388AA=
Content-Type: multipart/mixed; boundary="KToU3jeMtuPsyWMFrYid"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1622121469;
 bh=OB+nB29ooC6rcjwakfmHFcmzxKVSuMTpFqspMRNXGr8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=DPD4MvUvUXFKB3KdBXBZC2fg/x2f2Sk1UXOF/6iStd4GrezifGydgt79jziRYAR9NvC
 rEXgt1fU4E+3jA6pngP57k7Ve9tnLIV9RJS32jMHuDViYMKC/32sJVvJOxB4gg8I8YfCs
 jI8Lq3/yFN/6T7d/Bv6unYE/m8gSxUZDyhE=

--KToU3jeMtuPsyWMFrYid
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add the following ci builds:
 - qemu-amd64 ebg-secure-boot-snakeoil
 - qemu-amd64 ebg-swu (efibootguard + swupdate)
 - qemu-amd65 ebg-snakeoil-swu (efibootguard + secure-boot + swupdate)

This patch set also fixes issues for these ci builds.

Quirin Gylstorff (5):
  swupdate-config: add dependency to u-boot-${MACHINE}-config
  kas/opt: Allow override of WKS_FILE in swupdate option
  .gitlabci.yml: add secureboot build
  .gitlabci.yml: add swupdate build
  .gitlabci.yml: Add secure-boot and swupdate build

 .gitlab-ci.yml                  | 33 +++++++++++++++++++++++++++++++++
 classes/swupdate-config.bbclass |  4 +++-
 kas/opt/ebg-snakeoil-swu.yml    | 17 +++++++++++++++++
 kas/opt/ebg-swu.yml             | 16 ++++++++++++++++
 kas/opt/efibootguard.yml        |  2 ++
 kas/opt/swupdate.yml            |  4 ++--
 6 files changed, 73 insertions(+), 3 deletions(-)
 create mode 100644 kas/opt/ebg-snakeoil-swu.yml
 create mode 100644 kas/opt/ebg-swu.yml

-- 
2.20.1


--KToU3jeMtuPsyWMFrYid
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6473): https://lists.cip-project.org/g/cip-dev/message=
/6473
Mute This Topic: https://lists.cip-project.org/mt/83123858/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--KToU3jeMtuPsyWMFrYid--
