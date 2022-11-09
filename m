Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18529C43217
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 11:44:10 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web08.2256.1667994241636217201
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 09 Nov 2022 03:44:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=BrIYv9v7;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id p12so11347431plq.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 09 Nov 2022 03:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zsm629YcLXIpAY31Da72oAkjeq4p8vVldXYiD2r6/ic=;
        b=BrIYv9v7OwFtk7798KW6BBHxA6GpwC/cv48x5ViJQ/85R9N6Z7Qn7lIKa9YOoLTsxH
         JA2YS5sTh8lC8QYVOy+cmk0xeiivN7V9/ym2b2PaDNoBLy5Foq7HQHKAgyGD7ShhU9sw
         Xb1nxM0NF9JEeXWe04MMduu5QuFTu4zA0JwOUyJnR+WJ/fSIYUdsJ8UE/97yqIFTyS6x
         kGaHhxNMqFGeZpYEw6RBqWr6p4yDIJjqsshzCDocIMcMywAB/dGvYaH3HkjX71+RvzZc
         nlOn9/8zxE60RQjEetBvxfaZju31/6THE/IW8HcIC8Wtbjln1GpCSlZgfQ9x2ry6gocc
         JKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zsm629YcLXIpAY31Da72oAkjeq4p8vVldXYiD2r6/ic=;
        b=0T2O2qdl94iF9YfnK94fDTa53NkkSZbuTikNGtx9QCZzGk2k5XrAgRZHpeXlwXHpp1
         QyO2g7obbERHy7f8B1AU1SXfw1ckEgwoJUwhQmxNWswSQLfPUZIJgp+0erZoV5E8ocqi
         UIam5EwlVwmlWSd9zl6s8IwBAhoJH81vy0d7CKFjs7GE2GG/tjHrQNNO4LfCV33mNlf1
         r1A/Ke6LR/svyfayZbH2Lm0UnvkBDTcmx2SJDbB/y3uv4hC0+w3Y8fAulGgBF9rtxBaJ
         KtTsveNDiyVRIEC8Kxplui2lI7x99Vb0eamZVooLP/0up1znVvkFre96nEUYG+pOEagO
         chVw==
X-Gm-Message-State: ACrzQf0V/OqNTgedUlMabhDyqvVts1BheKLlny6jA0dRa1zJ7yjEhYNp
	ZfID/VgCx63jFySQakn8n11cZJmUkhPFD5Xg
X-Google-Smtp-Source: AMsMyM6d1cMcD9gifPlCfIWyC+hYMTWMnn9kDgZzv9+JFH9AZO1NK4aBGjG3x3P9cDTB7tQWQ6LmzQ==
X-Received: by 2002:a17:902:ea04:b0:187:4923:56f4 with SMTP id s4-20020a170902ea0400b00187492356f4mr38604089plg.97.1667994241011;
        Wed, 09 Nov 2022 03:44:01 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u14-20020a170903124e00b0018693643504sm8895279plh.40.2022.11.09.03.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 03:44:00 -0800 (PST)
Message-ID: <636b9280.170a0220.577b2.ecee@mx.google.com>
Date: Wed, 09 Nov 2022 03:44:00 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.153-cip19
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip ltp-timers: 7 runs,
 10 regressions (v5.10.153-cip19)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 11:44:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9963

cip/linux-5.10.y-cip ltp-timers: 7 runs, 10 regressions (v5.10.153-cip19)

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

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.153-cip19/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.153-cip19
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0f7fc281d55b27b299e8388c7d44809289ba8b99

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  b79157c8375cfdd2abfc59f63afe8ea09eaa8c5d =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/636b82d36df146d352e7db79

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636b82d36df=
146d352e7db7e
        failing since 5 days (last pass: v5.10.147-cip18, first fail: v5.10=
.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636b82d36df=
146d352e7db7e
        failing since 5 days (last pass: v5.10.147-cip18, first fail: v5.10=
.147-cip18-12-gcb2b164780be) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/636b86f3dc103bf9a8e7db70

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636b86f3dc1=
03bf9a8e7db75
        failing since 5 days (last pass: v5.10.147-cip18, first fail: v5.10=
.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636b86f3dc1=
03bf9a8e7db75
        failing since 5 days (last pass: v5.10.147-cip18, first fail: v5.10=
.147-cip18-12-gcb2b164780be) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/636b85b65581d5f268e7db4e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636b85b6558=
1d5f268e7db53
        failing since 5 days (last pass: v5.10.147-cip18, first fail: v5.10=
.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636b85b6558=
1d5f268e7db53
        failing since 5 days (last pass: v5.10.147-cip18, first fail: v5.10=
.147-cip18-12-gcb2b164780be) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/636b81a3815c5c830ee7db77

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636b81a3815=
c5c830ee7db7c
        failing since 5 days (last pass: v5.10.147-cip18, first fail: v5.10=
.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636b81a3815=
c5c830ee7db7c
        failing since 5 days (last pass: v5.10.147-cip18, first fail: v5.10=
.147-cip18-12-gcb2b164780be) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/636b85017d3de6ca48e7db4e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636b85017d3=
de6ca48e7db53
        failing since 5 days (last pass: v5.10.147-cip18, first fail: v5.10=
.147-cip18-12-gcb2b164780be)

    2022-11-09T10:46:10.665191     =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636b85017d3=
de6ca48e7db53
        failing since 5 days (last pass: v5.10.147-cip18, first fail: v5.10=
.147-cip18-12-gcb2b164780be)

    2022-11-09T10:46:10.665191     =

 =20

