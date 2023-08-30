Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401DEC83F17
	for <webhook@archiver.kernel.org>; Wed, 30 Aug 2023 00:28:09 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web11.3325.1693355283595765340
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 29 Aug 2023 17:28:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=JDx0IX31;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-68c3b9f8333so256967b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 29 Aug 2023 17:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693355282; x=1693960082; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/IF1oJDisoknSbF2nW49t0+HgmALmjwmIW213dHG08s=;
        b=JDx0IX31iR88YbvWvQYSiFg2ONcKCnRPQ95PV3Lwd9PT0upZb6HtUmA8lk+zAIpLTW
         CvrinlZQvvqBL8QTqxqMjTKLm8yqZESUI0L3AEjUuLHAGyPczCAIIw1ir48eOc0Zwkja
         6wFEoowGX6/Jzb+/xnjJaOGwEUpib1QmeFkn5j7VXwpvSv+p++Zz9UlXsY/IpDttIUF4
         Nf2sQf0PMn+r/mGiU4io0ngHpjoDzD8D0s9fG32M/DrL7EKlRQndOxLUSiCIOrFzTGFl
         nUDB5hRRP+Hd1JZWzTRt4NyhG0XZdvVB8P5cz+4AoRjHMHB60XH+KXfAQs7E6UKELZj1
         Z88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693355282; x=1693960082;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/IF1oJDisoknSbF2nW49t0+HgmALmjwmIW213dHG08s=;
        b=O/23oF8X/vVByk468AUpCGzODIxlniIfkkBg3hZvk7LPlCdfIy+ntRw0OPlgMsEaDo
         k/SRK7BrG5nAD57XIm1LVaWEVm0qTaqOlz4rgOsgEQR+KykO/67EVL8CFVaHyTdJiR7/
         7lasr8kKsvABh7IQqEw3q4a2QaLDhdB3/BgP/EqVFKKoRDqdJxaVReezPZ1ZscPVj3IZ
         tkGQS6ujjjMWuqSSCSSLfqgMCiOiGl9aIbqPM/z0n7kLt6brYSdfxtrdsADrJHhlaMRx
         i5DaT527Dx3Iu8x7JbAEP01B3gJO2/d5rF2ae8DH+f9SDHMTQyp+P8cFdVlOtIgKevWD
         MI0g==
X-Gm-Message-State: AOJu0YyNoj2IBEYExQN4zfw1RY6zO3UQxU9xLnwRWEEaxUICT+WpjPbB
	SsQ4KoFXUs3cM2FGOjNq02e3QMyRIARVoTvN5n4=
X-Google-Smtp-Source: AGHT+IEv1a3cpLYaruBjd3uzXqu0nKcB/E5bH4JfV9b/ueloUdTprBkO7jR5XyOtzsBzx5DhMEJxWQ==
X-Received: by 2002:a05:6a21:3299:b0:13d:7f7b:1926 with SMTP id yt25-20020a056a21329900b0013d7f7b1926mr5483028pzb.11.1693355281957;
        Tue, 29 Aug 2023 17:28:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n26-20020a63721a000000b00564be149a15sm9515299pgc.65.2023.08.29.17.28.00
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 17:28:01 -0700 (PDT)
Message-ID: <64ee8d11.630a0220.5c127.df42@mx.google.com>
Date: Tue, 29 Aug 2023 17:28:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.191-cip38-2-g05fb42f86d06a
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 5 runs,
 1 regressions (v5.10.191-cip38-2-g05fb42f86d06a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Aug 2023 00:28:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12901

cip-gitlab/ci/pavel/linux-test ltp-ipc: 5 runs, 1 regressions (v5.10.191-ci=
p38-2-g05fb42f86d06a)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.191-cip38-2-g05fb42f86d06a/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.191-cip38-2-g05fb42f86d06a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      05fb42f86d06ab31aa144cefe1ccd3c7cd8bbc72

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


  Details:     https://kernelci.org/test/plan/id/64ee789c20a1c3c356286d9b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/riscv/defconfig/gcc-10/lab-collabora/ltp-=
ipc-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/riscv/defconfig/gcc-10/lab-collabora/ltp-=
ipc-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/64ee789c20a1c3c356286d=
9c
        new failure (last pass: v6.1.46-cip4-rt2) =

 =20

