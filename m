Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54782C6FA86
	for <webhook@archiver.kernel.org>; Tue, 27 Sep 2022 10:32:43 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web09.9293.1664274762597942558
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 27 Sep 2022 03:32:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=oY08BGA5;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.182,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f182.google.com with SMTP id s206so9033886pgs.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 27 Sep 2022 03:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=lUD97kWRUjrD5w2Etf/RurpBlr5c2qCLyPV0VtRgGgo=;
        b=oY08BGA5PgxjZ8XaDR55LOKHfX/H9cKzMBDdroUOl2ArtK19f5N1uNUnb3PGWtgeBF
         YA5QoDbhOle7106gYb8NKVqcBmm665s9pBhlwpfpgVxbUJq4LTbsaCqy2podndOq9oxd
         Yg/EJRrHpXWzFfcFY3lv8qkyyfVY+an7vfmMZLnZwQ8u6KKtowkzJ+KDmn3c7STjnxbg
         p4BPSerVdj+d/szST9lnGP/B2I0LpE2viEVc54f2pTcm9g5084u4AA4edrzWCvlPnvWP
         H/mwQMy6PWXqGMmrsX2wdapRA0lWnG4hICgaJQraCMt0bdga2jZpw3EqR7T1gcMJnz1D
         Cdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=lUD97kWRUjrD5w2Etf/RurpBlr5c2qCLyPV0VtRgGgo=;
        b=6HqnlyoWhgzUoKOsHc+OxmdyS0yEQ2FiyRtywlrEXlkYiILSAR+iEjJlitjNBq+dDY
         3GlMU2urnxELZQtb0ZAlEarSQYd37oNEYU2IkU0e+FIpM9QuL2wTqtJxSeqxNaxtKghc
         7qzWENfF9CVwaDU8ZQRdhEvQgOGBhs7QRnbEPDsPtSAYscMjqGDAtzl8iJ2/ZKXkvkXc
         qQ9bMw99qxm0rdV13ldkreLdD3QJrSdIaWzdcQuJMj1hWuI29yxFQF9ZydBYmF1iHRJG
         roezmCPoMI4fm+1ILsreR3k0xU1lzfeEEIA2va4RThmeVK6VQ9Fddw5ltZwN7b5BvKhU
         ofbg==
X-Gm-Message-State: ACrzQf27ybEI21kgBFpnLqn5NV2TPbdWJwORMTR7FFJnFDwswcpB/gfk
	ZjAI4HrTQW3UTYYoH4NsVCUoN1Vv3/nZK7bi
X-Google-Smtp-Source: 
 AMsMyM7Y8LyIZwNkFTcrJRLnlBlOM7FWcMVZ1AAR87kA4qxDp7E+J/H9eyX7yY+VUsq0kKzsHl+oaQ==
X-Received: by 2002:a63:87c8:0:b0:43a:c2e4:efcc with SMTP id
 i191-20020a6387c8000000b0043ac2e4efccmr24464717pge.410.1664274761810;
        Tue, 27 Sep 2022 03:32:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 u12-20020a170903124c00b00176b87a697fsm1156155plh.269.2022.09.27.03.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 03:32:40 -0700 (PDT)
Message-ID: <6332d148.170a0220.88210.1a3c@mx.google.com>
Date: Tue, 27 Sep 2022 03:32:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.259-cip82
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip ltp-mm: 5 runs, 2 regressions (v4.19.259-cip82)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Sep 2022 10:32:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9560

cip/linux-4.19.y-cip ltp-mm: 5 runs, 2 regressions (v4.19.259-cip82)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.259-cip82/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.259-cip82
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      91f283faebd1a92efc2cfe0a3de7c568c87e5ee5

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  48cfd7a9977e6268b4aa2600608cebad7e0e42b8 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6332c3529eb6427fb1ec4ecc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.259=
-cip82/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.259=
-cip82/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6332c3529eb6427fb1ec4ecd
        failing since 255 days (last pass: v4.19.222-cip64, first fail: v4.=
19.225-cip65) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6332cb155b30123589ec4ec8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.259=
-cip82/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.259=
-cip82/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6332cb155b30123589ec4ec9
        failing since 255 days (last pass: v4.19.222-cip64, first fail: v4.=
19.225-cip65) =

 =20

