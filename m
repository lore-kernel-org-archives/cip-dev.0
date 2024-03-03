Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F8AC48BF6
	for <webhook@archiver.kernel.org>; Sun,  3 Mar 2024 12:33:02 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web10.72055.1709469180057412421
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 03 Mar 2024 04:33:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=sVYyl2jj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.176, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so3157368a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 03 Mar 2024 04:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709469179; x=1710073979; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e2BTT9CHTh+iuBMXYi0LazTCO56PjGRr2Yp+dMWp24k=;
        b=sVYyl2jj8fSVZv9lyHU3LQyDiJbR7Sw/SVHj6zUw0D7979k48fhjrfewqUe/YjeHyd
         FoGkIHTTlZVnH/D8NOqgrMMbmkRXU8bYIMviY5pOl0cYPlkaQQrHBN7bDFIHS9v2scxw
         ceHdF7BRjomGO+Hitr3itONoIKqrtuptO3yK9P9WN3W77QlOvwO42G6Wij75lx3GGYcD
         d+f7ZEQVdz+3H4Quy0J+WJtHFcmPIPjo1xbmKdKjp9XKs57Aky41o+7NYE1JLuP72GE8
         v31aFr7ruZUtsSIj8WclFkinWTuBQFapQJOA9BDzauurrLQUkNpQEPSAR4K1/4CMcmgL
         IrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709469179; x=1710073979;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e2BTT9CHTh+iuBMXYi0LazTCO56PjGRr2Yp+dMWp24k=;
        b=i1U1HNb0C1Nm/J7q+N02l0vk865cAM0VTurJltPK3gPpUsoIG+MAqNC5htxXKZVh3M
         8Dpjx9oMak4IQoGfZvvF7AqvU1Fsh8rQppkL2tSHFyA7PLTlecxQSpC0RQnlHvsy5MbZ
         vMpcxe5ZDgQaFCFh7PUkbJKlh95n5OYxDjLLWp2hRpS4PUVisHJTmnSpmz7ReZv18WXE
         qwlIigpgCAUGUOWEegL2ZlfJeJ0/HtDjr/cZAi/+JX1zqdyiyrZnVWDoTFFeMhkN0+1W
         Xrk25O7pdScK8oOPi0okiZSy4iVpyNbOyhy20RpvFuW+KH/bsM1XtkGdFgR1O4PmharL
         baVA==
X-Gm-Message-State: AOJu0Yxc8Uf8jhbF+hjfSpQRqF2MiQ/k5NW7u1nw/gcKv5HNpc7Og9GL
	OewRcBkOYBg278dKfdZenTPSkMLV3IFKwj3lbix+2TN/ArOTjF5jGrqPFGlMGZCw0Ya3rrXJ2a7
	j5ns=
X-Google-Smtp-Source: AGHT+IHJp+EUApX2qg06GrFgkBJ5YvN+XjA0n92ecWp+qHEX/ODBYFtnjWGl6mAFQUHwlzHn9cyuQA==
X-Received: by 2002:a17:902:bb8c:b0:1dc:7923:a9e5 with SMTP id m12-20020a170902bb8c00b001dc7923a9e5mr5018006pls.39.1709469178976;
        Sun, 03 Mar 2024 04:32:58 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p13-20020a170902780d00b001d8cde39e8bsm6726269pll.194.2024.03.03.04.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 04:32:58 -0800 (PST)
Message-ID: <65e46dfa.170a0220.4ebc8.aeda@mx.google.com>
Date: Sun, 03 Mar 2024 04:32:58 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Kernel: v6.1.80-cip16
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip ltp-pty: 11 runs, 3 regressions (v6.1.80-cip16)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 03 Mar 2024 12:33:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15176

cip/linux-6.1.y-cip ltp-pty: 11 runs, 3 regressions (v6.1.80-cip16)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

mt8173-elm-hana           | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.80-cip16/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.80-cip16
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c4a8a3898cc297c755b7d041d731243bf2338f24 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e45c55e1d84c2924637019

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.80-ci=
p16/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/ltp-pty-asus-C43=
3TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.80-ci=
p16/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/ltp-pty-asus-C43=
3TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/amd64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-pty.login: https://kernelci.org/test/case/id/65e45c55e1d84c29246370=
1a
        new failure (last pass: v6.1.78-cip15) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
mt8173-elm-hana           | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4613ca97de93fab63701c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.80-ci=
p16/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-pty-mt8173-el=
m-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.80-ci=
p16/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-pty-mt8173-el=
m-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-pty.login: https://kernelci.org/test/case/id/65e4613ca97de93fab6370=
1d
        new failure (last pass: v6.1.75-cip14) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65e461a65733ec171f637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.80-ci=
p16/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-pty-rk3399-gr=
u-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.80-ci=
p16/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-pty-rk3399-gr=
u-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-pty.login: https://kernelci.org/test/case/id/65e461a65733ec171f6370=
13
        new failure (last pass: v6.1.75-cip14) =

 =20

