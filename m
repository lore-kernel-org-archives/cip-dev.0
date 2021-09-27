Return-Path: <SRS0=2Qq9=OR=lists.cip-project.org=bounce+64572+6750+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3F7C433EF
	for <cip-dev@archiver.kernel.org>; Mon, 27 Sep 2021 08:38:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 732356103B
	for <cip-dev@archiver.kernel.org>; Mon, 27 Sep 2021 08:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 732356103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id GUuqYY4521723x8mQe03yrBe; Mon, 27 Sep 2021 01:38:08 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web08.28725.1632731887858109491
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Sep 2021 01:38:08 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 18R8c4sU027203
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 27 Sep 2021 10:38:05 +0200
X-Received: from md2dvrtc.fritz.box ([139.22.35.204])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 18R8c4M5028652;
	Mon, 27 Sep 2021 10:38:04 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH] scripts/wic/efibootguard-boot: Add missing whitespace
Date: Mon, 27 Sep 2021 10:38:03 +0200
Message-ID: <20210927083803.15507-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: pXyNIbteDCcbBZwLWwGk0918x4520388AA=
Content-Type: multipart/mixed; boundary="oYuQ8MECJMsHR1Znc0xm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1632731888;
 bh=fuRPgx9vph/7veMGCbhyIvEwP8/pGEywo02JdpkIWRQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=t18YD85ex+kfsbmTdVL22TlMlnFXk2WeD6Fn4xnTWmMXLRlmmZSTnPYbCQbgRqUcbqy
 0hV+W8kuys62I4U0pLjc9er+Q8SVHCp/FJDYwhNPWOy3tGRGOIy9Zo4FDVX3YM1UbHzLi
 KS9jSBYTEdLYIS8j9lpOxMxSwzFDaX+nOzU=
Message-ID: <20210927083803.Nce2WeS61RNgkYOwYA8Yfcu7a9lVuSm-PuIWhlu-WNA@z>

--oYuQ8MECJMsHR1Znc0xm
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The generated Kernel commandline was incorrect concatenated.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/lib/wic/plugins/source/efibootguard-boot.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index b85cfca..882729a 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -99,7 +99,7 @@ class EfibootguardBootPlugin(SourcePlugin):
                 exit(1)
             root_dev = root_dev.replace(":", "=")
 
-            cmdline += " root=%s rw" % root_dev
+            cmdline += " root=%s rw " % root_dev
             boot_files.append(kernel_image)
             boot_files.append(initrd_image)
             cmdline += "initrd=%s" % initrd_image if initrd_image else ""
-- 
2.30.2


--oYuQ8MECJMsHR1Znc0xm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6750): https://lists.cip-project.org/g/cip-dev/message/=
6750
Mute This Topic: https://lists.cip-project.org/mt/85895818/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--oYuQ8MECJMsHR1Znc0xm--
