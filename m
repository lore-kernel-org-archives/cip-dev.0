X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web12.438.1649866938901693630
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Apr 2022 09:22:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=J+5LIm/Z;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id q3so2398542plg.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Apr 2022 09:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=mcqIE9xr55RT3zvWgz9ukVAhV1Ogh0HOIehzHT5hmGg=;
        b=J+5LIm/ZzjiqNL2rk8qQ1WeKLV5uJZvz58u5LU1wkR7AsraOpUvivk+LjHFPk64kFE
         ww8jpQspGem/0TBZ0q4ODGeDHo+o8lgYMWKaey+Bh5R0hEGwPvPjYz8dHf/jjNR4tvAu
         og2rLbhWqDQTYX+lbfk2HRvF//Em3AsD5IXOjlpTQuWaWPvfAvhxy/yD2u8c6prJydrp
         qKoo7EDmMjI1I7Zjd119OsXgr5nk3RNUkQOM3T2AZt4exaz8VDdyo7SX2nqICk92W0Dh
         L9pgyjawahbszmGUJYobTBKY8gAaWMNlNGOJS3aPWaJmZk1PIYtyTxv2DNXlDzJv/G7s
         WFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=mcqIE9xr55RT3zvWgz9ukVAhV1Ogh0HOIehzHT5hmGg=;
        b=1vzORwgYVkpnLGMBD/r2DIBT3ZTFj4dnP48mmOegeJDy9JS70Fno5xN/u836sF3qV9
         mi+ZKXdr5Blaeg6EgOweWFgLqQt4Xd9U7t9VEAi9D4Sq8ipIxO5azZtDpFMk7MJTNMcK
         ttyPqE+wDC0yiaVYeoUPfIiQXH5TRqhZUSEQ76TDMk4wBgyCVaKznqJ/QFWzCUUTASBf
         pzQcvkFEqioIZa1R3kGagHVpKSyJTYvNUC8QpLidwslmyIPcBbXp4A+h1RFLaG945h7V
         yWNV2LuVxAljoHNMJPw+cizbNHEr7nEU3vkLTPq4iQGhKGNtvJffQuYVyYsZzNx3fkdz
         zfMw==
X-Gm-Message-State: AOAM533kSVQysBcZLCU4SibMNHLrLFI17W7wl7ovJKfuRLETWYAP6rWp
	PhnRdrvJ0HvmaL2z17yq4Cdq2ziJ/uTplCQ1
X-Google-Smtp-Source: ABdhPJznX/xsQXAtBkRgyLY9N+HvbieWkb4k87kwT/ThC6mt58j5C4FKCgoYrM77ULNzqhMGvHoOfQ==
X-Received: by 2002:a17:902:e78f:b0:156:3b3b:e4ce with SMTP id cp15-20020a170902e78f00b001563b3be4cemr43839009plb.8.1649866938309;
        Wed, 13 Apr 2022 09:22:18 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090a3fc500b001cb3fec230bsm3556214pjm.14.2022.04.13.09.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 09:22:18 -0700 (PDT)
Message-ID: <6256f8ba.1c69fb81.2cfcf.8e3a@mx.google.com>
Date: Wed, 13 Apr 2022 09:22:18 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.109-cip5
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 3 runs, 2 regressions (v5.10.109-cip5) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip kselftest-seccomp: 3 runs, 2 regressions (v5.10.109-ci=
p5)

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


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.109-cip5/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.109-cip5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      9c39c65c57028fa2c58fb7579c15f9cb67571acc =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6256ea47a75692fccdae068c

  Results:     83 PASS, 4 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.109=
-cip5/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora=
/kselftest-seccomp-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.109=
-cip5/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora=
/kselftest-seccomp-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220401.0/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/6256ea47a75692fccdae0693
        failing since 15 days (last pass: v5.10.100-cip2, first fail: v5.10=
.106-cip4) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6256f0a2ab516b4c48ae06db

  Results:     83 PASS, 4 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.109=
-cip5/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora=
/kselftest-seccomp-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.109=
-cip5/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora=
/kselftest-seccomp-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220401.0/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/6256f0a2ab516b4c48ae06e1
        failing since 15 days (last pass: v5.10.100-cip2, first fail: v5.10=
.106-cip4) =

 =20

