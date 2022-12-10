Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B951C4332F
	for <webhook@archiver.kernel.org>; Sat, 10 Dec 2022 02:19:39 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web10.6172.1670638772463734177
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Dec 2022 18:19:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Vuvf0ATn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id fa4-20020a17090af0c400b002198d1328a0so9538453pjb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Dec 2022 18:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BnyjeBtsSgFT553lIGb43T19xWEPiXRsbhJV2axY/pc=;
        b=Vuvf0ATnnOibeyioZ4DGtzHJy5C3G9JquMlvnaha/atByOIEOYgD9H4mvx6LoaYI3M
         7vZTFPIxnziKc3VUh++/o5+2D0ov1WBC3BwvaO1E7uzZsbaY36A0axO3Yw4d2WUh+CoK
         amLHAlMZYe4ZI7p86VoLffO0HAcmcXCMAZIF43XKVJ94ZqZo3FvfbcMrqOtwnKu+0fqy
         UauTb91h9GJfVzKr7KsUsjgAJGpL+Mt3QXJC6J1XjA+OI+Cn5ZMltETNd3aEVjRKnFtl
         Ut/jlsevwnFGH+SuGlM5ZWsnQKmd/pqUDraPJiLvBq1hceS4bX5I5TGqNKQzqKCw6ZVC
         QzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnyjeBtsSgFT553lIGb43T19xWEPiXRsbhJV2axY/pc=;
        b=75xe7cq1jLuDcqN7uXICYvp/yjcO+nYEYMwnJ9Odmkz4WZsRQwvrlJuL+bKBYrRtU3
         iPi1sXeNDflx2VSI/lIOccWpYeiz1YVwN9ZJRWG/7EB7pfcyhgj5eHBp7+XxaNriLWVk
         PiwmbGxpmnfyxJCNqsfxzdbJCZNI/uqdLm6a0YmyvXkvIwx8owfdUQiNiBeiSdcUJliZ
         Gdoa+SOytlNZ/jqXPndH/uPizNlIrUKTryb7JcYbzDNxSZoa7WIAJBWWpNZOebmG+KEc
         NWHxK1Ol/er5FcPoCpARsYAbNGrywa2hNOWOMjYznGjfjXckvPvGjUwg8vHfA4sAwchD
         /sDA==
X-Gm-Message-State: ANoB5pmdyM8h8pGzZ7t3VJMWjNQRhAQVrMUo7/rPTGDPOVz4drKElGaJ
	o94XGFbOgFVW1a/sA01SHP7uDhlcNvBZ8r0hQnk=
X-Google-Smtp-Source: AA0mqf4YmMOHaaz0WT6FSooZ3AsXoOWBb/NnVzwHDAUEkiX+zeTA6EVHzWFk1i2TZmAx2o7QsLUjdA==
X-Received: by 2002:a17:902:d4d1:b0:189:e7e:784c with SMTP id o17-20020a170902d4d100b001890e7e784cmr11688130plg.21.1670638771560;
        Fri, 09 Dec 2022 18:19:31 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u9-20020a634709000000b004768ce9e4fasm1540169pga.59.2022.12.09.18.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 18:19:30 -0800 (PST)
Message-ID: <6393ecb2.630a0220.c4b9e.33b7@mx.google.com>
Date: Fri, 09 Dec 2022 18:19:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.158-cip22
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip ltp-timers: 9 runs,
 6 regressions (v5.10.158-cip22)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 10 Dec 2022 02:19:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10192

cip/linux-5.10.y-cip ltp-timers: 9 runs, 6 regressions (v5.10.158-cip22)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.158-cip22/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.158-cip22
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f37e570b7c4ab8bcfacf36780a9e204878f2c181

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  e76de05a93390f5ec7fae2941d8f24d367c9b2b8 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6393e2399868c339782abcfb

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221202.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6393e239986=
8c339782abd00
        failing since 13 days (last pass: v5.10.153-cip19-3-gc76f4e7e5c71, =
first fail: v5.10.155-cip21) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6393e239986=
8c339782abd00
        failing since 13 days (last pass: v5.10.153-cip19-3-gc76f4e7e5c71, =
first fail: v5.10.155-cip21) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6393e7b55ae1d8eb3d2abcfa

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221202.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6393e7b55ae=
1d8eb3d2abcff
        failing since 35 days (last pass: v5.10.147-cip18, first fail: v5.1=
0.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6393e7b55ae=
1d8eb3d2abcff
        failing since 35 days (last pass: v5.10.147-cip18, first fail: v5.1=
0.147-cip18-12-gcb2b164780be) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6393e4bf2aa0ee5b722abd15

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221202.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6393e4bf2aa=
0ee5b722abd1a
        failing since 35 days (last pass: v5.10.147-cip18, first fail: v5.1=
0.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6393e4bf2aa=
0ee5b722abd1a
        failing since 35 days (last pass: v5.10.147-cip18, first fail: v5.1=
0.147-cip18-12-gcb2b164780be) =

 =20

