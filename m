Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665DFC761A6
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 08:31:02 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web10.37846.1679473855454139101
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 01:30:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=cEkr1ess;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so18430598pjz.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 01:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679473854;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t/KCiHADNT1GEvBtXHOrh7itkNaBXwgXZbJNkb87mtQ=;
        b=cEkr1essXPlWZIEG/cc1Sx2tr2kZ2znE55x17memSNQq4eZjKD+R7VMb3GHC8yqmrR
         Bmlif07Ep9jGjSYlkQXY+Z5pJGSvCqW58RT2Ch1fpNdgGDaWS7OK6c2ON7TYDSByMl+U
         X7AEzUbgIDopoVAuAZcFYL3v0xlgK+Pb+lk83IlimfyCGUhNOPAOXNoPARuNBIWNhu5+
         PcoSVLzPFjaYK04TJ7Ow0P2DXtr7riS/plVbOKSwpiJwDjtLIYB6rOhjCJaZrQaAWZbG
         8ZggecBtVw7AVH2+sBIm84058cXdG2astZERP2t0DxU1/UnyNb7Q8KI3am6St/+Zh4/p
         F6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679473854;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/KCiHADNT1GEvBtXHOrh7itkNaBXwgXZbJNkb87mtQ=;
        b=YqkT57YmsjvQA6oHHJGAHmwuWEFK9vOxG+XFaKUztjEHrIC5xK8tf5GkcikGrJ4sn2
         Mnk4wu/a9Eaml/mdmVyko+pPv5/kx8h6/A0HMEmUgNYKxYbuZ1LmSKceyysQ1Scqdcsi
         IqxgVuNkbMk1YuiBoI9LpmIkPbDpey2spe8hAcoxzN5dz3FWWgFBk+SiGvjdGM0gwUf8
         wYH6apXrVNvuJq4XUy2NDzNMkK8KPkMuyRyZqY0gx0aBbeFGAcliD+ASArO/7Pv4kQ1x
         pBE3FDNTbf1BC5pnVw2mrNgZ5wyGDiAsEyfnwG84Zh+n59mmuzEOaH0YYHLIc7COMBjv
         vKFA==
X-Gm-Message-State: AO0yUKXMIrzQaZGHbFJrkDoo4y4THGT84NBM/wu1+z0KOTN4oQGLL1uW
	Ksb3uB/YCwc7tNATBeSTKmWG32b2t6RbbSdJ8rM=
X-Google-Smtp-Source: AK7set/ty0ckXSe4ta45vMdKCpV5wMixJVvhDWZySm1CAaBGhj7ISSa3XJ627sCMhJrHW75BMkTo0g==
X-Received: by 2002:a05:6a20:9307:b0:d9:3750:3a64 with SMTP id r7-20020a056a20930700b000d937503a64mr1499042pzh.8.1679473854663;
        Wed, 22 Mar 2023 01:30:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 14-20020aa7914e000000b005e099d7c30bsm9464853pfi.205.2023.03.22.01.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 01:30:54 -0700 (PDT)
Message-ID: <641abcbe.a70a0220.bd484.137d@mx.google.com>
Date: Wed, 22 Mar 2023 01:30:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.277-cip94
Subject: cip/linux-4.19.y-cip ltp-pty: 6 runs, 1 regressions (v4.19.277-cip94)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 08:31:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11050

cip/linux-4.19.y-cip ltp-pty: 6 runs, 1 regressions (v4.19.277-cip94)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.277-cip94/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.277-cip94
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7027f305d14858b8392890a56cfe71edd50df202

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  f3463a347c37b44bafdf4e882cfb932f6888905d =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641aafa5560885d7c39c9579

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.277=
-cip94/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-=
asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.277=
-cip94/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-=
asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/641aafa5560885d7c39c95=
7a
        new failure (last pass: v4.19.276-cip93) =

 =20

