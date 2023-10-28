Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FE0C4167B
	for <webhook@archiver.kernel.org>; Sat, 28 Oct 2023 20:58:39 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
 by mx.groups.io with SMTP id smtpd.web10.34092.1698526711174681499
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 28 Oct 2023 13:58:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=waKOmS8P;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.128.172, mailfrom: bot@kernelci.org)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5a8ee23f043so26521947b3.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 28 Oct 2023 13:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698526709; x=1699131509; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u0jjDc85XqELek8xlP9TOiu8vGMJVJ7kdvBcHABVWGE=;
        b=waKOmS8POBZKIdAONNbqfyxo3m4MvlzYxJIEWwEhMvLTFqAjYiOZXC56RmOh8uPPnw
         IOD6AZPsOzdWPCuGSZAfE1yU4+SNQ97WHfJD4b2IY4h9NzbEsB/bc9+vXnmtMq4Nw22O
         cFdqVq+6Uy3bPdI6a2JAGTVqNH35tVfLsxXi81Jl3SzQSlpheI4eWKnJl/rL0SxWMlgW
         a3iE/N6HdvSHzRL7AINVNSwOOGKTqH/pHB0EAELBGR6DevIU8Z0gbK5enrRlKERDmZcB
         94a2sQF8BO/1EhhAz8t8+llrrvxUZqA6mLQWbE5k1lLsXvpnDKmNU/DWd39KcEEr50D3
         rvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698526709; x=1699131509;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u0jjDc85XqELek8xlP9TOiu8vGMJVJ7kdvBcHABVWGE=;
        b=TuvFQI7MgWbEWnzb/N1sVyi9trappJnIaKShDiUxC/lpjr1iA7DkDnbRBtLVwLgSbv
         Tc6BMBbXwl1mRUOlZzzRgGscbp/9ouszPBHHiFysOz2g7IjIxat6OvNsXzDw/nG1UhUZ
         aalD4WHfin64GQaJYWTUXjsNhg7t+QSCMawRDJVTFQSUL7S4avrkhPv9M33kAnaED52t
         xlqIF04hH2/rcKDw8iRUbxVnp4SvB5srIwapAmoVHmEKeTjFaWUqosGRCvoLLCHmqPLW
         dtNYLUUZZEPHl6GngDqA85h/al2Bt3z3f/goaz6l939BmirZhBvqdPHeThEP0MVSnGoy
         P+cw==
X-Gm-Message-State: AOJu0YyV4ZTH7XzizSn/ZGdF6xfSF++tDgFjjBSg3l9+Ih0IQzIkCMtJ
	hqNuwUhUMHzYjvNmI3EgZUvlckCTe2DEh9pBOHg=
X-Google-Smtp-Source: AGHT+IH0AVomg4IYLuqLTotx6TkkdIrP3NokpFrKylaj/GU0qpz4UupWl633dwlYz5gtBJz+kVkGeQ==
X-Received: by 2002:a81:d007:0:b0:5a7:bff2:12fd with SMTP id v7-20020a81d007000000b005a7bff212fdmr5693519ywi.10.1698526709556;
        Sat, 28 Oct 2023 13:58:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x10-20020aa7940a000000b0068c006dd5c1sm3319188pfo.115.2023.10.28.13.58.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 13:58:28 -0700 (PDT)
Message-ID: <653d75f4.a70a0220.3c9d7.9e38@mx.google.com>
Date: Sat, 28 Oct 2023 13:58:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.59-cip8-106-g65bd536c294e
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 7 runs,
 1 regressions (v6.1.59-cip8-106-g65bd536c294e)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 28 Oct 2023 20:58:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13493

cip-gitlab/ci/pavel/linux-test ltp-pty: 7 runs, 1 regressions (v6.1.59-cip8=
-106-g65bd536c294e)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.59-cip8-106-g65bd536c294e/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.59-cip8-106-g65bd536c294e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      65bd536c294e2f5356dabd805e63516e90d72628

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/653d6e88717498496aefcf0f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-collabora/ltp-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-collabora/ltp-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/653d6e88717498496aefcf=
10
        new failure (last pass: v6.1.58-cip7-132-gb38ea1474c159) =

 =20

