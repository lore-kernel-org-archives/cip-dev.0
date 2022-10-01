Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A99C433F5
	for <webhook@archiver.kernel.org>; Sat,  1 Oct 2022 20:31:58 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.1449.1664656316309189695
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 01 Oct 2022 13:31:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=GfshvuXv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d11so6684252pll.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 01 Oct 2022 13:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=71ktoq9Ie8QbzNYLhqHz4MPBBDdvWKuZD6J1FDWbb2w=;
        b=GfshvuXvQPwsi/jPxhdjGdQF31WW7nAlUyOnr9xvFeV4qQcmDtt0AoPPsPEfSNpgRv
         tdWJWum31RtrCUxxFjy5pksYDgTWSSXPVv46IwgprPfuwRnxmwEUhQOnvuo4sx8OdMgt
         dfD33Boxu3p28+unepGrGzVJ3Yir+IxEFzbLGBXwlMfvNTEYje31LN8xZKoMx6dxwrYF
         lvDSewXlLcapJ26K1xXT564c4CANZUgt6sfsZdReiNQFJA4kwlrhqH+jSC0lWeXxtAUy
         O9UJhJLJIJejgb91yGPXo4aUMS37GIbI0ACHa/ZYhPz9auGsBOUo4DJwHjkmVfrme+QH
         E/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=71ktoq9Ie8QbzNYLhqHz4MPBBDdvWKuZD6J1FDWbb2w=;
        b=duqk5vQnnQ47NYNGMFwzXAVzDTCbRDVHA5k6mGJDzcYOQH9j7gK9Tq8zIg9JcxqUrP
         yH3U0wY/TJGaX9qGwt50fNJZ2PVnjfkAurTpod2VoDRfdomdKkyirSF0WtReiX97T384
         tGynrR7oDZvxUW6xsikbNhFFQQYyoulCfGzbsyBZ+nki9ndhdEt/5WzHVVwvO/KpdAxX
         vjmUiEWxe8pTSD7vJ8DrPRR0hX+A7xGwBxMbDeJC4uCp1aXKBW+jBDexWYIWwVOxMFaG
         3BpeQcjn0eGHJBR2e34HuKuWULQqdPC5sbsboJmip7mn1nXaoYxK/7B6mnxgR7GjIa0u
         q4MQ==
X-Gm-Message-State: ACrzQf1Guh8ou+Lrjs1YnbHota5xegSPukmCOlAnCsi0iSxVfOIqik/W
	ijhgSJSr5dAm9CNNWv7WY0WlHoJDcwyqEMru1Io=
X-Google-Smtp-Source: 
 AMsMyM5/VyEl4FhnXfipOrrj6UAruhW3AU/8Loy6r1m5DV6ig4XhBMIRdKqVtBLBzzRDkkDW5N9MVQ==
X-Received: by 2002:a17:902:7589:b0:178:4ded:a90a with SMTP id
 j9-20020a170902758900b001784deda90amr15264771pll.74.1664656315301;
        Sat, 01 Oct 2022 13:31:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 x125-20020a626383000000b0053639773ad8sm4160618pfb.119.2022.10.01.13.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 13:31:55 -0700 (PDT)
Message-ID: <6338a3bb.620a0220.f5682.6ef6@mx.google.com>
Date: Sat, 01 Oct 2022 13:31:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-cip17-rt7
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip-rt ltp-timers: 10 runs,
 1 regressions (v5.10.145-cip17-rt7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 01 Oct 2022 20:31:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9611

cip/linux-5.10.y-cip-rt ltp-timers: 10 runs, 1 regressions (v5.10.145-cip17=
-rt7)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
              | regressions
--------------------------+--------+---------------+----------+------------=
--------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.145-cip17-rt7/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.145-cip17-rt7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      411cd76b5afe81569858976d0e9819ab48717fcb

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  48cfd7a9977e6268b4aa2600608cebad7e0e42b8 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
              | regressions
--------------------------+--------+---------------+----------+------------=
--------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/633898bc7f4bce1475ec4ec4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
145-cip17-rt7/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
145-cip17-rt7/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/633898bc7f4bce1475e=
c4ec5
        new failure (last pass: v5.10.109-cip5-rt4) =

 =20

