Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4438EC48BE4
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 15:24:34 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web11.7931.1658849064748581072
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 26 Jul 2022 08:24:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=pKmWUMjp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id jw17so1374684pjb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 26 Jul 2022 08:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=jKtlgoq+9ppG0eiFWwIF9tSb5cTTLZJ8oUp7CHINREs=;
        b=pKmWUMjpXYud9Tp7UG93SYBjP4aSnyHKR/HLOXvlgdUNtLtxfBXXtl/zXgHyJzKWDB
         VIpgOBa9g9gie1gkMVzS03neiE2u8dm0c8yNvWvvI/P3Nr6AAqq5aKjifJ+HhpL4zt0P
         MUDGQs/gukLhm/yrVp5Tl/qKFfBEsRefkzR5wfWfpdZpooHYz3y060XSRCh64+3F/1B+
         w/argHrvrhk80CxMoHixDH+iSBIPnDqKB868Q/M8klq9xvSyfyvZ5p2Q0JA/+RHhkNxX
         KUNqXSVG83JO/m8WDrhbEMgTVDMxK86y56Mh1HCDhrY0EGAQ77dHNbNBNWeWym68/+c0
         lNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=jKtlgoq+9ppG0eiFWwIF9tSb5cTTLZJ8oUp7CHINREs=;
        b=jgVfE7qIym8qQkQVB9VZfs4hKk+nwgZobDt7kMjfN7SG8H8u0qsJ0sdjUI61QmXShx
         /FXT2Y2i8+7TMDt+qQwsiciA9yhkGgp8ntB3V8keU/c8Kb2c7L8ICzOQCzZkIgHdRAEV
         phjt2FS2tiwgYZcOHs8SdFGnnqPGEvAh5qlC6+Zr/qgBOrI2uG1qa6UTPygA7m8fUmHd
         9DE5QyVZEF9/v9lbQgE0xq6t7oyLPBd7+IZj8OQPkr1/DJWFFFhEegwVz7Kfigx3940t
         sPTvMX7wAbHN6lGmRdgbab/wg38BEt/0mXLWzTsPXGtp1Wdt4F/UhucshRqrXuih6Nz0
         65zQ==
X-Gm-Message-State: AJIora/ug/ckERcsRtKfiF7cAP2ypnlwy2XFy9uJlWmKJGjU0leUltNP
	RCfyIyMOQ2VlKbzCPO6n5zbGwVqnrgy11iqK
X-Google-Smtp-Source: 
 AGRyM1s9G+EPOCRyqtsVQVmPyLCZuTQW725CPnJ1ikciupq3WB3SAOrLOyxFTM5Njvp4UDAsWJW5qg==
X-Received: by 2002:a17:90b:4ac1:b0:1ef:c1ba:e717 with SMTP id
 mh1-20020a17090b4ac100b001efc1bae717mr19536980pjb.92.1658849063997;
        Tue, 26 Jul 2022 08:24:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 o12-20020a170902778c00b0016d1f474653sm11400491pll.52.2022.07.26.08.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:24:23 -0700 (PDT)
Message-ID: <62e00727.1c69fb81.783b2.1b26@mx.google.com>
Date: Tue, 26 Jul 2022 08:24:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-36-g21d9d56f4de5a
Subject: cip/linux-5.10.y-cip kselftest-futex: 10 runs,
 1 regressions (v5.10.129-cip12-36-g21d9d56f4de5a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 15:24:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8936

cip/linux-5.10.y-cip kselftest-futex: 10 runs, 1 regressions (v5.10.129-cip=
12-36-g21d9d56f4de5a)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.129-cip12-36-g21d9d56f4de5a/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.129-cip12-36-g21d9d56f4de5a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      21d9d56f4de5acd415b12aecf82f754e9e6065fb =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/62e0040312a98b7adcdaf085

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/arm64/defconfig/gcc-10/lab-baylibre/kselftest-fute=
x-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/arm64/defconfig/gcc-10/lab-baylibre/kselftest-fute=
x-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62e0040312a98b=
7adcdaf086
        failing since 17 days (last pass: v5.10.126-cip11, first fail: v5.1=
0.129-cip12) =

 =20

