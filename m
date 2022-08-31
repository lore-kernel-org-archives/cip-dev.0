Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A978CECAAD1
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 13:48:01 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web09.25811.1661953675757361604
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 06:47:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=XC0hsGU2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id
 i7-20020a17090adc0700b001fd7ccbec3cso3710698pjv.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 06:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=WIygf95q4EdprwQ8LO1FRQOhGLX9IIZXyVyq2m7XVVQ=;
        b=XC0hsGU2RsLfrg+qFhzpqd1nf7BALSwN3TzaD9wMaaIA1S0hQfFukIyrHrUueoc/yC
         1gXGjdQ9oD59iRyWduUzzGsMFwVyMBqpuNk0i5j+nJKr7gJ+Cvux/0zNrSqYFbmysqUQ
         hgXLHy7KEyq0CsD2jV4FeHJb1ew1tWRSDntpZpNNAAhZTk5XC9WXFF2J2jF34fI9sWXk
         6w8LHU7CmobVdOllGklBlyEzn5UGxCmyFVknoqaXoHNw41rhu5E5xCFpMJ11TtGTxjom
         ziEYLhL1EVvhqyIzmFkEjTiBoOGqGXDSZN38gbzFJ9ZzR7nQxJEcihdJ5kaNAY5TT/at
         1BlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=WIygf95q4EdprwQ8LO1FRQOhGLX9IIZXyVyq2m7XVVQ=;
        b=XbOlkRJIH5jjQj5wMoe+BTFW+SqmaMVpgTXrOqY1FbM6gHZF4AisTyShqUKh1fGcDv
         1/4t+12HEUc1/e2VJgZlrmhvGe1UIznxBdLJBFRngr8Gld3MnbBLOZ12g8afBcC6a/pw
         DSZn/sPeEt7PJbXmKMX50V7qsizmIfyq5r50Pa4tpBXWbvkVKWRL+C9zM0sivzajoKZU
         Q4Qgx92YdBoWwwYu/b/jd1eOg7IRbLgpD693/s0aHbNq5jzSL6VWMohM1tZ5a3k/rdeF
         cXflaDxfZkX5laXAnkdKiFJuGm/lmZxZTdNqUJyFUkKiwpAZFVUqKAkOBbdOy7jTCMJM
         jrBw==
X-Gm-Message-State: ACgBeo0wCHV9x9fHbhsA+dxLFk6JMnmoP6ORfJZ9WiVb+gGwBE6YbZPX
	ltf5lDQbcPpDybgObRCBgZirn6nUBMrE7oRKnqw=
X-Google-Smtp-Source: 
 AA6agR7RydplPJ6qLjG03YUQDIfVT3rUTgIqtN/a4koLZ2gqXpx0iu73zf05bu6E15+hyMd0BrdDgQ==
X-Received: by 2002:a17:902:d484:b0:16f:161c:ac3f with SMTP id
 c4-20020a170902d48400b0016f161cac3fmr25777204plg.107.1661953674974;
        Wed, 31 Aug 2022 06:47:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 d26-20020aa797ba000000b0053668f17a23sm11022062pfq.220.2022.08.31.06.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 06:47:54 -0700 (PDT)
Message-ID: <630f668a.a70a0220.a52c5.3944@mx.google.com>
Date: Wed, 31 Aug 2022 06:47:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.256-cip80
Subject: cip/linux-4.19.y-cip baseline-nfs: 32 runs,
 1 regressions (v4.19.256-cip80)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 13:48:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9345

cip/linux-4.19.y-cip baseline-nfs: 32 runs, 1 regressions (v4.19.256-cip80)

Regressions Summary
-------------------

platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre | gcc-10   | defconfig | 1    =
      =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.256-cip80/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.256-cip80
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e5c44c8629fdb37d31546d9544b68fef7292f810 =



Test Regressions
---------------- =



platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre | gcc-10   | defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/630f5d4af098e57daa35564e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.256=
-cip80/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson-gxm-khadas-vi=
m2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.256=
-cip80/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson-gxm-khadas-vi=
m2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220826.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/630f5d4af098e57da=
a35564f
        failing since 8 days (last pass: v4.19.233-cip69, first fail: v4.19=
.255-cip79) =

 =20

