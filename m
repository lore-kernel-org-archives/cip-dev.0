Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD17C433F5
	for <webhook@archiver.kernel.org>; Sat,  1 Oct 2022 20:01:58 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web12.1259.1664654512829654427
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 01 Oct 2022 13:01:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=6Off6kUV;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id
 d1-20020a17090a6a4100b002095b319b9aso6136000pjm.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 01 Oct 2022 13:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=dgQSlBgP41kElOFpJTekrH1hY4356Hwt2dPa5xxpK9c=;
        b=6Off6kUV88sQ2/I3cDSdVZImHHtdOdcRRqMjl6cdFX6wAwPgeHetw3Oat5gBg6F+Da
         2Yo82sPoPFLZqwZChpp3JTX4c42R7ba7Gjal7zBdokQL6bZ8pi0fNefxW2Y5Vbl4OtuZ
         u8VIDN27vITxssABkgc6g1B6bKsgVUbLToQZFr/4LBCfPfF7qETQZ3Y5e/RYZ5eDSWhw
         H++axZ+RB4Zmw6V/WWMBYHmqqQ2vKjn3l3iBP7ICEVqC+Q9SwLAvnFdt1KAcR4UyrK37
         0ZkY9385M8P19t29CmtB5XpxHIEmdJ/832BkvJyuJIyECyi5StH+dlBhOQLhr+Hf+dYF
         Farw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=dgQSlBgP41kElOFpJTekrH1hY4356Hwt2dPa5xxpK9c=;
        b=23ZVoN19eFNGCiEF66EAZbd++q6FWBgDJfH+o1lG44uZj6dKzXSv5PaXwJn7gqE+eN
         4IedfbWpDbd9I864Ud5UTeufD/kkixUVv27mWLV2fHkKk6c78HfyGm2N8Z6+5lDCXRW+
         OzNkeJgE6XSpevJbnjz/oGRS28IB5qCyBPi6mihnjxExqS6Tfp78S8682ZIDm5mTJ1Wk
         93uggC3aFZ3J0nB+Ps6hujSC3JZCPLeSwFaq9UMZAk5dFm46zzIA4I+akaAsj7frHdRh
         bBPYPumZgxd0av3+Ewhmq7uA+y2xg4w4KratYerWOVcCE/h46J4xGvc98yujeHCNGuBG
         +vxg==
X-Gm-Message-State: ACrzQf1PneGloOdvlDDmMoR3qkShw+6KZvTmgQsd1P99IRsMgHISEbE5
	OYKxih2NcWwCLe4PmmhLSwymG6Bkkh4JvfIgrbE=
X-Google-Smtp-Source: 
 AMsMyM4tTOJIg0QsTeb+9fTq33J0LBm0/ucxW+kOoQgqW4CovVCh7XSkIzBdFflg1DEmR9rbgVZdFQ==
X-Received: by 2002:a17:902:e850:b0:178:64f:a57d with SMTP id
 t16-20020a170902e85000b00178064fa57dmr15546590plg.110.1664654512073;
        Sat, 01 Oct 2022 13:01:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 i2-20020a17090332c200b00176b5035045sm4294996plr.202.2022.10.01.13.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 13:01:51 -0700 (PDT)
Message-ID: <63389caf.170a0220.9edca.76db@mx.google.com>
Date: Sat, 01 Oct 2022 13:01:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-cip17-rt7
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip-rt baseline-nfs: 49 runs,
 2 regressions (v5.10.145-cip17-rt7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 01 Oct 2022 20:01:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9607

cip/linux-5.10.y-cip-rt baseline-nfs: 49 runs, 2 regressions (v5.10.145-cip=
17-rt7)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =

r8a77950-salvator-x          | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.145-cip17-rt7/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.145-cip17-rt7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      411cd76b5afe81569858976d0e9819ab48717fcb =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/6338977d72de264422ec4ea6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
145-cip17-rt7/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson-g12b-a=
311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
145-cip17-rt7/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson-g12b-a=
311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6338977d72de26442=
2ec4ea7
        new failure (last pass: v5.10.109-cip5-rt4) =

 =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
r8a77950-salvator-x          | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/6338961eaa6cc47206ec4ec5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
145-cip17-rt7/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-r8a77950-sal=
vator-x.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
145-cip17-rt7/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-r8a77950-sal=
vator-x.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6338961eaa6cc4720=
6ec4ec6
        new failure (last pass: v5.10.109-cip5-rt4) =

 =20

