Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA8DC001B3
	for <webhook@archiver.kernel.org>; Fri, 23 Jun 2023 13:13:55 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web11.41731.1687526033980510527
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Jun 2023 06:13:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=ysvA7zpb;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-55380677566so430623a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 23 Jun 2023 06:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687526033; x=1690118033;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UYVEAdlLc9gCj6lSk2iLFVGKj971OhrgcYSuvON6O60=;
        b=ysvA7zpbyXeCzzPk/rYfZfR62ewFcTFDoGV7oHBO482mBZin9BJCOB59b8/2nKLNN8
         u4GgJHSn45rxk4ywa0eOwhTN/dvdFFPXUkTlr9iZywIdkIGQo7J23PSYdogGn/jgmfus
         PPi+Q+QVWFGB9u9PGbG2mNOvg1B03iHsCiNicqeuPPu6Bt4ECDziI4XE+A0K3g5iE7KE
         mTReEaUKCj9+I+mYk1BaqLbMPM5p3yRYfPDc4CY3iu1M9AlMADj26eMPY7HV45lrjE3g
         /ckD8M/A+3hk3J7lriPoZ/FyI6/33EObeI7Lua+IQR2tvTS2Vqo5Sf5WeQCSUh9z8994
         m8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687526033; x=1690118033;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYVEAdlLc9gCj6lSk2iLFVGKj971OhrgcYSuvON6O60=;
        b=TjXcL2YcIb4DGxPLmzaJgwxUAa7cO6wy7zVK+BblXgK96jcE0Q+vhBb/sQX4J0d6lz
         Hafl21eGwIbOPxKwsaaZQn6OJUbV78QexdsRbNbJ8FUTs0cLKmZi8z95mmNMytRSgbyX
         SQEwukiZYm7oFxBZzqQed1aH5hgk4fNfoiHANieqvEiPuBo1Lu5pfoN6mpM9TQn+dKoP
         TPKS8l8didhQUHEzGpp8SQxdkjVgRWqY6k6B9WNeRE1YZZHxQq8+ltlnkxLR+N7fWPfZ
         LWwm7z3ehhO1O9JozKRsVEN8HyvTXbQgCASqKIDXnAupIovSThi9+yr5cGe9VR45xb40
         mPFA==
X-Gm-Message-State: AC+VfDw4efwlLSH738VKAvo1hQqyGf5Jr4olQey/mPrbAwnZIameX8kV
	cpmd2KVxp7pLCnfUHdbNIFbJ61Jro4V/yBab4i9vpQ==
X-Google-Smtp-Source: ACHHUZ4bxxenEgDrrvHOqmki5mikFXOO5WuwGo5lO1GFBVjs/wz7718LO1kzL3PLqEYu5XIysVsgtw==
X-Received: by 2002:a17:902:ce88:b0:1b6:9661:e848 with SMTP id f8-20020a170902ce8800b001b69661e848mr8106039plg.7.1687526032853;
        Fri, 23 Jun 2023 06:13:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jj9-20020a170903048900b001acacff3a70sm7187445plb.125.2023.06.23.06.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 06:13:51 -0700 (PDT)
Message-ID: <64959a8f.170a0220.89024.fd40@mx.google.com>
Date: Fri, 23 Jun 2023 06:13:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.287-cip100
Subject: cip/linux-4.19.y-cip ltp-mm: 4 runs, 1 regressions (v4.19.287-cip100)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Jun 2023 13:13:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12141

cip/linux-4.19.y-cip ltp-mm: 4 runs, 1 regressions (v4.19.287-cip100)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.287-cip100/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.287-cip100
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      843423b3724d762d5593ab9aaeb68ac695871b44

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  97c2fdb137a68e1eefed07c900db1a862edcdbf8 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64958ec651765427ab306130

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-=
asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-=
asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/64958ec651765427ab306131
        new failure (last pass: v4.19.284-cip99) =

 =20

