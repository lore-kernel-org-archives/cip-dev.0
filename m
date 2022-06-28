Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17AECCA47F
	for <webhook@archiver.kernel.org>; Tue, 28 Jun 2022 00:39:31 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web09.49728.1656376764945723609
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 27 Jun 2022 17:39:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=613Rn+O6;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id l6so9615511plg.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 27 Jun 2022 17:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=wBpmiMfh8Yy85JUFtSX5Hl0pVYdtIlYw1XiMFl+mSMM=;
        b=613Rn+O6X2kKSeOENhz5CMbIJw8wr81oiSWhHJIdtuy0DGpe/bXEjNX+U8jQ2pOUrY
         6/0WwUTdGzH77C0vX7AlLoSkHcQqUfcsXMFNKaYxFSeO4YpLlx0qeJb021188otUo5CA
         gNW2hRAKX8sNIqhhIXfW1U/jkxUTvrBCw7GU/2hBA6AdkPaJ6hISH9GiBlbZsQbQ4WIo
         SB7u+21sTNWfttK75alvR2MMYmICRBV0j+iQRZ5QgkBvgpa2KqSJRhqYoDzWbIMvyraq
         /wkfmlrN66iEqXOc+FQ6l+L15VFj+CCDxrFMPalnuMLOoHMeuAQ34wvhYMQ2BQALS5+a
         Ffag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=wBpmiMfh8Yy85JUFtSX5Hl0pVYdtIlYw1XiMFl+mSMM=;
        b=RbOnjzDYSAVNC32P05nU9w89ra1tRsB1OcEqQxypcLGQe5nMnjEs6ybXnEE29YQvPB
         17yzw/PU3hjF4G/014WleMePHrKB9eZkv6U18mUjPzcTssq3N6ZhTJ0KDu5ulmq0eb1v
         +NVxcPfbiX9PGIe2Oc43IDvRCObQHb7tkhVjSv/HgPsz8dLjom4xZZwC1LlUQ8SeyQxh
         oUKt68JaZVOAASmdeKUI5O7yDHNY9A1vYK/P1T0OalzkgZjsCkG/9BKwnY53Y+y5xI36
         JV4HlSAJriwo9q7wYoibK3h5H2qFKwgtUrr6QbLX5m4r3Lalrqz/EabnL52P56O6Va7w
         CT6Q==
X-Gm-Message-State: AJIora+nCFhqmijl9cJNFwOSEOKM7uDx/BUngIOqgsIw+3oYUo1H1nOb
	nREpitfLOyfZQYumwEBb4cQLsGq/mfoMecvA
X-Google-Smtp-Source: 
 AGRyM1u/W5KRGGkN5efpkE9tTJHXXKaKixZYiNmHePG+5xmCxYm/tXPGxJUAJFmNDAK5kbcvPrwVNw==
X-Received: by 2002:a17:902:9a44:b0:16a:585b:5a16 with SMTP id
 x4-20020a1709029a4400b0016a585b5a16mr885963plv.154.1656376764361;
        Mon, 27 Jun 2022 17:39:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 f10-20020a631f0a000000b003fbb455040dsm7672097pgf.84.2022.06.27.17.39.21
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 17:39:23 -0700 (PDT)
Message-ID: <62ba4dbb.1c69fb81.cd5af.a7d9@mx.google.com>
Date: Mon, 27 Jun 2022 17:39:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.121-cip9-287-ge9094c8446fc
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 5 runs,
 2 regressions (v5.10.121-cip9-287-ge9094c8446fc)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jun 2022 00:39:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8613

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 5 runs, 2 regre=
ssions (v5.10.121-cip9-287-ge9094c8446fc)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.121-cip9-287-ge9094c8446fc/plan/kselftest=
-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.121-cip9-287-ge9094c8446fc
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e9094c8446fcef728d675699ced39be2dbbfb8f7 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62ba38d41aabb8bb99a39bd6

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-287-ge9094c8446fc/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005=
-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-287-ge9094c8446fc/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005=
-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62ba38d41aabb8bb99a39bdc
        failing since 3 days (last pass: v5.10.118-465-g0af29783a3c9, first=
 fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62ba3d6f69e8633025a39bd1

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-287-ge9094c8446fc/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grunt=
.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-287-ge9094c8446fc/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grunt=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62ba3d6f69e8633025a39bd7
        failing since 3 days (last pass: v5.10.118-465-g0af29783a3c9, first=
 fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =20

