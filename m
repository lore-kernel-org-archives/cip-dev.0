Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129B8C4829F
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 01:39:38 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web11.10756.1707269973805547706
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Feb 2024 17:39:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=lukGNgqW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d93f2c3701so828585ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Feb 2024 17:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707269973; x=1707874773; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EF+RaEEfr67u5op7TAIpamVVNVsu9DWG0C97OSfB6oI=;
        b=lukGNgqWJqRrVwOoSjmcDw4hOAejN1/FHaLMp4aLTrwjz/3g1DHvk1RJ7GKBElYT57
         Avqwe8XwJdX/tEwwLvx1ovT6MhTdnqVs5RDIzrtViiuCbUyIcEJ+1xixvX4fCE39gT/S
         6oaZJX8bvRR6assuQJoCR/TaHvw1EwKHKI+7edTHssYIzL/URRi3VejYoRjJmIMZpxzd
         FtmC6VMN9wY77Y/to798vgRvzyBFOYNm6a2qigCISOl6tmjp73xdJGPQwXy6bVboTPP1
         mwwP33D95WlnhR599WJsSx1hJHf+npxinr9QTDFQ90UhR6sXdCDDNpHffdEpdk+mIE+Q
         zYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707269973; x=1707874773;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EF+RaEEfr67u5op7TAIpamVVNVsu9DWG0C97OSfB6oI=;
        b=daKa9WUxgNId8DGa2ysy9dJKtAnSqrWjaJVTuZiYPdfKJdk4q8g5oCckHBrZcQtjPO
         JOKob/11CNHgweSrIlDqT9H06XolMrEdi785qNrgNdJD7Ta1cfYoEj/Xlt7R2grLOyCv
         c5HOFkal59uuLxUUuyAHEACAgawtxY2y672oaTCLdMTv5QPO5kQeL4/ukugCic6AEUPF
         JgYSP9W1tt56HsBgWxDZ/WS40htmSMMtHOQoYgIjEF9uVks8xGBaar2VJ6CjXzL4wPJt
         KM5KQMn4FtJvkLb+raOUOQwCXVA66q/BDBjb8U0AFBA1/0RfGvlOlqI0+GZk/fwTpB0Q
         K7qA==
X-Gm-Message-State: AOJu0YyKUyQ4kiOB1mUA+5omBippRtxkostUG9DJis6eqtbMX0w/h6wP
	b6dKRUHW5XfoJarhPM2VhcwWE/mHI4jaSWD+ZoBK9uQSi205oyomN4sYLXHQvSWxIfMSPMI9qKL
	+
X-Google-Smtp-Source: AGHT+IGBpD2Co2Hk4u7RBT3VMf1C7gtyC0JqfVVUO0NgrRir8SRrBom9oQeP/bvSK8uiIpqOkOI03A==
X-Received: by 2002:a17:903:41ce:b0:1d9:e18d:1aa2 with SMTP id u14-20020a17090341ce00b001d9e18d1aa2mr3310002ple.66.1707269972745;
        Tue, 06 Feb 2024 17:39:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWjT2YVRn1ARw8GSfzA9kNZh+nduqSCZ5zsaUIdHVAFqqLcYllc1jnlpW7AMHkc/1O9nKiWsxiXVr8VkqA8A0ceOysowT8x6QFItj4Tg6T8Z4oMgxkFxtbMIFG3Iiad7Dt2ykUCniayGtSUJbGxPhiAsg==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g23-20020a1709029f9700b001d8c8980527sm179297plq.139.2024.02.06.17.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 17:39:30 -0800 (PST)
Message-ID: <65c2df52.170a0220.30a13.0b80@mx.google.com>
Date: Tue, 06 Feb 2024 17:39:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.209-cip44-50-ga624abaa85d7
Subject: cip/linux-5.10.y-cip ltp-fcntl-locktests: 10 runs,
 3 regressions (v5.10.209-cip44-50-ga624abaa85d7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 01:39:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14854

cip/linux-5.10.y-cip ltp-fcntl-locktests: 10 runs, 3 regressions (v5.10.209=
-cip44-50-ga624abaa85d7)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig  =
                | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44-50-ga624abaa85d7/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44-50-ga624abaa85d7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a624abaa85d7f3ff289eb2e257db5c4485d11d18

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d4fbdb4748bfa68e1e8d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie=
/ltp-fcntl-locktests-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie=
/ltp-fcntl-locktests-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65c2d4fbdb=
4748bfa68e1e8e
        new failure (last pass: v5.10.209-cip44) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d07aac74db00858e1e8b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests-=
r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests-=
r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65c2d07aac=
74db00858e1e8c
        failing since 236 days (last pass: v5.10.182-cip35-1-g7cde3fba93966=
, first fail: v5.10.182-cip35-8-gdba81ae6f2be) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d47604978d2f488e1e87

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65c2d47604=
978d2f488e1e88
        failing since 125 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =20

