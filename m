Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C07CCA47B
	for <webhook@archiver.kernel.org>; Fri, 10 Jun 2022 12:36:59 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.26532.1654864609849392997
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 10 Jun 2022 05:36:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=ApLeImNv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id t2so22680773pld.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 10 Jun 2022 05:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=rR8L2idFbwyd+P5Dq5ySifb9srAbpNmrCCwYFWcTqMs=;
        b=ApLeImNvznbbGwjgZvz/ZlBMOgGOOogQL9vLFYQV29AStqyXYDzXqX3AIvz9QyUf60
         GcWEDNrPCEppFsNwBno6MkJVxh2ZL7Il0DzfdVe6xkMQfi8k58tt0P+NO+RhxffG1VKz
         zTpCDfzTE8CkewtROfkjDzVehabkW2SME+fQwBzYRaB62Oh2qt24BSZR94gqt0E74GRI
         bazYVKihn35bjSJQL6Y1MGBAzQiexsZuDUtHqzgxwnOGDQLrC2VlOxlorTEZg/yIJgB5
         /rXJf+qcttiFxrtybt9O1ez04deBo2DnqefFA9hajiHLTccq2E+itBFwMQaT2a04XrFk
         LxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=rR8L2idFbwyd+P5Dq5ySifb9srAbpNmrCCwYFWcTqMs=;
        b=WsN+ai1QTeVru0487i1yrLJPSKrMp+Kho/oLazKP6I4QgIyubkbo0N3WSD+OQhB+WN
         FHaE6hUpSytIcuUjbGyQHRSESwyQx24sZbjjC22WQr/JggaIv0OHINYgsjtPVWACM+7G
         jtLxYZACT1+5eDfeL6jH0vcye0P5crN7qOGUn6mZDgLTjsl+v+z3ZsVJ0aljlJQEm5kO
         1GurgrnvByYFngSFYSzA4dtyr7MMYjmfuGVx+fCHY1Q2lpY8FySZO5JNx+Bdgg6Lz7Xl
         fTH/wkOKSt+ySkMAAx3HG9s1WwgTN3vVoTN9Swg9XszFx2S7nJmPPq0FWdbjihNS22DS
         XshQ==
X-Gm-Message-State: AOAM532AGBRvGK+f9OwzDUDPH01Jtpkg66321+JtODwmoia47viy3Vop
	Beq4M69/8+jPa1n0wQz6lM6iEGfBDK0Dw9BQhBg=
X-Google-Smtp-Source: 
 ABdhPJzF7j+L62d1Uv/lPzqTXPHBqHSocmXXR0xjMmEZNlGGBAV04qrzfcWLd7zUxE/ADZNgMWaZLA==
X-Received: by 2002:a17:902:9a42:b0:158:bf91:ecec with SMTP id
 x2-20020a1709029a4200b00158bf91ececmr45332296plv.115.1654864609080;
        Fri, 10 Jun 2022 05:36:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 g126-20020a625284000000b0050dc76281e0sm19364554pfb.186.2022.06.10.05.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 05:36:48 -0700 (PDT)
Message-ID: <62a33ae0.1c69fb81.bf627.4622@mx.google.com>
Date: Fri, 10 Jun 2022 05:36:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.121-cip9
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline-cip-nfs: 7 runs,
 1 regressions (v5.10.121-cip9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Jun 2022 12:36:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8541

cip/linux-5.10.y-cip baseline-cip-nfs: 7 runs, 1 regressions (v5.10.121-cip=
9)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.121-cip9/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.121-cip9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      bd24696dd7ad23517733728da675a00cd3073916 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62a334b2d520c854f7a39bff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.121=
-cip9/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-cip-nfs-r8a7=
74b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.121=
-cip9/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-cip-nfs-r8a7=
74b1-hihope-rzg2n-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm64/cip-core-image-kernelci-cip-core-buster-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62a334b2d520c=
854f7a39c00
        new failure (last pass: v5.10.112-cip6) =

 =20

