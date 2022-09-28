Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE5EC6FA8E
	for <webhook@archiver.kernel.org>; Wed, 28 Sep 2022 14:42:49 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web10.8776.1664376166565003464
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 28 Sep 2022 07:42:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=0RiaZtys;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id cv6so2520950pjb.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 28 Sep 2022 07:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=wPESWOPJMTh05l1Aj9HoXaDd1ExCU+s/vdAmxsoluFQ=;
        b=0RiaZtysvZWVcZVEo6lgYH42+rEdKiCfqMLQJzy0K1i27pjAkeaCDNjTA6hFwzOLdn
         kEs3Oz+WITsIUiS168M/b2Vll6YsBMp/XTS9+iQcFG5scHY/CFtIh6JFWiBTTfVZUGkW
         DZ5cxG4FRMZWmHqK86OlZdL+s1dtWTVaKQpY82GN1/HHPQ8HqX0qjutqRmbgPx/GFAUE
         RsPy9QSCO/E9Ukuiy4iXJt3KvR26pPIEzT+L9OiaAau3AUmlTyUkQiK3gtn+nSNpBf6S
         +SI+sK/HLGzlhIxu/nsiQD/Gmic4y57Izr2WboEiCo9RzhlPYl6AzAWqtcjfcEjHZI5S
         +C/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=wPESWOPJMTh05l1Aj9HoXaDd1ExCU+s/vdAmxsoluFQ=;
        b=OVuettl+vFve6zYLh1ENc0Vy4Seqi2TCOR6m7XV1peccRInXjwIuLnojpfwLxVF9u3
         YyYbn/TcQcWBdLzlGhb4hvQyf8MrYwteMOwl3uqxuvxMxXsowri2zNywN82OjvZNUJXt
         tI5UbE0aFiA8esne3unlHsS9FRkBHFTZcQWdH/OTHy6YIsz7/lDYuo/2tib0osikaHe/
         EuaaAD+EMYtOG3w+Rb0Q1xhg3y5FPkdX+9ybS1Gtz+ifhF9qTh7L5hI4ViJ5Z1TYHOkB
         QZFRZnh6IBx16X/xwMgHnafHf8Tikwh1s7bxb5YHtuETWQ8QI48Esn5H02ss8HmkUmPd
         lC1Q==
X-Gm-Message-State: ACrzQf1/cUbGjE2UfYi21dBBgS0JV4twRhQfDeZQBbb9/iiiWZzGbetd
	5XByYySz7+rLr9Jpguey/Dinzb5NkvLlpCqX
X-Google-Smtp-Source: 
 AMsMyM5K4RqlaizmCstRtNt9yakTl2aURE9sT/kb6pvcY1Ma1ApCUqsS1qZCkYH1Dxav8LZAXyJeJw==
X-Received: by 2002:a17:903:22d0:b0:177:f919:9259 with SMTP id
 y16-20020a17090322d000b00177f9199259mr155932plg.71.1664376165165;
        Wed, 28 Sep 2022 07:42:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 y7-20020a17090a2b4700b001fffbad35f6sm1598980pjc.44.2022.09.28.07.42.44
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:42:44 -0700 (PDT)
Message-ID: <63345d64.170a0220.bb57e.2af3@mx.google.com>
Date: Wed, 28 Sep 2022 07:42:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-cip17-140-g62223aebb3a92
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 18 runs,
 1 regressions (v5.10.145-cip17-140-g62223aebb3a92)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Sep 2022 14:42:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9568

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 18 runs, 1 regress=
ions (v5.10.145-cip17-140-g62223aebb3a92)

Regressions Summary
-------------------

platform   | arch | lab          | compiler | defconfig          | regressi=
ons
-----------+------+--------------+----------+--------------------+---------=
---
jetson-tk1 | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.145-cip17-140-g62223aebb3a92/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.145-cip17-140-g62223aebb3a92
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      62223aebb3a921dd8f6ae0008df527bf6bd30935 =



Test Regressions
---------------- =



platform   | arch | lab          | compiler | defconfig          | regressi=
ons
-----------+------+--------------+----------+--------------------+---------=
---
jetson-tk1 | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/6334567e1dce26f32fec4edd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/arm/multi_v7_defconfig/gcc-=
10/lab-baylibre/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/arm/multi_v7_defconfig/gcc-=
10/lab-baylibre/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6334567e1dce26f32=
fec4ede
        new failure (last pass: v5.10.140-cip16-261-g8fa62effa305f) =

 =20

