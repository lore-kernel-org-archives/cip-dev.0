Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2384C54EE9
	for <webhook@archiver.kernel.org>; Wed, 28 Sep 2022 15:12:49 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.9206.1664377966388868571
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 28 Sep 2022 08:12:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=A9v8wiAC;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id y136so12815781pfb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 28 Sep 2022 08:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=kfarlYcL6WT6rJlhwsvBAfVCm2Vz0scwB4lE9Si97FI=;
        b=A9v8wiACZyaYEPKcY7Odu5nzOg3J/jKbKhA2i5C7hOf/A+7EnexdljG55fvA8Jf9yT
         5EaoU2cg+L07MbpQiFvisu7ddUb/Ghv/GZLd6uewL1Tk4KmEbEHzlinZ0Df7skz27l3p
         sJ30/+4d59uSCOlQXGCE7r641uFLojyOheF6IDGg3/gPrRcrtqWhbsJHdvrydJScQ7hR
         eumgKgFX56rmIKeiS9mCzdvd3pBFlx5iHMipRv8h6Dkg68aUgDfzi2r6s2RAQbZM9qJ9
         draW/7pdcUh4Q6/eA3uD758At7fYFvUgeI1mWq5ps6B2c2b7l3MEOj2b+oReJl+eAlFd
         7E4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=kfarlYcL6WT6rJlhwsvBAfVCm2Vz0scwB4lE9Si97FI=;
        b=eEagnoDkfBVdnrQn0RQXpTUxnmUmspZcRe3A0d7ZGWyKXobEz1IefqK0HJfQkrCUs8
         4QGR/KzaYeGGeWGwbmxJ0v9JnMxpR4JAzMoDzQmO3yqoLNDB+4/C+q9P3gXhvbyVBthw
         4zrFu2ijqPuFjtetjAMu9kxjQvEjJ3PPEgqLotMXgYxgqP7KSXDOsPlcAOD7bpaaTsu1
         h7aGT4VF2IR09DzzDSvhiWIMBfnu4q7zQ/C1E1zMy68IYdM/a9KGA3HXYKOWlc3THY35
         xINo3JYIPP3Q3AgwMZzVB6j+T6B541Pu7mtAf+QrFSYo/vFcTnBJJfUU1qrA9ifaHC3p
         w7aQ==
X-Gm-Message-State: ACrzQf02YvrcCc/kfUUl6r/nRCQwO0GpOXTWIxxiczdUCadb4jHzzTuS
	wlObjrE/andz27/yWVZcnQoBemdkN2WFByIP
X-Google-Smtp-Source: 
 AMsMyM44qiV8y2akCruYH9tuf108gZgNituqj9jxockaY9kDyyO9Dcj31x/5QU9ua4ZxRm5NiFZpTw==
X-Received: by 2002:a63:f358:0:b0:43c:5e1:985 with SMTP id
 t24-20020a63f358000000b0043c05e10985mr29774745pgj.5.1664377965378;
        Wed, 28 Sep 2022 08:12:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 64-20020a630343000000b0043be496f3f3sm3751956pgd.57.2022.09.28.08.12.44
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 08:12:44 -0700 (PDT)
Message-ID: <6334646c.630a0220.8a90c.6838@mx.google.com>
Date: Wed, 28 Sep 2022 08:12:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-cip17-140-g62223aebb3a92
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 5
 runs, 1 regressions (v5.10.145-cip17-140-g62223aebb3a92)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Sep 2022 15:12:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9570

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 5 runs, 1=
 regressions (v5.10.145-cip17-140-g62223aebb3a92)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.145-cip17-140-g62223aebb3a92/plan/kselfte=
st-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.145-cip17-140-g62223aebb3a92
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      62223aebb3a921dd8f6ae0008df527bf6bd30935 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/6334562c96c8701ba3ec4ebc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/arm64/defconfig/gcc-10/lab-=
baylibre/kselftest-filesystems-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/arm64/defconfig/gcc-10/lab-=
baylibre/kselftest-filesystems-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/6334562c=
96c8701ba3ec4ebd
        failing since 27 days (last pass: v5.10.136-cip14-542-g97767707d3d0=
, first fail: v5.10.138-cip15-90-gd4130d0ee3c7) =

 =20

