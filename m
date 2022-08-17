Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99331C25B0E
	for <webhook@archiver.kernel.org>; Wed, 17 Aug 2022 01:08:21 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web11.23486.1660698492988302766
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 Aug 2022 18:08:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=vrD3QNxH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id
 d65-20020a17090a6f4700b001f303a97b14so483128pjk.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 Aug 2022 18:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=AHvxLmeNq+fQz4NuTAqpSPHO0e/DV732g0c32yKBx2w=;
        b=vrD3QNxH+dvvgKYaYRc6DaGy5sUIy+ifZNuk069RJTxH20CNzfTZVHskYqjll44ziX
         0HQHMEijjgBAL4zpc81mV18SSPgOG58E+zdFO6gvIscb2WGRvmYLrWtuCIkHfp4FRnoM
         8O6GfH6wNOmDUvJpXPPACWAR0R5k01PgbGAzrf2YU4QLvu4k7jFtnPRV1kRaksbrNDue
         tjjrvYKX53lhYUJ2vnsjfKTJimKzEJfHv0/o08a9+RU3Hycm06MMmPf6mYzknbQuRZ+X
         oHQ37PSMVgLtBIDeqZOeihHJJqpDJbEtBxqSTcIxIZAIXSw+T227oWET7sAZcOoFD1sO
         LXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=AHvxLmeNq+fQz4NuTAqpSPHO0e/DV732g0c32yKBx2w=;
        b=zRMtCo3ReM0gM0eMP+YQcJI02x7OEJHGl6L6fpnvoFDZbxhcRbMcI4Z5AhAHgUflMe
         rMerB0Mhi0kmyqFFwXlgDAbpG9SQ/1LdmTLhxNh0CeSSDTKBJPsuE4PFLLMHKa6AR3rN
         B7cQUMCB4bnZg+v32ElMF9/z/cSdDgdddUb9/E6A0l45Jelf+jAiqBcKZOdlOle6uCkq
         4TN1UYwvIZKkjUhrIRoykfiKxP3GzuzLJVbB8r/IVU3xfL7KOYgauP/13YxxbEqBk/LL
         K5sJbuYx3spbMpFz7hbMJI8PFEwRCvKA2nTrjFeDIv96w1WtdgbdvZi8rc8yTyd8nJC2
         DK6g==
X-Gm-Message-State: ACgBeo3BLp0o3M7oZJ/4t/Mi9embHGMkkLAhvojfTlrZV68iUqrHZi0Q
	IeIj1WypoagmVDCryDNbX1enbfiT919lZ2qA
X-Google-Smtp-Source: 
 AA6agR61qh1fxN/1ZnRhZOxOtm2d3zhpyUgDALeQCymQllNRqPgTxIWUAoErfQrfjTruj/mGs1fnxQ==
X-Received: by 2002:a17:903:2611:b0:170:953d:e03e with SMTP id
 jd17-20020a170903261100b00170953de03emr24950612plb.49.1660698492247;
        Tue, 16 Aug 2022 18:08:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 b4-20020a170902d50400b0016dc2366722sm26921plg.77.2022.08.16.18.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 18:08:11 -0700 (PDT)
Message-ID: <62fc3f7b.170a0220.875e6.010d@mx.google.com>
Date: Tue, 16 Aug 2022 18:08:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-49-g1145e9c6352e6
Subject: cip/linux-5.10.y-cip ltp-mm: 3 runs,
 1 regressions (v5.10.131-cip13-49-g1145e9c6352e6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Aug 2022 01:08:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9267

cip/linux-5.10.y-cip ltp-mm: 3 runs, 1 regressions (v5.10.131-cip13-49-g114=
5e9c6352e6)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.131-cip13-49-g1145e9c6352e6/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-49-g1145e9c6352e6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1145e9c6352e68c31b58d1035f4f1ff07b2f9c89

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  bccfa7395fce4accfd30cbf7196c0a6e8db37728 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/62fc2eae7e60ef578d35566a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220812.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62fc2eae7e60ef578d35566b
        failing since 217 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

