X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.web12.60.1652717117246629226
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 16 May 2022 09:05:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=f6zju86m;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.177, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f177.google.com with SMTP id v10so14480059pgl.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 16 May 2022 09:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=05qg/AJeluEtRoWnDs4Ge/hanogvUDDMxo4QXBlsXtk=;
        b=f6zju86m23xSsSYNC+lJ4SaR1khNyKD4vy7WPrpjWhXqs9juJKiVOxEhy2n6iiBHMQ
         ueJ4Zd6JUO1o/tnh59v76MpFsEv6pz1IsqCA+8oATARTaUidbv/83td6RLzbNQbTh2Wc
         /iZrz6bDU9Tkt9HkA1rpKbiD2/ttswk5LLCMbHwVdCPCzvZ0mW/D2BD8eNsuBrPdNHeq
         jLUJ6qciCgshoQH81Jaqw/AGtX02msX8PJ1gwMp72O3TlnqRevsvbh3JehrWI7F1WRFX
         r/silcDJn6gLUZ6QyFGB5393C+w1BdTlp/S1LlGK5myquSrY1nUOWoGnoUviysY6Qvuj
         VBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=05qg/AJeluEtRoWnDs4Ge/hanogvUDDMxo4QXBlsXtk=;
        b=6qP+5M0RE9NlAR9L1qlY6G+4XMy+qvILXv4smyclBRGANgUEqnL0TgWhddBycT0HoX
         sDIR4hTZ5dwPU5I3/pSXtRo2jc3JbzxZ9OvECxMMDmtNJLmEgU/JxSMGG+KfzuXZWco5
         HPzukGg5Krjeo0N2QgdW0f3dzhNkajWK7NcvCKFOydnXGQ/VdWRwIHA2mnojzUcEYZO0
         wth4c4jcBfnNNG80dhf5G11wp3SBKLwo8vPeKJ/gMEpyPn/XgOAexB9up6wAlWFUeP/d
         5J/jM9TIUxGjusI/slXIHtZZdxRh1FuxyefF8adYwcsJjrtki6xFl6khpzfyyY13Vfl1
         177g==
X-Gm-Message-State: AOAM533YWWFqncQIkXxCdFtu5H8qWeXlGIfDk+w7LcF8uJ3sEKZRu6qN
	K5lxkyfZhbuiPRCpXka3aORp4SZAVy3UWhq9m4M=
X-Google-Smtp-Source: ABdhPJwh/sU3ngJM70ftj9F9c0NBTTLi5naOyUAoZv4QgcjYyj7dbBAj6H8rdPY3NAAC/tY7+1zhNQ==
X-Received: by 2002:a05:6a00:26c3:b0:50d:d619:e4c6 with SMTP id p3-20020a056a0026c300b0050dd619e4c6mr18074955pfw.13.1652717116612;
        Mon, 16 May 2022 09:05:16 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q13-20020a17090a430d00b001deb3cbd8f1sm6711045pjg.27.2022.05.16.09.05.16
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 09:05:16 -0700 (PDT)
Message-ID: <6282763c.1c69fb81.3c19d.012b@mx.google.com>
Date: Mon, 16 May 2022 09:05:16 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-208-g5e70bc68d09e
Subject: cip-gitlab/ci/pavel/linux-test smc: 3 runs, 1 regressions (v4.4-st5-208-g5e70bc68d09e) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test smc: 3 runs, 1 regressions (v4.4-st5-208-g5e=
70bc68d09e)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-208-g5e70bc68d09e/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-208-g5e70bc68d09e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      5e70bc68d09e77ff437512cfdec26dcf5710d90e =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62826d05c59df6bb788f5757

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/smc-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/smc-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62826d05c59df6bb788f5758
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20

