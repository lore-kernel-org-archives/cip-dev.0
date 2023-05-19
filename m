Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CC2C77B75
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 15:14:49 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web10.29042.1684509282717210539
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 19 May 2023 08:14:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=z2hrOlKR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2537a79b9acso776897a91.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 19 May 2023 08:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684509281; x=1687101281;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QbCD8RDd8OELeiQPcbc3QSJPO4mzkPQcfWq6myhqn7I=;
        b=z2hrOlKRQLJAAAwvbfgOrQq65CE5zDoMIuMlFNomY6fpC/8vhJwRJnTDRD53Fkva6G
         aJ+MbxTDQf2PkAhGkNtkomynDk8hd/oR/RYowRNmym232/uTsEgBqLrxOXM4ueTJfKd4
         g8rDOkRXtHF8zX0iA8NVgWZC/Myiasc67Sg3CEVGgP89q6+SZIjkf9vc0VEkdQF3mtt/
         JfBDB1I6br6Alap/Srd/017MseYWwmLU9P/dt/ZlCuWAynv5cKd1FPgkaGjS5ZRCIX7k
         7DnBB6LV0D68sKod4VWv3d+dq4kosWKOud63IE/jbyndjrQ6MrnYxQ9ZMRqxze4oJEnV
         95rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684509281; x=1687101281;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QbCD8RDd8OELeiQPcbc3QSJPO4mzkPQcfWq6myhqn7I=;
        b=L2pb65IlWFcJiVDY64ELHOqNiJMWToKZeSRkGYXKiFG6xmz9Kb9AsGRNa8MyUXmyqN
         yS6ByWSkVlar5WglK0oSBcOtd4+4Z5+tAOLuqyfKBKI+qfbe2xPQkvAy+U3KBurBBmki
         1ZISvlIUBXwRZXQxmkkf6Ex9EuR6MrFzD0YF0PzHDZ2S4znHjC/zkAgMuStZzRrznjn1
         CCli+dbJWMmjB9hOfELvHE9xrWaxFzAg38Zxt7jvnwiXiPxY9/3tRPHI3qnZJSWja6EZ
         ZATD0McIYCL5tRa1sNid08sA7Hk5/mlkLDXVfE00HNEcwU6U0E3tI3BkFFvcaPfuUXKr
         ZMyg==
X-Gm-Message-State: AC+VfDxHmr52rDXFEN5O+mZEdPyb7qv+ICD7N8YQ1ezzlULqKVlSwIr5
	85J74v3qkb8QuYBAnmuQ8tCtxbnnCvwTiu8IfvTxow==
X-Google-Smtp-Source: ACHHUZ6InMS1/nuybuUELosWs1iqZDjpIUxsFcNUL/F/znlimGwH7V09aS8t6s7EZzkrXuRyiMXbDQ==
X-Received: by 2002:a17:90a:cb92:b0:253:727d:aa5e with SMTP id a18-20020a17090acb9200b00253727daa5emr2604589pju.8.1684509281225;
        Fri, 19 May 2023 08:14:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ga2-20020a17090b038200b0025315f7fef7sm1598289pjb.33.2023.05.19.08.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 08:14:40 -0700 (PDT)
Message-ID: <64679260.170a0220.b15eb.2c97@mx.google.com>
Date: Fri, 19 May 2023 08:14:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.283-cip98
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip ltp-timers: 11 runs,
 2 regressions (v4.19.283-cip98)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 15:14:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11569

cip/linux-4.19.y-cip ltp-timers: 11 runs, 2 regressions (v4.19.283-cip98)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.283-cip98/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.283-cip98
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      31603fc59adb456f6eb0f58de8bb989b41572c2a

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64678867477f286f262e8698

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.283=
-cip98/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.283=
-cip98/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64678867477=
f286f262e869d
        failing since 174 days (last pass: v4.19.259-cip82, first fail: v4.=
19.266-cip86) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64678867477=
f286f262e869d
        failing since 174 days (last pass: v4.19.259-cip82, first fail: v4.=
19.266-cip86) =

 =20

