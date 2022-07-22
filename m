Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C789EC43334
	for <webhook@archiver.kernel.org>; Fri, 22 Jul 2022 18:14:17 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web09.11174.1658513651668265022
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 22 Jul 2022 11:14:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=WHZH9zRJ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id k16so5192281pls.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 22 Jul 2022 11:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=/NvNMsyNvYl613pFoW8501MMNnA+k/fhm3zui3vzIvc=;
        b=WHZH9zRJHh5QTen6+8Glpeqs2kwgx25l+GmbmMleGK6XZ0ECVARDNKkMYh+RrHfE9v
         4BmukO8/LX14mZncvsWIXlt0imCj64IBcBhWArdGugjtDypZFue4pjh5r5UL4HG+XPOn
         zGcb1C01QCg8r2lX5n50x+0FaLKsLvS2z6MLwODj+M+3O96OociOKVgllCIA+XWW0MHg
         jgtDFKi07kRUiDcuXjtXCoVZYjFvcTzpogwkJN+7UDYdb+N2NoL6SPwN2K1YeFegdKA3
         LUj5c2mLhgEEuz2NLJx5DVh1oxrqKbemsrfpv1DKhqbfc1lT1Zmtpl2S/HvAh0qJYeMX
         mjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=/NvNMsyNvYl613pFoW8501MMNnA+k/fhm3zui3vzIvc=;
        b=gpNpBADFKTy//dgmf5BnR96sE8zsxplkouBRLF7+/2Uf9HobskTUNUXtLvhAPqFgAp
         IfYYJjwInvgIPgh5A8JG9umW0dpRQPhn21Z3VquJdeNXR6Y06MOdnZIiXrkkBa7e3w9T
         OqFRBnJzczwVG3S8ABpApXt2RQhGExSbHodkblutiGARmdA0Y24+mM1m2G518QPemLNP
         svNL2eAVgs9vCGgXhWpHCVQSbpHJY6DyPllfIY7TXgtbTDK0ROfdcVyJ98WCg2DBvmNi
         Vp2/UzeyrIUlsya1FXkTR1SDnTPs8Z+DsPiY2t/YbtiIrQoSJrRwt8tk+YEe9NcFulQ2
         rM7w==
X-Gm-Message-State: AJIora+/g98iehlzcC5VCCdgTMJjttsF2fTvgxsGFLXH0mBDtuUO7/MF
	GBAmCZdjqr/KS2nhKIAMOcwJanZD45/ukyAu
X-Google-Smtp-Source: 
 AGRyM1uZ14/ndf9cVMjrazHiQbLauk2GfLAqstw3HJ5m+rPhgStvWw/9lDvJ86Q/MeDwnGjau0t/8w==
X-Received: by 2002:a17:90b:1807:b0:1f0:5875:9751 with SMTP id
 lw7-20020a17090b180700b001f058759751mr919858pjb.25.1658513650652;
        Fri, 22 Jul 2022 11:14:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 200-20020a6304d1000000b004126fc7c986sm3730444pge.13.2022.07.22.11.14.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 11:14:10 -0700 (PDT)
Message-ID: <62dae8f2.1c69fb81.fb5eb.5a88@mx.google.com>
Date: Fri, 22 Jul 2022 11:14:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.251-cip77-82-g10c370b53152
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc kselftest-filesystems: 9
 runs, 2 regressions (v4.19.251-cip77-82-g10c370b53152)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Jul 2022 18:14:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8885

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc kselftest-filesystems: 9 runs, 2=
 regressions (v4.19.251-cip77-82-g10c370b53152)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.251-cip77-82-g10c370b53152/plan/kselftest=
-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.251-cip77-82-g10c370b53152
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      10c370b53152e01c8282be083dc0943e33d50ead =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/62da5c0dee4f1c5f59daf05d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig/gcc-10/lab-ci=
p/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig/gcc-10/lab-ci=
p/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220716.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/62da5c0d=
ee4f1c5f59daf05e
        new failure (last pass: v4.19.249-cip76-57-gef3cc1b9e556) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62da62b17c1cb31d00daf05d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220716.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/62da62b1=
7c1cb31d00daf05e
        new failure (last pass: v4.19.249-cip76-57-gef3cc1b9e556) =

 =20

