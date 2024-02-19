Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFE2C48260
	for <webhook@archiver.kernel.org>; Mon, 19 Feb 2024 06:41:18 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web11.36338.1708324872386817604
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 18 Feb 2024 22:41:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Shnz0StY;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d94b222a3aso37893345ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 18 Feb 2024 22:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708324871; x=1708929671; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k8zpAHoF3fg6xuEdAfpm8GMRRU7Uay8uuRLIlviG9QA=;
        b=Shnz0StYEKiwkcR2KWXiphPIK6hcWlkb70LvsEXPBxMaIL6meD8Fqp6kVcjJcoMkur
         vggCEJkOuOtD/V0eeLRQHKuOSP2EzJMA/tf3MvDYt+Mp0mptw9yEG4yYSO1PV5UezYxW
         +ZlLYLD32hdPbd4CzGcrn+kY290hNoK2yDzuEmPZo2V8/kjmjngaIsW+gchKfGQ2zsmp
         o+OAEjX1stLkJ85BLcH+2eJ/7SWGRL4YasgWp44QK0PhSxwk24gvbu6rY2wz028mSLs3
         2m3gT7gvRRPSs35hiuOqNC0Di2Vn/6JA3m+b8S0QA4dGmzNM7wmSoKydug4INyeHgIWk
         carQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708324871; x=1708929671;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8zpAHoF3fg6xuEdAfpm8GMRRU7Uay8uuRLIlviG9QA=;
        b=J4S/K5semigdoIaQnqnu8pV2CKQF8/lFtI+o6iy5bdMgxD4oDTkoOc0FXiDXuc4dAK
         XjcjWhCjcYOLbYjvvrvlSM4pPrb5NQWC1vnI72GdLfi2wTHEdwkh2DHaUhsvPADAynOf
         SzyBfCM4tfINbGCZfikMVd5XtyGuZLjo8BPHeZ2VJwlIQ2i11PzP4GLgimDDa5nnejN+
         kNEJrhzYSy2MeYAcf7yDEvm1GaETMbg4iGAMJ/zMZ6T2CAC/y+NoPanhBJuPkl0gC15I
         OeZjFKxZWSdpX+qAT98ngW4L6Krs6KowdJ34dPOvy5oMFWM1HSteknapkmMuo2n8sRtR
         Zy3w==
X-Gm-Message-State: AOJu0YwCUPI+K2b10nu21Dlec265G2UO4rLOOCWHWC8rsaWPKNNCIKts
	NNI37tWMs5be3OYPj8Sc8Uljf3yr06dT/YW2UDk//HWtOqcIfTAvw8wrwIODY4TvM1BzCIEoEii
	G
X-Google-Smtp-Source: AGHT+IHFnUPMmOWYrhNdRTMxwN457/eqeS/Q5n8ElPpHpbGPGIktkJs7JfXizHPIEfbxPXIQcBFSTQ==
X-Received: by 2002:a17:902:da89:b0:1db:e7a7:63f4 with SMTP id j9-20020a170902da8900b001dbe7a763f4mr4249479plx.19.1708324871239;
        Sun, 18 Feb 2024 22:41:11 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id iy18-20020a170903131200b001db5432449esm3662151plb.18.2024.02.18.22.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 22:41:10 -0800 (PST)
Message-ID: <65d2f806.170a0220.46251.b03e@mx.google.com>
Date: Sun, 18 Feb 2024 22:41:10 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.306-cip107
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip ltp-pty: 6 runs, 1 regressions (v4.19.306-cip107)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Feb 2024 06:41:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15028

cip/linux-4.19.y-cip ltp-pty: 6 runs, 1 regressions (v4.19.306-cip107)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.306-cip107/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.306-cip107
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      800dfc28d1a90b195d50f75fa7711d00cc1825bf

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65d2f183eb5fc4873d637026

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.306=
-cip107/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-pty-rk339=
9-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.306=
-cip107/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-pty-rk339=
9-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65d2f183eb5fc4873d6370=
27
        new failure (last pass: v4.19.304-cip106-3-gaf120b32b886e) =

 =20

