Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48CDC0502A
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 14:18:01 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web08.25969.1661955479113484252
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 07:17:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=8PU/MfYx;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id p18so14244523plr.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 07:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=L/b4YCUTdHfkHG5ts/jNeXV9stsczltBpJItSYm58O4=;
        b=8PU/MfYxhVtY6ip1AULfhxJOEnyrL01FzWxyH9OnHQ/OusNj6zxj5/zhtQ4AT3MbQX
         vb82xedlz3mV15mVGzKw5vTmFCKtyW+CKY5LSB4TQJR8IubvCdT0MEjdbj1A5zHs9xAe
         UIsGOBrJ5EVfTe2v1kfaxJ2o4RBjKVlloRguKIFI0SwYPejayCTOyhbw9TNedQW7FMoH
         kOCU5vNAupGgKhGJ+Z9ICWXv0jU1mcbKRKnhI6fYbNvQu7ZXiq+16IcJn3j67hWM9tfQ
         lfkgjXDqDkcySZusXf6iMYZOH8+XYlguTpSoisfIcd/0rk0Yki6QXrlYYFG96FYXoGn7
         juBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=L/b4YCUTdHfkHG5ts/jNeXV9stsczltBpJItSYm58O4=;
        b=HB9DfRGx//NwWOYA1rZbvx3uOq/k0WuhrORuzu9v3BbKnKa8L/rUjSrYwgUiK33Lba
         6LVEei0ljjUNVreXxJLAasb2TjHgVGIknSbL2AeuIiqNTzx2TyRThDok0kXNa07ZU9Ud
         mihp5wowyhhfip+m+/n5Jc08P973MFUjXPcK31q6kUFvhmXX/womjVb8nf6qAYMhr5US
         8BZfmdyMbZUzxzXHABYstrgx0qkmDsZrGmuZqHWF+UOPNxzi1OQ9ziSz8XDG708YhNQa
         tgkSnQoYxiIGVPDBahflZIvf3Hq/KrECrCdQciocX/Jdqam/orCJar1SSZfmDxmEh+SQ
         7O5A==
X-Gm-Message-State: ACgBeo3cfXYBcfUtStXJ4rUoe21zXLSGPSy4fs1ZbH76cjiZrybhNW4X
	DOcLQAohMPwTQqu6iYUBkP9IbjRpUMg746s7a+o=
X-Google-Smtp-Source: 
 AA6agR4Dv7kOSJW7vP4ONdi0vh/LJkdAHoPhmvtxzwKxGKPfAdw2lGrLTT/8++bAlG+5HeQAaIqXww==
X-Received: by 2002:a17:903:22c1:b0:16f:3d1:f5c with SMTP id
 y1-20020a17090322c100b0016f03d10f5cmr26082958plg.155.1661955478287;
        Wed, 31 Aug 2022 07:17:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 w190-20020a6262c7000000b0052d2b55be32sm11701463pfb.171.2022.08.31.07.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 07:17:57 -0700 (PDT)
Message-ID: <630f6d95.620a0220.d8efa.4f0b@mx.google.com>
Date: Wed, 31 Aug 2022 07:17:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.256-cip80
Subject: cip/linux-4.19.y-cip ltp-mm: 4 runs, 1 regressions (v4.19.256-cip80)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 14:18:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9347

cip/linux-4.19.y-cip ltp-mm: 4 runs, 1 regressions (v4.19.256-cip80)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.256-cip80/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.256-cip80
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e5c44c8629fdb37d31546d9544b68fef7292f810

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  48cfd7a9977e6268b4aa2600608cebad7e0e42b8 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/630f670f10b02283b335565a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.256=
-cip80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-a=
sus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.256=
-cip80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-a=
sus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/630f670f10b02283b335565b
        new failure (last pass: v4.19.255-cip79) =

 =20

