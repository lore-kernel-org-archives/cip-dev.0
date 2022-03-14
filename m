X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web10.24461.1647251581597262180
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Mar 2022 02:53:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=UzERzu1q;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id n2so13074982plf.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Mar 2022 02:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=8hr0qAlRCdly2YBFgWgSEKr2iCJ/uj3FucrAg09kqmI=;
        b=UzERzu1qKi0EtbN1RfItUD+7TPy0/PjfNW7s7FI33Oh479ZaXDlSRQnlQVT7nMoHV1
         7Wlg+YWe99X0AV/r1M8GZV6Y82XjTzomB7DIGP2w0u7rKHWEA9bcvJA7Op61vcmVxpEy
         Y2rnw1d12ycOfMOrNZevhr3gdlgP1GNDDRi0/LiHv1T0AjQ/xuacnB19BnRS3k+zQuw4
         HIxoGr2RtdN6NOO08jX7c0CeIId0q/MPhQ3+P03bXqz5BhFuQWZF9We4v/FG3h8DiDoM
         HVtBO7kCS4DjJV4NIya4kzIdP+4Q/9iDdsF+otj5QdnQ6kt0Y6LFpLRlpgUPXBdeKItT
         J72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=8hr0qAlRCdly2YBFgWgSEKr2iCJ/uj3FucrAg09kqmI=;
        b=vPhWXZbA1GSbwPb8lD/Tss/hXzKLshC2mXNrnnGzBTlp2Zo39uF5/axIDK4Vyhvjnw
         PQrBTaLpf8OfTdW8dcPNjcKZYn1Ef/3ubDUV8g+Ze3vGOX341hxHKHTweg+NDFG9uW+p
         FClnAO304BVk+Zu8pHyMjxdMoAXhNeoCIV6JxoghZKdb8K/Fj+spGf3zAqOBBbgKEDkR
         NF5ItiL8kf7ql1SlJeX3Gy33aT+D27CrE5PvXxHh5hsidbKwkdPP90YplC3t2wl1CpHV
         kmHHzcBB0QTOnDpo3tekthbplr07PiMfuNZvO9Nhs6OrrWcCIU6Kka5NPxWYSbOktNJk
         btQA==
X-Gm-Message-State: AOAM531pSzfE5tFx67tqlrW3LlhGLRTxQSSZWoa0LQtIShoSO2Cdv8IR
	yw/ieIHl7Iqn4d6uAf3kXpsbZ35g7vysrzOWlRw=
X-Google-Smtp-Source: ABdhPJyQ5VxZXo9U2FtWV49Gd9AqFsJu4eZT1QXhFCwnQywU1RfjmdmEJXmVr6Vi3l5vamrIaPsHhw==
X-Received: by 2002:a17:902:8a91:b0:14f:969b:f6be with SMTP id p17-20020a1709028a9100b0014f969bf6bemr22763658plo.161.1647251580837;
        Mon, 14 Mar 2022 02:53:00 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id lp4-20020a17090b4a8400b001bedba2df04sm16579939pjb.30.2022.03.14.02.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 02:53:00 -0700 (PDT)
Message-ID: <622f107c.1c69fb81.68b3.96b0@mx.google.com>
Date: Mon, 14 Mar 2022 02:53:00 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.104-cip3
Subject: cip/linux-5.10.y-cip kselftest-futex: 3 runs, 1 regressions (v5.10.104-cip3) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip kselftest-futex: 3 runs, 1 regressions (v5.10.104-cip3)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.104-cip3/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.104-cip3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      811c07d2359f700f05d08c49b9d8c4333322bf90 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/622f0099804c55a504c62974

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.104=
-cip3/arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-cip/kselftest-f=
utex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.104=
-cip3/arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-cip/kselftest-f=
utex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220228.1/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/622f0099804c55=
a504c62975
        new failure (last pass: v5.10.83-cip1-178-g2cf1d12aab81) =

 =20

