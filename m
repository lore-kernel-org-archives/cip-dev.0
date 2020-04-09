Return-Path: <SRS0=0lnv=5Z=lists.cip-project.org=bounce+64572+4569+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E66C2D0EA
	for <cip-dev@archiver.kernel.org>; Thu,  9 Apr 2020 05:27:31 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7D7C20B1F
	for <cip-dev@archiver.kernel.org>; Thu,  9 Apr 2020 05:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="N/x9yd62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D7C20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4569+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id d4WKYY4521723xGXpsfIIxsI; Wed, 08 Apr 2020 22:27:30 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.3575.1586410048978973769
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Apr 2020 22:27:29 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 0395RQx0029725; Thu, 9 Apr 2020 14:27:27 +0900
X-Iguazu-Qid: 2wHHQAbmtwf1YKJoGr
X-Iguazu-QSIG: v=2; s=0; t=1586410046; q=2wHHQAbmtwf1YKJoGr; m=AyrCu4pc+sqqKFzgcXoR8VDeIqEThY68TdBPRtp45GI=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1110) id 0395RPsN024295;
	Thu, 9 Apr 2020 14:27:26 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 0395RPbs013093
	for <cip-dev@lists.cip-project.org>; Thu, 9 Apr 2020 14:27:25 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 0395ROH5005025
	for <cip-dev@lists.cip-project.org>; Thu, 9 Apr 2020 14:27:25 +0900
From: punit1.agrawal@toshiba.co.jp
To: cip-dev@lists.cip-project.org
Cc: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>,
        Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
Subject: [cip-dev] CIP Core target EOL dates
Date: Thu, 09 Apr 2020 14:27:23 +0900
X-TSB-HOP: ON
Message-ID: <871roxxm84.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 44VUuLGbHiiVCUyb2RCf2hlMx4520388AA=
Content-Type: multipart/mixed; boundary="67YJmq8Ab4eJvJ9G8uHu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1586410050;
 bh=fvGvJoxepfCC6YM2f2JNNLmUi5zUdtMTauIGPapwoKo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=N/x9yd62hlLjJIluB6i1ZKDMUkzo9bhzCBXkpn2fUNfF51MHcUxsfGjJxHxUwj1h8+5
 mrggeSG/Hkk2RwLHnw55+KO1o38I2Eb88xgME48TpU5o5VSKmyi2RzlL0oSDCZROZdxxb
 oVk6bnByQddlk/9VSLHG1seMWzNVLI6t60w=

--67YJmq8Ab4eJvJ9G8uHu
Content-Type: text/plain

Hi,

CIP is planning to support the Kernels + Debian Rootfs combinations
marked with 'x' in the table below.

+----------+----------+-----------+-----------+
|          | Debian 8 | Debian 9  | Debian 10 |
|          |  Jessie  |  Stretch  |  Buster   |
|  Kernel  |          |           |           |
+----------+----------+-----------+-----------+
|   v4.4   |    x     |     x     |           |
+----------+----------+-----------+-----------+
|  v4.19   |          |     x     |     x     |
+----------+----------+-----------+-----------+

So far, the details of when the support is expected to end haven't been
explicitly called out for Core components. It would be good to rectify
this in order to set expectations and gather feedback from the user
community.

In addition, it will be helpful in estimating the required effort and
planning to resource the projects appropriately.

To start the conversation, I would like to propose the following target
EOL dates for each of the supported combination.

Note: All the dates are in YYYY-MM-DD format

+----------+--------------+--------------+--------------+
|          |   Debian 8   |   Debian 9   |  Debian 10   |
|          |    Jessie    |   Stretch    |    Buster    |
|  Kernel  |              |              |              |
+----------+--------------+--------------+--------------+
|   v4.4   |  2025-04-26  |  2026-01-10  |              |
+----------+--------------+--------------+--------------+
|  v4.19   |              |  2027-06-17  |  2019-10-18  |
+----------+--------------+--------------+--------------+

The proposed dates have been calculated as

    earlier of (Kernel, Debian) release date + 10 yrs

The choice of duration (10 yrs) is arbitrary and should be adjusted
based on requirement and available resources. Also, some of the
combinations could be dropped if there are no users for them.

Ideally, the dates for the Core components should be aligned with CIP
maintained kernels but there doesn't seem to be any public documentation
for the CIP kernel EOL dates. Let me know if this is written down
somewhere.

All feedback welcome.

Thanks,
Punit


The relevant Debian[0][1][2] and Kernel[3] release dates are copied
below for reference.

Debian Release Dates
--------------------
Jessie  - 2015-04-26
Stretch - 2017-06-17
Buster  - 2019-07-06

Linux Kernel Release Dates
--------------------------
v4.4  - 2016-01-10
v4.19 - 2018-10-18


[0] https://www.debian.org/releases/jessie/
[1] https://www.debian.org/releases/stretch/
[2] https://www.debian.org/releases/buster/
[3] https://www.kernel.org/category/releases.html

--67YJmq8Ab4eJvJ9G8uHu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4569): https://lists.cip-project.org/g/cip-dev/message=
/4569
Mute This Topic: https://lists.cip-project.org/mt/72890803/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--67YJmq8Ab4eJvJ9G8uHu--
