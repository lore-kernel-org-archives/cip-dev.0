Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B1DC4167B
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 18:12:06 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web10.43383.1702059120845557353
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Dec 2023 10:12:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=VhIS3wuV;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6cea5548eb2so1947643b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 08 Dec 2023 10:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702059120; x=1702663920; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h4ueulUlY6dSfH4ISfBLo/kfPutD3nEZ4DomZriNyNc=;
        b=VhIS3wuV54+rY3/Utd6lQqoJSf8m/KHUaPjHZbtapVmDcrAmNEhDw7A3cxI5gvHnDw
         d06nrGc4A9mLCyI+nDwCE/OETF7rNfxNS7r81zxfMfMjP1rWtaTxvNPWpHuJBI9DnpBp
         aWDpqXvFcbJgpHwK8nuEF4OEh7XqVhBIrXHMG5f7m7XP6biElWLJ/7XIRfj0tBf6rCnM
         WAnff7eN964qZxs8EbOSCWbSrDDhPivIb6J/NirHVvOQfVtLkMzUwOsSdk+o41TfM0rn
         mtSh1jUtdzVSuoLlKwYOdhZaHHscRtXOpI9b9mLCYvvul/RepjcKcBjuppyMMgtTwm2c
         drOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702059120; x=1702663920;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h4ueulUlY6dSfH4ISfBLo/kfPutD3nEZ4DomZriNyNc=;
        b=PTgUGV7Cda6f5u99NOTgwualxzMvr3rEmR0PO+zHZWm+xGlR/pXV92oKxo4lZT/M+I
         rxE/QiK/L3MpH8Q11Cw62/ZkvQfyccXNlpJIWbKvvvVkisza+sg0+Px/DPWdYLFnPlQ2
         7OxUdBvUEtpbF5zLdeuzlCvToWbqw80dxtt0994goDcni/rGJnF7S/k5VAkJyjw0SQ9p
         HJbAX++LprZbTfPMp/qeo3EZQHJjDxmRnpnIplujMrHBb88PV+WIjTN0T68GTB76CbyB
         91YfhJrMHUf5HXkbWAkjbbGarLlN8WkKPJHcYApbCE+2gNu5GfWm0zECL7NUe9uZ0kWa
         rlYA==
X-Gm-Message-State: AOJu0Yw3C5vhoq5KII/yiKUAFfxP1nUl7strr/JyslhGudaI8bvuDQ9/
	hhdkAX6qgFJrLLGXXguCHIZW4AdmsYzkw0/OiMFWPw==
X-Google-Smtp-Source: AGHT+IFQH6iNt59yJuCFNJrI7Xif84VyJP0zIdHO5+sTqdPmUl7od04QOJVf1uiWTe96mDgcgP812w==
X-Received: by 2002:a05:6a21:3383:b0:18f:97c:8a32 with SMTP id yy3-20020a056a21338300b0018f097c8a32mr520282pzb.93.1702059119833;
        Fri, 08 Dec 2023 10:11:59 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y130-20020a62ce88000000b006ce9d2471c0sm1957040pfg.60.2023.12.08.10.11.59
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 10:11:59 -0800 (PST)
Message-ID: <65735c6f.620a0220.9d1a9.7048@mx.google.com>
Date: Fri, 08 Dec 2023 10:11:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-63-gfdfe1fbf93bc6
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 9 runs,
 1 regressions (v5.10.201-cip41-63-gfdfe1fbf93bc6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 18:12:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13989

cip-gitlab/ci/pavel/linux-test ltp-timers: 9 runs, 1 regressions (v5.10.201=
-cip41-63-gfdfe1fbf93bc6)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-cip41-63-gfdfe1fbf93bc6/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-cip41-63-gfdfe1fbf93bc6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      fdfe1fbf93bc6fe6ed2708f11c2613bef556fdeb

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/6573505c7c3cb7c2fde13480

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/riscv/defconfig/gcc-10/lab-collabora/ltp=
-timers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/riscv/defconfig/gcc-10/lab-collabora/ltp=
-timers-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6573505c7c3cb7c2fde=
13481
        new failure (last pass: v5.10.201-cip41-63-g2bc5a8583f4a8) =

 =20

