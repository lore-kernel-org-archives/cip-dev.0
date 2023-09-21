Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9FAE71090
	for <webhook@archiver.kernel.org>; Thu, 21 Sep 2023 15:45:44 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.21580.1695311137113794192
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Sep 2023 08:45:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=DFphCEvR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1c572c9c852so8722205ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 21 Sep 2023 08:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695311136; x=1695915936; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Kua7zT4n0vlEZb2NpRT5L02oqi46CEmpgt+9YZZL5zI=;
        b=DFphCEvRvu2ApMWungxWsQujXYIQX8v0YsvAwCg8lHRinihV49S36xCmH2utevihkc
         h6vKDhRP9eEsl4au5zbx3znlH8He3nR2qA2cFV/y4sHvrctha4caOOOl/sA0YzcTODVU
         Gm1fO4n408dc044AHJD29QOcm3jMXomwV187wIVgbhX+vEIrOi9iRz/PCc8k0/J6fCCB
         g1YgXuty3q/qBJfOrkrGIANEdSJIZZGGzNShB6lKej2/vYHzll2GlrZcj+8fapO0HGfm
         g8bUHEz77+4ZaryRZE7df+kA6/RToRx7HzJWMkxo5aI82p+FiIIMK52GmX/HPY1fV1S/
         2eLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695311136; x=1695915936;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kua7zT4n0vlEZb2NpRT5L02oqi46CEmpgt+9YZZL5zI=;
        b=EwLGTvzvQzXvjeB/RsgrpKWPtcwhzL517WJGK94mFT+PVqBQ1Ys255HrZxTJb5FSQK
         1ptJoxsmoBMbB0ePB2HzdrLEyoL02wlJwi/Vq+/Mei1D2azwVOYNNot0r3rQHQDbQ2/b
         uXSjEYReOIlo2K0Pq2k5yqt9Iaaflvuy2JukIho8N8PcElCCv+5smtxY9+u6+/1RMN9F
         7aXem1P1XBzneCzDQacmNxzOB+FHIMjhBq8NFZpZP7XcQiFE+F6oVvh4ubr3LeC2BPct
         lPh6ORJE1Tq06DABMnHNKb8IF51sPZ3bxA+1Os8AQAPFSM5WwJTO0wvQDZ0ezzpykZAx
         nA0A==
X-Gm-Message-State: AOJu0YyzSmF1ciBrkfj802jZqqSrrEhPx9kzby+82EcDyuT1Y3BMuOwq
	PRMYY6LmIQAQ6YN+PTClL3rKLtMknYND76wuui89kQ==
X-Google-Smtp-Source: AGHT+IFgdNiHFDUkjfFDCxACddVhvxx17pZuG8ZIOq2qjIFemXQ49CrHYd7S0JsDmG6BT37L6l1x7g==
X-Received: by 2002:a17:903:11c8:b0:1c3:d07f:3a09 with SMTP id q8-20020a17090311c800b001c3d07f3a09mr6712684plh.65.1695311135970;
        Thu, 21 Sep 2023 08:45:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jb22-20020a170903259600b001bd41b70b60sm1652986plb.45.2023.09.21.08.45.34
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 08:45:35 -0700 (PDT)
Message-ID: <650c651f.170a0220.918bd.4ab0@mx.google.com>
Date: Thu, 21 Sep 2023 08:45:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v6.1.54-cip6-101-gb060fea6ba099
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs,
 2 regressions (v6.1.54-cip6-101-gb060fea6ba099)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Sep 2023 15:45:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13204

cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs, 2 regressions (v6.1.54-c=
ip6-101-gb060fea6ba099)

Regressions Summary
-------------------

platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.54-cip6-101-gb060fea6ba099/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.54-cip6-101-gb060fea6ba099
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b060fea6ba09908b06e60cc84cbf201d2a71a711

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/650c5931d01edbc44d8a0a44

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/riscv/defconfig/gcc-10/lab-broonie/ltp-tim=
ers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/riscv/defconfig/gcc-10/lab-broonie/ltp-tim=
ers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/650c5931d01=
edbc44d8a0a49
        failing since 107 days (last pass: v6.1.26-1298-g61395b9756bd5, fir=
st fail: v5.10.180-cip34-26-gc198172c84b6a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/650c5931d01=
edbc44d8a0a49
        failing since 107 days (last pass: v6.1.26-1298-g61395b9756bd5, fir=
st fail: v5.10.180-cip34-26-gc198172c84b6a) =

 =20

