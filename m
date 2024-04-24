Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAEBC19F4E
	for <webhook@archiver.kernel.org>; Wed, 24 Apr 2024 22:54:06 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
 by mx.groups.io with SMTP id smtpd.web11.3521.1713999237737110082
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Apr 2024 15:53:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=gLP4rXHx;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.48, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5ad7737ae84so217952eaf.2
        for <cip-dev@lists.cip-project.org>; Wed, 24 Apr 2024 15:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1713999237; x=1714604037; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VLOfOLKllucmTECnPbvYQHrhAspCCghPOEhVKMNXSw8=;
        b=gLP4rXHxWL7SPbBnd5MpTkOQLU5O9Ffew9iYhKXmYWTgmeF8s8NcPJ3DxYNxBkIbrU
         7DRahNyWc0nqGHwwfIr5ILOf49ZZtnApeyVY3UVhpBjoDtIwSsQKKmkGSqzQTi7+84Wf
         qky6tjzfxlSeWT6AAVoAtUhOlqFciJsO2YJ0WCTdBTFjG85CwRkxITsEX8b7GFvVimFD
         cJSpszRmk2PEp4Gkjyqa2rjpl1mgeRwcibT82/YOGSH3YWYSwsDsHuyT05tr4k90wLX1
         DoqESw6LV5nOXtgZbN3F1vLeLYAa+6QdUT+aK7lBd6ksWtmwbmMEVhztYLYgQb75RI4C
         Vnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713999237; x=1714604037;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VLOfOLKllucmTECnPbvYQHrhAspCCghPOEhVKMNXSw8=;
        b=YUTKflMGY6USWu4tF1GlW+Xg+Z9dDxGO3svZ1g7903Sg/XVEfxOTB6YhnUhFd03nyQ
         FEM6J+eKGX7ppvQn1J4MXvj1QMz6EToVVXYylWBEUf85h5GkepCzhs/59ZGAP4CrR/x7
         VP3Hq/ng6r+Vojkw++SgceZkErn/kHAmaqlK0ueed1Zsmg5QQIzMsd8FJU+CIoyRLs0q
         9MoOiasXp4lOKcOBFLHJh4Ri6+AackcGRwJDLoT0X/lgEY2Emex3RyRlVTqvICIRmlnv
         DlAUE1vfexYQEDZv36bKG71ORZsTCmqRbtlJ5xY7kT8iD0V9ouErUpF6gMMuQjZ6wQhw
         WlTA==
X-Gm-Message-State: AOJu0YwPBQWQ9X0qrlN97jIjdA7MBIOpBbDHX6e06DrUDIuBwuQPA91g
	JYB4GSJ+Igyo0G6gcpHMI5t6rWmJP160ldkwgk7wa7e8abN0lnSri/PARtXkQ/2byO9ASljqHOy
	Ipo5jNM2p2j6VSyf0CpQeOCT//Kw/eHupS4kUiMUWoisbocjbPUA=
X-Google-Smtp-Source: AGHT+IHrxbfu4cA3nVT75pP05x1zrIL+YEuKs3f0lIDq42iYzDyko6inpRRgAGUqQflpBmZn+nkbrScpH7yrcSxkjes=
X-Received: by 2002:a05:6871:b38f:b0:22e:c08c:b1cd with SMTP id
 be15-20020a056871b38f00b0022ec08cb1cdmr3008767oac.3.1713999236582; Wed, 24
 Apr 2024 15:53:56 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 25 Apr 2024 07:53:20 +0900
Message-ID: <CAODzB9orb6d7OtUUFfxd4VW6vhxdeoiHOLLB-zaG5yxGcFL4Tg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Apr 2024 22:54:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15745

Hi!

It's this week's CVE report.

This week reported 10 new CVEs and 6 updated CVEs.

* New CVEs

CVE-2024-26921: inet: inet_defrag: prevent sk release while still in use

Announce: https://lore.kernel.org/linux-cve-announce/2024041819-CVE-2024-26921-e3b3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7026b1d ("netfilter: Pass socket pointer down
through okfn().") in v4.1-rc1.
Fixed in v6.9-rc2.

Fixed status
mainline: [18685451fc4e546fc0e718580d32df3c0e5c8272]
stable/6.1: [7d0567842b78390dd9b60f00f1d8f838d540e325]
stable/6.6: [f4877225313d474659ee53150ccc3d553a978727]
stable/6.8: [e09cbe017311508c21e0739e97198a8388b98981]

CVE-2024-24856: Missing null pointer check causes a null pointer dereference bug

Announce: https://www.cve.org/CVERecord?id=CVE-2024-24856
CVSS v3(NIST): N/A
CVSS v3(CNA): 5.3 MEDIUM

The memory allocation function ACPI_ALLOCATE_ZEROED does not guarantee
a successful allocation,
but the subsequent code directly dereferences the pointer that
receives it, which may lead to null pointer dereference.
To fix this issue, a null pointer check should be added. If it is
null, return exception code AE_NO_MEMORY.

Fixed status
Not fixed yet.

CVE-2024-24862: Null pointer dereference bug in pci1xxxx_spi_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2024-24862
CVSS v3(NIST): N/A
CVSS v3(CNA): 5.3 MEDIUM

In function pci1xxxx_spi_probe, there is a potential null pointer that
may be caused by a failed memory allocation
by the function devm_kzalloc. Hence, a null pointer check needs to be
added to prevent null pointer dereferencing
later in the code. To fix this issue, spi_bus->spi_int[iter] should be
checked. The memory allocated by
devm_kzalloc will be automatically released, so just directly return
-ENOMEM without worrying about memory leaks.

It report said that it affected from v6.2 before v6.9-rc3

Fixed status
Not fixed yet.

CVE-2024-24863: Null pointer dereference bug in malidp_mw_connector_reset()

Announce: https://www.cve.org/CVERecord?id=CVE-2024-24863
CVSS v3(NIST): N/A
CVSS v3(CNA): 5.3 MEDIUM

In malidp_mw_connector_reset, new memory is allocated with kzalloc,
but no check is performed. In order to prevent null pointer
dereferencing, ensure that mw_state is checked before calling
__drm_atomic_helper_connector_reset.

It report said that it affected from v4.19-rc1 before v6.9-rc2

Fixed status
Not fixed yet.

CVE-2024-24891: Kernel information leak in tcm.c

Announce: https://www.cve.org/CVERecord?id=CVE-2024-24891
CVSS v3(NIST): N/A
CVSS v3(CNA): 6.0 MEDIUM

Exposure of Sensitive Information to an Unauthorized Actor
vulnerability in openEuler kernel on Linux allows Resource
Leak Exposure. This vulnerability is associated with program files
https://gitee.Com/openeuler/kernel/blob/openEuler-1.0-LTS/drivers/staging/gmjstcm/tcm.C.
This issue affects kernel: from 4.19.90-2109.1.0.0108 before
4.19.90-2403.4.0.0244.

The drivers/staging/gmjstcm/tcm.c is not found in the mainline so we
do not have to take care of this CVE.

Fixed status
This bug is not in the mainline nor stable kernels.

CVE-2024-24898: Kernel information leak in tcm.c

Announce: https://www.cve.org/CVERecord?id=CVE-2024-24898
CVSS v3(NIST): N/A
CVSS v3(CNA): 6.0 MEDIUM

Exposure of Sensitive Information to an Unauthorized Actor
vulnerability in openEuler kernel on Linux allows
Resource Leak Exposure. This vulnerability is associated with program files
https://gitee.Com/openeuler/kernel/blob/openEuler-1.0-LTS/drivers/staging/gmjstcm/tcm.C.
This issue affects kernel: from 4.19.90-2109.1.0.0108 before
4.19.90-2403.4.0.0244.

The drivers/staging/gmjstcm/tcm.c is not found in the mainline so we
do not have to take care of this CVE.

Fixed status
This bug is not in the mainline nor stable kernels.

CVE-2024-26922: drm/amdgpu: validate the parameters of bo mapping
operations more clearly

Announce: https://lore.kernel.org/linux-cve-announce/2024042317-CVE-2024-26922-896d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit dc54d3d ("drm/amdgpu: implement
AMDGPU_VA_OP_CLEAR v2") in v4.12-rc1.
Linux 4.4 is not affected.
Fixed in v6.9-rc5.

Fixed status
mainline: [6fef2d4c00b5b8561ad68dd2b68173f5c6af1e75]

CVE-2024-26923: af_unix: Fix garbage collector racing against connect()

Announce: https://lore.kernel.org/linux-cve-announce/2024042418-CVE-2024-26923-f7f6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1fd05ba ("[AF_UNIX]: Rewrite garbage collector,
fixes race.") in v2.6.23-rc1.
Fixed in v6.9-rc4.

Fixed status
mainline: [47d8ac011fe1c9251070e1bd64cb10b48193ec51]
stable/5.15: [e76c2678228f6aec74b305ae30c9374cc2f28a51]
stable/6.1: [b75722be422c276b699200de90527d01c602ea7c]
stable/6.6: [507cc232ffe53a352847893f8177d276c3b532a9]
stable/6.8: [dbdf7bec5c920200077d693193f989cb1513f009]

CVE-2024-26924: netfilter: nft_set_pipapo: do not free live element

Announce: https://lore.kernel.org/linux-cve-announce/2024042420-CVE-2024-26924-4d1e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3c4287f ("nf_tables: Add set type for arbitrary
concatenation of ranges") in v5.6-rc1.
This commit is not backported to 5.4, 4.19, and 4.4.
Fixed in v6.9-rc5.

Fixed status
mainline: [3cfc9ec039af60dbd8965ae085b2c2ccdcfbe1cc]

CVE-2024-26925: netfilter: nf_tables: release mutex after
nft_gc_seq_end from abort path

Announce: https://lore.kernel.org/linux-cve-announce/2024042421-CVE-2024-26925-7c19@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7203443 ("netfilter: nf_tables: GC transaction
race with abort path") in v6.5.
This commit was backported to 5.10, 5.15, 5.4, and 6.1. Linux 4.x is
not affected.
Fixed in v6.9-rc3.

Fixed status
mainline: [0d459e2ffb541841714839e8228b845458ed3b27]
stable/5.10: [2cee2ff7f8cce12a63a0a23ffe27f08d99541494]
stable/5.15: [eb769ff4e281f751adcaf4f4445cbf30817be139]
stable/5.4: [61ac7284346c32f9a8c8ceac56102f7914060428]
stable/6.1: [8d3a58af50e46167b6f1db47adadad03c0045dae]
stable/6.6: [8038ee3c3e5b59bcd78467686db5270c68544e30]
stable/6.8: [a34ba4bdeec0c3b629160497594908dc820110f1]

* Updated CVEs

CVE-2022-38096: drm/vmwgfx: Fix possible null pointer derefence with
invalid contexts

The mainlinx, 5.10, 5.15, 6.1, 6.6, and 6.8 were fixed.

Fixed status
mainline: [517621b7060096e48e42f545fa6646fc00252eac]
stable/5.10: [c560327d900bab968c2e1b4cd7fa2d46cd429e3d]
stable/5.15: [899e154f9546fcae18065d74064889d08fff62c2]
stable/6.1: [07c3fe923ff7eccf684fb4f8c953d0a7cc8ded73]
stable/6.6: [ff41e0d4f3fa10d7cdd7d40f8026bea9fcc8b000]
stable/6.8: [585fec7361e7850bead21fada49a7fcde2f2e791]

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

