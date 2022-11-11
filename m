Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C12FC4332F
	for <webhook@archiver.kernel.org>; Fri, 11 Nov 2022 04:57:21 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web11.2120.1668142631365106858
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 10 Nov 2022 20:57:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=gqKGDZXG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.182, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f182.google.com with SMTP id e129so3519435pgc.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 10 Nov 2022 20:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G7tEVRr2SArbfGF2BnlPQNTKu2SGQisAXiBLGt/+460=;
        b=gqKGDZXGARUhp7mss5vI1U5+0PyRd5ihSv6cKgmqz3bUkS6wr04YcO3Ym/ZGtnCRbw
         083qjd9jQtRyIQMxOLX3tduZ3bpMZD579j5Q0IEcfPUzkMp3k70ntH7VMYGIE+/nqUln
         +1UaLQDpdTNuNWAuxV3ttWC7ji9vFEmeZoz390XscJtsnaTIV+HsqldDVR19+QPXA6XF
         uky+d7omLOlCKyrnygOXC5+svLu/7SD96PNTqZXmLdHfNAm7tQ9PR5PpwacqrF7s+Llq
         Lm/eXitOhnI8xHqjfq65ywgYx/OB1RjNZ9YBPYORnsrgmeyGxBIF02eJE5I3RllQ3gFh
         GF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7tEVRr2SArbfGF2BnlPQNTKu2SGQisAXiBLGt/+460=;
        b=h5pFsedcU1Q7VDigJOhAaWaZOoA1tm46QQmwEvJ4kInzVM0LGBxwSUoTeLRbzCILCH
         ZgsXvMFBYKuiV73CagIyd+62Youv1VcjhhyVZjoxTEmBNsj6UMEnCWL0E6rgYUsApv6c
         Nu1Fhys9kzO6Aev1U5bUg7HM/RCii2Nw4UC+x9H5qCW6VsWW/GwiBrkfSyeoIG693bkt
         +GA+hLt5mM5EQVojR+nmogWTxW4zDBFUsru8SKs+s2+GwUmGqlTgjEe4S+wAA+V1cvcq
         Vaicx0QGisEnClfufqq14mk8I4cCHnPUMCmbrzAKvKhPOp6NOspsFWdMBVlUjLgBj/7G
         XjUw==
X-Gm-Message-State: ANoB5pmlEKdWF5jRoHRzdByQ5aoKG1PF7y+SzpTkXamw59aovx2sirjl
	WRD/uGudb3iUxKj5oNtTqlTkNztN0vOjMW/TE7U=
X-Google-Smtp-Source: AA0mqf4/z4PjA2CabP+JGGB8xosgeOaFXHW8twyMUJburaVAw891Tk/dgJ9TOMP7sm2MIRwKcPTLxg==
X-Received: by 2002:a62:6dc4:0:b0:56b:c616:287 with SMTP id i187-20020a626dc4000000b0056bc6160287mr877791pfc.73.1668142631849;
        Thu, 10 Nov 2022 20:57:11 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x66-20020a626345000000b0053e4296e1d3sm539629pfb.198.2022.11.10.20.57.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 20:57:11 -0800 (PST)
Message-ID: <636dd627.620a0220.1f6a8.10bb@mx.google.com>
Date: Thu, 10 Nov 2022 20:57:11 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.153-cip19-122-g149fbc7cd21d
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 3 runs,
 4 regressions (v5.10.153-cip19-122-g149fbc7cd21d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Nov 2022 04:57:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10018

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 3 runs, 4 regression=
s (v5.10.153-cip19-122-g149fbc7cd21d)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.153-cip19-122-g149fbc7cd21d/plan/ltp-time=
rs/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.153-cip19-122-g149fbc7cd21d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      149fbc7cd21d7e3a412f88c0e29d060f55e237f6

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


  Details:     https://kernelci.org/test/plan/id/636dcde5448bb69488e7db53

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.153-cip19-122-g149fbc7cd21d/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.153-cip19-122-g149fbc7cd21d/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636dcde5448=
bb69488e7db58
        failing since 15 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636dcde5448=
bb69488e7db58
        failing since 15 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/636dcfc7489476cd5ee7db74

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.153-cip19-122-g149fbc7cd21d/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.153-cip19-122-g149fbc7cd21d/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636dcfc7489=
476cd5ee7db79
        failing since 15 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06)

    2022-11-11T04:29:45.458147     =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636dcfc7489=
476cd5ee7db79
        failing since 15 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06)

    2022-11-11T04:29:45.458147     =

 =20

