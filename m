Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC81C001B0
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 11:12:03 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.104875.1692011515025404018
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Aug 2023 04:11:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=z8auW3cq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1bbf8cb61aeso25798215ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Aug 2023 04:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692011514; x=1692616314;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OjRAWmfbIbN+Jk3g/4AR3ACC5FEqI5Qbe88TrStRKaQ=;
        b=z8auW3cqQxOKi0pyMsP+dk/gl64DQWfni7/Oeavke6dwIQH7MApjAf5IhlntCkT3FV
         umu4Le5fXiW3lIic1z849mA4BUJLhH/fun+twHXq9px+5J286JaGE/dvnvbS4ARg2Rc7
         +DoW1BI4gRSC+G+NU7/wXAobqDADRV7VuVaKCbAm4qi7n98NItE/rWkxw+63CDMfBY7x
         ZQbL4UQIHAO6YYnDq/HGw8/O6+39OA352JeVFeYud8idS4cQLWb+j8rkN8SWVRFI0BWb
         X6/M4Lpm9ni270f2iJiXOvyHv6hrxecuUfxztBiJhtStGs03yEddhvQUfFGtNSIOzt/Q
         qvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692011514; x=1692616314;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OjRAWmfbIbN+Jk3g/4AR3ACC5FEqI5Qbe88TrStRKaQ=;
        b=ddwXLyzFYSNX2iIeajqsGMlBRWCK0ArtueEIJWdB2P/1v4oH12HFFoYmxrWYayc9y7
         Bcgf+9wI1uvWyzlR/Iunp/jD7jeIRyw0vnZpK/1JxQwMllkzI1y2dBqvFYsrvqReQxk5
         x8C1EAxY9rm86do37jXvuQrED2r3xxKLqo4d/mRT0q1MaXwI+e0uIQPtpRh63/I+RsQ8
         JZeIoKbp2iFDN/a7vwEeSfL3nCelBbOKyY6oSNa0hptYjJ6JIKK9MoqVsQm3Q6bgF8Xz
         VXQBrdpRkviR9L32TI6LuSYdQa/2Oi+6ihJdiI0qnwunvKAIhE3VBFV77OTD4fr1r0Sz
         FPzQ==
X-Gm-Message-State: AOJu0Yybq/KiQRi5yqZC1XBcNw6JeB3diNk204vDDTzTSiTZkg85VBVy
	HwzbilDd6fbAtH4dvirTUbmbv7I5YIcfe/khIOBLOMLd
X-Google-Smtp-Source: AGHT+IGEMIZ4PQUBHu5ez1SYsZJDwNnEw+rqOPWIuo/G6HvLMjrR3RTw2pNy/pXpzjbuINuqDNNVhw==
X-Received: by 2002:a17:902:d355:b0:1bd:d162:5dc6 with SMTP id l21-20020a170902d35500b001bdd1625dc6mr5243147plk.14.1692011514047;
        Mon, 14 Aug 2023 04:11:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902758700b001b9e9edbf43sm9214836pll.171.2023.08.14.04.11.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 04:11:53 -0700 (PDT)
Message-ID: <64da0bf9.170a0220.7002b.ffd3@mx.google.com>
Date: Mon, 14 Aug 2023 04:11:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.288-cip101-1117-g1f3468542aa9e
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 1 runs,
 1 regressions (v4.19.288-cip101-1117-g1f3468542aa9e)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 11:12:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12637

cip-gitlab/ci/pavel/linux-test ltp-ipc: 1 runs, 1 regressions (v4.19.288-ci=
p101-1117-g1f3468542aa9e)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.288-cip101-1117-g1f3468542aa9e/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.288-cip101-1117-g1f3468542aa9e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1f3468542aa9e444da3a41472888366e97d515e2

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64da00a09b21d810b935b1e2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig+x86-chromeboo=
k/gcc-10/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig+x86-chromeboo=
k/gcc-10/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/64da00a09b21d810b935b1=
e3
        new failure (last pass: v5.10.186-cip37-12-g2710acbceb75) =

 =20

