X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web08.9903.1648046204221601491
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 23 Mar 2022 07:36:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=SDvn/z9x;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id jx9so1831323pjb.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 23 Mar 2022 07:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=QT8udALDXVgxQXqkBXF+CbHpxRPUQx8VrBUSzqZGPW4=;
        b=SDvn/z9xwWKl1tz0jgbCMDlFVlO9CXtrwDgFjwPxgBPnF/g6Y2ZABJo7aPibcHMt4S
         JLM3YSmCDaZfbTBdPoF3rb31KpYj6TeqtCiy9BgWg3GXQFsKdGzymRqVG6uCLiGv2hdB
         ufStYaKu7UPaSdewtkg2TVwQ801XaNzZDZEpS0OD3Lk7Jt85UzDyDEq0RYvhkGi0KOnl
         tB/JiRwoaylP/HTXXbaFvFdw7qC4CsQfJfVbNbeehqqkU2388tT/WlU+2AipdC0sMbxA
         MgWMIRH6h7qytTB4dfXDyb4lni+JsgI5tds915E5KSs7g19kC4W4GaNAAAK4SuyqIQ3Z
         Vwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=QT8udALDXVgxQXqkBXF+CbHpxRPUQx8VrBUSzqZGPW4=;
        b=3ENEzchlGfXd+4EP2kiII0aOn0X9mKRY+zMTSPDIJGWB1iDC2FLTrWZmLCNkiwZ9lo
         tvnuJEyzO03qEdnsNvm+ITtKygtDMFlS31SWEXTlqOi+8hVOTToaIAxmaiEoaqijQgkc
         0/FHbMfHmC0spHzvQiQ6Rb8hRfhLgnnMDD+f+nE9n7ZrXeqouGP+z04POsm9nVsR9+EX
         MPn8dh/3lpPS90szgNuHjXXINQKl8VaGQNKp3esVxM+eutXJPzABD/RfAB8WcrfGhDGk
         KGbl0oNWDLVTR2sUYEnXx95WIQUz/wwmwtS/D9kX9+bc45rKGybyQrEGuttzGkEDNnLM
         sExg==
X-Gm-Message-State: AOAM531/2+ibbqw4wTBbWe6Y/XMcbS1Ah5dGdZEW0Go9v7Q8daaBWt3q
	3xi1IoObXzJLOanuPkQL+spofR5ftbP6eRc5kxs=
X-Google-Smtp-Source: ABdhPJz2Z1hBk+Ob4i6JB1lrCHWJFnnTXrYSxZNFkDWQOCQE25u5kRVU2w6tVjSboI12NPqYkKbfSQ==
X-Received: by 2002:a17:90a:730b:b0:1c6:781a:312f with SMTP id m11-20020a17090a730b00b001c6781a312fmr11951745pjk.53.1648046203527;
        Wed, 23 Mar 2022 07:36:43 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m19-20020a17090ab79300b001c5ddc6ff21sm12721pjr.8.2022.03.23.07.36.43
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 07:36:43 -0700 (PDT)
Message-ID: <623b307b.1c69fb81.7da8f.007c@mx.google.com>
Date: Wed, 23 Mar 2022 07:36:43 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.104-cip3-186-g758e0f22e236
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 5 runs, 2 regressions (v5.10.104-cip3-186-g758e0f22e236) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 5 runs, 2 regre=
ssions (v5.10.104-cip3-186-g758e0f22e236)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.104-cip3-186-g758e0f22e236/plan/kselftest=
-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.104-cip3-186-g758e0f22e236
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      758e0f22e2369c3d29d49c89c4ab585390c74a82 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/623b235f6bdedadae6bd9192

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-186-g758e0f22e236/arm64/defconfig+kselftest/gcc=
-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-186-g758e0f22e236/arm64/defconfig+kselftest/gcc=
-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220311.1/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/623b235f6bdeda=
dae6bd9193
        new failure (last pass: v5.10.104-cip3-155-g4f07dbd2df49e) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/623b298d243c950906bd91e3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-186-g758e0f22e236/arm64/defconfig+arm64-chromeb=
ook+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-186-g758e0f22e236/arm64/defconfig+arm64-chromeb=
ook+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220311.1/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/623b298d243c95=
0906bd91e4
        new failure (last pass: v5.10.104-cip3-155-g4f07dbd2df49e) =

 =20

