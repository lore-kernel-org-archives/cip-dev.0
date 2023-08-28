Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD5FC83F11
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 00:54:15 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web11.4254.1693184050529617187
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 27 Aug 2023 17:54:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=4JlhHYhj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-68a3cae6d94so2357661b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 27 Aug 2023 17:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693184049; x=1693788849;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QJRmCXAWDHX29kZwQFe9wxOCZ2KKsmy1VsnnGS6LGj8=;
        b=4JlhHYhjPdaFkiJh+MCxM2rle4ZSXTZce6fyYs2CYVwU0+Z9E/hj04vlWR54hJGLOL
         fzm5uPoz2qBcmk2avoE+qsX2Zhe9wmhNmIAtEwPLwgITrMNPMEw6MJgfpBYxE3hT2mT1
         fHGsFDxcreufIG3gwmNotMZbIcBPB5aGkW4n3VhDNKP6fcXWxMpR6i5vIb6gtwDsuQYe
         ayf/0wEMr8OS9NPqU/bpY2JyMRcQZ0L4ySmJWwj8k4ZdbYKD/5ALc3TWXsx+458FZO25
         gem08hSP3eqLtLDtCaEtJrefckygI14ju5utPxv/NFTMYtNkydBoYUu7vYAROO/fdxEK
         9yRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693184049; x=1693788849;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJRmCXAWDHX29kZwQFe9wxOCZ2KKsmy1VsnnGS6LGj8=;
        b=kp4Y37ZV+4pi7UXD4umx5VVHhERYfgZO6t/8/JtinIM5foOrGp9eZI2n4XhrtX55qG
         a0XeMRw71x9ScG3PFZtYJtqdHhKbH1SX6MtmM4ud5FmTX5j72csIekUcUvSNwB8DIYbS
         smnpSV2wOO7/wjApqLKryp+WZuYTUccodixaoTKhB6enazGPbBIggy5VmvyiNwZrQt5V
         MbNSko6+Yo2RafNeGFbwL55b5LvQK9aJ5dV5Fx+e+bOfILMFQFm+yaNcJkieOOR7xDhq
         TyvrOmSX5HwtolofzV2TTXFCXEUTmK0boJvu+tB0Cfw6jgVUgXrEZ4DYRL64mGYC3yp/
         qcoA==
X-Gm-Message-State: AOJu0Yxan7ZPa5xJi8GKOsSlSrpj424Cj5lX+mH59aypD7u71Y8loPU1
	KnLaPHCDcWYI7YMzYEhiNT9hs1GvHSEq9P9HrLE=
X-Google-Smtp-Source: AGHT+IHgTKBfU8Bv3BJ6LeWRsQAWKl2xkOY99frQa0r63gICxie5HPP6TWYkH4+NCLb7S4d03NstFQ==
X-Received: by 2002:a05:6a00:600a:b0:68c:4ff1:3de9 with SMTP id fo10-20020a056a00600a00b0068c4ff13de9mr2145567pfb.17.1693184049466;
        Sun, 27 Aug 2023 17:54:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j5-20020aa783c5000000b0064d47cd116esm5404090pfn.161.2023.08.27.17.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 17:54:08 -0700 (PDT)
Message-ID: <64ebf030.a70a0220.22d41.8322@mx.google.com>
Date: Sun, 27 Aug 2023 17:54:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.292-cip102
Subject: cip/linux-4.19.y-cip smc: 3 runs, 2 regressions (v4.19.292-cip102)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 00:54:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12860

cip/linux-4.19.y-cip smc: 3 runs, 2 regressions (v4.19.292-cip102)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.292-cip102/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.292-cip102
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      372689399d20f850142c3d734cb4365cd8a31242 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64ebe0db471fc745f4286d79

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/64ebe0db471fc745f4=
286d85
        failing since 415 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-08-27T23:49:44.403754  <8>[   11.474670] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/64ebe0dc471fc745f4=
286d86
        failing since 415 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-08-27T23:49:44.394000  <8>[   11.465150] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

