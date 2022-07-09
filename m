Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072FDCCA481
	for <webhook@archiver.kernel.org>; Sat,  9 Jul 2022 00:27:43 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.web08.1707.1657326462453601649
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Jul 2022 17:27:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=4qFNRUjw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.181,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f181.google.com with SMTP id s206so276078pgs.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Jul 2022 17:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=XgE7IzU12Qszv1lrGySdtm/XascIYB1whNXXezZvl60=;
        b=4qFNRUjwVScMjvXCa9UGXfNJCuLmBDs92joh7xmO780W35/zFLL+vt7HjKOXHp3irX
         f+PBVKFXkoZO05nPuzzzSjcwFTyNQSox1ehQxTX6SBqOAHPK9EHMvb1p2TEeWOyc6YDu
         MYzLkABBfo+gVHR73Xi4BKQHV3tNQlFkdi8hqUEBDe01xDkidRlhL6BADZwkzh08zxCo
         xwvB90MAShjYokuoUkQIRx39pqs6lpqpsoX47xG4Y9qZa4kwrJ7HT35qBHFG3NvztuKo
         +CA+IyG5w6+UNoSreEcFhkd1U3BUfXpd3wzAz+1c/KER6aeOBhzgpOZlUzxT4ORdrcq8
         qllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=XgE7IzU12Qszv1lrGySdtm/XascIYB1whNXXezZvl60=;
        b=Pc7ItubzLhgKDc6KalMgeOQKbmV2W+Firpef1opb11jd06lG0NlxJk/8xfam4qAMnI
         o87NcHtXZV9RC0+MFg23sAH8TLh0BNKZrgCQPcEBMMElG6b3k8yc9EHokymvOo/lvDbI
         jcIw93K6YF5tuimzBWPbTdrLp7Me7L8uvq5dZTPc+8eKi96F/yxjg0CYz25dubCCUuwi
         gkOaEy90Fn4WTWYfvVqp15VUAifpOXctbc/4W7cEyf4z4pL9E/YEKtYyGIW/17FfyUTM
         6Dvr3A8bUX8Rd+TttfX0G9cYzoCJUM3Ymb2aJ3acLzmm18rWsD0mK0jd1HyVC5RespS1
         ug3g==
X-Gm-Message-State: AJIora+x809RzWDHfRefJhiN2TkhXvk9vedn3xEFguSNFr1qsFxouTET
	bp7uzf5IdNhhoOZ6WqP1SuTZCyOlhEWgEzYm
X-Google-Smtp-Source: 
 AGRyM1vM92seDZZtdo9HjEO+zRJrdjXO+ZKIa9S7CqWsXMMGKnv9GEUFYVTeInoUkp9Kmkx7P/Y4iQ==
X-Received: by 2002:a63:195d:0:b0:412:50b8:c410 with SMTP id
 29-20020a63195d000000b0041250b8c410mr5238741pgz.520.1657326461769;
        Fri, 08 Jul 2022 17:27:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 n6-20020a170903110600b0016a6caacaefsm120978plh.103.2022.07.08.17.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 17:27:41 -0700 (PDT)
Message-ID: <62c8cb7d.1c69fb81.22584.0400@mx.google.com>
Date: Fri, 08 Jul 2022 17:27:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip smc: 7 runs, 4 regressions (v5.10.129-cip12)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 09 Jul 2022 00:27:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8738

cip/linux-5.10.y-cip smc: 7 runs, 4 regressions (v5.10.129-cip12)

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
l/v5.10.129-cip12/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.129-cip12
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      19dd4538e81e4019bc96ac6521af3a4ec93e110c =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/62c8b5eac7ae8b2546a39bf6

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/62c8b5eac7ae8b2546=
a39c02
        failing since 4 days (last pass: v5.10.125-cip10, first fail: v5.10=
.126-cip11)

    2022-07-08T22:55:33.526127  <8>[   10.176897] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/62c8b5eac7ae8b2546=
a39c03
        failing since 4 days (last pass: v5.10.125-cip10, first fail: v5.10=
.126-cip11)

    2022-07-08T22:55:33.507450  <8>[   10.158703] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8c2ae5a982a3a7ea39c02

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62c8c2ae5a982a3a7ea39c03
        failing since 10 days (last pass: v5.10.112-cip6, first fail: v5.10=
.125-cip10) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8c2ebcca94b1411a39bdc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/smc-qemu_arm64-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/smc-qemu_arm64-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62c8c2ebcca94b1411a39bdd
        failing since 28 days (last pass: v5.10.112-cip6, first fail: v5.10=
.121-cip9) =

 =20

