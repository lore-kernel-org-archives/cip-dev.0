Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527B7C4828D
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 23:05:52 +0000 (UTC)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
 by mx.groups.io with SMTP id smtpd.web11.4971.1707347148956168386
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Feb 2024 15:05:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=Kv+o7hIN;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.43, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2196dd318f5so869513fac.3
        for <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 15:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1707347148; x=1707951948; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I1jbGaWTg2JxR6I/4C6QxbIa9kSv4qrfU/hQ4C5c29o=;
        b=Kv+o7hINnsliMqZ0H0cCMFccfLJwlJtXiinGkWfeoDKee67QDBR+DXVb9OxNpnGP7k
         sJr45iuI8E7v0SJRM4aK++3o6ksarv/pcGayNMA2+trHQ5t2D8BrGQXcl71nJIPaLQkf
         +mmvYoGf0LaE6xN+Bn/afFHcPXkuNoeV4TwAzJguNtkjlhUsIK64XgXxbLATqSlXhcfK
         petlhmIqU38Qp6kGew+l2Vl/2CDVpGg4eaQnkXrL/pcpagCW2ojzpZCMT+/8ud2lS3oA
         A8j1Wak1WKIf/plMiIkSoUZ11tD9CMYCo43nfrb90bFg8BUENfQvOBe5qr3dxCY4IdG6
         3JzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707347148; x=1707951948;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I1jbGaWTg2JxR6I/4C6QxbIa9kSv4qrfU/hQ4C5c29o=;
        b=plSVAjgTCT0zIbeMJjo1wLoOsubwNg+TcUDIAZV6z+KGg88861jLx1eJ8qEmrFNNiC
         5nIxzQ1rNL8MdSNT3BDMDOu8WPLsVf/Dsr7875Mj2Y0BopHi8BA9JaywBWpONUxKz9UP
         iG85Ixv49iuuQduveRHKIgaauxOcXBZz43SX4/QP9ZNltjhG3/Ne91DpQU7SsSjj4kp5
         mbNVSBPtdaWKi5lyu9sICZ85b7tXi0IsZ1nXIDigdJA7JsCdXTbJP55T7f2NPIPy3LHv
         w4iDpRXs9SP9ogtoMsEgnfY5mDJ4VtfBIEnTUIn35pFmBwRA4l2AuaPrtOvk5A/BwDmL
         6ACg==
X-Gm-Message-State: AOJu0YwFSmZD4xstG4IZYJZFkAm/08+oe2TJ3AqHXi1YSsbY7rI9T+Ko
	vn5cU4eYZ2fLEkbYEzlEKaLq7QzShHtuelZNGzqT/yspOBzFBUJnhbd72lVgAARsSYE99h+wgeu
	5y+sfAosBX10gszuTDt+r7UEk3N6reMoUyikoaZXCqALrj+koUmI=
X-Google-Smtp-Source: AGHT+IEgwqO4iffZ5ZmB5k4eZpoVePhbLqDn3weuYp8nEuYb4J8qtSrylwgG3fo+8cc8gM8HpEMLWTSd2NVpzZXYJKw=
X-Received: by 2002:a05:6870:6390:b0:218:db16:8983 with SMTP id
 t16-20020a056870639000b00218db168983mr8190125oap.50.1707347147852; Wed, 07
 Feb 2024 15:05:47 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 8 Feb 2024 08:05:11 +0900
Message-ID: <CAODzB9rAHEekG4XfSQzigdMh0N+6KO-Z+H2mWZ+cLrbWBXX65g@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 23:05:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14915

Hi!

It's this week's CVE report.

This week reported 10 new CVEs and 3 updated CVEs.

* New CVEs

CVE-2023-6240: Marvin vulnerability side-channel leakage in the RSA
decryption operation

CVSS v3(NIST): N/A
CVSS v3(CNA): 6.5 (MEDIUM)

A Marvin vulnerability side-channel leakage was found in the RSA
decryption operation in the Linux Kernel. This issue may allow a
network attacker to decrypt ciphertexts or forge signatures, limiting
the services that use that private key.

This vulnerability is not only affecting Linux kernel, it is also
affecting lots of softwares.
https://people.redhat.com/~hkario/marvin/

Fixed status
Not fixed yet.

CVE-2024-22386: NULL pointer dereference bug was found in drm/exynos
device driver

CVSS v3(NIST): N/A
CVSS v3(CNA): 5.3 (MEDIUM)

A race condition was found in the Linux kernel's drm/exynos device
driver in exynos_drm_crtc_atomic_disable() function. This can result
in a null pointer dereference issue, possibly leading to a kernel
panic or denial of service issue.

It looks like commit 2e63972a ("drm/exynos: fix a possible
null-pointer dereference due to data race in
exynos_drm_crtc_atomic_disable()") fixes this vulnerability but
accessing to the bugzilla
(https://bugzilla.openanolis.cn/show_bug.cgi?id=8147) is restricted
now so we need to wait for sometime.

Fixed status
Not fixed yet.

CVE-2024-23196: NULL pointer dereference bug was found in sound/hda
device driver

CVSS v3(NIST): N/A
CVSS v3(CNA): 5.3 (MEDIUM)

A race condition was found in the Linux kernel's sound/hda device
driver in snd_hdac_regmap_sync() function. This can result in a null
pointer dereference issue, possibly leading to a kernel panic or
denial of service issue.

It looks like commit 1f4a08fed ("ALSA: hda: fix a possible
null-pointer dereference due to data race in snd_hdac_regmap_sync()")
fixes this vulnerability but accessing to the bugzilla
(https://bugzilla.openanolis.cn/show_bug.cgi?id=8148) is restricted
now so we need to wait for sometime.

Fixed status
Not fixed yet.

CVE-2024-24855: NULL pointer dereference bug was found in scsi device driver

CVSS v3(NIST): N/A
CVSS v3(CNA): 5.0 (MEDIUM)

A race condition was found in the Linux kernel's scsi device driver in
lpfc_unregister_fcf_rescan() function. This can result in a null
pointer dereference issue, possibly leading to a kernel panic or
denial of service issue.

It looks like commit 0e881c0a ("scsi: lpfc: Fix a possible data race
in lpfc_unregister_fcf_rescan()") fixes this vulnerability but
accessing to the bugzilla
(https://bugzilla.openanolis.cn/show_bug.cgi?id=8149) is restricted
now so we need to wait for sometime.

Fixed status
Not fixed yet.

CVE-2024-24857: Integer overflow bug was found in bluetooth device driver

CVSS v3(NIST): N/A
CVSS v3(CNA): 4.6 (MEDIUM)

A race condition was found in the Linux kernel's net/bluetooth device
driver in conn_info_{min,max}_age_set() function. This can result in
integrity overflow issue, possibly leading to bluetooth connection
abnormality or denial of service.

Fixed status
Not fixed yet.

CVE-2024-24858: Race condition bug in
{conn,adv}_{min,max}_interval_set() in bluetooth driver causes DoS

CVSS v3(NIST): N/A
CVSS v3(CNA): 4.6 (MEDIUM)

A race condition was found in the Linux kernel's net/bluetooth in
{conn,adv}_{min,max}_interval_set() function. This can result in I2cap
connection or broadcast abnormality issue, possibly leading to denial
of service.

Fixed status
Not fixed yet.

CVE-2024-24859: Race condition bug in sniff_{min,max}_interval_set()
in bluetooth driver causes DoS

CVSS v3(NIST): N/A
CVSS v3(CNA): 4.6 (MEDIUM)

A race condition was found in the Linux kernel's net/bluetooth in
sniff_{min,max}_interval_set() function. This can result in a
bluetooth sniffing exception issue, possibly leading denial of
service.

Fixed status
Not fixed yet.

CVE-2024-24860: NULL pointer dereference bug was found in bluetooth
device driver in {min,max}_key_size_set()

CVSS v3(NIST): N/A
CVSS v3(CNA): 4.6 (MEDIUM)

A race condition was found in the Linux kernel's bluetooth device
driver in {min,max}_key_size_set() function. This can result in a null
pointer dereference issue, possibly leading to a kernel panic or
denial of service issue.

It looks like commit da9065caa ("Bluetooth: Fix atomicity violation in
{min,max}_key_size_set") fixes this vulnerability but accessing to the
bugzilla (https://bugzilla.openanolis.cn/show_bug.cgi?id=8151) is
restricted now so we need to wait for sometime.

Fixed status
Not fixed yet.

CVE-2024-24861: Race condition bug was found in media/xc4000 device
driver in xc4000 xc4000_get_frequency()

CVSS v3(NIST): N/A
CVSS v3(CNA): 3.3 (LOW)

A race condition was found in the Linux kernel's media/xc4000 device
driver in xc4000 xc4000_get_frequency() function. This can result in
return value overflow issue, possibly leading to malfunction or denial
of service issue.

Fixed status
Not fixed yet.

CVE-2024-24864: Race condition bug in media/dvb-core in dvbdmx_write()
causes DoS

A race condition was found in the Linux kernel's media/dvb-core in
dvbdmx_write() function. This can result in a null pointer dereference
issue, possibly leading to a kernel panic or denial of service issue.

CVSS v3(NIST): N/A
CVSS v3(CNA): 5.3 (MEDIUM)

Fixed status
Not fixed yet.

* Updated CVEs

CVE-2024-1086: netfilter: nf_tables: reject QUEUE/DROP verdict parameters

stable 6.1, 6.6, and 6.7 were fixed.

Fixed status
mainline: [f342de4e2f33e0e39165d8639387aa6c19dff660]
stable/6.1: [8e34430e33b8a80bc014f3efe29cac76bc30a4b4]
stable/6.6: [6653118b176a00915125521c6572ae8e507621db]
stable/6.7: [f05a497e7bc8851eeeb3a58da180ba469efebb05]

CVE-2024-23849: net/rds: Fix UBSAN: array-index-out-of-bounds in rds_cmsg_recv

The mainlinx, stable 6.1, 6.6, and 6.7 were fixed.

Fixed status
mainline: [13e788deb7348cc88df34bed736c3b3b9927ea52]
stable/6.1: [71024928b3f71ce4529426f8692943205c58d30b]
stable/6.6: [7a73190ea557e7f26914b0fe04c1f57a96cb771f]
stable/6.7: [0b787c2dea15e7a2828fa3a74a5447df4ed57711]

CVE-2024-23851: Kernel crash in drivers/md/dm-ioctl.c when allocate
memory more than INT_MAX bytes

Fixed in 6.8-rc3.

Fixed status
mainline: [bd504bcfec41a503b32054da5472904b404341a4]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26557: kernel: predictable Authvalue in Bluetooth Mesh
Provisioning Leads to MITM

No fix information.

CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26560: kernel: impersonation attack in Bluetooth Mesh Provisioning

No fix information.

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

