Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB407C4707B
	for <webhook@archiver.kernel.org>; Sat, 13 Jan 2024 11:13:00 +0000 (UTC)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
 by mx.groups.io with SMTP id smtpd.web10.17130.1705144376280683574
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 13 Jan 2024 03:12:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=cyFQT7W3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.50, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-598dfed6535so147435eaf.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 13 Jan 2024 03:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705144375; x=1705749175; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CK5vNNMrnoLEQlK35xEWLmeIiwoM3Z6aH2cJwwGKNow=;
        b=cyFQT7W3QBkxwT4PsqN+xRSyt0s6n9Qzvigm49DrqimjMyLZIInlBg8aJfGia/ShSj
         /qiTfbsT0Dh63C41QW1nAvvudNuG8nentafJBwvXHNzHp9O6J+7r3u95mb8zxW4d/E/0
         SZM104O9LvIaONdc1Ky+PcCwqgWaxCVEiQVaV2zZtV0Sc3mBGg6LmX10qhgqo8pdiuHl
         TDTVcecEOi9w1+Hw6/t0YroQEXX/WxYlnEkugT8Wn5+4L7Q1dI7pPbQJkq/fK6nKjBwn
         unsHASbgWRstor0NsNl5fANBu9tQK8l57yXOlRgACToRj1ywltYmCkyDtLlveXQ9vOKO
         WoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705144375; x=1705749175;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CK5vNNMrnoLEQlK35xEWLmeIiwoM3Z6aH2cJwwGKNow=;
        b=lK+glLfIHhxOYPJWsNyH8wfxHgsXufS5/mRv0pc0sq8f99d25VUngQI+PJ0+dEYvDe
         JyI2UJZ30JqXlHLb2DVNsC3Dt6dFMvcy4LqBjZwNF8WfQIffuSgZKsD7JeY3OamdaMkm
         vyupHj80MA0X/A/s/3ZIVI7AoBZxyjAH1zMJ6DKWy3bj15nZbyHFUu4PFhI3a29tjXyq
         Thf4PLFwrQQLs5+lNIWyElBuPijd7JntxJE1juMpo2PMLPz3Is3xm01bJ6C7JHwro6B9
         /LCiuUfENfmJZrjTd5SHEBjXTGv+cuGFM/6Y1O7LNQE/PvSfCnsejc9qQog7lqX0ZXzT
         97Mw==
X-Gm-Message-State: AOJu0Yz0H1kedMuCCduF6ocoGkR2uaMV/2WyPVGdBIBsT3eUZ+hFh8Yp
	CGjAeSTqOC/XhB+P+xbFhNmwx1a+/Lq390cVlGh+BTyAc2c=
X-Google-Smtp-Source: AGHT+IEdcaVSPx3xYl3SsATDPSBvk5OGXUCBOf5fK3rUk6lPpDW+sp9j33kB4HPN4qfSZ08sgWwkdg==
X-Received: by 2002:a05:6358:b107:b0:175:55e2:c8f6 with SMTP id a7-20020a056358b10700b0017555e2c8f6mr3320601rwo.31.1705144374896;
        Sat, 13 Jan 2024 03:12:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id qi17-20020a17090b275100b0028df00a44casm5189125pjb.23.2024.01.13.03.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 03:12:53 -0800 (PST)
Message-ID: <65a27035.170a0220.bb621.2886@mx.google.com>
Date: Sat, 13 Jan 2024 03:12:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.304-cip106
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip ltp-mm: 6 runs, 3 regressions (v4.19.304-cip106)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Jan 2024 11:13:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14375

cip/linux-4.19.y-cip ltp-mm: 6 runs, 3 regressions (v4.19.304-cip106)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
               | 1          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.304-cip106/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.304-cip106
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      6617f4528449a329abd3b2dab36052b341610d99

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65a267018b67407d6f52a3f9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/ltp-mm-asus-=
C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/ltp-mm-asus-=
C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65a267018b67407d6f52a3fa
        new failure (last pass: v4.19.299-cip105) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
               | 1          =


  Details:     https://kernelci.org/test/plan/id/65a267ae74e09c5fbb52a3fd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65a267ae74e09c5fbb52a3fe
        failing since 728 days (last pass: v4.19.222-cip64, first fail: v4.=
19.225-cip65) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65a269879799e505b052a3fc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65a269879799e505b052a3fd
        failing since 728 days (last pass: v4.19.222-cip64, first fail: v4.=
19.225-cip65) =

 =20

