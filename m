Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62373C4829D
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 04:58:29 +0000 (UTC)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
 by mx.groups.io with SMTP id smtpd.web10.14128.1707281904751428036
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Feb 2024 20:58:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=COMbafoo;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.175, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bfd27f6dc0so163622b6e.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Feb 2024 20:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707281903; x=1707886703; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yh/RftxmQOIDERe7o5b7EBMeUXQn/i6q5xEgnbwtD8U=;
        b=COMbafoowDNDPhm31nJlmRArLcXGxo/XT67ELaX/mgzYcu+uU1+0NgSdXxqV7Gm9uU
         gKcqZIHoTyzkeV2sSIu8BaFeQQKGlHvsrye6W0kJHv638tQVWatkORiZBbj2diC29WPf
         8pwIVpyaCVNJ/wXPHVe10NmUyCw9fQwZN1qfKyaIP7oLCCkVfjVMcwDvf81255wXWC0o
         jPoYCEFDa6nJqq2HWDJ212ltuapjyea56gkw8I1YYqFExW4LkpjwBeas4+2+duxcaZ78
         crBeGy5RQ6zjqRjb67F3tSWayEY6ysxcWz4S97+8kNLmEgOCvcUqEjrMfv1rIFXPA7eQ
         J26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707281903; x=1707886703;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yh/RftxmQOIDERe7o5b7EBMeUXQn/i6q5xEgnbwtD8U=;
        b=ADLESOasMQx4Y1R5ypkCVL88y8WhiidI+OaNp8jJSNmoqh5hdGiAdlrIQ+BVKI3e+q
         HciViJFhhdZlMzRsHD3KP3Z3tVBrB6dHRCTaklqV9KSOp99ssM6OzbyiHDwC0kwqZH+f
         nfvssfNoa8McXWlTI8zWwIeuQJIBE3APeK/MhsWQpKdPr3TXveQWTjEVHS0TdyodsVJJ
         fESic1P7n4eMOhVeb/NrzHnj4S025SEl0/X9FD08HKDeG41uoZZ10zWzQ/hiym97Scdt
         o+7YV+Ne0eYjqg/11UGG+0JRQvmIS2J1+xWbu3UrJsZ153j8RD7bleyuEkycjDHL3Q79
         3zEA==
X-Gm-Message-State: AOJu0YzdmyDprIdRKHcnPN1tooCrDWjUp3zYl4m9wDJfoBx5XuRYM5fa
	pTLyB6QCfC3/BiesZg8vQh7gDf1KFo/fhvgR/Wtei73i/71moTOBDj94+raBfpZnsmyD2d9MCv/
	i
X-Google-Smtp-Source: AGHT+IHOLky4vtrwd+QGIGQ9kcOukye31CVuVMjUkBlB+TzJIdvsI4Y/YeuI2HSpu/H25/YWa5oMwg==
X-Received: by 2002:a05:6808:238e:b0:3bd:db8e:b1d8 with SMTP id bp14-20020a056808238e00b003bddb8eb1d8mr4918644oib.31.1707281903431;
        Tue, 06 Feb 2024 20:58:23 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id gx3-20020a056a001e0300b006ddc7ed6edfsm426769pfb.51.2024.02.06.20.58.18
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 20:58:21 -0800 (PST)
Message-ID: <65c30ded.050a0220.6fd4a.147d@mx.google.com>
Date: Tue, 06 Feb 2024 20:58:21 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1250-g39ff255b75f5
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs,
 3 regressions (v4.4.302-cip72-1250-g39ff255b75f5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 04:58:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14867

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs, 3 regressions (=
v4.4.302-cip72-1250-g39ff255b75f5)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip72-1250-g39ff255b75f5/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip72-1250-g39ff255b75f5
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      39ff255b75f5caee714b345c0c47b1c44b88dbe0

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fa5e725221e59b8e1ea4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65c2fa5e72=
5221e59b8e1ea5
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fac307bc61a34c8e1e79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65c2fac307=
bc61a34c8e1e7a
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb3b092713896c8e1e83

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65c2fb3b09=
2713896c8e1e84
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =20

