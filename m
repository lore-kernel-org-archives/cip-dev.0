Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110E5C6FD1C
	for <webhook@archiver.kernel.org>; Fri, 24 Mar 2023 10:23:46 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web11.97391.1679653422009265678
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Mar 2023 03:23:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=qch5JJ9X;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so4588208pjb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Mar 2023 03:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679653421;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3FWX6yNuKLxZxJYOCzR0Ee+fNmFyZgmnIOaR/Mf2Jho=;
        b=qch5JJ9Xc9PhaaxC7Qt80Tz7SKFj+8quvb0gyCSMOLHpBliR4tfZbInvEXAxiw2uL5
         vJBcc1izxWLQkRRjvIqTwf47W+Lm/FSmZXNcl/Nq6/wDIMsIlgB1YVNQFRPxdHmAFsY9
         wW2GM/vXAIHX0alTxNj+FvtMxCa+2EymsRP2dbc367xFca+VMFt4MGEFymE4ghoVmE6v
         lFfBQumcvBhDLlQpxxF23nnZviTg7x7/2HCvqs1x0TKTF3l3siO1m0CccRTdcqqoUFWV
         jm0mgtqCr9xSWJxoUwv/HATlLd0zZLsSt64faGB4kz9L0PQPhQI5q4N1tcw4E8eeh+cM
         4ThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679653421;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3FWX6yNuKLxZxJYOCzR0Ee+fNmFyZgmnIOaR/Mf2Jho=;
        b=lQsRH6VsHAQ2QxIPJT5+FCXFwohOuN2F++6UWa0aQHAnWIEgXPkHNBiv1+fIQcgzhq
         9Y57QpoSEKLXJjT534vmzJySe8KmKMid4stdgbad/1n0/43HNk8nijt4PP0Q6CI5fXR6
         h5EF57uuHw7G6HE8QguD4HgYp9EXBXVRFNqBXRzqsHzpeJKbHuVYlJoFTCxbGgA9axmE
         aIdss9wUrMf2MKmslbKLpfb5VxxO9HmscA6MullQkLDbFDoJHVTKB04hka5Nw0C55lqK
         sRhhNz5NamFPte+r1L8A0oLwQ9NbYELTzv1hDTjmRyzrqqPV/HB/4Fel3YpNoG9P4d68
         8wMA==
X-Gm-Message-State: AAQBX9cdUAtxGICOpjTuiYF3wmGNTitsOi3635pt8rmyUJV2gdCmsNXK
	caxMNNoX7vHI+GPyh9ko3/zZ4QWZYcgbqjDJaofQEg==
X-Google-Smtp-Source: AKy350bsFs8xt6mi6d82qpbFggIr+gKRL59FaDATGEQGAehuR9q3aQMczNNHA9itdsPZb+H5Bf4ByA==
X-Received: by 2002:a17:90a:3:b0:23d:3931:7b49 with SMTP id 3-20020a17090a000300b0023d39317b49mr1890700pja.35.1679653421010;
        Fri, 24 Mar 2023 03:23:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x15-20020a17090a6b4f00b0023acdac248dsm2684870pjl.15.2023.03.24.03.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 03:23:40 -0700 (PDT)
Message-ID: <641d7a2c.170a0220.84255.4ca7@mx.google.com>
Date: Fri, 24 Mar 2023 03:23:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.176-cip30
Subject: cip/linux-5.10.y-cip ltp-timers: 14 runs,
 6 regressions (v5.10.176-cip30)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Mar 2023 10:23:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11114

cip/linux-5.10.y-cip ltp-timers: 14 runs, 6 regressions (v5.10.176-cip30)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.176-cip30/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.176-cip30
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      530cf8a4dace471f6e04e5887f4993ba1fcd3109

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  f3463a347c37b44bafdf4e882cfb932f6888905d =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/641d6cab42154f828b9c96bc

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/641d6cab421=
54f828b9c96c1
        failing since 41 days (last pass: v5.10.165-cip25, first fail: v5.1=
0.167-cip26) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/641d6cab421=
54f828b9c96c1
        failing since 41 days (last pass: v5.10.165-cip25, first fail: v5.1=
0.167-cip26) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/641d6f41527c987b149c95cd

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/641d6f41527=
c987b149c95d2
        failing since 140 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/641d6f41527=
c987b149c95d2
        failing since 140 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/641d714953f8c9ea0f9c9510

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/641d714953f=
8c9ea0f9c9515
        failing since 140 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/641d714953f=
8c9ea0f9c9515
        failing since 140 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =

 =20

