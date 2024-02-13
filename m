Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA2DC4829A
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 19:06:26 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.21899.1707851177699363305
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 13 Feb 2024 11:06:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=W3YkJ2EU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e0d085cf59so2033919b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 13 Feb 2024 11:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707851177; x=1708455977; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mkznlkYIQQm7xiHoaULB5qvI0lullhyU9RDpz7hwpZQ=;
        b=W3YkJ2EUXcEEUewXsvmXRLZ1UXSYdj+0JGeG+IZFoNkkE37nEK6zFI2o1Eot8nFax4
         ok/18VhS1KC6M/oayla7loFGxkDbTlFi57X1yN0xsiJOQzpYZfvTKIxvIIXDuWcYs6ST
         tkSwWDSCSxIKBOBSw9Ynorphpccxp1Ux9Dcgz/WH6COAqt8oh2EFVpp5hpPRMA6N3qV0
         Zpp9IW+Yv0dCA5InjI98mb+A0nEHHMOLr2L1lomUmsUhJnC+wLs0xiIRDDtMraCy/6j2
         u++P+c+8t6ja6FDIBMPogj3L6v+LL5ERQA7P/zBUolAJx5Zj39BcY/6ki3JqkGfvWp4g
         cWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707851177; x=1708455977;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mkznlkYIQQm7xiHoaULB5qvI0lullhyU9RDpz7hwpZQ=;
        b=dz+pb+73jD8SZBK1z9q7QTQjc1ollJu8JRNvCUgpQNE23LccVDVD/4/LSVuUyZsoON
         GYBkEoGGY/WiYk3MO/OkvXarI9psi6NDt8AV4cbq6O70XH37MlH3fK4zCoqrMa+zityA
         e3qWNuY7ic7k28FVsu+vaBxdKmg/rdLjTBZF/up6cj3XyY1lbEZA8QZA6CRL4qsPDz9u
         Vt6O7NoEPI9pWwnFs7ML1vfD3V7zlh15h1sUPdXtsVoxJWV3fQvDu/PQtNWXCsl3OtIX
         uOUz/2GlpxrsffBbmksbHvM59XMwjKx88wOE7PfcUIVbEJVBlzTMdwQAq7cfmK5sP7e8
         BBSA==
X-Gm-Message-State: AOJu0YzYKCngtaE6f2b2xYqrWUgg6D9crR6zD0YJqRIZVfU2kL2CZJJQ
	Jjh+8eOWxSdNOtEzRnDD8z2vV83PPNYlz05CLBJmOm9WvpNaMxo6aRLTH0TDbDxmXFcCj7fvu+c
	iuSg=
X-Google-Smtp-Source: AGHT+IHqtZWDQ4y2xnSDm95rjEBp5a/9csbPRrWCzApuHUyBIu1n3IWdsubS+OiDjWXfxWtRU2TVzg==
X-Received: by 2002:a05:6a20:43a5:b0:1a0:5f8b:2cad with SMTP id i37-20020a056a2043a500b001a05f8b2cadmr775722pzl.13.1707851176776;
        Tue, 13 Feb 2024 11:06:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXPycHeXeKWtIeKPRMkC6UauKkKUR8pvYP3PRhKdblpqh1RGF5IueRGbid/ECdb2c1cLvDfn5L+R95W2yw+hJZzYXEioGmiRqBoNFqb9q30D5HQqTLTMLx9CliI30+AQlChippn3DE6PICR9plRRVYsZw==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ff7-20020a056a002f4700b006e091a254adsm7750091pfb.30.2024.02.13.11.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 11:06:14 -0800 (PST)
Message-ID: <65cbbda6.050a0220.4d28d.65af@mx.google.com>
Date: Tue, 13 Feb 2024 11:06:14 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.209-cip44-51-gdb99ac443b0da
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-ipc: 16 runs,
 2 regressions (v5.10.209-cip44-51-gdb99ac443b0da)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Feb 2024 19:06:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14950

cip/linux-5.10.y-cip ltp-ipc: 16 runs, 2 regressions (v5.10.209-cip44-51-gd=
b99ac443b0da)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44-51-gdb99ac443b0da/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44-51-gdb99ac443b0da
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      db99ac443b0da75f00a4fc49e0040ac5dfa47e72

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbaf99902408fda8637019

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/lt=
p-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/lt=
p-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65cbaf99902408fda86370=
1a
        failing since 132 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb0ede2fea7ebd6637020

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hi=
hope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hi=
hope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65cbb0ede2fea7ebd66370=
21
        new failure (last pass: v5.10.209-cip44-50-ga624abaa85d7) =

 =20

