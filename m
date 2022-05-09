X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web12.1639.1652133174577988193
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 09 May 2022 14:52:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=mrp/ctYs;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id l11-20020a17090a49cb00b001d923a9ca99so521886pjm.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 09 May 2022 14:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=fMMCeimsO/WMtkQ9vO6RzJdWBEFRFOwjGJCf8fug2G8=;
        b=mrp/ctYsALDZ4gAWQTw9PkrMg4uyFxTHO25U+krEduXXVKx/Fd9YpFb9CNszQSgPGb
         3a4yTSUwqsGeMd5pTZAMiBFdXUsYw421E5wNn7f2VvvSLum39xS2IK6+TbAsvelpeNXr
         Kzynm9xjuzZbwMSWmSuyipfbpdhG6Fbbib8uHNCQaM0MvCdpm0XSgrnqqgd9ZLq0efrK
         1PU7+98/vhAp8Kow0TzhqALmvIHfAZAw738o3+c78Jgjav51KRMFjwUGdtdkfaFynzbC
         +cSsmJ7LGxFIuUqdgv0pOHGivXrhWzpa9FP71l+BlQQiWP3Ka7YxgeKgTpPRhYrO38Rw
         7cdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=fMMCeimsO/WMtkQ9vO6RzJdWBEFRFOwjGJCf8fug2G8=;
        b=KmZAvUq6/lpoGS5KqUUG3FYOfmbo+bNlIHdZZZ5CBmWzBnMgPjs/pC1iRB1GLwI3G+
         jaMCDCemOfj/pncwVyT9t1AwmaZOKsJUpGTM7GDe8wCG+ESwFDe7CWthRjlaFAR9RS77
         LAkhrr30jI32C+XKataqzcCBrESSXxxVzUc/OQvM6qjk12ff1wtjPlIjSuyjf7zL7LNc
         2kkWptWGfWmtXwBDgvkSTf7uZD63I+vjav2Oq+YbF8rmXw+7ruJphdwP1eqAQyK5eNrE
         DIT6WGJChX0WbZMG20RnulGkIFek+aUh1y/mjQ1GkrcJxtji8d6yC7zom61k6hyyymPo
         Zf8Q==
X-Gm-Message-State: AOAM533e5Z4L36a80zzg8zi+rxHHulANY1sIsK6ljzeporJV2ocBL+00
	GjR9A93xtvb9NsZl4d6VL4tjJAUuqmAQSKMnerQ=
X-Google-Smtp-Source: ABdhPJxbM+7zxO6Zq8lma9xMomwvORg9aMpOTv+DVbuFdA6XOdkHzyHEpKF3URpYljhWSshmvs1Xng==
X-Received: by 2002:a17:90b:1b0d:b0:1dc:672e:c8c2 with SMTP id nu13-20020a17090b1b0d00b001dc672ec8c2mr20028216pjb.96.1652133173839;
        Mon, 09 May 2022 14:52:53 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 2-20020a17090a1a0200b001d7761ee6fcsm205055pjk.3.2022.05.09.14.52.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 14:52:53 -0700 (PDT)
Message-ID: <62798d35.1c69fb81.6e6e1.0b31@mx.google.com>
Date: Mon, 09 May 2022 14:52:53 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.112-cip6-218-g8253434cd56a
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 22 runs, 1 regressions (v5.10.112-cip6-218-g8253434cd56a) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 22 runs, 1 regress=
ions (v5.10.112-cip6-218-g8253434cd56a)

Regressions Summary
-------------------

platform            | arch  | lab          | compiler | defconfig | regress=
ions
--------------------+-------+--------------+----------+-----------+--------=
----
r8a77950-salvator-x | arm64 | lab-baylibre | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.112-cip6-218-g8253434cd56a/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.112-cip6-218-g8253434cd56a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      8253434cd56a1ed24ebcf6bd7bb980b182888279 =



Test Regressions
---------------- =



platform            | arch  | lab          | compiler | defconfig | regress=
ions
--------------------+-------+--------------+----------+-----------+--------=
----
r8a77950-salvator-x | arm64 | lab-baylibre | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/627985ca744f3839d88f5753

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-218-g8253434cd56a/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-nfs-r8a77950-salvator-x.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-218-g8253434cd56a/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-nfs-r8a77950-salvator-x.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220506.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/627985ca744f3839d=
88f5754
        new failure (last pass: v5.10.109-cip5-24-g4e205e4287c50) =

 =20

