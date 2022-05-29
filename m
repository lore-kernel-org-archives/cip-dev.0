X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web11.25982.1653837578068878327
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 29 May 2022 08:19:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=hWbtinHm;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.175, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f175.google.com with SMTP id j191so822302pgd.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 29 May 2022 08:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=tFSlqOaadDYIF1jreecg5GjZFp65VlCyJgSI808O1hA=;
        b=hWbtinHmHV3KhB/q9N2vR/SOtMs+g6vjg6UhAgmqHpFs+qnO8GS7QmGDtq+JqLcrRw
         1bVV0EwpX9L0X6Qmr84csViSUFLXP2K6PV4gJCi+7Z69rXOXNZdMmRaII9fJLH25GyQL
         mO98RHqfw8+VY+LA35ws/1zy4XY+LdKaOmaP8z9lq6Qihjrncb+a8yNJJHr8BrLA1Ezy
         ME2KvFhojR7FvRz5gMPgfvgRTeJ0J0EP3W4Dp8Dj6kfq40EQvllqjemFdqxGLMM7CWgw
         SIM4dt5nYIeD6NbNa71q6G9AzMh4bQ8yYDmFjSSQRrO0YUMPW73u28pCVGamo+ErKeG2
         oFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=tFSlqOaadDYIF1jreecg5GjZFp65VlCyJgSI808O1hA=;
        b=gZpkXmyoR36H0s6sbK9zsmSF3i58e2tJOc3JTVLuiqnYlfPl1bF5NHuWcLfLPW09oB
         3NDydHLzcVTjsisvgSZFMxrf4/a7F/nvInnyBqe095hE3pYfPjUXd5ydud+OmFinaO4f
         c6T4DUg6etu6j1i4b488qM+1G9qrRyrd4CqO5Uqvvbke/RAvAcuNxilaNv3TbZvHL4i/
         9Faml7xHnikDGKkbr+EYqJAvVWc+JkrgPV+6BnyiqszKvNfucVmV/4sZltcOfvecyhWM
         jQfxfs3nMDLQ1nye64lwZNDSSGsDs/WJ95zKdphY0GW1GuDRwWUTHV62lqE/z2QHcJXj
         GRHA==
X-Gm-Message-State: AOAM533/6wID5odPoBmOc4uuPe+GBOYGFoDXwZz9VZQ40MJvrfkmylK7
	itAxxasJTNkrLEWn4d0iVg9UU5B6j/FHMgyHY1A=
X-Google-Smtp-Source: ABdhPJw3pCPJU0aGgvAqGHahnQUlJWky/nqQ2tR9AcWzvsaXCI2kLG9SlKFVUqyg/twQPHkNSpKs9A==
X-Received: by 2002:a65:6e44:0:b0:3db:219e:2250 with SMTP id be4-20020a656e44000000b003db219e2250mr45387211pgb.369.1653837577373;
        Sun, 29 May 2022 08:19:37 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f14-20020a17090a9b0e00b001e281acb2f1sm4475024pjp.57.2022.05.29.08.19.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 08:19:36 -0700 (PDT)
Message-ID: <62938f08.1c69fb81.5576c.96a4@mx.google.com>
Date: Sun, 29 May 2022 08:19:36 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-297-gc0d53c2a5c03d
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs, 3 regressions (v4.4-st5-297-gc0d53c2a5c03d) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs, 3 regressions (v4.4-st5-297=
-gc0d53c2a5c03d)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-297-gc0d53c2a5c03d/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-297-gc0d53c2a5c03d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c0d53c2a5c03d0b2672a56140f211b51b3e047c1

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  17e9ae697a340242c49188ace12a60cd3bc95a53 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/629379c007f73d195ba39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/629379c007f73d195ba39b=
ce
        new failure (last pass: v5.10.112-cip6) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62937a218eee34ae0ca39bd8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62937a218eee34ae0ca39b=
d9
        new failure (last pass: v5.10.112-cip6) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/629379b4c0eb3c421aa39bf4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/629379b4c0eb3c421aa39b=
f5
        new failure (last pass: v5.10.112-cip6) =

 =20

