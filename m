Return-Path: <SRS0=+G+D=IC=lists.cip-project.org=bounce+64572+6211+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43119C433E0
	for <cip-dev@archiver.kernel.org>; Thu,  4 Mar 2021 17:24:40 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA4964F57
	for <cip-dev@archiver.kernel.org>; Thu,  4 Mar 2021 17:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA4964F57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6211+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 2roMYY4521723xkkqyPxPKUE; Thu, 04 Mar 2021 09:24:39 -0800
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web08.2095.1614878677388295014
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Mar 2021 09:24:38 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 124HOZca029824
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 4 Mar 2021 18:24:35 +0100
X-Received: from md2dvrtc.fritz.box ([167.87.94.54])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 124H9Y6j031858;
	Thu, 4 Mar 2021 18:09:34 +0100
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH 0/2] Defconfig matches Kernel version
Date: Thu,  4 Mar 2021 18:09:32 +0100
Message-Id: <20210304170934.7424-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: FQLgvI5Xv6x3yIqEJiskIFH9x4520388AA=
Content-Type: multipart/mixed; boundary="VoXTtCk75ejQZvfzLgz0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1614878679;
 bh=p2PCHUZZbnJwFDoKJBiLtCQ+fkhV95A3E5RrjPVnREY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ZJ0LREVgiVP367e7lbLOTe2zLbdAFoRzqSEEM+lXhl1Mb3Sj3sLGh8G9elTOXAVRSw/
 PzkuQftT92tj0O6wRoGJO3w6lFz/YucZUDqbf5Jc081ohDC+S+m9FQ+FDHDsAfKPXGF+9
 hACohatzKwFakP1CfaTZvQf3sdSeDZq7x5w=

--VoXTtCk75ejQZvfzLgz0
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add the option to select the defconfig matching the kernel version
and update cip-kernel-config

Quirin Gylstorff (2):
  conf/machine: Add KERNEL_DEFCONFIG_VERSION to select defconfig path
  linux-cip: Update cip-kernel-config

 conf/machine/bbb.conf                     | 5 +++++
 conf/machine/hihope-rzg2m.conf            | 5 ++++-
 conf/machine/iwg20m.conf                  | 5 ++++-
 conf/machine/qemu-amd64.conf              | 5 ++++-
 conf/machine/simatic-ipc227e.conf         | 5 ++++-
 kas/opt/4.4.yml                           | 1 +
 kas/opt/rt.yml                            | 1 +
 recipes-kernel/linux/linux-cip-common.inc | 2 +-
 8 files changed, 24 insertions(+), 5 deletions(-)

-- 
2.20.1


--VoXTtCk75ejQZvfzLgz0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6211): https://lists.cip-project.org/g/cip-dev/message=
/6211
Mute This Topic: https://lists.cip-project.org/mt/81082366/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--VoXTtCk75ejQZvfzLgz0--
