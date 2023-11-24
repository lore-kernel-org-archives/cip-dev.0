Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99605C61DF4
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 12:07:16 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web11.134065.1700827633418217045
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Nov 2023 04:07:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=XHvwOQC1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1cfa5a7a9ecso2937695ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Nov 2023 04:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700827632; x=1701432432; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zU+Mo9YbzHRc17am1/r9+GWPOxzGoFJDKgZNbQ/MuJk=;
        b=XHvwOQC1tY0hQLAgVVWjfkPoDjdx1OjI7LWLPLng7s3Q9+L2ZtUNj8/5syllRrrE0b
         ALAPrW8Kf0aoUDFanHzWudlUae02RaMHj4o8TvMPG1ITLvXN9+9UOlT60WbqgTm/teO3
         hUWQKzv/aT8i8HgwDkG1tTxG5yD6rLI7kmYFroNNUo/LmGs49SdhuRTtomFe8XlsjDkb
         a0XbYpHNiNXAHgexfgnLTArIzAEyim7QkJJYpMcIoUzc4ea5vgZGglz3EUVgnXFGQWnd
         IjANRByv+tkFegEbV73wsRFkcJ7doogKof3re3m560kxR0IjuEGyDNPNpv5xnEiW4+Ja
         FtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700827632; x=1701432432;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zU+Mo9YbzHRc17am1/r9+GWPOxzGoFJDKgZNbQ/MuJk=;
        b=pdFD/k1Ce/1tGz3ErgFVKQq25LJIuiLFj7daP6ScFa8Mf3xIzWW8UUaQMpssEJ+kW8
         sBFF74t2moD3kCPnneXUOMD7lok7f0Qche+4FnKLx+IVQg7jbY2djTmPLMoRCWaZTWck
         VSK52EK9xwP6LaHuEBJOAgd5X7X1wn33Z/H6Pbmi/Sh/4ZW6fWRGBqOhDwHp4gUQBQDr
         F8Nopa9nXF4I+VnMYBEQADCDKBWW3A5fD/hrNLpSmVKoqkX7lA/Xx+EGQfvXcc8EFQeQ
         Tz9M1GlBOyyhyHoDEg5qOGI0nWwT1ZArUQsvO2lt2VifSPyBXyVcHSGJuakJ4zy5lkmc
         GZEA==
X-Gm-Message-State: AOJu0YxeS+s5LC/8PuLxtVRqBkDdYv57JTOCP7s/EomJ7zdpeMVdWWYS
	5n+u31hlXno3q5q8NLrBYYDjADcZ1XVFEfISKm8=
X-Google-Smtp-Source: AGHT+IEqVzsPWpVKhyIWbeafrkApW9OdcWDiz2kXqc8l97U5lhYCpMHhKkGoAWflj1HbtndGhUXeUg==
X-Received: by 2002:a17:903:2343:b0:1cf:56e1:ba98 with SMTP id c3-20020a170903234300b001cf56e1ba98mr3013291plh.18.1700827632274;
        Fri, 24 Nov 2023 04:07:12 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jw11-20020a170903278b00b001cf5193b189sm3055434plb.9.2023.11.24.04.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 04:07:09 -0800 (PST)
Message-ID: <656091ed.170a0220.8dcc.6bee@mx.google.com>
Date: Fri, 24 Nov 2023 04:07:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.201-cip41-11-ga539098fe70dd
Subject: cip/linux-5.10.y-cip ltp-fcntl-locktests: 7 runs,
 1 regressions (v5.10.201-cip41-11-ga539098fe70dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 12:07:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13733

cip/linux-5.10.y-cip ltp-fcntl-locktests: 7 runs, 1 regressions (v5.10.201-=
cip41-11-ga539098fe70dd)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-11-ga539098fe70dd/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-11-ga539098fe70dd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a539098fe70dd29de0ce67ad5a39c40867ba5b2c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65608346ed1f4feac47e4a70

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests=
-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests=
-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65608346ed=
1f4feac47e4a71
        failing since 162 days (last pass: v5.10.182-cip35-1-g7cde3fba93966=
, first fail: v5.10.182-cip35-8-gdba81ae6f2be) =

 =20

