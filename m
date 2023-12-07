Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D7CC4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 13:27:56 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web11.83529.1701955671631682641
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 05:27:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=h2WqjYta;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.172, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5c21e185df5so727729a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 05:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701955670; x=1702560470; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HAo3hnze0+tAVoB/fsRV5CIZhSUjClmTNeBIyi8aDoM=;
        b=h2WqjYtagz4A162wjFTfc+vp3urMUTdnqM4RS9d2V6VIFBeKRLx/9t+aYi437W9Odr
         UVL2NQm9xgI2psmmBjFLyn9LXmJBPLrV6EY8oSWoq4XGXovrTuNidCA/jBOKrrc1rP8A
         Sp7YVAKKgs5vyxzvZ1hRTUQQ+4DDFRQFBfNz+VZnH8UlQ4jpRMzmYgg37hJ6nCaAVj4S
         Tf5oD05nyEV7qGos3iSMEJOcmor8/mgUv1/xxKXG3ABzsrygldNrSVAG8taN0wROZ5b5
         hjjeVoAb0a+eCGIMpfcqxCUbiZYYDe1PohJCWi9PdEDGRDvEA+keNTK/YT5rypitKpF0
         R3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701955670; x=1702560470;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAo3hnze0+tAVoB/fsRV5CIZhSUjClmTNeBIyi8aDoM=;
        b=W8fdeu8eMgjNIFVdV9awbpuRfM3qQslHbBzYp4yeo1nOHDdyKk1CvQMV5SR1lftGzg
         8uXLPTJp12WjMiG2JyoRumEJmseQOkXS9oDvjeKe3qZaLBlOUkVFLlaGgcCzswQrrns4
         O+DOFeW5mkEU7snsI7v5HQnGvDYlikhbaBWBkVTru5mN4hVl9MzNybr8EV1JKvthmjet
         LDUMrnz69d7eAUfQhvF8OMlH71ywGW7gDTbTAXS+9Ay8GozqnpUZyxYtrJD4Ap1R/jFf
         S/aCEZjyPR/76lBM4sg26CrZp1s9yTmCh7/Sc1FU6rNtIyY/KME99gBHi4yiuEPzrnaT
         9x2w==
X-Gm-Message-State: AOJu0YwzIA4ZCRlRaXuKbxo73DJRxLWiHXty4Pa9ajQ/q+1vpnBnQL0L
	Rz3r7jhgu+0hm4NqxXIg8Rg841qIHGxUlINUPlc9Dg==
X-Google-Smtp-Source: AGHT+IGSQivaWwFeYIFq1q42mpAGD/VouDNwqLb1xVYdajTeEvjcLyKVEHkq/nqY5Kd5vWddHOdYPg==
X-Received: by 2002:a05:6a20:1447:b0:18f:ec1b:688c with SMTP id a7-20020a056a20144700b0018fec1b688cmr2326389pzi.35.1701955670491;
        Thu, 07 Dec 2023 05:27:50 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n26-20020a63721a000000b0058901200bbbsm1265924pgc.40.2023.12.07.05.27.49
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:27:50 -0800 (PST)
Message-ID: <6571c856.630a0220.884be.2a89@mx.google.com>
Date: Thu, 07 Dec 2023 05:27:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-28-g38e219eb6aa85
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 9 runs,
 1 regressions (v5.10.201-cip41-28-g38e219eb6aa85)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 13:27:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13835

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 9 runs, 1 regressions (=
v5.10.201-cip41-28-g38e219eb6aa85)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-cip41-28-g38e219eb6aa85/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-cip41-28-g38e219eb6aa85
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      38e219eb6aa85cc3be6dec326b24dcf8cf438d01

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


  Details:     https://kernelci.org/test/plan/id/6571b547ea976e6025e13492

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/riscv/defconfig/gcc-10/lab-collabora/ltp=
-fcntl-locktests-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/riscv/defconfig/gcc-10/lab-collabora/ltp=
-fcntl-locktests-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6571b547ea=
976e6025e13493
        new failure (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d) =

 =20

