Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945D5C4829C
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 05:35:29 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web10.14527.1707284128422126490
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Feb 2024 21:35:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=1Xjf5RMJ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d911c2103aso1796255ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Feb 2024 21:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707284127; x=1707888927; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yjwu6P23DEWLmQP3OZXrv7tC+8/9UNd4ZewfEdmeZsk=;
        b=1Xjf5RMJy/0FGpa3mV/6zI7ft2Juonn7qkVbzt2sJYo9XaYl7Cl92414f77WKmIdkG
         ALtrjcCXD6MFpLpAwm5qj1r/SYYe+mpMswIOrUnmeN0/ycwK1l0LY5UJj5PgF0M7OJ3C
         3cKr90H9mVuEB18bkZH9Zfc7ga8jbbPuK1Rn/9SN0X1g/+fKgLQ9xGbgDFq/wHng0Fa0
         i5uW0uzMifv+K3nv5RqjIc9JjHBU4aUQznFaYqiPBgQuTkvjgkVrKI8ECEQR0/po45KH
         gPZXSQ9Vk2PnTZv92ptRrun+frMzNCC6UKg7TB92+K4hZg6jvJPaZgu3L3jcppmM5jew
         QTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707284127; x=1707888927;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjwu6P23DEWLmQP3OZXrv7tC+8/9UNd4ZewfEdmeZsk=;
        b=clYORZf/uHOT7Q42EW2QCxIXBX6RaG6VOG1ngqP45k/MepxfYxhFVTZ+S7nvYXGAs6
         H+vCVEjqLcX3Ey7plgSRXEsvhqlEYnuFspMG1y+NxthMXyGoxxdFkSugOONTXuw2jrYX
         FYyzjn0rNRdGH6lD0UeXuE4GBtNXuJ6gdAaIpB8DPIYydwLkwBxNkFuU8k+9RAFlzTm9
         +hQOmW6/JM9TO8UneT52sQ65AdBSwAY9xGbzyEps+fJ8/JK34gMdwSev+gCm7crl19G0
         3AkdVVe7CyKeeW+5/96FeuOursJtGIyzOahiEjp1w7sXNmdqffcJ1eP92+lXsgyADr/F
         IcDw==
X-Gm-Message-State: AOJu0YyYBgzvht5AI8xQhZxnGBIs5nS1xE15YUetEQaZIJ/j76gqQutN
	CDELPecbT4cm2a/+YgCYMnQpH+Bt4mkTO/RIf5olTuwh6kkYOHsNEnw4AyFlKd2rVxLcKxH7517
	9
X-Google-Smtp-Source: AGHT+IEcvuu6xXrMmZoxn3syauwGz+in/DhHGGE/sTsEm+CHPkj93mqz6A1hVyk9JS2oGS9v7e7IDQ==
X-Received: by 2002:a17:902:cf4a:b0:1d9:b9ea:a1ee with SMTP id e10-20020a170902cf4a00b001d9b9eaa1eemr4655539plg.14.1707284127427;
        Tue, 06 Feb 2024 21:35:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVvqemPZ8fWemKcWRvOhUvd6mBqUTrIgZZyROMxeuueczmPlL4hftbLLT92CV98o0rmMnEaVioMQkWzKcfS4hlt26iUH9P1Wlmy2x4t0rxGwhyY+vTfdf1uumQT2oLoh24SYuSxwlTLtYnYCW2A6J3uPA==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o18-20020a170902e29200b001d92db44c9bsm492713plc.17.2024.02.06.21.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 21:35:26 -0800 (PST)
Message-ID: <65c3169e.170a0220.10c90.16f1@mx.google.com>
Date: Tue, 06 Feb 2024 21:35:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1250-gd530578b1386
Subject: cip/linux-4.4.y-cip baseline-nfs: 32 runs,
 2 regressions (v4.4.302-cip72-1250-gd530578b1386)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 05:35:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14870

cip/linux-4.4.y-cip baseline-nfs: 32 runs, 2 regressions (v4.4.302-cip72-12=
50-gd530578b1386)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
imx6q-udoo                | arm    | lab-broonie   | gcc-10   | imx_v6_v7_d=
efconfig        | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-1250-gd530578b1386/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-1250-gd530578b1386
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d530578b1386a94e84c4ef7993e59fd028af441d =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
imx6q-udoo                | arm    | lab-broonie   | gcc-10   | imx_v6_v7_d=
efconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65c30fcd798190e19d8e1e89

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1250-gd530578b1386/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline=
-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1250-gd530578b1386/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline=
-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c30fcd798190e19=
d8e1e8a
        new failure (last pass: v4.4.302-cip72-1224-ga0ac575eeff8) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3100b6b121f3c218e1e84

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1250-gd530578b1386/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1250-gd530578b1386/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c3100b6b121f3c2=
18e1e85
        failing since 34 days (last pass: v4.4.302-cip72-1187-g657481329b53=
c, first fail: v4.4.302-cip72-1224-ga0ac575eeff8) =

 =20

