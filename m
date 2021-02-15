Return-Path: <SRS0=ShWu=HR=lists.cip-project.org=bounce+64572+6179+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2621AC433E0
	for <cip-dev@archiver.kernel.org>; Mon, 15 Feb 2021 10:30:53 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C8A364E04
	for <cip-dev@archiver.kernel.org>; Mon, 15 Feb 2021 10:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8A364E04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6179+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id qiMuYY4521723x6GYjfsm95J; Mon, 15 Feb 2021 02:30:52 -0800
X-Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.29535.1613385051640489497
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 15 Feb 2021 02:30:51 -0800
X-Received: by mail-pl1-f178.google.com with SMTP id a9so1358415plh.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 15 Feb 2021 02:30:51 -0800 (PST)
X-Gm-Message-State: RwntRSNo0Be5rjQIEPjBFg05x4520388AA=
X-Google-Smtp-Source: ABdhPJxcV3p0/DFF5hZtdS8CJ7wzTSEGq9lgULOoXukCVWCfuaoC1mGjNkN0rdnvJTdvEVXyLCgXgA==
X-Received: by 2002:a17:902:eac1:b029:e3:4940:541d with SMTP id p1-20020a170902eac1b02900e34940541dmr7545930pld.21.1613385050921;
        Mon, 15 Feb 2021 02:30:50 -0800 (PST)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x1sm18894605pgj.37.2021.02.15.02.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 02:30:50 -0800 (PST)
Message-ID: <602a4d5a.1c69fb81.7562.84c5@mx.google.com>
Date: Mon, 15 Feb 2021 02:30:50 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.175-cip43
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
Subject: [cip-dev] cip/linux-4.19.y-cip baseline-nfs: 19 runs, 1 regressions (v4.19.175-cip43) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="eOHR1PFLmU4LzUEHj8NF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1613385052;
 bh=q7mCZ8+JCk4BqfhSaAU2iEPHvZlQVahRyk8oWEoIsJo=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=akAHlW2Lt8LTAm5Fo+T8HDJiatwFElAvkJp5TZhbBVHsghi9HmPcLDuQ57LF0w8hSMD
 wx2r2g0i5qX1w45o+x4Vwew4u93F1qO/slp5gRI/mtt1CeTzx/PHkusoAgkVpKJLiNRJK
 58c6+fs3CnZmFPcRiJMiK1suIbIvlqv9chI=

--eOHR1PFLmU4LzUEHj8NF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline-nfs: 19 runs, 1 regressions (v4.19.175-cip43)

Regressions Summary
-------------------

platform                  | arch | lab          | compiler | defconfig     =
  | regressions
--------------------------+------+--------------+----------+---------------=
--+------------
sun7i-a20-olinuxino-lime2 | arm  | lab-baylibre | gcc-8    | sunxi_defconfi=
g | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.175-cip43/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.175-cip43
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      9b31f372ed011b190606ed6823a4361630440613 =



Test Regressions
---------------- =



platform                  | arch | lab          | compiler | defconfig     =
  | regressions
--------------------------+------+--------------+----------+---------------=
--+------------
sun7i-a20-olinuxino-lime2 | arm  | lab-baylibre | gcc-8    | sunxi_defconfi=
g | 1          =


  Details:     https://kernelci.org/test/plan/id/602a4526bc0de1d9593abe88

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.175=
-cip43/arm/sunxi_defconfig/gcc-8/lab-baylibre/baseline-nfs-sun7i-a20-olinux=
ino-lime2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.175=
-cip43/arm/sunxi_defconfig/gcc-8/lab-baylibre/baseline-nfs-sun7i-a20-olinux=
ino-lime2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0208.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/602a4526bc0de1d95=
93abe89
        failing since 37 days (last pass: v4.19.163-cip40-5-g95fea62f9f453,=
 first fail: v4.19.165-cip41) =

 =20

--eOHR1PFLmU4LzUEHj8NF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6179): https://lists.cip-project.org/g/cip-dev/message=
/6179
Mute This Topic: https://lists.cip-project.org/mt/80650566/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--eOHR1PFLmU4LzUEHj8NF--
