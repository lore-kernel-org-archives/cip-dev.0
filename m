Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05D4C41513
	for <webhook@archiver.kernel.org>; Wed,  9 Aug 2023 05:40:34 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
 by mx.groups.io with SMTP id smtpd.web11.82189.1691559625057737825
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 08 Aug 2023 22:40:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=eakfad9p;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.51, mailfrom: bot@kernelci.org)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6bd0a96e63dso957984a34.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 08 Aug 2023 22:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691559623; x=1692164423;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EHsxlRbA4/Wq6qxkszX7R0JXM2MBjMhC4UQ1wLdI0Mc=;
        b=eakfad9p+MVMDknczHHR4zf0fpdSGqLfJAvnLJ8V1MYOlfjCcaT9EMqNF2tQeUWAv9
         y05QsCx4obzcSI+qChcxX40SuINXWuiJemsLhSk7lqnTtlMtS1DNmxnLVNfxTTTMBWpW
         ebNmgMyiuYcGSFMQl+ia3I3h/aBYX5TM0KpIFrJj4Vmw9tq7SAZIMagTFmGwDXnpvaty
         oLsu571Gd7G0pTi0VaF3QqAPazbSOoHXQ+y9UXIV7xXLHu0jc8N2sMhzagme596Ik8El
         9MJeg/X6NABHkiSUHYhzhYlMMEqhFjyu+CGC82naPW1OEPwAzxoxv9Mk5m6fXVrKVAww
         RzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691559623; x=1692164423;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EHsxlRbA4/Wq6qxkszX7R0JXM2MBjMhC4UQ1wLdI0Mc=;
        b=UmMYesozFjnv2z4/ZGZHVOsaZf7Wt9gFJVHsPvi6renNUk8wd46SUAxtPVVzg0U7D4
         s9GYfaGc8VXoH0dDQCYZcKD0FcDNsZgMRiZ0dxtWadhqQGYqGIyc+dJ2l/5CcN/vboT6
         80sTI+TY355KxtuXD2UMFj4IAoN8kcWogFV+zQ8fFFiDEM7mlx4YoFhD0PR5wuWNNkfV
         cveWlIjUs4mnDbxR8oBR5bR4q2h/uha9cedsgMWXkdFW7QE4Ug2pJQjGAEj+QyT70Sr/
         XVIVaH3MdCyDcGvFAarqc1nwqasWMGM3/x9SxtDmgc9xS2BYc6je+w1Xr7uSnz90BwJ+
         6dyg==
X-Gm-Message-State: AOJu0YwKVvCL3LX1c7c/xpV/EijuJ4Udnmn0Vl1MPUDu+EiSJKLo6j19
	8gM7tO3x6gsmCRdm+j6tOrQ6eLiW1xZtgFAm0Gl3TA==
X-Google-Smtp-Source: AGHT+IFI96e1FWV7/WLFM8iBM3KlOjzR0f/sNVcT0QXof0wKrbyNcvXELPMj2bS+O7Ma8Hd5b+e/3g==
X-Received: by 2002:a9d:7c8e:0:b0:6b9:1ee7:5289 with SMTP id q14-20020a9d7c8e000000b006b91ee75289mr1793712otn.10.1691559623449;
        Tue, 08 Aug 2023 22:40:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c4-20020a631c44000000b005646e6634dcsm7477560pgm.83.2023.08.08.22.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 22:40:22 -0700 (PDT)
Message-ID: <64d326c6.630a0220.1652f.dba6@mx.google.com>
Date: Tue, 08 Aug 2023 22:40:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-13-g260094841fe1a
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip baseline-nfs: 25 runs,
 11 regressions (v5.10.186-cip37-13-g260094841fe1a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Aug 2023 05:40:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12578

cip/linux-5.10.y-cip baseline-nfs: 25 runs, 11 regressions (v5.10.186-cip37=
-13-g260094841fe1a)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.186-cip37-13-g260094841fe1a/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.186-cip37-13-g260094841fe1a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      260094841fe1a0a9e5ab7b9ae32450e8e4e0a4f4 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d320769a4639335d35b1ff

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64d320769a4639335d35b22a
        failing since 207 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-09T05:12:38.657292  <8>[   54.044769] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 40238_1.6.2.4.1>
    2023-08-09T05:12:38.772299  / # #
    2023-08-09T05:12:38.874961  export SHELL=3D/bin/sh
    2023-08-09T05:12:38.875756  #
    2023-08-09T05:12:38.978005  / # export SHELL=3D/bin/sh. /lava-40238/env=
ironment
    2023-08-09T05:12:38.978729  =

    2023-08-09T05:12:39.080909  / # . /lava-40238/environment/lava-40238/bi=
n/lava-test-runner /lava-40238/1
    2023-08-09T05:12:39.082063  =

    2023-08-09T05:12:39.086122  / # /lava-40238/bin/lava-test-runner /lava-=
40238/1
    2023-08-09T05:12:39.300998  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d3208d763b60dea335b203

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64d3208d763b60dea335b206
        failing since 207 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-09T05:12:48.123093  + set +x
    2023-08-09T05:12:48.127390  <8>[   46.655299] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 994721_1.6.2.4.1>
    2023-08-09T05:12:48.289271  #
    2023-08-09T05:12:48.392281  / # #export SHELL=3D/bin/sh
    2023-08-09T05:12:48.393008  =

    2023-08-09T05:12:48.494862  / # export SHELL=3D/bin/sh. /lava-994721/en=
vironment
    2023-08-09T05:12:48.495558  =

    2023-08-09T05:12:48.597374  / # . /lava-994721/environment/lava-994721/=
bin/lava-test-runner /lava-994721/1
    2023-08-09T05:12:48.598515  =

    2023-08-09T05:12:48.605136  / # /lava-994721/bin/lava-test-runner /lava=
-994721/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d31e1a95139a87c935b1dc

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64d31e1a95139a87c935b210
        failing since 207 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-09T05:02:51.492365  <8>[   47.445292] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 40226_1.6.2.4.1>
    2023-08-09T05:02:51.612413  / # #
    2023-08-09T05:02:51.715359  export SHELL=3D/bin/sh
    2023-08-09T05:02:51.716130  #
    2023-08-09T05:02:51.818544  / # export SHELL=3D/bin/sh. /lava-40226/env=
ironment
    2023-08-09T05:02:51.819283  =

    2023-08-09T05:02:51.921742  / # . /lava-40226/environment/lava-40226/bi=
n/lava-test-runner /lava-40226/1
    2023-08-09T05:02:51.922924  =

    2023-08-09T05:02:51.927519  / # /lava-40226/bin/lava-test-runner /lava-=
40226/1
    2023-08-09T05:02:52.198997  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d31dfb20df41c22235b25c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nf=
s-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nf=
s-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64d31dfb20df41c22235b25f
        failing since 207 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-09T05:02:27.175344  + set +x
    2023-08-09T05:02:27.177374  <8>[   39.943460] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 994714_1.6.2.4.1>
    2023-08-09T05:02:27.297446  / # #
    2023-08-09T05:02:27.399359  export SHELL=3D/bin/sh
    2023-08-09T05:02:27.399804  #
    2023-08-09T05:02:27.501187  / # export SHELL=3D/bin/sh. /lava-994714/en=
vironment
    2023-08-09T05:02:27.501633  =

    2023-08-09T05:02:27.603151  / # . /lava-994714/environment/lava-994714/=
bin/lava-test-runner /lava-994714/1
    2023-08-09T05:02:27.604032  =

    2023-08-09T05:02:27.605973  / # /lava-994714/bin/lava-test-runner /lava=
-994714/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d31b152e2b9cfaa335b22f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64d31b152e2b9cfaa335b234
        failing since 116 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-08-09T04:50:13.503303  + set<8>[   22.858287] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11241461_1.5.2.3.1>

    2023-08-09T04:50:13.503455   +x

    2023-08-09T04:50:13.607410  / # #

    2023-08-09T04:50:13.708036  export SHELL=3D/bin/sh

    2023-08-09T04:50:13.708221  #

    2023-08-09T04:50:13.808692  / # export SHELL=3D/bin/sh. /lava-11241461/=
environment

    2023-08-09T04:50:13.808874  =


    2023-08-09T04:50:13.909382  / # . /lava-11241461/environment/lava-11241=
461/bin/lava-test-runner /lava-11241461/1

    2023-08-09T04:50:13.909630  =


    2023-08-09T04:50:13.914258  / # /lava-11241461/bin/lava-test-runner /la=
va-11241461/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d31a9fb8f4c1613f35b268

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64d31a9fb8f4c1613f35b26d
        failing since 116 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-08-09T04:48:10.275124  <8>[   19.505222] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11241442_1.5.2.3.1>

    2023-08-09T04:48:10.278586  + set +x

    2023-08-09T04:48:10.382899  / # #

    2023-08-09T04:48:10.483826  export SHELL=3D/bin/sh

    2023-08-09T04:48:10.484075  #

    2023-08-09T04:48:10.584680  / # export SHELL=3D/bin/sh. /lava-11241442/=
environment

    2023-08-09T04:48:10.584977  =


    2023-08-09T04:48:10.685547  / # . /lava-11241442/environment/lava-11241=
442/bin/lava-test-runner /lava-11241442/1

    2023-08-09T04:48:10.686015  =


    2023-08-09T04:48:10.690764  / # /lava-11241442/bin/lava-test-runner /la=
va-11241442/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d32044705aa050fd35b205

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64d32044705aa050fd35b20a
        failing since 207 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-09T05:12:44.042464  / # #

    2023-08-09T05:12:44.144362  export SHELL=3D/bin/sh

    2023-08-09T05:12:44.144932  #

    2023-08-09T05:12:44.246055  / # export SHELL=3D/bin/sh. /lava-11241735/=
environment

    2023-08-09T05:12:44.246242  =


    2023-08-09T05:12:44.346778  / # . /lava-11241735/environment/lava-11241=
735/bin/lava-test-runner /lava-11241735/1

    2023-08-09T05:12:44.347061  =


    2023-08-09T05:12:44.351261  / # /lava-11241735/bin/lava-test-runner /la=
va-11241735/1

    2023-08-09T05:12:44.499979  + export TESTRUN_ID=3D1_bootrr

    2023-08-09T05:12:44.500081  + cd /lava-11241735/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d31a88a5199bb99235b22e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774=
a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774=
a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64d31a88a5199bb99=
235b22f
        failing since 14 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d31e5cec3dc36ef935b209

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64d31e5cec3dc36ef=
935b20a
        failing since 14 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64d31e85524f6afbba35b1e7

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64d31e85524f6afbba35b1ed
        failing since 139 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-08-09T05:04:55.564030  <8>[   96.626349] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-08-09T05:04:56.604440  /lava-11241648/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64d31e85524f6afbba35b1ee
        failing since 139 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-08-09T05:04:55.535512  /lava-11241648/1/../bin/lava-test-case
   =

 =20

