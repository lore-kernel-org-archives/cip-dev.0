Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859D1C54FCD
	for <webhook@archiver.kernel.org>; Wed, 29 Jul 2026 22:39:23 +0000 (UTC)
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23493.1785364754076061650
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jul 2026 15:39:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=L2kXE/p7;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.47, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6688dfaed31so1884181d50.3
        for <cip-dev@lists.cip-project.org>; Wed, 29 Jul 2026 15:39:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785364753; cv=none;
        d=google.com; s=arc-20260327;
        b=agfEadHRo3hkERk+LsEkyQ3hKCf1KK3E16RdyTi05lGaJws3F65yyaF/QbEtT7OpvJ
         A8p+RCMb6jmzF5b0ob+FnjFTHoH/8xsZSLkWJeRhTYRV+xHX/d+h9pbsszWjuFo7Yepz
         pw7L4JeKz1FfYdy1N6vAJQj1KHUaci9NpxDiCVMsXtciTbBJBq3YnDB7pe9Y7fHg5AG4
         R2523ySHWq5Cau0anlqtIuHxZ4H11ngSD0RiPkH6FDjhxCPGyLKp8SGfrOMAlTNqi7P/
         gE/1kP54PWEpj7uYYuwlOhf6y/ySfFdBTNTy6Olt1ZUYXgmF58ytoRepVxXybGy53V6I
         hYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=HRWfrsPuXd/zTJai7UCR9V4MifO2IC6a3f2aZZi5zCw=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=oEVD6S4aWH2XPl82RabEmGmP1Ca5/eX32FkSVh+qDe6YmeLY5o5k4z9kPL28J71Jfy
         QNKPV6JQPlRCe1rCKw49X07YNa2Ojln6vAwh2pb8yunkgs8VeU4O+ljLbdoPy6AeFD3o
         hWM/QiJake4AxqNXVFaiPaFR9wDdWmuEEutiwy9mcrMidbKwYpbsWg0cPBjrnX2D9/hb
         zMo29uYREPkwJ51Z6SgOEHdbb+QT3bW/rZiUKxv4wd5OhFHFhJ2lLIvBwrYG9DPEOIHZ
         48jsBLt9JN4jllWHHJg8uSfaQJX4CAO2zxEPQdymTu1IIULw92XjoVx+lYoedWBf+wO1
         yMOg==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1785364753; x=1785969553; darn=lists.cip-project.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HRWfrsPuXd/zTJai7UCR9V4MifO2IC6a3f2aZZi5zCw=;
        b=L2kXE/p79KRX6b/40nXR3Md/9xkWySPlcgMp5FpuIFPGRHtdCClQHyYFieZVfcT+GI
         s7EP9uXSmBaLeXNJlD2G1JPspZvij/Ly4GjSunTw69QWyomVMvBkctzVG89777JwUaex
         pBWBs9oNCECi/IxF3one5ROuLu2sqpcYY+tD0kacBKZBZJkljWW+n6wS289sdOd2z+ne
         P4ahB7o3PRSV/qJALATMJl6ljwcnf7bFdc4MKf89yWRJvUgCv2ppslwWmpgF3Ltd3UeV
         Xl0clxk9x1DBb1n9DStj81dhGr0mQ0iBe6DmiF9LIW00YjbBn1uuPtab8YivrrrcsP+/
         eQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785364753; x=1785969553;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HRWfrsPuXd/zTJai7UCR9V4MifO2IC6a3f2aZZi5zCw=;
        b=HdDDQDXK2XgSn6YYQQxE7k/8R8nw7dYIh9VOxkvQsRxnvc6Ixs/TUlXNwMYpUkGC+B
         fjrDRRv+KmvfQug92yYtT8yKE89V6MOLfKngWWnsYVwvW8J2fYOdiwjVCwTV06bA1NqF
         ktVnQ0CBQ868BVdm9OFFpXWdKlQjNk1kY2Mn/PI+JIaPAVZLdUEJXEP7KkORB4lDv3pl
         N4gC9rKSuPVV5c4eekdHcutnP+RjES3QOvwSIwjd9//N3NneDqKj199a8Cu8tt4CZXOw
         XPZ7LHGBN2GTwCz7voBK6InEmrajyRD+w6oMClhIfSrmQynQxCUC57X9QjAI3DVK1Qu5
         2oMQ==
X-Gm-Message-State: AOJu0YwGmervwk/Ljch2FlyK16G1Tf2GlRiAUWBiJYRLrSci/xpXi6wM
	zTDV6aU59jIl1UNXSjOHgEWR63/G9uwZiDqLUxRsqvt/7Ox45Sjsx893WoCiIpPBOegTtc19e3e
	s2fav1M+phP0BzvF2u8/TcqCLkNNdunjuH0ebxdud7rWDN8iQh4NzGnoZnQ==
X-Gm-Gg: AR+sD12p6BhcguBxKacq+yFq+WIfkNMLrByteSA+654htKna6nXndSwIG0JimqT+/xW
	Fp5bwcRD3MliRA7NHhMrc6EHDsDh526IQhVPindkE4uq9RH9mCKK2kfCYq7eNxn1LcRFUfUnRmV
	7vKAINA/BMwEqkcFx1DiRrIvZleysR5Dmzh30eyExKeHoi/NbBPGOHugv2vBVT8enbxAqqUICFK
	PslngnIru1E1lN1M/VVcD2Wgb/HdYDJ74ihEQq++HvAyFfJ+286bDRiEGYcRVJ0JaHIGyKt06Bw
	sdiyuS1Mkjg3SU/mfMXls/mW6pcXprsQrhyyTQXlNThP2WMPW89pF40BZ1TJhwSai+lCP9f2d72
	CyOqkn86DOkoXVwfL
X-Received: by 2002:a05:690e:1592:10b0:668:ea3:66c2 with SMTP id
 956f58d0204a3-6692ba202fbmr296781d50.78.1785364748857; Wed, 29 Jul 2026
 15:39:08 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 30 Jul 2026 07:38:32 +0900
X-Gm-Features: AUfX_my85N8QDi9ovvxrEyN1C7oRtvp0-W37DziVKUKJZYmmjaL5qg4MWHbwhIw
Message-ID: <CAODzB9r0NvDsFSP3fS4Y6LFhdKGNAj2ykLRu+Ph72+xhJ92SxQ@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Jul 2026 22:39:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23815

Hi!

It's this week's CVE report.

This week reported 355 new CVEs and 65 updated CVEs.

* New CVEs
CVE-2026-64208: crypto/krb5, rxrpc: Fix lack of pre-decrypt/pre-verify
length checks

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64208

Introduced by commit 9d1d2b5 ("rxrpc: rxgk: Implement the yfs-rxgk
security class (GSSAPI)") in v6.16-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b50aceafe6606ea52ed42aadd1b4d44a188aade]
stable/6.18: [585f9f6aef5c4542ac9d6ec45cd7dbc7df9af3ff]

CVE-2026-64209: phy: qcom: qmp-usbc: Fix out-of-bounds array access in
dp swing config

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64209

Introduced by commit 81791c4 ("phy: qcom: qmp-usbc: Add QCS615 USB/DP
PHY config and DP mode support") in v7.0-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea17fc4d7dc2ba6459b1a318962960520201baf1]

CVE-2026-64210: net/mlx5e: xsk: Fix unlocked writing to ICOSQ

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64210

Introduced by commit db05815 ("net/mlx5e: Add XSK zero-copy support")
in v5.3-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c326f9c68921e2f14dfcecb2f6b4216313d50248]

CVE-2026-64211: srcu: Don't queue workqueue handlers to never-online CPUs

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64211

Introduced by commit 61bbcfb ("srcu: Push srcu_node allocation to GP
when non-preemptible") in v7.0-rc6.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [593889c401426004bd0ea0f6d4fcece728b03420]

CVE-2026-64212: wifi: iwlwifi: mld: don't dereference a pointer before
NULL checking it

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64212

Introduced commit is not determined.Fixed in v7.1-rc5.


Fixed status
mainline: [d733ed481fd20a8e7bfe5119c4e77761ba3f87ee]
stable/6.18: [3a74aaad047353da3344aed32e9042d4f334f926]

CVE-2026-64213: hwmon: (lm90) Add lock protection to lm90_alert

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64213

Introduced by commit 7a1d220 ("hwmon: (lm90) Introduce function to
update configuration register") in v5.3-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [873e919e3101063a7a75989510ccfc125a4391cf]
stable/6.18: [bed1fc32e0eb653806fa98afcf55f9a311fc4ce2]

CVE-2026-64214: powerpc/time: Remove redundant
preempt_disable|enable() calls from arch_irq_work_raise()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64214

Introduced by commit cc15ff3 ("powerpc/mce: Avoid using
irq_work_queue() in realmode") in v5.18-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [31467b23823ffec1f6fff407f8e3ca9af8b7491a]
stable/6.1: [51860e423592893cd7bfa7287d99a3aff4dc3a9d]
stable/6.12: [72d8d1c36452a4d3ee134b1da48de7518c1329f9]
stable/6.18: [6dcd072a5ae3aed336e4a67a7d4cc5205b240065]
stable/6.6: [a09d07ac45e283c9861a9ceea06f56d0ba851d22]

CVE-2026-64215: drm/msm/a6xx: Check kzalloc return in a8xx_hfi_send_perf_ta=
ble

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64215

Introduced by commit 06cfbca ("drm/msm/a6xx: Share dependency vote
table with GMU") in v6.19-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b5c7a7f452b885bfbe102bd3a057a5f496802f8b]

CVE-2026-64216: netfs: Fix potential UAF in netfs_unlock_abandoned_read_pag=
es()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64216

Introduced by commit ee4cdf7 ("netfs: Speed up buffered reading") in v6.12-=
rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dbe556972100fabb8e5a1b3d2163831ff07b1e8e]
stable/6.18: [6080fa3ecfbb4448a3b47368629534c09b6ec750]

CVE-2026-64217: netfs: Fix overrun check in netfs_extract_user_iter()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64217

Introduced by commit 85dd2c8 ("netfs: Add a function to extract a UBUF
or IOVEC into a BVEC iterator") in v6.3-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ef37eef83fad3542ee06db2940433ae1a92b39d]
stable/6.12: [96cc3beb2390ba9f9c128c5733c0ccfe450dd4f9]
stable/6.18: [afeb32d9bf9aaeea51d0f723a19f14afb73bd94d]
stable/6.6: [00efe58bbdcc93272d579ca24bfc912563f4a204]

CVE-2026-64218: batman-adv: bla: fix report_work leak on backbone_gw purge

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64218

Introduced by commit 2372138 ("batman-adv: add basic bridge loop
avoidance code") in v3.5-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [9f678ca2ebec676f20b77dd7425575442d4bafe5]
mainline: [0459430add32ea41f3e2ef9351610e6d33627a6b]
stable/5.10: [ce2c0ee4d76d5ee4b391fe0e31334361e25030ec]
stable/5.15: [3423a45e5c3d3c5129f88143a9a969787d7d5a0a]
stable/6.1: [f1303adb1e59582f76c22798a2e2e150e054a9e7]
stable/6.12: [eeddd7bab3d59c1e98642a204141f8c5d6194707]
stable/6.18: [c6de1a5a9c406e30b91f1515a6ce05cc84023baa]
stable/6.6: [48663158222b3b7f6ee6791a67d512ede7fc94bb]

CVE-2026-64219: drm/amd/display: Validate payload length and
link_index in dc_process_dmub_aux_transfer_async

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64219

According to the .vulnerable file, this bug was introduced by commit
4f8e37d in v5.13-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6c92f6d9600efa3ef0d9e560a2b52776d9803c29]
stable/5.15: [d6590e3f766e3111dd1beaf88b9384d117acfa6b]
stable/6.1: [16a5fa57565afb6bf37e18129921c270c93d8e2b]
stable/6.12: [3265f3ed373fb8048be713aadcdf702579a0e53d]
stable/6.18: [1ecde19bfce6535bffddad1139ff466b6d401b8e]
stable/6.6: [90c398e822ca76e40548df0c061dd4f93ea92d71]

CVE-2026-64220: device property: set fwnode->secondary to NULL in fwnode_in=
it()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64220

Introduced by commit 01bb86b ("driver core: Add fwnode_init()") in v5.11-rc=
1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [215c90ee656114f5e8c32408228d97082f8e0eef]
stable/5.15: [f0e211d6539fae800217c10797993b7592d6ab01]
stable/6.1: [3f1024deeab3b5443c29b3de4fe475e87309b8fa]
stable/6.12: [34bf74b1fd2e4a44e27821a329204caf09df2976]
stable/6.18: [508fd8ab158abd04b7f7d0f707cd6d6c405df4ea]
stable/6.6: [371f53925a6714d0aa35f1aefdffc3e8cd62f480]

CVE-2026-64221: spi: ti-qspi: fix use-after-free after DMA setup failure

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64221

Introduced by commit c687c46 ("spi: spi-ti-qspi: Use bounce buffer if
read buffer is not DMA'ble") in v4.12-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [eae81909e5b3f0b1780c130718f0f71f414a188b]
mainline: [ea6ec3343e05f7937a53eb6d7617b3abdb4abc19]
stable/5.10: [9c6f306a8140962c7284197db54b96fdb5f468d6]
stable/5.15: [3bbbe7ae3fdada0df4157c1ffe989f92dfa8dcd6]
stable/6.1: [d6f422b122922d1abee907d673bcc990e5f3672d]
stable/6.12: [1cd927002120678bd5d23c760246639caa53040e]
stable/6.18: [d7a076fb596c7b408ed6df74793a597990a6d860]
stable/6.6: [f2dc841d7dc9063fe9b47ced869b1271e55052ae]

CVE-2026-64222: octeontx2-pf: avoid double free of pool->stack on AQ
init failure

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64222

Introduced by commit caa2da3 ("octeontx2-pf: Initialize and config
queues") in v5.6-rc1.
Introduced by commit d322fbd ("octeontx2-pf: Initialize cn20k specific
aura and pool contexts") in v6.19-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b244c242bec48b37e82b89787afd6a4c43457e1]
stable/5.10: [e6e9bc0bf963662b7042048ab0281014625d4cb4]
stable/5.15: [b92e7ea408b6f1144648909c9c49a55d245d7300]
stable/6.1: [94192b0579333c3deee2441379aab8ca98fc2e6b]
stable/6.12: [0488a0bb344fb1992853b60082acff6be8164d74]
stable/6.18: [0d9b9d7dbef976ae7f855b6358f1d703014e96ea]
stable/6.6: [4c29603498b05c049dbbbc47e882f2fbf0193cd7]

CVE-2026-64223: wifi: mac80211: consume only present negotiated TTLM maps

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64223

Introduced by commit 8f500fb ("wifi: mac80211: process and save
negotiated TID to Link mapping request") in v6.9-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a6e6ccd5bd07155c2add6c74ce1a5e68ad3b95ea]
stable/6.12: [f7d395dc5008168ac5b9c1ac2791e59a6078cca1]
stable/6.18: [2dd9304727c7041df0a599595910bdbe02ad03c5]

CVE-2026-64224: octeontx2-pf: fix double free in rvu_rep_rsrc_init()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64224

Introduced by commit 3937b73 ("octeontx2-pf: Create representor
netdev") in v6.13-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e8fb3de2a8effcaf62bec2c56b93d8bb480371d1]
stable/6.18: [8864b664d0443ecb8e56690e5546fcda5fe5e81b]

CVE-2026-64225: octeontx2-af: CGX: add bounds check to cgx_speed_mbps index

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64225

Introduced by commit 61071a8 ("octeontx2-af: Forward CGX link
notifications to PFs") in v4.20-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0bf0a4f3f1f5f57aa83e1400ba4f56f0abfd542]
stable/5.10: [94071141f00bc414e8f8f7f5db3b5143d535299f]
stable/5.15: [985b5e38ac4f4d5ff03c8bfd8484353b440a1579]
stable/6.1: [93d3dc81098cd60fb74d434ba7985ddfd9de5acb]
stable/6.12: [8201bf45cc7c1c1a09290c4db8ab1e19801f8fec]
stable/6.18: [47a4cf2229be379cf88f92e32e1240337cd6273f]
stable/6.6: [e043017ac429caee73bd30c5a725659f1a3a4568]

CVE-2026-64226: sched_ext: Avoid UAF in scx_root_enable_workfn() init
failure path

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64226

Introduced by commit f0e1a06 ("sched_ext: Implement BPF extensible
scheduler class") in v6.12-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9a415cc53711f2238e0f0ca8a6bcc796c003b127]
stable/6.12: [cf396941901858b0de426cdcd3974eea6a02c98c]
stable/6.18: [45c7c4e3db8b700307313c035ea08be829a7f21b]

CVE-2026-64227: ACPI: driver: Check ACPI_COMPANION() against NULL during pr=
obe

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64227

According to the .vulnerable file, this bug was introduced by commit
5829046 in v6.7-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e4865a56d013e86e46ea6acea15bb6eae01898ff]
stable/6.12: [a9451bf561232314755baf69a5916e0ac77f33fc]
stable/6.18: [34f4d0e4e5065237d15651df759a99e81b7f9f51]
stable/6.6: [f1e12d81f9cd250e722da01c7670b518d4181406]

CVE-2026-64228: net: ethtool: phy: avoid NULL deref when PHY driver is unbo=
und

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64228

Introduced by commit 9dd2ad5 ("net: ethtool: phy: Convert the PHY_GET
command to generic phy dump") in v6.16-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3adf69f8eb121a9128c2b0029efd050d3649153]
stable/6.18: [3586924625559e6f9876d726c80ff0a75f0d5849]

CVE-2026-64229: x86/mm: Disable broadcast TLB flush when PCID is disabled

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64229

Introduced by commit 4afeb0e ("x86/mm: Enable broadcast TLB
invalidation for multi-threaded processes") in v6.15-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [44126343d58c68adaa8343fbf1c07dd20078c35e]
stable/6.18: [fed725cace3ab1c4f7f8182e35029a603d953187]

CVE-2026-64230: regulator: tps65219: fix irq_data.rdev not being assigned

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64230

Introduced by commit 64a6b57 ("regulator: tps65219: Remove debugging
helper function") in v6.14-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9b2d3b703d13df50c630997dfdc25648e96db0d]
stable/6.18: [6827647fd2dcf4e7f355478a42e82f51e0b5344c]

CVE-2026-64231: drm/msm/dsi: don't dump registers past the mapped region

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64231

Introduced by commit bac2c6a ("drm/msm: get rid of msm_iomap_size") in
v5.14-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5b49a46baa853b26dbefa65c6c75dd9ff69f63d4]
stable/6.1: [5e2c196c3430fb94225c4102b1028d0146544761]
stable/6.12: [9f8274749d9010a1a72f97e547b7eb9ebb82345b]
stable/6.18: [a184aec790135938b0fadb415e55accd1f8685a0]
stable/6.6: [567b5e976e2e15280d78c9ef2add1954a0bbb5b1]

CVE-2026-64232: block: recompute nr_integrity_segments in
blk_insert_cloned_request

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64232

Introduced by commit 76c313f ("blk-integrity: improved sg segment
mapping") in v6.12-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c6e6a18a37b905cb584eb0dda3ae482162a81ca]
stable/6.12: [53a01bcc0242590eda4c452a5bd996f62457113b]
stable/6.18: [0943f81e1b3176f27dbaf6db268fc69d8a94f0ba]

CVE-2026-64233: usb: gadget: uvc: hold opts->lock across XU walks in
uvc_function_bind

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64233

Introduced by commit 0525210 ("usb: gadget: uvc: Allow definition of
XUs in configfs") in v6.3-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [68aa70648b625fa684bc0b71bbfd905f4943ca20]
stable/6.12: [2c9e0905ef7e69f7b814cd709613f6b3b5b98805]
stable/6.18: [caec0145e5974e85fe5192fc6a6f5aa1a98f82a6]
stable/6.6: [e15c414092b3c24610cc771e481a723b0f645eca]

CVE-2026-64234: tty: serial: pch_uart: add check for dma_alloc_coherent()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64234

Introduced by commit 3c6a483 ("Serial: EG20T: add PCH_UART driver") in
v2.6.38-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6fe472c1bbbe238e91141f7cabc1226e96a60d43]
stable/5.10: [760df81763b391bb5f0dcb0b7597b736da753ae4]
stable/5.15: [5f2e2a240dc1846e049bc67e9c3cdf5b031d08bf]
stable/6.1: [daea997bb244aeb50cbb2e5e075fb446a6cf068f]
stable/6.12: [d846df2dfbc2469a688833b4cc4f8aa80672bde8]
stable/6.18: [66f8bfea055b23719b4fd6ce207c44de37d82a59]
stable/6.6: [6dd5c0ea139b586ad5a091677056dafd405cfe82]

CVE-2026-64235: x86/ftrace: Relocate %rip-relative percpu refs in
dynamic trampolines

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64235

Introduced by commit 59bec00 ("x86/percpu: Introduce %rip-relative
addressing to PER_CPU_VAR()") in v6.9-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a17dc12bfed8868e6a86f3b45c16065a70641acb]
stable/6.12: [8093442a2d1d4b42b9340a86023ccb2afb30b93a]
stable/6.18: [d59cc66b702757e3c5a711e78a38583eac0c2738]

CVE-2026-64236: i2c: davinci: fix division by zero on missing clock-frequen=
cy

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64236

Introduced by commit b04ce63 ("i2c: davinci: kill platform data") in v6.14-=
rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [030675aa54cf757769b3db65642433d626b3ed7c]
stable/6.18: [3f43865cb64dd7cb50efae1281a95585617b12a1]

CVE-2026-64237: Input: elan_i2c - validate firmware size before use

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64237

According to the .vulnerable file, this bug was introduced by commit
bb03bf3 in v4.0-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [76b0d0baa9ae9c60e726bbe1b6ff0bec2c993634]
stable/5.10: [47b52b98edfe34d0249e72f815215ef24311c3a3]
stable/5.15: [c2c3b33b3c0bf2c9427c0926817ef5ffac50de6f]
stable/6.1: [331d49b4e1c9efe4479bbd22922dfcdd8c64be7b]
stable/6.12: [3b37190ad3ded3a15fb1dbfc4f26df520a3e59bb]
stable/6.18: [bf769358419e00344c1b16fa034d058f563d46a1]
stable/6.6: [48b0aa9c08a3ac8e0c0345b7ca581f552324e460]

CVE-2026-64238: gpio: shared: fix deadlock on shared proxy's parent removal

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64238

Introduced by commit 710abda ("gpio: shared: call
gpio_chip::of_xlate() if set") in v7.0-rc7.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a1b836607304f71051f9f9dcccf8b5097b86a1fb]

CVE-2026-64239: mm/damon/sysfs-schemes: delete tried region in regions_rmdi=
rs()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64239

Introduced by commit 9277d03 ("mm/damon/sysfs-schemes: implement
scheme region directory") in v6.2-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [441f92f7d386b85bad16de49db95a307cba048a2]
stable/6.12: [a5fa42214de55e43d165144727ce9facb9fc6b08]
stable/6.18: [0ba6c05156d9ff9fc6ca22b7690e2eec9eca66f7]
stable/6.6: [c0e37017a452addec873865c94cf7a665663a9b2]

CVE-2026-64240: media: rc: igorplugusb: fix control request setup packet

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64240

Introduced by commit eac6947 ("media: rc: igorplugusb: heed coherency
rules") in v7.1-rc1.
Fixed in v7.1-rc6.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.12 stable/5.10 stable/5.15
stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [171022c7d594c133a45f92357a2a91475edabe20]
stable/5.10: [e823e4294511989f5962e7ad85bf4d179ba74f52]
stable/5.15: [2243ad78ce64d344754260533ae7730c2174a34a]
stable/6.1: [aa22590a16e51455c6db802c774b31aadc604a9a]
stable/6.12: [0d880d2db9856e94127ab09331363bef59f98005]
stable/6.18: [f33b5a61673bd220fdaaf4202cf1013d6d66c943]
stable/6.6: [060fca8e098387f949e4eedaf215d952e477ac12]

CVE-2026-64241: gpio: rockchip: teardown bugs and resource leaks

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64241

Introduced by commit 936ee26 ("gpio/rockchip: add driver for rockchip
gpio") in v5.15-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9500077678230e36d22bf16d2b9539c13e59a801]
stable/6.12: [cdc603ce3118232712ba443dd8b414d8f25ca467]
stable/6.18: [7f945f7f10f442270518dfd768d230227c495fcf]

CVE-2026-64242: usb: gadget: net2280: Fix double free in probe error path

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64242

Introduced by commit f770fbe ("USB: UDC: net2280: Fix memory leaks")
in v5.10-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c8547c74988e0b5f4cbb1b895e2a57aae084f070]
stable/5.10: [71b3391dc81655ff058492f8e9d013b2c6e5747b]
stable/5.15: [550fa4d071a8c8e53072900869d37ae6abf4999d]
stable/6.1: [c5b9fdb1e8ddf50bc6272927edb118679f170350]
stable/6.12: [48f89ead20e48d447ad29fa937b43b9fa981cf28]
stable/6.18: [e6f8be12f0307145b9a6010f044925952b37de8b]
stable/6.6: [085652fda7f38040d1a2c42d72614f418feb843f]

CVE-2026-64243: ASoC: codecs: simple-mux: Fix enum control bounds check

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64243

Introduced by commit 342fbb7 ("ASoC: add simple-mux") in v5.11-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f63ad68e18d774a5d15cd7e405ead63f6b322679]
stable/5.15: [6fb653b62f169f6050fac45b56bf21ad097e19f6]
stable/6.1: [d8cc3e747b002a8b965c529de79c0654675b9a1a]
stable/6.12: [2ff3ac6f7664fe5639cad01712ac5e021fa7939c]
stable/6.18: [164dcbec9632ca93ae313e6da6e4e05584fa0f02]
stable/6.6: [5fe860af8630cf7c78523cbd68e5a234743585aa]

CVE-2026-64244: drivers/base/memory: set mem->altmap after successful
device registration

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64244

Introduced by commit 1a8c64e ("mm/memory_hotplug: embed vmem_altmap
details in memory block") in v6.6-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a2b8d7827f48ee54a686cb80e4a1d0ff954ec42a]
stable/6.12: [22dc0d042f02ce82aa61422ea5f232628bfd9e9c]
stable/6.18: [6c25bf4e44a2b6a14332f952bba0974521f5b72d]
stable/6.6: [802e113cf120df7208e4c7e604950a85e87120a8]
stable/7.1: [059ac6252a63edf1cea79bf30bd860a8c264b62c]

CVE-2026-64245: fbdev: modedb: fix a possible UAF in fb_find_mode()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64245

According to the .vulnerable file, this bug was introduced by commit
089d924 in v6.4-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [85b6256469cebdac395e7447147e06b2e151014f]
stable/6.12: [f906347d75c7fc377041c6d3c535d0f08846aada]
stable/6.18: [4d418cf8daf57e454b4d855bf9b2419fd8e6a540]
stable/6.6: [c7dc382439f7b019e207055b52e9cec051d42fa9]
stable/7.1: [13b6f0cdd5cd5e60f682ec43134ab0e2024bd356]

CVE-2026-64246: power: reset: linkstation-poweroff: fix use-after-free
in the linkstation_poweroff_init()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64246

Introduced by commit e2f471e ("power: reset: linkstation-poweroff:
prepare for new devices") in v5.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8eec545cde69e46e9a1d2b7d915ce4f5df85b3bd]
stable/5.15: [93c7ee139721936b6fa717572e74d3994603ae13]
stable/6.1: [cdda7d384c05485a232ae9a849f6445accb095bf]
stable/6.12: [3928ae803dee044b01076c478c279c0bd54164cd]
stable/6.18: [2205275be9be981e70ff29610b0117d8853fac70]
stable/6.6: [c04d606f8b35ee7d3ed243f63893a607e9d6c0bc]
stable/7.1: [d109e72f3fbccb540473285d17d7519584f7f76e]

CVE-2026-64247: KVM: x86: hyper-v: Bound the bank index when querying
sparse banks

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64247

Introduced by commit c58a318 ("KVM: x86: hyper-v: L2 TLB flush") in v6.2-rc=
1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4721f8160f17554b003e8928bb61e6c9b2fe92a3]
stable/6.12: [83c2f52c6a78b1590034e955cff3fe0b052fe4ae]
stable/6.18: [e36095d8d922bb26ce860231aacf0cd14edea07c]
stable/6.6: [d18756b12aab30d07794446445c93112e5c69a2e]
stable/7.1: [f636cf6a1e7b7f40d48d8d08bd5f152aa61dd130]

CVE-2026-64248: MIPS: smp: report dying CPU to RCU in stop_this_cpu()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64248

Introduced by commit 91840be ("irq_work: Fix use-after-free in
irq_work_single() on PREEMPT_RT") in v7.1-rc4.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [9f3f3bdc6d9dac1a5a8262ee7ad0f2ff1527a7e7]
stable/6.1: [f8a1ef884013dc99f712d3eb75624c7cd3fd94f6]
stable/6.12: [6eda71977ee11c222f8ad4cae4d18d50448e56f4]
stable/6.18: [f9b57a0015c241274651f4b36627f56b1b5a8651]
stable/6.6: [e1919d026706544cb6e7251ec06e908edd6f34ee]
stable/7.1: [9fef09df42df55ab819b285ea892e0fc1b95a9c4]

CVE-2026-64249: fpga: region: fix use-after-free in
child_regions_with_firmware()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64249

Introduced by commit 0fa20cd ("fpga: fpga-region: device tree control
for FPGA") in v4.10-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [54f3c5643ec523a04b6ec0e7c19eb10f5ebebdd3]
stable/5.10: [e918942bcc5355ad5b44ba557935dffc0727b0eb]
stable/5.15: [866184fc7ae42a0070f1141ae8c5dca7c24a59e2]
stable/6.1: [070b0ce947b18fa3dec0729695147f7e19599649]
stable/6.12: [e79afcb0a66d2b3c33e510eade902537e656fc00]
stable/6.18: [369496d885b4cf6e8647cf4dc5cf3ac68fdf37a1]
stable/6.6: [fbaf509ad7cb2f7dafe73ca20c956104cfcc9d68]
stable/7.1: [5e098e40e8bac43ed58645c10d5fad781966efe4]

CVE-2026-64250: LoongArch: Report dying CPU to RCU in stop_this_cpu()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64250

Introduced by commit 91840be ("irq_work: Fix use-after-free in
irq_work_single() on PREEMPT_RT") in v7.1-rc4.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [f2539c56c74691e7a88af6372ba2b48c06ed2fe4]
stable/6.1: [262dadc619e69ebeb97affd334cd1078a9704e98]
stable/6.12: [a0269e928728f970c782319fee53d92d4ea4e512]
stable/6.18: [90e254f18b8c224460082329dd5c42fd30995c2f]
stable/6.6: [1fa22de588a65880d6fe54c38c87fffe7d519f60]
stable/7.1: [0833b2b84c2fc1387f8165f0cbf6a02d67f647a5]

CVE-2026-64251: pwrseq: core: fix use-after-free in pwrseq_debugfs_seq_next=
()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64251

Introduced by commit 249ebf3 ("power: sequencing: implement the pwrseq
core") in v6.11-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [257595adf9dac15ae1edd9d07753fbc576a7583d]
stable/6.12: [ba0b9f04c7a5f9887b8ce672eaf049502c0548ec]
stable/6.18: [e91df6d273445c03f5aa302bfe147eda33d45794]
stable/7.1: [73569a44fca2992f0ca4a4c0104069741b9873a0]

CVE-2026-64252: MIPS: DEC: Prevent initial console buffer from landing in X=
KPHYS

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64252

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7fb13fd35110ebe95eb053faf79d018f51144d85]
stable/5.10: [9e22b6fc6532cd566dad6d89d8fb3885248e364a]
stable/5.15: [1c80327dedf05b8c8ca025b76c21235b19dd3a86]
stable/6.1: [8a15826e5d3bdcfbef2f8e9330c69ea9ee7282e7]
stable/6.12: [35212f2adc2cf15122b96b987519de235b855e46]
stable/6.18: [6e61fc2e06e44b6d30248cc5bc47a58e75c2b43e]
stable/6.6: [ab465495b1ed5efb7d2f9b90d8b20b1e0473e26f]
stable/7.1: [07c245bc39f94481fd75ff1ed54f7ab97111f3dd]

CVE-2026-64253: kernel/fork: clear PF_BLOCK_TS in copy_process()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64253

Introduced by commit 06b23f9 ("block: update cached timestamp post
schedule/preemption") in v6.9-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd38b75c4b43295b10d69772a46d1c74dbd6fc81]
stable/6.12: [ee0801aceabdf583392477baf69a290b09448b8f]
stable/6.18: [99e6c712cc300883b8cbf03347d5359ec1a4d6dd]
stable/7.1: [77bba61a20f1b3d206f4f90e10a7bb3cd90b9619]

CVE-2026-64254: NTB: epf: Avoid pci_iounmap() with offset when
PEER_SPAD and CONFIG share BAR

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64254

Introduced by commit e75d5ae ("NTB: epf: Allow more flexibility in the
memory BAR map method") in v6.0-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d876153680e3d721d385e554def919bce3d18c74]
stable/6.1: [eb47b9bffd07a47b84910847cb5ea066ce184055]
stable/6.12: [a4be4a1308f02bff79a30eea2d04ead5b63685f2]
stable/6.18: [81371dbd23601f67f01372817fdbab42c5601e43]
stable/6.6: [06f6dd2ff2bd07eaf7178a807407ff27e85122b4]
stable/7.1: [9764a786ba98db58f0725913c369e721253aba33]

CVE-2026-64255: wifi: iwlwifi: mld: validate sta_mask before ffs() in
BA session handlers

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64255

According to the .vulnerable file, this bug was introduced by commit
9aa3856 in v6.4-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f056fc2b927448d37eca6b6cacc3d1b0f67b20d2]
stable/6.18: [1de92789ce31e46fa7e7d8e89c90b19cdb1c103b]
stable/7.1: [fe7f339f63c9dc4ca546ed7ac38ba4bb3a99dcfc]

CVE-2026-64256: xfs: don't wrap around quota ids in dqiterate

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64256

Introduced by commit 21d7500 ("xfs: improve dquot iteration for
scrub") in v6.8-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d766e4e5e85d829629c3ba503802fe1303d7b591]
stable/6.12: [249e311c2ba392ceaf9ebfc145a46922946f069a]
stable/6.18: [d1c4c40599c376aeb0c93068a2ae344e79ee4b90]
stable/7.1: [2b14fe1e0924c6b901f4256456342569c5397abe]

CVE-2026-64257: smb: client: reject overlapping data areas in SMB2 response=
s

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64257

Introduced by commit 53b7c27 ("smb: client: restrict implied bcc[0]
exemption to responses without data area") in v7.2-rc3.
Fixed in v7.2-rc4.

Bug introduced commit was backported to following branches.
cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12 stable/6.18
stable/6.6 stable/7.1

Fixed status
mainline: [8986c932905ea508d66da421eb2eb6e676ace1fe]
stable/6.1: [445ece263131780dee273d727a4d6f11934feec7]
stable/6.12: [4a9d2657d3e05f6ed09c148cb127b4e58702275f]
stable/6.18: [fdafa1e68dc75045b7b617e6e7d2854950804d83]
stable/6.6: [36bfa52459e45c0d5b668de2f1c91f6dc5c67775]
stable/7.1: [57cba95f0e97c6f6e45e6731da30aff091bd7460]

CVE-2026-64258: fuse-uring: remove request-less entries from
ent_w_req_queue to fix NULL deref

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64258

Introduced by commit 4fea593 ("fuse: optimize over-io-uring request
expiration check") in v6.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c57a69be962d459c5e705f5cb4355b841b3461c]
stable/6.18: [0b466cf1b96e191b06b496c4de79da15315c3a9a]
stable/7.1: [0a7f33010c0e4cd92937e088a54350381fd0fbf2]

CVE-2026-64259: fuse-uring: make a fuse_req on SQE commit only
findable after memcpy

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64259

Introduced by commit c090c8a ("fuse: Add io-uring sqe commit and fetch
support") in v6.14-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1efd3d474fc0ba74dfd984249bca78807d739812]
stable/6.18: [e1711479e9068ea31b31353a702a51e639c3d059]
stable/7.1: [a635f427d57e2012102ae4886b48d8955c59fb86]

CVE-2026-64260: fuse-uring: Avoid queue->stopped races and set/read
that value under lock

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64260

Introduced by commit 4a9bfb9 ("fuse: {io-uring} Handle teardown of
ring entries") in v6.14-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b70a3aca16934c196f92abb17b01c1647b9bb63c]
stable/6.18: [39c8e925b207afceffaa5382416ed405e0223a03]
stable/7.1: [4021a3a79eee551d95fe1e1e7c1b195d34ba8c08]

CVE-2026-64261: fuse-uring: Avoid use-after-free in fuse_uring_async_stop_q=
ueues

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64261

Introduced by commit 4a9bfb9 ("fuse: {io-uring} Handle teardown of
ring entries") in v6.14-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d351da75066955144515cb2f9aa959f24a04287a]
stable/6.18: [23a356e0bd96c8d5fb3ddff069f692bf10cab5c1]
stable/7.1: [95d7f50aff2a5f71557263ff25b97b2951f32bf8]

CVE-2026-64262: fuse-uring: end fuse_req on io-uring cancel task work

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64262

Introduced by commit c2c9af9 ("fuse: Allow to queue fg requests
through io-uring") in v6.14-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bea4fe98204b6ce7eb8e29f7bf867dd7619b3ddd]
stable/6.18: [bb476ef8e1027a9d509fbaaf81f5061a07e9e5a7]
stable/7.1: [4f45f276d5b4412eade6f74f2e37f3adba0473ed]

CVE-2026-64263: fuse-uring: fix moving cancelled entry to ent_in_userspace =
list

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64263

Introduced by commit 4fea593 ("fuse: optimize over-io-uring request
expiration check") in v6.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [198f45eeb9f78b2a2d6d8be95e4e43468eb2c6bc]
stable/6.18: [50f3e03db823cabc41fe35c27d77c2bdb112baad]
stable/7.1: [e8afc85acdf329361b2d8df2ad9b52364686235f]

CVE-2026-64264: fuse-uring: fix EFAULT clobber in fuse_uring_commit

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64264

Introduced by commit c090c8a ("fuse: Add io-uring sqe commit and fetch
support") in v6.14-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a0a8bc51a13951c5141262bf770eeea3e0b6228]
stable/6.18: [0483fffdeeb363f320e6bf5fc0f0306007507306]
stable/7.1: [fe604c08d874648a69187f6380e5c7858627dc04]

CVE-2026-64265: fuse: clear intr_entry in fuse_resend and
fuse_remove_pending_req

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64265

Introduced by commit 760eac7 ("fuse: Introduce a new notification type
for resend pending requests") in v6.9-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8fce75fedf73ac72aa09163deb8f4291fdcaad2]
stable/6.12: [1d8ecd0cd696a5df0b2f72046a4ccee5d2a8ec2c]
stable/6.18: [7366e6f4d2b4c7002b13fb01219e83679dad4127]
stable/7.1: [893479015cb6442fd389d3b553ab3036c9541715]

CVE-2026-64266: fuse: re-lock request before returning from fuse_ref_folio(=
)

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64266

Introduced by commit c302162 ("fuse: support splice() reading from
fuse device") in v2.6.35-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b5befa80fdbe287a98480effed9564712924add5]
stable/5.10: [1f9156714592356b4fda57beac7eab9c2a462dd3]
stable/5.15: [5630da218a45ba80f0aba0846cbe8aa655da122b]
stable/6.1: [1ca605cfa59377f0143fb35b5b01360f37d1b7c4]
stable/6.12: [e6aa539720c3d8def69683ed0c07cf9faea4e8be]
stable/6.18: [be353caffa8640f5e25fb3714ce8b0cef5e410e5]
stable/6.6: [0e4a5a000123d81234e27a2f8187688cf608f755]
stable/7.1: [65a1c2551f7e16085acbb54aedde1feaa559ba7a]

CVE-2026-64267: fuse: avoid 32-bit prune notification count wrap

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64267

Introduced by commit 3f29d59 ("fuse: add prune notification") in v6.18-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [54243797cedf55447b4c5d560e8cd709900061ae]
stable/6.18: [6e2d84fdeac05bfd858e84a76353fdb84f23a43e]
stable/7.1: [c78c4b242299bc581e4987e5c2786c6f4760c516]

CVE-2026-64268: RDMA/siw: bound Read Response placement to the RREAD length

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64268

Introduced by commit 8b6a361 ("rdma/siw: receive path") in v5.3-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d29f7e9dbd844cae4d3e559cf78324b9642fd6b]
stable/5.10: [a31b6d18ded3cc32d9ee85a6ff0726d4274887b2]
stable/5.15: [595e6537ad1a210da32cbb9a7f91aa73090915ba]
stable/6.1: [3ef7e052cbd05a8b13a51a07b185a39ec93ee1cf]
stable/6.12: [6bc89f34a4597f9f6d41f7a60c67a3153bfe8851]
stable/6.18: [423a78ff7928c2601013f73ec6d896f5597d0df5]
stable/6.6: [b2e26c955f8dd7e8d3f16c858db05245ea4fa817]
stable/7.1: [75c93cd3c421890f49ea93f0b978b9b7bb10e5e3]

CVE-2026-64269: RDMA/rtrs-srv: Bound RDMA-Write length to chunk size
in rdma_write_sg

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64269

Introduced by commit 9cb8374 ("RDMA/rtrs: server: main functionality")
in v5.8-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [963af8d97a8c6a117134a8d0db1415e0489200b1]
stable/5.15: [68c09762172f6224e9ddf9b0a60bacbb36e443eb]
stable/6.1: [6cada540150894e81042a0ae0c796a21a9a877da]
stable/6.12: [6f40246f4312fdbab5a13cc440adebf95eb2aa66]
stable/6.18: [5a45d0aa1fa50a333ce5763ade744e2d89838667]
stable/6.6: [2912f3d40355dabc08fdbaaf2764d02445fe88dc]
stable/7.1: [da3e44add94b05dfde56f898421922f5cf35705f]

CVE-2026-64270: Input: mms114 - reject an oversized device packet size

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64270

Introduced by commit 07b8481 ("Input: add MELFAS mms114 touchscreen
driver") in v3.6-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66725039f7090afe14c31bd259e2059a68f04023]
stable/6.12: [b78150729762d47c14fe29a2582bdca5568e62b8]
stable/6.18: [8301c335305344d4da4ab9442b6a399dacfe5b8d]
stable/6.6: [5d2ea15ba03bf17ed143ff1a0995a4206edc3fb6]
stable/7.1: [f3d5e77b27fded71dcb97f409262bf0abba0410e]

CVE-2026-64271: Input: touchwin - reset the packet index on every
complete packet

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64271

Introduced by commit 11ea317 ("Input: add driver for Touchwin serial
touchscreens") in v2.6.20.16.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [478cdd736f2ce3114f90e775d7358136d3977b94]
stable/5.10: [ed9b66905407eb3d02df1aaeed82eb7a7f0eb508]
stable/5.15: [044167cba2384bcd783547ad5e30ecd292b30919]
stable/6.1: [6c9f29f128dd4057404838259af4c645318487e1]
stable/6.12: [70e4248793762df9832fd4fc2fc6ac7924572c36]
stable/6.18: [3e6f007b43e2fc6546e21fa74ee62c38984a6672]
stable/6.6: [431ad239f2924dff337c3fccb9246597c1b63185]
stable/7.1: [a8d87184576c889759e3aab899799a482f1e1a5b]

CVE-2026-64272: Input: mms114 - fix touch indexing for MMS134S and MMS136

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64272

Introduced by commit 53fefdd ("Input: mms114 - support MMS136") in v5.13-rc=
1.
Introduced by commit ab10867 ("Input: mms114 - support MMS134S") in v5.15-r=
c1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a6ac4e24c1a8a533bb61035184fdcc7eede4cc8d]
stable/6.12: [7c00a0787af7164438bdbc97fcae9733cfc58d21]
stable/6.18: [75b12874b4172533b9efc349db328cb1a59c3981]
stable/6.6: [112666835071d935fef764aab590339e97216d4a]
stable/7.1: [a747c4eb02656afdbd92eea83b88e92715a23977]

CVE-2026-64273: Input: iforce - bound the device-reported
force-feedback effect index

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64273

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0e9943d2e4c63496b6ca84bc66fd3c71d40558e2]
stable/5.10: [b1b79e89bc33e4c682d3df7ae2aadc62b5a0c310]
stable/5.15: [d10b0507fa0f5b46764b178e3271f9012f2df677]
stable/6.1: [6c0f2901c9d325d4a0574c4237fd507810d225ff]
stable/6.12: [e5fa31f0550b55d80045669ae9080dd5b88abffa]
stable/6.18: [70019779325f2bb5f5a4098e91e79c655f50fcef]
stable/6.6: [c21295616a8a52b9a5f18cd4ca8c73030eda3d4f]
stable/7.1: [a40250f97c312e000e3616c9074022311a0efbc3]

CVE-2026-64274: Input: goodix - clamp the device-reported contact count

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64274

Introduced by commit a7ac7c9 ("Input: goodix - use max touch number
from device config") in v4.1-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ed62a96e06be4e94b8296b7932afee550a70e04]
stable/5.10: [e825f352ef5271255cd08cc994b0dc25648a2f38]
stable/5.15: [4bfea9c3a0981c1c7fc5d1a1b27197b2de247902]
stable/6.1: [98b2caef249183b572c04451365246f919707845]
stable/6.12: [46addbd13dbf4aacb71cfbca964a5e552d0f45ae]
stable/6.18: [3b32303460155603d25444274856013d211d5e1f]
stable/6.6: [719d1a2c83a46be6bf81af905e4f6adb3d32dc28]
stable/7.1: [2a67668690129953e898923260a2dd1c7c196495]

CVE-2026-64275: Input: elan_i2c - prevent division by zero and
arithmetic underflow

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64275

Introduced by commit 6696777 ("Input: add driver for Elan I2C/SMbus
touchpad") in v3.19-rc1.
Introduced by commit e3a9a12 ("Input: elan_i2c - do not query the info
if they are provided") in v5.3-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [df2b818fa009c10ff6ba875a1663ff001cda9558]
stable/5.10: [59d4cc5e7a9785e4bdc9c55273274c6b49d4b58d]
stable/5.15: [f6d10af2036d1d4a847a74fe47ebbf93bce3c84c]
stable/6.1: [2f281ff0163a38fdc4cb4061f0c241e643283a5e]
stable/6.12: [feb4866a42ec94764c7eb58012256f6f37664727]
stable/6.18: [01e0317c256c560d8dcce2e9825eb6142ee34611]
stable/6.6: [8c1db3418a419e788691746b9c47f863c2fd4890]
stable/7.1: [6bac57d8fe2a077b8a85b4140eeb7999078158eb]

CVE-2026-64276: Input: synaptics-rmi4 - bound the F30 keymap to the
GPIO/LED count

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64276

Introduced by commit 3e64fcb ("Input: synaptics-rmi4 - limit the range
of what GPIOs are buttons") in v4.14-rc7.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d577e46785d45484b2ab7e7309c49b18764bf56c]
stable/5.10: [8c6d18d61bb6fe0e6edf848413391c590552e8a9]
stable/5.15: [d162a1ead7de404d8b41a093c83ed0db6487cded]
stable/6.1: [f0be9eba946e9200b43265e0a748d38bd0a56954]
stable/6.12: [4e3689c26854356f41fbaa1eafa382e58ac79e00]
stable/6.18: [e849c6f51e6877104c765da084e001ec37c8e119]
stable/6.6: [26c895928d7118436a24f564587cb4aefc40cdd8]
stable/7.1: [bfe622efecd4ff0a792d0ecd1a8dce535a902f50]

CVE-2026-64277: Input: synaptics-rmi4 - bound the F3A keymap to the GPIO co=
unt

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64277

Introduced by commit 9e4c596 ("Input: synaptics-rmi4 - add support for
F3A") in v5.10-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [57c10915f2c16c90e0d46ad00876bf39ece40fc2]
stable/5.10: [502ad7caaa1a445b734c827fa256e5311df67e3d]
stable/5.15: [3480e24bc4e178aaa009edb25b6ee12df199e210]
stable/6.1: [35ed74d32d8260bdfb14a94caf402bf0866bdeec]
stable/6.12: [850117b637bcb1dcc14be0cf09ac819a8707b42c]
stable/6.18: [8db211aed83733073b0814adaeeab61d4521474e]
stable/6.6: [ba57f430328534501962d60d651e385ffd7af9ca]
stable/7.1: [64fb0e1161ccc6b9e48b8df61f07d3c34c01ec42]

CVE-2026-64278: i2c: imx-lpi2c: mark I2C adapter when hardware is powered d=
own

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64278

Introduced by commit 1ee867e ("i2c: imx-lpi2c: add target mode
support") in v6.14-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [218cfe364b55b2768221629bd4a69ad190b7fbbc]
stable/6.18: [b2523f26979e0b5bd1422772176b2233fcd1f6d0]
stable/7.1: [5800647d19d3f1f747fda4dc67e55d6afa6ee119]

CVE-2026-64279: i2c: core: fix adapter deregistration race

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64279

Introduced by commit 35fc37f ("i2c: Limit core locking to the
necessary sections") in v2.6.31-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b1a58ed9eab146b36f41a55db8f5d7ce9fdedf3f]
stable/5.15: [d39282f552dd6c35b9b84b4af78f1198c24f3373]
stable/6.1: [11dfa37bf544cc806f21742ca2fd2d841bd7032e]
stable/6.12: [bb234487a447a99315add1b46aa57b72e163e1eb]
stable/6.18: [b6d2af6fe9c1f5ec0484536753c979cbd40a8ac3]
stable/6.6: [9882a9bd74db08e7bae5821a7050627ae92d3380]
stable/7.1: [35dbd1f1f603401155cbd3a180bb18e3a3b675b8]

CVE-2026-64280: fpga: dfl-afu: validate DMA mapping length in
afu_dma_map_region()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64280

Introduced by commit fa8dda1 ("fpga: dfl: afu: add
DFL_FPGA_PORT_DMA_MAP/UNMAP ioctls support") in v4.19-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fc3b071a7c8dc0f5d56defddf6e6fd5aaa3e1e27]
stable/6.18: [59070040fd12e0b78d7b4d341d9f9a183237c5ff]
stable/7.1: [fb2c0eab51ae5b02d2bae7d67c2cfbec39b57231]

CVE-2026-64281: svcrdma: wake sq waiters when the transport closes

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64281

Introduced by commit ccc89b9 ("svcrdma: Add fair queuing for Send
Queue access") in v7.1-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e5248a7426030db1e126363f72afdb3b71339a5c]
stable/7.1: [40eedc4253dbda0b29b7961200534dfcecb48ace]

CVE-2026-64282: KVM: arm64: Don't leak PFN when kvm_translate_vncr()
races MMU notifier

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64282

Introduced by commit 069a05e ("KVM: arm64: nv: Handle
VNCR_EL2-triggered faults") in v6.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f76b039a72d7e06374aa96862f0232ed53f7787]
stable/6.18: [0c93681aea0a1b8be14730a88abe77c840272e41]
stable/7.1: [cd1067ccc0dbc18890a74db116d00a4bc3c7f2f7]

CVE-2026-64283: KVM: guest_memfd: Treat memslot binding offset+size as
unsigned values

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64283

Introduced by commit a7800aa ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl()
for guest-specific backing memory") in v6.8-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eba85fee7fc6cf28fec38a5bf3c378bef9a79ca6]
stable/7.1: [f3a98d5881b9bd4807f49156143565f6aabcef1e]

CVE-2026-64284: KVM: x86: Ensure vendor's exit handler runs before
fastpath userspace exits

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64284

Introduced by commit f7f39c5 ("KVM: x86: Exit to userspace if fastpath
triggers one on instruction skip") in v6.12-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ffedf43910e44b76c2c1db4e9fbf12b268190c1]
stable/6.12: [b3436d9b9b1affe1c3191ac9831308923f5f03c3]
stable/6.18: [4ad73ef0e7966ecfe67de0060537b4cb14d9acd4]
stable/7.1: [f2ca2b5326211bd38490f0497eb583721ce0bbc0]

CVE-2026-64285: KVM: SEV: Pin source page for write when adding CPUID
data for SNP guest

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64285

Introduced by commit 2a62345 ("KVM: guest_memfd: GUP source pages
prior to populating guest memory") in v7.0-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f13e900599089b10113ceb36013423f0837c6792]
stable/7.1: [dcdb476f5fc5701ec06c23efe3e3529f07ca391e]

CVE-2026-64286: KVM: arm64: Clear __hyp_running_vcpu when flushing the
pKVM hyp vCPU

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64286

Introduced by commit be66e67 ("KVM: arm64: Use the pKVM hyp vCPU
structure in handle___kvm_vcpu_run()") in v6.2-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e8042f6e1d7befb2fb6b10a75918642bcd0acf9a]
stable/6.12: [dfaef40d8a1533940fc1af788d70fce07362b4ce]
stable/6.18: [6bea2f8becdb20d34378493c3b77a9b9cf8c6cfa]
stable/6.6: [477145860dba4c30f0b4e36f02f4c5291c1c888b]
stable/7.1: [d4f4d61715d1061ba83b88196a3605662be30750]

CVE-2026-64287: KVM: arm64: Bound used_lrs when flushing the pKVM hyp vCPU

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64287

Introduced by commit be66e67 ("KVM: arm64: Use the pKVM hyp vCPU
structure in handle___kvm_vcpu_run()") in v6.2-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8cc8bbbfab14c22c5551d0dd19b208a44b141c76]
stable/6.12: [9fa301d8298778dd799fa4dcf7a7f440715d146e]
stable/6.18: [c646431865f4b1a5b14067233fa27b11e05e0d46]
stable/6.6: [2c5e72b9fbf83fdfa724e9f1af0f418ccf8739b8]
stable/7.1: [7fca3fcef81c713bc82a37bf741e0f28e6d04a6f]

CVE-2026-64288: KVM: arm64: nv: Avoid dereferencing NULL VNCR pseudo-TLB

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64288

Introduced by commit 4ffa72a ("KVM: arm64: nv: Add S1 TLB invalidation
primitive for VNCR_EL2") in v6.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4be6cbeb93d26994bd1827ddbce391e3c4395c8f]
stable/6.18: [7c73a269a880b1399baacfb9d521415e6ef7ecc2]
stable/7.1: [5fd30133af864a1de0a0bd87d3fe3cf23205fbc7]

CVE-2026-64289: iommufd: Set upper bounds on cache invalidation
entry_num and entry_len

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64289

Introduced by commit 8c6eaba ("iommufd: Add IOMMU_HWPT_INVALIDATE") in v6.8=
-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d70986002f2f3eaaed89124fb2522bded38b016]
stable/6.12: [d2bd041e0efaf7d81789779b135279d18b33d6d5]
stable/6.18: [32ca4aed2a66205b072fcfecabe220289a8149ff]
stable/7.1: [2c6381d90898089287e0a358f06f89f6b4b389f2]

CVE-2026-64290: iommufd: Break the loop on failure in iommufd_fault_fops_re=
ad()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64290

Introduced by commit 07838f7 ("iommufd: Add iommufd fault object") in v6.11=
-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [172fc8b19825a0f5884c38f2289188284e2d45ee]
stable/6.18: [5539da127d03c1f6c2e2a49fdfbe331a0ccbdea8]
stable/7.1: [f66c16b175509642ee7082df57c9bf3deaebae1a]

CVE-2026-64291: iommufd: Set veventq_depth upper bound

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64291

Introduced by commit e36ba5a ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and
IOMMUFD_CMD_VEVENTQ_ALLOC") in v6.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6ebf2eb46fbd5b40393ff8fbb847ba96925beaff]
stable/6.18: [f565297edf316016be4a1a9e2eb9f39359313f43]
stable/7.1: [e7b5e55652746b1221b9c10ff80eae8a154101ba]

CVE-2026-64292: iommufd: Move vevent memory allocation outside spinlock

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64292

Introduced by commit e36ba5a ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and
IOMMUFD_CMD_VEVENTQ_ALLOC") in v6.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47443565d10c51366c9382dbc8597cd6c460b8a2]
stable/6.18: [779480ea79551c31964e74b9aef0e730faa3aa11]
stable/7.1: [6c5fc40200cd0a87d66a368eee00df4d1cca946e]

CVE-2026-64293: iommufd: Use sizeof(*hdr) instead of sizeof(hdr) in veventq=
 read

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64293

Introduced by commit e36ba5a ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and
IOMMUFD_CMD_VEVENTQ_ALLOC") in v6.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be93d186ae88a92e7aa77e122d4e661fa57b1e39]
stable/6.18: [04a177f91160ee18da98f5689482cf0f589ec869]
stable/7.1: [0cdbb97a4dbd69abdd2ab998b4fbc7803d4b0b72]

CVE-2026-64294: mm: do file ownership checks with the proper mount idmap

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64294

Introduced by commit 9caccd4 ("fs: introduce MOUNT_ATTR_IDMAP") in v5.12-rc=
1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e187bc02f8fa4226d62814592cf064ee4557c470]
stable/6.12: [8344bdf0629457e532797b42d9d2bbf2a2900bbf]
stable/6.18: [5c942ad7df75925ee166e7f0fb36892d8dde376b]
stable/6.6: [744b23aa430d52f5c8e4dbff7d71496d6643bed2]
stable/7.1: [04ba248d02d9eaa3d9077b00a6134caa75fa3e90]

CVE-2026-64295: mm: page_ext: add count limit to page_ext_iter_next to
prevent invalid PFN access

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64295

Introduced by commit 9039b90 ("mm: page_ext: add an iteration API for
page extensions") in v6.15-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ffd017237cfe99e6e5602ab14179b0e6878a0840]
stable/6.18: [8dcaa0f87a88d720d13106f3a306c6b61d189d86]
stable/7.1: [377b1cd6bbcf327338cd951cc2fd74bc75540235]

CVE-2026-64296: exfat: bound uniname advance in exfat_find_dir_entry()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64296

Introduced by commit ca06197 ("exfat: add directory operations") in v5.7-rc=
1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a1230e7b043c62737b05a3e9275ca83a43ad20a]
stable/5.10: [72a2589d82eb001c94b74bcfe6f9a599bd9bef60]
stable/5.15: [fae76a94b35ee8c0e2eb6f64caca01d75c6d34e4]
stable/6.1: [cf85180b8a015029ee147694eaf4e0b3537e9432]
stable/6.12: [727bf7783a2936ffd55c628dddfd69343e511dcf]
stable/6.18: [33c0b96d7e1672be1de0053786637ea46fb81507]
stable/6.6: [ce4736c1e6c4cfbf1ac409a8c328a0b69546c9a0]
stable/7.1: [c8e041c68c0bbb73aa62371ee63947bb6949d8b2]

CVE-2026-64297: module: decompress: check return value of
module_extend_max_pages()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64297

Introduced by commit b1ae6dc ("module: add in-kernel support for
decompressing") in v5.17-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [786d2d84416a9a1c1a47b71a68d679d886284be2]
stable/6.1: [e7f174715f9f0cbcb9e87b52e4fc4ef149baac98]
stable/6.12: [168072baf9ad516d5a06046514c7fea4c0671990]
stable/6.18: [a82e170637e050a803b4f37542371ef216bf66d2]
stable/6.6: [afcc0515bbdd28d509a2b5870faaa89b137f5d53]
stable/7.1: [e7da02659c229f73492fb1ed87ceda4090153aaa]

CVE-2026-64298: NFSv4: include MAY_WRITE in open permission mask for O_TRUN=
C

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64298

Introduced by commit af22f94 ("NFSv4: Simplify _nfs4_do_access()") in
v2.6.24-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5140f099ecd8a2f2808b7f7b720ee1bad8468974]
stable/5.10: [4817c8974315b666e895b7d1bb83cd3664c323b1]
stable/5.15: [cb148a2762d644bff1894728e8835a9a4b84f9ea]
stable/6.1: [30fdf4df6c3c00efec947e4ddf97f0fdd4473628]
stable/6.12: [6bd7d0a06b53c4e797e1a9cea0d2d41aa1b26230]
stable/6.18: [a937e92c1d00534b5c2e3e9f4381b7e988180797]
stable/6.6: [22c1fd1355ad4ca27aa7f0fa02719122dd92d9de]
stable/7.1: [e36501b7d4abdcd6d69a7cb901b2f286b7a3d041]

CVE-2026-64299: tracing: Prevent out-of-bounds read in glob matching

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64299

Introduced by commit 60f1d5e ("ftrace: Support full glob matching") in
v4.10-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0a6070839b1ef276d5b05bedfb787743e140fb17]
stable/5.10: [265f3a690f6c7d69ef7d2ca50b04b4853a211df3]
stable/5.15: [ee5b8888d3248618251fb69a2fad92afcb81557e]
stable/6.1: [56d4c9ab84714eebb285a2fee68aaedf81e3ef15]
stable/6.12: [ebb55902856973906c8bb339a3a34824ed4a5086]
stable/6.18: [2dad64a97e1df47f5d9ccb17fa319aa348617226]
stable/6.6: [35ae19764eabfe9c29029d3b5713c86e6855acdf]
stable/7.1: [e5d5f3bd053a5f14787526c9f0f55ef900d43ac6]

CVE-2026-64300: perf/aux: Fix page UAF in map_range()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64300

Introduced by commit b709eb8 ("perf: map pages in advance") in v6.14-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5948aaf64f81f217a25dcc2bf6c0779bca19566c]
stable/6.18: [c8b7e113f7b61eef2f017e6329c27c2331058c5a]
stable/7.1: [0cff05bd2186020f8706233e261016d149cc24db]

CVE-2026-64301: regulator: scmi: fix of_node refcount leak in
scmi_regulator_probe()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64301

Introduced by commit 0fbeae7 ("regulator: add SCMI driver") in v5.11-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa11039d6cdff84584a3ef8cc1f5e1b56e045da2]
stable/5.15: [1e446e8f8c763be3de7d0362e024cdf46194ffef]
stable/6.1: [637c11e3d8d43a7ee654591cda8d17c55a9234fa]
stable/6.12: [3e1441a4d06d35a314961e40057bd1f0106bbc14]
stable/6.18: [22cb337370e6539b0418832c6040e9b00c1b74ca]
stable/6.6: [e2baf8ea13fb4b10bec2c4751aea05c00dabcd0f]
stable/7.1: [a935b64548fcfe1d5b4dbdd31dddfb0d7019367f]

CVE-2026-64302: x86/mm: Fix freeing of PMD-sized vmemmap pages

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64302

Introduced by commit bf9e4e3 ("x86/mm: use pagetable_free()") in v6.19-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [39406c05f8f150f1685839acd38ffdd69ff92031]
stable/6.18: [add1e4112e00b619614784bf630aeebfdefa23e1]
stable/7.1: [03f6ecbc446c33b38fd452cd3c494092a8116967]

CVE-2026-64303: spi: fsl-lpspi: terminate the RX channel on TX prepare
failure path

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64303

Introduced by commit 09c0446 ("spi: lpspi: add dma mode support") in v5.2-r=
c1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01980b5da56e573d62798d0ff6c86bcaa2b22cbe]
stable/5.10: [ad370d1c7a9a832f77b2341513cd31188c9443af]
stable/5.15: [cce2063404b2341e7b2bbf85eddfcd70a31a0033]
stable/6.1: [af39a2698f69b584d14a00cffe0f51a2caa15337]
stable/6.12: [d5c1060218a3749c8a18b36f8169d910fce20639]
stable/6.18: [808033d80d5c9f8adf7e8de9317389270ce13430]
stable/6.6: [e65505d91fa036a238968e4c10744244d1b968c4]
stable/7.1: [9d000bdd250d649a11cd7f733175686877344582]

CVE-2026-64304: crypto: qat - validate RSA CRT component lengths

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64304

Introduced by commit 879f77e ("crypto: qat - Add RSA CRT mode") in v4.8-rc1=
.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b3ac78756588059729b9195fcc9f4b37d54057a5]
stable/5.10: [6d99c5fadd2df488103f64d6475b63ba6852202b]
stable/5.15: [c34369473bfe92a0b46ec78d6358e30341c7f481]
stable/6.1: [1002719d13072a5e4be1e993aa61dffb4a604e82]
stable/6.12: [3d61a214fdcda41f1ebfabbb483404032a7b4d91]
stable/6.18: [6fb62b767f3e27661e8f8d2f7b85f4e098fcdb1a]
stable/6.6: [500319830d76911c120dc0b9605f8c16d7702844]
stable/7.1: [ce42224487c504aee4b7ff3a7342e7b4d7e28cc9]

CVE-2026-64305: crypto: qat - protect service table iterations with service=
_lock

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64305

Introduced by commit d8cba25 ("crypto: qat - Intel(R) QAT driver
framework") in v3.17-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5c6f845e77ec35f9b7b047cc8f9789bf397cdd3e]
stable/6.12: [222fa7b453b612f4407f260146d89a2ce2bc831d]
stable/6.18: [c3c5925791cff3b84d313293fd60f384d877d793]
stable/7.1: [0dbcecea740d943002c1cbdafa39bdfc108e32a5]

CVE-2026-64306: crypto: drbg - Fix returning success on failure in CTR_DRBG

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64306

Introduced by commit cde001e ("crypto: rng - RNGs must return 0 in
success case") in v4.1-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [39a31ad9e2a5ed7e9c9c6f711dca96c8c8f5f26b]
stable/5.10: [074db6db03a0aaa78f05ca9d4838053713796665]
stable/5.15: [7b03312491f9fe6ba4d60c4023e7e61d2d1fed96]
stable/6.1: [75597e8774f319152744d24e0683d9393540a951]
stable/6.12: [bbbac12083eff489b35d848332f0dff311131344]
stable/6.18: [23b8b188cb32e5531d0f8d3af9506f8959cb369e]
stable/6.6: [cc42fb40171c249bb859071d81b4eb007398a0bc]
stable/7.1: [a9e886f73dd717027028bb7e3bbca93601ecdfc7]

CVE-2026-64307: crypto: ccp - Do not initialize SNP for ioctl(SNP_CONFIG)

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64307

Introduced by commit ceac7fb ("crypto: ccp - Ensure implicit SEV/SNP
init and shutdown in ioctls") in v6.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [08f0e65e784c4b20e6e620dd4f68d8636073a3d2]
stable/6.12: [345a6e869b33687e9268044bcaeeefd7c61da675]
stable/6.18: [441ea32cf2755a0dc593557056b00b7caa0651f5]
stable/7.1: [20f548cdac94860a164e5ebba4f7e4a01051cb06]

CVE-2026-64308: crypto: ccp - Do not initialize SNP for ioctl(SNP_VLEK_LOAD=
)

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64308

Introduced by commit ceac7fb ("crypto: ccp - Ensure implicit SEV/SNP
init and shutdown in ioctls") in v6.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [f91e9dbb5845d1e5abf1028e6df57dcf61583e1b]
stable/6.12: [61cf5eef20657bff9ca235fe938a99ce5ff65c06]
stable/6.18: [92567ed9306d5a3d1b007eb4faeff30cc3ffc3e4]
stable/7.1: [8836801847b9479ac046cb18a24981e1b0b05e9d]

CVE-2026-64309: crypto: ccp - Do not initialize SNP for ioctl(SNP_COMMIT)

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64309

Introduced by commit ceac7fb ("crypto: ccp - Ensure implicit SEV/SNP
init and shutdown in ioctls") in v6.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [5a1364da2f04217a36e2fdfa2db4ee025b383a20]
stable/6.12: [74768f73854d647a6462f252dc8782ab8a835211]
stable/6.18: [7a361c74bb12f3398c388905f1d325be642cd36e]
stable/7.1: [67ed191b4c8bdf432a3f32d1eb302880b4795cd1]

CVE-2026-64310: crypto: ccp - Do not initialize SNP for SEV ioctls

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64310

Introduced by commit ceac7fb ("crypto: ccp - Ensure implicit SEV/SNP
init and shutdown in ioctls") in v6.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [fb1758e74b8061aacfbce7bbb7a7cc650537e167]
stable/6.12: [5181e88da99c3d1d41e25db3472a62b8d4b42cdd]
stable/6.18: [9e983d0a74a6a2348e4ce61647ec8a4dfbe198ac]
stable/7.1: [d51207735e7c224cf591fa260c557a451a69a5cf]

CVE-2026-64311: crypto: loongson - Remove broken and unused loongson-rng

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64311

Introduced by commit 766b2d7 ("crypto: loongson - add Loongson RNG
driver support") in v6.18-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af3d1bb9a09daf928fc3f173689fb7904d6a6d4f]
stable/6.18: [037ec8353711c79353b12d5634e0c9ff363a9efa]
stable/7.1: [43de8b9f01b7dd2f6ca5360c6bf2f203c02288dc]

CVE-2026-64312: crypto: pcrypt - restore callback for non-parallel fallback

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64312

Introduced by commit 662f2f1 ("crypto: pcrypt - Call crypto layer
directly when padata_do_parallel() return -EBUSY") in v6.13-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [ed459fe319376e876de433d12b6c6772e612ca36]
stable/5.10: [81ce16d938db9b88cdc231522c0358395ae8c6b5]
stable/5.15: [3920c5f6edc341729d20d0507e466c6d3b11f372]
stable/6.1: [ae93c5b3e2a2968b56d772ca1d06615927b7cc36]
stable/6.12: [4711ca06bd169a2cbc9cc59a6de2ed512c41a880]
stable/6.18: [c4bd2f4c35b0e15b6040c2f7e7e7986780c066cf]
stable/6.6: [82789a44415e3e31168229421b138278dfb16412]
stable/7.1: [83fa1397d5853de1e27dd52ec44b068ff358ca18]

CVE-2026-64313: crypto: ecc - Fix carry overflow in vli multiplication

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64313

Introduced by commit 3c4b239 ("crypto: ecdh - Add ECDH software
support") in v4.8-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [27b536a2ec8e2f85a0380c2d13c9ecbc7aaab406]
stable/5.10: [d11b2bb99bec1f5557c01cac42231e23745f49b8]
stable/5.15: [b709e0e768766abe29a49e1c1922a1604be602f4]
stable/6.1: [24a54dfa06d09813b4802a374fad3d2c0e16a884]
stable/6.12: [5275e0fca256d081e2e7d4ba3dd8216c6e50d44e]
stable/6.18: [774ddddf5eb26eeca177350413e3e2bc50930ee9]
stable/6.6: [677450e5ef850c4d28b7956aa01104548c2a894e]
stable/7.1: [ebaae7c4251cc0cdb2602f334d4f08a3e82d271e]

CVE-2026-64314: crypto: chacha20poly1305 - validate poly1305 template argum=
ent

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64314

Introduced by commit a298765 ("crypto: chacha20poly1305 - Use
lib/crypto poly1305") in v6.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [265b861bece38318b8e0fc8fac0643d4ef906d31]
stable/6.18: [0016d3c21c6ab60a20be7f565cefb5999f3adeb6]
stable/7.1: [e74df53b36cdc6b6b9e5488ec883d1d55624737f]

CVE-2026-64315: crypto: caam - use print_hex_dump_devel to guard key hex du=
mps

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64315

Introduced by commit 8d818c1 ("crypto: caam/qi2 - add DPAA2-CAAM
driver") in v4.20-rc1.
Introduced by commit 226853a ("crypto: caam/qi2 - add skcipher
algorithms") in v4.20-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8005dc808bcce7d6cc2ae015a3cde1683bee602d]
stable/5.10: [1ec775f6a124cce6278ae58b7d1c78a3bc6eef23]
stable/5.15: [bcf3cf74dfb6981e18b22cbf561f859a0f7faa26]
stable/6.1: [6407dc85d0a4306681cf6c9be7f05e05dcb67a37]
stable/6.12: [8904b425cfcafe6a820c94b9bdf4b10f7d70f9d7]
stable/6.18: [d0b8cafd529b4ec759190c6081f7a76efb563a8f]
stable/6.6: [c8cfe11e48b2a4646fa662fcaa92e14810a28d46]
stable/7.1: [59057f5d4e9a195c6dd61695ad3bc4481ddf4f14]

CVE-2026-64316: crypto: caam - use print_hex_dump_devel to guard key hex du=
mps

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64316

Introduced by commit 6e00550 ("crypto: caam - print debug messages at
debug level") in v5.3-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f57657b6ea23f933371f2c2846322f441773cee]
stable/5.10: [45c0e3615e5bca5f1fc93357af8d19975c092d4f]
stable/5.15: [8b56ba10105ca34a4b75f7e33d41d96a63815591]
stable/6.1: [9a53dc0a0ae0486e164e5af3de5f99ab42c5a23e]
stable/6.12: [cea7302d5d05df74cfb4107897b1ca34163c06b9]
stable/6.18: [6f7b8e0321f3a8fbbd267d2ac15c671ab59e919e]
stable/6.6: [ebd37eef6e4f435e18829c0c0c9ba3a6618cb2dd]
stable/7.1: [8cf5fb0503129e53052fe29302379cf83891d0fb]

CVE-2026-64317: isofs: bound Rock Ridge symlink components to the SL record

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64317

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5fa1d6a5ec2356d2107dead614437c66fa7138b1]
stable/5.10: [1015e1c4b2fadd9c09704e24738e46598778c869]
stable/5.15: [36fe7d25dbc40da0c6b1dd4513a4f69ac6164eee]
stable/6.1: [a22cb6bb54dc167047ea9e70d97dfbc2c15649e3]
stable/6.12: [6bf41db09ef935d76fcc84ccf213b42c18de95ee]
stable/6.18: [b5699642640d6cff357638738c5293985cd5a53d]
stable/6.6: [b736b12108fd116c41777628f5a333791604df26]
stable/7.1: [9830725078c8483c6831ec10222ae724806ea36b]

CVE-2026-64318: partitions: aix: bound the pp_count scan to the ppe array

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64318

Introduced by commit 6ceea22 ("partitions: add aix lvm partition
support files") in v3.11-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2dc0bfd2fe355fb930de63c2f2eb8ced8570c579]
stable/5.10: [09861651617ba0fec089e8b9477439e68398c110]
stable/5.15: [5eacdb1967378f5e5591cd27a2d8cdee2df1a599]
stable/6.1: [b5e9c09309e18fd9839ad007c238120353ca0cc4]
stable/6.12: [4671bb74bba05fdd4acf670a35758c29e8c97b83]
stable/6.18: [ce93228e2193a17d2c58b656e439bb39fe5c3af8]
stable/6.6: [fd94a779020f2ecc8b2607f4c20b34acb1763b9a]
stable/7.1: [44f37ee92fdcd377c41bdf6a31cdd8cc7d4c410e]

CVE-2026-64319: nvmet-auth: validate reply message payload bounds
against transfer length

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64319

Introduced by commit db1312d ("nvmet: implement basic In-Band
Authentication") in v6.0-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a413ece2504c70aa34a20be4dafec04e8c741f9]
stable/6.12: [999f6205ede984a786f35f727b01f971b98e215d]
stable/6.18: [6d7649c1231dac14d906985d2936967e23041c26]
stable/6.6: [80cd28b56ab62d3e7ed0a7bf05282e6d3ee5b2a0]
stable/7.1: [caa71b3a43ea5c13fe7141cb019ebcb03b8ac857]

CVE-2026-64320: nvmet: fix pre-auth out-of-bounds heap read in
Discovery Get Log Page

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64320

Introduced by commit a07b497 ("nvmet: add a generic NVMe target") in v4.8-r=
c1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [53cd102a7a56079b11b897835bd9b94c14e6322c]
stable/6.12: [33b974eb626154ae9348f2bac7de84cb2a3d9dd4]
stable/6.18: [56c021a0869260d04c4b65d1471936aaf9177114]
stable/7.1: [a29b316b9bbfd269f323ab4ba9906a894025680f]

CVE-2026-64321: nvme: target: rdma: fix ndev refcount leak on queue connect

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64321

Introduced by commit 31deaeb ("nvmet-rdma: avoid circular locking
dependency on install_queue()") in v6.8-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [badc53620fe813b3a9f727ef9526f98567c2c898]
stable/6.12: [d65fe42820b890a6a4644de0a95a812471f79ad3]
stable/6.18: [a8803c4f0ac3fa7df5551bbb5a8800c434a94357]
stable/7.1: [5828517d17eda27f21d29ea14800c9e0a57bad11]

CVE-2026-64322: udf: validate sparing table length as an entry count,
not a byte count

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64322

Introduced by commit 1df2ae3 ("udf: Fortify loading of sparing table")
in v3.5-rc5.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3ec997bd5508e9b25210b5bbec89031629cdb093]
stable/5.10: [eeb0f3e193f8e523d03e4c9e084f6b4875f50e8e]
stable/5.15: [0a9b79a951cfd70a9d31ca01ae2d08a20bb730e9]
stable/6.1: [2d726135099313958f8975532a2e15322ff150ce]
stable/6.12: [2a219acb2ce674d99bbd1b7b35ed8c384dac7200]
stable/6.18: [04f4599a9efb90992d072a814960edf0cd62805d]
stable/6.6: [7285276aa50d2839afb5957ffd491ad282dc8f72]
stable/7.1: [7f7774b9da0ef17b87bfa238cf966ad0b3376150]

CVE-2026-64323: udf: validate VAT header length against the VAT inode size

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64323

Introduced by commit fa5e081 ("udf: Handle VAT packed inside inode
properly") in v2.6.26-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d8202786b3d75125c84ebc4de6d946f92fde0ee8]
stable/5.10: [0ad2d09a8d66fa8dc6f9b70d660b5fb4478ea934]
stable/5.15: [883962731420ec271ed8c1cd76524f4b17faa982]
stable/6.1: [2900e02a0dd4fc30ac9840e7ce4ca0b041ab0d63]
stable/6.12: [55287a3555ff0515b3aff181d2c08c0462a41709]
stable/6.18: [e610fb113cdfa8bf4247c9bf4f2337b81ad4ddad]
stable/6.6: [bb0d384c1f42a5b7ace0bd88fee80b9bb1d49acb]
stable/7.1: [74580fdf022909e184223cacc364feb826982d96]

CVE-2026-64324: udf: validate free block extents against the partition leng=
th

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64324

Introduced by commit 56e69e5 ("udf: prevent integer overflow in
udf_bitmap_free_blocks()") in v6.11-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [5f0419457f89dce1a3f1c8e62a3adf2f39ab8168]
stable/5.10: [fdd6229d2ae9914c1f25d1041db0f4f312a4fa76]
stable/5.15: [b54aee5652fcd7c23a0904a4623ec462c3edc70c]
stable/6.1: [12af328d2ee8d68e81ba612246d0b54b22d23e1f]
stable/6.12: [9442d75429b0c556292a7454fe888d54259f5240]
stable/6.18: [335202ab25b01fdd45889ff25eab70864686dea3]
stable/6.6: [fb49099206c5c57af28a157249fa7bcb5518f99e]
stable/7.1: [be87de7789a82a030a4896bc7683415ec9fa6f2b]

CVE-2026-64325: wifi: mt76: mt7921/mt7925: fix NULL dereference in CSA beac=
on

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64325

Introduced by commit 8aa2f59 ("wifi: mt76: mt7921: introduce CSA
support") in v6.14-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [351dd7d2c80d23e56dcce6faa4e62bea5b0877c7]
stable/7.1: [77e7b127472a191e086e1e0b1b051703f33b1801]

CVE-2026-64326: block: skip sync_blockdev() on surprise removal in
bdev_mark_dead()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64326

Introduced by commit d8530de ("block: call into the file system for
bdev_mark_dead") in v6.6-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [49f06cff50a4ccf3b7a1a662ceb892b3b21a527a]
stable/6.12: [f41cf35ee2a1e31374b3f54e7579c55153506e70]
stable/6.18: [9818bcae3c0ca1dde4b9a334125c46676e0a9b29]
stable/6.6: [d6998ddd507c81e3829489a6ead23f17f5acb7fe]
stable/7.1: [aa4c4a9315764b2b7a7182e72cc5ea87520436b4]

CVE-2026-64327: usb: gadget: f_fs: Initialize epfile->in early to fix
endpoint direction checks

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64327

Introduced by commit 7b07a2a ("usb: gadget: functionfs: Add DMABUF
import interface") in v6.9-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [82cfd4739011bdc7e87b5d585703427e89ddfaa5]
stable/6.12: [82cf1142e5ccf2b6d6d22ef713aaf3e5f2b5716b]
stable/6.18: [9e04055ab5fc0470a0031ee6934739f9aa8f34a5]
stable/7.1: [f99f32ea9aa976afcbec20647ed33b50a52002c1]

CVE-2026-64328: usb: gadget: f_fs: Fix DMA fence leak

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64328

Introduced by commit 7b07a2a ("usb: gadget: functionfs: Add DMABUF
import interface") in v6.9-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [baa6b6068a3f2bf2ed525a1cb37975905dadc658]
stable/6.12: [b7475b2dce5e121e687280ba5732ccefe77ffd2f]
stable/6.18: [e086c16962a1b0142e2675610e9c06fcfcd4c3a8]
stable/7.1: [0cae3d6109427c455bad0a18dfb3e2a91657e38a]

CVE-2026-64329: usb: typec: ucsi: ccg: Fix use-after-free of ucsi on remove

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64329

Introduced by commit e32fd98 ("usb: typec: ucsi: ccg: Move to the new
API") in v5.5-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f0bdc2884b67de337215079bba166df0cdf4ac5]
stable/5.10: [f1adeb1ff8bef1467d6961059810795d02bbad5d]
stable/5.15: [99381e762273a2410a3f0216000be32b013c0ea9]
stable/6.1: [1a160076d3d0dcd4a98a4599ad96eec0790b099b]
stable/6.12: [86c9ee928c4a370e323e432aaf8dca79c4ba7c85]
stable/6.18: [f5c772b76bbd95de8be51cf849c6098f6af6fcf9]
stable/6.6: [c32df11147822d22facee8fa30c2e8971d12f426]
stable/7.1: [dbb500bad02146b388041877574829016591ddc8]

CVE-2026-64330: usb: typec: tcpm: Validate SVID index in svdm_consume_modes=
()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64330

Introduced by commit 4ab8c18 ("usb: typec: Register a device for every
mode") in v4.19-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b681dd5fbf60b24a13c14661e5b7735759fb491]
stable/5.10: [89ff289cbf5d3b659a2babc5ccaae4eaf7e7cf53]
stable/5.15: [d638ec188e95fe60f4b01106ffd41958f8fb3c2c]
stable/6.1: [f8163c414de8640f2ca82ce4dc93409d4cdc2fad]
stable/6.12: [c6d2af3b217a525741c472f0ab45d7d274b8468f]
stable/6.18: [3e1b1ac47e8163627f159f30d80d51b914620dd4]
stable/6.6: [012406f89abc52d1d5f07aa5653b519ebf6d2407]
stable/7.1: [313ca06e7e224ca1dfadd5722fe71fb8bc276b8b]

CVE-2026-64331: usbip: vudc: fix NULL deref in vep_dequeue()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64331

Introduced by commit b6a0ca1 ("usbip: vudc: Add UDC specific ops") in v4.7-=
rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c5371e0b91b24159a3ebaa61e70b0980bcf03c0a]
stable/5.10: [9858c91d9ee6a13c45311569039413729fc9b757]
stable/5.15: [1226293ec9bed3d4cc5b05eeeb811d315ca51652]
stable/6.1: [3750f75f29f99c0223601e2ee73ad084adec47bd]
stable/6.12: [0025276175fbbe0dcbf3f84d090b0adee769e9d9]
stable/6.18: [347b59e9f96719d89b6ef555d02a18ada1a5846f]
stable/6.6: [d0ebf9cc7c2ddf95a7cfc654b940bdacb7edde97]
stable/7.1: [0443e4416aa1ee97748d1ed904eaf3352c60045e]

CVE-2026-64332: USB: ulpi: fix memory leak on registration failure

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64332

Introduced by commit 289fcff ("usb: add bus type for USB ULPI") in v4.2-rc1=
.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8af6812795869a66e9b26044f455b13deecdb69c]
stable/5.10: [d5b32f36c50894ac2df8fa184e6f35f3a6665ecd]
stable/5.15: [691e61e5d4cfc5a1b061e937f8cbf2126bfc19a0]
stable/6.1: [88187a43135c79d0e43573b4d8f880bbb919eceb]
stable/6.12: [624c57147df1977e0d3da53f1da7117861b9cf19]
stable/6.18: [1967a7f0cd5c08eb479196daa5aaa4b7b7a7bd04]
stable/6.6: [5c098f20f15db7f9126129686d1c6da2ce8bbeb0]
stable/7.1: [e5493c9a98ffe083acf13ac064828ae598ba3c16]

CVE-2026-64333: USB: serial: digi_acceleport: fix write buffer corruption

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64333

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [24ca1fea8f2753bf33e1d458ec1ae5d9b7796a65]
stable/5.10: [5d9dc88bdf8897788b0eed57113e9eca7fd42ea9]
stable/5.15: [2f296974acc279f05f284441bfe3064074958d11]
stable/6.1: [e60e4873e9178da9f4f2674e4c2ff085d5a84f79]
stable/6.12: [a274b3794fe1852c3d9fe6d900b94053c0b03410]
stable/6.18: [1243f120790042c2ac92e84e797dacc75fff4366]
stable/6.6: [699dfb6917503b3cda4d5da6941cf79c3c1b4c8b]
stable/7.1: [a3a13fdc53103b07335918e2cdeb465038a71725]

CVE-2026-64334: USB: serial: digi_acceleport: fix hard lockup on disconnect

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64334

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5c1ea24b53bf3bfb859f0a05573997487975da23]
stable/5.10: [6e51147c2744d15730084dc89cc99180d3de4184]
stable/5.15: [6a8592ace932081ea11aea41c460a1ca0f6344a4]
stable/6.1: [5a82d842e8c35227d7227f19e5e654df1451782c]
stable/6.12: [2067b3838da6e4af03bae3630414193188d754b2]
stable/6.18: [2b7dc482f859f2d027db07ff0efc1c5df5b3451a]
stable/6.6: [bcfeae431db9986c2b313e6a760f2ac8df61e138]
stable/7.1: [79bc131df0e50f8f663c1fdbbe952aaf193a8d39]

CVE-2026-64335: USB: serial: digi_acceleport: fix broken rx after throttle

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64335

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83a3dfc018943b05b6daf3a6f891833e1aabfa1f]
stable/5.10: [4f3f6f44db71e469933a7c36c5d57d937ba0a21b]
stable/5.15: [d5d2660caef78d4c996d34d123574c8e86f5b5ac]
stable/6.1: [61954033326fc7e637ed2aeeb4b52021e0ee4657]
stable/6.12: [abacd67e6f689c62d8a13e3da25f4272bc9ad4af]
stable/6.18: [eab394781e9321c0c7e97a24fd092387cb262f40]
stable/6.6: [8d50a910194f66566a5eb252b33283855c8d5203]
stable/7.1: [92fa3e1a49848509ea3f7995751963fc65095998]

CVE-2026-64336: USB: serial: keyspan_pda: fix information leak

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64336

Introduced by commit 034e38e ("USB: serial: keyspan_pda: add
write-fifo support") in v5.11-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6bfc8d01ac4068eced509f8fc74d0cd205e4dcec]
stable/5.15: [b069b7029862fafaff331d4c664d97d4ae828d6d]
stable/6.1: [e52ca411f50539ff1d0c877b9312771ca8a858c1]
stable/6.12: [e1494191a3aac665d3a2fce16169a97c346253ec]
stable/6.18: [cf6ca0aefae03958cfb5b189b0adbfb25c06bfac]
stable/6.6: [2f7a6b8ab3845bd1da02604f1a874b52a4555a72]
stable/7.1: [d4b12b6b395e43a2b1d80be3745631fcaa9c047b]

CVE-2026-64337: usb: mtu3: unmap request DMA on queue failure

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64337

Introduced by commit df2069a ("usb: Add MediaTek USB3 DRD driver") in v4.10=
-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0bddda5a11665c210339de76d27ebbd1a2e0b43c]
stable/5.10: [3cee30f1138281a1d247bb053a1ad4f7c5b04e98]
stable/5.15: [f3c4026524d3660c73ef2838b99776d37631e039]
stable/6.1: [e8f739a3860d043dcc135371637e82f53132efe5]
stable/6.12: [00c3fef4c2dc2c7cbd8281f8fda09d1913420f09]
stable/6.18: [8c29d9cfab1c3cf0d0b7fcdf9255597be30aa3e1]
stable/6.6: [4183874b7925f4a98b400cf857bea26ee87da236]
stable/7.1: [835b0596d4c9bdef93f842d8f826978fb4956b74]

CVE-2026-64338: USB: misc: uss720: unregister parport on probe failure

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64338

Introduced by commit 3295f1b ("usb: misc: uss720: check for
incompatible versions of the Belkin F5U002") in v6.10-rc1.
Fixed in v7.2-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/5.10 stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [b4ecbdc4f8830f5586c4a5cfc384c00f20f8f8b3]
stable/5.10: [6bbb98bec71b577fda4f4b48f7aea5874b04a576]
stable/5.15: [93563243377f8e9b46cc94d9c4f06533dd31b141]
stable/6.1: [1712fd71a5aaf81e47c747f180535fa963ad7830]
stable/6.12: [5e62d7857fd51b908b8371062ee839739a086bbe]
stable/6.18: [729b68a5bad71220ae0914c8bdab9488ad5be6c8]
stable/6.6: [0b3073f40cc9f95d5ff0037eb0a06f5c1725a7ea]
stable/7.1: [48dd0b2ec9f2e97c486eb68cd0a64b25c1c3df3e]

CVE-2026-64339: usb: misc: usbio: bound bulk IN response length to the
received transfer

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64339

Introduced by commit 121a0f8 ("usb: misc: Add Intel USBIO bridge
driver") in v6.18-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8c6314489550fa81d41723a0ff33f655b5b6c7b6]
stable/6.18: [48394f94211cf8fe0ea8604fc441633abf90fc94]
stable/7.1: [fc1b546973c1442d5b947fcdd03581f20ecc5bd2]

CVE-2026-64340: USB: legousbtower: fix use-after-free on disconnect race

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64340

Introduced by commit 18bcbcf ("USB: misc: legousbtower: semaphore to
mutex") in v2.6.25-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [62fc8eb1b1481051f7bab4aa93d79809053dd09f]
stable/5.10: [11d069f85851997b4ea0adf242ed9672dc749b8f]
stable/5.15: [b4222c05066b252b451f9c8c4730b5b60824ea66]
stable/6.1: [6462de75d2e370c7e74dcfb7b4ae79eb5a6a55ee]
stable/6.12: [ab2bfd7bec4f134b377ec42f513e90c35db94160]
stable/6.18: [766738ecf2b819e54d38763c8d1c8ae6cff14b39]
stable/6.6: [0b57e5ddbd89df3bc367463de3d2ca66f99a1a5e]
stable/7.1: [9ba62966461a8e3cc593b62c56ec62eb2d80436d]

CVE-2026-64341: USB: iowarrior: fix use-after-free on disconnect race

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64341

Introduced by commit 946b960 ("USB: add driver for iowarrior
devices.") in v2.6.21-rc2.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c602254ba4c10f60a73cd99d147874f86a3f485c]
stable/6.12: [3c0a7b29ebb391d5f50b115e86f842b709195b08]
stable/7.1: [71590982700fdeb39a37a500c877228b0140978e]

CVE-2026-64342: USB: iowarrior: fix use-after-free on disconnect

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64342

Introduced by commit b5f8d46 ("USB: iowarrior: fix use-after-free
after driver unbind") in v5.4-rc3.
Introduced by commit 946b960 ("USB: add driver for iowarrior
devices.") in v2.6.21-rc2.
Fixed in v7.2-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [bc0e4f16c44e50daa0b1ea729934baa3b4815dee]
stable/5.10: [d058d377291567b72aea33b017215cbfb383b0ad]
stable/5.15: [a7bbe946ca3a6eeb6f364d5e84b05e02c7c0d595]
stable/6.1: [97ad9337127be04ca0b027c2b01e69302353f404]
stable/6.12: [f328b0e9a0dbd162f5db1b83026b689f2fea2241]
stable/6.18: [b748f97aff339e7f08dca9cf38a05b980fb66fea]
stable/6.6: [164398601a7f160bc3df1efa454f983302cef03f]
stable/7.1: [e4596816984efc537e7c04c1af0c639394f967f7]

CVE-2026-64343: USB: ldusb: fix use-after-free on disconnect race

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64343

Introduced by commit ce0d7d3 ("usb: ldusb: ld_usb semaphore to mutex")
in v2.6.26-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [19bdfc7b3c179331eafa423d87e1336f43bbfeb8]
stable/5.10: [fc55923a972e715f9a27187b47d4920709e23d85]
stable/5.15: [e5a9bdce4bfd3e2226b5f3df5fb8385d6935ee69]
stable/6.1: [af59829e67e11ba2511a9f8e4b9111afc7d1f550]
stable/6.12: [d8f69404e1d671326f86d378b9f5bfbd56490e9d]
stable/6.18: [2107a4fc8ff1cf1d52f416c1e5cc8e97413a5915]
stable/6.6: [02ca08fff74cf9b0a3c4d2cacde1c6edeeb95bb4]
stable/7.1: [a3e794136ab5e3ad1e7019175a4b837aec86db4b]

CVE-2026-64344: USB: idmouse: fix use-after-free on disconnect race

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64344

Introduced by commit 54d2bc0 ("USB: fix locking in idmouse") in v2.6.24-rc2=
.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff002c153f9722caece3983cc23dc4d9d4652cb4]
stable/5.10: [31e75fed8f90cfea9f8285e7ed135b0e452bf872]
stable/5.15: [8d53b14ad4ccbff6d306b3a39c812303f4a87d41]
stable/6.1: [f62622e947f82a3854a8502d09492ffbdeb252b4]
stable/6.12: [d0f61acb51a8c8f3fd41c303ddb7770cd83e7ed4]
stable/6.18: [54c2b7356b4aeea467f9fb13b85e9e036bc428cb]
stable/6.6: [60fc5ef4ecea3e3d1fe556cecf53ddd13096ef09]
stable/7.1: [e88cff5fbaa629f3cab45c8b46f395d62c2eb515]

CVE-2026-64345: usb: gadget: f_printer: take kref only for successful open

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64345

Introduced by commit e8d5f92 ("usb: gadget: function: printer: fix
use-after-free in __lock_acquire") in v5.10-rc1.
Fixed in v7.2-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [30adce93d5c4a5a1ec29d9249e3fdfcc391d406b]
stable/5.10: [94ec20d97aa51547965a539f660a1fe79c6929a3]
stable/6.12: [bf20c94fa6aaff945f0ae3a23f3212cd299f28d9]
stable/6.18: [8a5eba992c862b0c94411eecf9b7121e8636db38]
stable/6.6: [75c0ad13e136961328253742501b4efc3988a587]
stable/7.1: [7f1f24c367938c5537e2308bf9a965f051d14774]

CVE-2026-64346: usb: gadget: udc: Fix use-after-free in gadget_match_driver

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64346

According to the .vulnerable file, this bug was introduced by commit
fc274c1 in v5.19-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [67e511d2989eb1c8c588b599ce2fcc6bb8e6f7ea]
stable/5.15: [f845852a5a8914277031f47d8de0f350fef52405]
stable/6.1: [50eeb8e8a4f389efc91b93cff14a683e714ec194]
stable/6.12: [d026f71df141c9b064ff32a78af5391a31ef75c2]
stable/6.18: [b52476a83d9e12df00765359d728a875b128bef1]
stable/6.6: [7a5214dae906d9f58e07bc4995e8181ee74439f4]
stable/7.1: [54fa390aae393eb130f307a85562e3001cc39a52]

CVE-2026-64347: usb: gadget: composite: fix dead empty check in the
USB_DT_OTG handler

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64347

Introduced by commit 53e6242 ("usb: gadget: composite: add USB_DT_OTG
request handling") in v4.3-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8f680609c2b3ab795ffcd6f21585b6dfc46d395]
stable/5.10: [2454264b2ab4cf0055c0bfd39e79f830452bd0db]
stable/5.15: [d3e72cfef2e38bd588055739a8100d14f9773b17]
stable/6.1: [8ac463fe6c0f85bdb1ce8c30e8c9e060802e4483]
stable/6.12: [91b3ecd34b60f950c50c560974945b6596a6f207]
stable/6.18: [01feaf024f29618d5ffa7ab0fd858e0579dcbf7b]
stable/6.6: [56add2b9b2e89ec61c0761165d758f73004fdfdf]
stable/7.1: [fcb21bf747640c9d6bd1eda9da85420f076d59c1]

CVE-2026-64348: usb: free iso schedules on failed submit

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64348

Introduced by commit 8de9840 ("[PATCH] USB: Fix USB suspend/resume
crasher (#2)") in v2.6.20.16.
Introduced by commit e9df41c ("USB: make HCDs responsible for managing
endpoint queues") in v2.6.24-rc1.
Introduced by commit 7d50195 ("usb: host: Faraday fotg210-hcd driver")
in v3.12-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b9399d25fbb34a05bbe76eeedd730f62ff2670e9]
stable/5.10: [b0d00d077f9738d215af9b50c74dffab7a1de19f]
stable/6.12: [8890699eea19027ef6e4f9cbcf27cba5e789793f]
stable/6.18: [6bc17a78a05671d303820224fb37ca339c1dc2cb]
stable/6.6: [be5004395dfd0b6ec310db359f887fa396fd0dd2]
stable/7.1: [4bb88aee6b868cbf73bf453f62497802f5fe4769]

CVE-2026-64349: usb: dwc3: fix dwc3_readl() and dwc3_writel() calls in
dwc3_ulpi_setup()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64349

Introduced by commit 9accc68 ("usb: dwc3: Add dwc pointer to
dwc3_readl/writel") in v7.0-rc1.
Fixed in v7.2-rc3.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [e0f844d9d74200d311c6438a0f04270834ba5365]
stable/6.18: [41a4e80d5af04855e68ac88f5e2cd07fa67287f8]
stable/7.1: [4349e487a1149ff33b65d53427b8aca57f2e4578]

CVE-2026-64350: usb: cdnsp: fix stream context array leak in
cdnsp_alloc_stream_info()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64350

Introduced by commit 3d82904 ("usb: cdnsp: cdns3 Add main part of
Cadence USBSSP DRD Driver") in v5.12-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3348f444a4ce43dd5c2d1aa41634cb6eff33aa64]
stable/5.15: [37283f5a47127fbdea567749a2110766af53d18d]
stable/6.1: [cb8e9391b7f4f77d112c51910cd7c355a337ef76]
stable/6.12: [d9643bbe93a6aee24edee1a86e0303aa74bcd320]
stable/6.18: [c00826e87bb75e14e0381b05da5f18ffd0241ab6]
stable/6.6: [fde3c095e1d48e0ac3ab8bc32905da42fe58a36a]
stable/7.1: [963075c4da0cd43b3d17b107c355e1eb0ee64a58]

CVE-2026-64351: net: usb: kalmia: bound RX frame length in kalmia_rx_fixup(=
)

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64351

Introduced by commit d402612 ("net/usb: Add Samsung Kalmia driver for
Samsung GT-B3730") in v3.0-rc4.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47b6bcef6e679593d2e86e04ee72c46a4e2f7139]
stable/5.10: [391706889a5112feafdc0c68db3ecc7ed325d09c]
stable/5.15: [aa4eef2cbb66ea3dfcfc24bdce798dd78a81b54b]
stable/6.1: [2d04c37ed4e1d0f733ad39ec35b5a5d8818b4f4a]
stable/6.12: [c466097d85d52f3aa200736cb4759e66d4bbf6e3]
stable/6.18: [e24eb271061db384a3c3ef6f107fe515e68ef222]
stable/6.6: [46ab32870d010e9a057bc5659cea22b7e728ca88]
stable/7.1: [51e65f1d78457ea4f9513d90ab22c9dccbb35110]

CVE-2026-64352: bpf: Allow LPM map access from sleepable BPF programs

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64352

Introduced by commit 694cea3 ("bpf: Allow RCU-protected lookups to
happen from bh context") in v5.14-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f884d371fafea137afea504d49ee4a7c8d7985b]
stable/5.15: [f0967d4f1ba4323a3cb7dc8fdba74dd3a8caaf04]
stable/6.1: [304ca50582f0c047370f85e13caec456f78c9fcc]
stable/6.12: [9bfdf4b81b0e56d47bc6c46c34a46638be716695]
stable/6.18: [57454944737f3ad9a8703aecbbb79713b513a94b]
stable/6.6: [ec662a8b2cde01e76b37ccd4b992d0342299e69c]
stable/7.1: [bd6ad9a6b30498d845413e863fb95c6fab3babe3]

CVE-2026-64353: bpf: Keep dynamic inner array lookups nullable

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64353

Introduced by commit d2102f2 ("bpf: verifier: Support eliding map
lookup nullness") in v6.14-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [53040a81ae57cdca8af8ac36fe4e661730cf7c6b]
stable/6.18: [0b92ad64d6e4bde85e6b9888404f9a7a2b65d269]
stable/7.1: [d57db0d975053e01410c54e708a85b6d32ef2ebd]

CVE-2026-64354: bpf: Validate BTF repeated field counts before expansion

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64354

Introduced by commit 797d73e ("bpf: Check the remaining info_cnt
before repeating btf fields") in v6.12-rc4.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b9452b594fd3aecbfd4aa0a6a1f741330a37dab7]
stable/6.12: [c5ff816d5f13900c3f1f3298cfcc61339e056e56]
stable/6.18: [cd407de2ef5dc70f1970b343ffaa16186340fdfd]
stable/7.1: [ff77d013b737c0f77d925e2f2c59f0cf3d76bd35]

CVE-2026-64355: bpf: Reject fragmented frames in devmap

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64355

Introduced by commit e624d4e ("xdp: Extend xdp_redirect_map with
broadcast support") in v5.14-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa496720618f1a6054f1c870bf10b4f6c99bf656]
stable/5.15: [47baddc856ae7e93a565dd9deeb797999b179466]
stable/6.1: [07a4c11ee8ef4abcb39d922e9e410ae269671cdf]
stable/6.12: [c5b4f5efcb55c1af3fe44ff712d31b7fb098a831]
stable/6.18: [a9bb2d9c798cb62a4050a991c27b752770c33afe]
stable/6.6: [bccbab36ff228e0825eb85d9b0f9b8434cd0a399]
stable/7.1: [51d07c12ca411e692c424ecdabf077f1e61a61be]

CVE-2026-64356: xfs: fix memory leak in xfs_dqinode_metadir_create()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64356

Introduced by commit e80fbe1 ("xfs: use metadir for quota inodes") in v6.13=
-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [45de375b25060edf46e20abb36521ba530336ceb]
stable/6.18: [c3d3d2212c2966973dd7d603c6c6e6ed6fc7fbe1]
stable/7.1: [06a2e6dbaa26c0740ac76dfa66b0aedc78d05820]

CVE-2026-64357: xfs: fix exchmaps reservation limit check

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64357

Introduced by commit 966ceaf ("xfs: create deferred log items for file
mapping exchanges") in v6.10-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0a5213bbff62b51c7d4999ac8c7e11ea57d00d45]
stable/6.12: [c597c8580d50127fc1221b5a5b653a94d49e23e3]
stable/6.18: [a62ef2d13d6e7270dd5e88c6082bf2d0edcd5112]
stable/7.1: [4707344b0d36d1012c8a1716e20167cd3afdd5f1]

CVE-2026-64358: media: mtk-jpeg: cancel workqueue on release for
supported platforms only

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64358

Introduced by commit 34c519f ("media: mtk-jpeg: fix use-after-free in
release path due to uncancelled work") in v7.1-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [b1845a227fda37b2fe5327df3ca0015d7e290235]
stable/6.12: [ac0774961a6ea174a71d4ffa39966edafbf7662d]
stable/6.18: [973408ceab14555a8548b97c8cc7b54208c3f251]
stable/6.6: [0fed0fc34ce734b4b8c2f6a467d38bddcb21dda9]
stable/7.1: [4c4b4af4a9f278da096f0dbdb6b59594701d29bf]

CVE-2026-64359: nilfs2: reject CLEAN_SEGMENTS ioctl with out-of-range
segment numbers

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64359

Introduced by commit 071cb4b ("nilfs2: eliminate removal list of
segments") in v2.6.31-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0e7a690fe435f8d5ea3feb7c1d8d73ba7e8b8aa9]
stable/5.10: [3ed388ec3b8922383d1e2d4432d7bd4cbbf8364e]
stable/5.15: [876c98e0fc65f071680c03c2e2ee3ef7ff9ca078]
stable/6.1: [39607452b1400c7bf748f15122df4d058b768c5b]
stable/6.12: [0789f0a6710713254a08f3a7d2ecbb6d1cbcf0aa]
stable/6.18: [223463c488b0554212a94de971ea538eb2805fc7]
stable/6.6: [286f77d002a337735c0846d7480a82d9cda2aa31]
stable/7.1: [d26aef771b4f6923da9f89d6d5b70d8def5853de]

CVE-2026-64360: hfs/hfsplus: zero-initialize buffer in hfs_bnode_read

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64360

Introduced by commit a431930 ("hfs: fix slab-out-of-bounds in
hfs_bnode_read()") in v6.17-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12
stable/6.6

Fixed status
mainline: [d67aadee19ffdf3cc8520c5a4f4d5b2916d30baf]
stable/5.10: [34684a04777358b2b40ac729e54c8e45359e46b3]
stable/5.15: [0b189b2204f1a2612dc68f8d139fb5b80539e710]
stable/6.1: [8f72fd25a57a457866350359ddd27a43caa62c95]
stable/6.12: [d2afc7ecee476f9251dd87444f7fb6a424410922]
stable/6.18: [f3461b84a4865d9b5e70fbb71da72ae044a3bcd2]
stable/6.6: [16ca053c2be5f4f3044dccf7fc19237dc820d394]
stable/7.1: [d5b45bad75cd2730b8452aed4d3b20a2b2a12576]

CVE-2026-64361: hfs/hfsplus: fix u32 overflow in
check_and_correct_requested_length

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64361

Introduced by commit a431930 ("hfs: fix slab-out-of-bounds in
hfs_bnode_read()") in v6.17-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12
stable/6.6

Fixed status
mainline: [966cb76fb2857a4242cab6ea2ea17acf818a3da7]
stable/5.10: [c8dd112173c02adf539fe2ad34a45f5e0068780d]
stable/5.15: [fc9d1447ca3cdc78d2e4ace1ce1f3a7c77ca08b1]
stable/6.1: [671c3fcc2ad31c1311ea6414382a2d95104ae1b9]
stable/6.12: [7399c3baee7bb622a92f0b895cd4d3009a693f2b]
stable/6.18: [607217f7ad419b53926f71e3f75001813bbc08ad]
stable/6.6: [b6a481642ea1977be2f84dc08c5affd742c177e7]
stable/7.1: [c25d3c931a63e762fcaa9cb125b901c53b62403f]

CVE-2026-64362: HID: lg-g15: cancel pending work on remove to fix a
use-after-free

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64362

Introduced by commit 97b741a ("HID: lg-g15: Add keyboard and LCD
backlight control") in v5.5-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7705b4140d188ce22656f6e541ae7ef834c7e11a]
stable/5.10: [3b9a3919aac6977262f04d5365c0456877522a44]
stable/5.15: [4aef9676c26dff8723b56834951cfc6b618f0986]
stable/6.1: [acce9dee807f21184fff19ad17c8ed464247e7f7]
stable/6.12: [dfc6e61f83113cc18346b6988f07271c0063357d]
stable/6.18: [4d0d51bc12d246accbfbb94de05d729c68c9b8fb]
stable/6.6: [33cd1a000daf929356aacf2b191d31714ff0615e]
stable/7.1: [8131f4226688c4be5f30874d167e44dab838eb09]

CVE-2026-64363: HID: appleir: fix UAF on pending key_up_timer in remove()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64363

Introduced by commit 9a4a557 ("HID: appleir: add support for Apple ir
devices") in v3.10-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [75fe87e19d8aff81eb2c64d15d244ab8da4de945]
stable/5.10: [89ef67359672bf4cd6921524e39f61648fe38c0f]
stable/5.15: [3d30a0bb0e79621ae921b487835c56198adfafa3]
stable/6.1: [37a52c61d4f78153c38ae1f7491dfcc8ac828dcf]
stable/6.12: [3755f6e25776b8b12ddf062f9b573f05090e4034]
stable/6.18: [b363d964ca829c1761c9f04188dfa28f90b0f2d4]
stable/6.6: [05e3decc55d1deca9410e0eb36466651fcbe57a5]
stable/7.1: [6b0838e86da88b1d3bff86f19761ff25af73eaca]

CVE-2026-64364: HID: multitouch: fix out-of-bounds bit access on mt_io_flag=
s

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64364

Introduced by commit 46f781e ("HID: multitouch: fix sticky fingers")
in v6.18-rc2.
Fixed in v7.2-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [8813b0612275cc61fe9e6603d0ee019247ade6be]
stable/5.10: [12e90656e330ff8bbaf2f29c535fdb8a11cc6f55]
stable/5.15: [152983d87387f6a8ae72b73474cfa55fbcf1ec75]
stable/6.1: [b5c037d6b807017e74a115288f81bc9cd5a5aab8]
stable/6.12: [e24918ee67c4dc3d20d4670750e46e9b160365f4]
stable/6.18: [37daa8c96bd563d03150e23f094cb60703594a6d]
stable/6.6: [a6d5ce2e1a2d7bf189bde8a659d04b65f0b0725d]
stable/7.1: [6493ebf9489efef0105078377b973ab33d51af22]

CVE-2026-64365: HID: letsketch: fix UAF on inrange_timer at driver unbind

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64365

Introduced by commit 33a5c27 ("HID: Add new Letsketch tablet driver")
in v5.17-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [46c8beeccd8ab2c863827254a85ea877654a3534]
stable/6.1: [2bb6e7143cf70ed281822d26c1848b2897ac36e9]
stable/6.12: [17f5928d7010bc9e002930326b59e60e40c09ee3]
stable/6.18: [3eca1a8165b5e7996e699e9df76cb4645e184d42]
stable/6.6: [523db788c0f84612707638e266e8957ca7e3a756]
stable/7.1: [df3d8aa1a9392da3de66398e7a03422463806b21]

CVE-2026-64366: HID: wacom: fix slab-out-of-bounds write in
wacom_wac_queue_insert

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64366

Introduced by commit 5e013ad ("HID: wacom: Remove static
WACOM_PKGLEN_MAX limit") in v6.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6b3014ec0e9a390ca563030b2d7689921f0daef5]
stable/6.18: [ca899a926c11a59211b764b0155d9a1cdcc32b81]
stable/7.1: [57bdd10ad50d68341f500a7b330f0d8949e510ec]

CVE-2026-64367: HID: hid-goodix-spi: validate report size to prevent
stack buffer overflow

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64367

Introduced by commit 75e16c8 ("HID: hid-goodix: Add Goodix
HID-over-SPI driver") in v6.12-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [db0a0768d09273aadadeb76730cd658d720333a4]
stable/6.12: [ad47ad624f2fce0bc44bbadb664242461a97d774]
stable/6.18: [dae1d000ddfd5c2140b036e47fff0c497ae9c64b]
stable/7.1: [835fcc8655569737e3f057d42875a96259db74c2]

CVE-2026-64368: mm/slab: do not limit zeroing to orig_size when only
red zoning is enabled

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64368

Introduced by commit 9ce6739 ("mm/slub: only zero requested size of
buffer for kzalloc when debug enabled") in v6.2-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [648927ceb84021a25a0fbd5673740956f318d534]
stable/6.12: [7e706d50fa119eead6376bf0ef973e8d73a96030]
stable/6.18: [2382971aaaef5bf85a651234c64906f59580b8be]
stable/6.6: [6256899c3a34674bba6076884aedbba49fc695e4]
stable/7.1: [0d18ccef142f04433dfb2a0c120cf223d2b8a42c]

CVE-2026-64369: s390: Revert support for DCACHE_WORD_ACCESS

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64369

Introduced by commit 802ba53 ("s390: add support for
DCACHE_WORD_ACCESS") in v6.7-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [37540b8c287fc817bdbd0c62bb75ad6eab0e5d03]
stable/6.12: [c9e0f1517631ac08987f8385817119bccf2f1f12]
stable/6.18: [be79d285bea70d0edd5015bd487311bfa8cbebc9]
stable/7.1: [c94806905e02cc8e17a69c822d93c41743b7ffc5]

CVE-2026-64370: posix-cpu-timers: Fix pid refcount leak in
do_cpu_nanosleep() error path

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64370

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87bd2ad568e15b90d5f7d4bcd70342d05dad649c]
stable/5.10: [afed3cdc1cca133f804fcf57ff228974f424b23a]
stable/5.15: [8a270b1258797f61b61da44f8bfd41a581b5c85b]
stable/6.1: [d605d00085adc3fddf67de01dc2a44aebf1a3fb5]
stable/6.12: [eb4cec29a78334d09bcfb41c0660cdd62ba05843]
stable/6.18: [7776f9226e99eb49d97492b0b445027cfcb189da]
stable/6.6: [e5ffc638faf5dc7d9dc85c9a95e10bf97442e0c0]
stable/7.1: [8f06363446c5d043c9a7c008b250040e9de98cf9]

CVE-2026-64371: proc: protect ptrace_may_access() with exec_update_lock (pa=
rt 1)

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64371

Introduced by commit f83ce3e ("proc: avoid information leaks to
non-privileged processes") in v2.6.30-rc5.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6650527444dadc63d84aa939d14ecba4fadb2f69]
stable/5.10: [ae1e630bcaac739f625822078edbaea98366930d]
stable/5.15: [d54f14655fd7d7b293698a8b6918563c4c0465e7]
stable/6.1: [bb43679356f1f2a4c6b1c88aec4f021e5b5c74e9]
stable/6.12: [4bfe8c481846cee52473a2f7d7b30ee8e6749fc4]
stable/6.18: [f9b4b03ccc9c69bf7f7298d4559906ebea7143b3]
stable/6.6: [7456ae990a9738962b33146916fabca62ae3d4e0]
stable/7.1: [c1cfd63326f5d09999134e9052c353faf738286e]

CVE-2026-64372: cpufreq: pcc: fix use-after-free and double free in
_OSC evaluation

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64372

Introduced by commit 0f1d683 ("[CPUFREQ] Processor Clocking Control
interface driver") in v2.6.34-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [266d3dd8b757b48a576e90f018b51f7b7563cc32]
stable/5.10: [8e454e9d0bc03446d610ee49abec9dfd424f6541]
stable/5.15: [632666a63116d8061c62a988d1ca39dcd6d27c9b]
stable/6.1: [5cdb25f144b101083d8bf3fd023ad87fbe6850d7]
stable/6.12: [a36ca93a8ba57464e521d70a337d37f069064111]
stable/6.18: [6ba6f6783be2ffeb2cbcdc9321c4b9f708f796f7]
stable/6.6: [982c9f92d57bda2b769851ff6d90d43dcf5f3734]
stable/7.1: [0e3c739a2f6fc1de5b19a8839ab80696b9cb2a29]

CVE-2026-64373: cpufreq: Fix hotplug-suspend race during reboot

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64373

Introduced by commit 65650b3 ("cpufreq: Avoid cpufreq_suspend()
deadlock on system shutdown") in v5.4-rc4.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [a9029dd55696c651ee46912afa2a166fa456bb3e]
stable/5.10: [6d5dd354c37abaf4d60400c55c71f23ba2b33639]
stable/5.15: [9103078c7b3091a2fbb52af176f95982ee7dd7f8]
stable/6.1: [cd4524ff6567fa4458a5bec4b017105e671d393e]
stable/6.12: [a0ef2fc89d28ca62923376c4b8ffaa57136a36be]
stable/6.18: [6e175c00c62dca3d91b987015808b5d52e8db2b4]
stable/6.6: [73255d702c7560185fd5951aadcf7eb057c2f453]
stable/7.1: [a0106b41f9a724868d390b8b3b4ea5ca0e04ea53]

CVE-2026-64374: sched/rt: Have RT_PUSH_IPI be default off for non PREEMPT_R=
T

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64374

Introduced by commit b6366f0 ("sched/rt: Use IPI to trigger RT task
push migration instead of pulling") in v4.1-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd29c017aed628076e915fe4cdfb5392fd4c5cab]
stable/5.10: [b99f04ae3d200d2f8844aa29145bd18eccbeecde]
stable/5.15: [d8312a56d9a162e3ec76476aa487e7d20bc602e9]
stable/6.1: [44aae426dbfd51286f7eb601cfa14bc32164812a]
stable/6.12: [89237c8fc15d8016a194076e648ccb57d75e65ae]
stable/6.18: [4bd0da48fbc1dbef6774175129107fbbdd353e26]
stable/6.6: [860aaff72c8446fed5e576249e19952883a18885]
stable/7.1: [a18f80bf5359238c4f067d691b96af00286fdd89]

CVE-2026-64375: proc: protect ptrace_may_access() with
exec_update_lock (FD links)

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64375

Introduced by commit 778c114 ("[PATCH] proc: Use sane permission
checks on the /proc/<pid>/fd/ symlinks") in v2.6.20.16.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6255da28d4bb5349fe18e84cb043ccd394eba75d]
stable/5.10: [6253dfee5afba536bb54fc6fe6c091c3758fafe1]
stable/5.15: [65bf0d2b6e914f1448d6a2fde193dcf60936a651]
stable/6.1: [de497d7aa2fae453a7e7c8f7d3e8682e565e3aaf]
stable/6.12: [83b17872e3166c295c599279fc9562ac3840c638]
stable/6.18: [497c6bae5167428596575f20af6613ff5671f383]
stable/6.6: [138c692d2b2d63d26f2eb957d0e4fcc5d61f9ff2]
stable/7.1: [dfd1894cb64cbd8758b461ed713800fe73db4f82]

CVE-2026-64376: firmware_loader: fix device reference leak in
firmware_upload_register()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64376

Introduced by commit 97730bb ("firmware_loader: Add firmware-upload
support") in v5.19-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [896df22ee57648b0c505bd76ddbc6b2341834696]
stable/6.1: [517676ec7dfca064e08f94007a4abd21969de0a0]
stable/6.12: [2619b47a0c8114eef980a56ade7e3ef4b58eb384]
stable/6.18: [92f41769e5fd16bcd9ba97500d0517332e0a5b45]
stable/6.6: [46d403da376a8b7c1187193294953816e1a8d7fe]
stable/7.1: [15432f19562fdb9199cce6d9fc24db12c71ed574]

CVE-2026-64377: cpufreq: qcom-cpufreq-hw: Fix possible double free

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64377

Introduced by commit 054a3ef ("cpufreq: qcom-hw: Allocate
qcom_cpufreq_data during probe") in v6.2-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bcb8889c4981fdde42d4fd2c29a77d510fe21da2]
stable/6.12: [28a03a3f6e6cda0b0da3b43761d175dec5d14d13]
stable/6.18: [e904961332801c87355f5d11c65bb433e717c489]
stable/7.1: [9de568ef6cdfc7912d5ea8db02843c0e4ef0c75d]

CVE-2026-64378: writeback: fix race between cgroup_writeback_umount()
and inode_switch_wbs()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64378

Introduced by commit a1a0e23 ("writeback: flush inode cgroup wb
switches instead of pinning super_block") in v4.5-rc7.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [cba38ec4cbd3a7b8b942a8d52531a05be8a9ff0d]
stable/5.10: [087d5b8b501c570f84bf655164e6698c3ce146e0]
stable/6.1: [3c9c9648f77e4d14e50676bc51c2174ba9c8d361]
stable/6.12: [c923cc3cb5cd8945ceaf08252754110643446593]
stable/6.18: [685fc15a410885b6d4dee64de0dce721b9428b12]
stable/6.6: [5c3265f3252b2ee50707adaaa3f9bd0df3df72de]
stable/7.1: [53eeaf4d63068dbc7708b0c7adb20151c812feca]

CVE-2026-64379: smb: client: mask server-provided mode to 07777 in modefrom=
sid

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64379

Introduced by commit e2f8fbf ("cifs: get mode bits from special sid on
stat") in v5.4-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3d9c7160d483fc8f9e225aafad8ecbbc43f3151]
stable/5.10: [5f6f2241034f189c69d4d0b5f8fe24a0c25b0c14]
stable/5.15: [ee2216dbdf0c677e89bb43e03247dba590ed00ef]
stable/6.1: [f511807feee7cb29b61bdfa86472c7e9e2e5df94]
stable/6.12: [b84e002e0df26bbc6cbd3ca01b8212601fe0ae7d]
stable/6.18: [c6c484a7d5bff6b929a86d7ed5130f29834c6a0d]
stable/6.6: [08c600b7e1818539ba5efee4cdb06215c245ca78]
stable/7.1: [f80add1bfb3425100a325b14f19648e75669a954]

CVE-2026-64380: smb: client: harden POSIX SID length parsing

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64380

Introduced by commit 349e13a ("cifs: add smb2 POSIX info level") in v5.7-rc=
1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ad2bcf2441430bb2e918fb3ef9a90d775a6e422]
stable/5.10: [171605aed68380c2fa75dff9b3a1ed427c50065b]
stable/5.15: [4213c1208978483021d7d125c131de3985d38f61]
stable/6.1: [96e889bc1e759c83f25093e8c2f3da31b4973f30]
stable/6.12: [427eb7eb46425fec845a43e861f3d6e2899cae59]
stable/6.18: [86c5d470f5d42e61123b2f4b4f0b91f4eee5b980]
stable/6.6: [0de5b8e76847f5de26f364a82c6602c4881c30da]
stable/7.1: [46a84715a015cb48e1b9c219dc88c03d8a541ea4]

CVE-2026-64381: smb: client: Fix next buffer leak in
receive_encrypted_standard()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64381

Introduced by commit b24df3e ("cifs: update receive_encrypted_standard
to handle compounded responses") in v4.19-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c6267a1d5cf4c73b656f8181b310cbbb3e4767b]
stable/5.10: [94e4f672db029414b9888b5137a7559f1febf2d8]
stable/5.15: [68fc0b6cc03ca58060c0f36454e169f5fe258974]
stable/6.1: [07e0ab81df1790afa35732a4e8e07ff831b29008]
stable/6.12: [67097772df7791c53d608f04bd31c676ccf79b83]
stable/6.18: [297243e365fc9fe2f8e9b7dd535a65d922cd108b]
stable/6.6: [9136a08dc29328edd9867f2545e73906ac9df93b]
stable/7.1: [927d4805aea0a287d36dd4f826ee24d69a2afee3]

CVE-2026-64382: smb: client: fix double-free in SMB2_open() replay

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64382

Introduced by commit 4f1fffa ("cifs: commands that are retried should
have replay flag set") in v6.8-rc2.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [b55e182f2324bc6a604c21a47aa6c448f719a532]
stable/6.12: [3196b5192f246df4272072f61a2f4a3e9967f55d]
stable/6.18: [14498ff5ce0f272ce0ef988721413e06b7038972]
stable/6.6: [02bc2896bdc3e29362d6e40d404006944a159c25]
stable/7.1: [ff2d30927bc3bf3c629f0768d2068096e64ef5ce]

CVE-2026-64383: smb: client: fix double-free in SMB2_flush() replay

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64383

Introduced by commit 4f1fffa ("cifs: commands that are retried should
have replay flag set") in v6.8-rc2.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [4be31c943a3a27a5a0251dbb8f5cb89059ec3d5a]
stable/6.12: [878757163eea684750107a31ea134c103863515d]
stable/6.18: [3407240cde132a4b72d6429a2625a09a2f78adaf]
stable/6.6: [6e27f40b682a5e42a2daae3ce6d96f0e0e16dedb]
stable/7.1: [013a9a3da46c5dabcf18f65ea6a47874ba12a15d]

CVE-2026-64384: smb: client: fix change notify replay double-free

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64384

Introduced by commit 4f1fffa ("cifs: commands that are retried should
have replay flag set") in v6.8-rc2.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [145f820dcbb2cced374f2532f8a61a44dce4a615]
stable/6.12: [d684f4134998085702009b94c35c2003fc9e72d3]
stable/6.18: [52af1975f0dfae990c5a0e85872cc41be0e88a68]
stable/6.6: [5821f9dbb8b5b24391850a13418e633edd0fb003]
stable/7.1: [901891513951bc8322ece754863909ea45af95c6]

CVE-2026-64385: smb: client: fix double-free in SMB2_ioctl() replay

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64385

Introduced by commit 4f1fffa ("cifs: commands that are retried should
have replay flag set") in v6.8-rc2.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [f9bbadb6c94583e3b4af1afc449bfceb1d1ddec9]
stable/6.12: [96fcfc8ae7359346156e492ca610e830d2649ad6]
stable/6.18: [276c8efbc49f9303ac76d0d4deab7128581b0f3b]
stable/6.6: [0be4bc64882edaefaaee8d1e27d083643eb778e6]
stable/7.1: [fc65ffb4ef1bf540da16b17c225ae51091e07d72]

CVE-2026-64386: smb: client: fix query_info() replay double-free

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64386

Introduced by commit 4f1fffa ("cifs: commands that are retried should
have replay flag set") in v6.8-rc2.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [2a88561d66eb855813cf004a0abe648bbb17de5e]
stable/6.12: [3c81dda84799f76b42aec598564316e2964440db]
stable/6.18: [f1add4acb656f5a82806a1ab0e63fed3d8b1bfca]
stable/6.6: [100fb7c455fa86d248b8bd7bb9de757c192870b4]
stable/7.1: [89234773e8348918111aa15f6922b58cf3843364]

CVE-2026-64387: smb: client: fix query directory replay double-free

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64387

Introduced by commit 4f1fffa ("cifs: commands that are retried should
have replay flag set") in v6.8-rc2.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [9647492b5e41954be59d5157eddbcd4cdc1656f7]
stable/6.12: [1665f25b1dea30bf2d02e16245d203a944c9d994]
stable/6.18: [00b0fa425941438b664950a8ee65dfba2def4336]
stable/6.6: [3409aedf3c81a810243da94164f6621c9d205c98]
stable/7.1: [3317a5d015fca976475aa71df224056777316fde]

CVE-2026-64388: smb/client: fix chown/chgrp with SMB3 POSIX Extensions

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64388

According to the .vulnerable file, this bug was introduced by commit
b326614 in v4.18-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [760ef2c579c2609cf17fb1cd5392f64d42d43d33]
stable/7.1: [550cfb8a81181331d4d0f76ab75ee58a0bf41e3e]

CVE-2026-64389: ksmbd: validate NTLMv2 response before updating session key

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64389

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Introduced by commit f9929ef ("ksmbd: add support for key exchange")
in v5.17-rc4.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [954d196bebb2b50151cb96454c72dc113b2af1ac]
stable/6.18: [b56400364aed5c34d6e1a0b493081290a5328a9c]
stable/7.1: [89ca7756d5566ba636bb9092cdbe57dab095e136]

CVE-2026-64390: ksmbd: track the connection owning a byte-range lock

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64390

Introduced by commit f5a544e ("ksmbd: add support for SMB3
multichannel") in v5.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c1016dd1d8b2bcd1158bbaabe94a31bb7e7431fb]
stable/5.15: [22d38cf75b556c20b039743bdf3654d535b858be]
stable/6.1: [66eb3643164e5e1029907793926c132f8b5c6148]
stable/6.12: [fe20d492a69a6f79e637f438072b212e21ed3b78]
stable/6.18: [427faaa52b0b399940c1a88065a5c310d10dad15]
stable/6.6: [ea5c9bf99f626a15cc59f645dc895f2b3f01992e]
stable/7.1: [5fecc15a30cb9ebd310f7b52c1ab607edcea78f6]

CVE-2026-64391: ksmbd: use opener credentials for ADS I/O

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64391

According to the .vulnerable file, this bug was introduced by commit
f441584 in v5.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [baa5e094886fffa7e6272edcb5e08be5ce28262c]
stable/6.12: [a8f5d39971bbad9340d49cd41b0e2da9452a649d]
stable/6.18: [2b4592cea214683de0f2ce6f8c22c097fb0ea1ab]
stable/7.1: [52a56cf53ec834c44ac1b4d16d585f26613ee5ce]

CVE-2026-64392: ksmbd: use opener credentials for delete-on-close

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64392

According to the .vulnerable file, this bug was introduced by commit
f441584 in v5.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [52e2f21911158ec961cd5aae19c56460db382af0]
stable/6.12: [18c59109bb6fb816d5102171666f87cf1e29901d]
stable/6.18: [e72c15085b6d86f45d224d98aa75b5cace4aaab9]
stable/6.6: [f08b3f451f12eee4abd8a5981803bc36db84458b]
stable/7.1: [4b7059974549d278e30fe70e2a4e421f9839817d]

CVE-2026-64393: ksmbd: run set info with opener credentials

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64393

According to the .vulnerable file, this bug was introduced by commit
e2f3448 in v5.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b383bcad3d2fe634b26efbce53e22bbb5753a520]
stable/6.1: [5cbabf3a71575cd31bc7785d92d4ab42338a654b]
stable/6.12: [0ce682867fd506f61f40c76bde7e4205bde34e87]
stable/6.18: [20ee516a62989a8d505ee432f9e59525ea23984e]
stable/6.6: [b35afd5cf8fab236ef21117e42ee45691d4ffa7b]
stable/7.1: [8cc9ec711f5255167247a9ab6a7179b787426ed7]

CVE-2026-64394: ksmbd: add a WRITE_DAC/WRITE_OWNER check to SMB2
SET_INFO SECURITY

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64394

According to the .vulnerable file, this bug was introduced by commit
e2f3448 in v5.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [44df157a1183a7f746caa970c169255da5ac61f8]
stable/6.1: [0848b1d8b403f530878195dcbe241a2fddb9d0e1]
stable/6.12: [9ab2ffd3ed3d4ca1667c52de27026ddabc11e537]
stable/6.18: [f56535db508ead8dec1c481ad93d7d8acd8f8f1e]
stable/6.6: [e6aa731f1b4b3e08caebf66a99f04b22bdab2e99]
stable/7.1: [aae600cdaffc6d9ce97645f129799a103a97d06d]

CVE-2026-64395: ksmbd: require source read access for duplicate extents

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64395

According to the .vulnerable file, this bug was introduced by commit
eb81736 in v5.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cedff600f1642aa982178503552f0d007bc829c8]
stable/6.1: [2d2ab6983620c2d60ce7db72133984ca3873b929]
stable/6.12: [b0d4d5cb846a1ddb7aaab9adfb5986e4540e6e5f]
stable/6.18: [db231af842868268839f9f9619c68cb27830d8be]
stable/6.6: [67bdad9cf01b25030e3bf00bbce6c309319d6663]
stable/7.1: [a10942af27832c2761d020863a46e79bebe0567d]

CVE-2026-64396: ksmbd: fix UAF of struct file_lock in SMB2_LOCK
deferred-lock cancellation

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64396

According to the .vulnerable file, this bug was introduced by commit
e2f3448 in v5.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d20d1c8ba5765d1d12eefc0aee6385ab3f240e1e]
stable/6.1: [367c42a611fe488b7b03f1f6737f4dee0e8b20a2]
stable/6.12: [463bbd79698513af4dad50fe1c573825f297ca2e]
stable/6.18: [5aa1cb01155f96824003baf7997cdf1f150caba3]
stable/6.6: [7703fd9aba1f2483c8e55f9ff73b7663e0761ed9]
stable/7.1: [5c75275c0fc9a2deb0d8f5604edcb16f288171c8]

CVE-2026-64397: ksmbd: serialize QUERY_DIRECTORY requests per file

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64397

According to the .vulnerable file, this bug was introduced by commit
e2f3448 in v5.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be6d26bf27499977c746abc163659915082348d8]
stable/6.1: [1426fd79102539bc0ab5c8fced047ad4313b9908]
stable/6.12: [64dac2d486ec1eb18dc00968b16a230b6b75ec24]
stable/6.18: [a1d5d31cad593ea5e1b637f2f39c9ef6d09d1199]
stable/6.6: [2a64dbf9c739ddf7a25a066507597bf89f8f73d2]
stable/7.1: [fd22b039a5a05bc1d6818e9dcd1001fb432a829d]

CVE-2026-64398: ksmbd: add a permission check for FSCTL_SET_ZERO_DATA

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64398

According to the .vulnerable file, this bug was introduced by commit
e2f3448 in v5.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3320ba068198adc144c89d6661b805acce01735b]
stable/6.1: [25377f369688dd0bd814dc8965ed26d44238ecaa]
stable/6.12: [ca53bb17f4e8232cfaece3953d3cef62c559b039]
stable/6.18: [57f2042fd87d7ce8fc3ac8b6c176e554df68b1a7]
stable/6.6: [3072d82461f498c85daea8766e9d8bfbada31605]
stable/7.1: [deffa929086d7902e30918adf3dd27ccfe9c08b1]

CVE-2026-64399: ksmbd: add permission checks for FSCTL_DUPLICATE_EXTENTS_TO=
_FILE

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64399

According to the .vulnerable file, this bug was introduced by commit
eb81736 in v5.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [388e4139db27a9e3612c9d356b826f5b1ff6a9e3]
stable/6.1: [bf460ad5958d506492de4524a656439da3f99c51]
stable/6.12: [9b9cf7e65cbeaae1b6636144bacee611cdd7a5d6]
stable/6.18: [baae7b39673ec21073a25e3d14f8feaada01d5df]
stable/6.6: [620d133d469295ee7c017ca6aafac335f65c4a5a]
stable/7.1: [c917e4522d251071dde9871b9142d8ea1186ebfe]

CVE-2026-64400: ksmbd: prevent path traversal bypass by restricting
caseless retry

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64400

According to the .vulnerable file, this bug was introduced by commit
74d7970 in v6.4-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [54bab9ba5a9f156ffa9324fcbe5a356fd0242f95]
stable/7.1: [8c9a4f1327eb71efbf14842e7b8a6d965077eb67]

CVE-2026-64401: smb: client: resolve SWN tcon from live registrations

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64401

Introduced by commit fed979a ("cifs: Set witness notification handler
for messages from userspace daemon") in v5.11-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec457f9afe5ae9538bdcd58fd4cb442b9787e183]
stable/5.15: [34ed271d558523bb54f5a95d863e14147d0c2533]
stable/6.1: [51d18db392e5386a7bb9e816d611f14e600cca3c]
stable/6.12: [945b4a4a54497db1dcb2f20ef801a84e884dac21]
stable/6.18: [91b8a58c6ac15c7db6518f696389933282f88da7]
stable/6.6: [aa3c0cab4b28c5007ec570c63e1d6ad6943ed0fd]
stable/7.1: [0700f946659d0ab2352ec8a9b1c6fc74b13a27d7]

CVE-2026-64402: coresight: ultrasoc-smb: Fix OOB write in smb_sync_perf_buf=
fer()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64402

Introduced by commit 06f5c29 ("drivers/coresight: Add UltraSoc System
Memory Buffer driver") in v6.3-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98495b5a4d77dd22e106f462b76e1093a55b29a7]
stable/6.12: [4c5a0a946373da99a80398289b28845b5ae40cd1]
stable/6.18: [661a019ac0413ecec9e5d1dfcc12fbca8e78d5fb]
stable/6.6: [38dbc8db8341ccdf8e1e1a067453d33ad751864b]
stable/7.1: [daf6246ab988fc8bdc82ad7c8d0b1c182d11b15f]

CVE-2026-64403: Bluetooth: L2CAP: validate option length before
reading conf opt value

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64403

Introduced by commit 7c9cbd0 ("Bluetooth: Verify that
l2cap_get_conf_opt provides large enough buffer") in v5.1-rc1.
Fixed in v7.2-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [687617555cedfb74c9e3cb85d759b908dcb17856]
stable/5.10: [cca81b4bc672604a84f6d224a55cc77ec7dee619]
stable/5.15: [f70d4aa88068096f35d73e3a05eff33c0a16b9cd]
stable/6.1: [7d871e969b941ce25653f7716203a0ea4d07ad4b]
stable/6.12: [996d3da39899aceb8f4910911a3f19a45a7d9d1b]
stable/6.18: [73abbaf91aa33da87c008fb62c148ade561bb606]
stable/6.6: [98d93c226bdfaa79bbdd86981921d7f106374225]
stable/7.1: [6b47bdaacfd0045687880177e0987055d8f4765a]

CVE-2026-64404: Bluetooth: ISO: avoid NULL deref of conn in iso_conn_big_sy=
nc()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64404

Introduced by commit 7a17308 ("Bluetooth: iso: Fix circular lock in
iso_conn_big_sync") in v6.13-rc3.
Fixed in v7.2-rc3.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [d5541eb148da72d5e0a1bca8ecd171f9fc8b366f]
stable/6.12: [b3e647a4aa4d2d054f86a783f5c426035e1dc237]
stable/6.18: [b84eeb7636d6962dd882d5e0b31475e4f404313c]
stable/7.1: [01afd198c2c286cd3b81f44d4e33a2e638711550]

CVE-2026-64405: Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64405

Introduced by commit a13f316 ("Bluetooth: hci_conn: Consolidate code
for aborting connections") in v6.6-rc1.
Fixed in v7.2-rc3.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [12917f591cea1af36087dba5b9ec888652f0b42a]
stable/6.1: [903227b6168bb99fd57d4e3c9c1b5014986198e0]
stable/6.12: [70c397b62ee015e19b3924d9da741c8dda017819]
stable/6.18: [61701912c58a05f6a043f097cc177a964abef348]
stable/6.6: [83b22d7f7c384564fa42c3cf19bec715c693d7a2]
stable/7.1: [b42cb640a0493d16b61ddd267420274be15efdc1]

CVE-2026-64406: Bluetooth: fix UAF in bt_accept_dequeue()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64406

Introduced by commit ab15135 ("Bluetooth: fix UAF in
l2cap_sock_cleanup_listen() vs l2cap_conn_del()") in v7.1-rc5.
Fixed in v7.2-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [4bd0b274054f2679f28b70222b607bb0afc3ab9a]
stable/5.10: [c0577c55219be42b6ea2ea8db11e85bfab6f4e8d]
stable/5.15: [96ad400d5132eb333f28f6f1e2d58f0728ca9547]
stable/6.1: [0a98ff4e7b867f72fbb4e1237d81e9fa02ded0a0]
stable/6.12: [6303ed4bbe0095f4cc195225479bf506e010d1db]
stable/6.18: [26168db1ce5a9766cde021b18e590a101c056614]
stable/6.6: [c66a95e60b65d876a927123b0ed36bd6177d9ca6]
stable/7.1: [50c662bdcd51b03033a0abed6716bfd377ba1049]

CVE-2026-64407: Bluetooth: btnxpuart: Fix out-of-bounds firmware read
in nxp_recv_fw_req_v3()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64407

Introduced by commit 689ca16 ("Bluetooth: NXP: Add protocol support
for NXP Bluetooth chipsets") in v6.4-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [badff6c3bed8923a1257a853f137d447976eec30]
stable/6.12: [441088792ffec3ca01f4efe2934060570eb11eb8]
stable/6.18: [2a68a773089204af1c8581dc79668b775418c5ee]
stable/6.6: [21e60eb4d95854196e7c0e77383f35e7ac95df61]
stable/7.1: [49bcb39e3a041ce26021f77971eaccb49a275118]

CVE-2026-64408: Bluetooth: bnep: pin L2CAP connection during netdev registr=
ation

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64408

Introduced by commit 65f53e9 ("Bluetooth: Access BNEP session
addresses through L2CAP channel") in v3.13-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bb067a99a0356196c0b89a95721985485ebce5a5]
stable/5.10: [390b5db3ff8745187f094c4e915663b7b1f98944]
stable/5.15: [46a88784c4c9b96954dd86f747ce93f65efa1302]
stable/6.1: [551ae773ec64045b4e72099132654887e0270bcc]
stable/6.12: [df22adc7eafc22e651561813c11dc51a796b12ee]
stable/6.18: [a6b22dbd80926556290ad2243be25218d6956a19]
stable/6.6: [ae215c5b6422d8eda443b861b124bd1be6969c31]
stable/7.1: [563a8573047182f550b1e1e030615755cd8c41da]

CVE-2026-64409: Bluetooth: btmtksdio: fix infinite loop in btmtksdio_txrx_w=
ork()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64409

Introduced by commit 26270bc ("Bluetooth: btmtksdio: move interrupt
service to work") in v5.17-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a257407e2bbbb099ed427719a50563f67fa366d8]
stable/6.1: [f6682c23b6fac4780d297ae4662053d17e58fd52]
stable/6.12: [7b429d611060e87752e848851815537963726493]
stable/6.18: [0039bdde36b23ccf1196635f1d52c5490481544d]
stable/6.6: [466540e045d01fcacf383a5beb8a2dad2fc53a26]
stable/7.1: [0f0a83e26a9c7fd4b243c315ce07161d2496d83d]

CVE-2026-64410: netfilter: flowtable: IPIP tunnel hardware offload is
not yet support

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64410

Introduced by commit d981035 ("netfilter: flowtable: Add IP6IP6 rx sw
acceleration") in v7.0-rc1.
Introduced by commit ab427db ("netfilter: flowtable: Add IPIP rx sw
acceleration") in v6.19-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6c5dcab95f4cd42a1648739ec9300fbb4b1a021f]
stable/7.1: [9efe838c13133acb70c78d04c49e8362fe533566]

CVE-2026-64411: netfilter: ebtables: terminate table name before
find_table_lock()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64411

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Introduced by commit 81e675c ("netfilter: ebtables: add CONFIG_COMPAT
support") in v2.6.34-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a622d2e9608c9dff47fc2e5759ac7aa3a836b45d]
stable/5.10: [4c046ca4e35a83ea32f6e748f54139f5fe2a1d01]
stable/5.15: [ab63ccefb9c71627f957a0724c2b9ebc869c6f20]
stable/6.1: [c6f539311e58e76aa96feef0f1572b13a564f8a2]
stable/6.12: [7436da6c1bc44654b7f11a17e746f6999fd37250]
stable/6.18: [6fe8d3cecd20bfaaaf440db3a06ba674d2f2e322]
stable/6.6: [2664f537ca5bcb2ef3fac2683dcca602e51fad24]
stable/7.1: [b6183b1b88a722b6d8ea0cecc99eba168a15e0be]

CVE-2026-64412: netfilter: ebtables: module names must be null-terminated

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64412

Introduced by commit bcf4934 ("netfilter: ebtables: Fix extension
lookup with identical name") in v4.6-rc5.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [084d23f818321390509e9738a0b08bbf46df6425]
stable/5.10: [43dd2332b8a27b3ac5108791680cade654ab0f96]
stable/5.15: [5777c8f1c3610786d8482b8f620f40fccaf1542b]
stable/6.1: [0ddca0f90fa3395111d078ae4399615cf3ea94aa]
stable/6.12: [da32e78bbb187ed7b137e0007034185570a3a172]
stable/6.18: [13a5f532e3a4fc75c33060a026def1572c208643]
stable/6.6: [d2367d99f2455f373996d9ddbe833dbe9f942213]
stable/7.1: [7b217960e88b5d2d1e8cdcbcaf3bdf6fe199a0c8]

CVE-2026-64413: netfilter: ebtables: zero chainstack array

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64413

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cbfe53599eebffd188938ab6774cc41794f6f9d5]
stable/5.10: [2ade612967e2cdfb9290ebcb773f302c82f311fa]
stable/5.15: [42bef500d07b5769d916e9122a3e3fa3fd2245ef]
stable/6.1: [fc7f105451044501a50cfd530cfa3b472c54acbc]
stable/6.12: [29bf41a9b59aff9f6197df58641a00037d567ca8]
stable/6.18: [9f74d28e903fa4fdf82f870d0aeadddc8196e41c]
stable/6.6: [9e6c5169db423e51dcc66a73fd15409c0d38e088]
stable/7.1: [5ee856e4208acafaaaf7b84824d39b78c21345d6]

CVE-2026-64414: netfilter: handle unreadable frags

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64414

Introduced by commit 65249fe ("net: add support for skbs with
unreadable frags") in v6.12-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da5b58478a9c1b85608c9e40a3b8432d071b409e]
stable/6.12: [3b13e7635795394705920cca1e1db7e4ca2e334b]
stable/6.18: [fc5bfe63bacf8a3ae307b62b34206406ca733354]
stable/7.1: [57056be3ec12e7d9ecd20a60d4060f510e4f284c]

CVE-2026-64415: mm/swap: add cond_resched() in
swap_reclaim_full_clusters to prevent softlockup

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64415

Introduced by commit 5168a68 ("mm, swap: avoid over reclaim of full
clusters") in v6.12-rc6.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66366d291f666ddeda5f8c84f253e308de3e6b55]
stable/6.12: [60cbe67d1342f34b66df1c2ee328e3cd333767d7]
stable/6.18: [69c0e6246575b780ae0d3f411c749bcf13c221f3]
stable/7.1: [2a55fdf9f746a1a6ced7fd62ea1080b8a917e0b0]

CVE-2026-64416: mm: swap_cgroup: fix NULL deref in
lookup_swap_cgroup_id on swapless host

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64416

Introduced by commit bea67dc ("mm: attempt to batch free swap entries
for zap_pte_range()") in v6.12-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63b02a9409cb5180398491b093e48bcb5315f5fb]
stable/6.12: [818416fef38759f23210de449663cd9d7e293d39]
stable/6.18: [b415c00bf23df577a4a95673d00ae76687bcc1d4]
stable/7.1: [6a4196d19f477524d2f92adca90fc1fbe9a0420a]

CVE-2026-64417: mm: shrinker: fix NULL pointer dereference in debugfs

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64417

Introduced by commit bbf535f ("mm: shrinkers: add scan interface for
shrinker debugfs") in v6.0-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e30453c61e185e914fde83c650e268067b140218]
stable/6.1: [ebb45c2648b1f60715fd283700f651e05e431231]
stable/6.12: [36f8534f461222291a74156ab91f3ba9f09b6f93]
stable/6.18: [006467ab932698612398f853344a7405164541f4]
stable/6.6: [09d2407985b8ce3e831f9d4310fe7ac06a6b3ae9]
stable/7.1: [b9beed2322f3538b0d2d53307062da4102b8d8d8]

CVE-2026-64418: mm: shrinker: fix shrinker_info teardown race with expansio=
n

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64418

Introduced by commit 307bece ("mm: shrinker: add a secondary array for
shrinker_info::{map, nr_deferred}") in v6.7-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [65476d31d8056e859c48580f82295ce159196ffe]
stable/6.12: [b9a280a9a454ed514636351d53fe2a233dc5054b]
stable/6.18: [6465ff3ce65131c774a312d450abe10f4b9f3875]
stable/7.1: [284c267f013e45d8c89d9fb9373105dc8e6c0947]

CVE-2026-64419: mm/shrinker: do not hold RCU lock in
shrinker_debugfs_count_show()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64419

Introduced by commit 5035ebc ("mm: shrinkers: introduce debugfs
interface for memory shrinkers") in v6.0-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b902890c62d200b3509cb5e09cf1e0a66553c128]
stable/6.1: [de5f69b8dae8698ac5e48dfcd30017887cdf4e5a]
stable/6.12: [2fed79f0fe8c8d28a972c290dbfd693c3546c8c4]
stable/6.18: [560e21e8ccff813e84d05f6500907c549a3d6985]
stable/6.6: [e441cbfbd0eaa6404278e985033c33caba4db767]
stable/7.1: [86237e56091e70f09c0fbf217f9d9c0e08f556c4]

CVE-2026-64420: mfd: cros_ec: Delay dev_set_drvdata() until probe success

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64420

Introduced by commit 1c1d152 ("platform/chrome: cros_ec_dev - utilize
new cdev_device_add helper function") in v4.12-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b2c1d41bc36c100b38ce5ee6def246c527eaf8a]
stable/5.10: [24522713034d521ea4b5f5f36342e2b2f7e73bd6]
stable/5.15: [f7e81dc181d9fe8ab977158042cd193e8cc12091]
stable/6.1: [257203d83204b192d1265a916b42ca0d499bb117]
stable/6.12: [ed2941e5db016a0c600b25f1972620e6e223d9fa]
stable/6.18: [b5f41d5bf08e7b1b14fa0bd640975e6d78dc006d]
stable/6.6: [729ae27dc2503a7c1f92da1859efb45da03e4fa0]
stable/7.1: [fc030c5b116f668d4ca86dca63742ddbc98d1665]

CVE-2026-64421: media: nxp: imx8-isi: Fix use-after-free on remove

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64421

Introduced by commit cf21f32 ("media: nxp: Add i.MX8 ISI driver") in v6.4-r=
c1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b670bf89824ede5d07d20bb9bfbafb754846081d]
stable/6.12: [ba2aa5d325270cd965c44458c5ff5ab555e6af51]
stable/6.18: [ef382a6baf0a95cf199fdf6bba2fd08e58b0a249]
stable/6.6: [d22fb719654bfde6f682c9f14629f5f9534175b7]
stable/7.1: [c12a5b2261351cd3b03921ce4720332ff5184b50]

CVE-2026-64422: net: ipv4: bound TCP reordering sysctl writes and MTU
probe sizes

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64422

Introduced by commit 91cc17c ("[TCP]: MTUprobe: receiver window & data
available checks fixed") in v2.6.24-rc4.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [efb8763d7bbb40cff4cc55a6b62c3095a038149c]
stable/5.10: [f0d88a4cd03affff6c08adf6c63964e235aede43]
stable/5.15: [27ddf4486c7dbf5bdd393fa8bef6b67179796d98]
stable/6.1: [782708ca1ea1f68b8cbb5ea3a7f5f18d0000efae]
stable/6.12: [99206ce2244f8a3ed64298d0667c9055845a5dc7]
stable/6.18: [bbae351c0f32f7c200249e4aa6561b2b419dcf69]
stable/6.6: [e81f805824a8109504fce090641b17d135b48cd1]
stable/7.1: [a094ac95d3b69adfa1676eb9c8eae6835d4f1671]

CVE-2026-64423: ipv4: igmp: remove multicast group from hash table on
device destruction

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64423

Introduced by commit e989707 ("igmp: hash a hash table to speedup
ip_check_mc_rcu()") in v3.11-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7993211bde166471dffac074dc965489f86531f8]
stable/5.10: [412ba7def06ffe974ba9a1d862b022362c54ffa5]
stable/5.15: [c6cb5f8ebe1c1a78710c19f102db9fe48b9e6ba9]
stable/6.1: [5f42729d74bd6c61306d864423290d92962de4e1]
stable/6.12: [8820b530cb2388503d7418228d03ba074bf7a03e]
stable/6.18: [2ca18df1c2611f70eb3eb487e02ae85eb703b284]
stable/6.6: [76d030ac95e17f91d69a595f17ebc5979700cf9a]
stable/7.1: [f91883031e5a62877a29ce139442973cbea769f1]

CVE-2026-64424: netpoll: fix a use-after-free on shutdown path

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64424

Introduced by commit 38e6bc1 ("netpoll: make __netpoll_cleanup
non-block") in v3.6-rc3.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [45f1458a85017a023f138b22ac5c76abd477db42]
stable/6.12: [95ecc5b58042f6b6743b589e6588f1cd7ba336aa]
stable/6.18: [a33f37f8d079da7236ed7b7e2aed2a34ab81e7cf]
stable/7.1: [5ed09a108d93a3b002cc79823d9455b50c4a8be7]

CVE-2026-64425: io_uring/io-wq: re-check IO_WQ_BIT_EXIT for each
linked work item

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64425

Introduced by commit 10dc959 ("io_uring/io-wq: check IO_WQ_BIT_EXIT
inside work run loop") in v6.19-rc7.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [29bef9934b2521f787bb15dd1985d4c0d12ae02a]
stable/5.10: [14b7ecad2ec56699325180a744f4b19f046401bb]
stable/5.15: [d179533c610e1b4c6aa436e3c1fd1b719d2c727c]
stable/6.1: [6e2f51f3e06773c2ee98ad09738f0908b48f76f9]
stable/6.12: [b6f179a653a934736c88d820fe0098c3c2532549]
stable/6.18: [1636d85dc139b07c0449308f2bb5e0c7a2e0da99]
stable/6.6: [ea61b04e1d7242cb37f5ed2cc91cf21a493f6597]
stable/7.1: [ab85765cbe3258b43dc6729af0e6ce3a87a133d8]

CVE-2026-64426: io_uring/nop: fix file reference leak with IOSQE_FIXED_FILE

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64426

Introduced by commit a85f310 ("io_uring/nop: add support for testing
registered files and buffers") in v6.13-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2564ca2e31bd8ee8348362941af2ee4671e487ca]
stable/6.18: [722869fcff598fad20d5ab79c305897a7534708b]
stable/7.1: [7267717f35787167fcce4bc14f6ef3fa06682dcf]

CVE-2026-64427: HID: logitech-dj: Fix maxfield check in DJ short
report validation

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64427

Introduced by commit b6a5791 ("HID: logitech-dj: Prevent
REPORT_ID_DJ_SHORT related user initiated OOB write") in v7.1-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [590cc4d782487632a52f37c2171bee1eeea29627]
stable/7.1: [7a89ad762fad53d56b7002d7ffc923a4b7f4006f]

CVE-2026-64428: gpio: sch: use raw_spinlock_t in the irq startup path

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64428

Introduced by commit 7a81638 ("gpio: sch: Add edge event support") in v5.13=
-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [286533cb14a3c8a8bd39ff64ea2fc8e1aa0f638b]
stable/5.15: [3b1aa05ec27eeccc889ecaa3f2d9baa9f453e50d]
stable/6.1: [4f03a15cc73c83740fc355ee22b336492d17b4da]
stable/6.12: [a235cec779bb39ec8f961a935b28a2ce278c6c64]
stable/6.18: [4508366ab7dd0c2917a51a9c2e23cc1b9d35157a]
stable/6.6: [7a550256d68bbdfa0903ab1c4595c04a6815493a]
stable/7.1: [41cad91a09d69e8fff4e936db29b1054b4e9f9f7]

CVE-2026-64429: gpio: eic-sprd: use raw_spinlock_t in the irq startup path

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64429

Introduced by commit 25518e0 ("gpio: Add Spreadtrum EIC driver
support") in v4.17-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [90f0109019e6817eb40a486671b7722d1544ae29]
stable/5.10: [96612bf2712cd961dbd9b52f3a9b4ab668f57628]
stable/5.15: [581ac2ad001ff1128931191f249a7f2074672b7a]
stable/6.1: [e244cd8b51001ba480f274c44dba9002813a4739]
stable/6.12: [6112fba4150039ccd90e29f2d1b788c73ad7b3dd]
stable/6.18: [4750909a40da9016185e0ac991510a278cecb1e7]
stable/6.6: [19d63fd528719ce7d06d9aeb88d25b7d6478198a]
stable/7.1: [5c3c9ec1172a4c3384b8b800b3a8896cc2c1b20e]

CVE-2026-64430: NTB: epf: Avoid calling pci_irq_vector() from hardirq conte=
xt

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64430

Introduced by commit 812ce2f ("NTB: Add support for EPF PCI
Non-Transparent Bridge") in v5.12-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4dcddc1c794d1c65eda68f1f8dd04a0fecc0870f]
stable/5.15: [33bba331a4a5fee8b6026fe72eca13cceeec1b7b]
stable/6.1: [aff271b12a1eb8c8b3da19223ae1a6abe1e8168b]
stable/6.12: [174a97f21bf9c54fa37ec0f321692e862ea130a3]
stable/6.18: [f71e8d9875069fa73e335f63f02ec6e52e3aaa51]
stable/6.6: [1dba8444ac0100133d72374634f6d7451fff1ccc]
stable/7.1: [6350df503897d57c5634f71b0767d48c3b837583]

CVE-2026-64431: ntfs: avoid calling post_write_mst_fixup() for invalid
index_block

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64431

Introduced by commit 0a8ac0c ("ntfs: update directory operations") in v7.1-=
rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5b6eedd7cc2936f9238e852b553a1b326105bde8]
stable/7.1: [e2018628301a6d9f54e34b0cb417f1688c66df1d]

CVE-2026-64432: fs/ntfs3: validate Dirty Page Table capacity in
log_replay copy_lcns

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64432

Introduced by commit b46acd6 ("fs/ntfs3: Add NTFS journal") in v5.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [57382ec6ac63b63dce2789e835fded28b698ae79]
stable/5.15: [964c3fae1dfc49dde5468eace940f199cda234e9]
stable/6.1: [3aa96956ca2200674e2a8f9c23ec6ecd45e5010f]
stable/6.12: [c6f9e804f73ef809529865fbc7256dd189ff8c33]
stable/6.18: [cf28fc1658463d768657cf1c27a83980d4ba7ef2]
stable/6.6: [946046841013ebac8492ef49651c53638d7a9a6a]
stable/7.1: [f433acc85b86f327d03ba8b03a33c105c51053de]

CVE-2026-64433: Bluetooth: MGMT: Fix UAF of hci_conn_params in
add_device_complete

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64433

Introduced by commit 1e2e304 ("Bluetooth: MGMT: Fix MGMT_OP_ADD_DEVICE
invalid device flags") in v6.15-rc7.
Fixed in v7.2-rc3.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [fa85d985f614bc3feb343000f14a1072e99b0df1]
stable/6.12: [e4369e4e970f3fa4676b76be14c1d315c87f22b6]
stable/6.18: [b346efa825b5e4386f19bc63f81141652d496ec4]
stable/6.6: [caed4a96d55757c139a899744657c032b6186665]
stable/7.1: [9531014c60c804e16099885d4a98aedcf31bce8d]

CVE-2026-64434: Bluetooth: L2CAP: Fix UAF in channel timeout by holding con=
n ref

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64434

Introduced by commit 8c8e620 ("Bluetooth: L2CAP: use chan timer to
close channels in cleanup_listen()") in v7.1-rc6.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.12 stable/5.10 stable/5.15
stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [b66774b48dd98f07254951f74ea6f513efe7ff8b]
stable/6.12: [0b0e2bf39cf99e458d991b9df253727e036a7d7d]
stable/6.18: [d3b739db5dc6f688a60d56da872fabaf65246032]
stable/6.6: [91047a4396a8b1857a6f712a90cf33ec0012b189]
stable/7.1: [50c38d9f42a529691e4e67ea9cedf4f0bfc8d277]

CVE-2026-64435: audit: Fix data races of skb_queue_len() readers on audit_q=
ueue

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64435

Introduced by commit 3197542 ("audit: rework audit_log_start()") in v4.10-r=
c1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9a71daaecb2fb1d8c704545cc0b1c920b9bf5d7]
stable/5.10: [69f98fff30bdaa72b0cb0e7e078ab6456a0a59b0]
stable/5.15: [b35597bdae1a5d8395da4b9baa993b9b71f74d68]
stable/6.1: [e575dabb805252e3113fdc3f56f6ecacfde422d0]
stable/6.12: [a3d85dec60bb0622360fc176b2a51abdbe2ff0ad]
stable/6.18: [fe997a84a385f840b593ead92e575503a5046cee]
stable/6.6: [7ff42312ccde549f8c698723822c7db35107a39b]
stable/7.1: [c5186201fa7030289cc4fe23fae87a3fcb566856]

CVE-2026-64436: net: af_key: initialize alg_key_len for IPComp states

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64436

Introduced by commit 80c9aba ("[XFRM]: Extension for dynamic update of
endpoint address(es)") in v2.6.21-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d129c3177d7b1138fd5066fcc63a698b3ba415b0]
stable/5.10: [58e82fc3dedb57b1432292504415b224fd2d6acb]
stable/5.15: [01b9115b55018123ef2449ac4951f89147a8428e]
stable/6.1: [3f63d1752d90c0e28be931a48ab5d89bc97d637d]
stable/6.12: [6de2a650917bedaaefd65b17cede83c5e2c1dedd]
stable/6.18: [e8417353cbd078d10531ba3928e609c84ab09e6b]
stable/6.6: [273c06b81d2e902b21acc801ae18c8276c8a9b69]
stable/7.1: [cea34abc94b0a81e3a8b5cfb41cf45af37c2c67e]

CVE-2026-64437: ksmbd: fix use-after-free of a deferred file_lock on
SMB2_CLOSE then SMB2_CANCEL

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64437

Introduced by commit f580d27 ("ksmbd: fix use-after-free of a deferred
file_lock on double SMB2_CANCEL") in v7.1-rc7.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.12 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [10f293a07f9e10e988b0ae44e2e99c631f5a68e0]
stable/6.1: [a796ba4e61d5e14e07b79a359faac69f8f9b22a3]
stable/6.12: [ddb9239828336b36d8a3ef5943fdffb2f55b6508]
stable/6.18: [94083db751930b1540ddff2b54d4677549c57f81]
stable/6.6: [b8e274e69ab09222c7a552c7c0c1eef9ce627fc1]
stable/7.1: [12c36c99655f325befe50c26842f7deca414c381]

CVE-2026-64438: crypto: qat - fix VF2PF work teardown race in
adf_disable_sriov()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64438

Introduced by commit ed8ccae ("crypto: qat - Add support for SRIOV")
in v4.3-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [277281c10c63791067d24d421f7c43a15faa9096]
stable/5.10: [218c2836b3987f3fa1d9eac505462cded0821e4c]
stable/5.15: [446b4d77599cf1a168573f7fb32a4a6aa4f09219]
stable/6.1: [5d916c1eae1933511a69bffe243b4ee5d7da399c]
stable/6.12: [51144032248cc4ea22917370565650670b8b4e9b]
stable/6.18: [49cd5ac6de8de39a14ead609bb552d372d5602cd]
stable/6.6: [f344a369d0380d54c8d6c8d24734a78dd5a89817]
stable/7.1: [6e92b28cd74fa433658efeadf21b9d4b01023d7d]

CVE-2026-64439: crypto: krb5 - filter out async aead implementations at all=
oc

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64439

Introduced by commit 00244da ("crypto/krb5: Implement the Kerberos5
rfc3961 encrypt and decrypt functions") in v6.15-rc1.
Introduced by commit 6c3c0e8 ("crypto/krb5: Implement the AES enctypes
from rfc8009") in v6.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6c9dddeb582fde005360f4fe02c760d45ca05fb5]
stable/6.18: [ef6feb77e2d91761427c5b773edc9c97e1b706ad]
stable/7.1: [2b7bd6dccff14b8b632c5244f1fd506918077221]

CVE-2026-64440: staging: rtl8723bs: fix OOB write in HT_caps_handler()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64440

Introduced by commit 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in v4.12-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8001e1a516ba3b495728c65b61f799cbfad6bd0]
stable/5.15: [37f642d47c3648a707df3ceb092eee1adffbfd28]
stable/6.1: [8c872b47c7fc32e95e0da1db7512388794adcd69]
stable/6.12: [918537a0fbed85aab61fa28ad75e6279070610c9]
stable/6.18: [6f91621fc45025ad3c0be796b70e6e4cee22fc69]
stable/6.6: [bb3b942da4123b55d1cacf19d1a7d5ba15dbf83a]
stable/7.1: [225b6d3fc7e99ac3d20b6c861d1e47d24e7ea31d]

CVE-2026-64441: staging: rtl8723bs: fix OOB reads in rtw_get_sec_ie(),
rtw_get_wapi_ie(), and rtw_get_wps_attr()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64441

Introduced by commit 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in v4.12-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1463ca3ec6601cbb097d8d87dbf5dcf1cb86a344]
stable/5.15: [efa27d487abcdec79669a60a6d94d5d6eceb7c1d]
stable/6.1: [2ea1ce30ead61589214240e8d33d96310fd613e5]
stable/6.12: [6ab1161e539fb7a1c8b35ff5a6ced4702e855b9c]
stable/6.18: [4b51ee8a40fe47864197d73cc02b191de7a6b072]
stable/6.6: [b27ecba3196f6c14e3809595ebd69c0c2392512a]
stable/7.1: [729c4e72563bda0f1725db1db9ea08df06f41d9b]

CVE-2026-64442: staging: rtl8723bs: fix OOB reads in IE loops in
issue_assocreq() and join_cmd_hdl()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64442

Introduced by commit 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in v4.12-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef61d628dfad38fead1fd2e08979ae9126d011d5]
stable/5.10: [bc881c9915c4468747d0ca5fd1abd7b313cfb0f4]
stable/5.15: [605ebd94d0f469204f3c9f2f84acc71e43e2780f]
stable/6.1: [a830bdc82461353bf7b1f8a2ad2689bf5d2de444]
stable/6.12: [ad2637c46ef8b8ae0894372a2d39fdfcdc420a1e]
stable/6.18: [c38d16b1ffac385c9e4b38447cd5c46af1114b58]
stable/6.6: [4c21eec80cf502d9ea18e0b946246b2376452786]
stable/7.1: [402f13ec95945f34a210b28df1f8740d3d4a58c5]

CVE-2026-64443: staging: rtl8723bs: fix OOB read in update_beacon_info() IE=
 loop

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64443

Introduced by commit 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in v4.12-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ed51de4a86e173c3b0ef78e039c2e49e08b11f16]
stable/5.15: [5e8db4cff5b45c7c4edc8ae3f302027c3bb32b25]
stable/6.1: [6dd5e8c3011ebabf417257d7f07901a7c4311539]
stable/6.12: [bd953d52d587d42365e399b96c52dbdb13032070]
stable/6.18: [69f174a0673b6b7a29b851adb60bc450cdc0ecc4]
stable/6.6: [9193c34f75fd9e1ea8a590d7cced464c3380dc29]
stable/7.1: [b5cc2f999927f69723ca53f1f2a3aa37dbeda907]

CVE-2026-64444: staging: rtl8723bs: fix OOB read in OnAssocRsp() IE loop

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64444

Introduced by commit 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in v4.12-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9654207e92283e0acac5d64fe5f8835383b5a23]
stable/5.15: [889ca6000ac7fa73457b041848fcb08e0d51b809]
stable/6.1: [1a52a05471494546f955a58e8c170c0c796c52d5]
stable/6.12: [0970dd47726a57e52013594e9fbf667586eb3673]
stable/6.18: [04f612dc03427e0b1ac80a2611b5ac0ba93ac446]
stable/6.6: [0406d746574e875d8778552eb674fcfbf5330bfb]
stable/7.1: [7e7741c8315e4160aead00a60cdd6f81ab880717]

CVE-2026-64445: staging: rtl8723bs: fix WEP length underflow and OOB
read in OnAuth()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64445

Introduced by commit 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in v4.12-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a1fc19d61f661d47204f095b593de507884849f7]
stable/5.10: [665e1ecb68b4e8419604e70a33f02d1c8b0222c6]
stable/5.15: [87cccc2a767f17dcab71e3b9fe5ae29b5516c5ce]
stable/6.1: [c9000c93078e5c0a5a651b077c0ec92a4bc7d580]
stable/6.12: [3e44a7665f3abd320a80d9c64ee4a93317041b8b]
stable/6.18: [64ec4192d9c10e96922245d4a6747304cc76b19d]
stable/6.6: [1f6c9d255bdda41216b6e34c96aa2b1abee0bb84]
stable/7.1: [d90b9f39f375c9826ef145605dfe97765d0ecb91]

CVE-2026-64446: staging: rtl8723bs: fix heap buffer overflow in
rtw_cfg80211_set_wpa_ie()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64446

Introduced by commit 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in v4.12-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5a752a616e756844388a1a45404db9fc29fec655]
stable/5.10: [a94a643a80a84ceb8139061c3d6bf988d75e45a5]
stable/5.15: [2131621986c62c86109ce4d84cf73a73757eb8a6]
stable/6.1: [6f20d7b0ee47c470734a69379b0fc6647c519603]
stable/6.12: [46f66c16a95191d9aca07a72ae6b1252a244e26c]
stable/6.18: [b9c4bf133c3c47e23baf4f5403b98a953bf58606]
stable/6.6: [5d7812360abf3143afcbf5efe4ef242448fa1f28]
stable/7.1: [138cd190efd56ab36c9fdd8fef8749d06937f24b]

CVE-2026-64447: staging: media: ipu7: fix double-free and
use-after-free in error paths

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64447

Introduced by commit b7fe4c0 ("media: staging/ipu7: add Intel IPU7 PCI
device driver") in v6.17-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3a9a8cf2d7fd61a2f63df61f6cbc0a9bb007cc0]
stable/6.18: [b5ddc7257bee71f5b8cf9083e2b0ac0427e9fbb3]
stable/7.1: [837c1f9655421055f751ed34745e820a54a27642]

CVE-2026-64448: smb: client: restrict implied bcc[0] exemption to
responses without data area

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64448

Introduced by commit 093b2bd ("CIFS: Make demultiplex_thread work with
SMB2 code") in v3.6-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [53b7c271f06be4dd5cfc8c6ef552a8355c891a7f]
stable/5.10: [8d0bbc78046d264bbf6a574ea6f9072258a43e35]
stable/5.15: [b6a381c01e2ac98a48e32ac0f2a45bbadd9e26b0]
stable/6.1: [31c6312608c60b72a1feb99a5afb680645a3e8a3]
stable/6.12: [419ec1b604d7fb60c10aec2dc062371f9fcd4940]
stable/6.18: [ceb875a375dedbf51c9425c1d13a2d7a8435c08c]
stable/6.6: [573e502d14714d2947e22e7eff40ec20a6a44a42]
stable/7.1: [6e9d10f62773b99bd927940fd9cbdfe7207e23ff]

CVE-2026-64449: staging: vme_user: bound slave read/write to the kern_buf s=
ize

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64449

Introduced by commit f00a86d ("Staging: vme: add VME userspace
driver") in v2.6.32-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f32f38265014fac7f5dc9490fb01a638ce6e121]
stable/6.1: [65358d89dc9f1c25d9364b2b3ef0f3b47717f9ed]
stable/6.12: [8eff7cd4817e14dbe3b9952cce55ef52d1d38940]
stable/6.18: [e99f2df433c63c86c93de1e5f08f16e404388756]
stable/6.6: [adc8b9c30d716c362646edb45662aa1c641a154a]
stable/7.1: [1b495fa0d4927c88d88bf346bf311f2e26e860ed]

CVE-2026-64450: tipc: fix out-of-bounds read in broadcast Gap ACK blocks

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64450

Introduced by commit d7626b5 ("tipc: introduce Gap ACK blocks for
broadcast link") in v5.8-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b66974a1b6134a4bbc3bfed181f7418f688eb54]
stable/5.10: [055663d21dc4336f67933ab26bef3c5934be6324]
stable/5.15: [016f5995c37a5a2c45198308f830f244517d70b7]
stable/6.1: [74b45af86a767594ba52330cd440ea84e24d700d]
stable/6.12: [a21ed5064217cc33726da6c7ef1a520eba43aea1]
stable/6.18: [2de42e268174766cb2e2b90721afdfdff70e0d8d]
stable/6.6: [9a51115fcdc78687c8852bf93a1db3951dbb223b]
stable/7.1: [f333b6851bdf326fd2134133272dbbed0c94d921]

CVE-2026-64451: tracing: Fix NULL pointer dereference in func_set_flag()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64451

Introduced by commit 76680d0 ("tracing: Have function tracer define
options per instance") in v6.19-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c3e94604675e3db186111b8942650d86577df9b0]
stable/7.1: [69f17ac132a38974cf1defb480cef6b79d1ab768]

CVE-2026-64452: 6lowpan: fix NHC entry use-after-free on error path

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64452

Introduced by commit 92aa7c6 ("6lowpan: add generic nhc layer
interface") in v4.1-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1720db928e5a58ca7d75ac1d514c3b73fd7061a7]
stable/5.10: [9c2f5c0829a8c8b904dae36be6d8056b719ac605]
stable/5.15: [80b5c8779acee0550845394fb3e5176a398aa24c]
stable/6.1: [cc27aea4d454abfb385ee2c9499c78b96db9b728]
stable/6.12: [593b78bb3c7ef0c6e9ae6fdf5afa80a5f7573168]
stable/6.18: [0beccbcf50de125be5520d0ffc59af4bb8655482]
stable/6.6: [a8e3a94711134e898c6021a6b77374efa91b3639]
stable/7.1: [b713aa0cc344f10f7a9928a230b5f5e780d04078]

CVE-2026-64453: usb: misc: usbio: fix disconnect UAF in client teardown

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64453

Introduced by commit 121a0f8 ("usb: misc: Add Intel USBIO bridge
driver") in v6.18-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0bfeec21984fedd32987f4e4c0cde34b445af404]
stable/6.18: [c40090f8d19b415e2925b22be964b5d1f695666f]
stable/7.1: [1947b6411460d68b54b13c536961933166937d05]

CVE-2026-64454: usb: dwc3: run gadget disconnect from sleepable suspend con=
text

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64454

Introduced by commit c854087 ("usb: dwc3: gadget: Improve
dwc3_gadget_suspend() and dwc3_gadget_resume()") in v6.4-rc3.
Fixed in v7.2-rc3.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [010382937fb69892b3469ac4d30af072262f59e8]
stable/5.15: [b399be2958456efe1b64b19c55a54a24e9035769]
stable/6.1: [48958478cb8dbc429a5b19f36e866b63d6297d1d]
stable/6.12: [e0e4f15d4225fb7156cc0e3c21eb8953114f9b89]
stable/6.18: [c4e232bd07fe2b69a6e5c380db41dd36b95e0524]
stable/6.6: [5e5798880eb1533a7de6fb68eb14b2d8202ebf76]
stable/7.1: [642e04f5c292d04070ae6e4374fbf14cc40a2465]

CVE-2026-64455: USB: chaoskey: Fix slab-use-after-free in chaoskey_release(=
)

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64455

Introduced by commit 66e3e59 ("usb: Add driver for Altus Metrum
ChaosKey device (v2)") in v4.1-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [abf76d3239dee97b66e7241ad04811f1ce562e28]
stable/5.10: [fe7a0f4be283b40dd592540027279735120d0d6f]
stable/5.15: [5ec61fbef9ec5635c492ae63dfb5d13f2bdf1023]
stable/6.1: [f3e409476ad0703c54c14f245e4e143c8124e1bd]
stable/6.12: [3ad5fbcced4e9c2b0fee3c1b76289a147fc35b89]
stable/6.18: [2a52d55c86a429dac47886b8424e67f90b001e67]
stable/6.6: [6c82f88bc7a8458d5c60f9b354c4d32d233f0cac]
stable/7.1: [8f50613bff228272577893aa10a346a2f3063e49]

CVE-2026-64456: hwrng: virtio: clamp device-reported used.len at copy_data(=
)

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64456

Introduced by commit f7f510e ("virtio: An entropy device, as suggested
by hpa.") in v2.6.26-rc5.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3046eeada299f917a8ad883af4434bfb86556b1]
stable/5.10: [3aa3e89cf80721c8d382b4c1a2b70a0449dad4a5]
stable/5.15: [63335e7b638ae70028ae285bb95153874a8bc852]
stable/6.1: [2e788948ff2a13358a303af112497a63201c5739]
stable/6.12: [81dd21b5f0c299cc7b5bf84f04a61938559d20e6]
stable/6.18: [285e17c44e3873a73460f294acbd64018ff64385]
stable/6.6: [fde19b0d4eeabae042519313c843fe6f27d41e9d]
stable/7.1: [92d5736a62040ec1cfff23ea57e6599301690ad5]

CVE-2026-64457: virtio_pci: fix vq info pointer lookup via wrong index

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64457

Introduced by commit 89a1c43 ("virtio_pci: pass vq info as an argument
to vp_setup_vq()") in v6.11-rc2.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7d380fb525c13bdd114369a1979c80c346e6abc]
stable/6.12: [41e6dc1a10036c9f47057033f19af7e52ec464b6]
stable/6.18: [075bc3c779e1ea7294afabdcb7e0a49536959b28]
stable/7.1: [64a4c0befa77bcc01076aec9f93863ffd4ed06b7]

CVE-2026-64458: mm/damon/ops-common: handle extreme intervals in
damon_hot_score()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64458

Introduced by commit 198f0f4 ("mm/damon/vaddr,paddr: support pageout
prioritization") in v5.16-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [35d4a3cf70a855b50e53189ac2f8463e20a02046]
stable/6.1: [58321b4e6e4f0f412069ab27ccdd56292757343a]
stable/6.12: [ef2ae10a4582bc92b7e944181bbd2f87f3d30f3a]
stable/6.18: [9c8f31eaae6140ecadec0c07320498a944556de2]
stable/6.6: [74fef68d521150281e36cdaa20e9e1ee3e3aa146]
stable/7.1: [76e415ea88d20f022ed5cfcf78c50e156a267e91]

CVE-2026-64459: tcp: restore RCU grace period in tcp_ao_destroy_sock

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64459

Introduced by commit 51e547e ("tcp: Free TCP-AO/TCP-MD5 info/keys
without RCU") in v6.18-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8bc4d43bccbd60efe85d0a44d5bf41762f2f0c30]
stable/6.18: [657646c08c94ef7b9dbe468fe7828032216f9841]
stable/7.1: [4caf12c778fed3dc3824cf36263be5e2c491fbd0]

CVE-2026-64460: PCI/IOV: Skip VF Resizable BAR restore on read error

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64460

Introduced by commit 5a8f77e ("PCI/IOV: Restore VF resizable BAR state
after reset") in v6.17-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f34f1712229d71ce4286440fef12526fd4590b37]
stable/6.18: [b77524621250407386f44c6eea7e5e4619ada1ce]
stable/7.1: [55fd485e66d0ad5c762c23dba1461fe9c741cd96]

CVE-2026-64461: PCI: mediatek: Fix IRQ domain leak when port fails to enabl=
e

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64461

Introduced by commit b099631 ("PCI: mediatek: Add controller support
for MT2712 and MT7622") in v4.14-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f865a57896bd92d7662eb2818d8f48872e2cbbc7]
stable/5.10: [e23da72ef202654a7d5269885c4fa39a8404db76]
stable/5.15: [ec7c05eed47d8b15c45380aee7ca168a82e15035]
stable/6.1: [1fbe8972a39548a633d06d7b03a01b7b119a2c12]
stable/6.12: [ce52e494a7555bdae1d990a2654fd7547ef6d986]
stable/6.18: [6e6a529d6f779413379b4404c9ef6a36c0337225]
stable/6.6: [fe8c701a53c2816cd82301f66c671d952003c1b0]
stable/7.1: [df77314b3bedbd9ad5d6f0682f98b99e3c5f7e2e]

CVE-2026-64462: PCI: altera: Fix resource leaks on probe failure

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64462

Introduced by commit c63aed7 ("PCI: altera: Use pci_host_probe() to
register host") in v5.9-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7a94138caeb27f3c49c1dbd93bf422098925bb28]
stable/5.10: [af7cf5d56d7d57c4fbfdb7b5b693790f331b07b7]
stable/5.15: [9cf0cc481e1645ec65e61486ae41c486c59781cb]
stable/6.1: [99fc088d6cc6890ae35fa2f29c50ebe027844c20]
stable/6.12: [0db9aa9ec51be0a0ffdcdfd9af2b7bf3aeb7911a]
stable/6.18: [09c43b7b7d29c6fadb27f32cdf7f3bb6598befa9]
stable/6.6: [a25bfa2a6665a1d77324d4a609e7513b87680227]
stable/7.1: [6864c789b570e57f932847fa83f6b56917182d73]

CVE-2026-64463: usb: typec: tcpci_rt1711h: unregister TCPCI port with devre=
s

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64463

Introduced by commit 302c570 ("usb: typec: tcpci_rt1711h: avoid
screaming irq causing boot hangs") in v5.8-rc3.
Fixed in v7.2-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [e8da46d99d3710106e7c44db14566bf9b57386b5]
stable/6.12: [94b1abf1af94aa5a355e9f03675e07bccfc41c4b]
stable/6.18: [e5406c8fb71cd2f89a46300a746f6e7972e621e8]
stable/6.6: [ce2e36e8759dfbfe546723810c306f42f484866d]
stable/7.1: [569f18a83eed0b0be4615f0c7bed40fb5c50e2e6]

CVE-2026-64464: xhci: sideband: fix ring sg table pages leak

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64464

Introduced by commit de66754 ("xhci: sideband: add initial api to
register a secondary interrupter entity") in v6.16-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [49f6e3c3ef19f04f6657ed8dce550e36c763abb8]
stable/6.18: [99d00a9e35e311a91d258029d5bb584377296c34]
stable/7.1: [a3eaf82ff842d6ca95937ea584417e04828235a6]

CVE-2026-64465: usb: xhci: Fix sleep in atomic context in xhci_free_streams=
()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64465

Introduced by commit 8df75f4 ("USB: xhci: Add memory allocation for
USB3 bulk streams.") in v2.6.35-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [42c37c4b75d38b51d84f31a8e29427f5e06a7c2a]
stable/5.10: [e623e4a203f56d5c57519a9a3cb29600551534ad]
stable/5.15: [d107eb316144c5fb958486e7fe604cd7f1b35cda]
stable/6.1: [1e45aa722c4ce5663e987102aac18c8ad6a83fdd]
stable/6.12: [f7b022ae07685e7526fc39f387ce65b5d309dd3b]
stable/6.18: [f90586129cf9e1fbdb718ef602eea3f15dc1c31c]
stable/6.6: [10666ac9c552990204e791af653abf8e9d9ff619]
stable/7.1: [93cd037da94fcb93183bfb2457e3a56d3eb4c8f4]

CVE-2026-64466: rust_binder: clear freeze listener on node removal

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64466

Introduced by commit eafedbc ("rust_binder: add Rust Binder driver")
in v6.18-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc4a9828897871ff3e5a1f8a1d346decbf4ee95e]
stable/6.18: [91b27f8172cdbf265240104772fd042a461a7767]
stable/7.1: [0644da3621ddd8e146280675a2a31d1e06634a1d]

CVE-2026-64467: rust_binder: use a u64 stride when cleaning up the offsets =
array

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64467

Introduced by commit eafedbc ("rust_binder: add Rust Binder driver")
in v6.18-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [803c8a9502e9b97cd6ae937618ef4a8fd6274343]
stable/6.18: [89b8cc948dce661af87527623b3a41cdd115e2f9]
stable/7.1: [74920b1b4e474ba7a4de4323c0458deec49d210b]

CVE-2026-64468: binder: fix UAF in binder_free_transaction()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64468

Introduced by commit a370003 ("binder: fix possible UAF when freeing
buffer") in v5.2-rc6.
Fixed in v7.2-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [f223d27a546c1e1f48d38fd67760e78f068fe8c4]
stable/5.10: [5602a43f251c3d75312df91a422675fc00ca3dce]
stable/5.15: [0be901ab1dcc4af59b88f2e324493bb283850167]
stable/6.1: [48aeda9f8039e4a6971d1804578efde7f2c01eda]
stable/6.12: [d45ef513eed1abebfec90c3cfb6ae50c2a4182db]
stable/6.18: [328ccf32acb87e8bbb1fe2b065068c574e4db2bf]
stable/6.6: [45df558c543bb5543bacc8065fd7c567740781e5]
stable/7.1: [0f15f0f6ca5df566275ce517f257af2559528b41]

CVE-2026-64469: binder: fix UAF in binder_thread_release()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64469

Introduced by commit 7a4408c ("binder: make sure accesses to
proc/thread are safe") in v4.14-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [114a116aaa5f0295376cdf12da743c5bce3b20ce]
stable/5.10: [1f96f8c0a6ed4f6d01d3dd29ad0cbf08dde96082]
stable/5.15: [df1a17abba8d6fac5f965adcb8113ceace6e4949]
stable/6.1: [38e1a71728e5795b670cc159c18e286a40aeebb4]
stable/6.12: [e63032dc715026a96bcaa13d375a8e15c91caa84]
stable/6.18: [ea02df466df60ecd758eb3b4df3f0cadc5c886ce]
stable/6.6: [faa070c7ad8ba25dcd0b12d7cdbb419e336f5391]
stable/7.1: [ef5439ba5b9ac93349f5df12ef88b42a0ce26340]

CVE-2026-64470: Bluetooth: btusb: fix use-after-free on marvell probe failu=
re

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64470

Introduced by commit a4ccc9e ("Bluetooth: btusb: Configure Marvell to
use one of the pins for oob wakeup") in v4.11-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c5b600a3c05b1a7a110d558df935a8fc8a471c79]
stable/5.10: [1edd524de5cc8143ece9c42c466346983dc5b5ed]
stable/5.15: [0ccb1cb0a464dab78284c34196cd3e8e18bab4c4]
stable/6.1: [631de465aba7f8ae46478bf5f598111412e8eff8]
stable/6.12: [92c736866244340497a8a65afe2ac25354c2bf5e]
stable/6.18: [a7e941a395711791c7e98d9870c6562c2c9e9ef2]
stable/6.6: [6e1b10df890f4663cb38af9fc1c93d36747b75af]
stable/7.1: [838c917a2f16eefe68def800ebf48a2af591149a]

CVE-2026-64471: Bluetooth: btusb: fix use-after-free on registration failur=
e

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64471

Introduced by commit 9bfa35f ("[Bluetooth] Add SCO support to btusb
driver") in v2.6.27-rc4.
Introduced by commit 9d08f50 ("Bluetooth: btusb: Add support for
Broadcom LM_DIAG interface") in v4.4-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eedc6867ebad73edbfaf9a0a65fbef7115cc4753]
stable/5.10: [e09ac7d0c6859a360bf36e7104aef03f88184e0b]
stable/5.15: [468fcdfaeb937163dd250773a9fed17ab1fa203c]
stable/6.1: [1ce5012944afaddbda939ec6bae9800fce84abbc]
stable/6.12: [14e02f1449ba425a44dedbec9a21efafb056e09f]
stable/6.18: [8db0ce3de78367f61c2970c0f16d9adee8830a23]
stable/6.6: [e6313b800da61a26c2fdd5eba0105e197c0ab3bc]
stable/7.1: [da7d7758fe884b256ddc9fef562e5ddef7952383]

CVE-2026-64472: vfio/mlx5: Fix racy bitfields and tighten struct layout

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64472

Introduced by commit 61a2f14 ("vfio/mlx5: Manage the VF attach/detach
callback from the PF") in v5.19-rc1.
Introduced by commit 79c3cf2 ("vfio/mlx5: Init QP based resources for
dirty tracking") in v6.1-rc1.
Introduced by commit f886473 ("vfio/mlx5: Add support for tracker
object change event") in v6.9-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f2365a63b02ddea32e7db78b742c2503ec7b81f1]
stable/6.1: [1dd99b8f4e143592e12e5a77e7b538bc698116cb]
stable/6.12: [399d806f998f7a25405fc1b97227e579aead24af]
stable/6.18: [7ed120b1a007bace57c461805519d70e1af44e59]
stable/6.6: [f1db80a67da928a92ba460ede1be52d8941f46be]
stable/7.1: [39d163627b51886492bf31f66cb02c94613d2287]

CVE-2026-64473: vfio: Remove device debugfs before releasing devres

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64473

Introduced by commit 2202844 ("vfio/migration: Add debugfs to live
migration driver") in v6.8-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc7fe87de492ea7f33a72b78d26650b75bf37f4f]
stable/6.12: [6cc60b41d61657dc469893d14e8e55d160056ff1]
stable/6.18: [a53109ffb6b5148e11a27fb7670355b92db12dd3]
stable/7.1: [a5df401dc84f091e20b045560569f0736758fea7]

CVE-2026-64474: vfio: prevent infinite loop in
vfio_mig_get_next_state() on blocked arc

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64474

Introduced by commit 4db5260 ("vfio: Extend the device migration
protocol with PRE_COPY") in v6.2-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a26b499b757cfc8bbff1088bb1b844639e250893]
stable/6.12: [ed7d5599e6c398da74845767cd1e6a8370a160fc]
stable/6.18: [7f2d6b31089e48db4653df832c9a6afdde9a1c29]
stable/6.6: [8e872c07e40d51a66dee7b280a23a460a2e1e3fa]
stable/7.1: [a3a8afa2f6e7f0dc266d08f02be3f3054241ba47]

CVE-2026-64475: vfio/pci: Release the VGA arbiter client on
register_device() failure

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64475

Introduced by commit 4aeec39 ("vfio/pci: Re-order vfio_pci_probe()")
in v5.13-rc1.
Fixed in v7.2-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [daedde7f024ecf88bc8e832ed40cf2c795f0796a]
stable/5.10: [0f2a35a0c7ea7da347b814750eaa78adf3582381]
stable/5.15: [8d65decde9afd2bd78bcfffdc0df73b82a0b5509]
stable/6.1: [ef4c38d30b3744e89eb5048218904bb629ea8d47]
stable/6.12: [42d758a09d2c46c42357ecde9a5492f015bde2e5]
stable/6.18: [52adb2dff7ce3d8430e2bdc5988b618a430def85]
stable/6.6: [9e0a3f642e607848669235f5069f35640abbfc88]
stable/7.1: [278a5659c391fe5afe5f9ce1bad1fd24e90144f1]

CVE-2026-64476: vfio/pci: Latch disable_idle_d3 per device

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64476

Introduced by commit 7ab5e10 ("vfio/pci: Move the unused device into
low power state with runtime PM") in v5.19-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4575e9aac5336d1365138c0284773bf8da4b1fa3]
stable/6.1: [332d785f9ae426eeeb92527872adf09d84101ba3]
stable/6.12: [b98296816d31441b307ef9fa8670dcf5a55e5505]
stable/6.18: [f6c67cf0051f96ba61d186731d3d9409b9927db2]
stable/6.6: [654710ef3135c4546b20a903bc23a51b0c44d6c8]
stable/7.1: [062b820290bcb9778e43a73597df76e9bb08acfb]

CVE-2026-64477: x86,fs/resctrl: Prevent out-of-bounds access while
offlining CPU when SNC enabled

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64477

Introduced by commit e13db55 ("x86/resctrl: Introduce
snc_nodes_per_l3_cache") in v6.11-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fc16126cc11d9f507130bf84ab137ee0938c900e]
stable/6.12: [ebc300b7ee0c669fa76a7a8858298ff32e296103]
stable/6.18: [be1567992417dc92133e74126de7a6066c825ac9]
stable/7.1: [58c5ec23b1a238eb75cb0aba6f69d8f9e68ef0b2]

CVE-2026-64478: ALSA: usb-audio: avoid kobject path lookup in DualSense mat=
ch

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64478

Introduced by commit 79d561c ("ALSA: usb-audio: Add mixer quirk for
Sony DualSense PS5") in v6.17-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12
stable/6.6

Fixed status
mainline: [7693c0cc415f3a16a7a3355f245474a5e661be4e]
stable/5.10: [e4c66a149c408e44e60bfec3fabf08b6b7abbc60]
stable/5.15: [4566bf8ae9dbfe81bdc2ff1702d59db8a233b06e]
stable/6.1: [662a1d7b5affc424ea4f4bc20dd99be29e687886]
stable/6.12: [c1da6d3f45036fa63672ee04ad97cb526b40b987]
stable/6.18: [a263eb12cbe2e208e6e637df0f9b0be9a484158e]
stable/6.6: [a47ecd904c51ae6a42957feb3cf2f4266adee2e5]
stable/7.1: [4246dd043b7a4f8e3bc1d2896e81d11220610eda]

CVE-2026-64479: ALSA: seq: Fix uninitialised heap leak in snd_seq_event_dup=
()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64479

Introduced by commit 4639762 ("ALSA: seq: Add UMP support") in v6.5-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
stable/5.15 stable/6.1

Fixed status
mainline: [435990e25bf1f4af3e6df12a6fbfd1f7ba4a97d4]
stable/5.15: [d7649aa11089a93ea2285c210397aa67e5800766]
stable/6.1: [a224c84e5d3d35708c082c84ad12d81d90762195]
stable/6.12: [fb1aa5082847b98f44f9c6272aee9d0dca9244f0]
stable/6.18: [651ba82fe2a144bc7356d940bfd235c3810b0549]
stable/6.6: [ea672a9f6cc38f06fe69dd2c257ef8a3d4db179a]
stable/7.1: [6ded42615fa1f4949925afd0a8a9e1ab3bf96202]

CVE-2026-64480: ALSA: ice1712: check snd_ctl_new1() return value

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64480

Introduced by commit b9a4efd ("ALSA: ice1712,ice1724: fix the
kcontrol->id initialization") in v6.4-rc6.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [2b929b91b0f3bc6de8a844370049cd99ee8e31ff]
stable/6.1: [57d59be545b309d4bb54ac472b15d1e67f254d95]
stable/6.12: [d34ad480b8896d2b486e2cf29ce1790326cad205]
stable/6.18: [71b87108ad93d433cdb20704a8dc8852304cf2c2]
stable/6.6: [69bf1dfa3215524c4ae255bb9dce0770875abbeb]
stable/7.1: [38a7cc46370a57122fb29c4bfe48a851c0c64459]

CVE-2026-64481: ALSA: hda/cs35l41: Fix firmware load work teardown

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64481

Introduced by commit 47ceabd ("ALSA: hda: cs35l41: Support Firmware
switching and reloading") in v6.0-rc1.
Introduced by commit 4c87051 ("ALSA: hda: cs35l41: Add read-only ALSA
control for forced mute") in v6.7-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b65020d5398f499c09498c9786dba6d67ae57664]
stable/6.12: [8947215c0136c9d905e4a46d824824f8b48a2e5b]
stable/6.18: [ce0a903d0591e3e2c790c5b628802b08d1b287cc]
stable/7.1: [d6a40a4d083ef74d00c8f9516cb5ff07ac70720b]

CVE-2026-64482: ALSA: gus: check snd_ctl_new1() return value

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64482

Introduced by commit c5ae57b ("ALSA: gus: Fix kctl->id
initialization") in v6.4-rc6.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [c7fa99d30c7a166a5e5db5a585ce7501ff68326b]
stable/6.1: [97f6bdf5d5ded2e37f358cacb5a95f1393356604]
stable/6.12: [fc5d4f27ca1293bc1379ef8fff691c30d9803ca2]
stable/6.18: [5e74e5e8cb7cc25f7a89f59abaf3489bf0c6f4a0]
stable/6.6: [eccf8e91266e39f6f15637702a04a1d344833fe2]
stable/7.1: [465075c6835103821d725c13f8c545898e5f2636]

CVE-2026-64483: ALSA: firewire: isight: bound the sample count to the
packet payload

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64483

Introduced by commit 3a691b2 ("ALSA: add Apple iSight microphone
driver") in v3.0-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [29b9667982e4df2ed7744f86b1144f8bb58eb698]
stable/5.10: [24423e0a9251d348c3f1fb0bb0e61b879e1e976c]
stable/5.15: [ebbffacda6733dcbcef601b5b523460f8d8b671e]
stable/6.1: [57e4d9043afc1eaddee8f50d11def6e65415d273]
stable/6.12: [31da82b9676c6b112e7c72c7529e6812b919742a]
stable/6.18: [8e48a29813df8dd71503800b7acf69c12c035045]
stable/6.6: [3ed2fa1ed8cc65f910b8bbc0be3cc366b30f8478]
stable/7.1: [31a01b70bb90e3ef3147f308e2ea899e1d2485ca]

CVE-2026-64484: ALSA: es1938: check snd_ctl_new1() return value

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64484

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1edd1f02dddd20aeb6066ded41017615766ea42f]
stable/5.10: [96cad5bd7d0a176db3fdc06717a41271247336bd]
stable/5.15: [6c4efebaf73e217efbd08cdbda805758a7db3680]
stable/6.1: [41759affbcfe3d51a32900da9547a1ffd744a85f]
stable/6.12: [af01c48e17a66fa038af210a5c49d6cdefd210bd]
stable/6.18: [9e53e99b6fa3cd82992d963cbff58dbbd1df8651]
stable/6.6: [7531a37720c2545a480fd0fa464978569bf9d6a2]
stable/7.1: [1949163dee39e0e4a1468f37dd7302962f6af45a]

CVE-2026-64485: ALSA: compress: Fix task creation error unwind

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64485

Introduced by commit 0417715 ("ALSA: compress_offload: introduce accel
operation mode") in v6.13-rc1.
Introduced by commit 3d3f43f ("ALSA: compress_offload: improve file
descriptors installation for dma-buf") in v6.13-rc5.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a60127debb9e370d6c0e22a307326b624a141f3]
stable/6.18: [b27a75d42044d9d4709095617730b91b1c4af423]
stable/7.1: [426a9947a38d272d0e19c031658da68e31128667]

CVE-2026-64486: ALSA: cmipci: check snd_ctl_new1() return value

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64486

Introduced by commit f2f312a ("ALSA: cmipci: Fix kctl->id
initialization") in v6.4-rc6.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [c205bd1b28fb7e5f1061a4e78813fad7d315cb3e]
stable/6.1: [b44888c33c4f11277d0e5e023338f2740232a4ed]
stable/6.12: [4dd5b0b1a52a8d6e59a3f217204817228ce0238b]
stable/6.18: [af2b009b773bc42995546507963e5e78970dc3ed]
stable/6.6: [8825a06bfa7932a7a74dec01669d405df0b47286]
stable/7.1: [67e9ea92cd598cba1783ff701553c776a6cedee9]

CVE-2026-64487: ALSA: caiaq: fix out-of-bounds read in the Traktor
Kontrol S4 input parser

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64487

Introduced by commit 15c5ab6 ("ALSA: snd-usb-caiaq: Add support for
Traktor Kontrol S4") in v2.6.37-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7f3f9fd81e7adbaa12c2e62ee07f0e094a543fd]
stable/5.10: [de5f9edc705497b1b2c6b173b22f283486d2fd91]
stable/5.15: [70d6d4cfa4ad09688aed2ec8a0cfa72c31f60334]
stable/6.1: [884f575cc6acb136eb4a161d925147f85b59c27e]
stable/6.12: [3cad86197c7bf8b45bb1d8adc1099d0913e80469]
stable/6.18: [a5fd3122283bf75c04f6414bf610100beb0565b0]
stable/6.6: [05df59b9a61f7ca66548df079d306c41da23845d]
stable/7.1: [0680413f2f10aab43878dd3db711a6a9e45bab7c]

CVE-2026-64488: ALSA: aoa: check snd_ctl_new1() return value

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64488

Introduced by commit f3d9478 ("[ALSA] snd-aoa: add snd-aoa") in v2.6.20.16.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8df560fefe6fed6a20b7e06720eeaeccec349ac0]
stable/5.10: [b0154ebc6dc552c389a574b1e221d728e10346e7]
stable/5.15: [d62624fe256b2d0d13454c78cbfc70ff5d954dc7]
stable/6.1: [e5e8c4508d95af82f9b4d065f658e5476a8e9bc8]
stable/6.12: [d73067e2bbf3775a495d9f38e38d0a3cf53ee790]
stable/6.18: [fd786466889e4a6e6de0f4462bd0068edea63960]
stable/6.6: [2ee9c46fd2dcd529cef18e37636ee12f5c3dbedd]
stable/7.1: [e47f2a341adbac001b6f5d0211b0cd1c1668637b]

CVE-2026-64489: ALSA: ymfpci: check snd_ctl_new1() return value

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64489

Introduced by commit c9b83ae ("ALSA: ymfpci: Fix kctl->id
initialization") in v6.4-rc6.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [e64d170346d00b580c0043de3e5ccb3e331c47d4]
stable/6.1: [d7c71dfd4b80f0eacac2c157a8a3a4c6e8b2e0d1]
stable/6.12: [02f33c2062c75e28abc7ad58ce86451cf3140455]
stable/6.18: [f6538a318947b627710b08a268bc80a48c23bde7]
stable/6.6: [91095474eea29b95c9a8bceb9b501a2702b6c55f]
stable/7.1: [18ec7d7785be7a4ee8ea11e355122282caad4267]

CVE-2026-64490: ALSA: virtio: Validate control metadata from the device

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64490

Introduced by commit d6568e3 ("ALSA: virtio: add support for audio
controls") in v6.9-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c77a6cbb36ff8cbc1f084d94f8dcda5250935271]
stable/6.12: [3243563f99ef5d3949b934bd6390a5679405d0e1]
stable/6.18: [5da9742de22db0dbaa8d414214ab5e1bedde00f9]
stable/7.1: [21584672fd699abe1768241d6c501b2de6139b6a]

CVE-2026-64491: ALSA: usx2y: us144mkii: fix work UAF on disconnect

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64491

Introduced by commit c1bb0c1 ("ALSA: usb-audio: us144mkii: Implement
audio capture and decoding") in v6.18-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [147996e7e7c9e8339c0e04f6fa7ccb3e4d448ff7]
stable/6.18: [c071df05bcda0e47aac581d4b564b2bebcb1ff60]
stable/7.1: [27161c68d5e78807c9d897db222a775b298d05fd]

CVE-2026-64492: iio: temperature: tmp006: use devm_iio_trigger_register

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64492

Introduced by commit 91f75cc ("iio: temperature: tmp006: add triggered
buffer support") in v6.13-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c5eed894efd93d68d7f6a359a81ddef0e928774]
stable/6.18: [a4f8491da9563ba6eb77969ac26fc7052114c476]
stable/7.1: [d90f868f56a16e10eedc6552f48d99dff4d275b7]

CVE-2026-64493: iio: pressure: mpl115: fix runtime PM leak on read error

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64493

Introduced by commit 0c3a333 ("iio: pressure: mpl115: Implementing low
power mode by shutdown gpio") in v6.2-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fbe67ff37a6fd855a6c097f84f3738bd13d0a898]
stable/6.12: [aab0fed636b14a5fd52fcae58b484f1cb96b841d]
stable/6.18: [b3f1af4ba8e9cf33aa08c4cdcaa5a17b140521ec]
stable/6.6: [5022f4ed5aae974ec530e3cbf0bd223be13055f7]
stable/7.1: [46e69d3dd429b33e50e2731913239f6af4ea2705]

CVE-2026-64494: iio: light: gp2ap002: fix runtime PM leak on read error

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64494

Introduced by commit f6dbf83 ("iio: light: gp2ap002: Take runtime PM
reference on light read") in v5.8-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [38b72267b7e22768a1f26d9935de4e1752a1dc85]
stable/5.10: [62e0d74821a02f0e0c5c79b99ae64dc83a9a90f5]
stable/5.15: [7110201c6b21455240c63388f30113f3baafacfc]
stable/6.1: [2593f0c6ea37df168975694a3b17e7086f11453e]
stable/6.12: [29137052c4485c74bc2d1b0717f69ca4de14274f]
stable/6.18: [0c655d067ac69ee24e2e9d706c54179ea58a43db]
stable/6.6: [f350883989ced96d6da7f582f9a6f9c6ffc94e34]
stable/7.1: [2ebaea7f3089decb01a8294d89d7e0cf288146c4]

CVE-2026-64495: iio: gyro: bmg160: bail out when bandwidth/filter is
not in table

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64495

Introduced by commit 22b46c4 ("iio:gyro:bmg160 Gyro Sensor driver") in
v3.18-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8320c77e67382d5d55d77043a5f60a867d408a2b]
stable/5.10: [1dc3a833be11e5d503038e3c701745fd0e03903c]
stable/5.15: [77e56ebb1786f4296afd5fa46975a989b285ae65]
stable/6.1: [029481cddb98697716f4bf3021d035eaf2ca0e1f]
stable/6.12: [d85ee50f58dd83fe74f6d0bf8bd345c657b216e8]
stable/6.18: [7bbf02b63961fc1768c9c654392c11f2077d4c59]
stable/6.6: [8d202515baea4e2e3be448d1590099af28f2346d]
stable/7.1: [6c8675468862161d1c59130266852b66867d3861]

CVE-2026-64496: iio: event: Fix event FIFO reset race

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64496

Introduced by commit b91acca ("iio:event: Fix and cleanup locking") in
v3.15-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af791d295737ea6b6ff2c8d8488462a49c14af01]
stable/5.10: [9dc84ba4be5bbeb29ee49efe6cea2cb32c461424]
stable/5.15: [d16a702ca7d29c0b7a9b509339d1b044a1cadb32]
stable/6.1: [a13ef1adbc62085b21b546b07b0be7e2fbf52150]
stable/6.12: [72c6aa8e0d74eab91b8694cde97dec088c248fee]
stable/6.18: [9edefd4c56bee3fe331e0355d1f10a533134999d]
stable/6.6: [0d4a646d7f87ea3625fafe387043fddc6a2f5e7f]
stable/7.1: [f187dc5a4c4846ffa07d9bda6e760837ed005574]

CVE-2026-64497: iio: chemical: scd30: Cleanup initializations and fix
sign-extension bug

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64497

Introduced by commit 64b3d8b ("iio: chemical: scd30: add core driver")
in v5.9-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [60d877910a43c305b5165131b258a17b1d772d57]
stable/5.10: [0ccff849bde90973e6c13a666f6ceab5c55b30d4]
stable/5.15: [1821bcacd8ac5b214c53be16cbb8172bf193f0b6]
stable/6.1: [40bb0fdb37f441c9c9f52bf58bbd8a0ca3cc9598]
stable/6.12: [8d4a46e971cf846bda98b20d4cabfa21c1276e5f]
stable/6.18: [82accdd57404399eddf3d56fd9beda7c61307388]
stable/6.6: [b131f0011dfef72350f4e3f11df94dc3e6b46065]
stable/7.1: [d49ff54b2784aa56a7c97982de713604de89d23a]

CVE-2026-64498: iio: buffer: hw-consumer: free scan_mask on buffer release

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64498

Introduced by commit 9a2e123 ("iio: buffer: hw-consumer: remove
redundant scan_mask flexible array") in v7.1-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6325d6e2204327965b849c0a16efb6ac9202e5a8]
stable/7.1: [fb8e18f8ca724bd4de4643cad5b7c7230b9a5a71]

CVE-2026-64499: iio: adc: ti-ads1119: fix PM reference leak in buffer preen=
able

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64499

Introduced by commit a930688 ("iio: adc: ti-ads1119: Add driver") in v6.11-=
rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [adf4bc07f814da8329278d32600147f5a150938c]
stable/6.12: [f40292fb19399a3c3f82de698023ba87c01e66cf]
stable/6.18: [ffb2195921c3d629194b9807de589578df9f9cb8]
stable/7.1: [6537f08100189d12bec4975000244e6ac4873c28]

CVE-2026-64500: iio: adc: lpc32xx: Initialize completion before requesting =
IRQ

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64500

Introduced by commit 7901b2a ("staging:iio:adc:lpc32xx rename local
state structure to _state") in v4.12-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e561b35633f450ee607e87a6401d97f156a0cd54]
stable/5.10: [7090c0d29708ee305022d0ea7b37612b33242fa2]
stable/5.15: [0e33587967b356519aa6f220b5b43c6976320397]
stable/6.1: [1ddf7b6ffb8ebb22b92a184a9eaa76277ef0c7cd]
stable/6.12: [48eccc6caed4e62c0f199ab3a3772fa969cd3b2d]
stable/6.18: [9e2e8b8cdfd37ae7c7a8a5c96c59e98a768731c4]
stable/6.6: [820c4f15353efe9a9429ae86ccceeaf4e0e4e585]
stable/7.1: [2f18c5551aa97ca7f39dbb151c67c9053ccadc17]

CVE-2026-64501: iio: adc: ad_sigma_delta: fix CS held asserted and state le=
aks

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64501

Introduced by commit 132d44d ("iio: adc: ad_sigma_delta: Check for
previous ready signals") in v6.14-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c72da0688575e5ef39c36bb44fed53aa18f8ae65]
stable/6.18: [c313bb7c38855e94ceef939d152dd75e5a904b5f]
stable/7.1: [f1de829ee87a1198d3465493ce430d36c5fa029c]

CVE-2026-64502: iio: adc: ad_sigma_delta: fix clear_pending_event for
registerless devices

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64502

Introduced by commit 132d44d ("iio: adc: ad_sigma_delta: Check for
previous ready signals") in v6.14-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [91bc6767a4f55dc470d8a56b55b9f2ea09094efe]
stable/6.18: [3394e0b3328422431cadaf314fa58d3717ed4936]
stable/7.1: [3bceb26dfaf7ba805b459e41c1d0ba916862dade]

CVE-2026-64503: iio: accel: kxsd9: fix runtime PM imbalance on write_raw() =
error

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64503

Introduced by commit 9a9a369 ("iio: accel: kxsd9: Deploy system and
runtime PM") in v4.9-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [44a5fd874bb6873bdaec59f722c1d57832fbc9df]
stable/5.10: [a93fd69c1ab0854ac4f5b8439c26dfadb25dfd20]
stable/5.15: [eeece4a85ece6f3837c75ef26a9b2bf5a1d0fcfc]
stable/6.1: [191fcfeb729ededd8dd2a999c6bf351ddfa0cec7]
stable/6.12: [223703d6e8bed50b6a0b47e160877909518d94b9]
stable/6.18: [6293211d142605bec435229ef0aa3668b8964164]
stable/6.6: [36154171385a8a2444a4b3c6eaa0c5294cb02478]
stable/7.1: [13a91e8631cfeb68e5b7fd6687f194f5a86e83fe]

CVE-2026-64504: iio: accel: bmc150: clamp the device-reported FIFO frame co=
unt

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64504

Introduced by commit 3bbec97 ("iio: bmc150_accel: add support for
hardware fifo") in v4.1-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce0e1cae26096fe959a0da5563a6d6d5a801d5fb]
stable/5.10: [b5a9f521e0a49a0266200fd535b32a9668ecb33b]
stable/5.15: [2fe0531dd73eff1de0f2584cb77716d645e548d5]
stable/6.1: [d0e6d924a5484e005cae5aff6a0aa07a22f3c9ff]
stable/6.12: [89f4a4ca0ac3a933c750569a771c079a290b0721]
stable/6.18: [3e766526827acd542bcd36c20c4d5f397e0f6521]
stable/6.6: [bfffc98f3de92e0f76be7c7b72e63ac1776a6dbc]
stable/7.1: [35a3cd8fd65e15029eb90f1e510045b1bb071175]

CVE-2026-64505: usb: gadget: function: rndis: add length check for header

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64505

According to the .vulnerable file, this bug was introduced by commit
6cdee10 in v2.6.12.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [21b5bf155435008e0fb0736795289788e63d426f]
stable/5.10: [200dd5092296ad4d5ae47f8445a2fb1edd1da973]
stable/5.15: [9ffd567d7bf269824dfac06f8ab9a32fef72699b]
stable/6.1: [b73c0142e3acdc063b50c33afb7be19cdb2cd410]
stable/6.12: [ba2cc601e59fe68716646199a33303493513e2e3]
stable/6.18: [7515a6d4a9e9e4838b833825882efa00e85f8901]
stable/6.6: [d6ef5af7d0fe1ac31e5653a77e6d775dd36bc433]
stable/7.1: [9facd79028a7807879eb441d12f0e00720980aa3]

CVE-2026-64506: wifi: rtw89: correct drop logic for malformed AMPDU frames

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64506

Introduced by commit bda294e ("wifi: rtw89: Drop malformed AMPDU
frames with abnormal PN") in v7.1-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63ccdfac8677387dfdbd9d4336089e9823280704]
stable/7.1: [994994cfadaf1fd362dea9b8d9d633f85dc1b3c3]

CVE-2026-64507: x86/bugs: Enable IBPB flush on BPF JIT allocation

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64507

According to the .vulnerable file, this bug was introduced by commit
5763105 in v5.18-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3af84b0fa00ead01fcd0e28b5d773ff25990a0d]
stable/6.12: [9354248fc1c33a844ca1872761f6668b393e8c37]
stable/6.18: [8a4c8af9ae67eb072d90d1b339f14d27a82bd2a1]
stable/6.6: [cb27f3bf915cc0f20fc0c48da9059304e39ebd35]
stable/7.1: [52440e15d9628f8f239373c0f2e5e8f92feea2df]

CVE-2026-64508: bpf: Support for hardening against JIT spraying

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64508

According to the .vulnerable file, this bug was introduced by commit
5763105 in v5.18-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [96cce16e26dd02a8678f1e87f88a4b5cdb63b995]
stable/6.12: [eed774da601268dae674e14d54a15e3624691f52]
stable/6.18: [8ff183ee4d8c452960df58175a094828c0513b2e]
stable/6.6: [6e52c240c43a601b681e3a4e58fc5685114d4726]
stable/7.1: [7a6c171c6a1ac6d1509752dac131d941a3de0b37]

CVE-2026-64509: rust: block: fix GenDisk cleanup paths

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64509

Introduced by commit 3253aba ("rust: block: introduce
`kernel::block::mq` module") in v6.11-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2957771379fa335103a4b539db57bb2271e12142]
stable/6.12: [d1dcaa5229a63a6b6df7e0f673fe576cf3d6e8cb]
stable/6.18: [e7636f26f77070a529c26d65afd217514ce85ce4]
stable/7.1: [6822a2685b4da9a87efd1fce4b042678a31ff734]

CVE-2026-64510: ACPI: NFIT: core: Fix acpi_nfit_init() error cleanup

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64510

Introduced by commit a61fe6f ("nfit, tools/testing/nvdimm: unify
common init for acpi_nfit_desc") in v4.6-rc1.
Introduced by commit fbabd82 ("acpi, nfit: fix module unload vs
workqueue shutdown race") in v4.12-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [38bf27511ef41bffebd157ec3eba41fc89ba59cd]
stable/5.10: [ee82078e776ae31266cc70fdf62ac17c3c6f100a]
stable/5.15: [6ff054cc02a763914773b026cacb429e5fbf64fa]
stable/6.1: [b07d22a2d17ad6465c87bd5752bc70e4c16e0ee4]
stable/6.12: [df7c92216a1583a76cb0cbf2f21cd68870609b05]
stable/6.18: [3b2628f7682aea8d9ce09ad4b9a3bd144b451eaa]
stable/6.6: [c127dbd832bd4b9aef8a749d9f491b74042f9b47]
stable/7.1: [7d69235bdc581a4346e9bcd6a8bea37d3e1abd25]

CVE-2026-64511: ACPI: NFIT: core: Fix possible NULL pointer dereference

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64511

Introduced by commit 9b311b7 ("ACPI: NFIT: Install Notify() handler
before getting NFIT table") in v6.6.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [027e128abb82788189d6d45b68e3e8e7329b67be]
stable/6.12: [3c8f73b0fbdf956c98e2329d5aaea3ad09a9cfb6]
stable/6.18: [452945662fd8e9862a2d2043239c7ee1815d1ac4]
stable/6.6: [a44343fe230aa48c74ef09830f3c5c90848b257e]
stable/7.1: [873576e585da5d0fc5debbab74eed565c0acea99]

CVE-2026-64512: ACPI: CPPC: Suppress UBSAN warning caused by field misuse

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64512

Introduced by commit 2f4a4d6 ("ACPI: CPPC: Use access_width over
bit_width for system memory accesses") in v6.9-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [1b1acf2dada0cc3931bb2cb9ff8832edfbee46a1]
stable/5.15: [a6385fccc82a7773250626a5bdc7a5b4098e33de]
stable/6.1: [e904596ba6dd108534ffa15e3e46b2fe245145e2]
stable/6.12: [37f28bf8f14672dfa395994e41fd778a63f0bf5c]
stable/6.18: [f29dc6132d4968e39d8fa575d1a12e2c718ce57b]
stable/6.6: [2fb80e962029000959f651665baa4838cc92eb99]
stable/7.1: [dc066bd13c860bb27d6ace511210e18b8064c1d9]

CVE-2026-64513: KVM: x86: Unconditionally recompute CR8 intercept on PPR up=
date

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64513

Introduced by commit eb90f34 ("KVM: vmx: speed up TPR below threshold
vmexits") in v4.11-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bb365a506b1e6fb050c0fceaad354fe395385ef0]
stable/6.18: [ff9c4c6428883182960cfe5c78928f0896d80ebc]
stable/7.1: [8c8e8ac22ee17d52f9eb2bc814bca7fab90fb8df]

CVE-2026-64514: userfaultfd: gate must_wait writability check on pte_presen=
t()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64514

Introduced by commit 369cd21 ("userfaultfd: hugetlbfs:
userfaultfd_huge_must_wait for hugepmd ranges") in v4.11-rc1.
Introduced by commit 63b2d41 ("userfaultfd: wp: add the writeprotect
API to userfaultfd ioctl") in v5.7-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e80af52db652fbc41320eee45a4f73bc029faf2]
stable/5.10: [a5700a4c1c9099ac2ac73fe8a09cf059972e0d2f]
stable/5.15: [d4026417e8184d13850a0bad4d96ceb6ed9f7152]
stable/6.1: [29e6f952c5fb7dc1d6b90fe5b7f36063d44ddae0]
stable/6.12: [a6e9a4939e359599701b1da351e84f72e021443a]
stable/6.18: [60d696a037eeeedfb57756dfe7ec08a1587c8631]
stable/6.6: [5f4dbdb0a87596214076b20b94f2b71b522170b3]
stable/7.1: [710183888174639a15fcec16cd1af766b8480bb7]

CVE-2026-64515: wifi: mac80211: fix MLE defragmentation

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64515

Introduced by commit 4d70e9c ("wifi: mac80211: defragment
reconfiguration MLE when parsing") in v6.9-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a74e893f30db64cdce0fc7a96d3baa417bcd55f5]
stable/6.12: [1f573e17bcb7275ddd1c8f47f46ae0faf0e902a4]
stable/6.18: [55c479aae99b120489a432db9c717484e523dfd6]

CVE-2026-64516: drm/amdgpu/vce1: Fix VCE 1 firmware size and offsets

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64516

Introduced by commit d4a640d ("drm/amdgpu/vce1: Implement VCE1 IP
block (v2)") in v6.19-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e5a1d5bb2ff061e64c7992f8e5404dfd4c2d0f3]

CVE-2026-64517: drm/xe/gsc: Fix double-free of managed BO in error path

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64517

Introduced by commit 2e5d47f ("drm/xe/uc: Use managed bo for HuC and
GSC objects") in v6.12-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3ded53fab90996e7d94a39049e11962dd066725]
stable/6.12: [7cb975fcd4777e7bad688f66aa0c10c16dd8276b]
stable/6.18: [2c890e71ae26fa32f5a96c3694b71a2c310940e7]

CVE-2026-64518: tcp: Fix out-of-bounds access for twsk in
tcp_ao_established_key().

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64518

Introduced by commit 6b2d11e ("net/tcp: Add missing lockdep
annotations for TCP-AO hlist traversals") in v6.13-rc1.
Fixed in v7.1-rc4.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [03cb001ef87b3f8d859cf7f96329acf3d6235d29]
stable/6.12: [87bb3e719042f0030a6dad39118c6a6b2a491ad9]
stable/6.18: [510db031ba6eb40134f84c90ef963ea4b6dfb878]

CVE-2026-64519: NFSD: Fix infinite loop in layout state revocation

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64519

Introduced by commit 1e33e14 ("nfsd: allow layout state to be
admin-revoked.") in v6.9-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f8ef58c10bfe5f86a643c7c8331b37e69e3dae1]
stable/6.12: [d1fc00ec02e9deb3f8d2bd59caf938c554fbc576]
stable/6.18: [fe59ae27d7346245f5d8d97220f374e63efd28b5]

CVE-2026-64520: firmware: arm_ffa: Bound PARTITION_INFO_GET_REGS copies

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64520

Introduced by commit ba85c64 ("firmware: arm_ffa: Add support for
FFA_PARTITION_INFO_GET_REGS") in v6.12-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3974ea1938406f9bfa7c1f48d4e43533f447bb08]
stable/6.18: [f39bc7ebe75e2186b417a024a7f7e2fd4cc7eb95]

CVE-2026-64521: pinctrl: meson: amlogic-a4: fix deadlock issue

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64521

Introduced by commit 6e9be3a ("pinctrl: Add driver support for Amlogic
SoCs") in v6.15-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e72ce029810390eb987a036fb2c8a5da9a23b685]
stable/6.18: [e917713f013423069782ff554935c7a5d4266783]

CVE-2026-64522: net/mlx5e: Fix eswitch mode block underflow on IPsec acquir=
e SA

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64522

Introduced by commit 22239eb ("net/mlx5e: Prevent tunnel reformat when
tunnel mode not allowed") in v6.18-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [abe003b33223ff33552f291644bf35d9c2f992fb]
stable/6.18: [b5bd4249e430f5963d559708ee96a671716d2400]

CVE-2026-64523: net/handshake: Take a long-lived file reference at submit

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64523

According to the .vulnerable file, this bug was introduced by commit
3b3009e in v6.4-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [09dba37eee70d0596e26645015f1aa95a9848e9d]
stable/6.12: [685b10dd0e32c7782cead16c8cf055c609678583]

CVE-2026-64524: drm/hyperv: validate resolution_count and fix WIN8 fallback

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64524

Introduced by commit 76c56a5 ("drm/hyperv: Add DRM driver for hyperv
synthetic video device") in v5.14-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [13d33b9ef67066c77c84273fac5a1d3fde3533d1]
stable/5.15: [96f7de3172d4aa878b7f87173b2b3507c350fcd6]
stable/6.1: [bc573752f3dac0d1ab8df7078c1851bc76717653]
stable/6.12: [a321c908f2eeea01539668eb270d074d9b88e490]
stable/6.18: [9c698b2c43c2667c34f5336bf46ad5786216ac2a]
stable/6.6: [1fb565b77b8f44afabb02de6310065f109d89e94]

CVE-2026-64525: xfrm: move policy_bydst RCU sync from per-netns .exit
to .pre_exit

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64525

Introduced by commit 069daad ("xfrm: Wait for RCU readers during
policy netns exit") in v7.0.
Fixed in v7.1-rc6.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [3e52417318473782012b236d0325bf7d2266a597]
stable/6.12: [bca6386dc08750fc7cdcbc7683473748ba3114b9]
stable/6.18: [91cc13978ab0bc6f669139f53e7e613a860d10e0]

CVE-2026-64526: ethtool: tsconfig: fix missing ethnl_ops_complete()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64526

Introduced by commit 6e9e2ee ("net: ethtool: Add support for tsconfig
command to get/set hwtstamp config") in v6.14-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6386bd772de64e6760306eb91c7e86163af6c22f]
stable/6.18: [d02342d9bb4f0ab682f1846a4fbc15dd2955f7e6]

CVE-2026-64527: drm/hyperv: validate VMBus packet size in receive callback

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64527

Introduced by commit 76c56a5 ("drm/hyperv: Add DRM driver for hyperv
synthetic video device") in v5.14-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f87763f47a3c22fb50265a00619ef10f2394b18]
stable/5.15: [57d5d697642e05d5dd2d40660817765943dd709f]
stable/6.1: [f5251226551bfec98c4705641b6f94ff1f238d91]
stable/6.12: [588c84b461393ff1998ac7b97b04f953f642e0df]
stable/6.18: [164dc7bf17609340233c6bf4f66bb7c7008a0511]
stable/6.6: [049a6b474823049fe60212f25f26e4b30f44ee8f]

CVE-2026-64528: tty: serial: samsung: Remove redundant port lock
acquisition in rx helpers

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64528

Introduced by commit b497549 ("[ARM] S3C24XX: Split serial driver into
core and per-cpu drivers") in v2.6.27-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3bb136bff5e6a5e48cdd813246c9c4686feaaa9]
stable/5.10: [ee9eb72be95490602c493db050c73d925c3a4d74]
stable/5.15: [10014eb7eee351f7b587f8ac85830f0c9343cb9a]
stable/6.1: [f4c3e63fa8639aedf96fb200d9939945a9eed51e]
stable/6.12: [14143ec10d69f42806b5d7b046f0fd1b835831ae]
stable/6.18: [9fd48937046efc9abb89379d63ee9cc5c661d711]
stable/6.6: [a9c22e0f93ba18322a6623ecdda2f0cd858ca350]

CVE-2026-64529: crypto: qat - remove unused character device and IOCTLs

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64529

Introduced by commit d8cba25 ("crypto: qat - Intel(R) QAT driver
framework") in v3.17-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d237230728c567297f2f98b425d63156ab2ed17f]
stable/5.10: [071590a44cbc38483fceb1ab943363ec26868e1b]
stable/5.15: [1de076f43e64bf65fbe7280a269c70e0e60518df]
stable/6.1: [a4999664a5ef77bdb0c6e6b935f581ac8ce6b63a]
stable/6.12: [b1ea97076bd0a5196290deba172034e480646727]
stable/6.18: [b8ebf008696de1ec08c90d51f94d7e40bd448be1]
stable/6.6: [6848a6e39cac44fdb7cb88f0f777df62172d1551]
stable/7.1: [3ae49dd04dbb11fb73f17f58a982dba128abe83a]

CVE-2024-14040: net: nexthop: Increase weight to u16

Announce: https://www.cve.org/CVERecord?id=3DCVE-2024-14040

According to the .vulnerable file, this bug was introduced by commit
283a72a in v5.13-rc1.
Fixed in v6.12-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b72a6a7ab9573e06d5c2fcb92eaa28614a735bfd]

CVE-2026-64530: net/sched: cls_api: Handle TC_ACT_CONSUMED in tcf_qevent_ha=
ndle

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64530

Introduced by commit 3f14b37 ("net/sched: act_ct: fix skb leak and
crash on ooo frags") in v6.8-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [a8a02897f2b479127db261de05cbf0c28b98d159]
stable/5.15: [5ed3d6f85991656667059d3fa5a1d683ac58c447]
stable/6.1: [f42e8134a3a1074b834a574d404352f867ba994a]
stable/6.12: [e1270e69dcf2c3512c453484178f2e9dc0db3f05]
stable/6.18: [2140c2f3f2e7b066e1ae616ede8856cafd8015e9]
stable/6.6: [447d493034a9cf7bf13a2abac86d0573d907ec2f]
stable/7.1: [e28aedab9488343924d227b5a896faed67ce84d5]

CVE-2026-64531: net: openvswitch: reject oversized nested action attrs

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64531

Introduced by commit a1e64ad ("net: openvswitch: remove misbehaving
actions length check") in v6.14-rc7.
Fixed in v7.2-rc4.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [3f1f755366687d051174739fb99f7d560202f60b]
stable/5.15: [ab855641241387db062a5e41d9ad6b8561542572]
stable/6.1: [c66bd2626c2764f23764ff0f8277f44a9cfe8349]
stable/6.12: [f1efff8858403191361a01269c6fe8dd7f55a385]
stable/6.18: [dbd14f736be02cfe73049bd801af89becd1a0749]
stable/6.6: [d573250d228401f707f4dbc09d11227a6215ee5f]
stable/7.1: [1b41cbe05b184f8861712f0806cc0c4f5d8c6dfe]

CVE-2026-64532: fs/ntfs3: bound NTFS_DE view.data_off in
UpdateRecordData{Root,Allocation}

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64532

Introduced by commit b46acd6 ("fs/ntfs3: Add NTFS journal") in v5.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e127829e57f5190f612412ece4541cb96d5ec7a]
stable/5.15: [b20e5a709d8bd190d6e4645606763c7423e694c1]
stable/6.1: [d41b382068ca4e64e421f736cdd700095464b6ac]
stable/6.12: [315d3a9a48b49f889da3d858a9307e677cb9e1bd]
stable/6.18: [be306b8d9143a9c076c804a7ca025d69caf9c448]
stable/6.6: [429d653ca641d38a78609b8f62e81a0a5c780a2d]
stable/7.1: [36feda687afebae24c472202694448738809c411]

CVE-2026-64533: fs/ntfs3: validate lcns_follow in log_replay conversion

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64533

Introduced by commit b46acd6 ("fs/ntfs3: Add NTFS journal") in v5.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6a4c53a2e26a865565bd6a460961e8d6fcb32329]
stable/5.15: [ca343a99806b4fc8e27c48f08be3445c5fcd1445]
stable/6.1: [ddfc8683e1a627dbf1b83bacf8961443dd654258]
stable/6.12: [159f694d682e4215b3822ae31ed3a4631628fe55]
stable/6.18: [7adb38279812c9c06b0e3fa7382f4d7887f3fa2d]
stable/6.6: [57c071e2c4f30b9c6f5aacb6679aab1269fbae99]
stable/7.1: [32b9f8733feb241627fa5f564b1a99b5cae974c5]

CVE-2026-64534: nvmet-tcp: check INIT_FAILED before nvmet_req_uninit
in digest error path

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64534

Introduced commit is not determined.Fixed in v7.1-rc2.


Fixed status
mainline: [4606467a75cfc16721937272ed29462a750b60c8]
stable/5.10: [22ec7a9fe9153d2737ee9b2fa6d2e43a1491decf]
stable/5.15: [ba35b1c674ca3841c0dfadd698f2c1b3ec542d4e]
stable/6.1: [c7874dad84b20433c0fe3919f291a762d40de08b]
stable/6.12: [d306da8833e75f669d93424fd84940236f3850bc]
stable/6.18: [2ed3c9d955e8cd6361f130623baa664a75fb345f]
stable/6.6: [e602c93b25bda4a9d0ff1791a4bdbfdcbb074af1]

CVE-2026-64535: nvmet-tcp: Fix potential UAF when ddgst mismatch

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64535

Introduced commit is not determined.Fixed in v7.1-rc4.


Fixed status
mainline: [dbbd07d0a7020b80f6a7028e561908f7b83b3d5a]
stable/6.1: [96fe2513df590e74b04253a45089cae75569570e]
stable/6.12: [6f9442983a3e4227afd1c83a5251ddbca585ea21]
stable/6.18: [088ee46c18d99baef453afd74181dd40ade044ad]
stable/6.6: [e091ff83d962f9ed00d9bd70443676de9fe98bdc]

CVE-2026-64536: staging: rtl8723bs: fix OOB reads in is_ap_in_tkip() IE loo=
p

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64536

Introduced by commit 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in v4.12-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3bf39f711ff27c64be8680a8938bcc5001982e81]
stable/5.15: [ea3809f7e20bdff282b8cc1e94937d5fb9fb32c7]
stable/6.1: [d2055332297e24c63fffda943ef7a5eefc0a6019]
stable/6.12: [204b22c8df115370037248859bf0fa62db73a396]
stable/6.18: [a6105ea8ca6ebbc04beaf3bcbf7dbb5985f5d395]
stable/6.6: [6f26cc55affd9d7f88ae2f5d12db4ecf9072c209]
stable/7.1: [4380b3860d887a13555ff024a58dfc05b490dfd6]

CVE-2026-64537: bridge: cfm: reject invalid CCM interval at configuration t=
ime

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64537

Introduced by commit 2be665c ("bridge: cfm: Netlink SET configuration
Interface.") in v5.11-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f3e02edd8322b31b8e6517faa6ba053bf29d1e26]
stable/5.15: [2870056a78961e0fecd652362ee9d3fcfd24a8a6]
stable/6.1: [f0f5eb59a97ece0d85de8cfa95dc18c609302a8b]
stable/6.12: [b42aeb58317f12024734759ff745856b53948873]
stable/6.18: [a090880c1f544589427e5b7050c40fb211ccecb4]
stable/6.6: [53788b134519e995699ea3721969c96a08d64575]
stable/7.1: [865643640b5b5c4579b32d7a55ac9ad648362eaa]

CVE-2026-64538: ipv6: Fix null-ptr-deref in fib6_nh_mtu_change().

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64538

Introduced by commit c0b220c ("ipv6: Refactor exception functions") in v5.3=
-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [46c3b8191aad3d032776bf3bebf03efdf5f4b905]
stable/5.10: [d08d019f2f43a6f9a71e81868bbc326b3afaf37b]
stable/5.15: [1451deca9896957159f0666520a792c1b861af4f]
stable/6.1: [b2c70dd3326809429b709a9c7e9220d29923051a]
stable/6.12: [80600b5d0f3ecb9324120dc95b5e915130f516c5]
stable/6.18: [b0d0eb13a0441a8ebf4f227843deaf494f1e2c33]
stable/6.6: [302d57ed7872838b40e56a868fb4c7da7da606e9]
stable/7.1: [6428634f7a0b7878144b4925c37856bef3224967]

CVE-2026-64539: Bluetooth: eir: Fix stack OOB write when prepending the Fla=
gs AD

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64539

Introduced by commit b44133f ("Bluetooth: Support the "discoverable"
adv flag") in v4.1-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f5fb689fdf80bdd143f22a502f9eb1f3c85e286]
stable/6.1: [0f0b6232af56441d0a2dcb173cc4f8d8aab39014]
stable/6.12: [09301f1fdf2aef8cce34d0c4650c30e7edb1ced9]
stable/6.18: [f1b4df9c260c51726da2e86e19322825fddeefd0]
stable/7.1: [57077eeb586c42f124bc09e018449362223067b3]

CVE-2026-64540: usbnet: gl620a: fix out-of-bounds read in genelink_rx_fixup=
()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64540

Introduced by commit 47ee305 ("[PATCH] USB: usbnet (5/9) module for
genesys gl620a cables") in v2.6.20.16.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ff7f2a6da4fccaa5cc9be7251a24e71e29fbd1a]
stable/5.10: [255d03551f94c7bdd86c7d9181a70b21917d829f]
stable/5.15: [4359376e6238d89977a35086e47ca3b07f43e850]
stable/6.1: [8624e179fa3ce23c2fbd1a198ce30764b73f054a]
stable/6.12: [0575599e451aff3c5329922562374a2cab25fc51]
stable/6.18: [0a7d9c7c5f1f208c523abbb4db6aea7bc1fad3db]
stable/6.6: [573418f7ea8f859a841417eb4b915594094fd967]
stable/7.1: [3ef79fa3860e644c8de7834fa7300e1c58f38862]

CVE-2026-64541: net/smc: fix UAF in smc_cdc_rx_handler() by pinning the soc=
ket

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64541

Introduced by commit d7b0e37 ("net/smc: restructure CDC message
reception") in v4.18-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9d160b35cc34a2ba8229d07651468a7848325135]
stable/5.10: [8de4f665d0febfb92803dece377791a563fc7041]
stable/5.15: [8145b432136285e01091815b48ceb2dae261f262]
stable/6.1: [1951bffbc6493ec34cff3956b29d4bc6606904a6]
stable/6.12: [472e9d7c0d5b03be3ff91ff941f57da822b031bc]
stable/6.18: [3bfb96d9bc6a7ed0b99c7db329cc2e22a28d84bb]
stable/6.6: [647b19e5cc145a2f1f685ae8ff3805a17356888c]
stable/7.1: [ce5aa8084329351086894aa34d77e40301d5bd3d]

CVE-2026-64542: ipv6: ndisc: fix NULL deref in accept_untracked_na()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64542

Introduced by commit aaa5f51 ("net: ipv6: new accept_untracked_na
option to accept na only if in-network") in v6.0-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d186e942365acece7c56d39da05dd63bf95b280a]
stable/6.12: [62c719203cb521b64fab74da94a81bdde5c18808]
stable/6.18: [a6450f7cfae57b382cbaf66a577765c9a88b3c58]
stable/7.1: [63d1c23764de2309cedbb779c75188d257a09d9b]

CVE-2026-64543: tipc: fix use-after-free of the discoverer in tipc_disc_rcv=
()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64543

Introduced by commit 25b0b9c ("tipc: handle collisions of 32-bit node
address hash values") in v4.17-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1579342d71133da7f00daa02c75cebec7372097b]
stable/6.12: [ec7d54d8cc1723921d671e3272b427c96366506f]
stable/6.18: [a0c5fdeb5fa257f8c6d469af266bc087cb5de6a2]
stable/6.6: [5e215bf1c47fdddf8203a0fe80a0ed594065f101]
stable/7.1: [b65289e1c3f352a9f92c6e19713ddd647e033253]

CVE-2026-64544: crypto: asymmetric_keys - fix OOB read in
pefile_digest_pe_contents

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64544

Introduced by commit af316fc ("pefile: Digest the PE binary and
compare to the PKCS#7 data") in v3.17-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7dd32c5179d7755de18e21d5674b08f9e5cb180]
stable/5.10: [89efd998470a93284b7ad5a20d4e0e3c6858ae8e]
stable/5.15: [7016377699b5b25b7ec3c0bf2ec3f983c7e95f7c]
stable/6.1: [b798ada5a5d1cb4cc4cfa72074b1b463eca6c506]
stable/6.12: [e162bc386e71b5412425a38ee048e8d2185491b9]
stable/6.18: [6acd2fbd00f9c72aebefce63fc2e73e8f3d79061]
stable/6.6: [627938383761fb4334b41ebe7ef438d6b8b19d60]
stable/7.1: [803591785d33cf13b6f73ce2796e8b9e6d5e6526]

CVE-2026-64545: net, bpf: check master for NULL in xdp_master_redirect()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64545

Introduced by commit 879af96 ("net, core: Add support for XDP
redirection to slave device") in v5.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e82d8cc4321c373dc46e741cd2dfdaa7921fddb7]
stable/5.15: [c99ca049e910d61ddbd28cc2c47242f2bfbb4970]
stable/6.1: [e2a56441233131fe18a76001de347ecda217e40c]
stable/6.12: [4edbcacca09f92b85d3951b6add11894b20a84bc]
stable/6.18: [03b743586a2469744e96e9c1015096d07240935d]
stable/6.6: [3876318ea54e83eb70982b8280a3c5e4e32269bf]
stable/7.1: [89c103d702b25ceb2d097faf854deb47b53b17ff]

CVE-2026-64546: drm/edid: fix OOB read in drm_parse_tiled_block()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64546

Introduced by commit 40d9b04 ("drm/connector: store tile information
from displayid (v3)") in v3.19-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [faaa1e1155833e7d4ce7e3cfaf64c0d636b190db]
stable/5.10: [c4ab04ca1bbf87eefa9fec5c80e1880450d2e7c0]
stable/5.15: [9acd5c1ddc17ca4c5ffa0c373e3fdf480506e061]
stable/6.1: [157727131ce8a52d8d9bc676c372ef82db6436c4]
stable/6.12: [4f5484d25f85ad6c989bad5f6a43450cecfcfd28]
stable/6.18: [9cc0f8e63e8c34cf43def35cbd305ba711181a1f]
stable/6.6: [bfa05d89dc3ca3fb1a9099ef5185549a5ec8490d]
stable/7.1: [4137e1ecec9c8cb6c4fcee28ffabbbc7409eb7fb]

CVE-2026-64547: net: usb: net1080: validate packet_len before pad-byte
access in rx_fixup

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64547

Introduced by commit 904813c ("[PATCH] USB: usbnet (4/9) module for
net1080 cables") in v2.6.20.16.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [03f384bc0cb8d4a1301d4f5b0baef2d980258383]
stable/5.10: [f42217fa7d535e9ec4151f7971f06f6ea65e850a]
stable/5.15: [c087749815379e9af2fdbeb08bfc33870b103958]
stable/6.1: [e4a87126c085b097d29e17e3b7647295bba8be7c]
stable/6.12: [4dc8484be3302d187274364820d3bef6c62bde32]
stable/6.18: [b153cfe84b1340c69a13d0957665a2bfcf21239c]
stable/6.6: [685e92934f11d5e215dad58813e2f9955ac2f436]
stable/7.1: [ea866cab12db1a2100b400a8b03569e5bc0ee29a]

CVE-2026-64548: bpf, sockmap: reject overflowing copy + len in
bpf_msg_push_data()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64548

Introduced by commit 6fff607 ("bpf: sk_msg program helper
bpf_msg_push_data") in v4.20-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c0a8ed85349dae298712d79cb276acfeb794d82]
stable/5.10: [f1644c9508d24f50dd9e8ebe8d3ba86e0996d2f5]
stable/5.15: [a12b1575f9feabd91695a9e9d004862f7195fa25]
stable/6.1: [ff39d0e3b4feeb65ca43c453d7c75fdf872ded0d]
stable/6.12: [db77b6bb6e6edb79b10b4efcce346eec5582d588]
stable/6.18: [4e40056bb5c829f0423f0a6694a0477726d2147e]
stable/6.6: [888706a76286c547bd035432602571e8024b5305]
stable/7.1: [bd004716ba75fed6d185795c85cdc92540ebeaab]

CVE-2026-64549: Bluetooth: bpa10x: avoid OOB read of revision string
in bpa10x_setup()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64549

Introduced by commit ddd68ec ("Bluetooth: bpa10x: Read revision
information in setup stage") in v4.4-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd068ef044128db655f48323a4acfd5907e04903]
stable/5.10: [1813add71e386f77b3040e6c8dc9b7b3ff965a6c]
stable/5.15: [bd56c23f1f8681a2857ee924a8bd3abf87c8913b]
stable/6.1: [7a64f39ebe1bacd9004a62eceadac0b122ec3cc2]
stable/6.12: [4b4008dda1d0c6e598d7865631ad4eda63a560f0]
stable/6.18: [bfc9e7be289df11e8e38c98cd78019d67fdd0bd5]
stable/6.6: [f80b4afe893dffa9fabdbf80fb4d6782b24a6793]
stable/7.1: [a8e169d308775039200bb9c905c7ce420db6e8c5]

CVE-2026-64550: net: qualcomm: rmnet: validate MAP frame length before
ingress parsing

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64550

Introduced by commit ceed73a ("drivers: net: ethernet: qualcomm:
rmnet: Initial implementation") in v4.14-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0f1887a9e30712a1df03e152dce6fb91344b1f3]
stable/5.10: [ed25befc8c36f896b5878f9078faddb67fd7e2d0]
stable/5.15: [a54d76d176e50d2fdbd39b7231efe256170339e4]
stable/6.1: [00f4c366dbca16a40772c3b7ec2d8cba839e9724]
stable/6.12: [14eb0c9491385d5361a292ea4974aec0e6887299]
stable/6.18: [1b12612c367e4be9b0814c0468e7e687835315b4]
stable/6.6: [3868c3244369ab709a90c9aad7534d406009b824]
stable/7.1: [231a8a4b76cb1b1827b3b19d7b3603642f5aaaef]

CVE-2026-64551: sctp: validate STALE_COOKIE cause length before
reading staleness

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64551

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1cd23ca80784223fa2204e16203f754da4e821f8]
stable/5.10: [6022da37786701df1fc5dd946a6dcba59d5473b1]
stable/5.15: [861f884f5471632c731cbbd612a1c072e391a624]
stable/6.1: [588706ebaf8cdb4a4161602949eba365514b1db1]
stable/6.12: [08a8f2d13f703924316e9aeac863a88ef50990c7]
stable/6.18: [ebe0a55d954fa8da383b6192edb8f763dcb002d5]
stable/6.6: [a257b41ddfe9e327b26581ad2777f04b23ac73f5]
stable/7.1: [bbd6b2ea966cf57b6ae095cf5a8dbc993cd197a0]

CVE-2026-64552: virtio-net: fix len check in receive_big()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64552

Introduced by commit 0c71670 ("virtio-net: fix received length check
in big packets") in v6.18-rc5.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [9e5ad06ea826322ce8c58b4a68442a96f600c3c4]
stable/6.1: [f9451d0fd5ba635dcabb49bfe456a6db734a8986]
stable/6.12: [fbeb65154583879d556ea94cb2f15888e9470f3d]
stable/6.18: [c7fc9adf4e006155f7f2aeda052fbcde25cdcc49]
stable/6.6: [38e94d63e29f4a5c6eae87ee2c02101aaa321502]
stable/7.1: [e6b8463b7d791f3886d7584259d6e9f06a69f12e]

CVE-2026-64553: net: psample: fix info leak in PSAMPLE_ATTR_DATA

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64553

Introduced by commit 6ae0a62 ("net: Introduce psample, a new genetlink
channel for packet sampling") in v4.11-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aedd02af1f8b0bceb7f42f5a21c41634ca9ed390]
stable/5.10: [0d3ea2ccddda442077fc44f11d873209c97ec50b]
stable/5.15: [7fe7e6949964aa8ee6305f09db2dc9eede977bb3]
stable/6.1: [e2fa322782a2d7d8078f7bb20817e0aa9f7c32e9]
stable/6.12: [48930f6c59fd0056c2de46ce52bfe27d9c9e5eb6]
stable/6.18: [a6cfb924ad74efce254e99c197d2e3863de70868]
stable/6.6: [befe1ebe7fc2c65c80074bc34ceeb0a721ed3cd2]
stable/7.1: [794a0d8bdbb39e083ed42caccb86d687a9b53570]

CVE-2026-64554: netfilter: bridge: fix stale prevhdr pointer in
br_ip6_fragment()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64554

Introduced by commit 764dd16 ("netfilter: nf_conntrack_bridge: add
support for IPv6") in v5.3-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [86f3ce81dd2b4b0aa2c3016c989a943e4b1b643d]
stable/5.10: [8c10778ec674b67a07ea042fcba64270f3f38a5a]
stable/5.15: [2731efa6364e47934c96eb69e01ea131e8af8030]
stable/6.1: [00c06ef8c018493943891a7d0ca82b71b24f3180]
stable/6.12: [f2e6596d10783557aeb9668da2a3b4d19deb2001]
stable/6.18: [1c4f67c89fd27c4df4c70b135c2c59627698b3c0]
stable/6.6: [c141f69d0a0fb16964dbc293650047e69bda8af7]
stable/7.1: [4ac981a8b7ce7aec99a52d08f8a8953e8e120067]

CVE-2026-64555: KVM: arm64: nv: Fix SPSR_EL2 restore in kvm_hyp_handle_mops=
()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64555

Introduced by commit 2de451a ("KVM: arm64: Add handler for MOPS
exceptions") in v6.7-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff1022c3de46753eb7eba2f6efd990569e66ff95]
stable/6.12: [10a568010e827108d149779908850afaec898846]
stable/6.18: [884b44256041ec6b2dcbe8e6a67384d26145cba1]
stable/7.1: [dd3b237eb7780d65eae296d3d3a70012b6e7a02f]

CVE-2026-17523: Kernel: can:bcm: arbitrary kernel code execution
leading to escalate privileges

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-17523


According to the RHBZ 2507407, 2 vulnerabilities are reported. The one
is this CVE and the other is CVE-2025-38004. This bug was fixed by
bf74aa8 ("can: bcm: switch timer to HRTIMER_MODE_SOFT and remove
hrtimer_tasklet") in v5.4-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [79305a826f872fe446c6fbf8450f515053ef6951]
mainline: [bf74aa86e111aa3b2fbb25db37e3a3fab71b5b68]
stable/4.19: [79305a826f872fe446c6fbf8450f515053ef6951]

CVE-2026-64556: perf/core: Detach event groups during remove_on_exec

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64556

Introduced by commit 2e498d0 ("perf: Add support for event removal on
exec") in v5.13-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [037a3c43edfb597665dd34457cd22b14692f2ba3]
stable/6.12: [39358e856fb89e62e3c8d7389a2dc4ec33dbe90e]
stable/6.18: [a2d5d3ee7b6e3953114726b1521e62123ab5b043]
stable/6.6: [4cdb1b3ab96eb1b7eb70bc5c82fede334bd60df2]
stable/7.1: [06ccef0434e98058ddae7bcebc901f93d22b7653]

CVE-2026-64557: Bluetooth: L2CAP: Fix use-after-free in
l2cap_sock_new_connection_cb()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64557

Introduced by commit 8ffb929 ("Bluetooth: Remove parent socket usage
from l2cap_core.c") in v3.13-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6fef032af0092ed5ccb767239a9ac1bc38c08a40]
stable/6.1: [b39298044e5534612511a2ff5de03ba5f6e7a820]
stable/6.12: [84e718b6a814edc84159361f9f454a4e92ae91ae]
stable/6.18: [36da806f7fbaee56ad9e81859deec203f9728700]
stable/6.6: [8c37e4338c801ebb8cee52436c01c41e009f6e87]
stable/7.1: [733e76e74e406c1d1ddc7369420dd8a47f48bb8a]

CVE-2026-64558: s390/pkey: Check length in pkey_pckmo handler implementatio=
n

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64558

Introduced by commit 8fcc231 ("s390/pkey: Introduce pkey base with
handler registry and handler modules") in v6.12-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1ac287e2af9a9112fe271427ef45eceb26bce8b4]
stable/6.12: [02028a24e26d85262ab9c8fc4344e1f3503007fc]
stable/6.18: [433e5e70cdc1edf382d28d08a885b22e2b98b7da]
stable/7.1: [614aa0491c7a190556c2345dddee0b6f5ed90989]

CVE-2026-64559: s390/pkey: Check length in PKEY_VERIFYPROTK ioctl

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64559

Introduced by commit 8fcc231 ("s390/pkey: Introduce pkey base with
handler registry and handler modules") in v6.12-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b3d4ab2d7df9426f7f1d3671d7e2108f2ca6e970]
stable/6.12: [0a9e34ccbe772b8f321388cdbdf4f22b94e513e7]
stable/6.18: [693bf91d4db134f9b1c2840c8e287eee3d993bac]
stable/7.1: [7e7e03848c918aa0acad5ffd75d929e3afec1554]

CVE-2026-64560: posix-cpu-timers: Prevent UAF caused by non-leader exec() r=
ace

Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-64560

Introduced by commit 55e8c8e ("posix-cpu-timers: Store a reference to
a pid not a task") in v5.7-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [920f893f735e92ba3a1cd9256899a186b161928d]
stable/7.1: [ad1cafa1bdaa71da85d71cac053838bbe97852b6]


* Updated CVEs

CVE-2022-0742: A memory leak flaw was found in the Linux kernel=E2=80=99s
ICMPv6 networking protocol, in
the way a user generated malicious ICMPv6 packets. This flaw allows a
remote user to crash the system.

stable/5.10 was fixed.

Fixed status
stable/5.10: [4463161e81e46be4bf8f94b2b4a75f5fa346ee15]

CVE-2022-3114: Kernel: Unchecked kcalloc return leads to null pointer
dereference.

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [6199da9712f9f9eaa117c044a91b48d157e1ab6b]
stable/5.15: [80d647a53cc2f90442dba921d1381ceadd75099c]

CVE-2022-48785: ipv6: mcast: use rcu-safe version of ipv6_get_lladdr()

stable/5.10 was fixed.

Fixed status
stable/5.10: [c49c69dc9f3e699fa3150aca7b189eea707b4047]

CVE-2022-49662: ipv6: fix lockdep splat in in6_dump_addrs()

stable/5.10 was fixed.

Fixed status
stable/5.10: [ea18594da69a09f68491da57f9fa09f003efbbc7]

CVE-2023-52494: bus: mhi: host: Add alignment check for event ring read poi=
nter

stable/5.10 was fixed.

Fixed status
stable/5.10: [76ed0c6f6418cec6efe6f65a0b91f84be80b72eb]

CVE-2024-26631: ipv6: mcast: fix data-race in ipv6_mc_down / mld_ifc_work

stable/5.10 was fixed.

Fixed status
stable/5.10: [75ddcd741d2a30696f5893bc71a9d28f4ef22311]

CVE-2024-27012: netfilter: nf_tables: restore set elements when delete set =
fails

stable/5.15 was fixed.

Fixed status
stable/5.15: [2cf64b16ac55c42c8989d8c819e42a77549cd680]

CVE-2024-27390: ipv6: mcast: remove one synchronize_net() barrier in
ipv6_mc_down()

stable/5.10 was fixed.

Fixed status
stable/5.10: [bfd2f3c58ad86ad33db80515e6c3503e0414e44b]

CVE-2024-36013: Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_connect(=
)

stable/6.1 was fixed.

Fixed status
stable/6.1: [8629a65a48890769c47ebc9b6e57c02a80a8975e]

CVE-2024-42132: bluetooth/hci: disallow setting handle bigger than
HCI_CONN_HANDLE_MAX

stable/6.1 was fixed.

Fixed status
stable/6.1: [2ae8d7742a09c275872e670c53337b3dcedaa11c]

CVE-2024-42133: Bluetooth: Ignore too large handle values in BIG

stable/6.1 was fixed.

Fixed status
stable/6.1: [a06a8cc80fa203fde828a8429583f7e4fe27eca4]

CVE-2025-38349: eventpoll: don't decrement ep refcount while still
holding the ep mutex

stable/6.1 was fixed.

Fixed status
stable/6.1: [b0821ec902d39062356cb644c16e17a705d1c9f5]

CVE-2025-38550: ipv6: mcast: Delay put pmc->idev in mld_del_delrec()

stable/5.10 was fixed.

Fixed status
stable/5.10: [1b5b413094af8d88a31b5df3fd262f6baca53841]

CVE-2025-39729: crypto: ccp - Fix dereferencing uninitialized error pointer

stable/6.12 was fixed.

Fixed status
stable/6.12: [26eb4fceaf8cad2b92255baf7f185b0a1e3f070c]

CVE-2025-39936: crypto: ccp - Always pass in an error pointer to
__sev_platform_shutdown_locked()

stable/6.12 was fixed.

Fixed status
stable/6.12: [fa30d62ab62d8a123f20febaca4390525e2d2ad5]

CVE-2025-40196: fs: quota: create dedicated workqueue for quota_release_wor=
k

stable/6.1 was fixed.

Fixed status
stable/6.1: [8df2eedd371a1c24ecc4283581299d7737dfcd06]

CVE-2025-71289: fs/ntfs3: handle attr_set_size() errors when truncating fil=
es

stable/6.6 was fixed.

Fixed status
stable/6.6: [92300ac7ff17cad67ff2f3fbb7003afa326134e0]

CVE-2026-23451: bonding: prevent potential infinite loop in bond_header_par=
se()

stable/6.6 was fixed.

Fixed status
stable/6.6: [9532d0d0ad1d726c06f807e8f0f1ec93cbabb452]

CVE-2026-31499: Bluetooth: L2CAP: Fix deadlock in l2cap_conn_del()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [d77e38f6a48469df0d30a66afc20b5fb218786d3]
stable/5.15: [8a300067d94a81b75a7ad87dad6de027ae859a82]
stable/6.1: [665f7f117375f076667c3ff27e98d0c4c67f7d5f]

CVE-2026-31502: team: fix header_ops type confusion with non-Ethernet ports

stable/6.6 was fixed.

Fixed status
stable/6.6: [420e5aad7ba89e8f79e2dc8327b0c0c24c1c1d53]

CVE-2026-31610: ksmbd: fix mechToken leak when SPNEGO decode fails
after token alloc

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [ae9cdb29efed20ffdee9ff3b0bb72fb369c353da]
stable/6.1: [bd4a7fb04f06f419b0e93d8b52fe32067eb312d1]

CVE-2026-31703: writeback: Fix use after free in inode_switch_wbs_work_fn()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [382cf81cae89e58d22b4bdc38891cd4d0b9ba921]
stable/6.6: [19ec404b079be057b387643ba0c69bbcc5867c35]

CVE-2026-31718: ksmbd: fix use-after-free in __ksmbd_close_fd() via
durable scavenger

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [0cfb57297a26ed55e6c7c8e4490065276accc2f0]
stable/6.1: [76d89d368a96ddeb72917abfcb76683f23f8a3ce]

CVE-2026-43119: Bluetooth: hci_sync: annotate data-races around hdev->req_s=
tatus

stable/6.6 was fixed.

Fixed status
stable/6.6: [e51042ddc0b20d9bda5eb6dcf85a2668f9c5dae4]

CVE-2026-43216: net: Drop the lock in skb_may_tx_timestamp()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [4839cbda8f13e99ce2bb3b593f5cc3288415684b]
stable/5.15: [3709d73ace37e9aaebb688f5a5cf706d74350b64]
stable/6.1: [cf7599116c4c0082fd25cb1bf0254631da0ed06e]
stable/6.6: [cd2463ec60f0d6e460078037c86f9d0947ee1ff6]

CVE-2026-43456: bonding: fix type confusion in bond_setup_by_slave()

stable/6.6 was fixed.

Fixed status
stable/6.6: [5d0fb9806ab6cf2c3cfba0e1b8c701da65e25af8]

CVE-2026-43499: rtmutex: Use waiter::task instead of current in remove_wait=
er()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [f3fa3424bceb128d2be4b3745506b22844b87db7]
stable/5.15: [838ce5cb5d93c3ab8b27e75bc6ad905a94b752fd]

CVE-2026-45944: iommu/vt-d: Clear Present bit before tearing down context e=
ntry

stable/6.12 was fixed.

Fixed status
stable/6.12: [c716a59e9977d751e5eb54bcfa6a80124cb5067b]

CVE-2026-46116: xfrm: defensively unhash xfrm_state lists in __xfrm_state_d=
elete

stable/5.10 was fixed.

Fixed status
stable/5.10: [6b4dc3181b4bfc5f5fc33ab33b1dc6e15759f4b6]

CVE-2026-46135: nvmet-tcp: fix race between ICReq handling and queue teardo=
wn

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [b7dd4d27aa70bd98bb10572310e913668baf6a65]
stable/5.15: [9c63cf80895a70eb4fcfcaa725bb1ac9ae76f02b]
stable/6.1: [6f96dea4819d122737b217ea16660d255abbf8c6]

CVE-2026-46242: eventpoll: fix ep_remove struct eventpoll / struct file UAF

stable/6.1 was fixed.

Fixed status
stable/6.1: [3e1144d2515d28e4312e663ea05eac203101491d]

CVE-2026-52942: netfilter: nf_log: validate MAC header was set before dumpi=
ng it

stable/5.10 was fixed.

Fixed status
stable/5.10: [2e96e1bc9b4d5450e6c33f078e19a9bc1dda6c0b]

CVE-2026-52972: crypto: af_alg - Cap AEAD AD length to 0x80000000

stable/7.1 was fixed.

Fixed status
stable/7.1: [0b3a57d218618cb1cc78ddc9ba02c07de84b46f4]

CVE-2026-53005: af_unix: Drop all SCM attributes for SOCKMAP.

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [48c41cd2e04af4b2cdef19e2d00994ae82952f14]
stable/6.18: [e0a71cbf0c1906a2eccbe69dd7d7f36fd1511d66]

CVE-2026-53027: fs/ntfs3: fix missing run load for vcn0 in
attr_data_get_block_locked()

stable/6.6 was fixed.

Fixed status
stable/6.6: [ea59d9dbc5504e29d420ac4aab774cbce39b0e69]

CVE-2026-53163: locking/rtmutex: Skip remove_waiter() when waiter is
not enqueued

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [bfbc047ceb42c0e1fac8f3a155d4548a8bbe76b1]
stable/5.15: [4ffacf76a457b7ca8ac05f5df8740b0d8f53574a]

CVE-2026-53260: tcp: Add preempt_{disable,enable}_nested() in
reqsk_queue_hash_req().

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [889fc99967007e2493833515a645cb2d800f6742]
stable/6.18: [de5a46f3b2c8d3cd20afa158bd3a725e3e3d6fd3]

CVE-2026-53332: slimbus: qcom-ngd-ctrl: Register callbacks after
creating the ngd

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [2047eeb38db878a31f58db19d98f8aedf284342e]
stable/6.1: [afc631e246936a40558f494112a4188401382671]
stable/6.6: [290014c7987636e6105bba89fa04cb4d59f775c1]

CVE-2026-53365: vsock/virtio: fix zerocopy completion for multi-skb sends

stable/6.12 was fixed.

Fixed status
stable/6.12: [293fe8f2d1b5ac464ca16a8eba09571bbbb34ba9]

CVE-2026-53366: ipv4: account for fraggap on the paged allocation path

stable/6.1 was fixed.

Fixed status
stable/6.1: [5c6375bced6147ec2e460ee3b653f4860d5ecdc2]

CVE-2026-53390: ksmbd: fix out-of-bounds read in smb_check_perm_dacl()

stable/5.15 was fixed.

Fixed status
stable/5.15: [c7488c85fd822959e9b5c22fbd9e7c8a21caf5e0]

CVE-2026-53392: NFSv4/flexfiles: reject zero filehandle version count

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [9033591535c066726f5b505126ccb4068b98fa4f]
stable/5.15: [18cc6d57a14fa65ab2a2b52279f549041c4bc9cf]
stable/6.1: [be7829715e341b42846437dd9e721005db59f0cc]
stable/6.6: [eeabb9020721db6bc132e68eeae380b8d4fb4b04]

CVE-2026-53393: nfsd: reset write verifier on deferred writeback errors

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [b8e5894e56cff70fa245628fe16f0ad6367f8090]
stable/5.15: [bc2baca02ec56da7707a74ed5d340b0a1dff1841]
stable/6.1: [43b65d2997963e80e8d8d86520bcb1e0751227de]
stable/6.6: [666e837b247fcadf2d8d508b9b0e49d720393eb4]

CVE-2026-53399: nfsd: release layout stid on setlease failure

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [d788ef40a7517d22c97ab01700e4ae4c611b6f2f]
stable/5.15: [2e0a5d6d62600b8c614d1b55e50ef94035d6adf9]
stable/6.1: [7bbb7ce74051c8be4b69ff44ce3db370600dae61]
stable/6.6: [48a586e382e4db1dbf958d44b63e081df5f8ed04]

CVE-2026-53400: i2c: core: fix adapter registration race

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [2e57c788e71f1763445f812eba4e0b4a2fbd0646]
stable/5.15: [a4365bc41baaf67f3a5aa8556d23544e6ec7480a]
stable/6.1: [1febb174815bcae56d73587e99e8f87e02f0784d]
stable/6.6: [da9d8d9711f78deebc202d0cffcf577e45ee8621]

CVE-2026-53402: fbdev: fbcon: fix out-of-bounds read in err_out of
fbcon_do_set_font()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [cb016bcb40c81e7b19c4ae6143babb366dae8e20]
stable/5.15: [ac562193c36696513ae196171892e9338475c4bc]
stable/6.1: [3618a4c5b2591cfa83efe74f5b18c2d02b35c3f5]
stable/6.6: [a7a526fbc847f07ad3a503c7382189be5ab68574]

CVE-2026-63797: rpmsg: char: Fix use-after-free on probe error path

stable/6.1 was fixed.

Fixed status
stable/6.1: [1306fc4f76f765727a6d5aefbf08ef0c8f32996f]

CVE-2026-63803: hdlc_ppp: sync per-proto timers before freeing hdlc state

stable/5.10 was fixed.

Fixed status
stable/5.10: [86d80a231bde4cfb64bfbfbfffd83056fc93628f]

CVE-2026-63806: KVM: Replace guest-triggerable BUG_ON() in ioeventfd
datamatch with get_unaligned()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [2426c15c1395b7d5ccf1e5025ca898af7f3decb6]
stable/5.15: [4186c850789906b875a1d263377a4d37c078e317]
stable/6.1: [36ff44fb3d89960391e013fb9d91e23dbc48be47]
stable/6.6: [92fc631b69deb1c7d56aec2663003600799dcd75]

CVE-2026-63810: block: Avoid mounting the bdev pseudo-filesystem in userspa=
ce

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [3d3fcf23993bb756de2f912ab631cfdcc4746554]
stable/6.1: [99cde0a7b1e98fd3970aabef1300918e91698dd5]
stable/6.6: [1a02a5028bd6dead1f8503854ef3168d651cd417]

CVE-2026-63815: f2fs: bound i_inline_xattr_size for non-inline-xattr inodes

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [3c8d6b4093aea40a20596f452289e7c22d84e6d5]
stable/5.15: [a08ee30dcbeff6b97df75c38c2589603ddde53a6]
stable/6.1: [c3e05522daae4e7348a1ea81eeb321d25aa0fd3b]
stable/6.6: [76e1a05cf6d4051931d7fa4ead51a05786a62918]

CVE-2026-63816: f2fs: atomic: fix UAF issue on f2fs_inode_info.atomic_inode

stable/6.6 was fixed.

Fixed status
stable/6.6: [7d3ae21783e5914c1761ac7d63f882d3d70800e9]

CVE-2026-63817: f2fs: validate compress cache inode only when enabled

stable/5.15 was fixed.

Fixed status
stable/5.15: [fcc051d377a9701a452e7663a1a8223c26225df9]

CVE-2026-63818: f2fs: validate orphan inode entry count

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [210c210c92d78fdf5051bc55c5c69044b1a2150a]
stable/5.15: [ad101d15716f5a24d1fa82a849f80430c805a3dd]
stable/6.1: [d18c81f5d0ecd5796aa47d66d98f2dd54d8d0f70]
stable/6.6: [d2f236196d542ccd8505736e41c3a1d3f0305f6f]

CVE-2026-63827: apparmor: fix use-after-free in rawdata dedup loop

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [643221da57dbb1a8fd800610331cf1ec27969f71]
stable/5.15: [b17f0c59cc1525765625cf07d0391b7f9c1ed7e5]

CVE-2026-63828: apparmor: mediate the implicit connect of TCP fast open sen=
dmsg

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [a16714e7cf2baa98ba2efddd5d6cbac641f4e76b]
stable/5.15: [20383429b56974507c465d016e5238b189f7a246]

CVE-2026-63829: net: ip_gre: require CAP_NET_ADMIN in the device netns
for changelink

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [19275943d8fe903eb7b9aa53e380e41efd042ada]
stable/5.15: [866b0f5ae599490bd496fd84581c68ac8b94e6af]
stable/6.1: [92b766fc55156e0da2ecd0c2302c971118f8a229]
stable/6.6: [e54c05ed3d9c28733fb9e5837219aca3691defa3]

CVE-2026-63830: net: skmsg: preserve sg.copy across SG transforms

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [f126eed589eec6f201405abbc398844042ef6d57]
stable/5.15: [31a110642b5fb5e61940cbcfb503445ac4f28017]

CVE-2026-63970: vsock/virtio: bind uarg before filling zerocopy skb

stable/6.12 was fixed.

Fixed status
stable/6.12: [72194f65050958e4c8e069adb6c5d89ef81ca197]

CVE-2026-64187: xfs: fail recovery on a committed log item with no regions

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [5105426424ad6981db827cc1ada835a488fab035]
stable/6.1: [226a3c8bea7163c39fe0a1c0ffc7ab7410ef3ba4]
stable/6.6: [d0ae7ec3aa61db5140b107f0a63e017f63e56a96]

CVE-2026-64189: netfilter: ipset: fix race between dump and ip_set_list res=
ize

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [a7a299277959683204d73333c32c092fd69327d4]
stable/5.15: [1bc67c3fc98e9fc07032cc56afcdbc690c47d11e]
stable/6.1: [e8a9976b61f1bc4aa7fd25fa26726dfdf2adf710]
stable/6.6: [96fbafc20ebd9a613736c2998b89c539fe3042f5]

CVE-2026-64192: bpf: Reject BPF_MAP_TYPE_INODE_STORAGE creation if BPF
LSM is uninitialized

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [de984ea883405420fdc416ae8964b752df586970]
stable/6.18: [267fdd9b6530c399dfd996e1a0a7628b45baf9f0]

CVE-2026-64206: Bluetooth: L2CAP: cancel pending_rx_work before taking
conn->lock

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [fc0c3b9cf27cfa2a06f66dae1d08c668fe0a2faa]
stable/5.15: [9901f847a762a5d953871dd95767ce2aed3d684d]
stable/6.1: [4a0bb0fd63fe2b0c62e1072cd1811d6f61e0081c]
stable/6.12: [8de7b386ffad480ca59222b688c94a2da8f0d805]
stable/6.6: [8daaf7f73fe998631a160d1a5a7e1b0b0480eef8]

CVE-2026-64600: xfs: resample the data fork mapping after cycling ILOCK

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [dc11be133efca5fe3a2fb02b016dee825cc12f18]
stable/6.1: [b8c9aa832b52680ee40d6cab0efb081f9a69df05]
stable/6.6: [50f0012da1040f69a4e788cd9aed587c9a04983f]

CVE-2026-63922: ipv6: exthdrs: refresh nh after handling HAO option

stable/5.10 was fixed.

Fixed status
stable/5.10: [b3ac54e5c905f86d22b502eacb5686a282c5659f]

Regards,
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

