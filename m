Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F21CD80C6
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 12:21:08 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.89529.1696940461264457076
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 10 Oct 2023 05:21:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=zKUqJSdt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1c9b1e3a809so4783235ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 10 Oct 2023 05:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696940460; x=1697545260; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6H8fK1QYbCrUmYndwy4WCE6u/oc6NuucPpQ/EOouIn4=;
        b=zKUqJSdt/YaeYes1tfUiUAK9GQsqpZC4Q937985/X4UItTPH+ar3XVCY/FDsOirSzW
         NrCAPuQbAV2zzSnWQtjlpeheZnwy4SwWsCFxeHl5qMO4eHJwPP3BlNylfDegp0jBz7KI
         xGr6n483ySqfzB5+piTbzpiX2MBu5646+pIw6Jgf8jkUxm/LT39LBbiG+KBy05La3M1b
         YI3hWhgYoTvj2KeJe6y9Ia6p6+t7lhYhGHp6QK1iEGoHFmyO2lT3AiAs4hCxKpA0goAQ
         dDAVmMh4utzlK3g+4c9DXriW/2ZQUJi15PO/88S8JAfSiv2fF7nBnjtk5sp0wOJPj2PH
         BUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696940460; x=1697545260;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6H8fK1QYbCrUmYndwy4WCE6u/oc6NuucPpQ/EOouIn4=;
        b=KwTOiDfazdjhpe7kwt8lBBrghmxH11XNbNaSSkxDYHYVWIKEcp1/VVuEK/knIE08n4
         tuANsB1AtDwKnhm5ywKQJZJljpspgRau+l8UGy9lMWn0Sh82ENjXNTPQqHp5CIyg00hX
         5bCzSt4Cw3g6TcDVYwkkNiJsh00xI8QzXyZXyYemfTzMTgfJGzgyXCyWGVV945oBSDk0
         +vrE+8Am4Y6PwhrHeGbsXqcf5XcV58sv+Zi7n6DtzdpI3xczxBZZFRoLH5ZbYDC9fy73
         m7o3KQaNMsGrpodh1gtumSucdHkQqKP8J7jtMTwfD/fj+WF6bgGbpSxyTirZPOMN2OZZ
         Nm+w==
X-Gm-Message-State: AOJu0YxnW6pbO/o4PT+YsIYO7sJMgi2F8iedYt4DrilyoyfjahMaTIcz
	W6q9GWjq/ZdmbOjoMxWEXsJ4oEgmj5OD8awRE6kIcw==
X-Google-Smtp-Source: AGHT+IHrBRuwwk5atw6idtNpWeyU9lb8mBBCK5czflzVi4yWBilqojD9HRS7YHcbO3+TFzIftRB/0A==
X-Received: by 2002:a17:903:11c7:b0:1c7:6fd8:442d with SMTP id q7-20020a17090311c700b001c76fd8442dmr17708225plh.67.1696940460313;
        Tue, 10 Oct 2023 05:21:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ij25-20020a170902ab5900b001c5eb2c4d8csm189010plb.160.2023.10.10.05.20.58
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 05:20:59 -0700 (PDT)
Message-ID: <652541ab.170a0220.ecc7e.072e@mx.google.com>
Date: Tue, 10 Oct 2023 05:20:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-553-gd498c00818b88
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 13 runs,
 3 regressions (v5.10.194-553-gd498c00818b88)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 12:21:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13366

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 13 runs, 3 regressions =
(v5.10.194-553-gd498c00818b88)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-553-gd498c00818b88/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-553-gd498c00818b88
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d498c00818b8876a72d6eb6c2498058ec80d51bb

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65253346c66b888670efcf24

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/ltp-fcntl-locktests-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/ltp-fcntl-locktests-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65253346c6=
6b888670efcf25
        failing since 117 days (last pass: v6.1.26-1320-g1ddf4b637f785, fir=
st fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525348c6f96063721efcf99

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6525348c6f=
96063721efcf9a
        failing since 0 day (last pass: v5.10.194-cip39-1-g53e59f50ca3ff, f=
irst fail: v5.10.194-cip39-552-gc89b2c57483f0) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/6525373388b02bdec8efcf06

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-lock=
tests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-lock=
tests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6525373388=
b02bdec8efcf07
        failing since 6 days (last pass: v5.10.182-cip35-8-g2391124f19a70, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =20

