Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167E9C19F2A
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 17:55:30 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web11.979.1659549327297579984
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 10:55:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=mNN6McdW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id
 v16-20020a17090abb9000b001f25244c65dso2793549pjr.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 10:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Ok0CNdq5vpXuaVY5XFyE3s4IozSVannoH2KfpAY4GHg=;
        b=mNN6McdW4tAdmk9xYDW69jvXMBPk7WhTVTth2kPg3JD02YFC5I+TiodTXlqqic/E/E
         8CFFcYiz0s5eqK0UeQ9cCk92xKkUUXStQlfedJ8cIXpkk+Wuo199uRVPlfrBhD0Nf4jf
         MODAL34jvWHdFZ8BpseZrZHT8VZN3nsHY6UlusbRVa8IK6euKm3dSX+DQFZjNQuuA7PN
         I0RgfCjQmreKd8CbLBY+M1W6n0Klaqiv9TTuvhfSEzL0/8N5MUcNkfPr4lEjkTx30N0k
         ow3zdqhfKsilWl2hddQ77HgecqBRv+6duHawuPPYgNm9FXPmoapHj6+pWoU44VUxF7pT
         cBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Ok0CNdq5vpXuaVY5XFyE3s4IozSVannoH2KfpAY4GHg=;
        b=JgupfK3W8XaQ541EyZ+Ic9l/6Plj8VEKgcLDb4nMNt7Fqv/Zk4zjmdBXWvx2kIX8bF
         oT0YqP7i3DSk+z1wLB+CbERweoUfxX6bUjWpdpf40nHU74P71KFGYHWcJgGlV/yRuQxv
         leue1j+q8/N6htK0y1pssaOm/k9FhyBympgZxmc8rnmDQL17XTPILGMOVUH+Z9ia497h
         FiFeHhd4wgzvjxrkNmgyaZeHW+K1kU55BAj1oOuZ8ukBm7D62cTwfnuSWddHmYJ+JAdU
         MXDGCApVBZA47idd4DpRqr2XAGb7O43HIiGw1mgELI01u66nxXldos+Qwj2fxjshKtvv
         vWVQ==
X-Gm-Message-State: ACgBeo230cDeCu9VYfyTrABq/G80UaCmkAWBbUj9maGWl5bK2e8Yc4f8
	WXPtRBVHXO+dmY490vnl5O9rdV+ulf4ctP2fK4Q=
X-Google-Smtp-Source: 
 AA6agR6glp/C/HllRgbjk9TQacTjC6Cr8/fZCv4TOnBGuMeo+hMApvge63jwvSleCNN9NXwIUJT+eQ==
X-Received: by 2002:a17:903:447:b0:16e:cbe3:29de with SMTP id
 iw7-20020a170903044700b0016ecbe329demr21788312plb.65.1659549326351;
        Wed, 03 Aug 2022 10:55:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 e14-20020a056a0000ce00b0052e0bc3ca3asm2611366pfj.173.2022.08.03.10.55.25
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 10:55:25 -0700 (PDT)
Message-ID: <62eab68d.050a0220.b028e.496a@mx.google.com>
Date: Wed, 03 Aug 2022 10:55:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-74-gc99f2b257bde3
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 5 runs,
 3 regressions (v4.4-st20-74-gc99f2b257bde3)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 17:55:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9093

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 5 runs, 3 regressions=
 (v4.4-st20-74-gc99f2b257bde3)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-74-gc99f2b257bde3/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-74-gc99f2b257bde3
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c99f2b257bde3cd60a833056aab624ad5fab3812 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62eab299624b85190ddaf057

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/62eab299=
624b85190ddaf058
        failing since 0 day (last pass: v5.10.131-cip13-24-ga6f4ea41fe167, =
first fail: v4.4.302-cip70-rt40) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62eaa973274be75cacdaf057

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/62eaa973=
274be75cacdaf058
        failing since 0 day (last pass: v5.10.131-cip13-24-ga6f4ea41fe167, =
first fail: v4.4.302-cip70-rt40) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62eab57e2192f3766cdaf07a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/62eab57e=
2192f3766cdaf07b
        failing since 0 day (last pass: v5.10.131-cip13-24-ga6f4ea41fe167, =
first fail: v4.4.302-cip70-rt40) =

 =20

