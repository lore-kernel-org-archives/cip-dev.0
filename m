Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD88FCCA47E
	for <webhook@archiver.kernel.org>; Fri, 24 Jun 2022 17:14:18 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.10413.1656090847293540735
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Jun 2022 10:14:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=HnqPA/IF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id q18so2608897pld.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Jun 2022 10:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=DuQ0o/1UuemBcNw505ANTyvSpF9HsuRFr8ukq9KKjCg=;
        b=HnqPA/IFqIqZ401lfVN1fbu4U0DZtdffGKhlgscc1AI/XOEC/zSFebLbV8WrKsjj6y
         yK8EOOh3lD7EwpSvVTfC5+lVK03D0pUs/rqc0nrhtgrdREjjNUlRFMHjdYqRI/kNLkom
         uaTawsUZZVOcV4MG3zKy/Qi7+mfF9/ANma9SBhILgDAj9PZN6kIGNSGL4TFVz64OG7gE
         2/7n0BgMe6QieZSmH0j1zACjpBqxUfasY5V3sxoX4fp3Qipx9qBowS7XbdJU2+wG6Jck
         AEUNqYh+yBituRF+2SD7VKtzxpWioESFyvEpXWMJV/CDoRann+5OThg8MjEV2/gkQinj
         rdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=DuQ0o/1UuemBcNw505ANTyvSpF9HsuRFr8ukq9KKjCg=;
        b=Dr0Q15ggR8U0cHq9fJXNAg3A3A0PERM4v2MpWlbD2H3WdGOwGpKQkTPUKQxD4erm/k
         Q3yh5o/VsA33drcH0Lo4BVUEOJ0Z8Dl5yIT0AolCG1PlC3KRVgq5V9/Hu0rzvV/8yjBb
         V5jYyjdi0UZBogw/jwSjH3VoJ3o/QXHjJOjOZXCK6jZMkAWGduvptBs0YYCqoiq7yZBO
         npXAZ5qZJyfZ2xGzOg9YZ6hAN9AUunbhO3JN6IzKrCCF1rDlTWfyjT1DNYC4lqwjyTvm
         ZrkIdWEVauG8Azn5XMuW9Yz+tyXiHvytDK8o8EdKnM/kE6i7tnUYNXTuFmMAoQxSijiZ
         2Vgg==
X-Gm-Message-State: AJIora/ZyBBbuMc6notiEIcjIg/POgxkm5omlEIkm/lE9/r6BIqQyXil
	e8P00b1vT4RKdQJePJdMr0minHzp1iNTOksXbj4=
X-Google-Smtp-Source: 
 AGRyM1ueTORvT+ovlC0BoDODg1oQtYS9T/wsv92MeE/lYgsYVd5ibzHLNLgZmxNSGZ/3qeMgWB6f2A==
X-Received: by 2002:a17:90b:4d8b:b0:1e3:31df:c98a with SMTP id
 oj11-20020a17090b4d8b00b001e331dfc98amr5089961pjb.175.1656090854196;
        Fri, 24 Jun 2022 10:14:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 t8-20020a635348000000b0040d274ba1b4sm1870285pgl.49.2022.06.24.10.14.07
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 10:14:12 -0700 (PDT)
Message-ID: <62b5f0e4.1c69fb81.496e5.2a7a@mx.google.com>
Date: Fri, 24 Jun 2022 10:14:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.121-cip9-272-g3fb28d4c623b
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 10 runs,
 2 regressions (v5.10.121-cip9-272-g3fb28d4c623b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jun 2022 17:14:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8598

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 10 runs, 2 regressions (v5.=
10.121-cip9-272-g3fb28d4c623b)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.121-cip9-272-g3fb28d4c623b/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.121-cip9-272-g3fb28d4c623b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3fb28d4c623b354373a844dd48f16cb4f005388e =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/62b5dfb8affe897e93a39bd0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-272-g3fb28d4c623b/arm64/defconfig/gcc-10/lab-br=
oonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-272-g3fb28d4c623b/arm64/defconfig/gcc-10/lab-br=
oonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62b5dfb8affe897e93a39bd1
        failing since 45 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62b5e1300833dfdc5fa39bea

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-272-g3fb28d4c623b/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-272-g3fb28d4c623b/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62b5e1300833dfdc5fa39beb
        failing since 42 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-289-g2969e096d186) =

 =20

