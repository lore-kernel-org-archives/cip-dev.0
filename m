Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCFFC2BB41
	for <webhook@archiver.kernel.org>; Wed, 17 Aug 2022 12:08:14 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web10.27745.1660738084496625892
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 17 Aug 2022 05:08:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=5MOfXDe/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id s206so11813578pgs.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 17 Aug 2022 05:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=WNjQBSZQoCTCDctBYoZEn9tr4moRqf58V7G9TWNftv4=;
        b=5MOfXDe/3PaDOb2tYLrNzxq8sYp3Hl1+SWmv/lHMxsGoZwdz/I933kU8EMv4prDY6C
         68CWMjXusTtNiFw5Hm5Ats3IKPv33Uf8T4KLH1N2eV3pUE9BLxlMrinOfC9c4bp8oZkY
         zya+/7RLdtG3VnPTUb0V0SWGoZ6I35YhtVAr9EGRqB2gVD1XUWbRjltDSwgx7LH/b51S
         s0Ln+LdsLdMFRumLjhs8SW/u0OoSG2TjGh2Ol0Zs+bvK+FB5yBT/nxUt3e0BFNDniDme
         xRjHQeK8pcKLR16XhYlNeOENoxyFkMH0NOoCiOOUnNZ/fzWL5XbTMPaIWtCu/y1XfAuc
         0XgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=WNjQBSZQoCTCDctBYoZEn9tr4moRqf58V7G9TWNftv4=;
        b=dLWWK3mBtso5DeLQB9jaqKVKAEF393epQri+V3tx5AZlXSzE64z+G+eIkYYIDvNZCi
         6Ea6T+ce0sFuB14QBXYZgxPNNcWgIiUPXbw+rZgmt/FLaZzQEqf0AWoReAMCfRMGQo1n
         d6dT4cFbPqzoU62rmzP8XHojiuKx+V9LJAwdAgWeM9LxEHRcx3FffocfMDwor/bWuqL5
         16sRQaT1nnzI+Z61CLs00jMU2K25v9hPPh7gY8SmtjF/HvjUdger/tXRfN1oZCnKXGe4
         Z7hCzWHW1s43eWWIO0y6VYrTK14tlfE6ZOmuqRSi5E4HGOAsiHeHESn/STBpNEOVxLl1
         aUOQ==
X-Gm-Message-State: ACgBeo3XUzW9pa/xqenMSIhYRJcC1dCRswiCwQA4oXaYQ5sQs3B1q06A
	ABrCXOp8uZbYOm12aTRHoUAPqoMEb1WxPzzw
X-Google-Smtp-Source: 
 AA6agR5yoEaSkwHOUUdzaDuAZjaoq+9LfB5/dYnZDzOqvu72LKHdkLS6q+lVaYvnvfO730nlcm/iSA==
X-Received: by 2002:a63:68d:0:b0:423:317a:1e07 with SMTP id
 135-20020a63068d000000b00423317a1e07mr17575111pgg.172.1660738083721;
        Wed, 17 Aug 2022 05:08:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 md20-20020a17090b23d400b001f30b100e04sm1388711pjb.15.2022.08.17.05.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 05:08:03 -0700 (PDT)
Message-ID: <62fcda23.170a0220.971b.21d2@mx.google.com>
Date: Wed, 17 Aug 2022 05:08:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-84-g3b53e4dbd9f41
Subject: cip/linux-5.10.y-cip kselftest-filesystems: 5 runs,
 1 regressions (v5.10.131-cip13-84-g3b53e4dbd9f41)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Aug 2022 12:08:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9276

cip/linux-5.10.y-cip kselftest-filesystems: 5 runs, 1 regressions (v5.10.13=
1-cip13-84-g3b53e4dbd9f41)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.131-cip13-84-g3b53e4dbd9f41/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-84-g3b53e4dbd9f41
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3b53e4dbd9f41171cf639b3ba0b107f6d6f444ac =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/62fccc57013365a446355649

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig/gcc-10/lab-baylibre/kselftest-file=
systems-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig/gcc-10/lab-baylibre/kselftest-file=
systems-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220812.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/62fccc57=
013365a44635564a
        new failure (last pass: v5.10.131-cip13-49-g1145e9c6352e6) =

 =20

