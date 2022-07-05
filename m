Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295F2CCA47C
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 03:04:45 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web11.79838.1656990284405595309
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 20:04:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=zlunLQ7W;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id o15so6374827pjh.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 20:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=y04nW6lyXzsUsD0ThYAbfVnBDvVnKIBUqbyTcBPWw9s=;
        b=zlunLQ7WOAR/Cj07KhupvQvlDhRvZ/wf0niZCminGBIah3tB978PBuQHpUaHun0mWm
         9nok5dP6Sg5OV/qghGUsoI8WT/reEIO9EpJqluqEmGFiG++BpqkvcD2/qyVMcOuVQy7u
         esBCx+RNsFrrhLY9ulN6YVISImSwJNXkJT8R63aAZDKsdTT8zff/y9mRhBu4+QtxUv2E
         7aOjrtSeeTHyKZo/EzfIHoXkMkFf0tPjmiF4CfQn0qpkIjeZjdPKWAPQSLPlGukyO4zi
         6YtLmkcCs37JouiGsMw4kRzdq2Tlko4h4HTIbXxUa5hdBafIa9BY/kPSzFi+v4fGv5g2
         Aa5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=y04nW6lyXzsUsD0ThYAbfVnBDvVnKIBUqbyTcBPWw9s=;
        b=NEeez6BZQe3bC1d4A5jcbBniWX8R97ilU1S+TCxgPxlCQZ/q2UvR9H4pOQzoa5YML+
         y+yzCLr6DUV8cDiPxMS91sqX7Ikv3ZPzEgaYN8PvyFXFbqHpWoPLsFy6HXNHxUj8WSMY
         CruemDj/xjMrdY/lhYUGW9+s3vPLKYdpl63zgqFU8xEz6abB3f3yvZRW0dBlDzgBuyJa
         mwsFdl3yy5t8aeD3SZk9s/vvlsxRJ+J3GNkhCNl4CqG4TNqedYOBgMMWzkj2hjo/xWSu
         5pmLA9EwM7SOGW2XegOafyreeDEmeSvETdd5X/euk5MlSBE+iyYDArPokK/eqRoa1945
         Hi0g==
X-Gm-Message-State: AJIora9q/SxfG3/4rRQPaevHaa077kVpy4k56xU+gdq/NRSuE66N3Dub
	+y3Y2iQExM+2oL8o6M/zzWYMTgEDnZ+zYT/s
X-Google-Smtp-Source: 
 AGRyM1tkLem50zm/5v4wGQSlFgtlou/oJefzOMNuV/rez9URcCoVKlqixfZKjJxxhi+YCSjK74NEzQ==
X-Received: by 2002:a17:903:2406:b0:16a:fd0:a65e with SMTP id
 e6-20020a170903240600b0016a0fd0a65emr33895635plo.124.1656990283719;
        Mon, 04 Jul 2022 20:04:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 n12-20020a654ccc000000b0041175e3ad46sm11602147pgt.32.2022.07.04.20.04.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 20:04:42 -0700 (PDT)
Message-ID: <62c3aa4a.1c69fb81.57906.0dfb@mx.google.com>
Date: Mon, 04 Jul 2022 20:04:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.125-cip10-119-g603acbe1aceb
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 6 runs,
 1 regressions (v5.10.125-cip10-119-g603acbe1aceb)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 03:04:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8660

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 6 runs, 1 regressions (=
v5.10.125-cip10-119-g603acbe1aceb)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.125-cip10-119-g603acbe1aceb/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.125-cip10-119-g603acbe1aceb
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      603acbe1acebe85cab7f594d9952a493be976262

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  e98f9465925434349d0aa6eb71e81b5464e76df4 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c39918610ac06b6aa39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-119-g603acbe1aceb/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-119-g603acbe1aceb/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220610.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62c39918610ac06b6aa39b=
ce
        new failure (last pass: v5.10.121-cip9-287-ge9094c8446fc) =

 =20

