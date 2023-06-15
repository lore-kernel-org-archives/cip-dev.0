Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22228EB64DC
	for <webhook@archiver.kernel.org>; Thu, 15 Jun 2023 12:56:51 +0000 (UTC)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
 by mx.groups.io with SMTP id smtpd.web11.17471.1686833804180004306
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 15 Jun 2023 05:56:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=0pPBEHHG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.45, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1a998a2e7a6so723654fac.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 15 Jun 2023 05:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686833803; x=1689425803;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ejw3n4gYfOQu4P2Y+Ok9hMEXmeZCu+o/CdZkW21BmKU=;
        b=0pPBEHHGWq58Z51PFONC/bMPh52ptzpwswhEbmVQb5Sz/BhhwgPdpIdmp6u1MvTz8l
         YmEY9MTDY6fcy0A6xQZhQFnZ5YwiCdYUvcZivBb7OUMQvwiziEitOd40RbmKSEAekj39
         8Q5seAC0Z0uxbRsAyh7bBxkb8hqq3S4P9Dd9wfPbpCbHvYdApU7xlbBqvZFuco/UuAa7
         lAxj/TiJvbS3vk53v8JCcyqFV8yAZ5lwn7cfD3LsaYVh4xL1Grsin6Hiy8V2bRLsEHLF
         E4fntAzxhwfjHOA5KqI6FlWopt/ERYKZGdF5eFN/wNTUB+oYN9T+02pqKh7QjClsCgsy
         5k2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686833803; x=1689425803;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ejw3n4gYfOQu4P2Y+Ok9hMEXmeZCu+o/CdZkW21BmKU=;
        b=dNlsTc+nwDS/vJcLJHNZRMXP7Kg1Jz1wum5kZOkgFD/XcRsXRpTSBCKEHakc2glOqG
         Y1kQId9KoFNVHbh2dKx/AtW0C26GAjvZmXzQ6nQC05hjkYv8Wy880c3lYbXXbprpVkQT
         vAv50NCLgNU0BaVny3ay0pqT6mziWyCtN7edLGpoLWscL2sW5rdEql1Z2kjctJw1HYAl
         e7+K1JADo0i74idQa3CMPKo5MmgqmBxfK8lO3Jimy7d7eOaLYHV7zwq5pklqN1KVKB3c
         muVXtZivAP4D2b3Z0L1DVj02qeI8EhyhBrIjOaPqhJuzAzNxMNyrmKbU7HncBdc1TpU6
         2FXw==
X-Gm-Message-State: AC+VfDxLLPc4lSXKlCfWdrkhNOcV+vjw/Ahc+mvOngnZRCJrk5oZnXxl
	Y85EqolHo62ASFQTn6gnZ63gGNxL0XKXqTWMrb4SUw==
X-Google-Smtp-Source: ACHHUZ40HjIQmP5EMAbztlvoHt7JqMJj1/jfaKMBu7NvKz4c28q6iBexfbWhE5rA5U+OgodEMTF/aA==
X-Received: by 2002:a05:6870:e403:b0:192:5cba:4c10 with SMTP id n3-20020a056870e40300b001925cba4c10mr12116883oag.40.1686833802919;
        Thu, 15 Jun 2023 05:56:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ga12-20020a17090b038c00b002564dc3cb60sm1858300pjb.9.2023.06.15.05.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 05:56:41 -0700 (PDT)
Message-ID: <648b0a89.170a0220.4fa2f.431b@mx.google.com>
Date: Thu, 15 Jun 2023 05:56:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.31-53-g486caac40d06
Subject: cip/linux-6.1.y-cip ltp-timers: 13 runs,
 3 regressions (v6.1.31-53-g486caac40d06)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jun 2023 12:56:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12062

cip/linux-6.1.y-cip ltp-timers: 13 runs, 3 regressions (v6.1.31-53-g486caac=
40d06)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 2          =

rk3399-gru-kevin       | arm64  | lab-collabora | gcc-10   | defconfig+arm6=
4-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.31-53-g486caac40d06/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.31-53-g486caac40d06
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      486caac40d06a2c987e5514b550d341cf6791b17

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  97c2fdb137a68e1eefed07c900db1a862edcdbf8 =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/648af9b37fd5d0612630615a

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-53=
-g486caac40d06/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-53=
-g486caac40d06/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/648af9b37fd=
5d0612630615f
        failing since 9 days (last pass: v6.1.26-1281-g84d5372e0f314, first=
 fail: v6.1.26-1314-g1ab0ac1d7e2e3) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/648af9b37fd=
5d0612630615f
        failing since 9 days (last pass: v6.1.26-1281-g84d5372e0f314, first=
 fail: v6.1.26-1314-g1ab0ac1d7e2e3) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
rk3399-gru-kevin       | arm64  | lab-collabora | gcc-10   | defconfig+arm6=
4-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/648b0368d6279119f6306130

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-53=
-g486caac40d06/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-ti=
mers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-53=
-g486caac40d06/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-ti=
mers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/648b0368d6279119f63=
06131
        new failure (last pass: v6.1.31-46-g4cc1cc26e90f) =

 =20

