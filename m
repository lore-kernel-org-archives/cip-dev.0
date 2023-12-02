Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D0AC4167B
	for <webhook@archiver.kernel.org>; Sat,  2 Dec 2023 00:06:53 +0000 (UTC)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
 by mx.groups.io with SMTP id smtpd.web11.8231.1701475610464389295
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Dec 2023 16:06:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=mf4gNqNd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.178, mailfrom: bot@kernelci.org)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-35d4c0eb3abso5226075ab.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Dec 2023 16:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701475609; x=1702080409; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o6ZytcHzeKMfZDZnHH4UaJVE3nOkUZsIXDGCmM7wHKM=;
        b=mf4gNqNdBtD/YJZK9l/geAXdCWvjAk1zPnaeqQ9PO4C7Kg+3Aoiu8nxrIOt7GzdRl9
         WAmcb5AS9n0p1SvKbH6cm0CJJ6zyUpPk/uqIw9e64UB8PDM7AKAthRkr1NmSJsI6SycR
         CYLBvafqPoNHM3RKUWduubuBubtS7ZpLZWuFZiHipV1mE0x8IjPYuf4sK04B1J/8Etbq
         TdsPIRxTxCl0p6kglKQFx4xFiqahhVBi8KB/JkxrjMtWNWGdtiqCP9tSys6Uo0hKKIsN
         aQeOfNZ/gHO5lySU8n7w9xRLw/EFR6odGor3ohskRRlAATrXkFTd6sEIboqpRJVOwXZW
         C8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701475609; x=1702080409;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o6ZytcHzeKMfZDZnHH4UaJVE3nOkUZsIXDGCmM7wHKM=;
        b=FHh3Nxf4hlZG46wfik5INgTZZws3aAI8b8zVuW6uPkz/vzEfVm7wgozCTxhVQWiCeI
         2OWcYeXUtuvIhEkLs1DVrwlVExnrWhTZp48vs6y1xXpmPKSJhcjB0WUaz8hs53jJ+SjK
         NXNISH37wDcHx+cQWSIAwrAxIYixPtx+1670N7ibUAr4sxp37C3SAuKE4U6f2mYI6hdZ
         udunukUlfErEGW0BYdcHbopmNokeDadRUYdxNYIKeenK5ZugWF4OcKqhjdX+1F5st870
         S8sssIqbqpdpUswbfwwNLYYR5TJI/M8dXvneTHqXP5Q8ZMKUiFk7XQGp9v7Qhz4EI/7B
         IELQ==
X-Gm-Message-State: AOJu0YzYkPfarm6kaXWXQMKfmnvcepPahjzDjqRFrGRQg2JjMQjAg37/
	qm5S3XcQUCf1Q7WLXVxvEnkXLuec64YvHPyLwnP+9Q==
X-Google-Smtp-Source: AGHT+IH0VrtotXEIuUQ3RrqUhqc7dNhUgn9wri7ZxFE9bOkXAkfOWBr7oy/fn7sBNoGxS4Ppsa8ciQ==
X-Received: by 2002:a5e:990f:0:b0:7b4:28f8:2bf6 with SMTP id t15-20020a5e990f000000b007b428f82bf6mr338823ioj.31.1701475609138;
        Fri, 01 Dec 2023 16:06:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x1-20020aa784c1000000b006cdd9c52f0asm3548824pfn.8.2023.12.01.16.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 16:06:48 -0800 (PST)
Message-ID: <656a7518.a70a0220.9c63b.c73a@mx.google.com>
Date: Fri, 01 Dec 2023 16:06:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.64-cip10
Subject: cip/linux-6.1.y-cip baseline-nfs: 48 runs,
 3 regressions (v6.1.64-cip10)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Dec 2023 00:06:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13771

cip/linux-6.1.y-cip baseline-nfs: 48 runs, 3 regressions (v6.1.64-cip10)

Regressions Summary
-------------------

platform           | arch  | lab         | compiler | defconfig           |=
 regressions
-------------------+-------+-------------+----------+---------------------+=
------------
beaglebone-black   | arm   | lab-broonie | gcc-10   | omap2plus_defconfig |=
 1          =

kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig           |=
 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.64-cip10/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.64-cip10
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      6eab166db6d4f9b10eb2993de0fcd289a09024bd =



Test Regressions
---------------- =



platform           | arch  | lab         | compiler | defconfig           |=
 regressions
-------------------+-------+-------------+----------+---------------------+=
------------
beaglebone-black   | arm   | lab-broonie | gcc-10   | omap2plus_defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/656a695676ad9a38bae134e2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.64-ci=
p10/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-blac=
k.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.64-ci=
p10/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-blac=
k.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/656a695676ad9a38b=
ae134e3
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07) =

 =



platform           | arch  | lab         | compiler | defconfig           |=
 regressions
-------------------+-------+-------------+----------+---------------------+=
------------
kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig           |=
 2          =


  Details:     https://kernelci.org/test/plan/id/656a6ab610a4b8d624e13536

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.64-ci=
p10/arm64/defconfig/gcc-10/lab-kontron/baseline-nfs-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.64-ci=
p10/arm64/defconfig/gcc-10/lab-kontron/baseline-nfs-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/656a6ab610a4b8d624e1353d
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-01T23:22:00.736194  + set<8>[   16.875669] <LAVA_SIGNAL_ENDRUN =
0_dmesg 400890_1.6.2.4.1>
    2023-12-01T23:22:00.736492   +x
    2023-12-01T23:22:00.841800  / # #
    2023-12-01T23:22:00.943500  export SHELL=3D/bin/sh
    2023-12-01T23:22:00.944055  #
    2023-12-01T23:22:01.045056  / # export SHELL=3D/bin/sh. /lava-400890/en=
vironment
    2023-12-01T23:22:01.045594  =

    2023-12-01T23:22:01.146591  / # . /lava-400890/environment/lava-400890/=
bin/lava-test-runner /lava-400890/1
    2023-12-01T23:22:01.147228  =

    2023-12-01T23:22:01.151906  / # /lava-400890/bin/lava-test-runner /lava=
-400890/1 =

    ... (12 line(s) more)  =


  * baseline-nfs.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id=
/656a6ab710a4b8d624e1354d
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-01T23:22:05.411924  /lava-400890/1/../bin/lava-test-case
    2023-12-01T23:22:05.464300  <8>[   21.798890] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>   =

 =20

