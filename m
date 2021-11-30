X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web09.71393.1638240014773085640
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 29 Nov 2021 18:40:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=TrjkZXrT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id p13so11340458pfw.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 29 Nov 2021 18:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=1N9v1JSs91k4UTLN3oxz27unoaVZlmmpXKjhGsw1fEU=;
        b=TrjkZXrTb5hirGC8yYYpJFtZHZ2v5Foh6e3+7284ETCArfp3comhUzStEyKWsSXhmG
         hevmDPgOEtl29iis3TXK/VfP7m5jrMXc8dZ9bBiH0+uGRtabFM3dDG2i5rVG9wt3LT4D
         YCCfdwHLR/aLBJetn1d4NuEvqGto1t2LouCXeP9ZPE7x60SIuubFZTOvzYj8ftm8c1ti
         hHGp3FdQU/wpieIYJiSE82yo4afy1mr9shNVhHAsTeAaKj29N5Wr5Lj3clZ/qJugaTwx
         F8mkJs3awDVueMc+E87FrytgsqR+kdVpsONFHFRdD0pnzS2WON9djRxHslMPtCT8tEWO
         HLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=1N9v1JSs91k4UTLN3oxz27unoaVZlmmpXKjhGsw1fEU=;
        b=UmL/SAIUznQBNIrCE1nxUHbKAeBpbVkwszelrmnK+XBG3AHqHbq6GbIcuXxd8bDuHR
         HNmoHzA2zd1l0le/watg6YyM5FW2GurxtYB+KIfH7H3L3pYvLdlTVgJRlu0NbfTbDy7S
         Mebmjc5l1jgrNf0sjF2N0sEIigaxNHLnrl2DOgWBnBujRdoQuW6C+RfQssVf7L8Wkkxf
         p7R/ChgT9BlUKlVyCgRs/kD8w+zqbAUeylgZVIIw+ZcvopzeEvSEdeDkOYwHQdEqJo8v
         dxxPOOBnvzfGkt/K3OBg08/o7gOjPUHZZSl3pfB2P7THbiI3m2XXVgR/57IQNQia0eus
         nylQ==
X-Gm-Message-State: AOAM531RcEJt+TPe2F0jNkgmuuXtB3v6CtdezA21Z4qsCjV0VcqIBC0b
	0thq8mQhduJnPtyFs1NqkyCNXB0vJ4bH+IIJ
X-Google-Smtp-Source: ABdhPJxghDhYkVE27PIX15gSkve0VCVMc1WlboO4kGeSY/rSXRHVML9dBgqzjuJP2WU+m4YCkmTfuw==
X-Received: by 2002:a63:e404:: with SMTP id a4mr34985792pgi.145.1638240013771;
        Mon, 29 Nov 2021 18:40:13 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b10sm18876554pft.179.2021.11.29.18.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 18:40:13 -0800 (PST)
Message-ID: <61a58f0d.1c69fb81.10029.4ed2@mx.google.com>
Date: Mon, 29 Nov 2021 18:40:13 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.217-cip62
Subject: cip/linux-4.19.y-cip baseline-nfs: 12 runs, 1 regressions (v4.19.217-cip62) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-4.19.y-cip baseline-nfs: 12 runs, 1 regressions (v4.19.217-cip62)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.217-cip62/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.217-cip62
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dc62e26e3be875a7324b85b8274c13a335e610dd =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/61a58c2989f6953bd118f6e4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.217=
-cip62/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.217=
-cip62/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
211126.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/61a58c2989f6953bd=
118f6e5
        new failure (last pass: v4.19.216-cip61) =

 =20

