Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749AEC761AF
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 08:33:02 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web10.37874.1679473979567816881
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 01:32:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=dBN5X22t;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id u20so10136998pfk.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 01:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679473979;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GcukYcWFJQc6DcXDRMbcR+RXX+oPidQgmlMIgCc/mAM=;
        b=dBN5X22tM3B50uS6jHcKrFnMRZTh3x/LFloMeXYTqcLRsOggjf2flr1XxUreH+OUaH
         +HWm7QOogAu/a0Sgo6mBexuJX6LsO4cN7VeOhyEJ1P74jRzRHZVp9BTR31bcxU6SXSHQ
         tT9CKKHQfrp/gaqag58vR1ZKKWPyOrsyjk3nYvxh7t0Fld21aWUi3+YMMvPcSyHw11sA
         7KrxoFjg91uc358PyV7tQUpK9c7sR6jE+VKqla91lb/eHjjvxsb2D+CwP696vXp56+v3
         vb3ShCLLfr4E9SOy9D2Cut2PRwUWMsqspnx/kEbofVvoqvyy/CKya5K/5SMNelqIjoao
         H8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679473979;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GcukYcWFJQc6DcXDRMbcR+RXX+oPidQgmlMIgCc/mAM=;
        b=nLwdcNvX3bPD2DImmDSYyxHa/qtHpEhX6eUd0eoc1mzeqJv4gufMFg5NTIWVis7MhB
         Eg8b8tYz70+EtlJJv2L7lFTBeBsIou4dYyXpOMUuNDZxj/Gi1++jjls6Fs+z7wjP7Sy1
         n++wGStytkHuvqRQ+rFaaSTdXR3UuYYjwYqACJjfm1r9sq3xVzwTg+nk6ZSPvNKF6WWk
         4NlNJ6t8cRbk6zOqydEAYxDVBKGPnx11k2Om2Bej3rXRP6jPdnk9/IXLkEKmKzMQyzMP
         5vs4s8fiZXiTLOEf3+tUESsklmkbZVD0kmPONGdTSCsO09OSgBZgt2+v36D/lR4PnOwN
         xdFA==
X-Gm-Message-State: AO0yUKVE6pwQIcgkL1HlNjOGXf4i1caWDoGB9bDCv4pY2vwF3X8XVJWT
	eo7Lc/Jg1X95305ltB6ImTcTskUAqkZh1XNVa6U=
X-Google-Smtp-Source: AK7set8duFBXVwNDFwFfi5FltruXbcFEq46dDyHBNfx9k1jNLdg2MjFMu/3hp/Rzqan2Aw1pyZdveQ==
X-Received: by 2002:a62:6491:0:b0:5aa:4db8:9ab1 with SMTP id y139-20020a626491000000b005aa4db89ab1mr2292346pfb.23.1679473978829;
        Wed, 22 Mar 2023 01:32:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h11-20020a62b40b000000b005da23d8cbffsm9472167pfn.158.2023.03.22.01.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 01:32:58 -0700 (PDT)
Message-ID: <641abd3a.620a0220.9c5d9.0af2@mx.google.com>
Date: Wed, 22 Mar 2023 01:32:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.175-cip29
Subject: cip/linux-5.10.y-cip ltp-ipc: 13 runs, 2 regressions (v5.10.175-cip29)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 08:33:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11057

cip/linux-5.10.y-cip ltp-ipc: 13 runs, 2 regressions (v5.10.175-cip29)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =

asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.175-cip29/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.175-cip29
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      bb7267e6d2a6f131bb46ba14f0d3c418379e8bd4

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  f3463a347c37b44bafdf4e882cfb932f6888905d =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641aaac9a5e7f395019c9578

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-ipc-=
asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-ipc-=
asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/641aaac9a5e7f395019c95=
79
        new failure (last pass: v5.10.173-cip28) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641aa96f422bd127839c9517

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-ipc-=
asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-ipc-=
asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/641aa96f422bd127839c95=
18
        new failure (last pass: v5.10.173-cip28) =

 =20

