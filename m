Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27C6C433FE
	for <webhook@archiver.kernel.org>; Sun, 13 Nov 2022 09:19:12 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web08.1161.1668331150196583818
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 13 Nov 2022 01:19:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=VlSryu+C;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso8129021pjc.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 13 Nov 2022 01:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bfYBT3ViSVqhz+UxzRyk8uMvzYsXuva2CoeqwvSAhk4=;
        b=VlSryu+CNJDLs8SYbcL6/eZhJInDq2JPpIxDaJrptPC1LelcXrTZ4ehxE0LEnKoijK
         b1/v8JaNXoCwbqBYQpnkB8Hy0s+KpG365FAbOwQCsRe10cCa9/7ptzkwHtThuMlc9khh
         FfcZGmHQreIX6i/t/dcC8nFUceTDXg4sMgB6HgXnz6x/rFsw4P6aRAfK1gc3LRfYOKsG
         H8rBj6kkpVY+CW+lyTRU3tw8D99CFLPWxtYdQDHpFWpTK9tKoIGUgoi1hKNrtBqNttdm
         Wd+syHMGQoA4Ceq/L33A4PNbM5MxkG73fIcFF9Sz9Ey9h4Xeu6sCSYaG94vRLOG7RYzN
         0x6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bfYBT3ViSVqhz+UxzRyk8uMvzYsXuva2CoeqwvSAhk4=;
        b=PXQaDg7dxYwMr/i0nPbQrFF/tzVXpb3RkbMFcoGyobe5o262BndiYGVfzUHdXp2bYX
         EQiP7/tSMXdzWb3t626//IkASXoAIsrkqR+xSNYt2JiwLHB2HzQdNGdjGy4qELQr66UL
         yx2rVuiVcgHCGZwfHmkyFXj1W0OQBa2pTjGUyk2qZcWzdOGOpay03HYaWgPBcEPgPOvM
         jQXBN2QSc/3MaC6wHH0CkS86mss/8jJwOjCbalqp6cLhson8ZNhRWSGeWalVSnaBVHUP
         LoWszQuflcw7j+9/X4VvIxK1rORN6DMWmdBsHh1I79wqgX14SUXJJEL1OA19LUDxAU9W
         o94Q==
X-Gm-Message-State: ANoB5pnwaSR8iNv+XU70SVLtiuCJZzen5llgJg/KgmxOFKlNc0F9sg9n
	LlVsfD+uU78aV1sMxahzbIfe/2d0HpFEKF4ZPyM=
X-Google-Smtp-Source: AA0mqf4I4lQK5VDCUPd9lXichYsJWCcSimjrAMjMf9QsNhLcbMvwF6mvXlTXzr6QZuOqyEolpT3X0w==
X-Received: by 2002:a17:90a:7ac4:b0:213:6442:232a with SMTP id b4-20020a17090a7ac400b002136442232amr9473674pjl.117.1668331149526;
        Sun, 13 Nov 2022 01:19:09 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b12-20020a170903228c00b00186b0ac12c5sm4830144plh.172.2022.11.13.01.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 01:19:09 -0800 (PST)
Message-ID: <6370b68d.170a0220.d9aed.704f@mx.google.com>
Date: Sun, 13 Nov 2022 01:19:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.154-cip20
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 5 runs,
 3 regressions (v5.10.154-cip20)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 13 Nov 2022 09:19:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10028

cip/linux-5.10.y-cip kselftest-lkdtm: 5 runs, 3 regressions (v5.10.154-cip2=
0)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.154-cip20/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.154-cip20
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      efa0ded8f5c8a9e3835e4aea63caa6cffb0ccda8 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6370a1dde6aab2cbf1e7db6d

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.154=
-cip20/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.154=
-cip20/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/6370a1dde6aab2cbf1e7db73
        failing since 138 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6370a205d53fd21637e7db82

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.154=
-cip20/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.154=
-cip20/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/6370a205d53fd21637e7db88
        failing since 138 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6370a1dd80b59f2ea3e7db4e

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.154=
-cip20/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.154=
-cip20/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/6370a1dd80b59f2ea3e7db54
        failing since 138 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =20

