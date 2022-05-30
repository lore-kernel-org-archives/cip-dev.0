X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web11.37838.1653923214540261017
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 30 May 2022 08:06:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=s/W+wM0r;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id c65so10239597pfb.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 30 May 2022 08:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=GWz1YRN6PWWzWIP/5Kctl9bSOjen8ji2VDiOjtlS4UU=;
        b=s/W+wM0rhRCIeybC8pghKRjPkEVeY+MlVzKGfm0cO5gjej3D4opRXp/h7W6kXqBF+M
         QTfHYEKlck8jnQvsBh6ZgDF64uFPxPB1x9Jah0++lZQRDyaP8buZWtZ5VefIXj+CGAPY
         SEtJcK9GpMyXgxSz282ugsRaEZk6PLhlV5ulLCtNGkE8bAsTmwk3VMxlfEf8zI3l9p1e
         XoM/r1vtbr/WWCTbS6yzILOTHokLe1R9N3eX57oacJ5VlB+z53cJ61KnG9CrQBIoXN8r
         dHvbtafFGTTGsjtbjwjehJtQlmDLsWJn7gfoDOWcGWg7HOcxY3+H6Xfa6gS9zMnSQ/h/
         06sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=GWz1YRN6PWWzWIP/5Kctl9bSOjen8ji2VDiOjtlS4UU=;
        b=Fr8JhnLUaMJRsFYnE0NUqDkW6oyfvZ9dg8o1oZOmg37tS60eW4q7hUELEgDLSrBUvs
         a6jt+e2Suj7ySsBLlazEVJy5Q4cB2eXw79cBIqpMCpDPO6Iudeju+xRHDzrYOftSQncg
         3slUIsPVmLZLKMq1adLEVpKqaGsrXHxQ0w2gSziljsdXYK5LXUTvk6vJDioZhewM5W1m
         aeiBhzfiVPwKfAfEgTojnlyXCHQb9JVh2t5ah8UqidlACZg/GXcM8kIFym6lq6MeBOjH
         0BJxJCii6/OQsh92yyydw3RmJgsK6BI/3Klhy8z5yEeZTe/uzi6y32WzovonsHQocZcG
         3bgA==
X-Gm-Message-State: AOAM530mdpEQc96z4tynuuEhpfpkR76Ab29dLeeJ4Q0IHAduf6ZJk+I+
	tSAAT/FPCz4TPjGschTMXHSV5cQr8uwl0anZMNU=
X-Google-Smtp-Source: ABdhPJw53VgOF8QOuuMcQr5tdXAR+MuPR+BGyiABnJLHZTOz3urOeWFdsGqwoOQiZ+xeh+3HiKoyJA==
X-Received: by 2002:a63:d012:0:b0:3fb:b3d6:122 with SMTP id z18-20020a63d012000000b003fbb3d60122mr13497499pgf.142.1653923213827;
        Mon, 30 May 2022 08:06:53 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id be3-20020a170902aa0300b001621cdf7172sm9507090plb.58.2022.05.30.08.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 08:06:52 -0700 (PDT)
Message-ID: <6294dd8c.1c69fb81.e7d8.52ba@mx.google.com>
Date: Mon, 30 May 2022 08:06:52 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.245-cip74
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip smc: 4 runs, 1 regressions (v4.19.245-cip74) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-4.19.y-cip smc: 4 runs, 1 regressions (v4.19.245-cip74)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.245-cip74/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.245-cip74
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0be9d6774be9b192bcea6fddada917ae3d22f22e =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/6294d331cb5996b1fea39bd6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.245=
-cip74/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.245=
-cip74/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/6294d331cb5996b1fea39bd7
        new failure (last pass: v4.19.237-cip71) =

 =20

