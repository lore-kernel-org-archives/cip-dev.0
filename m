X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web09.4067.1649213189725723961
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Apr 2022 19:46:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=40tnI/2l;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id x31so1227555pfh.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 05 Apr 2022 19:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=aEnbR3RIulSik30KsNActwn9/eBm6CSioL3uK5T6rOs=;
        b=40tnI/2lKe0WOIJjrmfr/Zd5V4eI8k6DzqopsDeDFfGw+8J13GHfPMtkBVlEoYMly5
         /kxDIXAMt1PkB9+poHJpSLUsnHHQLysbEH6IkMKRrcJGIKW2iZ2YTFtD2zhTv73UNwM9
         zCCItbGOl3S8vD9nzEnEmehNH5QB6R98Hz3ehxklJlpfH7dnW9GNtGtqOhYSyjo1FDX0
         X7CRx82NO3HqkOkSOSBtQQPdDwZllJbe2WtKaZPmzYMyi90GQlOCTau1wiTCZRi2Cmp9
         UD/kU3TX+NfZ3DG2idRNDH0LKSiRrZsmeYrcsoUUtom6YbJr/qpeSDrA6uuXcMZsZ4QO
         zg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=aEnbR3RIulSik30KsNActwn9/eBm6CSioL3uK5T6rOs=;
        b=J8v5yFvwWj0ce7Wezq3/GedVo3HRo2y6gB2xr5AQ11CYmFXSr6QrKCRoHpyDE2V+k+
         9DTr2ckZb/qkKzgAWS/H47KvN/e4M5nEYWqkNmbuyY/woTK/9+R34xnSiyFZ+L3P1Si9
         +kij+/kr8A24cXrM3cqmgFY+T2BDxxtAo5skgWF9FpM/dRfETxXp4kgaA6fDzkV+OXWz
         ceEUrYObcM8bjAMTcGCX0MIUdGn6V89xyWlFhwBGrfA4eyee+Tjs8wFDAZsu20ETcbM+
         x+2DtbDocgfZcHr9jQ9sNMhuKctx5c6trt6IvG5XJ4nRdbhM2J0xc0efHRbXwrlLMUfc
         rYJw==
X-Gm-Message-State: AOAM533I0499PBTuRxp6bU95pto9BgBa0ZpGgqKurJIfLpJJInQfxxG/
	kyAGcMzqjiSRrkCtbq7pWWR42sN4m/tP9KIxU1E=
X-Google-Smtp-Source: ABdhPJwQwXuWmSd5izMzS3HqKnWVqsBnnrGkgA/g/2NMqQ8hTAAkuzTETDl9XUQU7oGEU68dGyEDYA==
X-Received: by 2002:a63:d905:0:b0:399:370e:eee1 with SMTP id r5-20020a63d905000000b00399370eeee1mr5435367pgg.53.1649213189150;
        Tue, 05 Apr 2022 19:46:29 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m18-20020a056a00081200b004faeae3a291sm17231679pfk.26.2022.04.05.19.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 19:46:28 -0700 (PDT)
Message-ID: <624cff04.1c69fb81.ab00f.e68c@mx.google.com>
Date: Tue, 05 Apr 2022 19:46:28 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.106-cip4-66-gc8c4cc5cdb54c
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 5 runs, 2 regressions (v5.10.106-cip4-66-gc8c4cc5cdb54c) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip kselftest-seccomp: 5 runs, 2 regressions (v5.10.106-ci=
p4-66-gc8c4cc5cdb54c)

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
l/v5.10.106-cip4-66-gc8c4cc5cdb54c/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.106-cip4-66-gc8c4cc5cdb54c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c8c4cc5cdb54c5d2534c7533f0cd8a10adff3ba0 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/624cef6d81cfdf861cae067c

  Results:     83 PASS, 4 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gc=
c-10/lab-collabora/kselftest-seccomp-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gc=
c-10/lab-collabora/kselftest-seccomp-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220401.0/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/624cef6d81cfdf861cae0683
        failing since 7 days (last pass: v5.10.100-cip2, first fail: v5.10.=
106-cip4) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/624cfe2571f87ff4a5ae0681

  Results:     83 PASS, 4 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gc=
c-10/lab-collabora/kselftest-seccomp-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gc=
c-10/lab-collabora/kselftest-seccomp-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220401.0/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/624cfe2571f87ff4a5ae0688
        failing since 7 days (last pass: v5.10.100-cip2, first fail: v5.10.=
106-cip4) =

 =20

