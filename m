Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C66C7EE2C
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 00:57:00 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web10.40518.1685321818042699739
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 28 May 2023 17:56:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=3Oy/9ySq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.54, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-25632c99eecso1390685a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 28 May 2023 17:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685321817; x=1687913817;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nyUd6HEo0A4B5+gmxAVpH9RALFUMUzsEJKR4ISMCjaQ=;
        b=3Oy/9ySqi3G4JlWYMnJ0FiFzwjqaPohu/o9LwDtUGz7cx9WHRcAIM8v8N9bV9v9KXP
         s/sXv//s/hHWIOCa1hW2tZ7s7SQRIaBd0exwsurtfutafpQHSwZ7GIpVtah7vahd3VmY
         k6jNs0T7Bkw0552kKG7Ib32EZvSLrz0g5wnWiiMW3fjrrtrpXTjG4ib3I7OzY7HWRvHk
         O1NzAnn2jsbQN4UEXgkqI+KDHS1TkZTSg9VUCX0K10fHPD5kFIgSXdc2OsTG3V0R0AMy
         +WI8KM82rz5Aqe37cG5ah5nLBwmMD+WO6Ao0VCDBbtu/VtVeF+WEGVN8dQLM9WXAyXlu
         BMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685321817; x=1687913817;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nyUd6HEo0A4B5+gmxAVpH9RALFUMUzsEJKR4ISMCjaQ=;
        b=igPvZ2iAvuNnN1scKiDGfaDbnjZCKe7ANFPDsbcaz0+bw0dsHmHhplSSdBbdJnPPkx
         bdycYqb4fb6gisE9oim63vn/ZaCgKKnDSP7wmflCpOF9crDVXqpIcujZf5rto+NkD/19
         A8R4kMQKlWTqyf36ZwtX4fmyJOzQgiPAa/yBD3rtC0d+EfymHoB8WFle9LZHebnqMJC1
         64mImIFEQEfWe77Z/vEPeFPuw7WHrUyNyATaisSkLhaD+lbO4zN0fzRJHlLI/RUNkk6C
         tNHMb+/RSUzq8ICWKybDDjqV9cwbT24h6wb8eEtUKexBLXn48X0i+vc2c5Aa/l0qOt09
         AzDw==
X-Gm-Message-State: AC+VfDwTYupalfE9OKI8EGtSRXhMs/sC6OOfieHNDzb93eo16wHgVfdz
	rEtf0Trovr3xRYPL0upot6rtp9Tb4XA/lJtmurjAAg==
X-Google-Smtp-Source: ACHHUZ5XMEyZ3mJC6JzwIIU9tVKs92KEBl8rtwy6Hl/gKyQuVOkijWs3MVi1z1/HcSadHEaxWKqxqA==
X-Received: by 2002:a17:90a:6fa1:b0:256:2b9e:e0b with SMTP id e30-20020a17090a6fa100b002562b9e0e0bmr8353225pjk.27.1685321816954;
        Sun, 28 May 2023 17:56:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ms21-20020a17090b235500b0025043a8185dsm5998276pjb.23.2023.05.28.17.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 17:56:56 -0700 (PDT)
Message-ID: <6473f858.170a0220.c437a.bf5d@mx.google.com>
Date: Sun, 28 May 2023 17:56:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip33-21-g8eb0cdf459a2
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-futex: 11 runs,
 1 regressions (v5.10.180-cip33-21-g8eb0cdf459a2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 May 2023 00:57:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11674

cip/linux-5.10.y-cip kselftest-futex: 11 runs, 1 regressions (v5.10.180-cip=
33-21-g8eb0cdf459a2)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip33-21-g8eb0cdf459a2/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip33-21-g8eb0cdf459a2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8eb0cdf459a2bb2971bbf3eecc4f894d2717cff9 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/6473f17eba95c97cae2e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm64/defconfig/gcc-10/lab-broonie/kselftest-futex-=
meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm64/defconfig/gcc-10/lab-broonie/kselftest-futex-=
meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230519.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6473f17eba95c9=
7cae2e85e7
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =20

