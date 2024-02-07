Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94069C4828F
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 18:41:49 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.5936.1707331306960913698
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Feb 2024 10:41:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=QRSRcxM6;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d8da50bffaso4832275ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Feb 2024 10:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707331306; x=1707936106; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yqSx/ZGoQ45sw53R2H/hvERW4vP/VBUinq16qpk3ogU=;
        b=QRSRcxM6SJzsHQKEygDqTf04PtQ3+L0KTTUChzCJDY2QtLlUUvz6k18Bt4/GIXPu6P
         eSYdRuKNI9fiHvjZloX/a+jYmGb7ZSxhZjbiU0DD3L3/w616VnF94sPrhiCOc9ZAewaG
         pVwub+fXOnrVubz+4Ve6STQ4zoSJPDrZVOMfVA29Veh7vf6O5hMBHBlB/lesulDCHi0z
         nn0EqrQF881tOkaaSTgZYQdBc0TrLyOwHuMJSoAbShWwytFIlXhebs4Mo4qUyReyCeWJ
         qqI6h+nydYQkvBBzTsWtjA1M4AO4fteziObDRy/5LfmlefqpsswkRILnkjDEsNLuuRVw
         z3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707331306; x=1707936106;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqSx/ZGoQ45sw53R2H/hvERW4vP/VBUinq16qpk3ogU=;
        b=QnnHUMqg8wvLXFFO6P9Pd3cFIpJR+kCWlTLrXhMkskX7uz/UJaaAv7Ztm4MwY77+5C
         VXyjNubXmhMQWu1yUy+gkE/mU5nyFWQIHuQUJPSXL/oeQEaAas7RIrWQxwggSC1IotQi
         7O60gWO8obmCs/D/EugDhTh1AypT/nmcSTMoxIwO2+GoaOU+VzZgAIIGRYaem5u6yxnw
         EU+0lnTJQDP7frOE0NJfrFNzU+GjDMuWlNiyZjET3mW9DTix46sbrIHkY6CKaIBuRqpp
         2vhQ2oKtKHmEzEP95wZEFXS0/J9yW36yAXRzc3GN9MKf2J1hS46IKEjYH8VGZoMX/uwS
         CsrA==
X-Gm-Message-State: AOJu0Yw04bK7BTp6+eSgO8nMute8J9hRSJwOt+xLQ4/spBCmCurt45nt
	PRvcWVtqs+p8tONYUWln1lZbkk0hFJLhEgIuCxzDR1trcwxKfUx8BPRzOGsG3Fg+J7pXF8OdUXl
	Ads8=
X-Google-Smtp-Source: AGHT+IHVEOw/k98CUSG1cLuPctOhdR8oDEf3q2QeFaI4cFlFwMaPIi3R2EEE0/yIm/7LtQQkWaVWpw==
X-Received: by 2002:a17:903:124e:b0:1d7:858a:9ee1 with SMTP id u14-20020a170903124e00b001d7858a9ee1mr6605092plh.47.1707331305927;
        Wed, 07 Feb 2024 10:41:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVyLQXxJo/gvJ1nEQiMvZYKY1vj0aYeWML3ZJ51L831cgDHIHZD3AwyUVluOF1yqvvinu94igAJmPDUrAB+JGxQkagNMiCKLrPL/eWw7SYQUt4py0bcfFKSHX6ElpqLT3toSMOlWRzuMn83v/ysSwuFBw==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902c18b00b001d949393c50sm1761250pld.187.2024.02.07.10.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 10:41:44 -0800 (PST)
Message-ID: <65c3cee8.170a0220.f6692.60d5@mx.google.com>
Date: Wed, 07 Feb 2024 10:41:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.304-cip106-3-gaf120b32b886e
Subject: cip/linux-4.19.y-cip ltp-mm: 2 runs,
 2 regressions (v4.19.304-cip106-3-gaf120b32b886e)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 18:41:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14902

cip/linux-4.19.y-cip ltp-mm: 2 runs, 2 regressions (v4.19.304-cip106-3-gaf1=
20b32b886e)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.304-cip106-3-gaf120b32b886e/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.304-cip106-3-gaf120b32b886e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      af120b32b886ebb728032aa594bafc1d152eb9f5

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
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3c29b8e309435488e1e79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65c3c29b8e309435488e1e7a
        failing since 753 days (last pass: v4.19.222-cip64, first fail: v4.=
19.225-cip65) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3c3be2ad40f84d98e1e7d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/lt=
p-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/lt=
p-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65c3c3be2ad40f84d98e1e7e
        failing since 753 days (last pass: v4.19.222-cip64, first fail: v4.=
19.225-cip65) =

 =20

