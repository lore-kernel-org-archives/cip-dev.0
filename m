Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED1DC43219
	for <webhook@archiver.kernel.org>; Fri, 30 Sep 2022 15:52:08 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web11.569.1664553126447969925
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 08:52:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=8Un0hloH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id v186so4594853pfv.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 08:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=vyDyBJSIsouDxFAr61yQVO+39vMXDUQT0lOL2qYnLDs=;
        b=8Un0hloHSxTX6hnsZgmCeBHarLlhZXtqorlBCi0HOnUBiLHsM0VkE2JizKI+ZNwcYS
         igwU4FMDUs5sTD/GeB0trgibU9H3SSGkCeedv2vYu3YEH+VfGhnxhJzH11BYzCBSfLjD
         sTN86HDSdGjSNPiZDeqsf/HyZTNaXLv3uT/KVL+/wJkHRfscqXWxH00DmUrNXtOB+Avp
         xpCTSZ8zCu6FPSpgxaFFjMN+UH5UATLJqf6qj2sVGGK2xoj+i8YkKQc8xEpN5yPIKaxt
         MZCKC7ggLDbRAOlVqm/Jzm48QAUHloqfYXMCw7g5MH7CpXHcBZ3gj7z1aAgzI5FxZptn
         d+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=vyDyBJSIsouDxFAr61yQVO+39vMXDUQT0lOL2qYnLDs=;
        b=o2ff8Xw4EGiL3eTYil2rTlGnnfGmm0r2nNCQTovDvTF/ahqDIYFcl365qdyvjilLA6
         IARuGlKVd/pZCMCSmr+4oUc4xatDbxr3bLCr86GcMkK5Xhm4NvOb9hDK1mEVhahsrOdS
         ItCGCCPlOW/bwLApE/mxgP2n3Ww0krPfQvJKGp8Z24ltFOElRgq65iJC/Er1iQ11FTVC
         0ynLrfGgLjbGgHMpWLFRYVK5sJuQnfhvHkRWIapsfyGIZr9r9BlYRKkmJ/LfaTpElX4K
         o9Pnq5vBaaT8lzGvGkXtOWbgxjqXyrsdl00onU3FUnO8aLV+SYMILwo2SvujmwaocVS7
         ROag==
X-Gm-Message-State: ACrzQf0V4On7mlsuAlLbVMs9BGveRdnyQVB9eNaf7vNS92MeHVntWvG9
	N7n4M8Fn4oKhCA60DW3Rzno5RyJD18NSOmeYmY0=
X-Google-Smtp-Source: 
 AMsMyM6rL3w9T87wFfcqWkmT5qVmT14PFGs02ZrXla1mpwCqEYf85BKTYHxrSdeFFTP/+d0EBub0Nw==
X-Received: by 2002:a62:1bc8:0:b0:546:c62e:e84 with SMTP id
 b191-20020a621bc8000000b00546c62e0e84mr9682219pfb.45.1664553125656;
        Fri, 30 Sep 2022 08:52:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 n15-20020a170902d2cf00b0016f1319d2a7sm2014367plc.297.2022.09.30.08.52.05
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 08:52:05 -0700 (PDT)
Message-ID: <633710a5.170a0220.acce.3ee0@mx.google.com>
Date: Fri, 30 Sep 2022 08:52:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip70-98-gb2bfffe124dae
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 6 runs,
 4 regressions (v4.4.302-cip70-98-gb2bfffe124dae)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 30 Sep 2022 15:52:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9597

cip-gitlab/ci/pavel/linux-test ltp-timers: 6 runs, 4 regressions (v4.4.302-=
cip70-98-gb2bfffe124dae)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip70-98-gb2bfffe124dae/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip70-98-gb2bfffe124dae
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b2bfffe124dae9fd793da3a9d45f286a98412d6b

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  48cfd7a9977e6268b4aa2600608cebad7e0e42b8 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6337060dfb9a9753d9ec4ea9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6337060dfb9a9753d9e=
c4eaa
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/633705f06fcd50ce71ec4edb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/633705f06fcd50ce71e=
c4edc
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6337078ac659989dd2ec4ec5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6337078ac659989dd2e=
c4ec6
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/633705fc6fcd50ce71ec4ee1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/633705fc6fcd50ce71e=
c4ee2
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =20

