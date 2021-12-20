X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web08.1926.1639976359935919723
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 19 Dec 2021 20:59:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=isVQiWI9;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id 205so3503147pfu.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 19 Dec 2021 20:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=E7PVAHxyQBiKIpRxoiFzsdctxUZxyYrOl0zMR4BpHh0=;
        b=isVQiWI94LCjdVkt0Oi82ZE/WgfScoE2TGyKbzx0v7Wlep9q0Q4OToaSB1zlfwxI3y
         ZHORcyzaPFz7AP/pt78jRqPv9Ilrl/m/37OA/CznCvxjU54wtlfvWqxNlRbLVrN8NhUM
         KJBGBV0yAKUMMakmqfQaFc15Q6XtWVRs1XN1WbyzwEhIB+76pSmt9QUqIbWZKvUw5F+U
         FJMiV1mdM6Qaq+1lj6SxCmpXogfBnk4O5WzvGYGG7qZe59bTPnvzZp6i0mZ96aIGJfWE
         9UqhoSU8ABEIdCprBqvjDCaE1iuV2KJ6e0wTgsa+ICRY/G32PsbcqxUt801WU/0HrCCT
         mV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=E7PVAHxyQBiKIpRxoiFzsdctxUZxyYrOl0zMR4BpHh0=;
        b=g46aswH/8PIBJ6ESk4kh3KbYvoaJjn4vfWIHTovSzWRCpgYVjbMxOskvKHYKugNi0s
         OlDWDl+/SpL7XeNmSr+XwQOM9XHKDGIxvCvAqNfnE8niOIOKTDX5fwRVXIz/eISpeAvc
         Fd5bNTM6zUP7KHHuc5koNGtBb/vEDlwDjzQm3xkUwm/LBSfY/9HSsa83bPpl62CHnbIO
         RYvvfpoOCc9c/oiNcGZYVmxNYaZ3WGlJ0M/LZANQGRWczySGEyagNF9oFvHx2d9VV8e4
         UFYDHNB0xkEzWSYI7Ask6fmWC6jGW1x1pDdLKoub732rLc6RSW828qcARWd3Xd95lO0A
         3nPw==
X-Gm-Message-State: AOAM532JvZmLo0TpdmwMHjtimM1mYWTXmVuDKpzwim6UKlPh22WnbIWn
	9xMs0atVmWih2pOjn18wnTJxuwWks2fMNqYr
X-Google-Smtp-Source: ABdhPJxzVCPCv+tYQOsIV00MJrZroMdkyNxnBFc+vV4ot/6TJhLtB6/8rd+WvOUuGxK64c8qp0HMFQ==
X-Received: by 2002:a62:1dca:0:b0:4ba:cfc4:1af7 with SMTP id d193-20020a621dca000000b004bacfc41af7mr4243989pfd.58.1639976359285;
        Sun, 19 Dec 2021 20:59:19 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u5sm15322616pgm.60.2021.12.19.20.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 20:59:19 -0800 (PST)
Message-ID: <61c00da7.1c69fb81.29193.ba5a@mx.google.com>
Date: Sun, 19 Dec 2021 20:59:19 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.83-cip1-31-gdcbef6602957
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline-nfs: 19 runs, 1 regressions (v5.10.83-cip1-31-gdcbef6602957) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip baseline-nfs: 19 runs, 1 regressions (v5.10.83-cip1-31=
-gdcbef6602957)

Regressions Summary
-------------------

platform            | arch  | lab          | compiler | defconfig | regress=
ions
--------------------+-------+--------------+----------+-----------+--------=
----
r8a77950-salvator-x | arm64 | lab-baylibre | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.83-cip1-31-gdcbef6602957/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.83-cip1-31-gdcbef6602957
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dcbef66029571fbada7522b2db0790e5ff054c66 =



Test Regressions
---------------- =



platform            | arch  | lab          | compiler | defconfig | regress=
ions
--------------------+-------+--------------+----------+-----------+--------=
----
r8a77950-salvator-x | arm64 | lab-baylibre | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/61c0042fd454aeb76139722c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1-31-gdcbef6602957/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-r8a7=
7950-salvator-x.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1-31-gdcbef6602957/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-r8a7=
7950-salvator-x.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
211210.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/61c0042fd454aeb76=
139722d
        new failure (last pass: v5.10.83-cip1-7-geb3270fae08d) =

 =20

