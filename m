Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EB6C32789
	for <webhook@archiver.kernel.org>; Tue, 23 Aug 2022 04:00:09 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web09.27872.1661227200832105673
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 Aug 2022 21:00:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=iMWy2umx;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.178,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f178.google.com with SMTP id bh13so11206055pgb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 Aug 2022 21:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=JSk/oO32x0FBiZyYRojpZTYZt1wq83Afv9gyoxficRM=;
        b=iMWy2umx1CUd0C6EpPuvt65VxIYsnSIbguHuZw8oHRz5UgwGiZHEzgMH4CsliJ9s+t
         imEBuRUewZD4cB8n6+b72DsZXCwQ1/LO2Jj1rvdTdGr8eps3aZMC/LvQvTX8ItFDS3IG
         CVPqZQF1fNfftuc3x1kCOyPqUW1YDPFiA8HZ+jZbsvH9j6D4QPtO1aNIw/9VdI7CcNLX
         esJBEBufsQYCHe28ZEEogPazWGPbbvVP4L74r0U44ViepO1XH/JLL/wJWpwva8Poddfs
         RnbH0EB7mIaJvkOIhBVyK/TeoDE34xnRr7mwO9R2dTOz8nbHm3DnJQbFp9Q3qtvbk2BW
         tMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=JSk/oO32x0FBiZyYRojpZTYZt1wq83Afv9gyoxficRM=;
        b=XCOD077azDhuLLNxeeO8s3wT/ttQHUWGgWTxyLoIj4jHThemjqZBQPECfHQnJH0Sid
         ccWzgWl4LMsluLW/WMdrw03JNcH+ubw8EtvpO+P9pLDPCDAoGOQQ/O8qPIuPZJFnGf4R
         FQadkcLMsxmHjXnXXcweKVO3TYnnIr9++UV6Q4CEO2//Hnaale2Xx3pq1kKZbxAIoPmA
         tqKME/Ctu6ogHDwv30dD9EDezrPpOisLDch1Z3WtCiFzZ/mZyZrj+RPWTegMPO7pzyx0
         N2bsHt7Xcj3OX8tEgfpkeKK8RaXkFQhqMjEdjgcdUkigcyWIrRKv70LUiNPvd6t63gnP
         7B8A==
X-Gm-Message-State: ACgBeo0H+cff3L8d3nL9FHgFz7pudv1eB5cwj8CwGp6EdjyaxVQuGEyK
	bvW1Bi6fbqJ9/UBQpF3r93x/O+/9uTgwOrfj
X-Google-Smtp-Source: 
 AA6agR5yB/4p/kiMOsIqunDtoVCLySfflwV9ghQ+IrTnHSxCMYku4ixiA3xRpLf5xpKisE7tomUHFQ==
X-Received: by 2002:a05:6a00:1741:b0:536:baed:52ee with SMTP id
 j1-20020a056a00174100b00536baed52eemr6174277pfc.68.1661227200192;
        Mon, 22 Aug 2022 21:00:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 bk2-20020a056a02028200b0041c0c9c0072sm8041750pgb.64.2022.08.22.20.59.59
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 20:59:59 -0700 (PDT)
Message-ID: <630450bf.050a0220.646a6.e32a@mx.google.com>
Date: Mon, 22 Aug 2022 20:59:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.136-cip14-542-g97767707d3d0
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 6 runs,
 2 regressions (v5.10.136-cip14-542-g97767707d3d0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Aug 2022 04:00:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9305

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 6 runs, 2 regressions (v5.1=
0.136-cip14-542-g97767707d3d0)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.136-cip14-542-g97767707d3d0/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.136-cip14-542-g97767707d3d0
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      97767707d3d0aa36cbf6620b216d0d19b9314417 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63044489a383431e27355643

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.136-cip14-542-g97767707d3d0/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.136-cip14-542-g97767707d3d0/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/63044489a383431e27=
35564f
        failing since 49 days (last pass: v5.10.121-cip9-287-ge9094c8446fc,=
 first fail: v5.10.125-cip10-119-g603acbe1aceb)

    2022-08-23T03:07:42.062536  <8>[   12.994357] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/63044489a383431e27=
355650
        failing since 49 days (last pass: v5.10.121-cip9-287-ge9094c8446fc,=
 first fail: v5.10.125-cip10-119-g603acbe1aceb)

    2022-08-23T03:07:42.044013  <8>[   12.976256] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =20

