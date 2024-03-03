Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0A3C48BF6
	for <webhook@archiver.kernel.org>; Sun,  3 Mar 2024 21:43:35 +0000 (UTC)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
 by mx.groups.io with SMTP id smtpd.web10.83879.1709502209475530715
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 03 Mar 2024 13:43:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=oECICnH7;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.52, mailfrom: bot@kernelci.org)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e49812ba77so1972854a34.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 03 Mar 2024 13:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709502208; x=1710107008; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9p1ftAf8L5k20L+rcXsVnAVQqGwYWatGBPMDjCbpKaw=;
        b=oECICnH7M14L9acJmfrpQ9aDkVnPqq8vc9Jv8G5HVCQitEvbcDSVgNsZECfeXUdo4Y
         b/IUxj9/wMReK6vRnKPeoORuCrP1GkWKtvdhRt1RvU5+//Ysr5CtZ9gYjdP3s+crOgRN
         nOqu2HUQW8p9sh15uAKKM1MrL0eH7df6gbGrGvOpF9utQHHKWenpyjFzCumwOQW53uLV
         M0cmAq9UrFygfoDUBwjDz68qW1pJDM6QrN4ge5ihXxhsOLvxz2TQTpeF0KcugIozjIOD
         O/v+thTgD1XIfZD5YMhFlCJywTSfEmrsX7WN4gIm56pnh1K2BSCMlHEy/9891cQIwkLt
         Yhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709502208; x=1710107008;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9p1ftAf8L5k20L+rcXsVnAVQqGwYWatGBPMDjCbpKaw=;
        b=uchNeau2YiymLNOlLRRpWVQX/+YUPdghvE+LqKkcGTdXSr5fxo2D6WYGSQrMHKXZjj
         yp7K9Gse6iwZvHYv7FRnDL6oDyK8CzJugRTZUZUg+vxs94Dexzx2Sz3XzbRbj5J9xJ4a
         K388lTyUrsPtuhDmDTWBIVhpg1ybu3LFRApSv0Fh0fNCGp1rKDf9AA+Bn4nP7TCAxfIv
         wJSJ26hdTnJ/LcT3DlNrEfM+3yYs/ic9sjRiILUda/Xk3rN4biRUPiPf8hmtT1iltGNq
         b7ZrA78axMi4bd1PY6Sz2vfgJ990dosrYldPMRX/b6zH79nzhzNoavuTHjvxSsLQ6XDV
         vVJw==
X-Gm-Message-State: AOJu0YzEXu5L0ZbIwfnlPTPxhveSY/2yIVnm5pU/1PRvS/zniI0Y8VIK
	7Klhoc44QxugXI3wPKhaOj9gxSppeg3RttZbK1gM5D67VsL2i3joppoKAMucOOXqBoGgIR61//M
	QmQ4=
X-Google-Smtp-Source: AGHT+IFQDbGtO9zmiuZ9o6lVAAuUnFJPICE9XAvKi138XzIbfm1TGeB60QUwIZ/QNX1ACGsDowgJXA==
X-Received: by 2002:a9d:73ce:0:b0:6e4:dccf:8abe with SMTP id m14-20020a9d73ce000000b006e4dccf8abemr4526734otk.24.1709502208135;
        Sun, 03 Mar 2024 13:43:28 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l1-20020a170903244100b001dc10796951sm7060984pls.19.2024.03.03.13.43.27
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 13:43:27 -0800 (PST)
Message-ID: <65e4eeff.170a0220.17c01.b5c0@mx.google.com>
Date: Sun, 03 Mar 2024 13:43:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.78-cip15-547-gb5450675e67c
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 17 runs,
 3 regressions (v6.1.78-cip15-547-gb5450675e67c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 03 Mar 2024 21:43:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15185

cip-gitlab/ci/pavel/linux-test ltp-timers: 17 runs, 3 regressions (v6.1.78-=
cip15-547-gb5450675e67c)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =

qemu_riscv64             | riscv  | lab-broonie   | gcc-10   | defconfig   =
               | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.78-cip15-547-gb5450675e67c/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.78-cip15-547-gb5450675e67c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b5450675e67cda5a44ee81ea4d17ab5db9b7deff =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4e51072b2a4fb8e637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/amd64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-timers.login: https://kernelci.org/test/case/id/65e4e51072b2a4fb8e6=
37013
        new failure (last pass: v6.1.78-cip15-404-gdddfc5d4f194) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
qemu_riscv64             | riscv  | lab-broonie   | gcc-10   | defconfig   =
               | 2          =


  Details:     https://kernelci.org/test/plan/id/65e4dc0bdc2d9e98cd637015

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/riscv/defconfig/gcc-10/lab-broonie/ltp-tim=
ers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/riscv/defconfig/gcc-10/lab-broonie/ltp-tim=
ers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65e4dc0bdc2=
d9e98cd63701a
        new failure (last pass: v6.1.78-cip15-404-gdddfc5d4f194) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65e4dc0bdc2=
d9e98cd63701a
        new failure (last pass: v6.1.78-cip15-404-gdddfc5d4f194) =

 =20

