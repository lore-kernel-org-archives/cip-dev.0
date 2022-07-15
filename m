Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DF8C433EF
	for <webhook@archiver.kernel.org>; Fri, 15 Jul 2022 12:21:15 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web12.5653.1657887672693548468
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 15 Jul 2022 05:21:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=Xo6xIJeQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id l124so4515394pfl.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 15 Jul 2022 05:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=uTfVYLpbjw7ccCoTefyxUsFKUO/n2jrfw+XlAq1XxVU=;
        b=Xo6xIJeQrPSftIcOqCeKXyJ8kI6bV23VSdo2SJ/xBDLOiPuyUBbDFANmTAN2q+7BrG
         +SWieNI3Jh8WEw0oCmkbeVepVB7bqSHty4LJ1iqumd9wLPI3Ymkkr/WaCX1nSHuwZnkm
         ST2sC6cFVphJsePe24pGe80WUy/CJgMauR+RQVKmxyGz7pLqr49/keUzXYcKW1FBKRJA
         yJyW3Q/sZjh04dfeTZVmfYdZjbY7pRe3RZWcSwzT2dJJysABeO6G//q1wz6nPmLIIJ/r
         RFXUSlLY4YtXgQxZnnO8lDFLsrNQt/jeN7CYwumjzo0N1jjZxZGFmP9+SA1mO+mcC0NW
         QtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=uTfVYLpbjw7ccCoTefyxUsFKUO/n2jrfw+XlAq1XxVU=;
        b=p2meicsNg7Tkn0M/P9dlKnNCRNpWvjCBlFJvlBVNh8KF32VikJ52gQh++iqs1Bq8CP
         +CBSbaTOPYzFggQUJzxL45fh9DsQIOZi/jREI40Nf4B9cFi4n/5LMVK4+bU/l0Dj8U+K
         hZigehbIo/dtQYSjc5W4GBEOocHe9MUKd7LOsXrSNhnYpDhyB8diblvHN7ahEl0fFiPl
         LLgWzbtAnKBNEs7FhQCs5EVACiMPb2TU96kvBLBocUp1DwiKjHHTgFK0GCEEgQbttKcl
         fuuwx+SnLJP2DxZW1zgk/3kkVMz7jp1a7wrOQBrFRkQT0uMTrmTpgfPhKVFrxV3VcFOb
         xUWA==
X-Gm-Message-State: AJIora80WdwN/fxkM30vlGOEfGU0GQ2VOok+sT2hdibnl38OONZwGAPl
	aKsdrBeFsUQZse9gA+6K4wBbzWIr9EeCXhzO
X-Google-Smtp-Source: 
 AGRyM1uKwROCeBZbckpvD2iKGYlXjjWKef/aRmWwj5bbMK0ofvLn08n25qoL1EjB6LDDqfKqXKsP9Q==
X-Received: by 2002:a05:6a00:188e:b0:52a:af7f:e715 with SMTP id
 x14-20020a056a00188e00b0052aaf7fe715mr13635759pfh.2.1657887671923;
        Fri, 15 Jul 2022 05:21:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 b6-20020a1709027e0600b0016c3f7b5b48sm3385204plm.256.2022.07.15.05.21.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 05:21:11 -0700 (PDT)
Message-ID: <62d15bb7.1c69fb81.e4b33.545d@mx.google.com>
Date: Fri, 15 Jul 2022 05:21:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-59-ge5b19636ca9c4
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 4 runs,
 1 regressions (v5.10.129-cip12-59-ge5b19636ca9c4)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Jul 2022 12:21:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8828

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 4 runs, 1 regr=
essions (v5.10.129-cip12-59-ge5b19636ca9c4)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.129-cip12-59-ge5b19636ca9c4/plan/baseline=
-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.129-cip12-59-ge5b19636ca9c4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e5b19636ca9c43e262a365d756d491479adb3884 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/62d14f3df838014977a39bde

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm/multi_v7_defconfig/gcc-1=
0/lab-broonie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm/multi_v7_defconfig/gcc-1=
0/lab-broonie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62d14f3df8380=
14977a39bdf
        new failure (last pass: v5.10.126-cip11-116-gef362fbbff528) =

 =20

