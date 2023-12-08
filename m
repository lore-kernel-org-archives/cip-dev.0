Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEC6C46CA3
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 18:12:06 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.43384.1702059121391600527
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Dec 2023 10:12:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=0ZMsPcJ0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ce95e387e5so1842735b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 08 Dec 2023 10:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702059120; x=1702663920; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zF2BWCM17I4Uc8erwnYNT67v28BZNrCximIBMrupmuQ=;
        b=0ZMsPcJ0vbyhcAGjR5icT5YhjWnYsSz6CZ81Z0F5R13lYcgMgM1bMeDcF0uvGnJiBA
         t+d8WeY9HKGQZ1uqMxN4esJ88Fj3oKXAdRt6+yZ4z7L9fWtnCr04YGXs1pyqy6aEZYa2
         6sdVPsq3T9j9d24YxhaGAqzGmZ/4V+cdOxR1g+USp9jJe9vFWxpa8CKPVzBnCzqZQdjP
         fINiqcUhiPNVk/5/aNoSQjEXT6eaTGv+dvq/Izm/NPFE66xYzszaRcjypn/MjsUekMCR
         7NCNZoy7iXojgWc5OPJcfznajfl8jivNuW0NBrKcC0XH4mBcCY7p13ZQD9jpVWuwbBsD
         PUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702059120; x=1702663920;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zF2BWCM17I4Uc8erwnYNT67v28BZNrCximIBMrupmuQ=;
        b=gkl6o8yltjle98UBUPrdozjP9lNRGDSvF+R5iYYzLJ5k/yd3POBmEIiVzKQCkSSS5u
         NdvZIerO6YPcltuyNThz3T8S3FeXo6SNz4Hujv1TP7JEDnKM+wWlnou7pjdrTUNi/wJP
         bj+4ZGTf8t88JhAkwyY3yg4o2zQOEgvsJBl5/O9h2lCaCDpiGh3w6T7IueVxGUisSpij
         yLoK5vc3hPIMcei8KQfO54C6D3kydnKS99wdvbnhE1jagXzt/ft6V3a2qXCPc8UjSBaG
         2Rq6q5XRZhu2xfq5NBSIGGklxL0hPq8HdBscQL7e8Bk58gC5XCCWE10aa1IfrbJyQK7o
         faMA==
X-Gm-Message-State: AOJu0YzeqMR+WqH7ha+A0adAbCp0+8nbpRF01p4WZY/JuHTPpOZlgxlS
	lBzlSwCmzpgOsLi9kRAkYdAlhfdvpTLYTvCuc19dSQ==
X-Google-Smtp-Source: AGHT+IGH8Af91w4sZQIRDmfhFzRlaUCk2rFwPCDAh135+bnR3hHRofIh3nJBh895IiEH1EPbRtRR5w==
X-Received: by 2002:a05:6a00:134f:b0:6ce:7af1:1bec with SMTP id k15-20020a056a00134f00b006ce7af11becmr543012pfu.23.1702059120177;
        Fri, 08 Dec 2023 10:12:00 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id gx4-20020a056a001e0400b0068fe9c7b199sm1868744pfb.105.2023.12.08.10.11.59
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 10:11:59 -0800 (PST)
Message-ID: <65735c6f.050a0220.75d19.6b3d@mx.google.com>
Date: Fri, 08 Dec 2023 10:11:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-63-gfdfe1fbf93bc6
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 6 runs,
 1 regressions (v5.10.201-cip41-63-gfdfe1fbf93bc6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 18:12:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13990

cip-gitlab/ci/pavel/linux-test ltp-pty: 6 runs, 1 regressions (v5.10.201-ci=
p41-63-gfdfe1fbf93bc6)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-cip41-63-gfdfe1fbf93bc6/plan/ltp-pty/

  Test:     ltp-pty
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


  Details:     https://kernelci.org/test/plan/id/65734f30644d89feeee13529

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/riscv/defconfig/gcc-10/lab-collabora/ltp=
-pty-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/riscv/defconfig/gcc-10/lab-collabora/ltp=
-pty-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65734f30644d89feeee135=
2a
        new failure (last pass: v5.10.201-cip41-63-g2bc5a8583f4a8) =

 =20

