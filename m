Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7630C10F09
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 21:13:10 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web11.103809.1701983587868915209
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 13:13:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=qtemYUc2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-286f8ee27aeso1429691a91.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 13:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701983585; x=1702588385; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qkeLxvmgxJq2JGgwgu/DzUjsRMKd8jHAcTUE/+lOdWg=;
        b=qtemYUc2dc1JXJ0SQIH1Yq0wd1WMSQL/hLwDOcJ9c2EFi8mPO4IQGi0oQKnPMkeirv
         taXmJRyxpOxXElN7d1Pzb7KpIRtwjllLl4aaioU83eUSrSId5OJ5eB0Z9azKf9PtjMPV
         BP6k2PMaY6bPQJo3v8wP9oBXgQ6ziYvFIO9XSWHYUQE+Qg/kj98VEIBNWuttR8f9A8s2
         dBh9WQH/MTFWg4vgf6E6nAHuyzN3xUJB+2ZzGqHV4SBoIRVgc09L9hQg1yRiSZphbL4G
         isC/DeWf8sebPhteyazfHGWYZz7I7xK/JDafHPJPWlL/d2EyzETrgl0ilxWw7rf2yFf1
         RyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701983585; x=1702588385;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qkeLxvmgxJq2JGgwgu/DzUjsRMKd8jHAcTUE/+lOdWg=;
        b=XsSU/OIO/rmrwIIeUTkPcC8FvT3skdXetnHOvIgwlSDZsCbkTzj0ZCg3Yf4DerZeE2
         f/Za1puhP4EO5gjHt30hVbBcJplsrgsxG5jwHYJVwC9wm6VjkVu9OA2kEVVShGFk2+4Z
         hcgLkfxmqB8rg9i8IXvwrcoc2HNps8ZiE5UzPdKRK1NoGA6hEkyCkI/jaqniqY9sSQ30
         A38OL9ls91l+xbEY8kdM35jn2eTR1xvTP7AZvX7vbty4Kln6HY/ErIWLlaMw05BU6lMi
         S9EUUL+/BuQ0SSvzZF1mSMMwmiLzxmHg9nPrABGAgUGflKoY43VMRLAGLP1DN/3+Qqt4
         zVWQ==
X-Gm-Message-State: AOJu0Yx59rz9/iNzIaXfx3LsSHwPbVO8jH6xDHq7bSrhaLJzgd9xXxzW
	qwo3oHkPdrc9YcB5tYFyIptgaNhgRebaFBkox7iMnw==
X-Google-Smtp-Source: AGHT+IGm3rRDFjmioWVg4pTvrErZZWSpWIvrUI7JwKFdnAzUJ+cWxYeQ6FVWhz8SX4GDaOywUTYRSw==
X-Received: by 2002:a17:90b:1b46:b0:286:f16c:caff with SMTP id nv6-20020a17090b1b4600b00286f16ccaffmr3302666pjb.33.1701983584843;
        Thu, 07 Dec 2023 13:13:04 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p20-20020a170902ead400b001d0b5a97cabsm255930pld.124.2023.12.07.13.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:13:03 -0800 (PST)
Message-ID: <6572355f.170a0220.2e2a3.1b20@mx.google.com>
Date: Thu, 07 Dec 2023 13:13:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-28-ga386bc478aa6b
Subject: cip/linux-5.10.y-cip kselftest-lib: 3 runs,
 1 regressions (v5.10.201-cip41-28-ga386bc478aa6b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 21:13:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13916

cip/linux-5.10.y-cip kselftest-lib: 3 runs, 1 regressions (v5.10.201-cip41-=
28-ga386bc478aa6b)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-28-ga386bc478aa6b/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-28-ga386bc478aa6b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a386bc478aa6b422e6dd5d92a540987ddfca9397 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657226518f8b537556e13490

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/657226518f8b5375=
56e13491
        failing since 64 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

