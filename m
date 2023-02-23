Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47159C61DA4
	for <webhook@archiver.kernel.org>; Thu, 23 Feb 2023 23:17:55 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web10.4804.1677194272747588063
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 23 Feb 2023 15:17:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ZLKkhpIX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id qi12-20020a17090b274c00b002341621377cso971230pjb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 23 Feb 2023 15:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o2aRuVP+P5xs95MBTfvSZ1gZP/2B1/spqACBK/a3BlY=;
        b=ZLKkhpIXULfwCR+EYgCPnw4dykchq5D2pupul0l0wWVdZBmDlVAHKNgrD9DMq/eT82
         S/lVAUNZ+/eaiKWNEaxkmUBWKMsMxPFJOB4rNCU7GO7yQzMg2XWTkCfjmlhUf2A1jOD/
         eZMvb73JZtetGhbrK3338ryTd+pikRcEeu6pIS4kZ58o97+DiUALCJRFRR2WlilRHGfK
         O5kr1ECppTpEQpFK1HKPVrb3nY/A96LmOqil3WAdx1hCg6aw+N1z8yIQc1v9MY0OY21f
         137B5b51QiCXEvbD2x9yes8i69pcp2kobDcRneNdstcYYjHK6OPrPm+lGXBnuorGPMCX
         ncIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o2aRuVP+P5xs95MBTfvSZ1gZP/2B1/spqACBK/a3BlY=;
        b=YjtOXBAFjsvRb+k7HhTyXx23yoqwCSj9GSDHz3KDvDlvIeGio8GU1mTF+1j9HE/ys8
         eoKgE2i1HNBiWpzHFZrX2k2kMkzdtadMoMP2/egrhHgjZoYjO9nfQ+bvlspBysfSzXii
         XgtdF9/EgzMNV7Z7Wy1nPwfVC3ngYcuU16eE3sgZvvuw8P+a5++G67D4SM0v8OMXIv3g
         G2IRDLy8o6h3ytJ4Hw0wSq+isIsjHup+YxaU6WYjssFS5BfjUFKQv9+4z3G9F7TBa5Wy
         K433k2J/mbI0oVVxi00i4rwFVmWMKGvXNpjLarj8XjYj9bTipOzRLUeO24Rz3F8QY+52
         5gNQ==
X-Gm-Message-State: AO0yUKUUiVQcpRxnwCMcx1j4KOU/ox4eEBmiY6Im8f+Xv8bfzixRWxZM
	jzrP6dGhwt5BToYrhtlNlyjS1bOxs9EIfpU2r6M=
X-Google-Smtp-Source: AK7set89E+nIN3/2feOWFKJdr5muDmzeLJnz3ZgfaPxyljpG9duxAyHOupd0hcdDYJMh5IWTUgqycw==
X-Received: by 2002:a17:902:f683:b0:19a:7604:f265 with SMTP id l3-20020a170902f68300b0019a7604f265mr17379660plg.39.1677194271943;
        Thu, 23 Feb 2023 15:17:51 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x24-20020a170902821800b001947222676csm8133099pln.249.2023.02.23.15.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 15:17:51 -0800 (PST)
Message-ID: <63f7f41f.170a0220.94364.05c7@mx.google.com>
Date: Thu, 23 Feb 2023 15:17:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.167-cip26-2-g1e87e7748b91
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-timers: 6 runs,
 8 regressions (v5.10.167-cip26-2-g1e87e7748b91)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Feb 2023 23:17:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10804

cip/linux-5.10.y-cip ltp-timers: 6 runs, 8 regressions (v5.10.167-cip26-2-g=
1e87e7748b91)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.167-cip26-2-g1e87e7748b91/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.167-cip26-2-g1e87e7748b91
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1e87e7748b91cc6ec7f9f32d6d156ee15f651805

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  86f0584539eb1567f009f3e38be6940830649b92 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63f7e4bcb9473f7b5d8c8638

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f7e4bcb94=
73f7b5d8c863d
        failing since 69 days (last pass: v5.10.158-cip22, first fail: v5.1=
0.158-cip22-7-g92462fd9830b) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f7e4bcb94=
73f7b5d8c863d
        failing since 69 days (last pass: v5.10.158-cip22, first fail: v5.1=
0.158-cip22-7-g92462fd9830b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63f7e496ecc64c5fd08c862f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f7e496ecc=
64c5fd08c8634
        failing since 23 days (last pass: v5.10.162-cip24, first fail: v5.1=
0.165-cip25) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f7e496ecc=
64c5fd08c8634
        failing since 23 days (last pass: v5.10.162-cip24, first fail: v5.1=
0.165-cip25) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63f7f1fd90b6ae861b8c8656

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f7f1fd90b=
6ae861b8c865b
        failing since 13 days (last pass: v5.10.165-cip25, first fail: v5.1=
0.167-cip26) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f7f1fd90b=
6ae861b8c865b
        failing since 13 days (last pass: v5.10.165-cip25, first fail: v5.1=
0.167-cip26) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/63f7e9bc5aa8bb2db58c86a1

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f7e9bc5aa=
8bb2db58c86a6
        failing since 111 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f7e9bc5aa=
8bb2db58c86a6
        failing since 111 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =

 =20

