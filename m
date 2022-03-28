X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web11.917.1648506489333978077
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 28 Mar 2022 15:28:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ZTlQ4nWH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.54, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f54.google.com with SMTP id p4-20020a17090ad30400b001c7ca87c05bso549914pju.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 28 Mar 2022 15:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=r8I8DrCBXacWUZ+Ax8id10XJ8fs6bPNpcwZjZe2PnSQ=;
        b=ZTlQ4nWHzbQ24U58KabdAwcuXRFBdbbMzQ/MFGFHMdNL/7bFpiGrUbjrFgjxwSwlFN
         KbNipO5QQiSUYyofbjFmF0uyZs7d/bjQQrCKDfWTmaDopPKyV/FWzW17xD20Fn+stSQ0
         HCXr/kLTOzKn+gS8LEuPooEAHaPtFyJUNYstdd/8IXuqM0p2pD1yAxOIWigMdZBwRl8d
         Bz/Eb26B1F0IUUX8w0wjBKQnfzhNwLTL7JWmBqu4X5V93nsNQbfKGDl2prFxRJG3oyxd
         bYjS2pY5pXAbLgnBFZIljUAcus23VlRu/BLlCweQ7EBHM0IwfxThBOEKn+dJbIYCoMZJ
         s1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=r8I8DrCBXacWUZ+Ax8id10XJ8fs6bPNpcwZjZe2PnSQ=;
        b=z6gFjYJODJ6iiwao+UNWVdLid0+QXZSQt1QjkdrjGZE6UJecqH91AZnUDfP94VC48V
         2+sPKN6Y9bB6jGSf+mvfONK+1A3R6/KbnjMn34uN1mDyRUd8eLIgXzJbLfwY1hcTYGta
         Eg8qwKKkSAaqA+bBdoJWmqD1sdn+G4s7G42Mwj27FVp7SKIKp/6yZckCtbNeI037MPPW
         drPI0ga17OrBA7QbwudNGFHc2c+51BH2PauR1KYgzEbglbeXTew6aYBrvZsaFhuUbPfM
         K/KOJQhiNmP/azSXIjm7sWQOQHB/r23mhY0fUX3ruB/4xEQpx2oA/Io5qHWVb2h7fvkL
         dFLQ==
X-Gm-Message-State: AOAM53050RekuDSL0088jm2YGJupSbEwCl4/F9l/vx6CrhVyxRnyc5sN
	AztuZtdK33U2f8HLHPj5gLuk3Elx1HbeIzYX9z8=
X-Google-Smtp-Source: ABdhPJyoFf78WyzIF8ChQA5uPIbd3LKElNPPK+N3NRgL3JE6+uNUR6R4jB8iCuNPuhp235Fgixzasw==
X-Received: by 2002:a17:902:e9cd:b0:153:f7db:138 with SMTP id 13-20020a170902e9cd00b00153f7db0138mr27369213plk.174.1648506488377;
        Mon, 28 Mar 2022 15:28:08 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id nl17-20020a17090b385100b001c70883f6ccsm477316pjb.36.2022.03.28.15.28.07
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 15:28:08 -0700 (PDT)
Message-ID: <62423678.1c69fb81.3c0b5.1f06@mx.google.com>
Date: Mon, 28 Mar 2022 15:28:08 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.233-cip69-142-g40322771bdc1
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-ipc: 7 runs, 1 regressions (v4.19.233-cip69-142-g40322771bdc1) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-ipc: 7 runs, 1 regressions (=
v4.19.233-cip69-142-g40322771bdc1)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.233-cip69-142-g40322771bdc1/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.233-cip69-142-g40322771bdc1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      40322771bdc1d32499c228464c031d6a0779e3ca

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dc836ec4cd4e02e1346001f828c1f1988a8d7d54 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62422c066f6943a40eae0681

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-142-g40322771bdc1/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-ipc-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-142-g40322771bdc1/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-ipc-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62422c066f6943a40eae06=
82
        new failure (last pass: v4.19.233-cip69-120-ga36ab9aceb93) =

 =20

