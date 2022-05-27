X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web12.6472.1653672102474921065
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 27 May 2022 10:21:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Fd+ZxhhR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id s14so4672338plk.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 27 May 2022 10:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=+ZZnDAsOJkDYjgUBgKaxf/9yXP1o10tbhBE/62lOFB8=;
        b=Fd+ZxhhRKu6oK/lHw3bakbAX/wXB8iULv1RLKtxwpCnOrx/U2L026KPDb7saQEk3+t
         +rNjEwS8OUqYfjSN5fw4zFHjnBT6RDTBgkmOL/xCpa8m6S8SuCvJcLhPFWyttVW+s520
         BR1tWW5hvc7uo/ZpGf515nROvZlADlkJwguZ8+Bnt+JcPnHe8xW9SzYiW6yeQzE6bsgI
         3qrazNtZxwwBCIEWUTF9FD4zCFrns9nTmdQFL1XP2DyBzdbcCDY5JHcyr0jM8DL4w9Qy
         n/4d5D1w7wZbQbDCvinARaiE9a0cCXiHGkJE6Ue681514yd3zlpJSQMlN5V2tjmAQzQ6
         gAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=+ZZnDAsOJkDYjgUBgKaxf/9yXP1o10tbhBE/62lOFB8=;
        b=0sa8wmR7CUhmf7LLInedSFS+jB8OjxyMBqA+rg6mH8I0ZjWfE18hkuV4rRqaIMEi0O
         gCM+GOtxO4Alfjh/O6O9vdaWb9c9rDP6gDi13dTwNlg8anSyOwDeDDYLnIbO+cnErtVB
         xMUSU6HwjHXx+9+pv2RW+SNwy2HkKfwl9yU/+aOKcVH3ZZI3/dmUd8K2bCw18Ome5Jfw
         lIP57EeBp3XkGZjDYdYndrE9AAtu86ba4zVaz6MLqiQaULwWSm3b5KF5ZYCqFT+Gf/2a
         z5Yp/Tkzt/smaHA7FQaweEXaZPSU19yXA0frwVvIpCdbarI6tDBziNffVOweNY61pHNz
         RcsQ==
X-Gm-Message-State: AOAM533Cp5u+qWXusBGOJE+m4RhQX/s1VPfIR6HUYK9+YPP+MGlQedbM
	roHi9aeLh8LRyuc+A20z4LXtoQV9ygDaiFmLtKI=
X-Google-Smtp-Source: ABdhPJwmekDuweY8YGTKZtLQu4BABKmegEdiK1dEywtzBfHE8U8We8qLHs9dzk8yhN0vj2mxulsLmw==
X-Received: by 2002:a17:90a:191a:b0:1dc:a3d3:f579 with SMTP id 26-20020a17090a191a00b001dca3d3f579mr9612158pjg.30.1653672101518;
        Fri, 27 May 2022 10:21:41 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902c19200b0015e8d4eb234sm86066pld.126.2022.05.27.10.21.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 10:21:40 -0700 (PDT)
Message-ID: <629108a4.1c69fb81.e9966.057a@mx.google.com>
Date: Fri, 27 May 2022 10:21:40 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.112-cip6
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test smc: 9 runs, 2 regressions (v5.10.112-cip6) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test smc: 9 runs, 2 regressions (v5.10.112-cip6)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.112-cip6/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.112-cip6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c8f6747dcd02a8f87731c324f4bc37bd120a8982 =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:     https://kernelci.org/test/plan/id/629101e3f1b3a44880a39bd0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.112-cip6/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/smc-qem=
u_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.112-cip6/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/smc-qem=
u_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/629101e3f1b3a44880a39bd1
        failing since 16 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/629101f7a3b9a57b0da39bd3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.112-cip6/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv=
3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.112-cip6/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv=
3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/629101f7a3b9a57b0da39bd4
        failing since 16 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =20

