X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.445.1652370903210957416
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 12 May 2022 08:55:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=7Mm9o4CL;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id s14so5289512plk.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 12 May 2022 08:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=zqxTavb/uCVNt2BktIAy7n5T8491HtTz94gBKigtsEU=;
        b=7Mm9o4CLZCYcARxmr8aQk+xQ1nEC1udxjCHMgRKc81VyU38i0RDLcZPmsyEYQK/42Z
         ZSS8oHaxr+fpSoZzo+8v4PxzdCMEYfCclVOfQXm8DvS2bgjByWPLWFquTFoq44v0xxF7
         1tesyinFYlmojgq9H+mTl91hqn8Ee3xywfIyDeIZHR+Z8rpThfzZNffoRMpvRcG98MRX
         83PMhZl+bpHcphYGrhchiNauUlEzR31xwF3LZCwGZE6G+lD+phYukgLnkvc7LRngY0qx
         y3ner5dobO7g1Iu3SMObCgjxL8r6LnXIGedaVE4hozgPEWl+/JxFbgSZ4gLWC8rv+QZC
         ZihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=zqxTavb/uCVNt2BktIAy7n5T8491HtTz94gBKigtsEU=;
        b=YOyDPaV/6WHlbvRrtz4zKI3cIStnxwdrMxMaL7B4OjtXSwf9cOL/2XfFa0u00b6gVW
         3/THcEtCb/JBdNldNHu5AZnfJU370bmnhu+KPlghbhcB3VBFDcY+kRb6Owx55FIUffWl
         U0j8YuLXQIkKNywoejf6BMNWSfbDWmdNC7VdVYN8gqzkLAf17YMpG4SVMGSVGWnQx89Y
         zuFbLYymMsYEGU/sJZ2kb+hpRonb86GAGHX4/ZI15sWXl2tw/Noyk9KBIHZaTd1l4wdV
         6ArkVJHJc7d+NA8ajDO5lInfkw5medklyz/pNmgkXe6ddUCeoDKqV44oS3N3h8DCUhgp
         eCSw==
X-Gm-Message-State: AOAM5336wR3pRKboSaz0Z6IbA5gwPa0EefxAbZXz61XHkKKK3N8uqcMU
	b4kZSRxWT1K7xddCcyOaDJZA84CB+8zSHWbSRBI=
X-Google-Smtp-Source: ABdhPJxboKu1j7tV0AmF1k9LohQ9LDaUG63altEVMrukffLxcL9ZZBDcDqGcL5qtfU9P4jvw91O2lA==
X-Received: by 2002:a17:902:a981:b0:156:229d:6834 with SMTP id bh1-20020a170902a98100b00156229d6834mr224870plb.128.1652370902597;
        Thu, 12 May 2022 08:55:02 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902a38800b0015e8d4eb1cesm106480pla.24.2022.05.12.08.55.01
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 08:55:02 -0700 (PDT)
Message-ID: <627d2dd6.1c69fb81.e3926.04b0@mx.google.com>
Date: Thu, 12 May 2022 08:55:02 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.112-cip6-289-g2969e096d186
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 7 runs, 1 regressions (v5.10.112-cip6-289-g2969e096d186) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 7 runs, 1 regre=
ssions (v5.10.112-cip6-289-g2969e096d186)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.112-cip6-289-g2969e096d186/plan/kselftest=
-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.112-cip6-289-g2969e096d186
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2969e096d186c13cc3c3fc8927147105d46895c3 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/627d1ca55b72cc4eb98f5727

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/arm64/defconfig/gcc-10/lab-ba=
ylibre/kselftest-futex-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/arm64/defconfig/gcc-10/lab-ba=
ylibre/kselftest-futex-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220506.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/627d1ca55b72cc=
4eb98f5728
        new failure (last pass: v5.10.112-cip6-218-g8253434cd56a) =

 =20

