Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EA7C00140
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 15:24:34 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web10.8108.1658849065738540970
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 26 Jul 2022 08:24:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=QkKbMlPy;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id v18so486210plo.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 26 Jul 2022 08:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=2CPKfqASwC7mXzRldCfDMFs3S0z9Fc7p/ZeFg+kPNhc=;
        b=QkKbMlPyarZGhKYi7jzi9G7aDeBsF9czfJfOJEh+mbJqy+X3qwyOQ0xBOLYvR9ZzSi
         kCeZdkeHaoFx2HQJz3BzUnMjsGSm9skIDpu/JjcUIhLfZsLZ1S/s585KXUl4L/E9FQAD
         IErgRABcw7vCQcnI2WkLp1l1ZtgLYej/D11V/ugz91hUjhBmhlWiKBJyHh94UuOWQ7sz
         vR0Rw/Hc/LdZuaddeK4UnLB6TBHvhUhJTX7koZEqF4ZaGE+hUloSesFrsLDK3PkeZSPD
         7xzJxtiCAvAoYDqTuU0Sbb7Uphk/A/Fd1aYTNjtLx1TbwLvJXp1oYw2ZRVJk6N6eZTdb
         hCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=2CPKfqASwC7mXzRldCfDMFs3S0z9Fc7p/ZeFg+kPNhc=;
        b=dZaRNP+wp4fSmvh/x7fgw4FV/yBBXh1KBTOJW13oCLgLLsOaC1AWpuDOoyEjf/Prvw
         +i4yGvFy6s6VwpVZEadMjUIVvrwjnmZBbXf5G7ERG0NTYD4pkqvlogHOZ+jRZZB/kdnZ
         jKp4I/QduJyIgns+QVr5dJnEF6p3eEsay0MiDbwCJpMVhs0O7DxTwZuwBHffvLDKjaB7
         +PpuO2qQ6U4BZ47klLJj6yfXRbGWxC3x+xetrN9a4S2UhCbSd4zbU1/pTCY1gHsKGFjb
         KrUeafgxwNJ82If0JM6NBtuXHy34oTwZmSklgG5OHU6HMYW/G1ZwRDoJuqSHQ/vXVO0/
         jQBw==
X-Gm-Message-State: AJIora9/oqw7XdmbFkRyfCLEQNXNpSwKoOPQQFiA9UhVsT8GPn6aW6eI
	BREhonF1x/c+PigsX21q18RrpelPpjfQjJaH
X-Google-Smtp-Source: 
 AGRyM1txj97kBi9e68mQZh5ykkmci47IP/Y6TPgFhWolc/+SOH8KmAS/Z3e8WDsVNGj8C/ojo017TA==
X-Received: by 2002:a17:902:a618:b0:16c:abb9:d7a6 with SMTP id
 u24-20020a170902a61800b0016cabb9d7a6mr17302579plq.119.1658849064912;
        Tue, 26 Jul 2022 08:24:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 a199-20020a621ad0000000b0052bead2183asm7118957pfa.159.2022.07.26.08.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:24:24 -0700 (PDT)
Message-ID: <62e00728.1c69fb81.65f2.aaee@mx.google.com>
Date: Tue, 26 Jul 2022 08:24:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-36-g21d9d56f4de5a
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 8 runs,
 2 regressions (v5.10.129-cip12-36-g21d9d56f4de5a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 15:24:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8938

cip/linux-5.10.y-cip kselftest-seccomp: 8 runs, 2 regressions (v5.10.129-ci=
p12-36-g21d9d56f4de5a)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | multi_v7_defconfig+=
kselftest | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.129-cip12-36-g21d9d56f4de5a/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.129-cip12-36-g21d9d56f4de5a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      21d9d56f4de5acd415b12aecf82f754e9e6065fb =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | multi_v7_defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0018284531f90acdaf09c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/arm/multi_v7_defconfig+kselftest/gcc-10/lab-cip/ks=
elftest-seccomp-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/arm/multi_v7_defconfig+kselftest/gcc-10/lab-cip/ks=
elftest-seccomp-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/62e001828453=
1f90acdaf09d
        new failure (last pass: v5.10.129-cip12-12-g93db31b19404) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0010c2a52bd223edaf05e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-seccomp-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/62e0010c2a52=
bd223edaf05f
        new failure (last pass: v5.10.129-cip12-12-g93db31b19404) =

 =20

