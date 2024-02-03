Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED89C4828F
	for <webhook@archiver.kernel.org>; Sat,  3 Feb 2024 08:10:50 +0000 (UTC)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
 by mx.groups.io with SMTP id smtpd.web11.13532.1706947846675125272
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 03 Feb 2024 00:10:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=rxX8ZfnS;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.179, mailfrom: bot@kernelci.org)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3637fb0bd6cso9839605ab.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 03 Feb 2024 00:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706947845; x=1707552645; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rUuYKvR0zuNvacmIAEBql8G0/jdkmtI9pEo2M7UpKyQ=;
        b=rxX8ZfnSYPLTDdwhn3co777fW0/Yh8a/CDWtdMPOcB+4gC8wsPBmXyZp3jPQaBFFbB
         twXD8gwI+cxNzg0bUQG1ZYStzdMjpW63oErJ6p7yJIvAUIFogk5V9Q+Sf3eZ+FjalbW4
         lZ24QCvMEoHfa2L9RVPs8hddV94mf4/trsoPGMoT/kjdIEL3W99hphRpqdgx2brupKiy
         kIfvwYmFfQFpaNPA9Dt4YGkxZv98Sld0vOhI746DTKJW/Oz09BRgCSodU33KjpKI6jWT
         5Sa+NzsY8wGPcyBPFQHM80nlb9HQVlVVaEjmm+yDHA1Q8IvoPtPqHaOReNyiWZWcTaBQ
         0ZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706947845; x=1707552645;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rUuYKvR0zuNvacmIAEBql8G0/jdkmtI9pEo2M7UpKyQ=;
        b=MXOifp7UnA502H4qTOl/yVxejzQTuBbYFRsa2zdB+GV2hQVZOf956WQv/xH1IjmN7z
         is9tbdqJhUyBGoPKIT9Ax6qe++Oj1iK9v3O9XGl9/YPEobGbFjN3HfMDJIqhPNdx/gBy
         TIdnWBEgJHUOTpXygq6qDmKVyxKykgTuEL/hTdB0tEpfGNNgFi23IQN4MvYjagYTzuxk
         OCS/UtJzSyI/miiYxemJSqSABrqDGUEyCnR2GoPu2Kj6EvBYvaENmL3ALef6wbrrVV9b
         unYwRJnAOMZLNIw1ShiOpzi/EHeXrLq/kzr/WnrkkJth24VlBqMoEA2lM0gh9GMbiOFy
         cyOQ==
X-Gm-Message-State: AOJu0Ywc84AI/1q2KY4u70LKK48w6WnVC+nB+ihsHzviiKJzfwl0WrUA
	7BwZy9V0A9SEKIjKapCRUJvGl9myyOLCy2cfS1OB9jxG7btZ2aR0lwKUWR6qZwZE3Ex8OFxBkHN
	dGUWXEQ==
X-Google-Smtp-Source: AGHT+IFFnehzv0BTsUt7RK1jtH5DMbyjJMRHKe7/Q4SQAkzBgYgyAkE2iubuuCCWpGvtLZcfWi3RZw==
X-Received: by 2002:a92:dc06:0:b0:363:8077:e8f8 with SMTP id t6-20020a92dc06000000b003638077e8f8mr11989954iln.10.1706947845332;
        Sat, 03 Feb 2024 00:10:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUJnI+GFc+wnmh+yvUrDIyOnZV9Hqqdlj04roaNqWxW0nezzzZc7iAALldawMPH1mh+0wvULcwdM+ZzsqNZE5h7ATI5IgD/uaAhuQOqSLZP/7WWlUrJ1BAxgaRhRQDif2A5auS0bnufWd85BKyeOJxm+Q==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h4-20020a635304000000b0058ee60f8e4dsm2971773pgb.34.2024.02.03.00.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 00:10:44 -0800 (PST)
Message-ID: <65bdf504.630a0220.d6a37.c144@mx.google.com>
Date: Sat, 03 Feb 2024 00:10:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Kernel: v6.1.75-cip14
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip ltp-timers: 18 runs, 5 regressions (v6.1.75-cip14)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 03 Feb 2024 08:10:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14642

cip/linux-6.1.y-cip ltp-timers: 18 runs, 5 regressions (v6.1.75-cip14)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 3          =

qemu_smp8_riscv64            | riscv | lab-broonie | gcc-10   | defconfig  =
                | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.75-cip14/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.75-cip14
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f555c0a7ff8af9ddf857352bab79675e17c358ec

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 3          =


  Details:     https://kernelci.org/test/plan/id/65bdec1e78104fb50d00a03b

  Results:     31 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.75-ci=
p14/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/ltp-timers-meson-gx=
l-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.75-ci=
p14/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/ltp-timers-meson-gx=
l-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65bdec1e781=
04fb50d00a040
        failing since 1 day (last pass: v6.1.72-cip13-30-g79e2886a5da69, fi=
rst fail: v6.1.72-cip13-31-g9539320ac89dc) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65bdec1e781=
04fb50d00a040
        failing since 1 day (last pass: v6.1.72-cip13-30-g79e2886a5da69, fi=
rst fail: v6.1.72-cip13-31-g9539320ac89dc) =


  * ltp-timers.timer_getoverrun: https://kernelci.org/test/case/id/65bdec1e=
78104fb50d00a050
        new failure (last pass: v6.1.72-cip13-31-g9539320ac89dc) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
qemu_smp8_riscv64            | riscv | lab-broonie | gcc-10   | defconfig  =
                | 2          =


  Details:     https://kernelci.org/test/plan/id/65bde65e352db3c1e100a131

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.75-ci=
p14/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.75-ci=
p14/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65bde65e352=
db3c1e100a136
        failing since 40 days (last pass: v6.1.66-cip11-1-g2d3d776d703d7, f=
irst fail: v6.1.67-cip12) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65bde65e352=
db3c1e100a136
        failing since 40 days (last pass: v6.1.66-cip11-1-g2d3d776d703d7, f=
irst fail: v6.1.67-cip12) =

 =20

