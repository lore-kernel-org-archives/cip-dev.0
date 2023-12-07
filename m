Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1852BC46CA3
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 21:44:31 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web11.104560.1701985462100618161
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 13:44:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=B8K1PCHZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.178, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5c66988c2eeso1073686a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 13:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701985461; x=1702590261; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IM+U/otDts/sSgAhm13EbCYhAyQNO0mE20T6ElLKKrY=;
        b=B8K1PCHZUl32CA5+/OMufr5Xy8oBEDsuICjhtFiyjVITX5vZwizUmBP8xKXTRxLV/h
         0f9gd1hsX/KkEWmoMYcM0ndId4v0cjWGMpJyF8NdJ2gXaNjxlZKN+OdI73x77xyFe/j5
         QSZtAO9zMGuIitQkzjF1MU4xIQwlMWLBUU4+P7zZNius5c3WdDJK37nILnQ/XFo1Z+XE
         jN1kwmhhkHqFggPwABxeVSvKTuhIg3aDDS4PPEuTvyTHFWfP8CtSNEWHfFSnwEn8eV6i
         t8l1+CJ3tFvji/Q9PQFRDmb/JxwwTPs9BnZ5o/uX3cB1FweD4LjZADTYiuu6xavOe0Rh
         GJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701985461; x=1702590261;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IM+U/otDts/sSgAhm13EbCYhAyQNO0mE20T6ElLKKrY=;
        b=sic0ceH4XqBfd2iyS/8XQgBiJCDWazj86ThXYORNIzFzjN5DaJwrkIPhkDMSEW3FUg
         B9iS6ZUDwR47Hk2n2OPsiw9C+GTJ8rqBVittRKVpPC5syYd8WNVsQQUeTi8wgPt3zIPN
         I0azbUY2uD8LGxzJYUVlzxUBjgwA1xmo8JLmsLG9RZABSMmGK0buJY64fIHYR7U+pF82
         Nr7/xTbVJsdaGyZsB2iLKfkkt9dZ3bc7JeMY6o3jUi4N5CsBOIqLmLrs+oSLNZ+Eyl7a
         O318eTcLsUYKIhW+YtD3MmCYMyJKdCkJzzl3PCxgXNV7mzcKOH8YpeOMhccYOOCAAOnw
         NQcA==
X-Gm-Message-State: AOJu0YwmnxaK7BwuyIkBuxC33RaDxsm8izQy4oW7wU+ccVhnQDcjAuKw
	d87ykrpOY5aEbHoF6AlAztzZJhd4fEA1dtQeF/cRJg==
X-Google-Smtp-Source: AGHT+IFOvVDm7xemETX9va7JMXkZceA2Koyu1kThCp9VbV6pxvQpsiFp7oOEFGaioUezKBhP24hakA==
X-Received: by 2002:a17:903:41cf:b0:1cf:59ad:9637 with SMTP id u15-20020a17090341cf00b001cf59ad9637mr7428547ple.22.1701985460968;
        Thu, 07 Dec 2023 13:44:20 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902c3c600b001d1c96a0c66sm280918plj.130.2023.12.07.13.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:44:18 -0800 (PST)
Message-ID: <65723cb2.170a0220.75a2e.1b16@mx.google.com>
Date: Thu, 07 Dec 2023 13:44:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.299-cip105
Subject: cip/linux-4.19.y-cip ltp-mm: 6 runs, 2 regressions (v4.19.299-cip105)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 21:44:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13927

cip/linux-4.19.y-cip ltp-mm: 6 runs, 2 regressions (v4.19.299-cip105)

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


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.299-cip105/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.299-cip105
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d152f9dce44a3068c74de8c2046a16b8dd3c1544

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


  Details:     https://kernelci.org/test/plan/id/657230a274480bb975e13478

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/657230a274480bb975e13479
        failing since 691 days (last pass: v4.19.222-cip64, first fail: v4.=
19.225-cip65) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65723b6f4bb8a22209e1348a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65723b6f4bb8a22209e1348b
        failing since 691 days (last pass: v4.19.222-cip64, first fail: v4.=
19.225-cip65) =

 =20

