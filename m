Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773C9C47079
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 14:11:05 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.web11.7450.1704723061649493680
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 08 Jan 2024 06:11:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=TKRy9M9n;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.177, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ce2170b716so1363549a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 08 Jan 2024 06:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704723061; x=1705327861; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=En6a+aruoI629LnBPrfVVpWXLZFH155bl2IETSQ0NfQ=;
        b=TKRy9M9njKE7mUOu7g/c1st6SD+BRjvhbEYVdGIQBSFPyXv/Ui5vfQs4w/q1qynRFw
         idkUKsCqugAUr9ufFm2Z7UnGcFJWfOMowr7KroucxO22st5fRH2t0pmOzWQJWw9rlc8v
         CJ9Ck2/uXT8Dj2VdG+Ivp4ZlAAATdy/SHLOrcvpJ8IBvVFT2fGnob3uRM2KHQhxLmoji
         ZK+W5NhTv1Afz4+JFJrp5uc+IRWgSnPaGxfEcp31MAqH4jwwy0IB0fuKEYr9+YMEo7Mg
         I7m+LqreKLgz4qldMsuy9bUOz7cG9LThdd38yk7W1c0KRpY7HZqZ1KNG7XUjWcAV7Ehf
         omFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704723061; x=1705327861;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=En6a+aruoI629LnBPrfVVpWXLZFH155bl2IETSQ0NfQ=;
        b=SDEyOhbUj0rJHYbswB4w0LqF+6XR+TNN4KZIu6+ArCdsPLJvYPpfgu95v3DBb4zzGV
         +T2hT6GjPlVLv/OQ6utMeC3V0SVwxEpymjPiDnwvGP7nVbweHF3/VHJ/n1uj0in2iki4
         uqagOl8ZfH1bEWKHOdjpvCjXSIRiLbnWfAlgq7OksUF37Et51kU7CW0QEZtsd8BQr6v/
         VeyUBo9MJBQ6jNaQlsfVVnltu4ocN9dCeUZ+6WeuIahyBq9BxvVg0mcwpBEUDiC7QDzf
         85MWxDlubUP42SwV4oZ4vVIPeD736q/BLW24HRZK8wiVICbHEPSYAcsbaD/EThmHkUVV
         PjVQ==
X-Gm-Message-State: AOJu0YwDjU5NxJRvQ+SYmuNesQsfMZ26aYM0UUY4bAaDwT4PdbNhYWKl
	SvR8xt0KijGSAR96umaQeLj5OtOJp1dFt6Gtjfk34PURr3Y=
X-Google-Smtp-Source: AGHT+IEY6O+fo0X2EBbr2iPJd6SHzuLz6Aq4f5gzHUqUHZ4DfGCprbSSl2cDRxmEPUWoDGW6/hKmcA==
X-Received: by 2002:a05:6a20:6a1e:b0:199:d20a:69a3 with SMTP id p30-20020a056a206a1e00b00199d20a69a3mr526815pzk.33.1704723060757;
        Mon, 08 Jan 2024 06:11:00 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t9-20020a056a00138900b006daf1ded817sm2318884pfg.209.2024.01.08.06.10.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:10:58 -0800 (PST)
Message-ID: <659c0272.050a0220.fb78d.558d@mx.google.com>
Date: Mon, 08 Jan 2024 06:10:58 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.299-cip105-289-gad0914f265af
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 9 runs,
 4 regressions (v4.19.299-cip105-289-gad0914f265af)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jan 2024 14:11:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14286

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 9 runs, 4 regression=
s (v4.19.299-cip105-289-gad0914f265af)

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

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.299-cip105-289-gad0914f265af/plan/ltp-tim=
ers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.299-cip105-289-gad0914f265af
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ad0914f265af139fd53d721f0db787b707de20ef

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


  Details:     https://kernelci.org/test/plan/id/659bfb8f5c6d32234c52a593

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/x86_64/x86_64_defconfig+x86=
-board/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/x86_64/x86_64_defconfig+x86=
-board/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/659bfb8f5c6d32234c5=
2a594
        new failure (last pass: v4.19.299-cip105-158-g856c181dce342) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/659bfc11416dc9f96152a457

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/x86_64/x86_64_defconfig+x86=
-board/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/x86_64/x86_64_defconfig+x86=
-board/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/659bfc11416dc9f9615=
2a458
        new failure (last pass: v4.19.299-cip105-158-g856c181dce342) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/659bf8815f9f04e85e52a3f7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/659bf8815f9f04e85e5=
2a3f8
        new failure (last pass: v4.19.299-cip105-158-g856c181dce342) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/659bfe0e72e35d2a9552a404

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/659bfe0e72e35d2a955=
2a405
        new failure (last pass: v4.19.299-cip105-158-g856c181dce342) =

 =20

