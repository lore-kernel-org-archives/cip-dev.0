Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3F1C54EBD
	for <webhook@archiver.kernel.org>; Wed,  4 Jan 2023 13:22:03 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web11.11763.1672838522485297903
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 04 Jan 2023 05:22:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=lzKZGnCG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id n12so23183706pjp.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 04 Jan 2023 05:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U6iI8eX7zo8xEJ116ygpAQHA9MVrIHoWs3VFD4yIseM=;
        b=lzKZGnCGJ13Y1k9aYYYnwJeWR1cR7OX5ARve+o2w+kns8HFpoib4aCzeysgEotR6kg
         JNhXcPt//G6v9KlcA8bRPbJ8rWw6IjkDKLcsvx5+srhauyAtwLu6Ju1Sq+Dz8G5lQtnk
         qVBnzxROG4NkHXjkyj+VQELg8gH8Ys60B5/7KphSzN79splRRcL70G7vdDX/Kn7VLcCR
         VjZF/QHDCGPqHQ2V4UmWBelAEfp5LBQOCRwWrC7WVIjHLwlw7DaLJ8TVZ8SiyD6E5YrY
         2Mr00hgI2sYqAbhfVRBgJmiQoA0Cm9FzRsGPaeIKyFl6ZyHczB74vbLi5rrb3jqzMZHl
         zcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6iI8eX7zo8xEJ116ygpAQHA9MVrIHoWs3VFD4yIseM=;
        b=NMO4Tw3xl5WA++Bl4de+JeY/buY/blhg0iGnbpReWYAbG8XRkQP7TwkJ53yamC0c4E
         2otuCO/rbDNP2YElUt+y38ohICiUAjUbUj26CaFhO0Ye3ljhMengEW71CyP3IHsnCMwg
         fq+7w3oSHAjB+bov8/h28wMk/AJAofFaegtkaL7WOq8Ec7TLhu6K+9SKIEsBtlUI1IJo
         UvmqMDZ8Fklxco+l/1WX/KtLd+X/9kaJADoF33UDuQCIv7tx1rZaM5MOOOIZJ+5x8/WC
         E94DUvH9BEP6/ikfc7+QwmvWlHyL5O2cYKrb2zGocKtry4NN4+R5zMy050PDGjuhiDAZ
         WgUw==
X-Gm-Message-State: AFqh2kqid8ekqMPhDy6HVP5Eb6PHrFWul7bo8rmhAje0ZLWjmoXhAnja
	+VWqfY2Ugv6WI1cwnd0nhFErRp3r2D0UWtZ8AKo=
X-Google-Smtp-Source: AMrXdXtcCvH1gUn0Z1jMB/tLFk4Dx5XDKU8gIGyBNCxuhvoQ+iMLU/X8vcLnNpWyj4Rd10MuPVcVVA==
X-Received: by 2002:a17:902:d2cf:b0:192:90e7:41d5 with SMTP id n15-20020a170902d2cf00b0019290e741d5mr41312813plc.52.1672838521641;
        Wed, 04 Jan 2023 05:22:01 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902ecc200b0017f64ab80e5sm24148098plh.179.2023.01.04.05.22.00
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 05:22:01 -0800 (PST)
Message-ID: <63b57d79.170a0220.c1eec.5c3d@mx.google.com>
Date: Wed, 04 Jan 2023 05:22:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.161-cip23-65-gca8c192cb189
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 11 runs,
 2 regressions (v5.10.161-cip23-65-gca8c192cb189)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jan 2023 13:22:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10307

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 11 runs, 2 re=
gressions (v5.10.161-cip23-65-gca8c192cb189)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.161-cip23-65-gca8c192cb189/plan/kselftest=
-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.161-cip23-65-gca8c192cb189
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ca8c192cb189c6be84da2274a96e73320a638b43 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/63b5705a1ae830dc954eee8b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig+kselftest/gcc=
-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig+kselftest/gcc=
-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221230.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63b5705a1ae8=
30dc954eee8c
        new failure (last pass: v5.10.158-cip22-142-g79bb6f9db05d) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63b57bc6cbf0561e0e4eee1a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig+arm64-chromeb=
ook+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig+arm64-chromeb=
ook+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221230.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63b57bc6cbf0=
561e0e4eee1b
        new failure (last pass: v5.10.158-cip22-142-g79bb6f9db05d) =

 =20

