Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B647CCF9E4
	for <webhook@archiver.kernel.org>; Tue,  5 Sep 2023 23:21:56 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.37292.1693956106561317587
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Sep 2023 16:21:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=YEf13B1I;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1c336f3f449so20755095ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 05 Sep 2023 16:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693956105; x=1694560905; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TEtNLdjdR80hpD5W0gL6cRt3/vSJBIBSx8f3e+3JXHo=;
        b=YEf13B1IzfCY0SW4XQFbpxXfKk6Zp3eQU8po/7t0RKeWikWPpjxe2jPNseM6xCTaoH
         aDfx7fAMzpbvCPxmLpk22qtQy5NxX9NCLpy9BUvufuj4ThFVreiaN764ZXFqOPvsioT3
         UQz0iYGOd+mkHdDLvnBVcDpq12daw244IjOAdDs5kwQeSjDUqSNPWPg0BnEEXSjPOABP
         u97xvM0A652VYyREMmtykcEHuSJH6/QmL9DQv9/7yBuWOVoCEAHJzzDhit031jsiADi+
         tWgeAukfwI9c0yy1B+SANUz28Fdb7ks/dX12hAarXJW6yQhPGJwgREGOPd/j+zvFpu69
         fY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693956105; x=1694560905;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TEtNLdjdR80hpD5W0gL6cRt3/vSJBIBSx8f3e+3JXHo=;
        b=Yiy8raexjSMLFvhw95c5HC96iSiM6sydZoiDu1aqzptniDnDWFvqokwc5t5V4ajq28
         rIwnxJ1MGvwHpT761CFgWozW1EWotL4c1FVSSZSPpHeFe60Trq/KlFuYybeqzArnImv4
         AtNJM0EZ4PqBJasMc6HUxiSEvSQFh7jfnCATz+yoUcTB+SdnO7s4W2cy9RSyeGZ9krG5
         cK7km/O1BCxxP942BKlyOs5sFe65PUTh7JCfSFt0NK9pkdRimUE3pGJSe1JNTXjXUskY
         bQ0/BQ1iA5yj8DOS+u1AuR9BCr/cWZWA0tRQfjNIW7FPsS7gr2n/7bSJvzXT8+m79sIM
         RD4Q==
X-Gm-Message-State: AOJu0YygSpG4+7P4W2DnD4eCbDGkLOo20Q7NdaQf7kd4+eYfQyp0TCI7
	wi19CEfvVJKYcZxJ4/kr2u/VNokE0bJKiueMkK4=
X-Google-Smtp-Source: AGHT+IErXvcIaRAB8xeUhBo8MUypDtFwxdWX3F5vnCZYFezlaVhzkrh9yYrtEk53mPcLHwbHp9c6IA==
X-Received: by 2002:a17:902:e550:b0:1b8:83a3:7db6 with SMTP id n16-20020a170902e55000b001b883a37db6mr12537503plf.44.1693956105590;
        Tue, 05 Sep 2023 16:21:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ja20-20020a170902efd400b001c0aa301703sm9827259plb.63.2023.09.05.16.21.44
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 16:21:44 -0700 (PDT)
Message-ID: <64f7b808.170a0220.c7b53.5689@mx.google.com>
Date: Tue, 05 Sep 2023 16:21:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.46-cip4-14-gb994de8f45440
Subject: cip-gitlab/ci/pavel/linux-test smc: 3 runs,
 1 regressions (v6.1.46-cip4-14-gb994de8f45440)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Sep 2023 23:21:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12967

cip-gitlab/ci/pavel/linux-test smc: 3 runs, 1 regressions (v6.1.46-cip4-14-=
gb994de8f45440)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.46-cip4-14-gb994de8f45440/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.46-cip4-14-gb994de8f45440
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b994de8f45440fdf9186ead9b3a13945833c1547 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f7a41a8693e42969286dcc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/smc-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/smc-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/64f7a41a8693e42969286dcd
        new failure (last pass: v5.10.191-cip38-2-g05fb42f86d06a) =

 =20

