Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C23C43217
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 22:37:27 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web11.346.1668033440417206458
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 09 Nov 2022 14:37:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=fSF5gKVh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id g62so58609pfb.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 09 Nov 2022 14:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nm3bxKK37L1q7c6btXxYVDtM0e1675ZuhNf28TvWrAg=;
        b=fSF5gKVhIASk6bpdgDBcfHguVGat8kanaNcjgd3S+TaUsRXP0aAO0ZZK2mpMgS2nIy
         eJgL2GxDSxYmjrL5IL8DWHkkTSUH2zE9m+tYaDYPlVOUq39N4QWH3LLPasNBlyAkV9ka
         T1VeJYgMPY2MuX9MQ21MFIAvvMLG4mV0JTNEJyDLMeus1oQKt6ZM2uYXsLbMrsYgaO1V
         xUYsKgn+QO7FCVk2R7ElG3CEb6PrNqyNZ4rUnzp6eJw1hLQQ7wkzLqOYM9+NJVUo/MMQ
         PhWTKI2viYT2Xy+B4N3Gbwyob0KCppcXWZ42LxEC9xP1E8tb+BwW0wwtVMgVPGHU3VSQ
         exvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nm3bxKK37L1q7c6btXxYVDtM0e1675ZuhNf28TvWrAg=;
        b=XV2KawSh/kBMltlPiJd5+1FNvRRD7OZ3o4H6OFEL2Bu05QswW08pAUR3G7gIoufxFV
         H+7Q7+HB+bI/XJY1WW8vCNluWIb/oHPM2owHItlB/Kdgh6+fuN+VRL450nGqA16toJsP
         DhFxLw/B2rotW6XFbMVppiNI10JlJi3oCMN0s51mlRbLJuSgvxFGA6VPz7dVDWVN/zLH
         Xc/rhsSCImVepy2Dxaovd9ZzyGoaV4SYNfZmADK+VxNNvFcUGTZPIS/LuAsxNRQNqJGf
         xoKhb1u5so1Dy2cSOnJN6nMpR2lHAY7TO0cvCevU40Qg/sKI0YNqP85quwqq08GNp4Dk
         9hcA==
X-Gm-Message-State: ACrzQf3LBS26LT0Iqx0TUP8mjxAeRW/FqVR1iOm/SqqaASPI7XaEsRU9
	/7wiQ8HqYwR7uIBn8K3jotUgVKiK35vCXIAYrbU=
X-Google-Smtp-Source: AMsMyM7cbOfys1HXRxgHYlakwPWUXrb6fxrtnECoOqGSr5yWcDHazhoB5y+gs2YcH+QIaIznydXc7A==
X-Received: by 2002:a65:6753:0:b0:438:e83a:bebc with SMTP id c19-20020a656753000000b00438e83abebcmr52547562pgu.602.1668033439816;
        Wed, 09 Nov 2022 14:37:19 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z185-20020a6233c2000000b0056d2797bf05sm8717977pfz.217.2022.11.09.14.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:37:18 -0800 (PST)
Message-ID: <636c2b9e.620a0220.67dce.ef04@mx.google.com>
Date: Wed, 09 Nov 2022 14:37:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.153-cip19-3-gc76f4e7e5c71
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 6 runs,
 1 regressions (v5.10.153-cip19-3-gc76f4e7e5c71)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 22:37:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9978

cip/linux-5.10.y-cip kselftest-seccomp: 6 runs, 1 regressions (v5.10.153-ci=
p19-3-gc76f4e7e5c71)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.153-cip19-3-gc76f4e7e5c71/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.153-cip19-3-gc76f4e7e5c71
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c76f4e7e5c7160107c9b5d8ec188f61fe326cec3 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/636c170cb98f2cc6b0e7db4e

  Results:     87 PASS, 3 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19-3-gc76f4e7e5c71/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc=
-10/lab-collabora/kselftest-seccomp-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19-3-gc76f4e7e5c71/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc=
-10/lab-collabora/kselftest-seccomp-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_benchmark: https://kernelci.org/test/=
case/id/636c170cb98f2cc6b0e7db50
        new failure (last pass: v5.10.153-cip19) =

 =20

