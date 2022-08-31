Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17541C0502A
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 18:51:48 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.2758.1661971902199628325
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 11:51:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=YB66+e0K;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id x23so14965825pll.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 11:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=rjyfznnRmtdI1nB3dHnKrShhbbNEk96R0sf4c0pTu7k=;
        b=YB66+e0K1UzT1aXwwKyi/dSwrKVTbwa8BBuR1ZCn4tbVOtphpQZPouzSLVNIRwgY0F
         NV0VkYA4FPu0AOGGwoHw9W9yl1IJv/QQ5Vnlf0lXEvkeXkpMyJFZPKx7lv88m2gTb6QB
         qulFpMVJqrVZho0oVFGACFuEiKCAWoMujj3ROGPRFMgOU+iW8E1MeYxxTKPkIEcOvg6B
         17O5zQaZeWOSQjWkR4Qz6zyyfZXkJJ5BtUlu3S31kdU1InSwG+lzhb4wxPwnsOb7Nv9Q
         0Nm5Gkj9FTukuID6BO2A7BKH/o8G7vBUuJAjkTvmbSablCE1h2q0hn2gU1msuQ/jRHRp
         s2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=rjyfznnRmtdI1nB3dHnKrShhbbNEk96R0sf4c0pTu7k=;
        b=VntCIJX/iD3gkTRYi6WeSMLnn7q63gR+518mxolZsQbjPK9VSynvdTUlbQ70j1FF1q
         ZuYZpdg3ooR0MTkhf3Rf2PEo+zD/ovew4U6f1/+m5qu7UmzvvZBbI8iGsne3CHM/8W1V
         FOKZcCDLhHXyCX6/djXt3gjHnVKlx1fq42nSEg5CuKQ8HhqtNRkC1Htkmmu+9b7zceq+
         n/mhW3OrNGPqudClaC8xd3O8wZf6fDg3LiBh3r8cmxOBaL4KJ8CGFL+okYaSRMnzHrwA
         axQs2Q58edNyFYq7up3KzXiQDMKDflKaa38DVsscRbUeeFzx61fvxr+d8gXzkC7CY6hP
         XO3Q==
X-Gm-Message-State: ACgBeo0cSwvB0Wnw//u57jHZtUQvXIW54E+XvjIApTekSW/v5CM8jnZX
	VlMpEH/C3C//5b2p2V110medQrtBKp0YS4Lsbbk=
X-Google-Smtp-Source: 
 AA6agR6QyPUhLX0ClzyRVP7x/pQl8sPFmg7WofGyrZXf4SP1TZpzZ8u4C2TZOibjmTUTgmIiOg3tsw==
X-Received: by 2002:a17:90b:4f4d:b0:1fd:c928:e346 with SMTP id
 pj13-20020a17090b4f4d00b001fdc928e346mr4451146pjb.214.1661971901029;
        Wed, 31 Aug 2022 11:51:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 mn22-20020a17090b189600b001fd7cde9990sm1715256pjb.0.2022.08.31.11.51.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 11:51:40 -0700 (PDT)
Message-ID: <630fadbc.170a0220.72141.3d7f@mx.google.com>
Date: Wed, 31 Aug 2022 11:51:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.138-cip15-90-gd4130d0ee3c7
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 5 runs,
 3 regressions (v5.10.138-cip15-90-gd4130d0ee3c7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 18:51:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9394

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 5 runs, 3 regressions (v5.1=
0.138-cip15-90-gd4130d0ee3c7)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =

qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.138-cip15-90-gd4130d0ee3c7/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.138-cip15-90-gd4130d0ee3c7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d4130d0ee3c72fc50c48ae861863e85537802c47 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/630fac786fb1c82783355657

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.138-cip15-90-gd4130d0ee3c7/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.138-cip15-90-gd4130d0ee3c7/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/630fac786fb1c82783=
355663
        failing since 57 days (last pass: v5.10.121-cip9-287-ge9094c8446fc,=
 first fail: v5.10.125-cip10-119-g603acbe1aceb)

    2022-08-31T18:46:07.827976  <8>[   12.414694] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/630fac786fb1c82783=
355664
        failing since 57 days (last pass: v5.10.121-cip9-287-ge9094c8446fc,=
 first fail: v5.10.125-cip10-119-g603acbe1aceb)

    2022-08-31T18:46:07.809682  <8>[   12.396672] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/630f9b82aeec1b5ab9355682

  Results:     15 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.138-cip15-90-gd4130d0ee3c7/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/smc-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.138-cip15-90-gd4130d0ee3c7/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/smc-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * smc.CVE-2020-0543: https://kernelci.org/test/case/id/630f9b82aeec1b5ab9=
355684
        new failure (last pass: v5.10.136-cip14-542-g97767707d3d0)

    2022-08-31T17:33:43.321822  <8>[    2.588493] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2020-0543 RESULT=3Dfail>   =

 =20

