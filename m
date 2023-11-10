Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94B7C4332F
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 07:16:52 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web10.22836.1699600603724963921
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 09 Nov 2023 23:16:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=MDlk1Kxg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6c10f098a27so1545705b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 09 Nov 2023 23:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699600602; x=1700205402; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+4KTzzpwnGln6U/i7pwx43/E3c43EsP6rd0mKhpPDGs=;
        b=MDlk1Kxgso69jlkjmdzCTDEZ+69fcGZ6dcWJzOoVI/J6hD6lvkKscPTuUD6sp7Onr4
         LNHMzhme4Xu+NhvEZTh5/VyHzpQQbkifZDdaq/mfk/8mPN5oPmJZMCsO8CrMPGLl2iRC
         wCB2Mkou8RPoUuB/wy5C5K1sDsSJ9tQVwJRpBmpw5USQDfQP1nx6JV1lL/1bSZffkuZM
         6BNszk6jAUWiAjitKZMxL42+zRT081utUsNrZy2k4WEI4LXs0LNJMc5VsTf9A5qNtd7/
         N4WaWervJ2zjKT4V//eEidwG9IIT8Ic9trrggGrb0LdL7HGWCZXww+bdQSsh9BbZ6r5W
         XBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699600602; x=1700205402;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4KTzzpwnGln6U/i7pwx43/E3c43EsP6rd0mKhpPDGs=;
        b=Wad79ikCszIkjciA5sZNTGD+6errWVt/w206KxEZ0BIOqeVDrKfmw1VRxMx9+ah9Xg
         Bu03YGTJrdIss0nSt3QmOekbwB6IY+jICvwG3f13AQCNCfDxKH5BqXkGidusFhjp5WO0
         19jnCHWepncGsWBJtlH+zgLDhDF1aGw6V8uWDhDDpLr5ozzHNhuJaUNZ7XXn6gMlxydm
         P/Ia0uHlogEEN7XnEnmgxUm324OME1ssiE5pyV6r3MeIdZwKughb7MCiuba43pFbMwr1
         Xc3Abw76OyqcQiRX4WvzpI2+ePaS0jXSgnlXUuB1uvQtXnOtliIT0F7yKj8jlFrScLbb
         0XkA==
X-Gm-Message-State: AOJu0Yx82xHFu9EdHErUG7xcMEkvlub+A4UkgX2yZXKtKwPTGaivqW16
	JygkTCxF0M4RgUmydBNLoguHbuHiMQj76pS9nbqvHg==
X-Google-Smtp-Source: AGHT+IGLYkhK6/8HDt7gayG1gc2arSyYXizEXVEd5ZXiIlrDf9RPbdZJxfHhtdBU73YuKO2gwXh7Gw==
X-Received: by 2002:a05:6a00:2191:b0:6b2:2a2d:7a25 with SMTP id h17-20020a056a00219100b006b22a2d7a25mr7773106pfi.29.1699600602629;
        Thu, 09 Nov 2023 23:16:42 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y30-20020a056a00181e00b006c4cf21489asm969421pfa.205.2023.11.09.23.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 23:16:40 -0800 (PST)
Message-ID: <654dd8d8.050a0220.1a306.3202@mx.google.com>
Date: Thu, 09 Nov 2023 23:16:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.200-cip40
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip ltp-mm: 1 runs, 1 regressions (v5.10.200-cip40)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Nov 2023 07:16:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13558

cip/linux-5.10.y-cip ltp-mm: 1 runs, 1 regressions (v5.10.200-cip40)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.200-cip40/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.200-cip40
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      166400a23a22e665f5d880a99149b73abede402d

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/654dcc70985810062aefcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/654dcc70985810062aefcef4
        failing since 667 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

