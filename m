Return-Path: <SRS0=suI6=KM=lists.cip-project.org=bounce+64572+6466+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFD9C433B4
	for <cip-dev@archiver.kernel.org>; Mon, 17 May 2021 07:50:34 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 140D4611ED
	for <cip-dev@archiver.kernel.org>; Mon, 17 May 2021 07:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140D4611ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6466+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id wyKpYY4521723xZmHVChHmEx; Mon, 17 May 2021 00:50:33 -0700
X-Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web09.15964.1621237833014640071
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 17 May 2021 00:50:33 -0700
X-Received: by mail-pg1-f171.google.com with SMTP id j12so4074282pgh.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 17 May 2021 00:50:32 -0700 (PDT)
X-Gm-Message-State: yzQZsj755lC8q1GhM5PNH44Gx4520388AA=
X-Google-Smtp-Source: ABdhPJwD1t9XLLjpY7gIatntEs7LN2D9MSIU/nNvaP8pnIio9m9QmDn111O2tGLiHTSoSkOt+7zkCQ==
X-Received: by 2002:a62:3003:0:b029:28e:74d9:1e16 with SMTP id w3-20020a6230030000b029028e74d91e16mr60205063pfw.21.1621237832483;
        Mon, 17 May 2021 00:50:32 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id iq16sm784937pjb.31.2021.05.17.00.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 00:50:32 -0700 (PDT)
Message-ID: <60a22048.1c69fb81.edc6b.1eab@mx.google.com>
Date: Mon, 17 May 2021 00:50:32 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4.268-cip57
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Report-Type: test
Subject: [cip-dev] cip/linux-4.4.y-cip baseline-nfs: 10 runs, 2 regressions (v4.4.268-cip57) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="KWGFmdYHp01wPmApBACL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1621237833;
 bh=HNdlpUwT4VHYK9WlXMRkW5d/QrZtc2pOODMi9Vvtc1U=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=avFA1KJFs19UViXqmkTtKrC++cF9VwsRWwcNisdIeiaVZCxUF4jdf/Osq3e7lrvCaDJ
 CnWj17NMCOrT6Zce7L5wzStqcCMiC7m083PoKiKOyPu6Rf7TdqVPpjar+RoohbKQv4QGQ
 og3bBTwQpNNJQdaEe6lRpfrR18KzA8vBZH0=

--KWGFmdYHp01wPmApBACL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.4.y-cip baseline-nfs: 10 runs, 2 regressions (v4.4.268-cip57)

Regressions Summary
-------------------

platform                  | arch | lab             | compiler | defconfig  =
        | regressions
--------------------------+------+-----------------+----------+------------=
--------+------------
dove-cubox                | arm  | lab-pengutronix | gcc-8    | multi_v7_de=
fconfig | 1          =

sun7i-a20-olinuxino-lime2 | arm  | lab-baylibre    | gcc-8    | sunxi_defco=
nfig    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.268-cip57/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.268-cip57
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      999b74443ca356daa3b0238d7ff676f19728abed =



Test Regressions
---------------- =



platform                  | arch | lab             | compiler | defconfig  =
        | regressions
--------------------------+------+-----------------+----------+------------=
--------+------------
dove-cubox                | arm  | lab-pengutronix | gcc-8    | multi_v7_de=
fconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60a21887a3cbd37164b3afb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/multi_v7_defconfig/gcc-8/lab-pengutronix/baseline-nfs-dove-cubox.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/multi_v7_defconfig/gcc-8/lab-pengutronix/baseline-nfs-dove-cubox.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0503.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/60a21887a3cbd3716=
4b3afba
        new failure (last pass: v4.4.266-cip56) =

 =



platform                  | arch | lab             | compiler | defconfig  =
        | regressions
--------------------------+------+-----------------+----------+------------=
--------+------------
sun7i-a20-olinuxino-lime2 | arm  | lab-baylibre    | gcc-8    | sunxi_defco=
nfig    | 1          =


  Details:     https://kernelci.org/test/plan/id/60a21f550029ecebb1b3af97

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/sunxi_defconfig/gcc-8/lab-baylibre/baseline-nfs-sun7i-a20-olinuxin=
o-lime2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/sunxi_defconfig/gcc-8/lab-baylibre/baseline-nfs-sun7i-a20-olinuxin=
o-lime2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0503.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/60a21f550029ecebb=
1b3af98
        new failure (last pass: v4.4.262-cip55) =

 =20

--KWGFmdYHp01wPmApBACL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6466): https://lists.cip-project.org/g/cip-dev/message=
/6466
Mute This Topic: https://lists.cip-project.org/mt/82881603/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--KWGFmdYHp01wPmApBACL--
