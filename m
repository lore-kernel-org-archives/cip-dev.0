Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6671AC433EF
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 02:11:00 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web10.1969.1658801451981229834
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Jul 2022 19:10:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=PodjmPRa;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id
 o5-20020a17090a3d4500b001ef76490983so11909392pjf.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Jul 2022 19:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=gDHRJ34f7elKGYyhurTL9FTAIlhtwhS8nOg6RueKP/w=;
        b=PodjmPRaYF8LI1LbJZLir1PNQ0NHMOAiRYGEbRnoVUGwvK5m0mqSEiYBV8fHE2V+Kh
         urwrYF+ouWMtXo2rkJKE/bbUUxKTE/CPSXfgtU4dS+YHsj3K0NJ2x9b1Wx6DafAS/HJj
         AEq6SxxmDnDnuOWt5OgsnHHXQ6WOXW8xlrvaEjD5PL/XpKWuMjvF/GZy5oG7Kug0p+HL
         uWhksqEIxZzvget19q+qQTw7ZjHv+K8ySDzbxhzBDfhhK9OBdl8KcwbHpm8vGAhw+2vx
         f9ZUaoevpHrq3SWdVg6cRnwhe6aALCmfbGH1t0zwt3fTLqnVs12h/a+p3xDu+y0KHkNW
         g9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=gDHRJ34f7elKGYyhurTL9FTAIlhtwhS8nOg6RueKP/w=;
        b=ophsYYQubJoHrooxXxv+ejuhYfXrhdh5C0/VCSxbKZl2JKuTsTVxmK5QZloD2MPYSs
         F4AyqCW8qRgIvVVAMW4JUx9TfqmQd6NudHwbJH/bWXDKJmKApuyaye+qspH9zJmfc4pc
         zALz64HIokXRG6Ox+CX6bcSf3XxUEJ64L8w5kctgZVJk+9LzViTtKFNWKeSuMg/s2MGa
         /B5PFouC8fJEvhYhxS8xZT07QoAkTAbf2KD50gv9D/eWzQcEG7XthxaZnVfQW5MZKkQF
         hEcm9MRRG4Mtuu4AjULJxOpW6qfXxi1jScu35/KVMIbkolcYX+MFC7aXeHmgEpsg99hi
         FibA==
X-Gm-Message-State: AJIora8SiRIWa64NXPq4zd/aaVVFDt/1LGcikOv5Sm/88L39oEo05VVV
	EfhcD/HukhthxHen3yqDcbTTsSi53YAgl94r
X-Google-Smtp-Source: 
 AGRyM1v0b1TpESiJ2qUm+yz/oCRphAS31F2ph4CyVMNAPzi43rq4gXxogLQisQf3AJ9D/y0xbhnhoQ==
X-Received: by 2002:a17:903:2344:b0:16d:2dbe:fb4e with SMTP id
 c4-20020a170903234400b0016d2dbefb4emr14632165plh.89.1658801451152;
        Mon, 25 Jul 2022 19:10:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 6-20020a170902c10600b0016c06a10861sm9911468pli.74.2022.07.25.19.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 19:10:50 -0700 (PDT)
Message-ID: <62df4d2a.1c69fb81.cd376.fba5@mx.google.com>
Date: Mon, 25 Jul 2022 19:10:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip69-517-g92709d8ae585
Subject: cip/linux-4.4.y-cip smc: 12 runs,
 3 regressions (v4.4.302-cip69-517-g92709d8ae585)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 02:11:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8920

cip/linux-4.4.y-cip smc: 12 runs, 3 regressions (v4.4.302-cip69-517-g92709d=
8ae585)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig       =
           | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig+arm64-=
chromebook | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig       =
           | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip69-517-g92709d8ae585/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip69-517-g92709d8ae585
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      92709d8ae585b3c97e359b1323f02c37349ee40d =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig       =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/62df3b4f0d9464660fdaf064

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-517-g92709d8ae585/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-vi=
rt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-517-g92709d8ae585/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-vi=
rt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62df3b4f0d9464660fdaf065
        new failure (last pass: v4.4.296-cip67) =

 =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig+arm64-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62df4821591cbb65c6daf0f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-517-g92709d8ae585/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-517-g92709d8ae585/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62df4821591cbb65c6daf0f2
        failing since 10 days (last pass: v4.4.302-cip69, first fail: v4.4.=
302-cip69-508-gd887d54a1be6) =

 =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig       =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/62df3a0e3ff2ed5542daf069

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-517-g92709d8ae585/arm64/defconfig/gcc-10/lab-collabora/smc-qemu_arm64-=
virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-517-g92709d8ae585/arm64/defconfig/gcc-10/lab-collabora/smc-qemu_arm64-=
virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62df3a0e3ff2ed5542daf06a
        new failure (last pass: v4.4.296-cip67) =

 =20

