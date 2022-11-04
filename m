Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5EBC4167D
	for <webhook@archiver.kernel.org>; Fri,  4 Nov 2022 09:23:49 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web09.9152.1667553827278765364
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 04 Nov 2022 02:23:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=xN+wd6C0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.171, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f171.google.com with SMTP id s196so3901456pgs.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 04 Nov 2022 02:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QmXqnLxyuWgnG9TE4DHlgB116ZFNjk3V3nQ6I5CW2fI=;
        b=xN+wd6C02xRqIS9+3SwYJA/D7mGJfqXm+rKwa1yWEMJXZ7lSczi7tLy4B8+E7G9w7E
         UQCHmnEpLhPzmTpF0kvKJo9oNj+C0ambMuekKTrS/TJVXMpPSMQ3ds6MC51MnqtZZ7sg
         XDHpU2Q73oTTjp718GPTu4ku1+VvWBZqOkBYD5vgv+LghT8RWn7V4G4P5axyJz2MRRqN
         HCJbRbMKxIaLuyHK4sD7uZE9lDOqFFN+aUuuBxvSYsoCXoTrvCTLJTEvZzRwbaC5+wOS
         YBAKHmLCwzVfWKVTBHv/enTaNAwhWyLTnM8oGwd14MYippg6pkjPdixNS/c/ON2qwKLm
         29GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QmXqnLxyuWgnG9TE4DHlgB116ZFNjk3V3nQ6I5CW2fI=;
        b=aQujGI2cQgWdGCwXAa2Y74xKfwSP6746rottttWeT4Q+9dcgVTxi4RmfJBLQUAfaBH
         YnTik63h48dI8xlKrJJL341DTgQKmjSe6FRhpuQ9NT3WiWNvNUJYnydeA1IrhP/S4QH/
         XJdK2HaBi8qVWRFbK+Npz0zXNGn5ogDec4/49hBzwjHkqTJLsJuajgGjEGlsNsbsQiZ1
         gL1+4TKb4SRwCbml+VeXe9bP27agdOb6iLKl9CpRnC2ikXJvoKyDy1oN4Uj6XnPCPodw
         ckOuivwSxtZv2ed/tfzHr9jsmj212iVCkyTxiEMIKs2ecmFHK2hB2Mix9IYBWM9egtcx
         fMMA==
X-Gm-Message-State: ACrzQf2G5Hg5FDF5vNEjTpcrn/38E+m5EZb9Fi2ySyAdPFQ+lFk3Rg7a
	auK5EpD5nPO1R14m4Cpx6Fp0hmdCuKi0hw==
X-Google-Smtp-Source: AMsMyM7oWjkh1ysgQDjanJ2F9PfNvcI+takUUvNhxwoZ5V0X/kzdzTh0G8VhvVKms5kNGb4paWsPgw==
X-Received: by 2002:a63:5b58:0:b0:452:2ba4:f86b with SMTP id l24-20020a635b58000000b004522ba4f86bmr29145422pgm.223.1667553826637;
        Fri, 04 Nov 2022 02:23:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z19-20020a630a53000000b0046fe244ed6esm2021719pgk.23.2022.11.04.02.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 02:23:46 -0700 (PDT)
Message-ID: <6364da22.630a0220.68341.3819@mx.google.com>
Date: Fri, 04 Nov 2022 02:23:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-12-gcb2b164780be
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip ltp-timers: 5 runs,
 8 regressions (v5.10.147-cip18-12-gcb2b164780be)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Nov 2022 09:23:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9932

cip/linux-5.10.y-cip ltp-timers: 5 runs, 8 regressions (v5.10.147-cip18-12-=
gcb2b164780be)

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

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.147-cip18-12-gcb2b164780be/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.147-cip18-12-gcb2b164780be
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      cb2b164780beff6c4be7ccfd9020e39c07c44f3c

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


  Details:     https://kernelci.org/test/plan/id/6364c9c0f941ebe1ebe7dbef

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6364c9c0f94=
1ebe1ebe7dbf4
        new failure (last pass: v5.10.147-cip18) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6364c9c0f94=
1ebe1ebe7dbf4
        new failure (last pass: v5.10.147-cip18) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6364c8ea9109dc71eee7db4e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6364c8ea910=
9dc71eee7db53
        new failure (last pass: v5.10.147-cip18) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6364c8ea910=
9dc71eee7db53
        new failure (last pass: v5.10.147-cip18) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6364c84000a7c9903ce7db67

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6364c84000a=
7c9903ce7db6c
        new failure (last pass: v5.10.147-cip18) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6364c84000a=
7c9903ce7db6c
        new failure (last pass: v5.10.147-cip18) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6364ca85de7f237323e7db76

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6364ca85de7=
f237323e7db7b
        new failure (last pass: v5.10.147-cip18) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6364ca85de7=
f237323e7db7b
        new failure (last pass: v5.10.147-cip18) =

 =20

