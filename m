Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3CAC4828F
	for <webhook@archiver.kernel.org>; Sun,  4 Feb 2024 05:40:36 +0000 (UTC)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
 by mx.groups.io with SMTP id smtpd.web10.33696.1707025230413118434
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 03 Feb 2024 21:40:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Q7ddtgA3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.48, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2196dd318f5so369924fac.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 03 Feb 2024 21:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707025229; x=1707630029; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WXplHvRIeJAzKx9cZuBZnPOy9SmImkW3Syor0n/yWcg=;
        b=Q7ddtgA3bfu3S/Z5Iy0azK7A3v1gLGbTz+vXAlLjtwbsDyLnzbtc1a/GeYhdXOihsy
         OmQaBHjeWIOqHLb4CTtfiOvPM3WCwgcOxxKmm3OLH8BSvsA7SCSkBWmv4xAd7USviAIg
         kMDx4OEkTEoAMINzDy9G8Yl+ZrB9IynSNzAiNHV3yIP/xCAfkp32KpDjh+okrFO5VNkj
         CyZxyaxCZJDSjXNK+lK1Z+ntSgO09XT1kEAakls1DrBQa54NqbBEeHIZ65xo8NyJa8ho
         ++3LYfS4AaXD+2XoIha6/L36C1jCdh7++6ntZQWFMcxrBIhZZ9Rnf67wr/yOmo53G/kx
         JovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707025229; x=1707630029;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXplHvRIeJAzKx9cZuBZnPOy9SmImkW3Syor0n/yWcg=;
        b=EuBgW4CvSfhAgP++Tp19w2WxpReKlzXBpI/SerOxTp4Lk3hpC6hI/rQeuFZozb7QTb
         lvhzeLnXt+JLuoQuyraZdPhW2H3RQiXo/wh0PLwPKaHQ3NeNHWkJOU5ehVG1rVpQfPDH
         5DGa1Bgz/zLuZoAPk/ttsnXsiYRtu2hJb7UTTzZxbv3E08Ny3zAvka0OHCZIC7gOPa6Y
         vlC9rERI6AZmPtiXtvavYhm8TIZU9xIQvudmILi/hlAqA9W3XUuOYN0jW/x3VF3iNjY+
         1OoeKsKrwPWHa/PJ1hAQzjSWoCaDspIvFsMX1LM/Ca5jn5kEMwmOOJRXz2epy6YLKTSs
         6qjw==
X-Gm-Message-State: AOJu0YxY9kaXYbYUqGNTmbUEmvmz6ZVamLo8oILYyEluDJyZLtwYaT9D
	UTxwOYip5n+EUwYKx0saZ+jY5e4pg742Ksh15QSr9OdhwrLbenCmNjIz48k5U2eB4UspvkdJNuw
	t4k4=
X-Google-Smtp-Source: AGHT+IFsnPyTev1/IpBzsrvILgW7GUFD1MnAHYlvwm+qL3NrY70dDaewP2GBqLFOX6ZDx/3ujv3yUQ==
X-Received: by 2002:a05:6358:ed0f:b0:178:cf5d:4372 with SMTP id hy15-20020a056358ed0f00b00178cf5d4372mr7414121rwb.5.1707025229244;
        Sat, 03 Feb 2024 21:40:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z5-20020a170902ee0500b001d9773a198esm3407481plb.201.2024.02.03.21.40.25
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 21:40:27 -0800 (PST)
Message-ID: <65bf234b.170a0220.44e60.ad9d@mx.google.com>
Date: Sat, 03 Feb 2024 21:40:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.75-cip14-132-g6e54756fbd6c2
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 19 runs,
 5 regressions (v6.1.75-cip14-132-g6e54756fbd6c2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 04 Feb 2024 05:40:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14652

cip-gitlab/ci/pavel/linux-test ltp-timers: 19 runs, 5 regressions (v6.1.75-=
cip14-132-g6e54756fbd6c2)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
             | regressions
-----------------------+--------+---------------+----------+---------------=
-------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defconf=
ig+x86-board | 2          =

qemu_riscv64           | riscv  | lab-broonie   | gcc-10   | defconfig     =
             | 2          =

rk3399-gru-kevin       | arm64  | lab-collabora | gcc-10   | defconfig+arm6=
4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.75-cip14-132-g6e54756fbd6c2/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.75-cip14-132-g6e54756fbd6c2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6e54756fbd6c2a85eb65a7be04700955d2e49b68

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
             | regressions
-----------------------+--------+---------------+----------+---------------=
-------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defconf=
ig+x86-board | 2          =


  Details:     https://kernelci.org/test/plan/id/65bf172ed821c719ef00a046

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/x86_64/x86_64_defconfig+x86-board/gcc-10/=
lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/x86_64/x86_64_defconfig+x86-board/gcc-10/=
lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65bf172ed82=
1c719ef00a04b
        new failure (last pass: v6.1.72-cip13-32-gf60d2e8cb51c) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65bf172ed82=
1c719ef00a04b
        new failure (last pass: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =



platform               | arch   | lab           | compiler | defconfig     =
             | regressions
-----------------------+--------+---------------+----------+---------------=
-------------+------------
qemu_riscv64           | riscv  | lab-broonie   | gcc-10   | defconfig     =
             | 2          =


  Details:     https://kernelci.org/test/plan/id/65bf113bf368cdbe1f00a03e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/riscv/defconfig/gcc-10/lab-broonie/ltp-ti=
mers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/riscv/defconfig/gcc-10/lab-broonie/ltp-ti=
mers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65bf113bf36=
8cdbe1f00a043
        failing since 52 days (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6=
, first fail: v5.10.201-cip41-77-g545d45774209f) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65bf113bf36=
8cdbe1f00a043
        failing since 52 days (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6=
, first fail: v5.10.201-cip41-77-g545d45774209f) =

 =



platform               | arch   | lab           | compiler | defconfig     =
             | regressions
-----------------------+--------+---------------+----------+---------------=
-------------+------------
rk3399-gru-kevin       | arm64  | lab-collabora | gcc-10   | defconfig+arm6=
4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf1edec49f6832f000a03a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65bf1edec49f6832f00=
0a03b
        new failure (last pass: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =20

