Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D05BC77B60
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 10:38:33 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web10.39374.1679481508807410770
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 03:38:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=V6EPdzd0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.175, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f175.google.com with SMTP id y19so10259706pgk.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 03:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679481508;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8GEzYo1adn63Q9wHdHfyYA5LMjAwf9gDRwGhfFIuRsk=;
        b=V6EPdzd0Ay4lSq4PhiESKfaZ0Fe1eqdxN2DIRjeDuLuJYfzjUtyK0rxBFtXxZwXSGd
         kGZE9TynilBYACoFut6w+v+tk60ywSUAtHqiU1/nYR5yJX4iC2nB9Ip/SthRNm6zVZAt
         kDmDZS6z2taM9t68J/618fop8mVX6+8foUVwi8eWtrOZVJYaEDwjM80/dqz881E4Fmic
         rj8F/jk3AmElv9fJ+UwxBwnazMan+Crj3H8wNeKXDf5JzYTLNX6ZWM14cSXZdzSrnpio
         JVmjWC4Sfh4V3v6/PcCLkeAZ1hqVd5ATBXZckUrENQjWQhng3CBbmzHjXN1rNa3IVXTR
         wkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679481508;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8GEzYo1adn63Q9wHdHfyYA5LMjAwf9gDRwGhfFIuRsk=;
        b=B+dsbQUbCQG5eYNrLSpRaKLLCKXPVAoa0ymd/Trr1bND1/Oi2WDvUWMNQD2ZkyN6nu
         weO/jKuKrom0nw7rum8FdBWsO0+j2R/7W0wyq1deriAmPXKCekRYOBOOYIIFVIxl3awO
         ht+dg/jog7/PQWLK0iBHiz3AZXLL5BTMnMlIiSWajjaLYOtqrVQWex2hLPp5dC93d0T0
         36+7EKeRcFcmFWmMCHDiLui6jpksZlq3/+1bUK3D6WgAAR91OU0LaOSwbr2i8dk2SLgC
         uEMBwhg8yCXtL7WyDRdNSLcv8JpTX3c9FfuVSJ3/tBRvqHc6x3DGxkl8dW0zAW7Q3Gqr
         vhaQ==
X-Gm-Message-State: AO0yUKVYYsoB7lkZCQgLytKImToin92EgaxIUiroA4VctkvHR4wWHKFB
	7DHPddTQbqmU3y0TT76KOcVQHiUny4a5ui5fue8bmQ==
X-Google-Smtp-Source: AK7set/YqHHZtaXN3JQ+HAnGX3zyl3NaXluhgR6yP3R9cJDl99HwAq4sprIEyhL/6tE//AIcvsjubg==
X-Received: by 2002:a62:84cb:0:b0:627:f837:2f5b with SMTP id k194-20020a6284cb000000b00627f8372f5bmr2730052pfd.11.1679481507956;
        Wed, 22 Mar 2023 03:38:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c18-20020a62e812000000b006227c3d5e29sm10130421pfi.16.2023.03.22.03.38.27
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 03:38:27 -0700 (PDT)
Message-ID: <641adaa3.620a0220.dc165.215a@mx.google.com>
Date: Wed, 22 Mar 2023 03:38:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.277-cip94-1098-g26d9f86d942d
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 9 runs,
 2 regressions (v4.19.277-cip94-1098-g26d9f86d942d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 10:38:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11068

cip-gitlab/ci/pavel/linux-test ltp-ipc: 9 runs, 2 regressions (v4.19.277-ci=
p94-1098-g26d9f86d942d)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =

asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.277-cip94-1098-g26d9f86d942d/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.277-cip94-1098-g26d9f86d942d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      26d9f86d942d1c22bb7542618e47ea5c0e6b4026

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  f3463a347c37b44bafdf4e882cfb932f6888905d =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641acc7b5b1b0a17649c9539

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/641acc7b5b1b0a17649c95=
3a
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641ac9b8943c6ff70a9c951b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/ltp-ipc-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/ltp-ipc-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/641ac9b8943c6ff70a9c95=
1c
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =

 =20

