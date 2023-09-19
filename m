Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292ACCE79A9
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 23:42:16 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.25559.1695166926770747796
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 19 Sep 2023 16:42:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=p2VCC8zL;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1bf7a6509deso46901865ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 19 Sep 2023 16:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695166926; x=1695771726; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2MhkzAGDc5JESi7Tm/QmTc16swVLzWXHpu83PtrYiAw=;
        b=p2VCC8zL2DO6zWIGVUm1F2rT76k0LBocowsh/WobHHS0KYi/sgETYwcWQT0BGdwAjC
         EwHhd0cJulNUi5ZEEEPzmXwehxh0dhzwqrKcEdpH44CWBBsW37OC6U5xVf8RohHuOjNo
         w+lVPfVOJnD50/iahMIjrUWcfxF/8oIVRqx8ssfT57WpV5U6ctjkQ0PC5B2R5k08nn8k
         SnrVzK6dKgzw19sDMuRVV25dHb2ADj+UNzDBv3TS5kSWmV9xy6DzZN56B+kJiWhS/JhE
         +NShvnTWs48wV14mIdje9fNl/Zlkke/xgPsW8/aBDdmLO98PTjnO9XEgcwpFYcMlbl3X
         a3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695166926; x=1695771726;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2MhkzAGDc5JESi7Tm/QmTc16swVLzWXHpu83PtrYiAw=;
        b=MeBA108N93PF8zKCkjTr3I4jktWuRuymDIPHeBZDWZVMXDqymZKYpByDc6mEAV5UbH
         WW498s90iC6TW9g1uBBewUQNWgygowchkJfjF3ZFoNipY71xYVDt4aOohDCyIa5EPsmn
         fqwHCjXzWKRRrF7Y5EuJm1ryaeFQYeiI9s1vVJfiBokW/JYGYWET7XCttQMcJtfIbDss
         oRHkdiNRpXVsADvp17TLtTvMGmDVO38F6afvJNSN696VxNm7iRK0dyueohlw+BOePFyA
         n1iP++kPmdUvP8KfSnYEE9jwD3yJ2Dkvi0HY/u4ia14d8GbZpLXCNuqkTK1B3MjeH/Ea
         4Yog==
X-Gm-Message-State: AOJu0YxTcAV+p/KJpxoqSu4eJMFCbXZ9q0nXplPth8oRRnSW0gg5Xi75
	5JEp9+k6nlcYJJ4wTLViaDle9p/kJqpYods+T6LvUA==
X-Google-Smtp-Source: AGHT+IGjKLjyU8Avr0L2dPstr5k5WRb44sD+QOXkWdGvdUHFiN4lsbUiHc3J5Q+zzjAn7gd+4gq+Hg==
X-Received: by 2002:a17:903:2281:b0:1b5:561a:5c9a with SMTP id b1-20020a170903228100b001b5561a5c9amr1061331plh.39.1695166925745;
        Tue, 19 Sep 2023 16:42:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f18-20020a170902ce9200b001bb9d6b1baasm10444305plg.198.2023.09.19.16.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 16:42:03 -0700 (PDT)
Message-ID: <650a31cb.170a0220.0778.5ae8@mx.google.com>
Date: Tue, 19 Sep 2023 16:42:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.194-cip39-rt16
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt ltp-timers: 4 runs,
 1 regressions (v5.10.194-cip39-rt16)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Sep 2023 23:42:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13172

cip/linux-5.10.y-cip-rt ltp-timers: 4 runs, 1 regressions (v5.10.194-cip39-=
rt16)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig           =
 | regressions
------------------+-------+---------------+----------+---------------------=
-+------------
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig+preempt_rt=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.194-cip39-rt16/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.194-cip39-rt16
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7aa1fa8ed3b5d0130443043c96b985082bf55241

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig           =
 | regressions
------------------+-------+---------------+----------+---------------------=
-+------------
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig+preempt_rt=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/650a225a5060d7f1438a0aa5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/riscv/defconfig+preempt_rt/gcc-10/lab-collabora/ltp-timers-q=
emu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/riscv/defconfig+preempt_rt/gcc-10/lab-collabora/ltp-timers-q=
emu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/650a225a5060d7f1438=
a0aa6
        new failure (last pass: v5.10.186-cip37-rt15) =

 =20

