Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09026EB64DD
	for <webhook@archiver.kernel.org>; Mon,  7 Aug 2023 09:17:02 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web11.30153.1691399812580126206
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 07 Aug 2023 02:16:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=LFTs4KII;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-68706d67ed9so2901647b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 07 Aug 2023 02:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691399811; x=1692004611;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jDAHIQjap/jzAPNiTvMUwYftzahlDqwfMTk7JqUTmj0=;
        b=LFTs4KIIuAijzbbXNwK4cM1AkADZyjTW11hzxUFcP/+QCa6DS6Mr3//uw5SfEbbcxz
         iw+yQaaBKTgF4q8Ai0tzetSZt85nXljxASdpRSYgpv7y+JInQyKRAJvM6jXeKDK5Gz2x
         xNp/SlmAcGVC3PaHPdxkKjD7bWCkxGrQvkYeR5dtkQHj0A8grDS2tq5tlMqKXkj3Ia9J
         e25pYAjGji0hL5K8WGlL78F9HRT+xrQPuTuvvf3D+lRuZPc61vI9jmdb1KsX2o9M98+m
         KeU9ZIQi16wakfxTEB0Ly71+LFIROKwFJxmqCJNjGAYMc5lizZIV+qMOjkYudGic/Va0
         YFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691399811; x=1692004611;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jDAHIQjap/jzAPNiTvMUwYftzahlDqwfMTk7JqUTmj0=;
        b=dFE6g4OvXeL+82vJVGuKNz/ZzkfdbFP7qXsb2/7FP3Id+nxZc0fBxAYzd7mdBdDJsM
         Jb0Gj/uZKWijf4n7epDHqb8c4C9f/irw4A+qL1l79NaPHYwkPShDBaqI6zdjC4iQ+bEL
         xlGPN2JsGsxeRzMFecdha3Vqlua/H/lam0ISFcrJMAjIifm//Hy51QsViCw20xxmRsEi
         Ty80PFNrkW1T23mWjNWBVpNYNGcKJ4qkM/AyD7xL+ZV4LEaqazgF+e7YUmIORY6acfrh
         L9h9Olzt929aadYq0Fe86ehWkEymcE4dqdugWaLnNzb3p5yJSBC1SNc52xPbzcKsL8IH
         dhdg==
X-Gm-Message-State: AOJu0Yx3tT8gwKM11QVvrQgTtOWNZYLrYBHxkC3jbiyLcdEb+vY50xlg
	vdc2n6FMKgtevOnbPdGNsHxcatNtP8/alP0AEIG9Hw==
X-Google-Smtp-Source: AGHT+IEDF5oBAB5PojMjtkXecnK+uiqjUTqZZdvJ5KgUpdddr1g/kSYD8M7j2NGfBnrqqEy6+TpgFA==
X-Received: by 2002:a05:6a00:190e:b0:686:fb87:7f55 with SMTP id y14-20020a056a00190e00b00686fb877f55mr9170157pfi.15.1691399811494;
        Mon, 07 Aug 2023 02:16:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fe23-20020a056a002f1700b006875be41637sm5822781pfb.145.2023.08.07.02.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 02:16:50 -0700 (PDT)
Message-ID: <64d0b682.050a0220.3aeae.a458@mx.google.com>
Date: Mon, 07 Aug 2023 02:16:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-1447-g64a295c810065
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st-rc
Subject: cip/linux-4.4.y-st-rc baseline-nfs: 13 runs,
 2 regressions (v4.4-st20-1447-g64a295c810065)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Aug 2023 09:17:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12554

cip/linux-4.4.y-st-rc baseline-nfs: 13 runs, 2 regressions (v4.4-st20-1447-=
g64a295c810065)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

hp-x360-14-G1-sona       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1447-g64a295c810065/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1447-g64a295c810065
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      64a295c810065a25a02cc0e6ae5fcda96967143d =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0af1ef10a53f76935b2b4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1447-g64a295c810065/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1447-g64a295c810065/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64d0af1ef10a53f76=
935b2b5
        failing since 101 days (last pass: v4.4-st20-1097-g52d843097a439, f=
irst fail: v4.4-st20-1186-g2516b357b2e3a) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-x360-14-G1-sona       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d0b03dd494b2d7d835b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1447-g64a295c810065/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1447-g64a295c810065/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64d0b03dd494b2d7d=
835b1da
        failing since 209 days (last pass: v4.4-st20-234-g4e6ec7162c8e, fir=
st fail: v4.4-st20-799-g1229c813bcd9) =

 =20

