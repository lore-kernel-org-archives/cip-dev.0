Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E41EB64DD
	for <webhook@archiver.kernel.org>; Wed,  9 Aug 2023 05:59:34 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web11.82380.1691560771718879490
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 08 Aug 2023 22:59:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=XY9kXKpR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1bb9e6c2a90so55991875ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 08 Aug 2023 22:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691560771; x=1692165571;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LT6DnWDBdHBMk8HYsLSLOW4WAXF8oV3Y9IkwXHvteKw=;
        b=XY9kXKpRzrW/FY01jmNUXW6AhsiuW4i1OXdGZvQWOdfQ4VpqN0SIXAAuTzBLSH6v1o
         xR6aQZgs2h8rNJCw1NTUj6XayJnVF0v7wR5RLihfix+fKqe6VSVPXKmEgmtBr26IYe7Y
         P3JbeMUK2kww9HWqwC9qu9Cy2kO2LaTFmrlTDWG7ooeRKKoKcbuVv8Y7RQluwASAGF83
         fEiKCXS/v1MniMN1d0sZAKgKLNuWK2sCXhNYZl8tTIn/NESh4rrhnGZDNZxIzK2ARmmA
         JGEka/n+P17vxdZgCbqnXnkD0yJlnvRum05pU/iQcpsZsxmgNV4iqvz7QY6lK8XuaX4z
         +A2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691560771; x=1692165571;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LT6DnWDBdHBMk8HYsLSLOW4WAXF8oV3Y9IkwXHvteKw=;
        b=X9wJYupJg7QCyaq6BRHmct8tbVwZEL861pPxC+jP6jDHDeZVIgEaylYcJFWyL8AhuI
         m33DdjMLwOUuj2vwdnkPDYFWMCig/cqZOxG8EhoaFmMzqWCryh5sljTLySJZnAZ3yAI1
         7tzc06P6RvMlKSVzrdt9UIfwqEpINrXQNCuddLufZjDOZuwuozOEJX9ZjZTbbzyr5CK1
         OQHu72lE7TCKBLGaxZD7Llgi3/gEI6CgzZwoTyid2Q7rEdcJNm5Y+ncb7gjZsSJ9MPTv
         5HHolVJdcDKq5Njb2G+y9/BP1EWRcuSvjSUTKOwLuLzSttpToTSJhMYUIsDOWBJ8QjaA
         mLhA==
X-Gm-Message-State: AOJu0YwxIQ+45+l697pf2OLzbgqne4jJ6MtN4k77/2dm+IKcIWP71YCb
	GfaqF5EWLM6RO1M97WMGRoFB7NvC17DONopVgzOEnA==
X-Google-Smtp-Source: AGHT+IFZuh0gPl/Nnh1K03HkOeGpzNpVJ0DoBzM++FTJmECvEfpvkfFIGtZC3xGB9Hug2NgTHoO7Rg==
X-Received: by 2002:a17:903:230d:b0:1bb:a85c:23cc with SMTP id d13-20020a170903230d00b001bba85c23ccmr2365616plh.15.1691560770724;
        Tue, 08 Aug 2023 22:59:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y22-20020a17090264d600b001b8422f1000sm10253524pli.201.2023.08.08.22.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 22:59:30 -0700 (PDT)
Message-ID: <64d32b42.170a0220.9107f.3432@mx.google.com>
Date: Tue, 08 Aug 2023 22:59:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.42-cip2-1-g47d13938e615
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
Subject: cip/linux-6.1.y-cip ltp-timers: 8 runs,
 2 regressions (v6.1.42-cip2-1-g47d13938e615)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Aug 2023 05:59:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12580

cip/linux-6.1.y-cip ltp-timers: 8 runs, 2 regressions (v6.1.42-cip2-1-g47d1=
3938e615)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 2       =
   =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.42-cip2-1-g47d13938e615/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.42-cip2-1-g47d13938e615
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      47d13938e615152046baba32a1c3135dd09e2feb

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
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 2       =
   =


  Details:     https://kernelci.org/test/plan/id/64d3198fb54ab40e2735b266

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.42-ci=
p2-1-g47d13938e615/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu_smp=
8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.42-ci=
p2-1-g47d13938e615/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu_smp=
8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.timer_settime: https://kernelci.org/test/case/id/64d3198fb54=
ab40e2735b271
        new failure (last pass: v6.1.42-cip2)

    2023-08-09T04:43:45.536947  =

   =


  * ltp-timers.timer_settime: https://kernelci.org/test/case/id/64d3198fb54=
ab40e2735b271
        new failure (last pass: v6.1.42-cip2)

    2023-08-09T04:43:45.536947  =

   =

 =20

