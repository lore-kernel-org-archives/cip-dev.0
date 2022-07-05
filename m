Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAF3CCA47F
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 21:10:43 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web08.269.1657055440108715434
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Jul 2022 14:10:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=IfXv16Mh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id
 89-20020a17090a09e200b001ef7638e536so10016352pjo.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Jul 2022 14:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=a9NpbWCDyTAUD6ThLuIDOPWdNvKaRsogBF48aoL11SM=;
        b=IfXv16MhJrrHsERDjXwWmBMT6//NGBMsxbmocwhg+UKq1qJXrx0UxkCQoOs2UvaAyi
         utC7vrcU88msfSnSqF2eY0oVYVt7ep14Q498EsiUS/ERyuv2NvfJQA9+Vd6HxN7T4lIi
         lrEgAYrejXc/9SWbNpMt7ueyVJyWZeWW63njCB74QRALsPJuTOPQvm1q0dCEt7uID869
         IwQ+9OviaM8pZ+bHIvmdJ+G6+odqUfPV+jWcJf5+KXfujZyY5C75fshE7TpwQBxoKNIc
         ajTg/EOrz6D5trKrIx8V75oswlRHirUPyT68g2q6lSLKugnhKKVsZ/N8yMXVI/SJjh3b
         P5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=a9NpbWCDyTAUD6ThLuIDOPWdNvKaRsogBF48aoL11SM=;
        b=R4TfVG6sRDmKa6calIEcw4xm5MOtPWzeJ5YJsLTnhd4dWhr+uEGrH29oXOSBtwItZb
         Jo5Gh2oxRlPV3r9JJt9Nk2bkxKEYhs9gQMJ8jCRCMjLsYHFi/7JTv/liEyFOXXdicn7R
         YuVPm1ifeG6T9gD2li6CdSqyVp1U7gr1Xt+MGYhFjO1MmLbYVtSbCd6TH65kEAd+H0cJ
         vvsYIXjMDzguNbeCuPzv1fHLuFBxyWK7y6t+ZT2kKHY5kEpqEK6PcaJuc+FFt6pM2JxK
         oZ+QvG6O5ynV3OiAfRXeE7tVGTjmHoU1dtT8FgSaVUr82LivfWFW6BTHb8QzqGyN//sr
         KpZg==
X-Gm-Message-State: AJIora/Tk9EjE2axWZnSWi8ixNg25hM3LCTd3J2JUk24eKOE0yHwciXo
	aJlV2VAGe0PxrmcCmphBwrCdSnmCLYu7GAM/
X-Google-Smtp-Source: 
 AGRyM1sKyjcxhXDs8KBAQpT3hzAfzRTaKB4ZBoP69mR5Fb4RFUIfQVQYQWvA7JSNrrXS9ZTzUbrlYw==
X-Received: by 2002:a17:903:24e:b0:16b:a02d:41fc with SMTP id
 j14-20020a170903024e00b0016ba02d41fcmr37234193plh.121.1657055439424;
        Tue, 05 Jul 2022 14:10:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 v187-20020a6261c4000000b005255f5d8f9fsm23502124pfb.112.2022.07.05.14.10.38
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 14:10:39 -0700 (PDT)
Message-ID: <62c4a8cf.1c69fb81.10c2f.1d89@mx.google.com>
Date: Tue, 05 Jul 2022 14:10:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.126-cip11-1-gc5218dc69ff1
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 6 runs,
 2 regressions (v5.10.126-cip11-1-gc5218dc69ff1)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 21:10:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8694

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 6 runs, 2 regressions (v5.1=
0.126-cip11-1-gc5218dc69ff1)

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
Flinux-5.10.y-cip-rc/kernel/v5.10.126-cip11-1-gc5218dc69ff1/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.126-cip11-1-gc5218dc69ff1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c5218dc69ff1f0703b893c079a21669841b479e1 =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/62c4955b727b70db9ea39bdf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-1-gc5218dc69ff1/arm64/defconfig/gcc-10/lab-bro=
onie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-1-gc5218dc69ff1/arm64/defconfig/gcc-10/lab-bro=
onie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62c4955b727b70db9ea39be0
        failing since 56 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c499586b82b91b1aa39c83

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-1-gc5218dc69ff1/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-1-gc5218dc69ff1/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62c499586b82b91b1aa39c84
        failing since 54 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-289-g2969e096d186) =

 =20

