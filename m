Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66B1C54E5D
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 21:13:36 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web11.35756.1709327612125439759
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 13:13:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=r3+ZC+mF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e5e4b1d1f1so147967b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 13:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709327611; x=1709932411; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wc/C7b4EZ+qfyCpKfALCA3bX3CimBwzOiU37NM0xJyM=;
        b=r3+ZC+mFC9T+mwrZDhC9xlyojIUabt3w6E8uC5AgntQPp5pfSUJc8tq2hWRTExKPnE
         1cR7fQZYLJn4Exmz46Xig0Alm2lOabd4EobqK19AOCHve/rk7RVJoDCpcEG911uDvbxa
         TbU13BFFO3mU3L77C9P8TGWNMrOasruSk79kxm6f86vqZBIDSGdlTANKRZFNs52pQLxo
         nKIxRY0ZJ7GOlioZyBkfAaLRpi/CrgVVTBqpC4vWppFFwMIUiHnwhIIEEXDSR0eHA6y8
         JhsbeBXMY9n/8NpFlbBQZ9bC+oOydQD3j/L2i+VjPfpOXiMDDjegWxHxfK5YfTCZSkck
         Pz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709327611; x=1709932411;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wc/C7b4EZ+qfyCpKfALCA3bX3CimBwzOiU37NM0xJyM=;
        b=R8IfilsxKn5Tva6N548kMDOET0CRjbZwhEbOhJGEE4Zd0gtCaGLrAB43acpGHm0XTM
         H/XoCKDTzSt0oPIgPKsJgcSBm2j9FEU8mEaEoZQav4D1O1tXhBbysNtzNBpNsAPzJH9B
         O0shmp7d9/ngojGtBk0YD2bBbtvFUCTEC6Fn/Egqs50HLgyLwVlcXGkBpaSXecFNWso1
         yP3vDY2MxeMdhSO9wualXUMk+46hnz3MrSdShn8vI2WLTybvGwYfVKvdE1pN1QQuL8Zy
         +DXSgvKBsqDWjY2yiEDKjdhP0Z0zQjXAztfmPuKD6+oDsdpouYhNNfxEul+hqGRzS1ym
         z28g==
X-Gm-Message-State: AOJu0YyauiJdzYK1Ajp+fhQRke8KpXB7qeg58Tgw+g25S29dTMZ08doe
	IvzqzLp7Q+9/L3esK9FmvAYrvcFo8Qa/i44RyhJ8xmoVXTlp5fIzXnc3JjldJRUCH8Yw9TcP01B
	Au5k=
X-Google-Smtp-Source: AGHT+IFrTlzhQrv6h8i9h/LXdFIxjnfd2dnb4fMjPk0XXgbL6n+W2H/ljxYE5c/Pab8Xcj0whbHF9Q==
X-Received: by 2002:a05:6a20:c706:b0:19e:a5ae:229b with SMTP id hi6-20020a056a20c70600b0019ea5ae229bmr7172608pzb.31.1709327610713;
        Fri, 01 Mar 2024 13:13:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2-20020a63bd42000000b005dc832ed816sm3071075pgp.59.2024.03.01.13.13.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 13:13:29 -0800 (PST)
Message-ID: <65e244f9.630a0220.741f8.e4e4@mx.google.com>
Date: Fri, 01 Mar 2024 13:13:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.209-cip44-552-gc0460fb20fc00
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 4 runs,
 1 regressions (v5.10.209-cip44-552-gc0460fb20fc00)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 21:13:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15142

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 4 runs, 1 regre=
ssions (v5.10.209-cip44-552-gc0460fb20fc00)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-552-gc0460fb20fc00/plan/kselfte=
st-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-552-gc0460fb20fc00
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c0460fb20fc000a52548daa693788068d4fc9a8e =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65e2346eef4812ade763702a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65e2346eef4812=
ade763702b
        failing since 120 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

