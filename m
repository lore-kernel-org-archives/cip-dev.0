X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web12.19245.1647204820721035186
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 13 Mar 2022 13:53:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=3QkEnYVw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id v1-20020a17090a088100b001bf25f97c6eso12506683pjc.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 13 Mar 2022 13:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=E1APzL1Mmn3nTdO6U5ECzKLm3AiKdc55jrQfVwTL6EI=;
        b=3QkEnYVwpqqxs+uPBXcDGXdi3LF63fIE6vmfmXDYdjdsgVAr9QA7PrE8YruaypJxgE
         JffAIkIPrtzhQzjp+TGVv9Rb+VXvoNmPtTbk/SIk7Q8BMPhB2dbCrEi9LyiAjj91yLOo
         +SFCvko5nWXV+/7MEn9KH9JpqToP7SMOw2QY5oaMpQrOZitmirCFnFxFoGqMte+iPiA1
         glhU6iZc17ufdm5sDCYMyRDT1LYIBB9AbEMDMfimAFQYxuI5X7DFbbddQGBn7ncuRCYk
         5Hekm0/p2a1BB0SF395zU1xQmQ8eJyBB7Dzqn+RZyLMBi0P64bE62Zy96yx9777i1zsF
         wC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=E1APzL1Mmn3nTdO6U5ECzKLm3AiKdc55jrQfVwTL6EI=;
        b=truBKbQb8JDmuVeRv74t2Qd/J5j3bSwiEEbyXYUDDt5ov5qsY3IUXfeZly8ZJhGzsa
         YyX6UIqBlpYEQJ2IxmnIklC1j5yQj/L04TJVGo8FpweMApzdZzc8+17kkeG0wxZ+pOTD
         fEuhoxdCp1gh+yW8g9xA0Ax2vh7jIOMU9OVPYWYpcjHeQf13ZbvMFoCNAT5sERiI8LNk
         7hkxUFUJ1MYlY+4zpUzR64X3OzB1NVlpF6CpxrHOnL5mOEnLaRiMvqmnSpuvGRLU1Ol4
         ja+Rc31lyndvdco/flqsZM5JbY969ATfTbk/3kC9szD6RJbLd1owyh0vMCoDSGZxDHWY
         to0A==
X-Gm-Message-State: AOAM533O5s6YNDR190e87x3zVQGn2xLQzuo9kN+K3PF11WOU0WK+QsK1
	hk/g+ksmC9zUZT7hAJkMzQvs/TPZrgY8RMMoAbA=
X-Google-Smtp-Source: ABdhPJzKltDtdTts8QUVJvZE8gP3N3jixf5ONmiOYDxKvSYVVHTyD2yp+Gzctw4uFDbNFV326kDiZA==
X-Received: by 2002:a17:903:2447:b0:151:f899:9d9d with SMTP id l7-20020a170903244700b00151f8999d9dmr21068702pls.28.1647204819925;
        Sun, 13 Mar 2022 13:53:39 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l9-20020a655609000000b0037589f4337dsm14549767pgs.78.2022.03.13.13.53.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 13:53:39 -0700 (PDT)
Message-ID: <622e59d3.1c69fb81.54284.52e9@mx.google.com>
Date: Sun, 13 Mar 2022 13:53:39 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.231-cip68-123-g92e3e7f3d4df
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 12 runs, 1 regressions (v4.19.231-cip68-123-g92e3e7f3d4df) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 12 runs, 1 regress=
ions (v4.19.231-cip68-123-g92e3e7f3d4df)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.231-cip68-123-g92e3e7f3d4df/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.231-cip68-123-g92e3e7f3d4df
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      92e3e7f3d4dfeddc69231ba7a1a4f6b0bbece2e6 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/622e4d7762fc2fe421c6296e

  Results:     82 PASS, 6 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.231-cip68-123-g92e3e7f3d4df/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.231-cip68-123-g92e3e7f3d4df/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220228.1/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/622e4d7762fc2fe421c62994
        new failure (last pass: v4.19.229-cip67-111-g5c3c0b39cf3b)

    2022-03-13T20:00:36.772424  <8>[   37.616344] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-03-13T20:00:37.797686  /lava-5872198/1/../bin/lava-test-case   =

 =20

