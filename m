Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD072C433EF
	for <webhook@archiver.kernel.org>; Mon,  4 Jul 2022 08:22:49 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web08.69800.1656922967017634147
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 01:22:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=5FxwRQQp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id r6so3988355pfq.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 01:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=mPOmyIKBMWKpRPzy4H/o8vm7nzfMxR4rBwN01RBTlZ4=;
        b=5FxwRQQprZVchN0ssSZVeM3zxknk6V8eBmWTkEkpDBzdWs9jcTLKa4BoL0jGCLqPVV
         RMngRfVxF3hHXOkVkbBJ569BVJ+L6kQSavmiDjvJomLOgO8+Qn2VQ+oXRol1+zYG2qrt
         f3Jn0pDHKaTUKo3wXJv+tTj4r7pmWweQk5K5ZCx5zzm90Zehmcti/rBj6/sVInoAlBza
         XlSo9BjMmJWTSj8rProyoOVQxyBBt/WZ5VttapO6WdZ02Hr7eK6fWXzkTC1OsAAAGSG0
         W/AQPsVMSpCxa46POAR/uEcHgjFL19lqIHM8E344TiHA877AJf0ffS5puMsTs5paGZ25
         PO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=mPOmyIKBMWKpRPzy4H/o8vm7nzfMxR4rBwN01RBTlZ4=;
        b=FBsLN81bqDInF2xEaqofOiy1HdjRHCapZpE18k+cUpV4pHBnUs/NiAimir5Tnu+3XM
         r56OvqdMRbOv331sbB1+7A23VDd4XBhKdHxVmxTJ0BMrKPNDlJFsBScYddsbFN/9leXf
         inAnNxbotHk3pQ1qz0bcg6+KMg/KsS7JvhSU0YVz/tdGS7hkigkZZ82uLqIqLUgFP9ob
         nYNGvYU5Ft2ZnJqSFwsp/kH1VgasOHPT8mEWYhjp4tOqTALWn0vCpBlEq+6kuhjYZSR9
         ojq7Fb4G45Lw5mlaqE8bjBc63BfEnhFC2zzFhtAP7yABVLzOmYadxmejNOmySE3mnNco
         f+6w==
X-Gm-Message-State: AJIora8x/kXmbECd4kNijXPgJ3Kr8KFSmEdtpZBQScPCDYmhz8ML7sAw
	CVEXaRVb1YBA3jp8GnEatseZRxWYIkxAMR2/
X-Google-Smtp-Source: 
 AGRyM1vKQNZYVBRtEeVNETJUXOVxI/qWi0RQsXx3Ual1/j6FZxwN5RDFaQQGBx0j4VoEaQVdDvWzUg==
X-Received: by 2002:a05:6a00:14c5:b0:525:3797:fd3b with SMTP id
 w5-20020a056a0014c500b005253797fd3bmr33582927pfu.27.1656922966358;
        Mon, 04 Jul 2022 01:22:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 mt7-20020a17090b230700b001ef7bd5b711sm3324875pjb.0.2022.07.04.01.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:22:46 -0700 (PDT)
Message-ID: <62c2a356.1c69fb81.5e283.45f9@mx.google.com>
Date: Mon, 04 Jul 2022 01:22:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.126-cip11
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip smc: 11 runs, 4 regressions (v5.10.126-cip11)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Jul 2022 08:22:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8649

cip/linux-5.10.y-cip smc: 11 runs, 4 regressions (v5.10.126-cip11)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.126-cip11/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.126-cip11
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      400500e48ef52304feac8a819c6c911660ce59d8 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/62c292a28120faaa0ea39bcd

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/62c292a28120faaa0e=
a39bd9
        new failure (last pass: v5.10.125-cip10)

    2022-07-04T07:11:07.647073  <8>[   12.392134] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/62c292a28120faaa0e=
a39bda
        new failure (last pass: v5.10.125-cip10)

    2022-07-04T07:11:07.628834  <8>[   12.373944] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/62c291ea2e1f80de00a39c18

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62c291eb2e1f80de00a39c19
        failing since 6 days (last pass: v5.10.112-cip6, first fail: v5.10.=
125-cip10) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62c293674daedbeb83a39bf5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/smc-qemu_arm64-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/smc-qemu_arm64-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62c293674daedbeb83a39bf6
        failing since 23 days (last pass: v5.10.112-cip6, first fail: v5.10=
.121-cip9) =

 =20

