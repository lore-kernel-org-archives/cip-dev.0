Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBAEC433EF
	for <webhook@archiver.kernel.org>; Thu, 14 Jul 2022 13:25:12 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web08.7491.1657805108427873648
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Jul 2022 06:25:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=0Lyetl+b;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id j3so1839210pfb.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Jul 2022 06:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=/7jonIRYXZ1MPmYiZSeNb2Hz4ATedZBFWz71/ZIUiAo=;
        b=0Lyetl+bPpMoI/U7qhqITN0QlBRAo5dSF/0vMk18CHwUPzHVkY7bM1u/HQOS8utv+w
         XxKgHygvJMZocbimexZTxfFY4cv2WjEbFqROHretSZTcaI16M8tSx9ShrfsgQ66rkJpj
         x8PQ2FqdhOII9Tn8jzGNP3GwRLHx/+zqG+iPA4Uvl08+7LMQV17V70mQTe3M88PWLLhH
         4BBSfOc3jmcjTYllobu9ztN0zz3XHJSeJN6A0ETHnbuR4ueefkGP8b5n1WqyTm2euz+K
         76L5y6zEJt1P8D5Ghw0QziHCzs/vD5kn+4hfgoX5tj1Td4pt2wAX8yMElRGpPgD0YMJp
         YrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=/7jonIRYXZ1MPmYiZSeNb2Hz4ATedZBFWz71/ZIUiAo=;
        b=i7x5IxY7Np0iBoL/ITBmLwJa8JmwN/Y2NYgR9/7A+jLwQprCm6bq4YDJiqYcn5G/ZF
         JOI5RICMwrRk9U2eCZqKnS5itkkqZCj9ez7iT9QOWTpiT5TgXxr/Pgeg/S4AyqbTYYsx
         fgxB15oGxn2+XbGuOsidqqDmyVSHReWp2NfhEXHjW+4Fst7WlD4w8LDgRUquLZYbHSCl
         ZrziniaZZg9Nhm7P/JMSh/fD3uZZfa5a2p+oBD1VIwywGHI45VXz3yhjtQ/YzFAGYH6K
         8FXTCimvA1dfJI+H+MZDHWA1VgAZ97+jqzRaTeewTBAvC66U24evOwZlL4kYqHZwAzb2
         wZPw==
X-Gm-Message-State: AJIora+z7fjixpROXP7EDrPG2f+tnLktbUOJ2nGGzTQA/LUa63FxOL60
	74vf98/NepMr9PcGp1MlNDPGklrGBuI0i61JWw0=
X-Google-Smtp-Source: 
 AGRyM1vcIl27EC6yiZzZCOSQeuBMCLleHw/h+YTY0tAWHfBDZO9/J2ofEz8FBhzGEkC7fLYZxcHmdg==
X-Received: by 2002:a63:5964:0:b0:411:4724:e618 with SMTP id
 j36-20020a635964000000b004114724e618mr7495498pgm.484.1657805107457;
        Thu, 14 Jul 2022 06:25:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 k8-20020a170902c40800b0016be0d5483asm1492164plk.252.2022.07.14.06.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:25:07 -0700 (PDT)
Message-ID: <62d01933.1c69fb81.ada1a.26a3@mx.google.com>
Date: Thu, 14 Jul 2022 06:25:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip69-508-gd887d54a1be6
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip baseline: 64 runs,
 4 regressions (v4.4.302-cip69-508-gd887d54a1be6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Jul 2022 13:25:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8762

cip/linux-4.4.y-cip baseline: 64 runs, 4 regressions (v4.4.302-cip69-508-gd=
887d54a1be6)

Regressions Summary
-------------------

platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-baylibre | gcc-10   | defconfig+arm64-c=
hromebook | 1          =

qemu_arm64-virt-gicv2 | arm64 | lab-baylibre | gcc-10   | defconfig        =
          | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-baylibre | gcc-10   | defconfig+arm64-c=
hromebook | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-baylibre | gcc-10   | defconfig        =
          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip69-508-gd887d54a1be6/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip69-508-gd887d54a1be6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d887d54a1be6de9a74cb732ba80ecaf1cedefb61 =



Test Regressions
---------------- =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-baylibre | gcc-10   | defconfig+arm64-c=
hromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62d010fdc8375f91f7a39bfc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-508-gd887d54a1be6/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre=
/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-508-gd887d54a1be6/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre=
/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220708.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62d010fdc8375f91f7a39=
bfd
        failing since 56 days (last pass: v4.4.302-cip69, first fail: v4.4.=
302-cip69-296-g52de9431d314) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-baylibre | gcc-10   | defconfig        =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/62d011c63bdb63e01fa39beb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-508-gd887d54a1be6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_ar=
m64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-508-gd887d54a1be6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_ar=
m64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220708.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62d011c63bdb63e01fa39=
bec
        failing since 56 days (last pass: v4.4.302-cip69, first fail: v4.4.=
302-cip69-296-g52de9431d314) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-baylibre | gcc-10   | defconfig+arm64-c=
hromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62d010fcc8375f91f7a39bf9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-508-gd887d54a1be6/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre=
/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-508-gd887d54a1be6/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre=
/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220708.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62d010fcc8375f91f7a39=
bfa
        failing since 56 days (last pass: v4.4.302-cip69, first fail: v4.4.=
302-cip69-296-g52de9431d314) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-baylibre | gcc-10   | defconfig        =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/62d011b279c0f70856a39bf3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-508-gd887d54a1be6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_ar=
m64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-508-gd887d54a1be6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_ar=
m64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220708.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62d011b279c0f70856a39=
bf4
        failing since 56 days (last pass: v4.4.302-cip69, first fail: v4.4.=
302-cip69-296-g52de9431d314) =

 =20

