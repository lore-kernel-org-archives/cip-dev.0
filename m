Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA48C77B76
	for <webhook@archiver.kernel.org>; Fri, 14 Apr 2023 11:13:40 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web11.6702.1681470814609240567
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 14 Apr 2023 04:13:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=BUVQ+B7F;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2472a3bfd23so212873a91.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 14 Apr 2023 04:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681470814; x=1684062814;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0SKFQc6ztOVIk/u2Y4q6E3ahfFXUV5gZDWBuLpfx90Q=;
        b=BUVQ+B7FRM1WZZD67M80VClcvYmk1g0kKoLrNjpmNwDL0KMZZ7P847Dmyml/9Mt/UD
         SevbNLpCn3SUeUqEAEav2CLRJIxUtbgQWUg81xnDuCgqvjo2DtQ9yJzLCG4nc/HXLLG4
         NMBrZU+l0iDwHnY7glLKye6+XD9NixEmjLlIxwWO+ZIaJKgwM8Sq/8my5vYCJ0gtwjxB
         RigdKeGWp+yGI4yYHQHZCF4Gy+v+AvKPZFR2ciA63Y1267kjQ+/K3RMd7VK/EBGH70bK
         fQwf/2Z7Y1S4toLCI/QxquKx+7W/5RLhjFW2GRcOrf4xYXbqmuUwBNvYDNT1NXkfXD49
         CFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681470814; x=1684062814;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0SKFQc6ztOVIk/u2Y4q6E3ahfFXUV5gZDWBuLpfx90Q=;
        b=gP5cbSqJY+d8QbdWFK5cbCS5Iq3kLuABKmPJMkDDKvGRgW80wtyct675iFqFmvH5iG
         7uTagRb1tpvt0LlXJ5njzlhvUMR6SmkwJfd/C3Oc9KC/CMAhWzcE3lU885Wb9Fa0fuk3
         4hinh7DBKczxL6jYs/7FEKKPxAR5Bron9XLt0yB+VXkAguP+rixmlVs3vDPGWBY8OfAa
         ge0zRo+xAvExQA7R0imZeAVV+879G6J9W6jpcZGz+uywF5PexMyhgKf9Nhn058MWZDvQ
         +5Dv77aTxc0ZCCbfI4CyfXfsvymWrcfLDP1PwyP9N/nRiYsayHVdgXaO7fCbL+8v6fgL
         qfPw==
X-Gm-Message-State: AAQBX9fndgHg36vSAGRQLXnvZ5xl/0FYSsfD6xlgreVsSdBrP2Dr7kXc
	IMKtJjYNdmcjndQvq+mywILitwT39qG3qUt5PWxg+H/6
X-Google-Smtp-Source: AKy350acHy1WZ1ZzyXZplGdY+wCFYhVDR2q/VuD4OszXZrnY33dz8SzYHXXapaMVRvcnkYMkFBskjg==
X-Received: by 2002:a05:6a00:2e87:b0:627:f0e1:4fbf with SMTP id fd7-20020a056a002e8700b00627f0e14fbfmr9307355pfb.33.1681470813682;
        Fri, 14 Apr 2023 04:13:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e19-20020a62aa13000000b0063b6451cd01sm1148563pff.121.2023.04.14.04.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:13:33 -0700 (PDT)
Message-ID: <6439355d.620a0220.a850c.285e@mx.google.com>
Date: Fri, 14 Apr 2023 04:13:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.280-cip96
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip ltp-timers: 9 runs,
 4 regressions (v4.19.280-cip96)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Apr 2023 11:13:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11211

cip/linux-4.19.y-cip ltp-timers: 9 runs, 4 regressions (v4.19.280-cip96)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.280-cip96/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.280-cip96
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0f5788ca10e5121ce62a8a58a84c723b7d99607f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  cb9b37a6a47ea5f9e442b4473c6eb06877bd18ac =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64392d2e9215888a3e2e85ed

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230407.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64392d2e921=
5888a3e2e85f2
        failing since 138 days (last pass: v4.19.259-cip82, first fail: v4.=
19.266-cip86) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64392d2e921=
5888a3e2e85f2
        failing since 138 days (last pass: v4.19.259-cip82, first fail: v4.=
19.266-cip86) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64392a998fde324d812e85e7

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-timers-r8a774a1-=
hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-timers-r8a774a1-=
hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230407.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64392a998fd=
e324d812e85ec
        failing since 20 days (last pass: v4.19.277-cip94, first fail: v4.1=
9.279-cip95) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64392a998fd=
e324d812e85ec
        failing since 20 days (last pass: v4.19.277-cip94, first fail: v4.1=
9.279-cip95) =

 =20

