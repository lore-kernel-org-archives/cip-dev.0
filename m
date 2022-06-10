Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A5DCCA47B
	for <webhook@archiver.kernel.org>; Fri, 10 Jun 2022 12:20:39 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web08.26383.1654863629905540895
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 10 Jun 2022 05:20:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=NO6LXew3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id 187so23709961pfu.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 10 Jun 2022 05:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=7w8aDPpn/s7zPqySKbXUBRerWjqSmQs5cguRr532Tss=;
        b=NO6LXew3w/UkZiW7mhCk1oPLl/m8CuhvfB84pEEkwNEr3mL4GZPP4RiwmrynyuGcI/
         xpxLwbO/cp0Y6x0JsW7WshE+RFUT9HisSdFDaBZpX9Yn37jYvNyX0Ltt4XsIiQQZpVWS
         m9cmg+7PVYjKzpoSuR7vP6pB4QMdxnncO973g2BiS1VkWsQYtRME4+HpGa76v89DhGU4
         EBPzCL/w7qPUkckbXVQlfUtEyzdq0FDirat5nfNy3SYc4rXDdBsTcj6kHBd8OH0OyGCZ
         7cYQWtVXOxWJ1YY/6gUKIkf4aGbblmWKdsW6GIzIoS52Z3cINPjBcXAVbvnCuXrjQhfA
         33NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=7w8aDPpn/s7zPqySKbXUBRerWjqSmQs5cguRr532Tss=;
        b=oIwDKA8oL+fWkG47ZMYNrsEZD5NFy/vFoy1aFr1mYceFQ2hzspDsiftQ5b/dMo2BT5
         p23z1SS0co080VZAgurVteV+w8Idu5CulibJOLCN8O0PdmeqTEjDt5wZDAU8boYRjDku
         WHlonvddGMlx0ziV6K1nufUm6RA1gebqV369gsSQGnvde1xZAv9vNesaEMuM5jNioUng
         G/n8XexflOkYlONoR9ON9TbOQkjWQdyATjHq9rmMccVz4uM9YTl7XAvytKd+0iEVL90E
         KiuvNcvkeCA0rMj5lD57iQaXQZaBWF+BrTzZFgbyHntU8dCTWxenxqSAVTdzqgTiK08n
         DePA==
X-Gm-Message-State: AOAM533+8EhYTDEssOf8j8gD0rOTyIqPvDn9P/Uuctp9wXpD0Dne0Rr3
	A1hn6csYizww4eRIdtXvWq3hbpAFKKGEO3Tfm6w=
X-Google-Smtp-Source: 
 ABdhPJwlb/jIFmYXCvF01j5BcHiVsHCHxUuhZ5sjzr5vc3lnsXtjkrfySLUxlBnHv9mHPFHBTRZa1A==
X-Received: by 2002:a65:6c10:0:b0:380:437a:c154 with SMTP id
 y16-20020a656c10000000b00380437ac154mr39256591pgu.549.1654863629169;
        Fri, 10 Jun 2022 05:20:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 t190-20020a6381c7000000b003db7de758besm19451894pgd.5.2022.06.10.05.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 05:20:28 -0700 (PDT)
Message-ID: <62a3370c.1c69fb81.62a26.6628@mx.google.com>
Date: Fri, 10 Jun 2022 05:20:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.246-cip75
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip kselftest-futex: 6 runs,
 1 regressions (v4.19.246-cip75)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Jun 2022 12:20:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8538

cip/linux-4.19.y-cip kselftest-futex: 6 runs, 1 regressions (v4.19.246-cip7=
5)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.246-cip75/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.246-cip75
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      38ce181ac6ca9f3decdd389cbfd0a38fecdb28c7 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/62a329e31d0cbb2cc9a39bdf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.246=
-cip75/arm64/defconfig/gcc-10/lab-baylibre/kselftest-futex-meson-gxl-s905x-=
libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.246=
-cip75/arm64/defconfig/gcc-10/lab-baylibre/kselftest-futex-meson-gxl-s905x-=
libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220603.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62a329e31d0cbb=
2cc9a39be0
        new failure (last pass: v4.19.245-cip74) =

 =20

