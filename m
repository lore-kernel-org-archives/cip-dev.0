Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4BFC77B60
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 08:33:02 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web10.37875.1679473980226525871
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 01:33:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=WJqXrXfB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id d13so17865404pjh.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 01:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679473979;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S+2FQPm+f/UAN+5vO750SilGImczyvP3gBiT+D/bxp4=;
        b=WJqXrXfB9fvRUnegjRKnSZEEGjW52jBE2p+ZIZvzPLjZScDG6EfUgOjjdGrdT7gRpn
         QxZEawOPk1FldhzGKcnSY7v4Sz29mnvyDDD5ZRQzjQ1jqQdb8+poorpnnxZqm9u/ZZs7
         GCwy+vjW8hMz5BZ+Oq5+2enl6ILGV6Vu93ETl06azskxCcUIvdgHGkbita+S6g2Pb9uR
         Nk6eq7lsAN+wq5a4rMYfOYy3OYSZ0cGs6YLqhuD8Jc9seqGXq6S23vDRm4d2YQlINDup
         Z85JERaUa1srebnD7HxNXL8gku+OvpcW9YMYZCn/QiO+8N7zPK91mBVkJefT0hu4hqkt
         t5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679473979;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S+2FQPm+f/UAN+5vO750SilGImczyvP3gBiT+D/bxp4=;
        b=HqwlMdmDJ6UQ6iRdGHlYRT0Rk76uqr776W1hFCPZ+q/hG0job6H+VJxjHos7W75aCW
         pbyY7IumANKlQAsQ20YTe5prhPSvy0If2tBD0P6VZyKWaG8iGLhUwmQyDajdGB8wVuz0
         FbHX2Ucz/gqNp6IfVJwQJ7yu/PcKlNgmNO3Gc3gYcbCWIiMEGdHi1irSa7AEnmU3eYrp
         KGbQ7O1reA0bYJqlHuhIkxoNZQ0Dau89J/8ka8spEOILwrKOjeX9JLVUIhaA0jVy3GuV
         zUHGT/ZhPkhjwxKPOO2PgLlaw01UL+y4V14kUDUpzuiiEyc9+0fC53GCzfncxlxJeqgo
         5IKA==
X-Gm-Message-State: AO0yUKVZKbQCxkjl86BC+DEk3yXM+glOw4YBOBSRDnokWHd5j3Yo6uZc
	IEaTr4ixOlJIL019uzKGbrAHmG2CSQt765p9beQ=
X-Google-Smtp-Source: AK7set/jUdnytAwmqXOQ3T/IbL0IQoGx+IDHfBLnXEmPU02mAcmWcce4Ae2x8rQFrdBAvxKribhIPQ==
X-Received: by 2002:a17:90b:3eca:b0:23d:e0c1:8b8e with SMTP id rm10-20020a17090b3eca00b0023de0c18b8emr2886736pjb.17.1679473979583;
        Wed, 22 Mar 2023 01:32:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bh9-20020a17090b048900b0023af4eb597csm12843825pjb.52.2023.03.22.01.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 01:32:59 -0700 (PDT)
Message-ID: <641abd3b.170a0220.62d1e.81ac@mx.google.com>
Date: Wed, 22 Mar 2023 01:32:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.175-cip29
Subject: cip/linux-5.10.y-cip ltp-mm: 7 runs, 3 regressions (v5.10.175-cip29)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 08:33:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11058

cip/linux-5.10.y-cip ltp-mm: 7 runs, 3 regressions (v5.10.175-cip29)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
                 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.175-cip29/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.175-cip29
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      bb7267e6d2a6f131bb46ba14f0d3c418379e8bd4

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  f3463a347c37b44bafdf4e882cfb932f6888905d =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641aa964bcd66af1329c9518

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-a=
sus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-a=
sus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/641aa964bcd66af1329c9519
        new failure (last pass: v5.10.173-cip28) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/641ab8acb42985ea7a9c9505

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/641ab8acb42985ea7a9c9506
        failing since 434 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/641ab8d2364a2a7ff79c9505

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/641ab8d2364a2a7ff79c9506
        failing since 434 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

