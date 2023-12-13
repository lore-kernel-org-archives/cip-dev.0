Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6E0C4332F
	for <webhook@archiver.kernel.org>; Wed, 13 Dec 2023 10:22:51 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
 by mx.groups.io with SMTP id smtpd.web10.33169.1702462965601245213
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Dec 2023 02:22:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Hyw6+PK3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.53, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-590711b416fso3825476eaf.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Dec 2023 02:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702462964; x=1703067764; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mj6DMCMr9rZ50Mm5UBD3B6nOVJCrLyoOBo+CnZUKCvQ=;
        b=Hyw6+PK3orAM+qqrryBLhDDORz3E94tVTbG68NpPOvkg3MdHtm6ZwDQ++OjQIZeCz3
         SuwdyeArJeYBPbe3pLtUwyeYS5Q3U/m3i0R9jHrxxFuRZoU0YkGB8TDkj5QVjaG72Dhe
         Gx8r/9TVcunWUky2zW8+Q/gY8PN2cBtfQ8Qn9s/ctkWJ33ZGucO6aNnc5dWJKhtKDvWx
         X7LN9HMyCehTbfh7Pn2HRWpESljYm2d22U6X43QamhnfaPaaJ9yfqIXADVJ3vO3Wx873
         C9rCrxQ1LkfGrQkx9txnp7/f9RYnBESPLsgZPoc+T1s85g8zv2bU0zegSBz+jCDZaRqS
         8m2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702462964; x=1703067764;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mj6DMCMr9rZ50Mm5UBD3B6nOVJCrLyoOBo+CnZUKCvQ=;
        b=LXHc1eWF0v/5I4Egd3ChxVRg58RtOgt2jjRFSrQxNsMiy8A6tuzQyWS+lwd7CuWDWy
         GtZIr1/kGuSti9JI1XaLenLEfYEtgiseiMSHAhpFHJ6icea+ZvwXk53CM1S0Zdin+xLT
         kmIqwuRvoYjmLUnR9tke+tP4/JWmbXjWkAw++Sa3T8VqcrL3rDLduwakcOuSCTmkE9ky
         H1qRJs/E0u6fq9IsXWQkwVbknR28nQcQyPalRnA9sKzxBfpLTM+9yvZ9KkNeUGp9JPdF
         u/oMSbB5DQpb3QRsdazJSmHS9KoTAGzDlOyHd7uzC4e+Ns19amW+LVJu09LyJ7uxZrEx
         aqdg==
X-Gm-Message-State: AOJu0Yy4HQ5BDQQ8Tbiw8hjIYYxo7XM/0lj099CGNccRTdWsc+xURdG/
	0w/oqsEYjKjK9YTXlptdMDFxpgeGM/YEszTSOXPVzA==
X-Google-Smtp-Source: AGHT+IHN1A9NGh+uDZPdnf5WZ3GA7XdpoEBPbS0K6mmaxfEq6jLj2y/mB6kVFdgCFz0+/RrhX81Ckg==
X-Received: by 2002:a05:6358:88c:b0:16d:fb29:d78 with SMTP id m12-20020a056358088c00b0016dfb290d78mr10305949rwj.2.1702462964160;
        Wed, 13 Dec 2023 02:22:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j20-20020a635954000000b005c200b11b77sm9682669pgm.86.2023.12.13.02.22.43
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 02:22:43 -0800 (PST)
Message-ID: <657985f3.630a0220.974d.d165@mx.google.com>
Date: Wed, 13 Dec 2023 02:22:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-77-g545d45774209f
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 6 runs,
 1 regressions (v5.10.201-cip41-77-g545d45774209f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Dec 2023 10:22:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14065

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 6 runs, 1 regressions (=
v5.10.201-cip41-77-g545d45774209f)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-cip41-77-g545d45774209f/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-cip41-77-g545d45774209f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      545d45774209f8cd48179f8431020b19faaeef38

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/65797817efba1d8521e134a1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm64/defconfig/gcc-10/lab-broonie/ltp-f=
cntl-locktests-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm64/defconfig/gcc-10/lab-broonie/ltp-f=
cntl-locktests-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65797817ef=
ba1d8521e134a2
        failing since 3 days (last pass: v5.10.201-cip41-63-g2bc5a8583f4a8,=
 first fail: v5.10.201-cip41-63-gfdfe1fbf93bc6) =

 =20

