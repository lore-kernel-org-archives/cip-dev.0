Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D64C46CA3
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 12:58:33 +0000 (UTC)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
 by mx.groups.io with SMTP id smtpd.web11.34538.1702040306651706034
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Dec 2023 04:58:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=zcoE1NUK;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.49, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-58cecfb4412so955852eaf.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 08 Dec 2023 04:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702040305; x=1702645105; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QkUnK/SQvNbJi9aA9kcuwbaPhR8tUC20yvR+AvqPVkk=;
        b=zcoE1NUKMpw5B14ew9DhmtTwWPNfT1ciVskllQdcJmLjl/z3IP/8NJgTwQcXJaaiZJ
         k+au5GwGjQeRk7zFDiLLd1BCsp+rywnEQoVux7fEYaJhihWnhId1NUQRVJVFOipctJRc
         x0Z5HrmnGX/UH3rqsyagiCrTAZhmOA5Zcy/DBoRxYbbg1d4eeFq8RTbO3ubmuXAiQJn6
         HqTokkc/qZ3CukcAhcnASvcHIl8ZQSpMCbSK9fgSMWxywBZ8AHkqgAyXXCwa9LexDBaj
         x9tsS101jYP4mdJe78+SwAzJs0VngOUJXdXg8ZXSSqOiuOoxLfw9pdY0zZJI9xGMheWg
         i+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702040305; x=1702645105;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QkUnK/SQvNbJi9aA9kcuwbaPhR8tUC20yvR+AvqPVkk=;
        b=aGe9zk8tHt6yAjMZYHrKgQWEFSnDgCBUPL3/ZmTI6jcd7TLPcIWMWimBKPX8oF+Ove
         N4ltUIpfkqo9YxOIGmJqHMwzKGUDSsdjEGD2K7V/Vn/wikuOv97uN9fIVYOMN8acCTt2
         zXAN16EVO926X6sEEk7Ir9UWDIn5zku2kQglcyMSAMDVhsrdIg0KW3W8n+p0MRSHeF3l
         9aZcI9OWuLjmwzoZa01DdjtYyon63fmlCapZkwe1V2I/vMKO9Sc4kCC0QYITksjOqmhS
         GhbciAq52wPM0GbDJG+f5xNAqI2rTmBI6t6KkqOO492c0cq3bzlKyA8rrrd6otSiglmQ
         GJMQ==
X-Gm-Message-State: AOJu0Yxi5MjHEmonrLHMwkHhuto7Q7kqE9DJ6nSGp1Y0TPLNOS8JphwX
	3rPrbA0F3NZOmC7WQ7mh18g56eay481APYhDcQNk0Q==
X-Google-Smtp-Source: AGHT+IFOfcFdpst+MC6TDfDUUrPN4ewqdJhU9Z3FJFMmnWpLCYm/rHdLIcxtNZJ8nQfiKWT4LoYOcQ==
X-Received: by 2002:a05:6358:7248:b0:170:4205:a974 with SMTP id i8-20020a056358724800b001704205a974mr5812755rwa.13.1702040305223;
        Fri, 08 Dec 2023 04:58:25 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i186-20020a6387c3000000b00578b8fab907sm974193pge.73.2023.12.08.04.58.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 04:58:24 -0800 (PST)
Message-ID: <657312f0.630a0220.bf893.1c61@mx.google.com>
Date: Fri, 08 Dec 2023 04:58:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.299-cip105-158-g856c181dce342
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 38 runs,
 1 regressions (v4.19.299-cip105-158-g856c181dce342)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 12:58:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13941

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 38 runs, 1 regress=
ions (v4.19.299-cip105-158-g856c181dce342)

Regressions Summary
-------------------

platform      | arch | lab         | compiler | defconfig          | regres=
sions
--------------+------+-------------+----------+--------------------+-------=
-----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.299-cip105-158-g856c181dce342/plan/baseli=
ne-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.299-cip105-158-g856c181dce342
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      856c181dce342f36a06ba6a8062830cca0f733a8 =



Test Regressions
---------------- =



platform      | arch | lab         | compiler | defconfig          | regres=
sions
--------------+------+-------------+----------+--------------------+-------=
-----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/65730c72dec5eb27fce13475

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-158-g856c181dce342/arm/multi_v5_defconfig/gcc=
-10/lab-broonie/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-158-g856c181dce342/arm/multi_v5_defconfig/gcc=
-10/lab-broonie/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65730c72dec5eb27fce134ab
        failing since 58 days (last pass: v4.19.284-cip99-114-g02e97826987b=
f, first fail: v4.19.295-cip103-95-ge42cfc8bb88b7)

    2023-12-08T12:29:58.991701  + set +x<8><LAVA_SIGNAL_ENDRUN 0_dmesg 3241=
45_1.6.2.4.1>
    2023-12-08T12:29:59.109251  #
    2023-12-08T12:29:59.211459  / # #export SHELL=3D/bin/sh
    2023-12-08T12:29:59.212268  =

    2023-12-08T12:29:59.314393  / # export SHELL=3D/bin/sh. /lava-324145/en=
vironment
    2023-12-08T12:29:59.315238  =

    2023-12-08T12:29:59.417522  / # . /lava-324145/environment/lava-324145/=
bin/lava-test-runner /lava-324145/1
    2023-12-08T12:29:59.418889  =

    2023-12-08T12:29:59.422653  / # /lava-324145/bin/lava-test-runner /lava=
-324145/1
    2023-12-08T12:29:59.778515  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

