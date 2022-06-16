Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CE8C433EF
	for <webhook@archiver.kernel.org>; Thu, 16 Jun 2022 16:33:44 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web08.19952.1655397218317532449
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 16 Jun 2022 09:33:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=AdSvAilU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id
 y13-20020a17090a154d00b001eaaa3b9b8dso1957438pja.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 16 Jun 2022 09:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=CcQLuUcKbXlbKg862q1vH3lfWqUCeQDbV9i+We7b+m4=;
        b=AdSvAilUcDYKO2Kj48jAX1UYM9HTHx+hNAZ2+EeZPFW9vszG+m12BhybCCeY4XKTIt
         Miv1GCvyY5ql1lCuDBcE/44FTWfE2XU0PI13QsHVtxnLQ0LwLrWhHBrJxaVdN1y099HW
         6Lc5FxWF1+Y5Nd37yxQlUI0orXc86rK5K9Qfzo2p4ByXhISOWB5bvKjfFh1BNlVFV5cz
         0lSMGvYDy7yEeKkA8Z3DWnVttaLkFQ2PCsLjof5AS6SdolxJHEqEJJVCKjN2eiRtUKJ9
         q189yrEde3xt92EWFud6ROOfU1R1HBMc0X1VWoN7w8YvZMeuCfNYsy1kg8G5CvzSSlhy
         nO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=CcQLuUcKbXlbKg862q1vH3lfWqUCeQDbV9i+We7b+m4=;
        b=SC3DvjEsQvI+XszyImISuIaUZAAF3R8op25PYMha08cBAvGBmtdxylTxuL2oFLRwYP
         HRJDdRGniOVuSL7JKDiIeKGbiXLv1vxqRHhfThw0FXP5IQM1lo4vSnoBMcHNjmpMT2IQ
         B88cmNqkwFedR2VNwvXQFkV6MYZrJCSLX48d1eXBpcZhObtbBW1E8nTM9pGzyRf/8QD8
         qdWOVD2t3gOdYyLa73WQuOn3Yn27tlOR1KRKMeZGQE1TzNGd9UDvf1TAFcacAJVnvq20
         ZNZWft1wiz+apvZHzbZ0OhS0xQUxTacjoE0OtOvzRPSQRPSLvztXbUzBUBL3J4IHPRIU
         twEA==
X-Gm-Message-State: AJIora9jcxel/kHrWqP6CjkpQysiuNSnw824lFIs0oaHw2Cz+y0RU2DD
	3So1nIGe7AntJIgPPJLxKI5CMmY4+851IAl8Ntg=
X-Google-Smtp-Source: 
 AGRyM1tN2zXjKtFaC3BP7xBzctEgMAon8N/adxvPDLli60WqZSBeeo0y7Hm7gj8gy9l0/rAtTtc98A==
X-Received: by 2002:a17:903:2cb:b0:14f:4fb6:2fb0 with SMTP id
 s11-20020a17090302cb00b0014f4fb62fb0mr5249136plk.172.1655397217464;
        Thu, 16 Jun 2022 09:33:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 x8-20020a17090a6b4800b001e2d4ef6160sm1777220pjl.27.2022.06.16.09.33.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 09:33:37 -0700 (PDT)
Message-ID: <62ab5b61.1c69fb81.25c3f.2bed@mx.google.com>
Date: Thu, 16 Jun 2022 09:33:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.246-cip75-307-g39a7d45c38bb7
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 41 runs,
 1 regressions (v4.19.246-cip75-307-g39a7d45c38bb7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jun 2022 16:33:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8574

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 41 runs, 1 regressions=
 (v4.19.246-cip75-307-g39a7d45c38bb7)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.246-cip75-307-g39a7d45c38bb7/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.246-cip75-307-g39a7d45c38bb7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      39a7d45c38bb7a761b622e3f5d1c8f804a801c29 =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ab4bad846011ede1a39bd2

  Results:     17 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.246-cip75-307-g39a7d45c38bb7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.246-cip75-307-g39a7d45c38bb7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/x86/rootfs.cpio.gz =



  * baseline.bootrr.thermal-device-probed: https://kernelci.org/test/case/i=
d/62ab4bad846011ede1a39bd7
        new failure (last pass: v4.19.245-cip74-32-g2d021d7a9e637)

    2022-06-16T15:26:16.327820  /lava-6630445/1/../bin/lava-test-case
    2022-06-16T15:26:16.334049  <8>[   13.172181] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dthermal-device-probed RESULT=3Dfail>   =

 =20

