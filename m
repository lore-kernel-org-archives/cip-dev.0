Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F410C47077
	for <webhook@archiver.kernel.org>; Wed,  3 Jan 2024 08:13:13 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web10.13464.1704269584675310082
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Jan 2024 00:13:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=IPdrUN3u;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-28be52a85b9so5198453a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 03 Jan 2024 00:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704269583; x=1704874383; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gcd1QMnDbTUBB//DUd0BXxZpO2yRO2jqFomD+jvXjwI=;
        b=IPdrUN3ufY779VBShFjynM5S5CJ5hFFgVS2dKP80HvFQNB2Bai185ZnBvH20lc++Kr
         y0TTUnGB50hbDfpIvm16IKhPcJYMgvzLz3aCLy1iW0KKtimYPklONhHNKSc8Fmez0hKT
         7CIUxVuPmHtUvxXvXZbMRXXYcO9Qr5Zj89ABRjH25MDCB91+fo/tLzYH+I7EkqJa0TYT
         ILKqfYFNctBmK6d3q6C8MnzoTXMKuP9+zwSgxQSlY4qazWABcdTZkOJRw7iybkk+aADU
         j14SWRfYxFRfCWBylA68yx5WMCs5j3adMumiOg0N19lMzqeJeluHvDRQK+SeFHAWzoAh
         jKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704269583; x=1704874383;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gcd1QMnDbTUBB//DUd0BXxZpO2yRO2jqFomD+jvXjwI=;
        b=mSbURNOa3Jn29Ayg6RPdBJvYr1TmxzukFV59OJwmpI1QK32c727AMxSguHv6MnqoAp
         8LGdgi8xCZNQmooMe952JhS3BOdnE3jDT02o6tTjsU/fLmD2Ko1Rm6PqLKA7SdCXyoLf
         jejXbk5xjpJjD7obV+eewxrBqFO9ATyaR7FTpGpUl9V09qFGoPfqo8t3AbmfQHLeXs0m
         Y3sgXGp0f3cHBCW/EcTehMP418EUA8QYV5nkS9QgIfi2MJW1WGFds3siSx/o3Wl4u5up
         hQPz9gbxpq93dARK3P5nMtwLBIwLtL8+bc4rfAHlzqr9i/WMlfulav/y0mBoISlnkhBg
         yqUg==
X-Gm-Message-State: AOJu0Yy4n1mz0aTQB8d2CB88pulTS3AyKgupIUtGhvFmoGVgOX9751Xt
	QeXCldqajk4E4ef87cANgg4SR5cZkVOG2dE2m+QciFI3oa0=
X-Google-Smtp-Source: AGHT+IHyPlXeU216yv5M2duYrx78ACvCWTAR27JLlp+wBSoA0HYJKxBfS31XL/2MWyICzNF0e6G7ag==
X-Received: by 2002:a17:90a:9c08:b0:28c:4a2d:ccca with SMTP id h8-20020a17090a9c0800b0028c4a2dcccamr4757631pjp.16.1704269583607;
        Wed, 03 Jan 2024 00:13:03 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id pl17-20020a17090b269100b0028aefb5fa05sm977675pjb.40.2024.01.03.00.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 00:13:02 -0800 (PST)
Message-ID: <6595170e.170a0220.6e0a.226c@mx.google.com>
Date: Wed, 03 Jan 2024 00:13:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1224-ga0ac575eeff8
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip baseline-nfs: 28 runs,
 1 regressions (v4.4.302-cip72-1224-ga0ac575eeff8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Jan 2024 08:13:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14241

cip/linux-4.4.y-cip baseline-nfs: 28 runs, 1 regressions (v4.4.302-cip72-12=
24-ga0ac575eeff8)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-1224-ga0ac575eeff8/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-1224-ga0ac575eeff8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a0ac575eeff89882d3aa16d67979a86e668f5d1d =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/659510315f562ffb3c77b5c2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1224-ga0ac575eeff8/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1224-ga0ac575eeff8/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/659510315f562ffb3=
c77b5c3
        new failure (last pass: v4.4.302-cip72-1187-g657481329b53c) =

 =20

