Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425CCC19F28
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 18:19:09 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.web09.198.1659550745359392415
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 11:19:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=PnS/7CNJ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.174,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f174.google.com with SMTP id d7so12795083pgc.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 11:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=YuswQ0tmHVWlrrzFbPNCRJicLOhpZVCacgn5bY8IaOo=;
        b=PnS/7CNJcdk8vPgy1sdW4jkaLsa7auogKKfdpJcIipHEwZDN+xdYsQbHBKWu8ct6jT
         wQleSzYys9Xs4ht88Fo8033qfFr/DDAZdIyx6dnqa55GCxRrCMFTq/9x15JpF7wEQTuw
         mXEhKP46TaXLPZ6KaYukVWqhhT3jlN9UY34HVMj8fiyjyMidGHaOBuaFf9MhI8tnj4Vc
         SkUYkaqGEIusE6W7xKnP4G+98k+1Ms8k/26q4f4zn7pFAeztcri8sHy/3Jc1jAJiaRPs
         L0B2LT8IxyiLETdNiWk5sNjeYqCVusdnbSiPgts3XX0EBGqxqaTQVw4CrHJv58WbCoi5
         MU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=YuswQ0tmHVWlrrzFbPNCRJicLOhpZVCacgn5bY8IaOo=;
        b=IEnJRkbASfhXl1XzMMMYRxkqRAAXZLXyA0KY8BJkq+7YpqLyD6HnZ82SbrL5+gF4nC
         Oo/gm7Oc10FkfMPgcZqW+9ccio+huTZ1aa2h8N1TkSVDgrXJfDLtwtOcz6YILto6CTYS
         sJIPJDTKPJ7xINiBaiSKuPvwUqxVjZ9Bwt6dxKtDz+iJXAl8L4uFxGM4G5YfucmE6JzG
         F0JawPX8+XKpTzCCTYeCPktX8i9RymUlJqE3RYJ82Uhmg5oAxlVW+rFYPnlz1GaxPqBe
         Okp+c1OdaIptKMifapJEAfqab7VsgDSdSTvWECrLOBlfNX/8pmFgDtzH5IhQ/Mncl4pl
         QSQQ==
X-Gm-Message-State: ACgBeo0FROhw6W5Lz5CFOgiqk/wVJBqfdLfwZquOcAkLtgtKRWevYMGR
	//tM9i2canET/1p4k1lm12HxFWhCDBfJX55Q2F8=
X-Google-Smtp-Source: 
 AA6agR662sGQCqHcLaAM00uFwarL/g8Wu3NMtDOOjaGgGX4TOIzpeKguczkZRxB1fWGPDPq4FqXojg==
X-Received: by 2002:a63:2c8e:0:b0:41c:5901:67d8 with SMTP id
 s136-20020a632c8e000000b0041c590167d8mr8605302pgs.365.1659550744661;
        Wed, 03 Aug 2022 11:19:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 l3-20020a170902f68300b0016ed773cc92sm2318383plg.50.2022.08.03.11.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 11:19:04 -0700 (PDT)
Message-ID: <62eabc18.170a0220.66920.3f0b@mx.google.com>
Date: Wed, 03 Aug 2022 11:19:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-24-ga6f4ea41fe167
Subject: cip/linux-5.10.y-cip kselftest-futex: 9 runs,
 1 regressions (v5.10.131-cip13-24-ga6f4ea41fe167)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 18:19:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9100

cip/linux-5.10.y-cip kselftest-futex: 9 runs, 1 regressions (v5.10.131-cip1=
3-24-ga6f4ea41fe167)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.131-cip13-24-ga6f4ea41fe167/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-24-ga6f4ea41fe167
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a6f4ea41fe167f956d4000eaf276a1e383603071 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62eab2a7624b85190ddaf06d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-24-ga6f4ea41fe167/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ks=
elftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-24-ga6f4ea41fe167/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ks=
elftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62eab2a7624b85=
190ddaf06e
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =20

