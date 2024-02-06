Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992ABC4828D
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 03:10:12 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.13863.1707189007257988102
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 19:10:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=b3Qx/ocZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d7232dcb3eso38521675ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 19:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707189006; x=1707793806; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2SeEkh58sZjfOKBLXpVJvLURp9CtT+VKxe4sVZyGyGk=;
        b=b3Qx/ocZCeojkZFRHqLSTflXYahkNk39Rxqbww3q7JiyQAqEYrGtrIW4MdIP9ItBLZ
         eKyhI8mDlLpTW3GoJVCJZSdY7ceeNtVwvO3ewnKlJpbNlOaEvuyYowo5xEX72E/cLCJo
         bfmQQzJInQQKOjKm3nf3nsHXt4EcMgagpn11MBZWtWtY/+UFC453wAAdmAL9ayTs76dd
         zV2qHBKl2X1OzMNXLS1ucdLVby90wB9V6Civ64wTOZ9PfbmYO0eAoZqPQna2GusgG+0R
         XCzvhfdyaq4dzA3H/4Lt6+qnwCdcVN4HZf/j0KlV2bhC23EMHzyy9nCs3aOwMCcfOB0T
         ShRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707189006; x=1707793806;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SeEkh58sZjfOKBLXpVJvLURp9CtT+VKxe4sVZyGyGk=;
        b=NJPfGehMg9zZGqUaS/eHR29hBtkfPYeqm5fKJ5mWUasuB6/q9/C8sklo3UInHG+OAm
         6SPCfcojEb6urKBZAGsFEZAwRi0fDxG1gCx5k111oFudUavThj1wr/W2m3dSAm82Rksh
         vmOwy+PwmVt95gdUAe4pBi+52p1FMEIUbPJQsQfBrsGQNpPmhyoxELk5STrMKs22IWtq
         m3x1Ugv/q7zRaDtsM16hWH+2rNA9hEO6hzcbUuXK+YoMjIoK7Aqh3bwkyEmtWOv/IpTb
         OAqv7J8uozWBpMBo8Gmyhin/Gl5Btiub48ckHgggVFZYN0L2sxHdk5X06yJlp6QTSIt5
         qAcA==
X-Gm-Message-State: AOJu0Yz2IHfUGsCGNiXjKlap1xV31bXqU975Pkc7Jsp+NCXwyCRd40HK
	gcoLrQBnPTiNH2TIq5aAoAOi6+zwORFbUvvaUWdlSl3XHQFfWlEwhQPu1eUAHUj9eHaXP/udTeD
	R
X-Google-Smtp-Source: AGHT+IEeMwIzTe9Cn64lCpaa57daJeZfuEKzW4jV2M3TYMz7/R8cKeHNRDLORsOw4HY0pWSJWOxENA==
X-Received: by 2002:a17:903:246:b0:1d6:fe11:2642 with SMTP id j6-20020a170903024600b001d6fe112642mr499238plh.27.1707189006080;
        Mon, 05 Feb 2024 19:10:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWDCGoBJqMKJgG8Fnp+jtJmvB05JxUUZ455DDMvGTeo/m5mICh9d8wjhAwSiKqgeU65BP6H3UQq8SxdL8GGjLmaHQid7glfKKT783VK7aUhj6szS4zuq4nTH1zNZivFjeFzIEQz8r0m5IBCldcuAVcPvw==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id mn12-20020a1709030a4c00b001d933201459sm638252plb.77.2024.02.05.19.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 19:10:05 -0800 (PST)
Message-ID: <65c1a30d.170a0220.e37ba.2ec9@mx.google.com>
Date: Mon, 05 Feb 2024 19:10:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.209-cip44-rt18
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt ltp-ipc: 28 runs,
 4 regressions (v5.10.209-cip44-rt18)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 03:10:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14769

cip/linux-5.10.y-cip-rt ltp-ipc: 28 runs, 4 regressions (v5.10.209-cip44-rt=
18)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+preempt_rt | 1          =

qemu_smp8_riscv64            | riscv | lab-collabora | gcc-10   | defconfig=
+preempt_rt | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+preempt_rt | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
            | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.209-cip44-rt18/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.209-cip44-rt18
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d814befd12dcf6c81b483cb36f507d70112c1097

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1963a6e967f1aed00a047

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/ltp-ipc-meson-=
gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/ltp-ipc-meson-=
gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65c1963a6e967f1aed00a0=
48
        failing since 74 days (last pass: v5.10.184-cip36-rt14, first fail:=
 v5.10.201-cip41-rt17) =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
qemu_smp8_riscv64            | riscv | lab-collabora | gcc-10   | defconfig=
+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1918bbbfc07206000a0a1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/riscv/defconfig+preempt_rt/gcc-10/lab-collabora/ltp-ipc-qemu=
_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/riscv/defconfig+preempt_rt/gcc-10/lab-collabora/ltp-ipc-qemu=
_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65c1918bbbfc07206000a0=
a2
        new failure (last pass: v5.10.201-cip41-rt17) =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65c196dd1c9ea447e300a03e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig+preempt_rt/gcc-10/lab-cip/ltp-ipc-r8a774a1-h=
ihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig+preempt_rt/gcc-10/lab-cip/ltp-ipc-r8a774a1-h=
ihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65c196dd1c9ea447e300a0=
3f
        failing since 74 days (last pass: v5.10.184-cip36-rt14, first fail:=
 v5.10.201-cip41-rt17) =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65c19a4cee09543fc000a03d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m=
-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m=
-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65c19a4cee09543fc000a0=
3e
        failing since 74 days (last pass: v5.10.179-cip32-rt13, first fail:=
 v5.10.201-cip41-rt17) =

 =20

