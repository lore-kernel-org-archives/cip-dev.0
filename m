Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD52C41513
	for <webhook@archiver.kernel.org>; Fri, 11 Aug 2023 14:57:23 +0000 (UTC)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
 by mx.groups.io with SMTP id smtpd.web10.44884.1691765838706051410
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 11 Aug 2023 07:57:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=YQIUxmc4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.170, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3a412653352so1727275b6e.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 11 Aug 2023 07:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691765837; x=1692370637;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dHDmdYzToSuIjnHzOHOlACD51N0QcdEwGZYQe8UiX40=;
        b=YQIUxmc4BhdtFZXQQ7VD7LgpuRZi9E9fuyAhwZTIRSs69u2VNEk7EWlAuijvHBn1GP
         qmWcM1B/GrcrC6Jvw+XwpOERe7cXlm84u+dPZhYaShbsx3BqVHkNVbNv4tRAx+eiJAfX
         sP2WJKGTkWyP635Dpo0DLJMKnZMhzEyixuJD/NpSTTuzOGpWoWSWjn6pwPSVmDi+i0Vx
         SA9lf6/1W59sO/AgKBF2iVN/QzGcsA7AK56bs0ebdJUruGOnUJWp4m2JBMSSHZ8954X7
         6VgePV8q081lU/frl5HMWkXJMmZ+9puG+pAe1OMHl3nNiFZzMEdGcXrpvqoV/RGEt6Sz
         shvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691765837; x=1692370637;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dHDmdYzToSuIjnHzOHOlACD51N0QcdEwGZYQe8UiX40=;
        b=dCK6kptgM7VNgRlE0z6icKPkmHrsb9sAXSb4LJ53WIEwEgdUKGFbehnwTJRWspwtGb
         o7rFCBGfuujmwQQrLhUg7V+taJrWKHa8u0KeknxzEGlQywv1RU/8zARaIXGr5LV5twE7
         HxAebcMKUpmXHMDbF/AiKdoDOYYwifBV018N9pspCKttr8Vx95HqHMf54CgAl3ZGWcnZ
         EvYF4r1VAElBFQ1RoE76clTLKKroaPfaoMTuxNJOjLSuvrNKSfqfF9FYNFHGPdJz82QF
         4lGjpTlHC6p4DPw9XfNulX+aAlX991a6wcX8sj+9/WUOuJNuXs/8IXyDlqJijPO4CLGb
         P4Hg==
X-Gm-Message-State: AOJu0YwWig6STglIuf0mYQA0BTuJz/CSLasQeV3f7ai4fBXkWa/Gl6b2
	VO3G1y3ANPmQqAMd9O35ZjQgqg8OlkZge9fnXc+exA==
X-Google-Smtp-Source: AGHT+IFUPHtqmigzsR5BKj47VfbQkL3K5qCjdhdBDi4Teq+rLiSUu4NfNAVnI1cEWrBWqyX6F6DY1A==
X-Received: by 2002:a05:6808:15aa:b0:3a7:a375:a173 with SMTP id t42-20020a05680815aa00b003a7a375a173mr3109323oiw.10.1691765837325;
        Fri, 11 Aug 2023 07:57:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x7-20020a63b207000000b0055386b1415dsm3458405pge.51.2023.08.11.07.57.16
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 07:57:16 -0700 (PDT)
Message-ID: <64d64c4c.630a0220.1eb6c.6496@mx.google.com>
Date: Fri, 11 Aug 2023 07:57:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-770-gddd36cfc4c4c8
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 43 runs,
 11 regressions (v5.10.186-cip37-770-gddd36cfc4c4c8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Aug 2023 14:57:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12616

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 43 runs, 11 regres=
sions (v5.10.186-cip37-770-gddd36cfc4c4c8)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.186-cip37-770-gddd36cfc4c4c8/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.186-cip37-770-gddd36cfc4c4c8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ddd36cfc4c4c8e772fc77e48315307e9956bad25 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d641bd50d4794b1535b21c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oc=
topus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oc=
topus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64d641bd50d4794b1535b221
        failing since 113 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-11T14:11:48.589728  + <8>[   16.299589] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11263807_1.5.2.3.1>

    2023-08-11T14:11:48.590195  set +x

    2023-08-11T14:11:48.698359  / # #

    2023-08-11T14:11:48.800775  export SHELL=3D/bin/sh

    2023-08-11T14:11:48.801704  #

    2023-08-11T14:11:48.903457  / # export SHELL=3D/bin/sh. /lava-11263807/=
environment

    2023-08-11T14:11:48.904161  =


    2023-08-11T14:11:49.005456  / # . /lava-11263807/environment/lava-11263=
807/bin/lava-test-runner /lava-11263807/1

    2023-08-11T14:11:49.006563  =


    2023-08-11T14:11:49.010564  / # /lava-11263807/bin/lava-test-runner /la=
va-11263807/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64d63f11b43e43b70135b1e5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.=
txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64d63f11b43e43b70135b1ea
        failing since 112 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-11T14:01:09.931674  + set +x

    2023-08-11T14:01:09.938153  <8>[   18.281568] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11263705_1.5.2.3.1>

    2023-08-11T14:01:10.046824  / # #

    2023-08-11T14:01:10.147587  export SHELL=3D/bin/sh

    2023-08-11T14:01:10.147761  #

    2023-08-11T14:01:10.248336  / # export SHELL=3D/bin/sh. /lava-11263705/=
environment

    2023-08-11T14:01:10.248968  =


    2023-08-11T14:01:10.350313  / # . /lava-11263705/environment/lava-11263=
705/bin/lava-test-runner /lava-11263705/1

    2023-08-11T14:01:10.351301  =


    2023-08-11T14:01:10.356362  / # /lava-11263705/bin/lava-test-runner /la=
va-11263705/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d641932ec404007a35b201

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64d641932ec404007a35b206
        failing since 113 days (last pass: v5.10.168-cip27-109-g23841ec76be=
c, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-11T14:11:47.114330  + set<8>[   20.254107] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11263788_1.5.2.3.1>

    2023-08-11T14:11:47.114762   +x

    2023-08-11T14:11:47.222092  / # #

    2023-08-11T14:11:47.324659  export SHELL=3D/bin/sh

    2023-08-11T14:11:47.325437  #

    2023-08-11T14:11:47.426947  / # export SHELL=3D/bin/sh. /lava-11263788/=
environment

    2023-08-11T14:11:47.427788  =


    2023-08-11T14:11:47.529299  / # . /lava-11263788/environment/lava-11263=
788/bin/lava-test-runner /lava-11263788/1

    2023-08-11T14:11:47.530454  =


    2023-08-11T14:11:47.535871  / # /lava-11263788/bin/lava-test-runner /la=
va-11263788/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64084dc5635c68135b226

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64d64084dc5635c68=
135b227
        new failure (last pass: v5.10.186-cip37-566-g36076316ef049) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d6449587a229b6c835b1de

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig/gcc-10/lab-=
broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig/gcc-10/lab-=
broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64d6449587a229b6c=
835b1df
        new failure (last pass: v5.10.186-cip37-566-g36076316ef049) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d63fe914ccba3b4e35b210

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64d63fe914ccba3b4=
e35b211
        failing since 14 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64449bd4ab8e82235b21b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64d64449bd4ab8e82=
235b21c
        failing since 14 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64452bd4ab8e82235b221

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig/gcc-10/lab-=
cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig/gcc-10/lab-=
cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64d64452bd4ab8e82=
235b222
        failing since 14 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64615250ed4f95335b242

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64d64615250ed4f95=
335b243
        new failure (last pass: v5.10.186-cip37-566-g36076316ef049) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64d645d6f155676e6135b1ee

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64d645d6f155676e6135b207
        failing since 113 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-11T14:29:36.337394  /lava-11263866/1/../bin/lava-test-case

    2023-08-11T14:29:36.376630  <8>[   37.281338] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64d645d6f155676e6135b208
        failing since 113 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-11T14:29:34.186861  <8>[   35.091163] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-08-11T14:29:35.246884  /lava-11263866/1/../bin/lava-test-case

    2023-08-11T14:29:35.281193  <8>[   36.186359] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

