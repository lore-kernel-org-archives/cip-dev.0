X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web10.6273.1647926298014123403
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 21 Mar 2022 22:18:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=sAcTxkaX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id o6-20020a17090a9f8600b001c6562049d9so1176427pjp.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 21 Mar 2022 22:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=2xlD+LTX7j+N7IxEkP4jOmBlZPfV+MAVfde5cfXqBZk=;
        b=sAcTxkaX0wZWYvdjKuUdhcn4BUawDkrAoRB6IRyD90Qdk8hdO4OAKM3xILi9RWfZqD
         LHbXEObUvYeiHMS1RZxmhV31BzpkLZQbcyXnRsjVuaSn2V+K836vAnowcb0onhkO7vu5
         N/tihy02ANYbbe1+zYa8j673+EdL7tHutU/VpCcRdcLVQcBswozg355V1qm0+O3hToJb
         GEPBvnqNTDFxt2hqoGXVqzwC6l0w0n8Ihj3vaWFwGCwyF5n/xeknXlpJrDCYtqmqC+Qp
         YHPtsxJCzC6BfPE1EgIyhquRc3DDfBP0QBqsorpOA2vr1SZ38lKf/jQ8+Ojfzf0XURIX
         WcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=2xlD+LTX7j+N7IxEkP4jOmBlZPfV+MAVfde5cfXqBZk=;
        b=OfqeiKU1ePcrIokPy2o1vOQUdTcat205LE1LgXQgvVtJulEBVWCUpcaIwNj6vkgWtS
         G6ykFG2JcdwDVqnzZTWpPlRmISlDS1sA0sBjbP2bd+JsYGEaKz8SmrCKxhDKT2+xGrMa
         /zyNWEtqD653gIQRnmGxvShU8Mo0c6bUGiXOpA2UhDW2PD0nfG2YcB2ykG9bnVYkN8ZM
         w2I7X8Ax+cnHOAOiGxZsfUlfmkYSIn3cix6Wipk3UonTSJurKAu+8Voc1SRAG+hn2Bmf
         MfOMR7b7vv/iAKgTWRJlZPmzAqQ+4Xdg4weZsCEUiM2/DMZmSdn14lNZs9E9Hi0g7ZEc
         P9NQ==
X-Gm-Message-State: AOAM530U1XOx6fj6kQPQ/UpB6ecmppC+hU/L7by17PpNIJJ6sp1g38fv
	C3Uqzt3PqEDcuizLheFDstV1b8MkhIYnRXmV2F8=
X-Google-Smtp-Source: ABdhPJxGJGXervGm55ZdczVbLlH818Dr+mLrrgJ2eVvRMQuYJkQ/go13kJ1xbmaQIpMO17dEFvAFUg==
X-Received: by 2002:a17:90b:3ece:b0:1bf:21bd:87d7 with SMTP id rm14-20020a17090b3ece00b001bf21bd87d7mr2857226pjb.5.1647926297227;
        Mon, 21 Mar 2022 22:18:17 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d6-20020a056a00244600b004f701135460sm22188404pfj.146.2022.03.21.22.18.16
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 22:18:16 -0700 (PDT)
Message-ID: <62395c18.1c69fb81.83b2f.d24c@mx.google.com>
Date: Mon, 21 Mar 2022 22:18:16 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.104-cip3-155-g4f07dbd2df49e
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 8 runs, 1 regressions (v5.10.104-cip3-155-g4f07dbd2df49e) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 8 runs, 1 regr=
essions (v5.10.104-cip3-155-g4f07dbd2df49e)

Regressions Summary
-------------------

platform         | arch | lab     | compiler | defconfig           | regres=
sions
-----------------+------+---------+----------+---------------------+-------=
-----
beaglebone-black | arm  | lab-cip | gcc-10   | omap2plus_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.104-cip3-155-g4f07dbd2df49e/plan/baseline=
-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.104-cip3-155-g4f07dbd2df49e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4f07dbd2df49ee61f77347287ba5837888067f02 =



Test Regressions
---------------- =



platform         | arch | lab     | compiler | defconfig           | regres=
sions
-----------------+------+---------+----------+---------------------+-------=
-----
beaglebone-black | arm  | lab-cip | gcc-10   | omap2plus_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/6239501d259a2b13d82172c0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-155-g4f07dbd2df49e/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-155-g4f07dbd2df49e/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/6239501d259a2=
b13d82172c1
        new failure (last pass: v5.10.104-cip3-132-g46c091c34fabb) =

 =20

