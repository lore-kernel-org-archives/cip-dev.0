Return-Path: <SRS0=wsSt=FP=lists.cip-project.org=bounce+64572+5950+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB24CC433FE
	for <cip-dev@archiver.kernel.org>; Fri, 11 Dec 2020 13:54:54 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00FF623ED2
	for <cip-dev@archiver.kernel.org>; Fri, 11 Dec 2020 13:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00FF623ED2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5950+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id LVBTYY4521723xpbqra5vjgc; Fri, 11 Dec 2020 05:54:53 -0800
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web10.6932.1607694892013179811
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Dec 2020 05:54:52 -0800
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 0BBDsnjQ029559
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 11 Dec 2020 14:54:50 +0100
X-Received: from md2dvrtc.fritz.box ([139.22.37.41])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 0BBDsnjC015801;
	Fri, 11 Dec 2020 14:54:49 +0100
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH 0/2] Minor Fixes
Date: Fri, 11 Dec 2020 14:54:46 +0100
Message-Id: <20201211135448.17147-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: qkkxmrVeTyBXTFxS0Cdpyt7ax4520388AA=
Content-Type: multipart/mixed; boundary="VPA2hp6rJ2GXaNJbHwVr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1607694893;
 bh=3W+f8SoqFRIf8yPPPM/GbntKwhHCqJWdryqLtdSYl4s=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=qH+avKnUaZNDOaCXQuPHUmVVALj0u1S01+tYIXwWwnccss9l2L+uha7ETZ8Plp0vWtJ
 oiqTk2Nmz5YpAqP/V23ZaPIhCvCu4FUPMIstcoJhFrZJ4nAlcLPGikGr9og8Pf+/0ft/r
 pyVHWa8yLI4BCXK+8v07Vhb77J5aeBJ+l3M=

--VPA2hp6rJ2GXaNJbHwVr
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add __pycache__ to gitignore
correct syntax in initramfs-config

Quirin Gylstorff (2):
  initramfs-config: use correct syntax for FILESPATH
  add pycache to .gitignore

 .gitignore                                                      | 1 +
 .../initramfs-config/initramfs-abrootfs-secureboot_0.1.bb       | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.20.1


--VPA2hp6rJ2GXaNJbHwVr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5950): https://lists.cip-project.org/g/cip-dev/message=
/5950
Mute This Topic: https://lists.cip-project.org/mt/78879161/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--VPA2hp6rJ2GXaNJbHwVr--
