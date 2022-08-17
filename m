Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16D5C32773
	for <webhook@archiver.kernel.org>; Wed, 17 Aug 2022 12:08:14 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web11.27700.1660738088433014682
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 17 Aug 2022 05:08:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=L9UYsHul;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.182,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f182.google.com with SMTP id l64so11826050pge.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 17 Aug 2022 05:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=mYXcHMXa+SupXgJVNva4y4afba6rNlTkrQEK6ouEFeE=;
        b=L9UYsHulZwP6TKm+8liFJUdYd/AI15uUucIK2O9SJGHKizSKQGjmXsgkYVI/do1FXj
         60ClKJFL5kcj3Xy15ba0ExIKxN9ocy5PKbhPHrLnr1llL8GRCDp7K7NHUrNQm6xRtPzl
         4JE9a2BK+L1Yj+PMRCgr/BL3iHpyu0K/wyofTv7qc1iW0eVe98TM4CxMHMOTI+O9Cznu
         Di8QB18lJVBYouTokJRM9Q9zBBlDWjNH230vPcOFeyUceI4FpZxYR0C+OyV61ei/cYCX
         r4VoDssO80vDqzRqIiVlb/+7SVrMSNba0RXCcDjD98npsISjWZmomsWCOD1nrGJDeZAC
         Hm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=mYXcHMXa+SupXgJVNva4y4afba6rNlTkrQEK6ouEFeE=;
        b=iByszITodyOxR5lZYPf/x5w/EDRt6Puv+oLhTlF2ozl/E+NjSU1d9oK24VvNwEx+RL
         L3iJiQhY+t1wNkrtP3kvgnuqVVt3qcmafTzmG/W4raIQOh139IAMiqSLR++T5kQQjSc0
         WygVFfN6WMkGkov/5/eeyW1QQJYgJwloB76wuDcUntH4EttPDPP9vcYZKiPjVu1TVuaZ
         IZbbRbvt/fJdDtMjer5qSK+TnFhI2NW7WTw2fVM6Y7rky9cC9bS0oY9p86L3+mNvRofa
         YDW8/R1Z9fWvJKT2gCfPE0FsPzR1Mbxgtx7qtuRVXTNMVJQrctXENY327kbbyqOT/tlH
         8Sow==
X-Gm-Message-State: ACgBeo3wnnkAN7XeXWaq5FOyxHAtlAP+apF1Fv34Dbc0WqjgWZlaFFv5
	3Ncgemt0NOK1SDcucW65bpkJRTsaZkjF7nMQ
X-Google-Smtp-Source: 
 AA6agR6s4AicO4h9Kez8Ffvt35oy3P168WW8TrY278Fn0N52vCGOhbfqhpAMH8ELsO81afPDCqLHjg==
X-Received: by 2002:aa7:8e91:0:b0:52d:8ebf:29a4 with SMTP id
 a17-20020aa78e91000000b0052d8ebf29a4mr25491812pfr.1.1660738087729;
        Wed, 17 Aug 2022 05:08:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 m2-20020a170902db0200b0016eea511f2dsm1323996plx.242.2022.08.17.05.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 05:08:07 -0700 (PDT)
Message-ID: <62fcda27.170a0220.4f48c.1ca7@mx.google.com>
Date: Wed, 17 Aug 2022 05:08:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-84-g3b53e4dbd9f41
Subject: cip/linux-5.10.y-cip smc: 4 runs,
 2 regressions (v5.10.131-cip13-84-g3b53e4dbd9f41)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Aug 2022 12:08:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9280

cip/linux-5.10.y-cip smc: 4 runs, 2 regressions (v5.10.131-cip13-84-g3b53e4=
dbd9f41)

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


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.131-cip13-84-g3b53e4dbd9f41/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-84-g3b53e4dbd9f41
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3b53e4dbd9f41171cf639b3ba0b107f6d6f444ac =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/62fccb35c57e6b08323556b5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-=
virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-=
virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62fccb35c57e6b08323556b6
        failing since 50 days (last pass: v5.10.112-cip6, first fail: v5.10=
.125-cip10) =

 =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62fcd126c3e59998d3355668

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62fcd126c3e59998d3355669
        failing since 67 days (last pass: v5.10.112-cip6, first fail: v5.10=
.121-cip9) =

 =20

