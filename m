Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C08C07E97
	for <webhook@archiver.kernel.org>; Sat,  2 Dec 2023 00:06:53 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.8229.1701475609663286450
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Dec 2023 16:06:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=dzv636xQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d06fffdb65so1675755ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Dec 2023 16:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701475608; x=1702080408; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PYo6wRy4Yg10DqNQlhqCk8cr2Uu5TO9jaI9x7QM8ZUc=;
        b=dzv636xQWdhySf7ZNzCisVLYqIHcyzxGRhDIE+XgHEWaSqelIGXMM0/AC2sSsE6lZB
         08lPiRIsmCywd7+yNtbU7M8hPjrykQjq+20GttNZRO/MwuOehxwU4jw1V84L1BpaL2F3
         XQi/CrIFyQ70C4j2OC2nSrKmPwC5IiIhAclvVpVgggdcSkNqu5opsf9bONzIHNee/quP
         HAEzuTgnPxjWSBxedX8QMIon2qK/IKGYskiTV35+fe2+ljd0h3LjvB4NRotA0pIfIBXP
         zXIMtg9BfH8wFMAEFFLY1x2xBfWpirm0EYUMbw46zMrqVRdKISoWtq8gMcm0BlKhKbg2
         wf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701475608; x=1702080408;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYo6wRy4Yg10DqNQlhqCk8cr2Uu5TO9jaI9x7QM8ZUc=;
        b=KK7iOOzneDMojluIW+5jO2gPAbcplshDDJsHFcRjJW+x8dN7EoRmrpjSI8SiHI6Zui
         1QL/+gnw1LtjSlFQGxUuK0KpLM4EIUdl2BiR9Ru5qkHtcZrQNYLef4b81Y/GHKfTGQm3
         V6QBh0g+DU69oG+HdqmHiZQX4XIvCjKg/mZKWC2/7345p1l+MYCTCH0002XHcH1zdvDq
         mHs+2eDHyVjqNPTDW0Gpw141FsLMJ8SbjA0BA2YdC+gAEMMH/6XU7cF72SQrVhdpvnc5
         3opgQkIDeXpnlUbPEN3DJ+iV9l/YfDiaBpEK/NeWb+wXb5H7FQ/VQP7aHDOM2CIisPhS
         lAsw==
X-Gm-Message-State: AOJu0Yysjtrd0BMELN9uc/XYfzQMoQ43N0rX/MjpNI6X1LUsR6v44vUK
	CCgzBuOwxNxajnIz6bkSEOKj7lkL5CyrGqKRbTlm1g==
X-Google-Smtp-Source: AGHT+IE+kpLnWBJOD3aQItOvYC0XVTDNe554UkF0GnG5phOJnI5V9UNvNnkG0wxSuOeBJu0wiClo1A==
X-Received: by 2002:a17:902:c408:b0:1d0:1e49:3f60 with SMTP id k8-20020a170902c40800b001d01e493f60mr369250plk.27.1701475608631;
        Fri, 01 Dec 2023 16:06:48 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902da8700b001c60c3f9508sm3915800plx.230.2023.12.01.16.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 16:06:48 -0800 (PST)
Message-ID: <656a7518.170a0220.a4dbe.d6b7@mx.google.com>
Date: Fri, 01 Dec 2023 16:06:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.64-cip10
Subject: cip/linux-6.1.y-cip baseline: 103 runs, 1 regressions (v6.1.64-cip10)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Dec 2023 00:06:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13770

cip/linux-6.1.y-cip baseline: 103 runs, 1 regressions (v6.1.64-cip10)

Regressions Summary
-------------------

platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.64-cip10/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.64-cip10
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      6eab166db6d4f9b10eb2993de0fcd289a09024bd =



Test Regressions
---------------- =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/656a6a5037ac6feac6e13479

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.64-ci=
p10/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.64-ci=
p10/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656a6a5037ac6feac6e1347e
        failing since 7 days (last pass: v6.1.59-cip8, first fail: v6.1.62-=
cip9-12-g3a5321f469b07)

    2023-12-01T23:24:38.295390  / # #

    2023-12-01T23:24:39.371592  export SHELL=3D/bin/sh

    2023-12-01T23:24:39.372845  #

    2023-12-01T23:24:40.855550  / # export SHELL=3D/bin/sh. /lava-12154588/=
environment

    2023-12-01T23:24:40.856793  =


    2023-12-01T23:24:43.574854  / # . /lava-12154588/environment/lava-12154=
588/bin/lava-test-runner /lava-12154588/1

    2023-12-01T23:24:43.577173  =


    2023-12-01T23:24:43.588966  / # /lava-12154588/bin/lava-test-runner /la=
va-12154588/1

    2023-12-01T23:24:43.647866  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-01T23:24:43.648353  + cd /lava-121545<8>[   28.484297] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 12154588_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =20

