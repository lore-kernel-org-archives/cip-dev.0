Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0ECC05027
	for <webhook@archiver.kernel.org>; Fri, 27 Jan 2023 02:26:07 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.93705.1674786365426204626
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 26 Jan 2023 18:26:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=bBD18FrT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9so3632439pll.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 26 Jan 2023 18:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FI1ESiw3BZ48tGtSSlW5a3oQxI1Gt+tJspo5EwFbVJI=;
        b=bBD18FrTmJTSMGxuEG8MSE7ibCoHL4opCX/97yA9ysbRq3R8sPzbjPwrH9kCSDkW18
         L3TyHm+Y5g/GpSbNcLdS6ttY4QUg6oerqET38ixfUJqwwyNgqd+F0+ypoxmZ9huEbJbH
         F/fVQVjKMz+a34QFls8lq4kk71QGMaTQvVXNVaQBZFCKWRgsP+Z+WP8a1p+2T9uCD1AI
         FKho8osK9P4//xv4jXbCQiAkBXOX8SCaame9Heiz0rHBLktCl25wG6szoReD/it/F6Bk
         3OXIl3c56xp1pjG1BU0VrEc0K7b4DH0ag8SWSvyjT4PQSitlUs+nqzbTZ66KBb7eW9Su
         fXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FI1ESiw3BZ48tGtSSlW5a3oQxI1Gt+tJspo5EwFbVJI=;
        b=ZtRQuZzMsngnp1FeLel88WxQPTYhU30OFoajBiGSoqTF4g3/KLIqxWU3b+94xJcp2z
         aerRK9D4wbM2JtUtOKuzGQn8Z9n90S3uLFL/wxrb64fdQVmxm9BIa0GZKXLyfGiopssv
         HAEQOaPwzqe3w3GQH/gBQcQwUOEwSbBtdovqTHlz8YZ7RZJIw5BZGX5w0EzbHqlZPggW
         B6Oo+ZtBgqiIrBGObVv7M+vSjE7u2eTib5gzMpUq4EzYN03WQEoTQh9RVJQPRbPCv/+M
         U0VgQzorortk44wpUgQYDWbdz13d+6xQmUOnTjyC1PLr2qjQk9qt0g3fJ8mdjWXQFz2P
         5kag==
X-Gm-Message-State: AO0yUKV5FXgs0bngPZiGTvQthJK2cRK4kW3YEdLetpEFSggA4kuF6OPG
	E142gQTyAX4qOZf8VlBYNgr3OXS8shipdc+7TonWmw==
X-Google-Smtp-Source: AK7set82Bfr49dxjN966+piSeG4js0B6oHtMziMDENhRzjTOHPshT1gStC7V7y+xNzmPVzbyd/qPxg==
X-Received: by 2002:a17:90a:e7ce:b0:228:d42c:d5d6 with SMTP id kb14-20020a17090ae7ce00b00228d42cd5d6mr4754476pjb.27.1674786364365;
        Thu, 26 Jan 2023 18:26:04 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090a134300b0022bb9f05753sm4002566pjf.48.2023.01.26.18.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 18:26:03 -0800 (PST)
Message-ID: <63d3363b.170a0220.74136.6ca6@mx.google.com>
Date: Thu, 26 Jan 2023 18:26:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.162-cip24-rt10
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt kselftest-futex: 3 runs,
 1 regressions (v5.10.162-cip24-rt10)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Jan 2023 02:26:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10493

cip/linux-5.10.y-cip-rt kselftest-futex: 3 runs, 1 regressions (v5.10.162-c=
ip24-rt10)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.162-cip24-rt10/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.162-cip24-rt10
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      55fa0afa2bb00f24b1721b532102d34eb18be47e =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/63d33316183c942eb1915ed3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm64/defconfig/gcc-10/lab-baylibre/kselftest-futex-meson-g1=
2b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm64/defconfig/gcc-10/lab-baylibre/kselftest-futex-meson-g1=
2b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/63d33316183c94=
2eb1915ed4
        new failure (last pass: v5.10.158-cip22-rt9) =

 =20

